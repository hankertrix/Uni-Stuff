#set page(numbering: "1")
#set heading(numbering: "1.1")
#{
    set document(
        title: "MA3005 Control Theory Notes",
        author: "Hankertrix",
    )
    align(center, text(3em)[*#context document.title*])
    align(center, text(2em)[#context document.author.first()])
    outline()
    pagebreak()
}

#import "@preview/fancy-units:0.1.1": qty, unit

// Function definitions
#let mathred(content) = text(fill: red, $#content$)
#let mathblue(content) = text(fill: blue, $#content$)
#let mathgreen(content) = text(fill: green, $#content$)
#let redcancel = math.cancel.with(stroke: red)
#let evaluated(expression, size: 100%) = $lr(#expression|, size: #size)$
#let cimage(..image_args) = align(center, image(..image_args))
#let labelled_equation(content, label) = math.equation(
    block: true,
    numbering: _ => ("(", str(label), ")").join(""),
    content,
)
/**
 * A diagonal box for table headings.
 *
 * 'text_left' is the text that appears on the left (top or bottom).
 * 'text_right' is the text that appears on the right (top or bottom).
 * 'start' controls where the diagonal will start:
 *      `top` will create a line from top left to bottom right
 *      `bottom` will create a line from bottom left to top right.
 *      Defaults to `top`.
 * Additionally, the function accepts all parameters from `table.cell`
 */
#let diagbox(
    text_left,
    text_right,
    cell_type: "table",
    start: "top",
    ..kwargs,
) = {
    let cell
    if cell_type == "table" {
        cell = table.cell
    } else {
        cell = grid.cell
    }

    let content = context {
        let stroke = kwargs.at("stroke", default: 1pt + black)
        let inset = kwargs.at("inset", default: 0% + 5pt)

        let padded_right = pad(text_right, inset)
        let padded_left = pad(text_left, inset)

        let measure_right = measure(padded_right)
        let measure_left = measure(padded_left)

        // Used to account for big differences between text widths
        let width_diff = calc.abs(measure_right.width - measure_left.width)

        let inner_height = (
            measure_right.height + measure_left.height + width_diff / 10
        )
        let inner_width = measure_right.width + measure_left.width

        // Empty box to ensure minimal size
        box(width: inner_width, height: inner_height)

        if start == "bottom" {
            place(bottom + right, padded_right)
            place(top + left, line(
                start: (0%, 100%),
                end: (100%, 0%),
                stroke: stroke,
            ))
            place(top + left, padded_left)
        } else if start == "top" {
            place(top + right, padded_right)
            place(top + left, line(end: (100%, 100%), stroke: stroke))
            place(bottom + left, padded_left)
        } else {
            panic(
                "Unhandled value '"
                    + start
                    + "' for start parameter, expected 'top' or 'bottom'",
            )
        }
    }
    cell(content, ..kwargs, inset: 0pt, breakable: false)
}

#show link: set text(blue)

= Definitions

== Control theory
Control theory deals with the dynamic response of a system to commands or
disturbances.

=== Classical
- Transfer function concept with analysis and design in the Laplace and
    frequency domain.
- More emphasis on physical understanding.

=== Modern
- State variable concept with emphasis on matrix algebra.
- Mathematical technique

=== Types of control systems
- Open-loop (O/L)
    - No feedback
- Closed-loop (C/L)
    - Has feedback
    - Error actuated

== Control system
- A control system is a system in which some *physical quantities* are
    controlled by regulating certain energy inputs.
- A *system* is a group of physical components assembled to perform a specific
    function. The components may be electrical, mechanical, thermal, biomedical,
    chemical, pneumatic or any combination of the above.
- A system need not be limited to an ensemble of physical components. It can
    refer to abstract, dynamic phenomena such as economics (COE) or ecology
    systems.
- A physical quantity may be temperature, pressure, electrical voltage,
    mechanical position, velocity, pH value, liquid level, etc.
- There are many applications of control system including simple devices like
    air-conditioners, microwave, traffic light control to sophisticated systems
    like space vehicles, missile guidance, autopilot, robotic systems, power
    systems, assembly line, chemical processes, quality control, etc.

== Open loop control (O/L)
- The output has no effect on control action. Some examples are traffic lights,
    microwave, oven, dryers, toasters, etc. Requires careful calibration for
    good performance.
- Control variable adjusted to make output equal to input, but not readjusted to
    keep the two equal.
- Open loop control with certain safeguards are very common, such as guiding a
    process through a sequence of predetermined steps.

== Closed loop control (C/L)
- There is an actuating signal, and hence the output depends on the input and
    the current output. Some examples are servo-controlled motor, missile,
    robots, etc.
- To improve performance, the operator adjusts the control variable based on
    observation of the system error, `e`.
- Feedback control system automates this action.
- The error is used to adjust the control variable by means of an actuator.

#pagebreak()

== Control system equation
Consider a static system.

#cimage("./images/static-control-system.png")

- Assume that $G$ and $H$ are static values, then:
    $ e(t) = r(t) - b(t) = r(t) - H c(t) $
    $ c(t) = G e(t) = G r(t) - G H c(t) $
    $ c(t)/r(t) = frac(G, 1 + G H) $
- Compare this to the open loop system where:
    $ c(t)/r(t) = G $
- Let $mathred(M) := c(t)/r(t)$, the relation between $c(t)$ and $r(t)$

=== Effect on stability
- If $G H = - 1$ then $c(t)/r(t) = oo$
- Closed loop control system can become unstable if choices $G, H$ are not
    chosen carefully.
- For the simple case above, the unstable condition of $G H = - 1$ can be
    avoided using an appropriate value of $H$.
- However, in the systems that are being analysed, elements of $G$ and $H$ are
    functions of $s$ (frequency) and proper handling is needed for such systems.
- Essentially, feedback can destabilise a system if it is not carefully
    designed.
- Open loop systems seldom have such problems, due to not having any feedback in
    the first place.

#pagebreak()

=== Effect on parameter sensitivity
- Defining a measure of sensitivity as $S^M_G$, which is the percentage change
    in $M$ with respect to a percentage change in $G$.
    $
        S^M_G = frac((Delta M)/M, (Delta G)/G)
        = frac(Delta M, Delta G) G/M approx.eq frac(partial M, partial G) G/M
    $
- For a closed-loop system:
    $ S^M_G = frac(1, 1 + G H) $
- For an open-loop system:
    $ S^M_G = 1 $
- Implications:
    - Open-loop systems "feel" the changes in $G$ directly.
    - Closed-loop systems can be made to be less sensitive to changes in $G$
        using an appropriately large value of $H$.

=== Effect of input noise.
Another significant advantage of feedback system is in its superior performance
in the presence of disturbance or noise.

#cimage("./images/control-systems-input-noise-effect.png")

- Suppose $H = 0$ and $r = 0$, which is an open loop system with no feedback and
    zero reference, then:
    $ c(t) = G_2 n (t), quad "or" quad c(t)/n(t) = G_2 $
- Suppose $H != 0$ but with $r = 0$, we have:
    $ c(t) = G_2(f(t) + n(t)) = G_2 (-G_1 H c(t) + n(t)) $
    $
        c(t) = G_2/(1 + G_1 G_2 H) n(t),
        quad "or" quad c(t)/n(t) = G_2/(1 + G_1 G_2 H)
    $
- If $H$ or $G_1$ is large, then $1 + G_1 G_2 H$ is large and $c(t)$ due to
    $n(t)$ is small.

#pagebreak()

=== Effect of sensor noise
However, feedback is not effective against sensor noise.

#cimage("./images/control-systems-sensor-noise-effect.png")

- Suppose $H != -$ but with $r = 0$, we have:
    $ c(t) = G_2 G_1 e(t) = - G_2 G_1 H(n(t) + c(t)) $
    $ "Or" quad c(t) = frac(-G_2 G_1 H, 1 + G_2 G_1 H) n(t) $
- If $H$ is large, both numerator and denominator are large, and hence $n(t)$ is
    not attenuated by large $H$.

#pagebreak()

== Feedback control systems

=== Regulator system
A regulator system's function is to maintain a constant output, despite unwanted
disturbances to the system. The input is seldom changed.

- Open loop (O/L) system, which is manually controlled and has no thermostat

    #image("./images/open-loop-regulator-system.png")

- Closed loop (C/L) system, which is automatic and requires a thermostat

    #image("./images/closed-loop-regulator-system.png")

=== Follow-up system
A follow-up system keeps the output in close correspondence with the input,
which is always changing.

#image("./images/follow-up-system.png")

=== Basic element of a control-loop system
#image("./images/basic-elemement-of-a-control-loop-system.png")

== Transfer function
The transfer function of a linear, time-invariant, differential equation system
is defined as the ratio of the Laplace transform of the output to the Laplace
transform of the input, under the assumption that all initial conditions are
zero.

$ G (s) = frac(cal(L) {"Output"}, cal(L) {"Input"}) $

== Plant
- A plant is the combination of process and the actuator.
- A plant is often referred to with a transfer function (commonly in the
    s-domain) which indicates the relation between an input signal and the
    output signal of a system without feedback, commonly determined by the
    physical properties of the system.

== Dynamic analysis
- Dynamic analysis is the determination of a response of a plant to commands,
    disturbances and chances in plant parameters.
- If the dynamic analysis is unsatisfactory, and the plant cannot be modified,
    it is necessary to select control elements needed to improve performance to
    an acceptable level.

== Methods of analysis
+ Consider system performance in the time domain by measuring the output
    response for a given input, like step input, ramp input or sinusoidal input.
+ Analysis in the frequency domain. Output response to sinusoidal input is
    considered in steady state, with transients allowed to subside, before
    measurements are made. It is very common to work in the frequency domain.

== Requirements of control theory
+ Stability.
+ Accuracy, which is specified in terms of errors. Errors can either be:
    - Steady state (s.s.), like due to static friction as the output cases to
        move.
    - Transient, which can reverse the direction or overshoot due to energy
        stored in inertia.
+ Speed of response.

All 3 requirements are incompatible with each other and a good design is a
compromise of all 3 requirements.

- A highly accurate response would not be stable, since it would measure all the
    tiny fluctuations due to noise from the background.
- An extremely fast response time would likely result in inaccurate and unstable
    results, as it is difficult to bring the system to a steady state
    (critically damp the system) in an extremely short amount of time.

#pagebreak()

=== Example
If a system is subjected to a sudden change in input:

- Its transient period should be short, and its response should not be
    excessively oscillatory. In other words, the system should be critically
    damped.
- The steady state error must be small.

Transient response and steady state error characteristics can be improved using
feedback (sensors) and the motivation for feedback.

- Reduce the effect of parameter variation.
- Reduce the effect of noise.
- Improve transient response characteristics.
- Reducing the steady state error.

#stack(
    dir: ltr,
    image("./images/step-response-for-low-gain.png", width: 50%),
    image("./images/step-response-for-high-gain.png", width: 50%),
)

== Stationary or time invariant system
- The parameters of this system do not vary with time.
- The output is independent of time.
- The coefficient of the describing differential equation is constant.

For example:
$ dot.double(y) + 4 x y + 2 x^2 = 3 t med ("non-linear") $

== Linear system
The principle of superposition holds for such a system, which means the inputs
can be added together to obtain the output.

For example:

#cimage("./images/linear-system-example.png", height: 15em)

== Lumped parameter system
- The physical characteristics of this system are assumed to concentrate in one
    or more lumps and thus independent of spatial distribution.
- For example:
    - Bodies are assumed to be rigid and treated as point mass.
    - Springs are regarded as massless and do not change with temperature.
    - Electrical leads are assumed to have no resistance.
- In contrast, when the parameters are distributed, the examples above become:
    - Bodies are elastic.
    - Springs have distributed mass.
    - Electrical leads have distributed resistance.
    - Temperature varies across a border.

== Deterministic system or variable
- A deterministic system or variable's future behaviour is predictable and
    repeatable within reasonable limits.
- Otherwise, system or variable is considered stochastic or random, and analysis
    of it is based on probability theory.

== First order difference equations
A first order difference equation is a recursively defined sequence in the form:
$ y_(n + 1) = f (n, y_n), quad n = 0, 1, 2, dots.h $

== Continuous variable system
#image("./images/continuous-variable-system.png")

- All system variables are a continuous function of time.
- The describing equations are *differential* equations.

== Discrete variable system
#cimage("./images/discrete-variable-system.png", height: 15em)

- A discrete variable system has one or more variables known only at a
    particular instant of time.
- The equations are *difference* equations.
- Such a system is usual for systems that sample data at regular time intervals.

== Ways to classify systems

=== Static or dynamic systems
- Static systems are composed of simple linear gains or non-linear devices and
    are described by algebraic equations.
- Dynamic systems are described by differential or difference equations.

=== Continuous-time or discrete-time systems
Continuous-time dynamic systems are described by differential equations, and
discrete-time dynamic systems are described by difference equations.

=== Linear or non-linear systems
- Linear dynamic systems are described by differential (or difference) equations
    having solutions that are linearly related to their inputs.
- Equations describing non-linear dynamic systems contain one or more non-linear
    terms.

Example:
$ dot.double(x) + 7 dot(x) + 3 x^2 = 3 dot(y) + 3 y $

The equation above has an input in $y$ and an output in $x$. It is non-linear
due to the presence of the $x^2$ term.

=== Lumped or distributed parameters
Lumped-parameter, continuous-time dynamic systems are described by ordinary
differential equations, and distributed parameter, continuous-time dynamic
systems are described by partial differential equations.

Example:
$ frac(partial^2 y, partial t^2) - 10 frac(partial^2 y, partial x^2) = 0 $

The equation above is a distributed parameter system due to the difference
equation above.

=== Time-varying (non-stationary) or time-invariant (stationary) systems
- Time-varying dynamic systems are described by differential (or difference)
    equations having one or more coefficients as functions of time.
- Time-invariant (constant-parameter) dynamic systems are described by
    differential (or difference) equations having only constant coefficients.

Example:
$ dot.double(x) + 5 t dot(x) + 6 x = 5 y $

The equation above has an input in $y$ and an output in $x$. It is a
time-varying system due to the presence of the $t$ term in the output.

=== Deterministic or stochastic systems
Deterministic systems have fixed (non-random) parameters and inputs, and
stochastic systems have randomness in one or more parameters or inputs.

=== Multivariable or single variable systems
Multivariable systems have multiple variables in their input and while single
variable systems only have one variable in their input.

Example:
$ dot.double(x) + 5 dot(x) + 3 x = 2 dot(y) + 3 y + 4 z $

The equation above has inputs in $y$ and $z$ and an output in $x$, hence it is a
multivariable system.

== Dynamic systems
Any dynamic system is the sum of first order dynamic systems.

#pagebreak()

== Heaviside cover-up method (Heaviside theorem)
Heaviside cover-up method is a method to decompose a fraction into partial
fractions.

Using the example of:
$ frac(2 s + 1, s (s - 1) (s + 1)) $

+ Do the first step of regular partial fraction decomposition.
    $
        frac(2 s + 1, s (s - 1) (s + 1))
        = A / s + frac(B, s - 1) + frac(C, s + 1)
    $
+ Pick one of the partial fractions, for example, $frac(C, s + 1)$, and cover up
    its denominator. Equate it to the original fraction and also cover up the
    same term in the original fraction. By covering up the term, set its value
    to 0, and treat the term like it doesn't exist. Using $frac(C, s + 1)$:

    $
        frac(2s + 1, s (s - 1) #rect[$s + 1$]) &= frac(C, #rect[$s + 1$]) \
        //
        frac(2s + 1, s (s - 1) #rect(fill: black)[$s + 1$])
        &= frac(C, #rect(fill: black)[$s + 1$]) \
        //
        evaluated(frac(2s + 1, s (s - 1)))_(s + 1 = 0) &= C \
        evaluated(frac(2s + 1, s (s - 1)))_(s = -1) &= C \
        frac(2(-1) + 1, (-1) (-1 - 1)) &= C \
        frac(-2 + 1, (-1) (-2)) &= C \
        1/2 &= C \
        C &= 1/2
    $

=== Extension to multiple roots
The Heaviside cover-up method can be applied to multiple roots by factoring out
the repeats and applying it to the remaining fraction. For example:

$
    frac(1, (s + 1)^2 (s + 2))
    &= frac(1, s + 1) (frac(1, (s + 1) (s + 2))
    wide ["Apply Heaviside cover-up method"] \
    //
    &= frac(1, s + 1) (frac(1, s + 1) - frac(1, s + 2)) \
    &= frac(1, (s + 1)^2) - frac(1, (s + 1) (s + 2))
    wide ["Apply Heaviside cover-up method"] \
    //
    &= frac(1, (s + 1)^2) - (frac(1, s + 1) - frac(1, s + 2)) \
    &= frac(1, (s + 1)^2) - frac(1, s + 1) + frac(1, s + 2)
$

#pagebreak()

=== Special case for roots of multiplicity 2, like $(s + 1)^2$
The Heaviside cover-up method can be easily used for roots of multiplicity 2 by
multiplying the partial fraction by the denominator of the remaining unknown and
setting the variable to infinity. For example:

$
    frac(1, (s + 1)^2 (s + 2))
    &= frac(A, s + 1) + frac(B, (s + 1)^2) + frac(C, s + 2)
    wide ["Apply Heaviside cover-up method"] \
    //
    &= frac(A, s + 1) - frac(1, (s + 1)^2) + frac(1, s + 2)
$

To find the remaining unknown ($A$), multiply the equation by the denominator of
the remaining unknown ($A$):
$
    frac(1, (s + 1)^2 (s + 2))
    &= frac(A, s + 1) - frac(1, (s + 1)^2) + frac(1, s + 2) \
    //
    frac(1, (s + 1)^2 (s + 2))
    &= (s + 1) (frac(A, s + 1) - frac(1, (s + 1)^2) + frac(1, s + 2)) \
    //
    frac(1, (s + 1) (s + 2))
    &= A - frac(1, (s + 1)) + frac(s + 1, s + 2) \
$

Set $s = oo$:
$
    frac(1, (s + 1) (s + 2))
    &= A - frac(1, (s + 1)) + frac(1, (s + 1) (s + 2)) \
    //
    frac(1, (oo + 1) (oo + 2))
    &= A - frac(1, (oo + 1)) + frac(oo + 1, oo + 2) \
    //
    0 &= A - 0 + 1 \
    A &= -1 \
    therefore quad frac(1, (s + 1) (s + 2))
    &= - frac(1, s + 1) - frac(1, (s + 1)^2) + frac(1, s + 2) \
    //
    therefore quad frac(1, (s + 1) (s + 2))
    &= frac(1, s + 2) - frac(1, s + 1) - frac(1, (s + 1)^2) \
$

#pagebreak()

== SISO
SISO stands for single input, single output.

== MIMO
- MIMO stands for multiple input, multiple output.
- A multiple input, multiple output (MIMO) system is equal to the sum of single
    input, single output systems (SISO), i.e.
    $ "MIMO" = "Sum of SISO" $

== Poles
For a transfer function:
$ G(s) = N(s)/D(s) $

The characteristic equation is:
$ D(s) = 0 $

The poles are defined as all values of $s$ that satisfy the characteristic
equation.

#pagebreak()

= Laplace transform
Let $F (s)$ be the Laplace transform of $f (t)$, written as:
$ cal(L) {f} = F(s) = integral_0^oo e^(- s t) f (t) thin dif t $

The inverse Laplace transform is:
$
    cal(L)^(- 1) {F(s)} = f (t)
    = frac(1, 2 pi j) [integral_(c - j oo)^(c + j oo) F (s) e^(s t) thin dif s]
$

Where:
- $s = sigma + j omega$

Then:
$ cal(L) {frac(d f, d t)} = s F (s) - f (0) $
$ cal(L) {frac(d^2 f, d t^2)} = s^2 F (s) - s f (0) - frac(d f, d t) (0) $
$
    cal(L) {frac(d^n f, d t^n)}
    = s^n F (s) - sum_(i = 1)^n s^(n - 1) frac(d^(i - 1) f, d t^(i - 1))
$

Laplace transform allows a differential equation in the time domain to be
converted to an algebraic equation, which is then solved to obtain the solution
in the Laplace domain, before converting back to the final solution in the time
domain.

== Property 1
$
    mathred(cal(L) [integral_0^t f(x) thin dif x])
    = evaluated(1/s integral_0^t f(x) thin dif x)_(t = 0) + mathred(F(s)/s)
$

== Property 2
$
    mathred(cal(L)[frac(d f(t), d t)])
    = evaluated(f(t) e^(s t))_(t = 0)^(t = oo) + mathred(s F(s))
$

== Property 3
$ cal(L) [f (t)] = F (s) $
$ cal(L) [f (t) e^(- a t)] = F (s + a) $

== Property 4
$ cal(L) [t^n] = frac(n !, s^(n + 1)) $

#pagebreak()

== Shift theorems
- In automatic control systems, it is known as dead time.
- In the process industry, it is known as transport lag.

$ cal(L) {e^(a t) f (t)} = F (s + a) $
$ cal(L) {f (t + a)} = e^(a s) F (s) $

== Convolution theorem
- The convolution theorem is the product of 2 Laplace transforms to form the
    Laplace transform of the convolution integral.
- $tau$ is known as the dummy time variable.

$
    cal(L)^(-1) {X(s) Y(s)} & = integral_0^t x(t - tau) y (t) thin dif tau \
                            & = integral_0^t y(t - tau) x (tau) thin dif tau
$

== Final value theorem
The final value theorem is useful in determining steady state accuracy.
$ lim_(t -> oo) f (t) = lim_(s -> 0) s F (s) $

== Initial value theorem
The initial value theorem is useful in the inverse Laplace transform when the
initial condition is known to be zero.
$ lim_(t -> 0 +) f (t) = lim_(s -> oo) s F (s) $

#pagebreak()

== Laplace transform table
<laplace-transform-table>

#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header(
        [Time function: $f (t) med (0 "for" t < 0)$],
        [Laplace transform: $F (s)$],
    ),

    [A unit impulse], [$1$],

    [A unit step: $"constant" = u (t)$], [$1 / s$],

    [A unit ramp: $t$], [$1 / s^2$],

    [A ramp: $a t$], [$a / s^2$],

    [$frac(a t^n, n !)$], [$a / s^(n + 1)$],

    [Exponential decay: $e^(- a t)$], [$frac(1, s + a)$],

    [Exponential growth: $1 - e^(- a t)$], [$frac(a, s (s + a))$],

    [$t e^(- a t)$], [$frac(1, (s + a)^2)$],

    [$t - frac(1 - e^(- a t), a)$], [$frac(a, s^2 (s + a))$],

    [$e^(- a t) - e^(- b t)$], [$frac(b - a, (s + a) (s + b))$],

    [$(1 - a t) e^(- a t)$], [$frac(s, (s + a)^2)$],

    [$1 - frac(b, b - a) e^(- a t) + frac(a, b - a) e^(- b t)$],

    [$frac(a b, s (s + a) (s + b))$],

    [$frac(e^(- a t), (b - a) (c - a))
    + frac(e^(- b t), (c - a) (a - b))
    + frac(e^(- c t), (a - c) (b - c))$],
    [$frac(1, (s + a) (s + b) (s + c))$],

    [A sine wave: $sin omega t$], [$frac(omega, s^2 + omega^2)$],

    [A cosine wave: $cos omega t$], [$frac(s, s^2 + omega^2)$],

    [$t sin omega t$], [$frac(2 w s, (s^2 + omega^2)^2)$],

    [$t cos omega t$], [$frac(s^2 - omega^2, (s^2 + omega^2)^2)$],

    [A damped sine wave: $e^(- a t) sin omega t$],
    [$frac(omega, (s + a)^2 + omega^2)$],

    [A damped cosine wave: $e^(- a t) cos omega t$],
    [$frac(s + a, (s + a)^2 + omega^2)$],

    [$omega/sqrt(1 - zeta^2) e^(- zeta omega t) sin omega sqrt(1 - zeta^2) t$],
    [$frac(omega^2, s^2 + 2 zeta omega s + omega^2)$],

    [$1 - frac(1, 1 - zeta^2) e^(- zeta omega t)
    sin (omega sqrt(1 - zeta^2) t + phi.alt), cos phi.alt = zeta$],
    [$frac(omega^2, s (s^2 + 2 zeta omega s + omega^2))$],
)]

#pagebreak()

== Inverse Laplace Transform for complex conjugate roots
Given a Laplace transform as a fraction:
$
    Y(s) & = frac(C, [s - (a + j b)][s - (a - j b)](s - r_1)) \
         & = frac(C, (s^2 - 2a s + a^2 + b^2)(s - r_1)) \
         & = frac(K s, s^2 - 2a s + a^2 + b^2) + frac(K_1, s - r_1)
$

Where:

- $C, K$ and $K_1$ are constants
- $(a plus.minus j b)$ are the complex conjugate roots
- $(s - r_1)$ is the remaining root

The general form of the inverse transformation for the above Laplace transform
with complex conjugate roots ($Y (s)$) is:
$
    y (t) = 1 / b lr(|K (a + j b)|) e^(a t) sin (b t + alpha) + K_1 e^(r_1 t)
$

Where:

- $alpha$ is the angle from the polar form of $K (a + j b)$

The response term is just the general form without the $K_1$ term, i.e.
$
    y(t) & = 1/b |K(a + j b)| e^(a t) sin (b t + alpha) \
         & = 1/b e^(a t) |K(a + j b)| (cos alpha sin b t + sin alpha cos b t) \
         & = 1/b e^(a t) (A sin b t + B cos b t)
$

Where:

- $A = |K (a + j b)| cos alpha$
- $B = |K (a + j b)| sin alpha$

#pagebreak()

=== Example
Given:
$ Y (s) = frac(75, (s^2 + 4 s + 13) (s + 6)) $

Since the $(s^2 + 4 s + 13)$ term cannot be factorised into real roots, we make
use of the above general form for complex conjugate roots:
$
    s^2 + 4s + 13 & = [s - (a + j b)][s - (a - j b)] \
    s^2 + 4s + 13 & = s^2 - 2a s + a^2 + b^2 \
$

By comparing the coefficients:
$
                  -2a = 4 quad & "and" quad a^2 + b^2 = 13 \
                             a & = -2 \
                     a^2 + b^2 & = 13 \
                  (-2)^2 + b^2 & = 13 quad because a = -2 \
                             b & = sqrt(13 - 4) \
                             b & = 3 \
    therefore quad a = -2 quad & "and" quad b = 3
$

Evaluating $K s$ using the Heaviside cover-up method:
$
    evaluated(frac(75, (s^2 + 4s + 13)(s + 6)))_(s = a + j b)
    &= evaluated(frac(K s, s^2 + 4s + 13))_(s = a + j b) \
    evaluated(
        frac(
            75, #rect(fill: black)[$(s^2 + 4s + 13)$]
            (s + 6)
        )
    )_(s = a + j b)
    &= evaluated(frac(K s, #rect(fill: black)[$s^2 + 4s + 13$]))_(s = a + j b) \
    evaluated(frac(75, s + 6))_(s = a + j b) &= evaluated(K s)_(s = a + j b) \
    evaluated(frac(75, s + 6))_(s = -2 + 3j) &= evaluated(K s)_(s = -2 + 3j) \
    frac(75, -2 + 3j + 6) &= K (-2 + 3j) \
    frac(75, 4 + 3j) &= K (-2 + 3j) \
    K(-2 + 3j) &= frac(75, 4 + 3j)
$

#pagebreak()

Converting $4 + 3 j$ to polar form:
$
                 |4 + 3j| & = sqrt(4^2 + 3^2) \
                          & = sqrt(25) \
                          & = 5 \
                    alpha & = arctan 3/4 \
                          & approx 36.9 degree \
    therefore quad 4 + 3j & = 5 angle 36.9 degree
$

Hence:
$
    K(-2 + 3j) &= frac(75, 5 angle 36.9 degree) \
    &= 15 angle -36.9 degree quad because 1/i = -i \
    therefore quad |K(-2 + 3j)| &= 15 \
    therefore quad alpha = angle K(-2 + 3j) &= -36.9 degree
$

Now that we have found the solution for the complex conjugate term, we need to
find the value for $r_1$. By comparing the coefficients:
$
    s - r_1 & = s + 6 \
        r_1 & = -6
$

Using the Heaviside cover-up method to find $K_1$:
$
    evaluated(frac(75, (s^2 + 4s + 13) (s + 6)))_(s + 6 = 0)
    &= evaluated(frac(K_1, s + 6))_(s + 6 = 0) \
    //
    evaluated(frac(75, (s^2 + 4s + 13) #rect(fill: black)[$s + 6$]))_{s = -6}
    &= evaluated(frac(K_1, #rect(fill: black)[$s + 6$]))_(s = -6) \
    //
    evaluated(frac(75, s^2 + 4s + 13))_(s = -6)
    &= evaluated(K_1)_(s = -6) \
    frac(75, (-6)^2 + 4(-6) + 13) &= K_1 \
    K_1 &= 75/25 \
    K_1 &= 3
$

#pagebreak()

Hence, the final equation is:
$
    y(t) & = 1/b |K(a + j b)| e^{a t} sin (b t + alpha) + K_1 e^(r_1 t) \
         & = 1/3 dot 15 e^(-2t) sin (3t - 36.9 degree) + 3e^(-6t) \
         & = 5e^(-2t) sin (3t - 36.9 degree) + 3e^(-6t)
$

Using the relationship
$sin (alpha + beta) = sin alpha cos beta + cos alpha sin beta$ in which
$alpha = 3 t$ and $beta = - 36.9 degree$ gives:
$
    y(t) & = 5e^(-2t) sin (3t - 36.9 degree) + 3e^(-6t) \
         & = 5e^(-2t) (sin 3t cos (-36.9 degree)
               + cos 3t sin (-36.9 degree)) + 3e^(-6t) \
         & = 5e^(-2t) (4/5 sin 3t + 3/5 cos 3t) + 3e^(-6t) \
         & = e^(-2t) (4 sin 3t + 3 cos 3t) + 3e^(-6t)
$

Hence, the response term is:
$ e^(- 2 t) (4 sin 3 t + 3 cos 3 t) $

#pagebreak()

=== Alternate method
Alternatively, we can also apply the standard partial fraction decomposition
then evaluate the inverse Laplace Transform for each fraction. Using the same
example:
$ Y (s) = frac(75, (s^2 + 4 s + 13) (s + 6)) $

Applying partial fraction decomposition:
$
    frac(75, (s^2 + 4 s + 13) (s + 6))
    = frac(A, s + 6) + frac(B s + C, s^2 + 4 s + 13)
$

Using the Heaviside cover-up method to find $A$:
$
    evaluated(frac(75, (s^2 + 4s + 13) (s + 6)))_(s + 6 = 0)
    &= evaluated(frac(A, s + 6))_(s + 6 = 0) \
    evaluated(frac(75, (s^2 + 4s + 13) #rect(fill: black)[$s + 6$]))_(s = -6)
    &= evaluated(frac(A, #rect(fill: black)[$s + 6$]))_(s = -6) \
    evaluated(frac{75, s^2 + 4s + 13))_(s = -6) &= evaluated(A)_(s = -6) \
    frac(75, (-6)^2 + 4(-6) + 13) &= A \
    A &= 75/25 \
    A &= 3
$

Completing the square for the $B s + C$ term:
$
    frac(B s + C, s^2 + 4s + 13)
    &= frac(B s + C, s^2 + 4s + (4/2)^2 - (4/2)^2 + 13) \
    &= frac(B s + C, s^2 + 4s + 2^2 - 2^2 + 13) \
    &= frac(B s + C, s^2 + 4s + 2^2 + 9) \
    &= frac(B s + C, (s + 2)^2 + 9) \
    &= frac(B s + C, (s + 2)^2 + 3^2)
$

#pagebreak()

Solving for the values of $B$ and $C$:
$
    frac(75, (s^2 + 4s + 13) (s + 6))
    &= frac(B s + C, (s + 2)^2 + 3^2) + frac(3, s + 6) \
    //
    frac(75, (s^2 + 4s + 13) (s + 6)) - frac(3, s + 6)
    &= frac(B s + C, (s + 2)^2 + 3^2) + frac(3, s + 6) \
    //
    frac(75, (s^2 + 4s + 13) (s + 6))
    - frac(3 (s^2 + 4s + 13), (s^2 + 4s + 13) (s + 6))
    &= frac(B s + C, (s + 2)^2 + 3^2) \
    //
    frac(75 - 3 (s^2 + 4s + 13), (s^2 + 4s + 13) (s + 6))
    &= frac(B s + C, (s + 2)^2 + 3^2) \
    //
    frac(-3s^2 - 12s + 36, (s^2 + 4s + 13) (s + 6))
    &= frac(B s + C, (s + 2)^2 + 3^2) \
    //
    frac(-3s^2 - 12s + 36, (s^2 + 4s + 13) (s + 6))
    &= frac((B s + C) (s + 6), ((s + 2)^2 + 3^2) (s + 6)) \
    //
    frac(3s^2 - 12s + 36, (s^2 + 4s + 13) (s + 6))
    &= frac((B s^2 + 6B s + C s + 6C), ((s + 2)^2 + 3^2) (s + 6)) \
$

By comparing the coefficients:
$
    B = -3 quad & "and" quad 6B + C = -12 \
     6 (-3) + C & = -12 \
              C & = 6
$

Hence:
$
    Y(s) & = frac(75, (s^2 + 4s + 13) (s + 6)) \
         & = frac(3, s + 6) + frac(-3s + 6, (s + 2)^2 + 3^2) \
         & = frac(3, s + 6) + frac(-3s - 6 + 6 + 6, (s + 2)^2 + 3^2) \
         & = frac(3, s + 6) + frac(-3s - 6 + 12, (s + 2)^2 + 3^2) \
         & = frac(3, s + 6) + frac(-3(s + 2) + 4(3), (s + 2)^2 + 3^2) \
         & = frac(3, s + 6) - 3 (frac(s + 2, (s + 2)^2 + 3^2))
           + 4 (frac(3, (s + 2)^2 + 3^2))
$

Using the #link(<laplace-transform-table>)[Laplace transform table]:
$
    y(t) & = 3e^(-6t) - 3e^(-2t) cos 3t + 4e^(-2t) sin 3t \
         & = e^(2t) (4 sin 3t - 3 cos 3t) + 3e^(-6t)
$

#pagebreak()

== Percentage overshoot
The percentage overshoot is given by:
$ "Percentage overshoot" = e^(- frac(pi zeta, sqrt(1 - zeta^2))) $

== Spring mass damper system
#image("./images/spring-mass-damper-system.png")

The inertial force $M dot.double(y)$ is equal to the external forces, i.e.
$ M dot.double(y) = k (x - y) - c dot(y) $
$ therefore M dot.double(y) + c dot(y) + k y = k x $

Applying the Laplace transform on the function:
$
    "Force" & = cal(L) {M dot(y) + c dot(y) + k y} = cal(L) {k x} \
            & = M s^2 Y(s) + s Y(s) + k Y(s) = k X(s)
$

Hence, the transfer function, $frac(Y (s), X (s))$, is:
$
    frac(Y (s), X (s)) = frac(k, M s^2 + c s + k)
    = frac(omega_n^2, s^2 + 2 zeta omega_n^2)
$

Where:

- $k / M = omega_n^2$
- $c / M = 2 zeta omega_n$

== Bounded signal
A bounded signal, $y(t)$ if there exists a finite constant $mu, mu < oo$, such
that:

$ |y(t)| < mu "for all" t gt.eq 0 $

- Examples of bounded signals include $cal(1)(t), sin omega t, e^(-t)$.
- Examples of unbounded signals are $t, t sin omega t, e^t$.

== Bounded-input bounded-output (BIBO) stable
A system is bounded-input bounded-output (BIBO) stable if the output signal is
bounded when the input signal is bounded.

The system $G(s)$ is BIBO stable if and only if all its poles are in the open
left-half $s$-plane, or equivalently, the poles have negative real parts.

#pagebreak()

= Classification of systems

== Forward transference function ($K G (s)$)
<forward-transference-function>
$
    K G(s) & = K frac(
                 K_G (s + a_1) (s + a_2) ... (s^2 + b s + c) ...,
                 s^l (s + d_1) (s + d_2) ... (s^2 + e s + f) ...
             ) \
           & = frac(K sum_(k = 0)^m A_k s^k, s^l sum_{k = 0} B_k s^k),
             quad n >= m + 1
$

Where:

- $n$ is the order of the system, which is the *highest* power of $s$ in the
    *denominator*.
- $n - m$ is the rank of the system, which is the difference between the
    *highest* power of $s$ in the *denominator* and the *numerator*.
- $l$ is the class (or type number) of the system, which is the power of the
    *factor* $s$ in the *denominator*.
- $s^l$ is also known as the *integrator*.
- The *denominator* is also known as the *lag* term.
- The *numerator* is also known as the *lead* term.

=== Example
State the order, rank and type number of the systems with open-loop transfer
function:
$
    G(s) & = frac(s + 2, s^4 + 3s^3 + 3s^2 + s) \
    G(s) & = frac(1, s^3 (s + 2) (s + 1)) \
    G(s) & = frac(s^2 + s + 1, (s + 2) (s^2 + s + 4))
$

+ For $(1)$, the order is 4, the rank is $4 - 1 = 3$, and the type number is $1$
    since the denominator can be written as $s (s^3 + 3 s^2 + 2 s + 1)$.
+ For $(2)$ the order is 5, the rank is $5$ and the type number is $3$ since
    $s^3$ is a factor.
+ For $(3)$, the order is 3, the rank is $1$, and the type number is $0$.

#pagebreak()

== Transfer function of closed-loop systems
The transfer function of a closed-loop system is given by:
$ frac(G (s), 1 + G (s) H (s)) $

Where:

- $G (s)$ is the transfer function of the forward path
- $H (s)$ is the transfer function of the feedback path
- $G (s) H (s)$ is the open-loop transfer function, which is the transfer
    function of a closed-loop system if the feedback path from the feedback
    element is broken.

== Nyquist diagrams (polar plots)
The polar plot of the frequency response of a system is the line traced out as
the frequency is changed from 0 to $oo$ by the tips of the phasers (vectors)
whose length represents the magnitude, like the amplitude gain of the system and
the angle represents their phase $phi.alt$.

#image("./images/nyquist-diagram.png")

When the polar plot of a transfer function touches -1 on the $x$-axis, the
system becomes unstable.

#pagebreak()

=== Example 1
Determine the Nyquist diagram for a first-order system with an open-loop
transfer function of:
$ frac(1, 1 + tau s) $

The frequency response is:
$ s = j omega $
$
    frac(1, 1 + j omega tau)
    = frac(1, 1 + j omega tau) times frac(1 - j omega tau, 1 - j omega tau)
    = frac(1, 1 + omega^2 tau^2) - j frac(omega tau, 1 + omega^2 tau^2)
$

Hence, the magnitude is:
$ "Magnitude" = 1 / sqrt(1 + omega^2 + tau^2) $

And the phase is:
$ "Phase" = - arctan omega tau $

At zero frequency the magnitude is 1 and the phase is $0 degree$. At infinite
frequency the magnitude is zero and the phase is $−90 degree$. When
$omega tau = 1$, the magnitude is $1 / sqrt(2)$ and the phase is $−45 degree$.
Substitution of other values leads to the result shown below, which is the
Nyquist diagram for a first-order system:

#cimage("./images/nyquist-diagram-example.png", height: 15em)
#pagebreak()

=== Example 2
Determine the Nyquist diagram for a system with the open-loop transfer function:
$ G(s) = frac(s + 2, s + 10) $

Substituting $s = j omega$:
$
    G(j omega) & = frac(j omega + 2, j omega (j omega + 10))
                 dot frac(-j omega + 10, -j omega + 10) \
               & = frac(
                     omega^2 + 20 + j(10 omega - 2 omega),
                     j omega (omega^2 + 100)
                 )
                 wide ("Rationalising the denominator") \
               & = frac(8 omega - j(omega^2 + 20), omega (omega^2 + 100))
$

Hence, the polar coordinates are:

$
    |G(j omega) | = frac(
        sqrt((omega^2 + 20^2)^2 + 64 omega^2),
        omega (omega^2 + 100)
    )
$

$
    angle G(j omega) = arctan omega/2 - 90 degree - arctan omega/10
$

And the Cartesian coordinates are:

$ "Real"(G(j omega)) = 8/(w^2 + 100) $
$ "Im"(G(j omega)) = -frac(omega^2 + 20, omega (omega^2 + 100)) $

=== Nyquist diagram analysis
#cimage("./images/nyquist-diagram-analysis.png")

#pagebreak()

== System types

=== System type 0
Systems of type 0 have no *integrator* term or $s^l$ term in the denominator of
the #link(<forward-transference-function>)[transfer function].

General forms:

#enum(
    numbering: "a)",
    $ G(s) = 1 / (1 + s T) $,
    $ G(s) = 1 / (1 + b s + a s^2) $,
    $ G(s) = frac(1, (1 + s T) (1 + b s + a s^2)) $,
    $ G(s) = frac(1 + s T, a + b s + a s^2) $,
)

Nyquist diagram of the functions above:
#stack(
    dir: ltr,
    cimage("./images/system-type-0-nyquist-diagram-1.png", width: 50%),
    cimage("./images/system-type-0-nyquist-diagram-2.png", width: 50%),
)
#pagebreak()

=== System type 1
Systems of type 1 have an *integrator* term of the power 1, or $s^1$ as the
$s^l$ term in the denominator of the #link(
    <forward-transference-function>,
)[transfer function].

General forms:

#enum(
    numbering: "a)",
    start: 5,
    $ G(s) = frac(1, s (1 + s T)) $,
    $ G(s) = frac(1, s(1 + b s + a s^2)) $,
)

#cimage("./images/system-type-1-nyquist-diagram.png", height: 50em)

=== System type 2
Systems of type 2 have an *integrator* term of the power 2, or $s^2$ as the
$s^l$ term in the denominator of the #link(
    <forward-transference-function>,
)[transfer function].

General form:

#enum(
    numbering: "a)",
    start: 7,
    $ G(s) = frac(1, s^2 (1 + s T)) $,
)

#cimage("./images/system-type-2-nyquist-diagram.png", height: 35em)

=== Nyquist diagram for systems type 1 and type 2
#cimage("./images/system-type-1-and-2-nyquist-diagram.png", height: 15em)

== Examples of finding the magnitude and phase of an output

=== Example 1
Determine the magnitude and phase of the output from a system when subject to a
sinuisoidal input of $2 sin 3t$ if it has a transfer function of:
$ G(s) = 2/(s + 1) $

The frequency response function is obtained by replacing $s$ with $j omega$:
$ G(j omega) = 2 / (j omega + 1) $

Multiplying the topand bottom of the equation by $(-j omega + 1)$ gives:

$
    G(j omega) & = 2 / (j omega+ 1) times frac(- j omega + 1, - j omega + 1) \
               & = frac(- 2 j omega + 2, omega^2 + 1) \
               & = frac(2, omega^2 + 1) - j frac(2 omega, omega^2 + 1)
$

The magnitude of $a + j b$ is $sqrt(a^2 + b^2)$, and hence for $G(j omega)$:
$
    |G(j omega)| & = sqrt(
                       2^2/(omega^2 + 1)^2
                       + frac(2^2 omega^2, (omega^2 + 1)^2)
                   ) \
                 & = 4/sqrt(omega^2 + 1)
$

And the phase angle is given by:
$ tan phi.alt = - omega $

For the specified input, we have $omega = #qty[3][rad s^-1]$. The magnitude is
thus:

$ |G(j omega)| = 2/sqrt(omega^2 + 1) = 2/sqrt(3^2 + 1) approx 0.63 $

#pagebreak()

== Gain margin
- The gain is the real value of the intersection of the polar plot of a system
    and the real axis or the $x$-axis of the polar plot.
- The intersection point is also known as the phase crossover.
- If $x$ is the gain of a system, then the gain margin of a system is given by
    $1/x$, which is the margin a system has before becoming unstable.
- The gain margin is $20 log 1/x$ in decibels (#unit[dB]).

#cimage("./images/gain-margin.png", height: 15em)

== Phase margin
- On the polar plot of a system, draw a circle of radius 1 from the origin.
- The intersection of the polar plot of the system and this circle is known as
    gain crossover.
- Draw a straight line to the origin from this intersection point, and the acute
    angle between the drawn straight line and the real axis or $x$-axis is
    called the phase margin.
- The obtuse angle is known as the phase angle.

#cimage("./images/phase-margin.png", height: 20em)
#pagebreak()

== Example of determining gain and phase margins
Determine the gain margin and the phase marign for a system that gave the
following open-loop experimental frequency response data:
- At frequency #qty[0.005][Hz], a gain of 1.00 and phase -120#sym.degree.
- At frequency #qty[0.010][Hz], a gain of 0.45 and phase -180#sym.degree.

The phase crossover occurs at #qty[0.010][Hz], and the gain at that point is
1.00, so the gain margin is:
$ 1/x = 1/0.45 = 2.22 $

The phase margin is the number of degrees by which the phase angle is smaller
than -180#sym.degree at the gain crossover. The gain cross over is the frequency
at which the open-loop gain first reaches the value 1 and so is #qty[0.005][Hz].
Thus, the phase margin is:
$ 180 degree - 120 degree = 60 degree $

== Criterion for stable systems
- A good stable control system usually has an open-loop gain significantly less
    than 1, typically about 0.4-0.5, when the phase shift is -180#sym.degree and
    an open-loop phase shift of between -115#sym.degree and 125#sym.degree when
    the gain is 1.
- Such values give a slightly under-damped system which gives about 20-30%
    overshoot.

#pagebreak()

= Block diagrams

== General rules
+ Multiplication
    #cimage("./images/block-diagram-multiplication.png")
+ Summation
    #cimage("./images/block-diagram-summation.png")
+ Pre-multiplication converted into post-multiplication
    #cimage("./images/block-diagram-pre-to-post-multiplication.png")

#pagebreak()
#enum(
    start: 4,
    [
        Post-multiplication converted into pre-multiplication
        #cimage("./images/block-diagram-post-to-pre-multiplication.png")
    ],
    [
        Closed-loop
        #cimage("./images/block-diagram-closed-loop.png", height: 15em)
        To derive the closed-loop transfer function, we go along the signal path
        and follow the rules defined above.
        $ (R - C H)G = C $
        $ R G - C H G = C $
        $ R G = C (1 + H G) $
        $ C/R = G/(1 + G H) $

        Where:
        - $G$ is the direct or forward transfer function
        - $H$ is the feedback transfer function
        - $G H$ is the loop transfer function or open-loop transfer function
        - $C/R$ is the closed-loop transfer function
        - $E/R = 1/(1 + G H)$ is the actuating signal ratio
    ],
)

#pagebreak()

=== Example 1
Establish the relationship between $Y(s)$ and $X(s)$:
#cimage("./images/block-diagram-example-1.png", height: 10em)

$ Y = A X + B X + C X $
$ Y = (A + B + C) X $
$ Y/X = A + B + C $

#cimage("./images/block-diagram-example-1-answer.png", height: 5em)
#pagebreak()

=== Example 2
Simplify the system and find $C/R$:
#stack(
    dir: ltr,
    cimage("./images/block-diagram-example-2-1.png", width: 50%),
    cimage("./images/block-diagram-example-2-2.png", width: 50%),
)
#cimage("./images/block-diagram-example-2-3.png", height: 18em)
#pagebreak()

=== Example 3
Simplify the system and find $C/R$:
#stack(
    dir: ltr,
    cimage("./images/block-diagram-example-3-1.png", width: 50%),
    cimage("./images/block-diagram-example-3-2.png", width: 50%),
)
#stack(
    dir: ltr,
    cimage("./images/block-diagram-example-3-3.png", width: 50%),
    cimage("./images/block-diagram-example-3-4.png", width: 50%),
)
#cimage("./images/block-diagram-example-3-5.png", height: 20em)
#pagebreak()

== Feedback types

=== Unity feedback
A system has unity feedback if there is no feedback transfer function, which
means whatever is the output is exactly what the controller receives.

#cimage("./images/unity-feedback-system.png", width: 70%)

$ C(s) = G(s) dot E(s) $
$ E(s) = R(s) dot C(s) $
$ therefore C(s) = G(s) [R(s) - C(s)] $

=== Non-unity feedback
A system has non-unity feedback if there is a feedback transfer function, which
usually means the is output has been amplified or diminished.

#cimage("./images/non-unity-feedback-system.png", width: 70%)

$ E(s) = R(s) - B(s) $
$ B(s) = C(s) H(s) $
$ C(s) = G(s) E(s) $
$ therefore "Closed loop transfer function" = frac(G(s), 1 + G(s) H(s)) $

=== Example 1
A negative feedback system has a forward path gain of 12 and a feedback path
gain of 0.1. What is the overall gain of the system?

Using the non-unity feedback equation:
$ "System gain" = G/(1 + G H) = 12 / (1 + 0.1 times 12) = 5.45 $

The overall gain is 5.45.

=== Example 2
#cimage("./images/feedback-example-2.png")

$ G(s) = 10/(S + 10) dot 20/S = frac(200, S(S + 10)) $
$
    "Open-loop transfer function (OLTF):" quad
    G H(s) = frac(200, S(S + 10)) dot 2 = frac(400, S(S + 10))
$

$
    "Closed-loop transfer function (CLTF):" quad
    C/R (S) = frac(G(s), 1 + "OLTF") = frac(200, S^2 + 10S + 400)
$

The characteristic equation is:
$ S^2 + 10S + 400 = 0 $

Reduced system:
#cimage("./images/feedback-example-2-answer.png")

= Mason's gain formula
$ C(S)/R(S) = sum_(k = 1)^n frac(T_k Delta_k, Delta) $

Where:
- $n$ is the number of forward paths
- $T_k$ is the gain (transmittance) of the $k^"th"$ forward path
- $Delta_k$ is the associated path factor
- $Delta$ is the determinant of the signal flow graph

== Obtaining the determinant of the signal flow graph ($Delta$)
$
    Delta & = "Determinant of the signal flow graph" \
          & = 1 - ["Sum of gains of all the individual loops"] \
          & quad + ["Sum of the gain products of two non-touching loops"] \
          & quad - ["Sum of the gain products of three non-touching loops"] \
          & quad + ["Sum of the gain products of four non-touching loops"] \
          & quad + ...
$

== Obtaining the associated path factor ($Delta_k$)
$
    Delta_k =
    #text[The part of #sym.Delta *not touching* the $k^"th"$ forward path]
$

== Example 1
The block diagram and corresponding signal flow graph for a more complex system
is shown below. There are two forward paths from input $R(s)$ to output $C(s)$:
$ T_1 = G_1 G_2 G_3 G_5 wide T_2 = G_4 G_5 $

#cimage("./images/masons-gain-formula-example-1.png", height: 15em)

Simplifying the diagram:
#cimage(
    "./images/masons-gain-formula-example-1-simpler-diagram.png",
    height: 15em,
)

The gains for the three loops in the system are:
$ L_1 = - G_1 G_2 G_3 G_5 H_1 wide L_2 = -G_2 H_2 wide L_3 = -G_4 G_5 H_1 $

Because $L_2$ and $L_3$ are non-touching loops,
$
    Delta &= 1 - (L_1 + L_2 + L_3) + L_2 L_3
    &= 1 + (G_1 G_2 G_3 G_5 H_1 + G_2 H_2 + G_4 G_5 H_1) + G_2 G_4 G_5 H_1 H_2
$

Because all three loops touch path $T_1$, setting $L_1 = L_2 = L_3$ in the above
expression for #sym.Delta gives $Delta_1 = 1$. Because loops $L_1$ and $L_2$
touch path $T_2$, setting $L_1 = L_3 = 0$ in the expression for #sym.Delta gives
$Delta_2 = 1 - L_2 = 1 + G_2 H_2$. Substitution of these results into Mason's
gain formula yields:
$
    C(s)/R(s) & = frac(T_1 Delta_1 + T_2 Delta_2, Delta) \
              & = frac(
                    G_1 G_2 G_3 G_5 + (G_4 G_5)(1 + G_2 H_2),
                    1 + (G_1 G_2 G_3 + G_4 + G_2 G_4 H_2) G_5 H_1 + G_2 H_2
                )
$

== Example 2
#cimage("./images/masons-gain-formula-example-2.png")

- There is only one forward path from $R(s)$ to $C(s)$.
- 3 loops:
    $ L_1 = -G_3 H_3 wide L_2 = - G_2 G_3 H_2 wide L_3 = - G_1 G_2 G_3 H_1 $
- All loops are touching each other, hence:
    $ T_1 = G_1 G_2 G_3 G_4 $
    $
        Delta & = 1 - ( - G_3 H_3 - G_2 G_3 H_2 - G_1 G_2 G_3 H_1) \
              & = 1 + G_3 H_3 + G_2 G_3 H_2 + G_1 G_2 G_3 H_1
    $
- Hence:
    $
        G(s) = T_1/Delta = frac(
            G_1 G_2 G_3 G_4,
            1 + G_3 H_3 + G_2 G_3 H_2 + G_1 G_2 G_3 H_1
        )
    $

#pagebreak()

== Example 3
#cimage("./images/masons-gain-formula-example-3.png")

There are two forward paths from $R(s)$ to $C(s)$, and:
$ T_1 = G_1 G_2 G_3 $
$ T_2 = G_4 G_3 $

There are 3 loops:
$ L_1 = - G_2 H_2 wide L_2 = - G_1 G_2 G_3 H_1 wide L_3 = - G_4 G_3 H_1 $

$L_1$ and $L_3$ are non-touching loops, so this gives us:
$ Delta = 1 + (G_1 H_2 + G_1 G_2 G_3 H_1 + G_4 + G_3 H_1) $
$ Delta_1 = 1 $
$ Delta_2 = 1 + G_2 H_2 $

Hence:
$
    C(s)/R(s) = frac(
        G_1 G_2 G_3 + G_4 G_3 (1 + G_2 H_2),
        1 + G_2 H_2 + G_1 G_2 G_3 H_1 + G_4 G_3 H_1 + G_2 H_2 G_4 G_3 H_1
    )
$

#pagebreak()

= Mathematical modelling
- Mathematical modelling is the first stage of any study, as mathematical
    modelling is needed to gain a good understanding of the system under
    investigation, like its purpose, specifications, main components, and its
    input and output.
- The simplicity of the model is an important consideration. Simplicity is
    necessary to also make changes in the mathematical model as convenient as
    possible.
- Simplicity is achieved by making assumptions about the system. It requires
    knowledge and understanding of the behaviour of the system to be controlled.
- Write the relevant equation of motion for the system.
    + Newton's Law for mechanical motion.
    + Kirchhoff's Law for electrical circuits.
    + Mass and heat balance for chemical systems.
- In control engineering, these equations of motions, also called the
    mathematical model of a system, are usually set in differential equations.
- The mathematical model represents an approximation to the actual dynamics and
    steady state behaviour of the system.

== Fundamental steps to model the actual system
+ Conceptual model is first specified, the building block of the models are
    idealisation of events or phenomena occurring in real system being modelled
    blocks, like mass, viscous damping, spring stiffness, electrical resistance,
    capacitance, inductance, etc.
+ Relationship in the model expressed mathematically by appropriate physical
    laws to each building blocks and obtain necessary equation of motion.
+ Dynamic behaviour is obtained by solving model behaviour compared to actual or
    predicted system behaviour and adjustments are made if necessary to aid
    control system design.

== When is a mathematical model useful?
+ When the system or the controller for the system doesn't exist at all, such as
    an automatic tracking system for satellites. The idea can be conveniently
    and cheaply designed and tested using the mathematical model rather than
    working with the actual system.
+ When the system is in complete operation, but does not work according to the
    specification. An example is the control of the water level in the boiler
    drum in a power station being unstable.

#pagebreak()

== Transfer function (T.F.)
#cimage("./images/transfer-function-mathematical-modelling.png")
- If the input-output relationship of linear system is known, the
    characteristics of the system itself are also known.
- The input-output relationship in the Laplace domain is called the transfer
    function (T.F.)
    $ "System" -> T.F. (s) = "Output"(s)/"Input" = C(s)/R(s) $
- Usually, we assume that the component is linear and stationary, with zero
    initial conditions.
- For a physical system:
    $ T.F.(s) = N(s)/D(s) $
    Usually $N(s)$ will be of a lower order than $D(s)$ as nature integrates
    rather than differentiates.

    Where:
    - $D(s)$ is the characteristic function.
        - It contains all the physical characteristics of the system.
        - If $D(s) = 0$, then it is known as the characteristic equation.
        - The roots of the characteristic equation determine the stability of
            the system and the general nature of the transient response to any
            input.
    - $N(s)$ is a function of how the input enters the system.
        - It does not affect the absolute stability of the system, or the nature
            of transient modes of the system.
        - It determines the magnitude and sign of each transient mode and thus
            establishes the shape of the transient response as well as the value
            of the steady state output value.

=== Ways to obtain transfer functions
+ Mathematical, which is to take the Laplace transform of differential equations
    of a system and solving for the transfer function with zero initial
    conditions.
+ Experimental, which is to apply known inputs like sine waves and step
    functions to systems and measure the output values to construct the transfer
    function.

A transfer function with a similar frequency can be obtained by replacing $s$ in
the transfer function with $j omega$.

#pagebreak()

== Modelling a spring mass damper system

=== Example 1
#image("./images/mathematical-modelling-of-spring-system-1.png", height: 10em)
- $x$ is the input in the system.
- Let the point above the label $y$ be $P$.
- The spring pushes on the point $P$ from the left with a force $k(x - y)$.
- The damper pushes on the point $P$ from the right with a force $c dot(y)$.
- At equilibrium, these forces cancel out and equate to 0.
- Hence, the system equation is:
    $ k(x - y) = c dot(y) $
    $ k(x - y) - c dot(y) = 0 $
    $ k x = c dot(y) + k y $
- Taking the Laplace transform of the system:
    $ Y(s)/X(s) = frac(k, C s + k) $

#pagebreak()

=== Example 2
#image("./images/mathematical-modelling-of-spring-system-2.png", height: 10em)
- $x$ is the input in the system.
- Let the point above the label $y$ be $P$.
- The damper pushes on the point $P$ from the left with a force
    $c(dot(x) - dot(y))$.
- The spring pushes on the point $P$ from the right with a force $k y$.
- At equilibrium, these forces cancel out and equate to 0.
- Hence, the system equation is:
    $ c(dot(x) - dot(y)) - k y = 0 $
    $ c(dot(x) - dot(y)) = k y $
    $ c dot(x) = k y + dot(y) $
- Taking the Laplace transform of the system:
    $ Y(s)/X(s) = frac(C s, C s + k) $

=== Example 3
#image("./images/mathematical-modelling-of-spring-system-3.png", height: 10em)
- $f$ is the input in the system.
- Let the point below the label $y$ be $P$.
- The spring pushes on the point $P$ from the right with a force $k y$.
- The damper pushes on the point $P$ from the right with a force $k dot(y)$.
- At equilibrium, these forces cancel out and equate to 0.
- Hence, the system equation is:
    $ f - k y - c dot(y) = 0 $
    $ f = k y + c dot(y) $
- Taking the Laplace transform of the system:
    $ Y(s)/F(s) = frac(1, C s + k) $

=== Example 4
#cimage("./images/mathematical-modelling-of-spring-system-4.png", height: 10em)
$ "Inertial forces" = "External forces" $
$ M frac(d^2 y, d t^2) = sum F_s $
$ sum F_s = k y $
$ M frac(dif^2 y, dif^2 t) = - k y $
$ M frac(dif^2 y, dif^2 t) + k y = 0 $
$ M dot.double(y) + k y = 0 $

=== Example 5
#cimage("./images/mathematical-modelling-of-spring-system-5.png", height: 14em)
$ "Net force" = F - k y - c frac(dif y, dif t) $

Then, applying Newton's second law, this force must be equal to $m a$, where $a$
is the acceleration, and so:
$ m frac(dif^2 y, dif t^2) = F - k y - c frac(dif y, dif t) $

The relationship between the input $F$ to the system and the output $y$ is thus
described by the second-order differential equation:
$ m frac(dif^2 y, dif t^2) + c frac(dif y, dif t) + k y = F $

The term _second-order_ is used because the equation includes
$frac(dif^2 y, dif t^2)$ as its highest derivative.

=== Example 6
#cimage("./images/mathematical-modelling-of-spring-system-6.png", height: 10em)
$ m dot.double(y) = k(x - y) - c dot(y) $
$ m dot.double(y) + c dot(y) + k y = k x $
$ M s^2 Y(s) + C s Y(s) + K Y(s) = K X(s) = "Force" $
$
    therefore "TF" Y(s)/X(s)
    &= frac(K, M s^2 + C s + k) \
    &= frac(omega_n^2, s^2 + 2 zeta omega_n s + omega_n^2)
$

Where:
- $k/m = omega_n^2$
- $c/m = 2 zeta omega_n$

#pagebreak()

=== Example 7
#cimage("./images/mathematical-modelling-of-spring-system-7.png")
$ "Inertial forces" = "External forces" $
$
    sum T & = I alpha \
          & = I dot.double(theta)_0 \
          & = G( theta_i - theta_0) - b dot(theta)_0 \
$
$ "Torque" = I dot.double(theta)_0 + b dot(theta)_0 + G theta_0 = G theta_i $
$ I s^2 theta_0 (s) + b s theta_0 (s) + G theta_0 (s) = G theta_i (s) $
$
    therefore "TF:" frac(theta_0 (s), theta_i (s))
    &= frac(G, I s^2 + b s + G) \
    &= frac(omega_n^2, s^2 + 2 zeta omega_n^2 + omega_n^2)
$

Where:
- $G/I = omega_n^2$
- $b/I = 2 zeta omega_n$

#pagebreak()

=== Example 8
For the mechanical system shown below, draw a free body diagram, assuming
$y < x$. Determine the transfer function ($Y/X$) between the input displacement,
$x$ and the output displacement $y$.
#cimage("./images/mathematical-modelling-of-spring-system-8.png", height: 15em)

$ k(x - y) + C(dot(x) - dot(y)) = M dot.double(y) $
$ M dot.double(y) + c dot(y) + k y = k x + c dot(x) $

Applying the Laplace transform:
$ Y(s) [M s^2 + C s + K] = X(s) [K + C s] $
$ Y(s)/C(s) = frac(k + C s, M s^2 + C s + K) $

== Typical transfer functions

=== Proportional block
#cimage("./images/proportional-block.png")
$ e_0/V = x/L $

The transfer function is constant, like the transducer used as a displacement.

#pagebreak()

=== Time constant block
#cimage("./images/time-constant-block.png")

The transfer function contains a time constant (1#super[st] order system).
$ I omega + b omega = T $
$ "Let" I/b = tau $
$ tau s Omega (s) + Omega (s) = T(s)/b $
$ frac(Omega (s), T(s)) = frac(1/b, 1 + tau s) $

=== Integrating block
#cimage("./images/integrating-block.png", height: 15em)

There is a constant input that produces an output that is a constant rate of
change with respect to time.

$ "Response of cylinder:" Q = A dot(y) $
$ therefore Y(s)/Q(s) = frac(1, A s) $

== System types

=== Spring mass damper system
#cimage("./images/spring-mass-damper-system.png")
$ "Inertial forces" = "External forces" $
$ m dot.double(y) = k(x - y) - c dot(y) $
$ m dot.double(y) + c dot(y) = k x $

=== Torsional system
#cimage("./images/torsional-system.png")
$ "Inertial forces" = "External forces" $
$ sum T = I alpha $
$ I alpha = I dot.double(theta)_0 = G(theta_i - theta_0) - b dot(theta)_0 $
$ therefore I dot.double(theta)_0 + b dot(theta)_0 + G theta_0 = G theta_i $

#pagebreak()

=== System with gearing
#cimage("./images/system-with-gearing.png")
$
    n & = "Speed of the driving shaft"/"Speed of the driven shaft" \
      & = omega_1/omega_2 \
$

$ "Equating kinetic energy:" 1/2 I omega_2^2 = 1/2 I e omega_1^2 $
$ therefore I e = frac(I omega_2^2, omega_1^2) = I/n^2 $

=== Gear driven spring system
#cimage("./images/gear-driven-spring-system.png")
$
    "Equating potential energy:" 1/2 G theta_2^2 = 1/2 G theta_1^2,
    quad n = theta_1/theta_2
$
$ G_e = frac(G theta_2^2, theta_1^2) = G/n^2 $

==== Reflecting from gear 2 to gear 1
#cimage("./images/reflecting-from-gear-2-to-gear-1.png", height: 14em)

$ "Inertia:" (N_1/N_2)^2 J_2 $
$ "Viscous friction:" (N_1/N_2)^2 B_2 $
$ "Torque:" (N_1/N_2) T_2 $
$ "Angular displacement:" (N_2/N_1) theta_2 $
$ "Angular velocity:" (N_2/N_1) omega_2 $

=== Gear driven with dashpot system
#cimage("./images/gear-driven-with-dashpot-system.png")

$ T = omega b $
$ P = b omega^2 $
$ n = omega_1/omega_2 $
$ "Power" = omega T $
$ therefore b omega_2^2 = b_e omega_1^2 $
$ b_e = b/n^2 $

=== Geared system
#cimage("./images/geared-system.png")

$ I_3 = I_1 + I_2/n^2 $
$ G_e = G/n^2 $
$ I_e = I/n^2 $
$ b_e = b/n^2 $
$ n = "Speed of the driving shaft"/"Speed of the driven shaft" $

=== Electrical systems
+ Resistance
    #cimage("./images/electrical-systems-resistance.png", height: 5em)
    $ V = i R $
    $ V = I Z, quad Z = R $
+ Capacitance
    #cimage("./images/electrical-systems-capacitance.png", height: 5em)
    $ i = C V $
    $ V = I Z, quad Z = 1/(C S) $
+ Inductance
    #cimage("./images/electrical-systems-inductance.png", height: 5em)
    $ V = L i, quad V = I Z, quad Z = L S $

==== Loop method
Voltage equation: The sum of the voltage drop across a closed loop is 0.

$ V = i R + 1/C integral i thin dif t + L i $

Since $q = integral i thin dif t$, $q$ = charge:
$ therefore V = R frac(dif q, dif t) + q/c + L frac(dif^2 q, dif t^2) $

==== Node method
Current equation: The sum of currents at a circuit node or junction is 0.
$ i = V/R + C dot(V) + 1/L integral V thin dif t $

Since $V = frac(dif Phi, dif t)$, where #sym.Phi is magnetic flux:
$ therefore i = frac(dif Phi, dif t) + C frac(dif^2 Phi, dif t^2) + 1/L Phi $

==== Common electrical circuits
Simple lag circuit:
#cimage("./images/electrical-systems-simple-lag-circuit.png", height: 10em)

$ E_i = I Z = I (Z_r + Z_e), quad Z_r = R, quad Z_c = 1/(C s) $
$
    E_t = I(R + 1/(C s)), quad E_0 = I 1/(C s), quad
    therefore frac(E_0, E_i) = frac(1, R C s + 1)
$

Transient lead circuit:
#cimage("./images/electrical-systems-transient-lead-circuit.png", height: 10em)
$
    E_i = I(R + 1/(C s)), quad E_0 = I R,
    quad therefore E_0/E_i = frac(R C s, R C s + 1)
$

==== Electromechanical analogy
#align(center)[#table(
    align: left,
    columns: 3,
    table.header([*Force*], [*Voltage*], [*Current*]),

    [$M$ - Mass], [$L$ - Inductance], [$C$ - Capacitance],
    [$c$ - Viscous friction], [$R$ - Resistance], [$$ - Conductance],
    [$K$ - Stiffness], [$1/C "-" 1/"Capacitance"$], [$1/L "-" 1/"Inductance"$],
    [$x$ - Displacement], [$q$ - Charge], [$Phi$ - Magnetic flux],
    [$f$ - Force], [$v$ - Potential difference], [$i$ - Current],
    [$V$ - Velocity], [$i$ - current], [$v$ - Potential difference],
)]

=== Gear trains
Distance work done:
$ r_1 N_2 = r_2 N_1 $

Distance:
$ theta_1 r_1 = theta_2 r_2 $

Work done:
$ T_1 theta_1 = T_2 theta_2 $

$
    therefore T_1/T_2 = theta_2/theta_1
    = N_1/N_2 = omega_2/omega_1 = r_1/r_2 = 1/n
$

Where:
- $N$ is the number of teeth
- $r$ is the radius of the gear
- $n$ is the gear ratio

#pagebreak()

== Position control system
#align(center)[Physical system:]
#cimage("./images/position-control-system-physical-system.png")

#align(center)[Block diagram:]
#cimage("./images/position-control-system-block-diagram.png")

== Mechanical systems
Find $X/Y$.

#cimage("./images/mechanical-systems-diagram.png")

General steps:
+ Separate the springs, dampers and mass.
+ Analyse forces on springs and dampers.
+ Use free-body diagrams to write down the equation of motion.
+ Laplace transform.

#pagebreak()

=== Steps 1-2
+ Separate the springs, dampers and mass.
+ Analyse forces on springs and dampers.

#cimage("./images/mechanical-systems-steps-1-2.png")

=== Steps 3-4 (Mass 1)
3. Use free-body diagrams to write down the equation of motion.

#cimage("./images/mechanical-systems-steps-3-4-mass-1.png")

Using $f = m a$ on $M_1$:
$ K_2 (x - z) - K_1 z - B_1 dot(z) = M_1 dot.double(z) $
$ K_2 x = M_1 dot.double(z) + B_1 dot(z) + (K_1 + K_2) z $

4. Laplace transform:
$ K_2 X = M_1 s^2 Z + B_1 s Z + (K_1 + K_2) Z $
$ K_2 X = (M_1 s^2 + B_1 s + (K_1 + K_2)) Z $

#labelled_equation($Z = K_2 / (M_1 s^2 + B_1 s + (K_1 + K_2)) X$, 1)

#pagebreak()

=== Steps 3-4 (Mass 2)
3. Use free-body diagrams to write down the equation of motion.

#cimage("./images/mechanical-systems-steps-3-4-mass-2.png")

Using $f = m a$ on $M_2$:
$ - K_2 (x - z) - B_2 dot(x) - K_0 (x - y) = M_2 dot.double(x) $
$ K_2 z + K_1 y = M_2 dot.double(x) + B_2 dot(x) + (K_0 + K_2) x $

4. Laplace transform:
$ K_2 Z + K_0 Y = M_2 s^2 X + B_2 s X + (K_0 + K_2) X $

#labelled_equation($K_2 Z + K_0 Y = (M_2 s^2 + B_2 s + (K_0 + K_2)) X$, "2")

=== Steps 3-4 (Solving $X/Y$)
3. Use free-body diagrams to write down the equation of motion.
4. Laplace transform.

#cimage("./images/mechanical-systems-steps-3-4-solving-x-y.png")

$
    K_2 K_2/(M_1 s^2 + B_1 s + K_1 + K_2) X + K_0 Y
    = M_2 s^2 + B_2 s + (K_0 + K_2) X
$
$ K_0 Y = (M_2 s^2 + B_2 s + K_0 + K_2 - K_2^2/(M_1s^2 + B_1 s + K_1 + K_2)) $
$
    X/Y = K_0/(M_2 s^2 + B_2 s + K_0 + K_2
    - K_2^2/(M_1 s^2 + B_1 s + K_1 + K_2))
    = G(s)
$

== Linear and rotary systems
#cimage("./images/linear-and-rotary-systems.png")
#pagebreak()

=== Example
Write the differential equations and obtain the transfer function
$frac(theta_o (s), theta_i (s))$ for the drive system shown below. In the
diagram, the springs represent long shafts and damping effects due to bearings
and shaft couplings are present.

#cimage("./images/linear-and-rotary-systems-example.png", height: 8em)

Solution:

Equations are written in order, starting at the input. To help visualise signs,
assume that $theta_i > theta_2, dot(theta)_2 > dot(theta_3)$, and
$theta_3 > theta_o$. The shaft torsion torque $k_1(theta_i - theta_2)$
transmitted through the damper $c_1$ and spring $k_2$ accelerates inertia $J$
and supplies the damping torque.

#labelled_equation(
    $
        T_i = k_1 (theta_i - theta_2) = c_1 (dot(theta)_2 - dot(theta)_3)
        = k_2 (theta_3 - theta_o)
    $,
    1,
)

#cimage(
    "./images/linear-and-rotary-systems-example-free-body-diagram.png",
    height: 10em,
)

From the free body diagram, the summation of torque at the inertia element $J$
is:
#labelled_equation($T_i - c_2 dot(theta)_o = J dot.double(theta)_o$, 2)

Applying the Laplace transform to both sides of equation $(2)$ and re-arranging:
$ k_2 Theta_3 (s) = (J s^2 + c_2 s + k_2) Theta_o (s) $
$ => quad Theta_3 (s) = 1/k_2 (J s^2 + c_2 s +k_2) Theta_o (s) $

Re-arranging the differential equations of equation $(1)$ yield:
$ k_1 theta_i = c_1 dot(theta)_2 + k_1 theta_2 - c_1 dot(theta)_3 $
$ c_1 dot(theta)_2 = c_1 dot(theta)_3 + k_2 theta_3 - k_2 theta_o $

Applying Laplace transform to the equations:
$ k_1 Theta_i (s) = (c_1 s + k_1) Theta_2 (s) - c_1 s Theta_3 (s) $
$ c_1 s Theta_2 (s) = (c_1 s + k_2) Theta_3 (s) - k_2 Theta_0 (s) $
$ Theta_2 (s) = 1/(c_1 s) [(c_1 s + k_2) Theta_3 (s) - k_2 Theta_o (s)] $

Substituting $Theta_2 (s)$ into the previous equation yields:
$
        k_1 Theta_i (s) & = (c_1 s + k_1) 1/(c_1 s) [(c_1 s + k_2) Theta_3 (s)
                              - k_2 Theta_o (s)] - c_1 s Theta_3 (s) \
                        & = 1/(c_1 s) {[(c_1 s + k_1) (c_1 s + k_2) - c^2 s^2]
                              Theta_3 (s) - (c_1 s + k_1) k_2 Theta_o (s)} \
                        & = 1/(c_1 s) {[c_1 s(k_1 + k_2) + k_1 k_2] Theta_3 (s)
                              - (c_1 s + k_1) k_2 Theta_o (s)} \
    => quad Theta_3 (s) & = frac(
                              c_1 k_1 s Theta_i (s)
                              + (c_1 s + k_1) k_2 Theta_o (s),
                              c_1 s(k_1 + k_2) + k_1 k_2
                          )
$

Equating the above with $Theta_3 (s)$ obtained earlier yields:
$
    (J s^2 + c_2 s + k_2)/k_2 Theta_o (s)
    &= frac(
        c_1 k_1 s Theta_i (s) + (c_1 s + k_1) k_2 Theta_o (s),
        c_1 s(k_1 + k_2) + k_1 k_2
    ) \
    frac(c_1 k_1 k_2 s, c_1 s(k_1 + k_2) + k_1 k_2) Theta_i (s)
    &= [(J s^2 + c_2 s + k_2) - frac(
            (c_1 s + k_1) k_2^2,
            c_1 s (k_1 + k_2) + k_1 k_2
        )] Theta_o (s) \
    frac(Theta_o (s), Theta_i (s))
    &= frac(
        c_1 k_1 k_2,
        J c_1 (k_1 + k_2) s^2 + [J k_1 k_2 + c_1 c_2 (k_1 + k_2)] s
        + k_1 k_2 (c_1 + c_2)
    )
$

#pagebreak()

== Types of motors
#cimage("./images/types-of-motors.png")

=== Graphs
#cimage("./images/graphs-of-types-of-motors.png")

=== Shunt motors
$ V_T = E_b + I_a R_a $
$ V_T = k phi.alt omega + I_a R_a $
$
    omega = V_T / (K phi.alt) = - frac(I_a R_a, K phi.alt)
    = frac(V_T - I_a R_a, K phi.alt)
$
$ "Speed regulation" = frac(N_o - N_(f l), N_(f l)) $
$ "Shunt motor": T = k phi.alt I_a $
$ "Starting current": I_a = frac(V_T - E_b, R_a) $

=== Permanent magnet DC motor
Voltage equation:
#labelled_equation($V = R_a I_a + K_e Omega$, 1)

Armature current:
#labelled_equation($I_a = (V - K_E Omega)/R_a$, 2)

Torque:
#labelled_equation($T = K_T I_a = K_T/R_a (V - K_E Omega)$, 3)

From equation $(3)$,
#labelled_equation($"Starting torque": T_s = (K_T V)/R_a$, 4)
#labelled_equation($"No load speed": Omega_0 = V/K_E$, 5)

Using the above units:
$ K_T = "Torque constant" (#qty[1][N m A^-1]) $
$ K_E = "Back EMF constant" (#qty[1][V s rad^-1]) $

#cimage(
    "./images/permanent-magnet-dc-motor-torque-vs-speed-characteristics.png",
    height: 13em,
)

=== Armature controlled DC motor
#cimage("./images/armature-controlled-dc-motor.png", height: 10em)

$ T(t) = J dot.double(theta) (t) + B dot(theta) (t) $
$ therefore T(s) = s(J s + B) theta (s) $

Armature loop:
$ e_a = R_a i_a + L_a i_a + e_m $
$ therefore E_a = (R_a + L_a s) I_a + E_m $

Constant current source:
$ T_m = K_t i_a $
$ T_m = K_t I_a $

Eliminating $I_a, E_m, T$:
$ theta/E_a = frac(1/K_e, s(T_a T_m S^2 + (T_m + gamma T_a)s + gamma + 1)) $

Where:
- $T_m = frac(J R_a, K_e K_t)$ is the motor time constant
- $T_a = frac(L_a, R_a)$ is the armature time constant
- $gamma = frac(B R_a, K_e K_t)$ is the damping factor

Assuming armature inductance, $L_a$ is small compared to armature resistance
$R_a$:
$
    frac(theta_m (s), E_a (s)) =
    frac(K_t/(R_a J_m), S[S + 1/J_m (b_m + frac(K_t K_e, R_a))])
$

#cimage("./images/armature-controlled-dc-motor-block-diagram.png", height: 15em)

=== Field controlled DC motor
#cimage("./images/field-controlled-dc-motor.png", height: 8em)

Generally, motor load is assumed to consist of an inertia and a damper with
damping constant, $B$. Motor shaft position $theta$ and motor torque are
related.

$ T(t) = J dot.double(theta) (t) + B dot(theta) (t) $
$ therefore T(s) = s (J s + B) theta (s) $
$ theta(s)/T(s) = 1/(s(J s + B)) $

Equating loop field:
$ e_f = R_f I_f + L_f $
$ E_f = (R_f + s L_f) I_f $

With constant armature voltage, the developed motor torque, $T$, is proportional
to the field current. $T = K_t I_f$. $K_T$ is the motor torque constant.

Eliminating $I_f$ and $T$:
$ theta/E_f = frac(K_t/(R_f B), s(T_m s + 1) (T_f s + 1)) $

Where:
- $T_m = J/B$ is the motor time constant
- $T_f = L_f/R_f$ is the field time constant

In the operating range of the motor:
$ T_f << T_m $
$ therefore theta/E_f = frac(K_t/(R_f B), s(T_m s + 1)) $

The system type is $1/s$, so the motor is basically an integrator. For a
constant input, $theta_f$ has shaft angle $theta$ which increases at a constant
rate. Essentially:
$ theta prop integral e_f $

#cimage("./images/field-controlled-dc-motor-block-diagram.png", height: 5em)

== Motivation for mathematical modelling
+ A method to unify sub-systems across different disciplines.
+ To regulate the output with respect to time $t$.

For example:
#cimage("./images/example-of-mathematical-modelling.png")

=== Physical system
#cimage("./images/physical-system-block-diagram.png")

=== Example
#cimage("./images/mathematical-modelling-example-diagram.png", height: 25em)

Using $f = m a$:
$ f - (C_1 dot(x) + K_1 x) = M dot.double(x) $
$ f = M dot.double(x) + C_1 dot(x) + K_1 x $

Laplace transform:
$ F(s) = M s^2 X + C_1 s X + K_1 X $
$ F(s) = [M s^2 + C_1 s + K_1] X $
$ X(s)/F(s) = 1/(M s^2 + C_1 s + K_1) = G(s) $

Assuming $M = #qty[1][kg], C_1 = #qty[7][Ns m^-1], K_1 = #qty[6][N m^-1]$.

Solve $x(t)$ when $f(t) = #qty[1][N]$.

Input in s-domain: $F(s) = 1/s$

Solving $x(t)$:
$ X(s) = 1/(M s^2 + C_1 s + K_1) F_s $
$ X(s) = 1/(s^2 + 7s + 6) 1/s $
$ X(s) = 1/(s(s + 1)(s + 6)) $

#pagebreak()

Partial fraction decomposition:
$ X(s) = 1/(s(s + 1)(s + 6)) $
$ X(s) = A/s + B/(s + 1), C/(s + 6) $

Comparing the numerator:
$ A(s + 1)(s + 6) + B s (s + 6) + C s(s + 1) = 1 $

Substitute $s = 0$:
$ A(1)(6) + 0 = 1 quad -> quad A = 1/6 $

Substitute $s = -1$:
$ B(-1)(5) = 1 quad -> quad B = - 1/5 $

Substitute $s = -6$:
$ C(-6)(-5) = 1 quad -> quad C = 1/30 $

$ therefore X(s) = 1/(6s) + 1/5(s + 1) + 1/30(s + 6) $

Laplace inverse:
$ x(t) = cal(L)^(-1) {X(s)} = 1/6 - 1/5 e^(-t) + 1/30 e^(-6t) $

Recomputing the steady-state $x (x_(s s)$ with final value theorem:
$
    x_(s s) & = lim_(t -> oo) x(t) = lim_(s -> s X(s) \
                           & = lim_(s -> 0) 1/(s(s + 1)(s + 6)) \
                           & = lim_(s -> 0) 1/((1)(6)) = 1/6
$

This result is only valid when the system is stable.

#pagebreak()

= Poles and stability
For a transfer function:
$ G(s) = N(s)/D(s) $

The characteristic equation is:
$ D(s) = 0 $

The poles are defined as all values of $s$ that satisfy the characteristic
equation.

== Stability analysis
- Intuitively, a stable system is one whose response does not "blow up" during
    its operation.
- Another intuitive understanding is the output of a system has "finite energy"
    if the input to the system has only "finite energy".
- Since "energy" is related to the size or magnitude of a signal, this leads to
    the following stability concept, which is:
    #align(center)[A system is bounded-input bounded output (BIBO) stable if the
        output signal is bounded when the input signal is bounded.]
- In other words, if a stable system is driven by an input that doesn't blow up,
    then the output doesn't blow up either.
- On the other hand, if a system is unstable, then some bounded input produces
    an unbounded output.

=== Criteria for bounded-input bounded-output (BIBO) stability
- *Open* left-half of $s$-plane is the region to the left of the imaginary axis
    in the $s$-plane *excluding* the imaginary axis.
- *Closed* left-half of $s$-plane is the region to the left of the imaginary
    axis in the $s$-plane *including* the imaginary axis.
- *Open* right-half of $s$-plane is the region to the right of the imaginary
    axis in the $s$-plane *excluding* the imaginary axis.
- *Closed* left-half of $s$-plane is the region to the right of the imaginary
    axis in the $s$-plane *including* the imaginary axis.

The system $G(s)$ is BIBO stable if and only if all its poles are in the open
left-half $s$-plane, or equivalently, the poles have negative real parts.

=== Example
Consider a simple case where the poles of the system are all distinct and that
the system is driven by a unit step function, i.e.
$ r(t) = cal(1)(t) $

In this case, the output $C(s)$ is:
$ C(s) = N(s)/D(s) 1/s $

Performing partial fraction decomposition:
$ C(s) = 1/s + sum_(i = 1)^n a_i/s + p_i $

== Transfer function poles
Poles dictate the homogeneous solutions and the transient response of a system.

=== Differential equation
$ M dot.double(x) + C dot(x) + K x = f $
$ "Homogeneous solution": M dot.double(x) + C dot(x) + K x = 0 $
$ M d^2 + C d + K = 0 $

==== 1st possibility
$ d = - 1, 2 $
$ x = A e^(-t) + B e^(2t) $

==== 2nd possibility
$ d = plus.minus 5 j $
$ x = A cos (5 t + phi.alt) $

==== 3rd possibility
$ d = - 2 plus.minus 5 j $
$ x = A e^(-2t) cos (5t + phi.alt) $

#pagebreak()

=== Laplace transform
$ [M s^2 + C s + K] X(s) = F(s) $
$ X(s)/F(s) = 1/(M s^2 C s + K) $
$ "Transfer function poles": M s^2 + C s + K = 0 $

==== 1st possibility
$ s = -1, 2 $
$ x = A e^(-t) + B e^(2t) $

==== 2nd possibility
$ s = plus.minus 5 j $
$ x = A cos (5t + phi.alt) $

==== 3rd possibility
$ s = - 2 plus.minus 5 j $
$ x = A e^(-2t) cos (5t + phi.alt) $

== Stable systems
Transfer function poles dictate stability.
$ X(s)/F(s) = 1/(s^2 + 3s + 2) $

Transfer function poles:
$ s^2 + 3s + 2 = 0 $
$ (s + 1) (s + 2) = 0 $
$ s = -1, -2 $

#cimage("./images/stable-system-diagrams.png")
#pagebreak()

== Partially-stable systems
Transfer function poles dictate stability.
$ X(s)/F(s) = 1/(s^2 + 4) $

Transfer function poles:
$ s^2 + 4 = 0 $
$ s = plus.minus 2 j $

#cimage("./images/partially-stable-system-diagrams.png")

== Unstable systems
Transfer function poles dictate stability.
$ X(s)/F(s) = 1/(s^2 + s - 2) $

Transfer function poles:
$ s^2 + s - 2 = 0 $
$ (s - 1) (s + 2) = 0 $
$ s = 1, -2 $

#cimage("./images/unstable-system-diagrams.png")
#pagebreak()

== Types of poles
+ Real poles ($s = a$)

    Transient response: $A e^(a t)$

+ Pure complex poles ($s = plus.minus b j$)

    Transient response (always partially stable): $A cos (b t + phi.alt)$

+ Complex poles with real parts ($s = a plus.minus b j$)

    Transient response: $A e^(a t) cos (b t + phi.alt)$

Where $A$ and #sym.phi.alt are constants.

*Stable systems* require #mathred($e^(a t) -> 0$) when $t -> oo$.
$ a < 0 $

#cimage("./images/stability-s-plane.png", height: 20em)
#pagebreak()

== Damping factor and stability
- In the design of a closed loop control system, the speed of response should be
    reasonably fast, while the percentage overshoot should not be too great and
    the settling time not too long.
- However, these are conflicting requirements, and hence the system design must
    compromise on the 3 factors.
- Usually, if the speed of the response and the peak overshoot are of highest
    importance, then the damping factor should be $zeta = 0.4$.
- If settling time is the most important, a value of $zeta = 0.7$ should be
    chosen.
- Thus, the damping factor chosen should lie within the range
    $0.4 < zeta < 0.7$.

The shape of natural response is determined by the location of the poles of the
transfer function.

$-e^(-2t)$ decays faster than $e^(-t)$. The point further to the left in the
$s$-plane are associated with natural signals that decay faster than those
associated with poles closer to the imaginary axis.
$ c(t) = c_(s s) (t) + c_(t r) $
$ lim c_(t r) (t) = 0 quad ("stable") $

$ G(s) = c(s)/R(s) = N(s)/D(s) $
$ t -> oo = oo quad ("unstable") $

$ c_(t r) (s) = c_1/(s + r_1) + c_2/(s + r_2) + c_3/(s + r_3) + dots.c $
$ c_(t r) (t) = c_1 e^(-r_1 t) + c_2 e^(-r_2 t) + c_3 e^(-r_3 t) + dots.c $

#cimage(
    "./images/functions-associated-with-points-in-the-s-plane.png",
    height: 30em,
)

== The $s$-plane
We can plot the positions of the poles on a graph with the real part of the pole
value as the $x$-axis and the imaginary part as the $y$-axis. The resulting
graph describes what is termed the $s$-plane.

=== Negative real roots
The graph below shows the $s$-plane for the transfer function:
$ G(s) = 1/((s + 1)(s + 2)) $

#cimage("./images/s-plane-negative-roots.png", height: 15em)

Since $s = -1$ and $s = -2$, there are no imaginary terms. The system is stable
since the roots are negative and give rise to exponential terms that decrease
with time.

=== Positive real roots
The graph below shows the $s$-plane for the transfer function:
$ G(s) = 1/((s - 1)(s - 2)) $

#cimage("./images/s-plane-positive-roots.png", height: 15em)

Since $s = +1$ and $s = +2$, there are no imaginary terms. The system is
unstable since the roots are positive and give rise to exponential terms which
increase with time.

#pagebreak()

=== Complex roots with positive real roots
The graph below shows the $s$-plane for the transfer function:
$ G(s) = 1/(s^2 + 2s + 4) $

#cimage("./images/s-plane-complex-roots.png", height: 15em)

The roots of the quadratic equation are:
$ s = 1/2 (- 2 plus.minus sqrt(4 - 16)) = -1 plus.minus sqrt(3) j $

The system is under-damped but is stable. The system is stable because the real
parts of the roots are negative.

=== Negative and equal real roots
The graph below shows the $s$-plane for the transfer function:
$ G(s) = 1/(s + 1)^2 $

Since $s = -1$ only, there is critical damping. In general, we can state that a
system is stable if all the system poles lie in the left half of the $s$-plane.
The more negative the real part of the pole, the more rapidly the transient dies
away. The larger the imaginary part of the pole, the higher the frequency of the
oscillation. A system having a pole which has a positive real part is unstable.

#cimage("./images/s-plane-negative-and-equal-roots.png", height: 15em)

#pagebreak()

== Routh-Hurwitz stability criterion
The Routh-Hurwitz stability criterion is a simple way to check the *number of
    poles* that have *positive real parts*.

=== Steps
+ Form the roof array.
+ The roof array is formed by laying out all the powers of $s$ in a table, with
    the powers of $s$ being the rows, starting from the highest power of $s$ at
    the top.
+ For the first 2 powers of $s$, fill the column next to that power of $s$ with
    its coefficient, then skip a power of $s$ and write down the next power of
    $s$ in the next column, continuing until there are no more powers of $s$.
+ For example, if the power of $s$ is 4, then the coefficient of $s^4$ is
    written down, followed by the coefficient of $s^2$, and followed by $s^0$,
    which is the constant term.
+ If the power of $s$ is 3, then the coefficient of $s^3$ is written down,
    followed by the coefficient of $s^1$, which is $s$.
+ Figure out the rest of the coefficients of the powers of $s$.
+ To do this, go to the bottom of the first numerical column and set that value
    as the anchor.
+ Multiply the anchor with the value that is both above and to the right of the
    current column, and subtract the multiplication of the value directly above
    the anchor and the value to the right of the current column.
+ Divide the result by the value of the anchor to obtain the coefficient for the
    power of $s$.
+ Move to the next column, but keep the anchor constant.
+ Repeat steps 8 and 9 to obtain the next coefficient for the same power of $s$.
+ Continue the same steps until the row is completed, then do the same thing for
    the next row, until the coefficients for all the powers of $s$ have been
    filled.
+ If there is no change in sign (like positive to negative or negative to
    positive), that means there are no roots with positive real parts, and hence
    the system is stable.

Special cases:
- If one of the elements in the first numerical column is 0, replace the zero
    with $epsilon$, which is a small positive number. In this case, the system
    is *partially stable* if there are *no* sign changes in the first numerical
    column, and *partially unstable* if there are *sign changes* in the first
    column.
- If an entire row of elements are zero, form an equation with the power of $s$
    above it and differentiate the equation with respect to $s$, then use the
    coefficients of the result to replace the 0s, then continue as normal. In
    this case, the system is *partially stable* if there are *no* sign changes
    in the first numerical column, and *partially unstable* if there are *sign
        changes* in the first column.

#pagebreak()

=== Example 1
Characteristic equation:
$ s^4 + 8s^3 + 32s^2 + 80s + 100 = 0 $

#cimage("./images/routh-hurwitz-example-1-step-1.png", width: 90%)
#cimage("./images/routh-hurwitz-example-1-step-2.png", width: 90%)
#cimage("./images/routh-hurwitz-example-1-step-3.png", width: 90%)

Since there is no change in sign for the first numerical column, there are no
roots with positive real parts and hence the system is stable.

=== Example of first special case
When one of the elements in the first numerical column is 0.

#cimage("./images/routh-hurwitz-special-case-1-example.png")

Where $epsilon$ is a small positive number.

Check for sign changes in the first numerical column, and the system is now
either partially stable (*no* sign changes in the first numerical column) or
partially unstable (*sign changes* in the first numerical column).

#pagebreak()

=== Example of the second special case
When there is an entire row of elements that are 0.

#cimage("./images/routh-hurwitz-special-case-2-example-step-1.png")

Form an equation with the coefficients of $s$ in the row above (the row in red)
to form the auxiliary polynomial, which is
$ P(s) = s^4 + 5s^2 + 20 $

Differentiate the auxiliary polynomial with respect to $s$:
$ frac(dif P(s), dif s) = 4s^3 + 10s $

Use the coefficients of $frac(dif P(s), dif s)$ to replace the zero elements.

#cimage("./images/routh-hurwitz-special-case-2-example-step-2.png")

Continue as per normal.

#cimage("./images/routh-hurwitz-special-case-2-example-step-3.png")

Check for sign changes in the first numerical column, and the system is now
either partially stable (*no* sign changes in the first numerical column) or
partially unstable (*sign changes* in the first numerical column).

#pagebreak()

=== Example 2
Check the stability of a unity feedback system with a forward-loop transfer
function of:
$ G(s) = 1/(s^3 + s^2 + 2s + 23) $

#cimage("./images/routh-hurwitz-example-2-block-diagram.png")

$
    G_(C L) & = C/R = G/(1 + G) \
            & = 1/(s^3 + s^2 + 2s + 24)
$

Characteristic equation:
$ s^3 + s^2 + 2s + 24 = 0 $

#cimage("./images/routh-hurwitz-example-2.png")

There are two sign changes in the first column, which means that there are two
roots with positive real parts, and hence two unstable poles.

#pagebreak()

= Time response
- Stable system
    - Transient response, $c_(t r)$, disappears with time.
    - Steady state, $c_(s s)$, measures the system accuracy.
- Unstable system
    - Only has transient response, $c_(t r)$.
- Transient response is always present in a system, due to effects like:
    - Inertia friction
    - Inductance
    - Capacitance

#cimage("./images/time-response-for-system-graph.png", height: 20em)

For a first-order system:
$ G(s) quad -> quad C/R = K/(1 + tau s) $

#cimage("./images/time-response-input-to-output-graphs.png")

== First order systems

#cimage("./images/mathematical-modelling-of-spring-system-6.png")

At equilibrium:
#labelled_equation($c dot(y) + k y = k x$, 1)

Laplace transform of $(1)$ with zero initial conditions:
$ C S Y(s) + K Y(s) = K X(s) $
$
    therefore quad "Transfer function": G(s)
    = Y(s)/X(s) = k/(c s + k) = 1/(1 + s tau)
$

Where $tau = "time constant" = C/K$.

=== Mechanical first-order systems
#cimage("./images/mechanical-first-order-system.png", height: 15em)

The input variable $x_i$ and output variable $x_o$ are related by the equation
obtained by equating the forces at $A$:
$ K(x_i - x_o) = C dot(x)_o $
$ C/K dot(x)_o + x_o = x_i $

Taking the Laplace transform and assuming initial conditions to be zero:
$ X_o (s C/K + 1) = X_i $
$ therefore quad "Transfer function": X_o/X_i = 1/(1 + C/K s) = 1/(1 + tau s) $

=== Unit step input
$ Y(s) = 1/(1 + s tau) dot 1/s = 1/s - tau/(1 + tau s) = 1/s - 1/(s + 1/tau) $
$ cal(L)^(-1){Y(s)} = y(t) = 1 - e^(-t/tau) $

Where:
- $1$ is the steady state response.
- $e^(-t/tau)$ is the transient response.

#cimage("./images/unit-step-time-response-graph.png")

$
    y(t) = cases(
        1 - e^(-1) = 0.632,
        1 - e^(-2) = 0.865,
        1 - e^(-3) = 0.95,
        1 - e^(-4) = 0.982,
        1 - e^(-5) = 0.993,
        dots.c
    )
$

The 2% settling criterion states that after 4 time constants, the output should
be within 2% of the value at $t = oo$.

The time constant is useful in studying the 1st order response system response
time, and its units is in #unit[sec].
- Its value influences the response of the system.
- The smaller the time constant #sym.tau, the faster the system response.
- It is the negative reciprocal of the coefficient of $t$ in exponential term
    $e^(a t)$ in transient responses, i.e.
    $ a = - 1/tau $

#pagebreak()

=== Unit ramp input
$
    Y(s) = 1/(1 + s tau) dot 1/s^2 & = 1/s^2 - tau/s + tau^2/(1 + tau s) \
                                   & = 1/s^2 - tau(1/s) + tau(1/(s + 1/tau))
$
$ cal(L)^(-1){Y(s)} = y(t) = t - tau + tau_e^(-1/tau) $

Where:
- $t - tau$ is the steady state response.
- $tau_e^(-t/tau)$ is the transient response, which decays to less than 2% of
    #sym.tau in time $4 tau$.

#cimage("./images/unit-ramp-time-response-graph.png", height: 15em)

=== Unit impulse input
$ Y(s) = 1/(1 + s tau) dot 1 = frac(1/tau, s + 1/tau) $
$ Y(t) = 1/tau e^(-t/tau) $

#cimage("./images/unit-impulse-time-response-graph.png", height: 15em)

=== Example 1
#cimage("./images/first-order-system-example-1-figures.png")

+ The first-order plant of Figure (a) has the unit step response given in Figure
    (b). Find the parameters of the transfer function.
    $ c(t) = k(1 - e^(t/tau)) $
    $ c(0.5) = 0.730 = k(1 - e^(-0.5/tau)) $
    $ c(1.0) = 1.104 = k(1 - e^(-1.0/tau)) $
    $ therefore frac(1 - e^(-0.5/tau), 1 - e^(-1.0/tau)) = 0.730/1.104 $

    Let $gamma = e^(-0.5/tau)$:
    $ therefore 1.104(1 - gamma) = 0.730(1 - gamma^2) $
    $ 0.374 - 1.104 gamma + 0.73 gamma^2 = 0 $
    $ gamma = frac(1.104 plus.minus sqrt(1.21882 - 0.09208), 2(0.73)) = 0.512 $
    $ e^(-0.5/tau) = 0.512 $
    $ tau = 0.746 $
    $ k = 0.730/(1 - 0.512) = 1.496 $

#pagebreak()

+ The plant is connected into the closed-loop system as shown in Figure (c).
    Sketch the unit step response of the closed-loop system.
    $
        T(s) & = frac(K/(tau s + 1), 1 + 0.4K/(tau s + 1)) \
             & = 2/(s + 1.34 + 0.8) \
             & = 2/(s + 2.14) \
             & = 0.935/(0.467s + 1)
    $

$ therefore k = 0.935, quad tau = 0.467s $

=== Example 2
The graph below shows the experimentally obtained voltage output of an unknown
system subjected to a step input of #qty[+10][V]. Determine the transfer
function of the system and locate its pole on the complex plane.

#cimage("./images/first-order-system-example-2-figure.png", height: 15em)

The system appears to be 1st order. Let it be where $r$ and $c$ are voltages. If
$r$ is a step of #qty[10][V],
$
    lim_(t -> 0) c(t)
    = lim_(s -> 0) s C(s)
    = lim_(s -> 0) s(10 a)/s(1 + s t)
    = 10a
    = #qty[2.5][V] quad ("from graph")
$

Hence $a = 0.25$. Now consider $T$. The output should reach 63% of the steady
state (#qty[1.575][V]) in $T$ seconds. From the graph, $T = #qty[1.3][secs]$.
So, we get:
$ C/R = 0.25/(1 + 1.35) $
$ C(t) = 2.5(1 - e^(-t/1.3)) "if" R = 10/s $

Comparing the results:
#align(center)[#table(
    align: center,
    columns: 5,
    [*$t$*], [1], [2], [3], [4],
    [*Predicted*], [1.34], [1.96], [2.25], [2.38],
    [*Observed*], [1.22], [1.84], [2.16], [2.33],
)]

=== General method
Find $c(t)$ when $r(t)$ is a step input with magnitude $p$.
$ r(t) = p u (t) $
$ R(s) = p/s $

$
    C(s) = (p/s) (k/ tau s + 1)
    = underbrace(A/s, "Steady-state output")
    + underbrace(B/(tau s + 1), "Transient output")
$

Where $A$ and $B$ are residues.

$
    C(s) & = A/s + B \
         & = (p k)/s - frac(p k tau, tau s + 1)
$
$
    c(t) = underbrace(p k, "Steady-state output")
    - underbrace(p k e^(-t/tau), "Transient output")
$

#stack(
    dir: ltr,
    spacing: 2em,
    align(horizon + center)[
        When $p = k = 1$:
        $ "2% settling time": t_s = 4 tau $
    ],
    image(
        "./images/first-order-system-general-method-response.png",
        height: 20em,
    ),
)

#stack(
    dir: ltr,
    spacing: 2em,
    align(horizon + center)[
        $ "DC gain of" G(s) = lim_(s -> 0) k/(tau s + 1) = k $
        $ c_(s s) = p k "(product of DC gain and magnitude of step)" $
        $ "Poles of" G(s): s = - 1/tau $
        $ c_(t r) (t) = A e^(-t/tau) $
        $ c(t) = c_(s s) + c_(t r) $
    ],
    cimage(
        "./images/first-order-system-general-method-s-plane-graph.png",
        height: 15em,
    ),
)

== System response
- As systems are dynamical in nature, their performances are hard to measure or
    quantify.
- One accepted approach is to use a reference input to the system, and measure
    its performance in time domain analysis.
- Let $c(t)$ be the output of the system with input $r(t)$. The time response of
    a system consists of two parts, the transient and the steady state response.

#cimage(
    "./images/system-response-transient-and-steady-state-response-graph.png",
    height: 15em,
)

- The responses can be written as:
    $ c(t) = c_(t r) (t) + c_(s s) $

    Where:
    - $c_(t r)(t)$ deontes the transient response
    - $c_(s s)(t)$ deontes the steady state response

- The transient response is defined as the part of the time response that goes
    to zero as time becomes very large, or:
    $ lim_(t -> infinity) c_t (t) = 0 $
- The steady state response is the part of the total response that remains after
    the transient response has died out.
- All real control systems exhibit transient response to some extent before the
    steady state is reached, as inertia, mass, inductance, capacitance are
    unavoidable in physical systems. Because of these, the response of a typical
    control system cannot follow sudden changes in the input instantaneously and
    transients are usually observed.
- Hence, having a good transient response of a system is necessarily important,
    as it is a significant part of the dynamic behaviour of the system.
- It determines the deviation between the output response and the input (or the
    desired response) before the steady state is reached.
- The steady state response is also very important, as it determines where the
    system output response ends up at after a long time.
- If the steady state response response of the output does not agree with the
    steady state of the input or desired response exactly, then a steady state
    error occurs.
- The design of a controller should include considerations of the transient and
    steady state performance specifications.

== Test signals

=== Step input
$ r(t) = cases(A \, quad t >= 0, 0 \, quad t < 0) $

#cimage("./images/test-signals-step-input.png", height: 10em)

- $R(s) = A/s$
- When $A = 1$, known as the unit step input, is very useful in studying changes
    in input signals.

=== Ramp input
$ r(t) = cases(A t \, quad t >= 0, 0 \, quad t < 0) $

#cimage("./images/test-signals-ramp-input.png", height: 10em)

- $R(s) = A/s^2$
- When $A = 1$, known as the unit ramp input, is useful in studying the system's
    ability to follow increasing input values.

=== Impulse input
$ r(t) = A delta $

#cimage("./images/test-signals-impulse-input.png", height: 10em)

- $R(s) = A$
- When $A = 1$, known as the unit impulse input, is useful in studying sudden
    shock or impact and *system identification*.

=== Sinusoidal input
$ r(t) = cases(A sin omega t \, t >= 0, 0 \, t < 0) $

#cimage("./images/test-signals-sinusoidal-input.png", height: 10em)

- $R(s) = omega/(s^2 + omega^2)$
- When $A = 1$, known as the unit sinusoid input, is useful in studying the
    *frequency response* of a system.

== Responses of first-order systems
For a first order system the transfer function is:
$ G(s) = 1/(T s + 1) $

- The transfer function of a DC motor with armature voltage as input and angular
    velocity as output is:
    $ Omega(s)/U(s) = k_m/(tau_m s + 1) $
- The transfer function of a mechanical rotational system with torque as input
    and angular velocity as output:
    $ Omega(s)/U(s) = 1/(J s + b) $
- The transfer function for a thermal system:
    $
        frac(Theta_s (s), Theta_e (s))
        = frac(R_1 + R_2, R_1 + R_2 + C R_1 R_2 s)
    $

In terms of block diagrams, the first-order systems can be represented in the
following two forms:

#cimage("./images/response-of-first-order-system-block-diagram.png")

Where $T, k > 0$.

#pagebreak()

=== Step input
$ R(s) = 1/s $
$ C(s) = 1/(s(T s + 1)) = 1/s - T/(T s + 1) $

In time domain, it is:
$ c(t) = 1 - e^(-t/T), quad t >= 0 $

Note that:
$ c(0) = 1 - 1 = 0 $
$ c(T) = 1 - e^(-1) = 0.632 $
$ c(oo) = 1 $
$
    evaluated(frac(dif c(t), dif t))_(t = 0)
    = evaluated(1/T e^(-t/T))_(t = 0) = 1/T
$

#cimage("./images/response-of-first-order-system-unit-step.png", height: 20em)

- The smaller the $T$, the faster the response.
- For $t > 4T$, the response is within 2% of the final value.

#pagebreak()

=== Ramp input
$ R(s) = 1/s^2 $
$ C(s) = 1/(s^2 (T s + 1)) = 1/s^2 - T/s + T^2/(T s + 1) $

In time domain, it is:
$ c(t) = t - T + T e^(-t/T), quad t >= 0 $

Note that:
$ c(0) = 0 - T + T = 0 $
$ c(oo) = oo $

#cimage("./images/response-of-first-order-system-unit-ramp.png", height: 20em)

The error $e(t)$:
$ e(t) = r(t) - c(t) = T - T e^(-t/ T) = T(1 - e^(-t/T)) $

The error at steady state is:
$ e(oo) = T $

#pagebreak()

=== Impulse input
$ C(s) = 1/(T s + 1) $
$ R(s) = 1/(T s + 1) dot 1 $

In time domain, it is:
$ c(t) = 1/T e^(-t/T), t >= 0 $

#cimage(
    "./images/response-of-first-order-system-unit-impulse.png",
    height: 20em,
)

=== Important property of the Laplace transform
- Suppose $c_1(t)$ is the output response corresponding to an input $r_1(t)$.
    Then if the input is changed to:
    $ r_2(t) = frac(dif r_1(t), dif t) $
- Then the corresponding output $c_2 (t)$ is given by:
    $ c_2(t) = frac(dif c_1(t), dif t) $
- This property can be verified easily when placed in the Laplace domain. In
    this case, we have:
    $ C_1(s) = G(s) R_1(s) $
    $ s C_1(s) = G(s) s R_1 (s) = G(s) R_2 (s) $

    The above implies that the output of the system with $R_2(s)$ as input is
    $s C_1 (s)$. In time domain, this means output is $frac(dif c_1(t), dif t)$
    when input is $frac(dif r_1(t), dif t)$.
- This fact manifests in the responses of first order system with ramp, step and
    impulse inputs. The step function is the derivative of the ramp function,
    and the impulse function is the derivative of the step input.

#pagebreak()

== Responses of second-order systems
Second-order systems are represented as:
$ G(s) = omega_n^2/(s^2 + 2 zeta omega_n s + omega_n^2) $

They are represented by:
- The mechanical translational system with force as input and position as
    output:
    $ X(s)/F(s) = 1/(m s^2 + b s + k) $
- The mechanical rotational system with torque as input and angular displacement
    as output:
    $ Theta(s)/T(s) = 1/(J s^2 + b s + k) $
- RLC circuit with voltage as input and capacitor voltage as output:
    $ frac(E_o (s), E_i (s)) = 1/(L C s^2 + R C s + 1) $

In terms of block diagrams, a second-order system can be represented in the
following two forms:

#cimage("./images/response-of-second-order-system-block-diagram.png")

- There are two parameters that characterise the second order system:
    - $omega_n$, which is the natural frequency.
    - $zeta$, which is the damping ratio.
- In both block diagrams above, the transfer function between the input and the
    output is:
    $ G(s) = omega_n^2/(s^2 + 2 zeta omega_n s + omega_n^2) $

#pagebreak()

=== Unit step input
$ R(s) = 1/s $
$ C(s) = G(s) R(s) = omega_n^2/(s (s^2 + 2 zeta omega_n s + omega_n^2)) $

- To obtain the steady state value, the final value theorem is used (assuming
    that the steady state exists):
    $
        lim_(t -> oo) c(t) = lim_(s = 0) s C(s)
        = lim_(s = 0) frac(s omega_n^2, s(s^2 + 2 zeta omega_n s + omega_n^2))
        = 1
    $
- To obtain the expression of the transient response, expression of the poles of
    $G(s)$ is needed.
- The poles of $G(s)$ are the roots of the deonominator polynomial, or the roots
    of:
    $ s^2 + 2 zeta omega_n s + omega_n^2 = 0 $
- Consider the roots of the above under different ranges of $zeta$.
    + $0 < zeta < 1$ (underdamped case), the roots are:
        $ s_(1, 2) = - zeta omega_n plus.minus j omega_n sqrt(1 - zeta^2) $
    + $zeta = 0$ (undamped case), the roots are:
        $ s_(1, 2) = plus.minus j omega_n $
    + $zeta = 1$ (critcally damped case), the roots are:
        $ s_(1, 2) = - omega_n $
    + $zeta > 1$ (overdamped case), the roots are:
        $ s_(1, 2) = - zeta omega_n plus.minus omega_n sqrt(zeta^2 - 1) $

#pagebreak()

==== Underdamped case ($0 < zeta < 1$)
The output is:
$
    C(s) = omega_n^2/(s(s^2 + 2 zeta omega_n s + omega_n^2))
    = omega_n^2/((s + zeta omega_n)^2 + omega_d^2) dot 1/s
$

Where:
- $omega_d = omega_n sqrt(1 - zeta^2)$, known as the damped natural frequency.

Simplifying:
$
    C(s) & = 1/s - frac(
               s + 2 zeta omega_n,
               s^2 + 2 zeta omega_n s + omega_n^2
           ) \
         & = 1/s - frac(s + zeta omega_n, (s + zeta omega_n)^2 + omega_d^2)
           - frac(zeta omega_n, (s + zeta omega_n)^2 + omega_d^2)
$

Taking the inverse Laplace transform, we get:
$
    c(t) & = 1 - e^(- zeta omega_n t) cos omega_d t
           - e^(-zeta omega_n t) zeta/sqrt(1 - zeta^2) sin omega_d t \
         & = 1 - e^(- zeta omega_n t)/sqrt(1 - zeta^2)
           (zeta sin omega_d t + sqrt(1 - zeta^2) cos omega_d t) \
         & = 1 - e^(- zeta omega_n t)/sqrt(1 - zeta^2)
           sin (omega_d t + arctan sqrt(1 - zeta^2)/zeta), quad t >= 0
$

==== Undamped case ($zeta = 0$)
The output is
$
    C(s) = omega_n^2/((s + j omega_n)(s - j omega_n)) dot 1/s
    = omega_n^2/(s^2 + omega_n^2) dot 1/s
    = 1/s - s/(s^2 + omega_n^2)
$
$ c(t) = 1 - cos omega_n t, quad t >=0 $

==== Critically damped case ($zeta = 1$)
$
    C(s) = omega_n^2/((s + a)(s + b)) dot 1/s
    = 1/s + 1/(a - b) (b/(s + a) - a/(s + b))
$
$ c(t) = 1 + 1/(a - b) (b e^(- a t) - a e^(- b t), quad t >= 0) $

Where:
- $a = zeta omega_n + omega_n sqrt(zeta^2 - 1)$
- $b = zeta omega_n - omega_n sqrt(zeta^2 - 1)$

#pagebreak()

==== Graph of the cases
Note that the $x$-axis is in units of $omega_n t$.

#cimage("./images/response-of-second-order-system-graph-of-all-cases.png")

Assuming that $omega_n$ is fixed, a few notable points are:
- Underdamped system with $zeta$ between 0.5 and 0.8 gets close to the final
    value more rapidly than a critically damped or overdamped system.
- Among the systems responding without osciallation, a critically damped system
    exhibits the fastest response.
- An overdamped system is always sluggish in responding to any inputs.

== Transient response
Systems with energy storage cannot respond instantaneously and will exhibit
transient responses whenever they are subjected to inputs of disturbances.
- In many applications, the desired performance characteristics of control
    systems are specified in terms of time-domain quantities (both transient and
    steady state).
- As systems with energy storage cannot respond instantaneously to input demand,
    transient responses result.
- Frequently, the performance characteristics of a control system are specified
    in terms of transient response to a unit-step input since it is easy to
    generate and is sufficiently drastic.
- The transient response of a system to a unit-step input depends on the initial
    conditions. For purposes of comparison, a standard set of initial conditions
    are used.

=== Quantities in transient response
#cimage("./images/transient-response-quantities-graph.png")
+ Delay time, $t_d$, is the time required for the response to reach half the
    final value for the very first time.
+ Rise time, $t_r$, is the time required for the response to rise from 10% to
    90%, 5% to 95%, or 0% to 100% of its final value.
    - For underdamped second-order systems, the 0% to 100% rise time is normally
        used.
    - For overdamped systems, the 10% to 90% rise time is commonly used.
+ Peak time, $t_p$, is the time required for the response to reach the first
    peak of the overshoot.
+ Maximum overshoot, $M_p$, is the maximum peak value of the response curve
    measured from unity. If the final steady-state value of the response differs
    from unity, then it is common to use the maximum percent overshoot, which is
    defined by:
    $ M_p = frac(c(t_p) - c(oo), c(oo)) times 100% $
+ Settling time, $t_s$, which is the time required for the response curve to
    reach and stay within a range about the final value. The size of this range
    is specified by the absolute percentage of the final value, usually 2% or
    5%. The settling time is related to the largest time constant of the control
    system. Which percentage error criterion to use is usually determined from
    the objectives of the system design in question.

#pagebreak()

=== Comments on transient response
- The time-domain specifications given are quite important since the responses
    in time are what are observed.
- Thus, the transient response should be satisfactory. Note that if values of
    $t_d, t_r, t_p, M_p$ and $t_s$ are specified, the shape of the response
    curve is virtually determined.
- Clearly, not all quantities are applicable for any given case. For example,
    $t_p$ and $M_p$ are not defined for an overdamped system, and $t_s$ may not
    be reached if systems have steady-state errors to step input, etc.
- Save for special applications where oscillations cannot be tolerated, the
    transient response should be sufficiently fast and lightly damped (minimal
    overshoot). In the case of a second-order system, this means $zeta$ is
    between 0.5 and 0.8. Small values of damping ratio (less than 0.4) yield
    excessive overshoot and large values of damping ratio (greater than 1),
    yields sluggish response.

=== Example: Underdamped second order system
$
    frac(X(s), F(s))
    = frac(omega_n^2, s^2 + 2 zeta omega_n s + omega_n^2), quad zeta < 1
$

Poles:
$ s = - zeta omega_n plus.minus j omega_n sqrt(1 - zeta^2) $

Transient response:
$ A e^(- zeta omega_n t) cos (omega_n sqrt(1 - zeta^2) t + phi.alt) $

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        S-plane:
        #cimage("./images/transient-response-example-s-plane.png", height: 15em)
    ],
    [
        Step response:
        #cimage("./images/transient-response-example-graph.png")
    ],
)

#pagebreak()

=== Transient quantities for second-order systems

==== Rise time ($t_r$)
In the special case of a standard second-order system with $0 <= zeta <= 1$, the
aforementioned quantities can be connected to the system parameters.
$
    c(t) & = 1 - e^(- zeta omega_n t)
           (cos omega_d t + zeta/sqrt(1 - zeta^2) sin omega_d t) \
         & = 1 - e^(- zeta omega_n t)/sqrt(1 - zeta^2)
           sin (omega_d t + arctan sqrt(1 - zeta^2)/zeta)
$

Note that $t_r$ is defined by the smallest solution to $c(t_r) = 1$. Hence:
$
    1 = 1 - e^(- zeta omega_n t)/sqrt(1 - zeta^2)
    sin (omega_d t_r + arctan sqrt(1 - zeta^2)/zeta)
$

This implies that:
$
    sin (omega_d t_r + phi.alt) = 0
    quad because e^(-zeta omega_n t)/sqrt(1 - zeta^2) != 0
$

Simplifying:
$ omega_d t_r + phi.alt = 0, pi, 2 pi, dots $

For the first $t_r > 0$:
$
    t_r = frac(pi - phi.alt, omega_d)
    = frac(pi - arctan sqrt(1 - zeta^2)/zeta, omega_d)
$

#pagebreak()

==== Peak time ($t_p$)
Peak time $t_p$ is defined by $evaluated(frac(dif c(t), dif t))_(t_p) = 0$.
$
    evaluated(frac(dif c(t), dif t))_(t = t_p)
    = frac(omega_n e^(- zeta omega_n t_p), sqrt(1 - zeta^2))
    (- zeta sin (omega_d t_p + phi.alt) + sqrt(1 - zeta^2)
        cos (omega_d t_p + phi.alt)) = 0
$

This implies that:
$
    zeta sin (omega_d t_p + phi.alt)
    = sqrt(1 - zeta^2) cos (omega_d t_p + phi.alt)
$
$ tan (omega_d t_p + phi.alt) = sqrt(1 - zeta^2)/zeta $
$ omega_d t_p + phi.alt = phi.alt + n pi $
$ "or" quad t_p = pi/omega_d, frac(2 pi, omega_d), dots $

==== Maximum overshoot ($M_p$)
The maximum overshoot occurs at the peak time (assuming that there is an
overshoot).
$
    M_p & = c(t_p) - 1 \
        & = -e^(-zeta omega_n t_p) cos omega_d t_p
          + zeta/sqrt(1 - zeta^2) sin omega_d t_p \
        & = e^(- zeta omega_n (pi/omega_d))
          (cos pi + zeta/sqrt(1 - zeta^2) sin pi)
$

This implies that:
$ M_p = e^(- frac(zeta pi, sqrt(1 - zeta^2))) $

In terms of percentage:
$ e^(- frac(zeta pi, sqrt(1 - zeta^2))) times 100% $

#cimage(
    "./images/transient-response-quantities-maximum-overshoot-graph.png",
    height: 18em,
)

==== Settling time ($t_s$)
The settling time $t_s$ can be obtained by considering the envelope of the
response, $c(t)$
- Specifically, note that $1 plus.minus e^(- zeta omega_n t)/sqrt(1 - zeta^2)$
    contains the response of $c(t)$ for all values of time $t$.
- The speed of decay of the envelope curves depends on the value of the time
    constant $T = 1/(zeta omega_n)$.
- Using the results of the first-order system, $t_s$ for #sym.plus.minus 2% and
    #sym.plus.minus 5% tolerant band are approximated by:
    $ t_s = 4T = 4/(zeta omega_n), quad "and" t_s = 3T - 3/(zeta omega_n) $

#cimage(
    "./images/transient-response-quantities-settling-time-graph.png",
    height: 25em,
)

- Note that the settling time is inversely proportional to the product of the
    damping ratio and the undamped natural frequency of the system.
- Since the value of $zeta$ is usually determined from the requirement of
    permissible maximum overshoot, $t_s$ can be determined by $omega_n$.
- This means that the duration of the transient period may be varied, without
    changing the maximum overshoot.
- $omega_n$ must be large for rapid response.
- To limit the maximum overshoot and to make the settling time small, the
    damping ratio $zeta$ should not be too small.
- Note that if $zeta$ is between 0.4 and 0.8, then the maximum percent overshoot
    for the step response is between 25% and 2.5%.

#pagebreak()

==== Summary
Consider the unit-step response of the second-order system defined by:
$ G(s) = omega_n^2/(s^2 + 2 zeta omega_n s + omega_n^2) $

Where:
- $omega_n$ is the undamped natural frequency
- $zeta$ is the damping ratio

Damped natural frequency, $omega_d$:
$ omega_d = omega_n sqrt(1 - zeta^2) $

Let:
$ phi.alt = arctan omega_d/(zeta omega_n) $

Rise time, $t_r$:
$ t_r = frac(pi - phi.alt, omega_d) $

Peak time, $t_p$:
$ t_p = pi/omega_d $

Maximum overshoot, $M_p$:
$ M_p = e^(-frac(zeta pi, sqrt(1 - zeta^2))) times 100% $

Settling time, $t_s$:
$ t_s = 3T = 3/(zeta omega_n) quad "for 5% criterion" $
$ t_s = 4T = 4/(zeta omega_n) quad "for 2% criterion" $

#pagebreak()

== Dominant poles
Dominant poles are the rightmost poles (slowest).

#cimage("./images/dominant-poles-graph.png")

#text(red)[
    System 1 has two poles:
    $ s= -2 plus.minus j $
    $ "Transient response": A e^(-2t) = cos (t + phi.alt) $
]

#text(green)[
    System 2 has two poles:
    $ s= -1 plus.minus j $
    $ "Transient response": A e^(-t) = cos (t + phi.alt) $

    System 2 is *slower*.
]

#pagebreak()

== Responses of higher-order systems
- Higher order systems can be decomposed into multiple first and second order
    systems.
- Expect some deviations form the first and second order systems.
- The location of the poles of the transfer function in the $s$-plane has great
    effects on the transient response of the system. So it is important to sort
    out the poles that have dominant effect on the transient response, known as
    the dominant poles.
- The poles that are close to the imaginary axis in the left half of the
    $s$-plane give rise to transient responses that will decay relatively
    slowly, whereas the poles that are far away from the imaginary axis
    (relative to the dominant poles) correspond to fast decaying time response.
- To see this effect, take
    $ G(s) = 10/((s + 1)(s + 10)) $

    #cimage("./images/response-of-higher-order-system.png")
- Hence, the transient response will be dominated by the dominant poles, which
    are also known as the slowest poles.
- The steady-state value is equal to the product of the DC gain of the transfer
    function and the magnitude of the input step.

#pagebreak()

= Steady state analysis of systems
#cimage("./images/steady-state-analysis-of-systems.png", height: 10em)
- Consider the feedback control system shown above where the loop transfer
    function $G(s) H(s)$ is written as:
    $
        G(s) H(s) = frac(
            K (tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
            s^N (tau_1 s + 1) (tau_2 s + 1) dots (tau_p s + 1)
        )
    $
- The system is called type 0, type 1, type 2, type 3, etc. If
    $N = 0, N = 1, N = 2, N = 3$, etc.
- Note that the error is for a closed-loop system type defined by the open loop
    transfer function or the loop transfer function.

== Error analysis
- Note that:
    $ C(s)/R(s) = G(s)/(1 + G(s) H(s)) "and" E(s)/C(s) = 1/G(s) $
- Hence, the error signal is given by:
    $ E(s) = R(s)/(1 + G(s) H(s)) $
- The steady state error can be found using the final-value theorem:
    $
        e_(s s) = lim_(t -> oo) e(t) = lim_(s = 0) s E(s)
        = lim_(s = 0) frac(s R(s), 1 + G(s) H (s))
    $
- The final value theorem can be applied only if all the roots of the polynomial
    in the denominator of $frac(s R(s), 1 + G(s) H(s))$ have negative real
    parts.

#pagebreak()

=== Step input ($R(s) = 1/s$)
- Consider the case where $R(s) = 1/s$, or $r(t) = 1$ for $t >= 0$. Then:
    $
        e_(s s) = lim_(s = 0) s E(s)
        = lim_(s = 0) frac(s 1/s, 1 + G(s) H(s))
        = 1/(1 + G(0) H(0))
        = 1/(1 + K_p)
    $

    Where $K_p := lim_(s = 0) G(s) H(s) = G(0) H(0)$ is the step-error constant.
- For type 0 systems:
    $
        K_p = lim_(s = 0) frac(
            K(tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
            mathred(s^0) (tau_1 s + 1) (tau_2 s + 1) dots (tau_p s + 1)
        ) = mathred(K)
    $
- For type 1 systems or higher ($N >= 1$):
    $
        K_p = lim_(s = 0) frac(
            K(tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
            mathred(s^N) (tau_1 s + 1) (tau_2 s + 1) dots (tau_p s + 1)
        ) = mathred(oo)
    $
- In summary, for step input:
    $ e_(s s) = 1/(1 + K_p), quad "for type 0 systems" $
    $ e_(s s) = 0, quad "for type 1 systems or higher" $

=== Ramp input ($R(s) = 1/s^2$)
- Consider the case where $R(s) = 1/s^2$, or $r(t) = 1$ for $t >= 0$. Then:
    $
        e_(s s) = lim_(s = 0) s E(s)
        = lim_(s = 0) frac(s 1/s^2, 1 + G(s) H(s))
        = 1/(s + s G(0) H(0))
        = 1/(K_v)
    $

    Where $K_v := lim_(s = 0) s G(s) H(s)$ is the ramp-error constant.
- For type 0 systems:
    $
        K_v = lim_(s = 0) frac(
            s K(tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
            mathred(s^0) (tau_1 s + 1) (tau_2 s + 1) dots (tau_p s + 1)
        ) = mathred(0) <= 1/(s + 1)
    $
- For type 1 systems:
    $
        K_v = lim_(s = 0) frac(
            s K(tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
            mathred(s^1) (tau_1 s + 1) (tau_2 s + 1) dots (tau_p s + 1)
        ) = mathred(K)
    $
- For type 2 systems or higher ($N >= 2$):
    $
        K_v = lim_(s = 0) frac(
            s K(tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
            mathred(s^N) (tau_1 s + 1) (tau_2 s + 1) dots (tau_p s + 1)
        ) = mathred(oo)
    $
- In summary, for ramp input:
    $ e_(s s) = oo, quad "for type 0 systems" $
    $ e_(s s) = 1/K, quad "for type 1 systems" $
    $ e_(s s) = 0, quad "for type 2 systems or higher" $

#pagebreak()

=== Parabolic input ($R(s) = 1/s^3$)
- Consider the case where $R(s) = 1/s^3$, or $r(t) = 1$ for $t >= 0$. Then:
    $
        e_(s s) = lim_(s = 0) s E(s)
        = lim_(s = 0) frac(s 1/s^3, 1 + G(s) H(s))
        = 1/(s^2 + s^2 G(0) H(0))
        = 1/(K_a)
    $

    Where $K_a := lim_(s = 0) s^2 G(s) H(s)$ is the parabolic-error constant.
- For type 0 and type 1 systems ($N = 0, 1$):
    $
        K_a = lim_(s = 0) frac(
            s^2 K(tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
            mathred(s^N) (tau_1 s + 1) (tau_2 s + 1) dots (tau_p s + 1)
        ) = mathred(0)
    $
- For type 2 systems:
    $
        K_a = lim_(s = 0) frac(
            s^2 K(tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
            mathred(s^2) (tau_1 s + 1) (tau_2 s + 1) dots (tau_p s + 1)
        ) = mathred(K)
    $
- For type 3 systems or higher ($N >= 3$):
    $
        K_a = lim_(s = 0) frac(
            s^2 K(tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
            mathred(s^N) (tau_1 s + 1) (tau_2 s + 1) dots (tau_p s + 1)
        ) = mathred(oo)
    $
- In summary, for ramp input:
    $ e_(s s) = oo, quad "for type 0 and type 1 systems" $
    $ e_(s s) = 1/K, quad "for type 2 systems" $
    $ e_(s s) = 0, quad "for type 3 systems or higher" $

#pagebreak()

=== Summary
Given a closed-loop feedback system:
#cimage("./images/steady-state-analysis-of-systems.png", height: 10em)

The above system has an open loop transfer function given by:
$
    G(s) H(s) = frac(
        K(tau_a s + 1) (tau_b s + 1) dots (tau_m s + 1),
        s^N (tau_1 s + 1) (tau_2 s+ 1) dots (tau_p s + 1)
    )
$

The error table for different system types and input functions are:
#align(center)[#table(
    align: center,
    columns: 4,
    table.header(
        [*Type of system*],
        [*Step input $(a/s)$*],
        [*Ramp input $(a/s^2)$*],
        [*Parabolic input $(a/s^3)$*],
    ),
    [Type 0], [$1/(1 + K)$], [$oo$], [$oo$],
    [Type 1], [$0$], [$1/K$], [$oo$],
    [Type 2], [$0$], [$0$], [$1/K$],
    [Type 3], [$0$], [$0$], [$0$],
)]

= Process controllers
- Single loop process controllers:
    - On-off
    - Proportional
    - Integral (also called reset and anti-reset windup)
    - Derivative (also called rate)
- Traditionally, they are analogue and pneumatic but today, most of them would
    be digital.
- PLC stands for programmable logic controllers.
- DCS stands for distributed control systems.
- PCS stands for process automation systems, which combine distributed control
    systems (DCS) and programmable logic controllers (PLC).

== Control loops
#cimage("./images/control-loops-block-diagram.png")
- Process, which refers to the system, machine or plant under control.
- Sensors or transducers.
- Controller, e.g. on or off, analogue or digital.
- Final control elements or actuators, like motors and control valves.
    - Pumps, conveyors and blowers, which manipulate the flow of material and
        energy into and out of the process.
    - Automatic control valves, which adjust the flow of material and can also
        change the process pressure, level and temperature.
    - Propellers and thrusters, which manipulate the speed, position and
        orientation of ships and rigs.
    - Motors (AC, DC, stepper), which manipulate mechanical position and the
        speed of machines.

== Instrumentation and control
All branches of engineering and science depend on instrumentation. It extends
human sensing ability by measuring more accurately, rapidly, and over greater
distances. The types of measurement systems are:
- Monitoring of process and operation.
- Control of process and operation.
- Experimental engineering analysis (theoretical and experimental).

== Bridge circuits
- Bridge circuits are commonly used as variable conversion elements in measuring
    systems and produce outputs in the form of voltage levels which changes as
    measured physical quantity changes in value.
- They provide an accurate method of measuring resistance, inductance and
    capacitance values.
- The bridge is excited by:
    - DC voltage for resistance measurements.
    - AC voltage for inductance and capacitance measurements.

#pagebreak()

=== Bridge types
- Null bridge type
    - Mainly employed for calibration purposes.
    - Balancing bridge by using unknown adjustments.
    - Null points measured with highly sensitive galvanometers.
- Deflection bridge type
    - Used with closed loop control systems.
    - Used to determine the magnitude of unbalance from the meter reading.
    - For static inputs, it uses a ordinary meter or galvanometer to measure
        deflection.
    - For dynamic signals, it uses an oscilloscope.
- An important factor in determining the type to use is the bridge sensitivity.
    - For a large change in resistance, use a series arrangement.
    - For a small change in resistance, use a shunt arrangement.

Types of electrical bridge circuits:
#align(center)[#table(
    align: center,
    columns: 2,
    table.header([*Bridge Type*], [*Bridge Features*]),
    [Voltage-sensitive bridge],
    [Readout instrument does not "load" bridge. That means it requires no
        current, like an electronic voltmeter of CRO.],

    [Current-sensitive bridge],
    [Readout requires current, like a low-impedance indicator such as a simple
        galvanometer.],

    [Null balance bridge],
    [Adjustment is required to maintain balance. This becomes the source of the
        readout, like a manually adjusted strain indicator.],

    [Deflection bridge],
    [The readout is a deviation of the bridge output from the initial balance,
        e.g. as required by CRO.],

    [AC bridge], [Alternating current or voltage is used.],
    [DC bridge], [Direct current or voltage is used.],

    [Constant voltage],
    [Voltage input to bridge remains constant, like a battery or
        voltage-regulated power supply.],

    [Constant current],
    [Current input to bridge remains constant regardless of bridge unbalance,
        like a current-regulated power supply.],

    [Resistance bridge],
    [The bridge arms are made up of "pure" resistance elements.],

    [Impedance bridge], [The bridge arms may include reactance elements.],
)]

#cimage("./images/wheatstone-bridge-circuit.png", height: 15em)

== Amplifiers
- Increase low level signals from transducers, like thermocouples, strain gauge
    bridge outputs, to a level sufficient for recording with voltage measuring
    instruments.
- Linear integrated circuits, which are built miniature amplifier circuits which
    can be used directly in a number of applications, often with the addition of
    only a few passive external components (integrated circuit technology).
- In most applications of integrated circuits, a high gain amplifier forms the
    internal amplifier to which passive circuit elements are connected to
    provide an overall amplifier circuit. An example of this are operational
    amplifiers.
- Operational amplifiers are DC differential amplifiers with associated
    components that together operate upon a direct voltage or current.

=== Inverting amplifiers:
- Summing amplifiers, which are the basis of analogue to digital and digital to
    analogue converters.
- Integrating amplifiers which are used for low-pass filters.
- Differentiating amplifiers which are used for high-pass filters.

=== Differential amplifiers:
- These are also called instrumentation amplifiers.
- They are used to handle spurious noise, temporary drifts and power supply
    ripples.
- They are also used to handle math operations.

=== Non-inverting amplifier:
- They are used as unity gain buffer amplifiers to deal with high input
    impedance, also known as a voltage follower.
- They are also used to deal with the limitations of operational amplifiers,
    like input bias, offset current, offset voltage, common mode rejection ratio
    and slewing rate.

== Data acquisition

=== Feedback type
The feedback type uses a closed loop arrangement.
+ Ramp type
    - These can only count up.
    - They are the simplest and can only convert one bit at a time.
+ Tracking type
    - These can count up and down.
    - They do not require sampling and holding (S/H).
+ Successive approximation
    - These require sampling and holding (S/H) to digitise rapidly changing
        analogue signals.
    - The conversion time depends on the number of bits (resolution).
    - For 8 bits, the time taken is #qty[0.8][#sym.mu sec].
+ Simultaneous (parallel)
    - These use flash encoding, making them the fastest.
    - They also do not require sampling and holding (S/H).

#pagebreak()

=== Integrating type
- The integrating type gives repeatable results despite noise by averaging noise
    components.
- They have a longer conversion time, which is a disadvantage.
- However, they have higher accuracy, do not require sampling and holding (S/H),
    and are ideal for slow varying signals.
- Types:
    + Dual slope, an old technique, is used for low-speed and low-cost
        applications.
    + Quantised feedback, a new technique, uses the charge balancing technique.

== Analogue to digital and digital to analogue conversion
The output from the transducer is usually analogue, which varies linearly and
continuously with the quantity being measured. With larger and more complex
instrumentation system, it is often useful to convert this analogue signals to
digital signals so that it can be analysed or processed with computers or
microprocessors.

=== Digital to analogue conversion
+ Binary weighted resistor network, which requires a very large range of
    resistance.
+ R-2R ladder network.

=== Analogue to digital conversion
+ Components consist of comparators, number of registers, control logic and
    digital to analogue converters.
+ Sampling (Shannon sampling theorem), which is an operation performed by a
    sample and hold device (S/H).
+ Quantisation
+ Encoding

=== Converter characteristics
The operating principles and philosophy of the analogue to digital converters
have now been described without much emphasis on limiting constraints or
possible errors.

==== Word length and resolution
The smallest quantum is one least significant bit, which quantified in voltage
(or current) terms as:
$ 1 "LSB" = "Voltage range"/2^n $

Where $n$ is the converter word length.

The resolution of an analogue-to-digital converter with a word length of 8 bits
and an analogue signal input range of #qty[10][V] is:
$ "Resolution" = 10/2^8 = #qty[0.39][V] = #qty[39][mV] $

==== Full scale range (FSR)
The full scale range (FSR) is the maximum positive value (it can be negative for
a negative unipolar converter) the converter represents with all "ones" in its
register. It is given by:
$ "FSR" = "Voltage range" times frac(2^n - 1, 2^n) $

=== Analogue to digital converter
#cimage("./images/analogue-to-digital-converter-image.png")

== Controlled variable range
#cimage("./images/controlled-variable-range.png")

== Two position action control
#cimage("./images/two-position-action-control.png", height: 20em)

- On increasing input, at set point, the controller is activated.
- Controller is deactivated only when the input decreases to the reset point.
- Adjustable dead band, which is a narrow band that can cause system
    oscillation.
- An example of such a control system is the temperature control of a HVAC
    system.

== Proportional control
The proportional band (PB), is the input range where proportional control is
effective.

#stack(
    dir: ltr,
    image("./images/proportional-control.png", width: 50%),
    align(horizon)[#image(
        "./images/proportional-controller-block-diagram.png",
        width: 50%,
    )],
)

- With proportional control, the controller produces a control action that is
    proportional to the error.
- There is a constant gain $K_p$ acting on the error signal $e$ and so:
    $ "Controller output" = K_p e $
- Increasing the gain speeds up the response to changes in inputs, but does not
    eliminate the input offset.

$
    P B = frac(
        "Percentage change in input",
        "Percentage change in output"
    ) times 100%
$
$ K_c = 1/(P B) $

#cimage("./images/proportional-control-effect.png", height: 15em)
#pagebreak()

== Proportional with integral control
#stack(
    dir: ltr,
    spacing: 1em,
    image("./images/proportional-with-integral-control.png", width: 70%),
    image("./images/pi-controller-block-diagram.png", width: 30%),
)
- With proportional with integral (PI) control, the proportional element is
    augmented with an additional element which gives an output proportional to
    the integral of the error with time.
- The proportional element has an input of the error $e$ and an output of
    $K_p e$.
- The integral element has an input of $e$ and an output which is proportional
    to the integral of the error with time, i.e.
    $ K_i integral e thin dif t $

    Where $K_i$ is the integrating gain.
- Thus the controller output:
    $ "Controller output" K_p e + K_i integral e thin dif t $
- In terms of the Laplace transform:
    $ "Controller output" (s) = (K_p + K_i/s) E(s) $
- This can be written as:
    $ "Controller output" (s) = K_p/s (s + 1/T_i) E(s) $

    Where $T_i = K_p/K_i$ and is called the integral time constant.
- The presence of integral control eliminates steady-state offsets and this is
    generally an important feature required in a control system.

$ u(t) = K_c [e(t) + 1/T_i integral_0^t e(t) thin dif t] $

It is used to eliminate steady state error:
- Proportional control has an immediate response.
- Integral control continues even when $e(t)$ becomes 0, because:
    $ dot(u) (t) prop e(t) $

=== Reset windup problem with integral action
#cimage("./images/reset-windup-problem.png")

- $u(t)$ will drop only when it causes $e(t)$ to change sign.
- When $e(t)$ changes sign frequently, we get oscillations.
- If the error is sustained, $u(t)$ may reach maximum value before the error
    changes sign and remains at maximum.
- It can occur after large set-point change, when there is large sustained load
    disturbance or during start-up.

To overcome the problem, the integral output is usually prevented from reaching
its maximum limit by turning off the integral action.

#pagebreak()

== Proportional with derivative control
#stack(
    dir: ltr,
    spacing: 1em,
    align(horizon)[#image(
        "./images/proportional-with-derivative-control.png",
        width: 70%,
    )],
    image("./images/pid-controller-block-diagram.png", width: 30%),
)

$ u(t) = K_c [e(t) + T_d frac(dif e(t), dif t)] $

- With derivative control, the controller produces a control action that is
    proportional to the rate at which the error is changing.
- Derivative control is not used alone but always in conjunction with
    proportional control and, often, also integral control.
- The proportional element has an input of the error $e$ and an output of
    $K_p e$.
- The derivative element has an input of $e$ and an output which is proportional
    to the derivative of the error with time, i.e.
    $ K_d frac(dif e, dif t) $

    Where $K_d$ is the derivative gain.
- Thus the controller output is:
    $ "Controller output" = K_p e + K_d frac(dif e, dif t) $
- In terms of the Laplace transform, we have:
    $ "Controller output" (s) = (K_p + K_d s) E(s) $
- This can be written as:
    $ "Controller output" (s) = K_p (1 + T_d s) E(s) $

    Where $T_d = K_d/K_p$ and is called the derivative time constant.

#pagebreak()

- Derivative control has the controller effectively anticipating the way an
    error signal is growing and responding as the error signal begins to change.
- A problem with this is that noise can lead to quite large responses.
- Adding derivative control to proportional control still leaves the output
    steady-state offset.
- Changing the amount of derivative control in a closed-loop system will change
    the damping ratio since increasing $K_d$ increases the damping ratio.
- The proportional gain follows $e(t)$.
- The derivative control has immediate response as:
    $ u(t) prop dot(e) (t) $
- The graph to the right shows that increasing the derivative gain increases the
    damping ratio, for a step input.
    #cimage("./images/derivative-control-effect.png", height: 20em)

#pagebreak()

== PID controller
#cimage("./images/pid-controller-block-diagram.png", height: 15em)
- PID stands for proportional with integral and derivative control.
- A PID controller is also known as a three-term controller.
- The controller output is:
    $
        "Controller output"
        = K_p e + K_i integral e thin dif t + K_d frac(dif e, dif t)
    $
- Taking the Laplace transform gives:
    $ "Controller output" (s) = K_p (1 + K_i/(K_p s) + K_d/K_p s) E(s) $
- And so:
    $ "Controller output" (s) = K_p (1 + 1/(T_i s) + T_d s) E(s) $
- Processes and equipment are usually maintained at nominal or steady state
    value that is not zero.
- Error is the deviation of controlled variable from the set point.
    $
        u(t) = K_c [e(t) + 1/T_i integral^t e(t) thin dif t
            + T_d frac(dif e(t), dif t)] + macron(u)
    $

    Where:
    - $macron(u)$ is the bias value, which is equal to the nominal or steady
        state value.
- $u(t) = macron(u)$ when $e(t) = 0$

=== Digital PID controller
Position:
#labelled_equation(
    $u(t_i) = K_c[e(t_i) + 1/T_i integral_0^t_i e(t) thin dif t +
        T_d frac(dif e(t_i), dif t)]$,
    1,
)
#labelled_equation(
    $u(t_(i - 1))
    = K_c[e t_(i - 1) + 1/T_i integral_0^t_(i - 1) e(t_(i - 1)) thin dif t
        + T_d frac(dif e(t_(i - 1)), dif t)]$,
    2,
)

Let $Delta t = t_i - t_(i - 1), Delta u_i = u(t_i) - u(t_(i - 1))$, and velocity
is:
$
    (1) - (2): Delta u = K_c [Delta e_i + (e_i frac(Delta T, T_i))
        + T_d/(Delta T) (Delta e_i - Delta e_(i - 1))]
$

== Selecting a controller
#cimage("./images/selecting-a-control-system.png")

== Pneumatic controller
#cimage("./images/pneumatic-controller.png", height: 30em)

The functions of the pneumatic controller are:
- To enable the set point signal to be generated.
- To receive the feedback signal representing the measured level.
- To generate an error signal by comparing the above two signals.
- To amplify the error signal and to incorporate dynamic terms, in generating
    the controller output signal.

== Feedback controller
#cimage("./images/feedback-controller.png")
A very simple example of the use of a feedback controller would be for the
control of the level of liquid in a storage tank, by manipulating the inflow
rate, with outflow rate being a wild variable.

#pagebreak()

== Cascade controller
#cimage("./images/cascade-controller-block-diagram.png", height: 20em)
- The cascade controller is very similar to the feedback controller, only that
    the output from the feedback controller becomes the (variable) set point of
    the cascade controller, so that this set point would not be manually
    adjustable.
- This set point is known as a "remote" set point, as opposed to a "local set
    point", which is set manually.
- The configuration represents a dual loop system, with the outer (major) loop
    having greater authority than the inner (minor) loop.
- The purpose of the inner loop will relate to one or more of the following
    factors, provided that the gain of the loop is made sufficiently high:
    - The closed inner loop, on its own, will have a faster transient response
        than that of the secondary section of the process. This means the speed
        of the response of the outer loop will be increased.
    - The closed inner loop will be relatively insensitive to changes in the
        properties of the secondary section of the process, so that this loop
        becomes an element having stationary properties, as far as the outer
        loop is concerned.
    - The closed inner loop will be relatively linear in its behaviour, despite
        possible departure from linearity in the characteristics of the
        secondary section of the process, with the result that the linearity of
        the outer loop will be enhanced.
    - Parasitic disturbances occurring within the secondary section of the plant
        will have a minimal effect on the output of the primary section of the
        plant process.
- A typical use of a cascade controller is to introduce a minor feedback loop,
    in which the inflow rate is measured and fed to a flow controller.

#cimage("./images/cascade-controller.png", height: 10em)

== Feedforward controller
#cimage("./images/feedforward-controller-block-diagram.png", height: 20em)

- The feedback controller has to attempt to hold the liquid level at the set
    point value, despite changes in the wild variable, the outflow rate $Q_o$.
- If, in a practical case, the controller cannot achieve the desired accuracy,
    then the situation can be relieved by instrumenting the wild variable and
    incorporating a feedforward controller, as shown below:

#cimage("./images/feedforward-controller.png", height: 15em)
#pagebreak()

= System types

== Closed-loop system
#cimage("./images/closed-loop-system-with-labels.png")

Objective: Design $G_c (s)$ to achieve the *desired steady-state errors and
    poles* for closed-loop transfer function.

To make $c(t)$ stable, control its:
+ Steady-state error
+ Transient response

== Unity feedback systems
#cimage("./images/unity-feedback-system-block-diagram.png")

$G(s)$ is the Open loop transfer function.
$ E = R - C $
$ C = G E $
$ C = G(R - C) $
$ C(1 + G) = G R $
$ C/R = G/(1 + G) $

#pagebreak()

== System Type
$G(s)$ is the open-loop transfer function for unity feedback system.
$
    G(s) = frac(
        K(T_a s + 1) (T_b s + 1) dots.c (T_m s + 1),
        S^N (T_1 s + 1) (T_2 s + 1) dots.c (T_p s + 1)
    )
$

- $G(s)$ is a Type $N$ system, where $N$ can be 0, 1, 2, etc.
- The system type is the power of $s$ in the denominator.

When $N$ increases, and is used to make a closed-loop system, the *steady state
    error decreases*, which is *desirable*, but *stability also decreases*,
which is *undesirable*.

Hence, $N$ is a *trade-off* between steady-state error and stability.

== Steady-state error ($e_(s s)$)
$ "Transfer function": C/R = G/(1 + G) $
$ E = R - C $
$ E = R - C/R R $
$ E = R(1 - G/(1 + G)) $
$ E(s) = R/(1 + G) $

Computing the steady-state error $e_(s s)$ via the final value theorem:
$
    e_(s s) & = lim_(t -> oo) e(t) \
            & = lim_(s -> 0) s E(s) \
            & = lim_(s -> 0) frac(s R(s), 1 + G(s))
$

#pagebreak()

== Step input error ($e_(s s)$)
$ "General formula": e_(s s) = lim_(s -> 0) frac(s R, 1 + G) $
$
    "For step input": R = 1/s quad -> quad e_(s s)
    = lim_(s -> 0) s/(1 + G) dot 1/s = mathred(1/(1 + G(s = 0)))
$

We define $K_p$ to be the *static position error constant*, such that:
$ K_p = lim_(s -> 0) G(s) = G(s = 0) $

Using this definition, the step input error ($e_(s s)$) can be expressed as:
$ e_(s s) = 1/(1 + K_p) $

=== $K_p$ vs system types

==== Type 0 systems
$
    & K_p = lim_(s -> 0) frac(
          K (T_a s + 1) (T_b s + 1) dots.c,
          (T_1 s + 1) (T_2 s + 1) dots. c
      ) = K \
    & -> quad e_(s s) = 1/(1 + K_p) = 1/(1 + K)
      quad #text(red)[(Non-zero error)]
$

==== Type 1 or higher systems
$
    & K_p = lim_(s -> 0) frac(
          K (T_a s + 1) (T_b s + 1) dots.c,
          s^N (T_1 s + 1) (T_2 s + 1) dots. c
      ) -> oo, quad "for" N >= 1 \
    & -> quad e_(s s) = 1/(1 + K_p) \
    & -> quad e_(s s) = 0
      quad #text(red)[(Steady-state error eliminated)]
$

==== Summary
For *step inputs*, the steady state error $e_(s s)$:
+ Type 0 systems:
    $ e_(s s) = 1/(1 + K) quad "(Non-zero value)" $
    $e_(s s)$ decreases as $K$ increases.
+ Type 1 or higher systems
    $ e_(s s) = 0 quad #text(red)[(Steady-state error eliminated)] $
    Requires at least *one integrator* in the forward path.

#pagebreak()

== Ramp input error ($e_(s s)$)
$ "General formula": e_(s s) = lim_(s -> 0) frac(s R, 1 + G) $
$
    "For ramp input": R = 1/s^2 quad -> quad e_(s s)
    = lim_(s -> 0) s/(1 + G) dot 1/s^2 = mathred(1/(lim_(s -> 0) s G))
$

We define $K_v$ to be the *static velocity error constant*, such that:
$ K_v = lim_(s -> 0) s G(s) $

Using this definition, the ramp input error ($e_(s s)$) can be expressed as:
$ e_(s s) = 1/(1 + K_v) $

=== $K_v$ vs system types

==== Type 0 systems
$
    & K_v = lim_(s -> 0) frac(
          s K (T_a s + 1) (T_b s + 1) dots.c,
          (T_1 s + 1) (T_2 s + 1) dots. c
      ) = 0 \
    & -> quad e_(s s) = 1/(K_v) -> oo
      quad #text(red)[(Can't follow input)]
$

==== Type 1 systems
$
    & K_v = lim_(s -> 0) frac(
          s K (T_a s + 1) (T_b s + 1) dots.c,
          s(T_1 s + 1) (T_2 s + 1) dots. c
      ) = K \
    & -> quad e_(s s) = 1/(K)
      quad #text(red)[(Non-zero-error)]
$

==== Type 2 and higher systems
$
    & K_v = lim_(s -> 0) frac(
          s K (T_a s + 1) (T_b s + 1) dots.c,
          s^N (T_1 s + 1) (T_2 s + 1) dots. c
      ) -> oo, quad "for" N >= 2 \
    & -> quad e_(s s) = 0
      quad #text(red)[(Steady-state error eliminated)]
$

==== Summary
For *ramp inputs*, the steady-state error $e_(s s)$:
+ Type 0 systems:
    $ e_(s s) = 0 quad "(Can't follow ramp input)" $
+ Type 1 systems:
    $ e_(s s) = 1/K_v quad "(Non-zero value)" $
    $e_(s s)$ decreases as $K_v$ increases.
+ Type 2 or higher systems:
    $ e_(s s) = 0 quad #text(red)[(Steady-state error eliminated)] $

#pagebreak()

== Unit parabolic input error ($e_(s s)$)
$ "General formula": e_(s s) = lim_(s -> 0) frac(s R, 1 + G) $
$
    "For ramp input": R = 1/s^3 quad -> quad e_(s s)
    = lim_(s -> 0) s/(1 + G) dot 1/s^3 = mathred(1/(lim_(s -> 0) s^2 G))
$

We define $K_a$ to be the *static acceleration error constant*, such that:
$ K_v = lim_(s -> 0) s^2 G(s) $

Using this definition, the parabolic input error ($e_(s s)$) can be expressed
as:
$ e_(s s) = 1/(1 + K_a) $

=== $K_a$ vs system types

==== Type 0 systems
$
    & K_a = lim_(s -> 0) frac(
          s^2 K (T_a s + 1) (T_b s + 1) dots.c,
          (T_1 s + 1) (T_2 s + 1) dots. c
      ) = 0 \
    & -> quad e_(s s) = 1/(K_v) -> oo
      quad #text(red)[(Can't follow input)]
$

==== Type 1 systems
$
    & K_a = lim_(s -> 0) frac(
          s^2 K (T_a s + 1) (T_b s + 1) dots.c,
          s(T_1 s + 1) (T_2 s + 1) dots. c
      ) = 0 \
    & -> quad e_(s s) = 1/(K_a) -> oo
      quad #text(red)[(Can't follow input)]
$

==== Type 2 systems
#grid(
    columns: 2,
    align: horizon,
    column-gutter: 2em,
    $
        & K_a = lim_(s -> 0) frac(
              s K (T_a s + 1) (T_b s + 1) dots.c,
              s^2 (T_1 s + 1) (T_2 s + 1) dots. c
          ) = K \
        & -> quad e_(s s) = 1/(K)
          quad #text(red)[(Non-zero-error)]
    $,
    image("./images/parabolic-response-of-a-type-2-system.png", height: 20em),
)


==== Type 3 and higher systems
$
    & K_a = lim_(s -> 0) frac(
          s K (T_a s + 1) (T_b s + 1) dots.c,
          s^N (T_1 s + 1) (T_2 s + 1) dots. c
      ) -> oo, quad "for" N >= 3 \
    & -> quad e_(s s) = 0
      quad #text(red)[(Steady-state error eliminated)]
$

==== Summary
For *parabolic inputs*, the steady-state error $e_(s s)$:
+ Type 0 and 1 systems:
    $ e_(s s) -> oo "(Can't follow parabolic input)" $
+ Type 2 systems:
    $ e_(s s) = 1/K_a quad "(Non-zero value)" $
    $e_(s s)$ decreases as $K_a$ increases.
+ Type 3 or higher systems:
    $ e_(s s) = 0 quad #text(red)[(Steady-state error eliminated)] $

== Steady-state error ($e_(s s)$) summary
#table(
    columns: 4,
    align: center + horizon,
    table.header(
        table.cell(rowspan: 2)[*System Types*],
        table.cell(colspan: 3)[*Steady-state Error ($e_(s s)$)*],
        [Unit step input], [Unit ramp input], [Unit parabolic input],
    ),

    [Type 0], $ 1/(1 + K_p) $, $ oo $, $ oo $,
    [Type 1], $ 0 $, $ 1/K_v $, $ oo $,
    [Type 2], $ 0 $, $ 0 $, $ 1/K_a $,
    [Type 3], $ 0 $, $ 0 $, $ 0 $,
)

The table above increases in system "level" going down, and increases in input
"level" going right.
- Input "level" *higher than* system "level":
    $ e_(s s) -> oo $
- Input "level" *equal to* system "level":
    $ e_(s s) "is non-zero" $
- Input "level" *lower than* system "level":
    $ e_(s s) = 0 $

Thus:
- *Steady-state errors* are related to $K_p, K_v$ and $K_a$.
- *Increasing system type* requires an *integrator* in the forward path, but
    this will have a *destabilising effect*.
- Designing a *stable-system* with *more than two integrators* in the forward
    path is *generally difficult*.

= Root locus

== Closed loop system
#cimage("./images/closed-loop-system-purpose.png")

== Root Locus
Using a *proportional controller*, like $"controller" = K$:
#cimage("./images/root-locus-closed-loop-system.png")

The root locus is the *trajectory* of the closed-loop *system's poles* as $K$
varies *from zero to infinity*.

=== Illustration
#cimage("./images/root-locus-illustration.png")
#pagebreak()

== Recap on complex numbers
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        $ sigma + j omega = r e^(j theta) $

        Where:
        - $r = sqrt(sigma^2 + omega^2)$
        - $theta = arctan omega/sigma$

            $
                frac(sigma_1 + j omega_1, sigma_2 + j omega_2)
                &= frac(r_1 e^(j theta_1), r_2 e^(j theta_2)) \
                &= underbrace(r_1/r_2, "Magnitude") e^(j underbrace(
                    (theta_1 - theta_2),
                    "Phase"
                ))
            $
    ],
    image("./images/complex-plane.png", height: 20em),
)

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        $ s + z = r_z e^(j theta_z) $
        Where $r_z = |s + z|$.

        $ s + p = r_p e^(j theta_p) $
        Where $r_p = |s + p|$.

        $
            frac(s + z, s + p)
            = underbrace(frac(r_z, r_p), "Magnitude")
            e^(j underbrace((theta_z - theta_p), "Phase"))
        $
    ],
    image("./images/complex-plane-addition.png", height: 20em),
)

#pagebreak()

== Characteristic equation (CE)
#cimage("./images/root-locus-characteristic-equation-diagram.png")
$ C(s)/R(s) = frac(K G(s), 1 + K G(s) H(s)) $

Characteristic equation (CE):
$ 1 + K G(s) H(s) = 0 $

For a given $K$, *any $s$ that satisfies the characteristic equation* will be a
*closed-loop pole*.

When $K$ varies, the location of the closed-loop poles changes. The *root locus
    represents the trajectory of the closed-loop poles*.

== Required conditions
Characteristic equation (CE):
$ 1 + K G(s) H(s) = 0 $
$
    K N(s)/D(s) = K frac(
        (s + z_1) (s + z_2) dots.c (s + z_m),
        (s + p_1) (s + p_2) dots.c (s + p_n)
    ) = 1 e^(plus.minus j (pi plus.minus 2 q pi))
$
$ K N(s)/D(s) = 1e^(plus.minus j(pi plus.minus 2 q pi)) $
$
    [K |N(s)/D(s)|] e^(j (angle N - angle D))
    = 1 e^(plus.minus j(pi plus.minus 2 q pi))
$

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    [
        Magnitude condition:
        $ K|N(s)/D(s)| = 1 $
    ],
    [
        Phase condition:
        $ angle N - angle D = - pi - 2 q pi $
        $ angle N - angle D = -(1 + 2q) pi $
    ],
))

== Starting and ending points
#cimage("./images/root-locus-characteristic-equation-diagram.png")

Characteristic equation (CE):
$ "CE": 1 + K N(s)/D(s) = 0 $
$ D(s) + K N(s) = 0 $

Smallest $K$, like $K = 0$:
$ "CE": D(s) + K N(s) = 0 quad -> quad D(s) = 0 $
Solution shows that *closed-loop poles* are equal to *open-loop poles*.

Largest $K$, like $K -> oo$:
$ "CE": D(s) + K N(s) = 0 quad -> quad N(s) = 0 $
Solution shows that *closed-loop poles* are equal to *open-loop zeros*.

#pagebreak()

== Infinite open-loop zeros
$
    1 + K frac(
        (s + z_1) (s + z_2) dots.c (s + z_m),
        (s + p_1) (s + p_2) dots.c (s + p_n)
    ) = 0
$
$
    K frac(
        (s + z_1) (s + z_2) dots.c (s + z_m),
        (s + p_1) (s + p_2) dots.c (s + p_n)
    ) = 1e^(-j pi (1 + 2q))
$

In general, when $m <= n$, some *closed-loop poles* end at infinite open-loop
zeros.

$
    lim_(s -> oo) K(frac(
            (s + z_1) (s + z_2) dots.c (s + z_m),
            (s + p_1) (s + p_2) dots.c (s + p_n)
        )) = 1 e^(-j pi (1 + 2q)
$

$ lim_(s -> oo) K(s^m/s^n) = 1e^(-j pi(1 + 2q)) $
$ lim_(s -> oo) K(s)^(m - n) = 1e^(-j pi(1 + 2q)) $
$ lim_(s -> oo) K(|s| e^(j angle s))^(m - n) = 1e^(-j pi(1 + 2q)) $

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        Magnitude condition:
        $ K(|s|)^(m - n) = 1 $
    ],
    [
        Phase condition:
        $ (m - n) angle s = - pi (1 + 2q) $
        $ angle s = frac(pi(1 + 2q), n - m) $
    ],
))

== Physical interpretation
*Phase condition at $s -> oo$*:
$ angle s = frac(pi (1 + 2q), n - m), quad q = 0, dots, n - m - 1 $

$angle s$ represents the *asymptote angle*.

It is required to substitute $q$ with $|n - m|$ number of integer values.

The asymptote location on the real axis is:
$ sigma_a = frac(sum_i^n (- p_i) - sum_j^m (- z_j), n - m) $

=== Example
#cimage("./images/root-locus-physical-interpretation-example.png", height: 30em)

$ 1 + K frac(s + z_1, (s + p_1) (s + p_2) (s + p_3)) = 0 $
$ m = 1, quad n = 3 $

*Asymptote formula*:
$
    sigma_a = frac(sum_i^n (-p_i) - sum_j^m (-z_j), n - m), quad
    angle s = frac(pi(1 + 2q), n - m)
$
$ m = 1, quad n = 3 $
$
    sigma_a = frac(sum_i^3 (-p_i) + z_1, 3 - 1), quad
    angle s = frac(pi(1 + 2q), 3 - 1)
$
$ angle s = pi/2 + q pi, quad q = 0, 1 $
$ angle s = pi/2, (3pi)/2 $

#pagebreak()

== Locus on the real axis
*Phase condition*:
$
    angle frac(
        (s + z_1) (s + z_2) dots.c (s + z_m),
        (s + p_1) (s + p_2) dots.c (s + p_n)
    ) = plus.minus pi
$
$
    underbrace(
        sum_(i = 1)^m angle (s + z_i),
        "Angle contributions for all open-loop zeros"
    ) - underbrace(
        sum_(j = 1)^n angle (s + p_j),
        "Angle contributions from all open-loop poles"
    )
    = plus.minus pi
$

*Ignore complex open-loop poles or zeros*. Conjugate pairs cancel their angle
contributions.

=== Region 1
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/root-locus-on-the-real-axis-region-1.png"),
    [
        *Phase condition*:
        $
            angle frac(
                (s + z_1) (s + z_2) dots.c (s + z_m),
                (s + p_1) (s + p_2) dots.c (s + p_n)
            ) = plus.minus pi
        $
        $ angle (s + z_i) = angle (s + p_j) = 0 $

        For region 1, the left hand side angles are 0, which is not equal to
        $plus.minus pi$, hence there is *no locus* in region 1.
    ],
)

=== Region 2
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/root-locus-on-the-real-axis-region-2.png"),
    [
        *Phase condition*:
        $
            angle frac(
                (s + z_1) (s + z_2) dots.c (s + z_m),
                (s + p_1) (s + p_2) dots.c (s + p_n)
            ) = plus.minus pi
        $

        For region 2, vectors for all the #sym.times and #sym.circle that are on
        the left of #sym.star produce:
        $ angle(s + z_2) = angle(s + p_1) = angle(s + p_2) = 0 $

        Only vector $angle(s + z_1) = pi$, so for region 2, the left hand side
        angles are #sym.pi, hence there is *a locus* in region 2.
    ],
)

=== Region 3
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/root-locus-on-the-real-axis-region-3.png"),
    [

        *Phase condition*:
        $
            angle frac(
                (s + z_1) (s + z_2) dots.c (s + z_m),
                (s + p_1) (s + p_2) dots.c (s + p_n)
            ) = plus.minus pi
        $

        2 vectors on the right of #sym.star produce angles of $pi$:
        $ angle(s + z_1) = angle(s + p_1) = pi $

        Net phase on the left hand side angles is 0, which is not equal to
        $plus.minus pi$, hence there is *no locus* in region 3.
    ],
)

=== Region 4
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/root-locus-on-the-real-axis-region-4.png"),
    [
        *Phase condition*:
        $
            angle frac(
                (s + z_1) (s + z_2) dots.c (s + z_m),
                (s + p_1) (s + p_2) dots.c (s + p_n)
            ) = plus.minus pi
        $

        3 vectors on the right of #sym.star produce angles of $pi$:
        $ angle(s + z_2) = angle(s + z_1) = angle(s + p_1) = pi $

        Net phase on the left hand side angles is $plus.minus pi$, hence there
        is *a locus* in region 4.
    ],
)

=== Overall
*Phase condition*:
$
    angle frac(
        (s + z_1) (s + z_2) dots.c (s + z_m),
        (s + p_1) (s + p_2) dots.c (s + p_n)
    ) = plus.minus pi
$

Regions with *an odd number* of #sym.times and #sym.circle that are *on the
    right of* #sym.star will satisfy the phase condition.

== Break-out points
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 2em,
    align: horizon,
    image("./images/root-locus-break-out-points-1.png"),
    [
        Using the characteristic equation:
        $ "CE": 1 + K frac(s + 5, (s + 1)(s + 2)(s + 3)) = 0 $

        Finding the asymptote:
        $ "Angle": angle s = frac(pi (1 + 2q), 3 - 1) $
        $ angle s = pi/2, 3pi/2, quad q = 0, 1 $
        $ "Location": sigma_a = frac((-1 - 2 -3) - (-5), 3 - 1) = - 0.5 $
    ],

    grid.cell(colspan: 2)[
        $ K = - frac((s + 1) (s + 2) (s + 3), s + 5) $
        $ frac(dif K, dif s) = 0 quad "(max point)" $
        $
            -> s = -1.45, underbrace(
                -2.62\, -6.42,
                "rejected because they are not on locus"
            )
        $

    ],

    image("./images/root-locus-break-out-points-2.png"),
    image("./images/root-locus-break-out-points-3.png"),
)

== Break-in points
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 2em,
    align: horizon,
    image("./images/root-locus-break-in-points-1.png"),
    [
        Using the characteristic equation:
        $ 1 + K frac(s + 3, (s + 1) (s + 2)) = 0 $

        *Asymptote*:
        $ "Angle": angle s = frac(pi (1 + 2q), 2 - 1) $
        $ angle s = pi, quad q = 0 $
        $ "Location": sigma_a = frac((-1 - 2) - (-3), 2 - 1) = 0 $
    ],

    image("./images/root-locus-break-in-points-2.png"),
    [
        $ K = - frac((s + 1) (s + 2), (s + 3)) $
        $ frac(dif K, dif s) = 0 quad "(maximum and minimum point)" $
        $ -> s = -1.58 quad "[Break-out point (maximum point)] or" $
        $ -> s = -4.41 quad "[Break-in point (minimum point)]" $
    ],
)

== Departure angles
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 2em,
    align: horizon,
    image("./images/root-locus-departure-angles-1.png"),
    [
        Using the characteristic equation:
        $ "CE": 1 + K frac(s + 4, (s + 1) (s + 1 + j) (s + 1 - j)) = 0 $

        *Asymptote*:
        $ "Angle": angle s = frac(pi (1 + 2q), 3 - 1) $
        $ angle s = pi/2, 3pi/2, quad q = 0, 1 $
        $ "Location": sigma_a = frac((-1 - 1 - 1) - (-4), 3 - 1) = 0.5 $
    ],

    image("./images/root-locus-departure-angles-2.png"),
    [
        $ K = - frac((s + 1) (s + 1 + j) (s + 1 - j), s + 4) $
        $ frac(dif K, dif s) = 0 $

        No break-out points.
    ],

    // Spacer
    [#v(10em)], [],

    grid.cell(colspan: 2)[
        $ "CE": 1 + K frac(s + 4, (s + 1) (s + 1 + j) (s + 1 - j)) = 0 $
        $
            "Phase": sum_(i = 1)^(m = 1) angle (s + z_i)
            - sum_(j = 1)^(n = 3) angle (s + p_j) = plus.minus pi
        $
        $ arctan (1/3) - pi/2 -pi/2 - alpha = - pi $
        $ alpha = arctan (1/3) $
    ],

    image("./images/root-locus-departure-angles-3.png"),
    image("./images/root-locus-departure-angles-4.png"),
)

== Intersection of imaginary axis
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 2em,
    align: horizon,
    image("./images/root-locus-intersection-of-imaginary-axis.png"),
    [
        Using the characteristic equation (CE):
        $ "CE": 1 + K frac(s + 4, (s + 1) (s + 1 + j) (s + 1 - j)) = 0 $
        $ s^3 + 3s^2 + (4 + K)s + (2 + 4K) = 0 $

        #text(red)[Substituting $s = j omega$:]
        $ (j omega)^3 + 3(j omega)^2 + (4 + K) j omega + (2 + 4K) = 0 $
        $ j omega^3 + 3omega^2 + (4 + K) j omega + (2 + 4K) = 0 $
        $
            underbrace((-3 omega^2 + (2 + 4K)), "Real part")
            + underbrace(j((4 + K) omega - omega^3), "Imaginary part") = 0
        $
        $ K = 10, quad omega = sqrt(14) $
    ],
)

#pagebreak()

== Arrival angles
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 2em,
    align: horizon,
    image("./images/root-locus-arrival-angles-1.png", height: 23em),
    [
        Using the characteristic equation:
        $ "CE": 1 + K frac((s + 1 + j) (s + 1 - j), (s + 1) (s + 5)) = 0 $
        $ K = - frac((s + 1) (s + 5), (s + 1 - j) (s + 1 + j)) $
        $ frac(dif K, dif s) = 0 $
        $ -> s = -1.78 quad "(maximum point)" $

        $s = -1.78$ is a *break-out point*.
    ],

    grid.cell(colspan: 2)[
        $
            "Phase": sum_(i = 1)^m angle(s + z_i)
            - sum_(j = 1)^n angle(s + p_j) = plus.minus pi
        $
        $ pi/2 + alpha - pi/2 - arctan(1/4) = pi $
        $ alpha = pi + arctan(1/4) $
    ],

    image("./images/root-locus-arrival-angles-2.png"),
    image("./images/root-locus-arrival-angles-3.png"),
)

== Summary
+ Starting and ending points of the locus
    #enum(
        numbering: "a.",
        [Starting points - *open loop poles*],
        [Ending points - *open loop zeroes*],
    )
+ Asymptotes (*infinite open-loop zeros*)
    #enum(
        numbering: "a.",
        [Angles],
        [Location],
    )
+ Locus on real axis
+ Break-in and break-out points
    #enum(
        numbering: "a.",
        [Break-in (*minimum $K$*)],
        [Break-out (*maximum $K$*)],
    )
+ Departure and arrival angles
+ Imaginary axis intersection

= Root locus controller design

== Root locus
#cimage("./images/root-locus-characteristic-equation-diagram.png")
$ C(s)/R(s) = frac(K G(s), 1 + K G(s) H(s)) $

Characteristic equation (CE):
$ "CE": 1 + K G(s) H(s) = 0 $

Root locus shows how the closed-loop poles change for $0 < K < oo$. We can also
use the *root locus* technique if the controller is not equal to $K$.

#pagebreak()

== Basic controllers

=== PD controller
Time domain:
$ a = K_p e + K_D frac(dif e, dif t) $

Laplace domain:
$
    A & = K_p E + K_D s E \
      & = E underbrace((K_p + K_D s), G_c "for PD")
$

Equation:
$ K_D s + K_p = K_D (s + underbrace(K_p/K_D, z_c)) $

$K_D$ and $z_c$ change closed-loop poles.

#cimage("./images/pd-controller-root-locus.png")
#pagebreak()

=== PI controller
Time domain:
$ a = K_p e + K_I integral_0^t e thin dif t $

Laplace domain:
$
    A & = K_p E + K_I/s E \
      & = E underbrace((K_p + K_I/s), G_c "for PI")
$

Equation:
$ K_p + K_I/s = K_p frac((s + K_I/K_p), s) $

PI controller eliminates steady-state error.

#cimage("./images/pi-controller-root-locus.png")

#pagebreak()

=== Comparison
#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    [
        *PD controller*:

        Increase speed and stability.

        Deals with the *transient response*.
    ],
    [
        *PI controller*:

        Eliminates steady-state error $e_(s s)$.

        Deals with the *steady-state response*.
    ],
))

#table(
    columns: 4,
    align: center + horizon,
    table.header(
        diagbox()[*Properties*][*Controllers*],
        [$K_p$ #linebreak() Proportional],
        [$K_D s$ #linebreak() Derivative],
        [$K_I/s$ #linebreak() Integral],
    ),

    [Stability], sym.arrow.b, sym.arrow.t, sym.arrow.b,
    [Steady-state error ($e_(s s)$)], sym.arrow.t, [---], sym.arrow.t,
    [Speed], sym.arrow.t, sym.arrow.t, sym.arrow.b,
    [Disturbance rejection], sym.arrow.t, [---], sym.arrow.b,

    [Noise rejection], [---], sym.arrow.b, sym.arrow.t,
)

Legend:
- #sym.arrow.t Good
- --- Neutral
- #sym.arrow.b Bad

== Improving transient response

=== Design of PD controllers
#cimage("./images/pd-controller-design-block-diagram.png")

- Closed loop poles define the transient response.
- The aim is to find $K_p$ and $K_D$ to achieve the desired closed-loop poles.

=== General steps
+ Determine the *desired closed-loop poles*.
+ Express the *characteristic equation* of the *closed-loop transfer function*
    in terms of *$K_p$ and $K_D$*.
+ *Substitute* the poles into the *characteristic equation*.
+ Solve the *real and imaginary parts* of the characteristic equation to obtain
    the *required $K_p$ and $K_D$*.

=== Example
#cimage("./images/pd-controller-design-example.png")

==== Step 1
Determine the *desired closed-loop poles*.

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    [
        #underline[Criterion 1: 10% overshoot]
        $ e^(- frac(pi zeta, sqrt(1 - zeta^2))) = 0.1 $
        $ - frac(pi zeta, sqrt(1 - zeta^2)) = ln 0.1 $
        $ zeta = sqrt(frac((ln 0.1)^2, (ln 0.1)^2 + pi^2)) = 0.59 $
    ],
    [
        #underline[Criterion 2: 2% settling time]
        $ 4/(zeta omega_n) = 0.5 $
        $ 4/(0.59 omega_n) = 0.5 $
        $ omega_n = frac(4, (0.59) (0.5)) = 13.5 $
    ],
))

*Desired poles*:
$
    s = - zeta omega_n plus.minus j omega_n sqrt(1 - zeta^2)
    approx - 8 plus.minus 11 j
$

==== Step 2
Express the *characteristic equation* of the *closed-loop transfer function* in
terms of *$K_p$ and $K_D$*.
$
    G_(c l) = frac(
        frac(K_p + K_D s, s^2 + 2s + 2),
        1 + frac(K_p + K_D s, s^2 + 2s + 2)
    ) = frac(K_p + K_D s, s^2 + 2s + 2 + K_p + K_D s)
$
$ G_(c l) = frac(K_p + K_D s, s^2 + (2 + K_D)s + (2 + K_p)) $

*Characteristic equation*:
$ s^2 + (2 + K_D)s + (2 + K_p) = 0 $

#pagebreak()

==== Step 3
*Substitute* the poles into the *characteristic equation*:
$ "Desired poles": s = -8 plus.minus 11j $
$ "Characteristic equation": s^2 + (2 + K_D)s + (2 + K_p) = 0 $
$ (-8 + 11j)^2 + (2 + K_D) (-8 + 11j) + (2 + K_p) = 0 $
$ (-71 + K_p - 8 K_D) + j (11 K_D - 154) = 0 $
#labelled_equation($bold("Real part"): -71 + K_p - 8 K_D = 0$, 1)
#labelled_equation($bold("Complex part") 11 K_D - 154 = 0$, 2)

==== Step 4
Solve the *real and imaginary parts* of the characteristic equation:
$ K_D = 14, quad K_p = 183 $
$ K_p + K_D s = 183 + 14s = 14(s + 13.1) $

==== Root locus
#cimage("./images/pd-controller-design-example.png")
$ K_p + K_D s = 14(s + 13.1) $
$ bold("Desired poles"): s = -8 plus.minus 11j $

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    [
        *P controller characteristic equation*:
        $ 1 + frac(K_p, s^2 + 2s + 2) = 0 $

        *PD controller characteristic equation*:
        $ 1 + frac(K_D (s + 13.1), s^2 + 2s + 2) = 0 $
    ],
    image("./images/pd-controller-design-example.png"),
)

#pagebreak()

=== Drawbacks of PD controllers
- Cannot be realised with passive components.
- Sensitive to high frequency noise.
$ "PD controller": G_c = K_D s + K_p = K_D (s + z_c) $
$ "Noise amplification": lim_(omega -> oo) |G_c (s = j omega)| $
#align(center)[Alternative controller: *Lead compensator*]

=== Lead compensator
#cimage("./images/lead-compensator-block-diagram.png")
$ G_c = K frac(s + z_c, mathred(s + p_c)) $
$
    "Noise amplification" & : lim_(omega -> oo) | G_c (s = j omega) | \
                          & = lim_(omega -> oo) | frac(
                                K(j omega + redcancel(z_c)),
                                (j omega + redcancel(p_c))
                            ) \
                          & = lim_(omega -> oo) | frac(K (j omega), j omega) | \
                          & = K
$

The lead compensator has finite amplification, which is *better than the PD
    controller*.

=== Designing the lead compensator
#cimage("./images/lead-compensator-design-block-diagram.png")

*3 unknowns*:
$ K, z_c, p_c $
$ p_c > z_c $

#pagebreak()

=== General steps
+ Design the desired transient response with a PD controller.
    $ K_D s + K_p = K_D (s + z'_c) $
+ Using the obtained PD controller, specify a value of $z_c$ such that:
    $ z_c < z'_c $
+ *Use* the *characteristic equation to determine*:
    $ K, p_c $

=== Example
#cimage("./images/lead-compensator-example.png")

*Desired poles*:
$ s = -8 plus.minus 11 j $

==== Step 1
Design the desired transient response with a PD controller:
$ K_D s + K_p = 14(s + 13.1) = K_D (s + z'_c) $

==== Step 2
Use the obtained PD controller to specify a value of $z_c$ such that:
$ z_c < z'_c $
$ z_c = 10 $

$ bold("Lead compensator"): K frac(s + 10, s + p_c) $

#pagebreak()

==== Step 3
Use the characteristic equation to determine $K$ and $p_c$
$ bold("Characteristic equation"): 1 + G_c G = 0 $
$ 1 + K frac(s + 10, s + p_c) (1/(s^2 + 2s + 2)) = 0 $
$ (s + p_c) (s^2 + 2s + 2) + K(s + 10) = 0 $
$ s^3 + (2 + p_c) s^2 + (2 + 2p_c + K)s + (10 K + 2p_c) = 0 $

Substituting $s = -8 plus 11j$ into the equation:
$ (2K - 71 p_c + 2262) + j (-154 p_c + 451 + 11K) = 0 $
$ "Real part": 2 K - 71 p_c + 2262 = 0 $
$ "Imaginary part": -154 p_c + 451 + 11K = 0 $

Solving:
$ K = 669 $
$ p_c = 50.7 $

$ G_c = 669 frac(s + 10, s + 50.7) $

#pagebreak()

==== S-plane for PD controller
#cimage("./images/pd-controller-s-plane-block-diagram.png")

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    [
        *Desired poles*:
        $ s = -8 plus.minus 11 j $

        *PD controller characteristic equation*:
        $ 1 + frac(14(s + 13.1), s^2 + 2s + 2) = 0 $
        $ 14 frac(s + 13.1, s^2 + 2s + 2) = 1 e^(j pi) $
        $ angle frac(s + 13.1, s^2 + 2s + 2) = pi $
        $ angle(s + 13.1) - angle (s^2 + 2s + 2) = pi $

        *Phase condition*:
        $ alpha - beta_1 - beta_2 = pi $
    ],
    image("./images/pd-controller-s-plane-graph.png"),
)

#pagebreak()

==== S-plane for lead compensator
#cimage("./images/lead-compensator-s-plane-block-diagram.png")

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    [
        *Desired poles*:
        $ s = -8 plus.minus 11 j $

        *Lead compensator characteristic equation*:
        $
            1 + (frac(
                    mathred(669) mathblue((s + 10)),
                    s + 50.7
                )) (1/(s^2 + 2s + 2)) = 0
        $
        $ angle frac(mathblue(s + 10), mathred(s + 50.7)) = pi $
        $
            mathblue(angle(s + 10)) - angle (s^2 + 2s + 2)
            - mathred(s + 50.7) = pi
        $
        $ mathblue(alpha_"new" > alpha) $

        *Phase condition*:
        $ mathblue(alpha_"new") - beta_1 - beta_2 - mathred(beta_3) = pi $
    ],
    image("./images/lead-compensator-s-plane-graph.png"),
)

== Improving steady-state response

=== Design of PI controllers
- The aim is to upgrade the system type.
- A PI controller can be implemented if having a transient response is fine.

Note that:
$
    K_p + K_I/s & = frac(K_p (s + K_I/K_p), s) \
                & = K_p underbrace(
                      frac(s + z_c, s),
                      "Pole-zero cancellation"
                  ), quad "if" z_c "is small"
$

The transient response is slightly affected.

==== Example: Root locus
#cimage("./images/pi-controller-example-block-diagram.png")

#align(center)[
    *Characteristic equation for $K_p$ controller*:
    $ 1 + K_p (frac(s + 5, (s + 8) (s + 10)^2)) = 0 $

    *Characteristic equation for $K_I$ controller*:
    $
        1 + K_p underbrace((frac(s + 0.5, s)), "PI Controller")
        (frac(s + 5, (s + 8) (s + 10)^2)) = 0
    $
]

#grid(
    columns: 2,
    column-gutter: 2em,
    image("./images/pi-controller-example-root-locus-1.png"),
    image("./images/pi-controller-example-root-locus-2.png"),
)

#align(center)[The root locus does not change much.]

=== Drawbacks of PI controllers
- Cannot be realised with passive components.
- Alternative controller: *Lag compensator*.

#pagebreak()

=== Lag compensator
#cimage("./images/lag-compensator-block-diagram.png")

The objective is to enhance position error constant $K_p$.
$
    K_p & = lim_(s -> 0) G_c G \
        & = lim_(s -> 0) K frac(redcancel(s) + z_c, redcancel(s) + p_c) G_s \
        & = K z_c/p_c G(0)
$
$ e_(s s) = 1/(1 + K_p) $

As the $K z_c/p_c$ factor increases, the value of $K_p$ increases and the
steady-state error ($e_(s s)$) decreases. The error reduces, but is not fully
eliminated.

#pagebreak()

==== Example: Root locus
#cimage("./images/lag-compensator-example-block-diagram.png")

$ e_(s s) = 1/(1 + K_p) $

When the $K_p$ increases, the steady-state error ($e_(s s)$) decreases.

#cimage("./images/lag-compensator-example-root-locus.png")

The root locus does not change much.

#pagebreak()

== Improving transient and steady-state response

=== PID controllers
#cimage("./images/improving-response-pid-controller-block-diagram.png")

*Time domain*:
$ a = K_p e + K_D frac(dif e, dif t) + K_I integral_0^t e thin dif t $

*S-plane domain*:
$
    bold("PID"): K_p + K_D s + K_I/s & = frac(K_D s^2 + K_p s + K_I, s) \
                                     & = frac(K_D (s + z_1) (s + z_2), s) \
                                     & = K_D underbrace(
                                           (s + z_1),
                                           "PD controller"
                                       )
                                       underbrace((s + z_2)/s, "PI controller")
$

Steps:
+ Use the PD controller to tune the transient response.
+ Use the PI controller to eliminate steady-state error.

#pagebreak()

=== Lead-lag compensators
#cimage("./images/lead-lag-compensator-block-diagram.png")

Lead-lag compensator:
$
    underbrace(
        (frac(K_1 (s + z_1), s + p_1)),
        "Lead compensator" #linebreak() z_1 < p_1
    )
    underbrace(
        (frac(K_2 (s + z_2), s + p_2)),
        "Lag compensator" #linebreak() p_2 < z_2 << 1
    )
$

Steps:
+ Design the lead compensator to tune the transient response.
+ Use the lag compensator to reduce steady-state error.

== Summary
#table(
    columns: 3,
    align: center + horizon,
    table.header([], [*Active*], [*Passive*]),
    [Transient Response], [PD], [Lead],
    [Steady-state Response], [PI], [Lag],
    [Transient and steady-state Response], [PID], [Lead-lag],
)

#pagebreak()

= Bode plots

== Harmonic inputs
#cimage("./images/bode-plots-transfer-function.png", width: 50%)

*Time domain*:
$ bold("Input"): r = r_0 cos (omega t) $
$
    bold("Steady-state"): c = underbrace(
        (r_0 |G(s = j omega)|),
        "Magnitude changed by a factor of" |G(s = j omega)|
    )
    cos (omega t + underbrace(
            angle G(s = j omega),
            "Phase shift by a factor of" angle G(s = j omega)
        ))
$

#cimage("./images/harmonic-inputs-graph.png")

=== Example
$ "Input": r(t) = r_0 cos (10t) $
$
    G(s = 10j) & = 2/(10j + 2) \
               & = 2/(sqrt(104 e^(j (arctan 5)))) \
               & = 2/sqrt(104) e^(-j (arctan 5))
$
$
    c_(s s) (t) = r_0 underbrace(
        |G(s = j omega)|, 2/sqrt(104)
    ) cos (10t + underbrace(angle G (s = j omega), - arctan 5))
$

== Bode plot
#cimage("./images/bode-plots-transfer-function.png", width: 50%)

The bode plot shows the frequency response of the transfer function and
generates two logarithmic scale plots:
+ Magnitude plot
    $ 20 log_(10) (|G(s = j omega)|) "against" lg omega $
    *$x$-axis is $lg omega$*.
    #cimage("./images/bode-plots-magnitude-plot.png")
+ Phase plot
    $ angle G(s = j omega) "against" lg omega $
    #cimage("./images/bode-plots-phase-plot.png")

#pagebreak()

=== Motivation
+ Together with Fourier series analysis it can compute the output of periodic
    inputs.

    For example, $r = 2 sin(3t) + 6 cos(100t + pi)$
    $
        "Output": c = 2 |G(s = 3j)| sin(3t + angle G(s = 3j))
        + 6|G(s = 100j)| cos(100 t + pi + angle G(s = 100))
    $
+ For analysis:
    - Resonance
    - Filtering
+ For designing closed-loop systems:
    - *Poles*
    - *Steady-state response*
+ Reverse engineering:
    - *Identifying the transfer function* of the system

#pagebreak()

== Superposition principle
The objective is to plot two log-scale plots.
#cimage("./images/bode-plots-transfer-function.png", width: 50%)

$ G(s) = K frac(Pi_(i = 1)^n (s + z_i), Pi_(j = 1)^m (s + p_j)) $

*Frequency response*:
$
    G(s = j omega) & = K frac(Pi_(i = 1)^n (s + z_i), Pi_(j = 1)^m (s + p_j)) \
                   & = K frac(
                         Pi_(i = 1)^n (sqrt(omega^2 + z_i^2)
                             e^(j arctan (omega/z_i))),
                         Pi_(j = 1)^m (sqrt(omega^2 + p_j^2)
                             e^(j arctan (omega/p_j)))
                     ) \
                   & = underbrace(
                         K frac(
                             Pi_(i = 1)^n (sqrt(omega^2 + z_i^2)),
                             Pi_(j = 1)^m (sqrt(omega^2 + p_j^2))
                         ), |G(s = j omega)|
                     )
                     e^(j overbrace(
                         (sum_(i = 1) arctan (omega/z_i)
                             - sum_(j = 1)^m arctan (omega/p_j)),
                         angle G (s = j omega)
                     ))
$

*Transfer function*:
$ G(s) = K frac(Pi_(i = 1) (s + z_i), Pi_(j = 1)^m (s + p_j)) $

*$angle G$, phase*:
$ sum_(i = 1)^n arctan(omega/z_i) - sum_(j = 1)^m arctan(omega/p_j) $

The above equation is a *linear combination of angles*.

*$|G|$, magnitude*:
$
    K frac(
        Pi_(i = 1)^n (sqrt(omega^2 + z_i^2)),
        Pi_(j = 1)^m (sqrt(omega^2 + p_j^2))
    ) quad stretch(->)^(quad "Log-scale" quad) quad
    20 lg (K frac(
            Pi_(i = 1)^n (sqrt(omega^2 + z_i^2)),
            Pi_(j = 1)^m (sqrt(omega^2 + p_j^2))
        ))
$
$
    20 lg |G| = 20 lg (K) + sum_(i = 1)^n 20 lg (sqrt(omega^2 + z_i^2))
    - sum_(j = 1)^m 20 lg (omega^2 + p_j^2)
$

The above equation is a *linear combination of magnitudes*.

#pagebreak()

== Principal components
+ Constants ($K$)
+ Differentiator ($s$)
+ Integrator ($1/s$)
+ First order systems ($a/(s + a)$)
+ Second order systems ($frac(omega_n^2, s + 2 zeta omega_n s + omega_n^2)$)

== Plotting constants
#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-constant-plots.png"),
    [
        #image(
            "./images/bode-plots-constant-transfer-function.png",
            height: 5em,
        )

        $ G(s) = K $
        $ G(s = j omega) = K e^(j 0) $

        *Magnitude*:
        $ 20 lg |G(j omega)| = 20 lg K $

        *Phase*:
        $ angle G(j omega) = 0 $
    ],
)

== Plotting differentiator
#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-differentiator-plots.png"),
    [
        #image(
            "./images/bode-plots-differentiator-transfer-function.png",
            height: 5em,
        )

        $ G(s) = s $
        $ G(s = j omega) = j omega $
        $ G(s = j omega) = omega e^(j pi/2) $

        *Magnitude*:
        $ 20 lg |G(j omega)| = 20 lg omega $

        *Phase*:
        $ angle G(j omega) = pi/2 $
    ],
)

== Plotting integrator
#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-integrator-plots.png"),
    [
        #image(
            "./images/bode-plots-integrator-transfer-function.png",
            height: 5em,
        )

        $ G(s) = 1/s $
        $ G(s = j omega) = 1/(j omega) $
        $ G(s = j omega) = 1/omega e^(j - pi/2) $

        *Magnitude*:
        $ 20 lg |G(j omega)| = -20 lg omega $

        *Phase*:
        $ angle G(j omega) = - pi/2 $
    ],
)

== Plotting first order pole
#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-first-order-pole-plots-1.png"),
    [
        #image(
            "./images/bode-plots-first-order-pole-transfer-function.png",
            height: 5em,
        )

        $ G(s = j omega) = a/(j omega + a) $

        When $omega << a$:
        $ G(s = j omega) = a/a = 1e^(j 0) $

        *Magnitude*:
        $ 20 lg |G(j omega)| = 0 $

        *Phase*:
        $ angle G(j omega) = 0 $
    ],
)

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-first-order-pole-plots-2.png"),
    [
        #image(
            "./images/bode-plots-first-order-pole-transfer-function.png",
            height: 5em,
        )

        $ G(s = j omega) = a/(j omega + a) $

        When $omega >> a$:
        $ G(s = j omega) = a/(j omega) = a/omega e^(j (- pi/2)) $

        *Magnitude*:
        $
            20 lg |G(j omega)| & = 20 lg a/omega \
                               & = 20 lg a - 20 lg omega
        $

        *Phase*:
        $ angle G(j omega) = - pi/2 $
    ],
)

#pagebreak()

=== Example
#cimage(
    "./images/bode-plots-first-order-pole-example-transfer-function.png",
    width: 50%,
)

$ a = 10 $

*Corner frequencies*:
$ omega = 1, 10, 100 $

#cimage("./images/bode-plots-first-order-pole-example-plots.png")

== Plotting first order zero
#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-first-order-zero-plots-1.png"),
    [
        #image(
            "./images/bode-plots-first-order-zero-transfer-function.png",
            height: 5em,
        )

        $ G(s = j omega) = a/(j omega + a) $

        When $omega << a$:
        $ G(s = j omega) = a/a = 1e^(j 0) $

        *Magnitude*:
        $ 20 lg |G(j omega)| = 0 $

        *Phase*:
        $ angle G(j omega) = 0 $
    ],
)

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-first-order-zero-plots-2.png"),
    [
        #image(
            "./images/bode-plots-first-order-zero-transfer-function.png",
            height: 5em,
        )

        $ G(s = j omega) = a/(j omega + a) $

        When $omega >> a$:
        $ G(s = j omega) = a/(j omega) = a/omega e^(j (pi/2)) $

        *Magnitude*:
        $
            20 lg |G(j omega)| & = 20 lg a/omega \
                               & = 20 lg a - 20 lg omega
        $

        *Phase*:
        $ angle G(j omega) = pi/2 $
    ],
)

#pagebreak()

=== Example
#cimage(
    "./images/bode-plots-first-order-zero-example-transfer-function.png",
    width: 50%,
)

$ a = 10 $

*Corner frequencies*:
$ omega = 1, 10, 100 $

#cimage("./images/bode-plots-first-order-zero-example-plots.png")

== Plotting second order pole
#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-second-order-pole-plots-1.png"),
    [
        #image(
            "./images/bode-plots-second-order-pole-transfer-function.png",
            height: 5em,
        )

        $
            G(s = j omega) = frac(
                omega_n^2,
                (- omega^2) + j 2 zeta omega_n omega + omega_n^2
            )
        $

        When $omega << omega_n$:
        $ G(s = j omega) = omega_n^2/omega_n^2 = 1e^(j 0) $

        *Magnitude*:
        $ 20 lg |G(j omega)| = 0 $

        *Phase*:
        $ angle G(j omega) = 0 $
    ],
)

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-second-order-pole-plots-2.png"),
    [
        #image(
            "./images/bode-plots-second-order-pole-transfer-function.png",
            height: 5em,
        )

        $
            G(s = j omega) = frac(
                omega_n^2,
                (- omega^2) + j 2 zeta omega_n omega + omega_n^2
            )
        $

        When $omega >> omega_n$:
        $
            G(s = j omega)
            = omega_n^2/(- omega^2) = omega_n^2/omega^2 e^(j (- pi))
        $

        *Magnitude*:
        $
            20 lg |G(j omega)| & = 20 lg omega_n^2/omega^2 \
                               & = 40 lg omega_n - 40 lg omega
        $

        *Phase*:
        $ angle G(j omega) = - pi $
    ],
)

#pagebreak()

=== Example
#cimage(
    "./images/bode-plots-second-order-pole-example-transfer-function.png",
    width: 50%,
)

$ omega_n = 1 $

*Corner frequencies*:
$ omega = 0.1, 1, 10 $

#cimage("./images/bode-plots-second-order-pole-example-plots-1.png")
#cimage("./images/bode-plots-second-order-pole-example-plots-2.png")
#cimage("./images/bode-plots-second-order-pole-example-plots-3.png")

Resonance frequency $omega_r$:
$ omega_r = omega_n sqrt(1 - 2 zeta^2) $

== Plotting second order zero
#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-second-order-zero-plots-1.png"),
    [
        #image(
            "./images/bode-plots-second-order-zero-transfer-function.png",
            height: 5em,
        )

        $
            G(s = j omega) = frac(
                (- omega^2) + j 2 zeta omega_n omega + omega_n^2,
                omega_n^2,
            )
        $

        When $omega << omega_n$:
        $ G(s = j omega) = omega_n^2/omega_n^2 = 1e^(j 0) $

        *Magnitude*:
        $ 20 lg |G(j omega)| = 0 $

        *Phase*:
        $ angle G(j omega) = 0 $
    ],
)

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/bode-plots-second-order-zero-plots-2.png"),
    [
        #image(
            "./images/bode-plots-second-order-zero-transfer-function.png",
            height: 5em,
        )

        $
            G(s = j omega) = frac(
                (- omega^2) + j 2 zeta omega_n omega + omega_n^2,
                omega_n^2,
            )
        $

        When $omega >> omega_n$:
        $
            G(s = j omega)
            = -omega^2/omega_n^2 = omega^2/omega_n^2 e^(j pi)
        $

        *Magnitude*:
        $
            20 lg |G(j omega)| & = 20 lg omega^2/omega_n^2 \
                               & = 40 lg omega - 40 lg omega_n
        $

        *Phase*:
        $ angle G(j omega) = pi $
    ],
)

#pagebreak()

=== Example
#cimage(
    "./images/bode-plots-second-order-zero-example-transfer-function.png",
    width: 50%,
)

$ omega_n = 1 $

*Corner frequencies*:
$ omega = 0.1, 1, 10 $

#cimage("./images/bode-plots-second-order-zero-example-plots-1.png")
#cimage("./images/bode-plots-second-order-zero-example-plots-2.png")

== Complex function
$ G = frac(1000s, s^2 + s + 100) $
$ G = mathred(1000/100) mathblue((s)) mathgreen((frac(100, s^2 + s + 100))) $

=== Asymptotes
#cimage("./images/bode-plots-complex-function-asymptotes.png")
#pagebreak()

=== Sketch
$ G = mathred(1000/100) mathblue((s)) mathgreen((frac(100, s^2 + s + 100))) $
#cimage("./images/bode-plots-complex-function-sketch.png")

=== MATLAB plot
#cimage("./images/bode-plots-complex-function-matlab-plot.png")

=== Reading the bode plot
#cimage("./images/bode-plots-transfer-function.png", width: 50%)

Compute the output if the input is:
$ r(t) = 2 cos t + 5 cos 10 t $
$
    c(t) = 2|G(s = j)| cos (t + angle G(s = j))
    + 5|G(s = 10j)| cos (10t + angle G(s = 10j))
$

#cimage("./images/bode-plots-complex-function-reading-matlab-plot.png")

$
    c(t) = 2 |underbrace(G(s = j), 10)|
    cos (t + underbrace(angle G(s = j), pi/2))
    + 5 |underbrace(G(s = 10j), 1000)|
    cos (10t + underbrace(angle G(s = 10j), 0))
$

$ therefore quad c(t) = 20 cos (t + pi/2) + 5000 cos (10 t) $

== Low-pass filter
#cimage("./images/bode-plots-low-pass-filter.png")

#align(center, grid(
    columns: 3,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,
    [*Input Signal*], [], [*Output Signal*],

    $ r(t) = cos (omega t) $,
    sym.arrow,
    $ c(t) = |G(s = j omega)| cos (omega t + angle G) $,
))

*Relationship between $|G(s = j omega)|$ and the cut-off frequency ($omega_c$)*:
$
    |G(s = j omega)| = cases(
        << |G(s = j omega_"low")|\, quad omega >= omega_c,
        ~|G(s = j omega_"low")|\, quad omega < omega_c
    )
$

== High-pass filter
#cimage("./images/bode-plots-high-pass-filter.png")

#align(center, grid(
    columns: 3,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,
    [*Input Signal*], [], [*Output Signal*],

    $ r(t) = cos (omega t) $,
    sym.arrow,
    $ c(t) = |G(s = j omega)| cos (omega t + angle G) $,
))

*Relationship between $|G(s = j omega)|$ and the cut-off frequency ($omega_c$)*:
$
    |G(s = j omega)| = cases(
        ~ |G(s = j omega_"high")|\, quad omega >= omega_c,
        <<|G(s = j omega_"high")|\, quad omega < omega_c
    )
$

#pagebreak()

== Reverse engineering
Reverse engineering's aim is to use bode plots to approximate the transfer
function.

#cimage("./images/bode-plots-reverse-engineering.png")

*Estimated transfer function*:
$
    G(s)
    = mathblue(frac(30^2, s^2 + 2(0.01)(30)s + 30^2))
    mathred((3/(s+3))) mathgreen(((s + 400)/400)) K
$
$ G(s) = frac(900K, s^2 + 0.6s + 900) (frac(3, s + 3)) (frac(s + 400, 400)) $

DC gain from plot is #qty[63.5][dB].

Hence:
$ 20 lg lr(|lim_(s -> 0) G(s)|) = 63.5 $
$ lr(|lim_(s -> 0) G(s)|) = 10^(63.5/20) $
$ (900K)/900 (3/3) (400/400) = 10^(63.5/20) $
$ K = 10^(63.5/20) = 1500 $

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,
    [*Estimated*], [*Actual*],

    $ G(s) = frac(10125(s + 400), (s^2 + 0.6s + 900)(s + 3)) $,
    $ G(s) = frac(15000(s + 450), (s^2 + s + 900)(s + 5)) $,
))

#pagebreak()

=== Example
Use the bode plots to approximate the transfer function:
#cimage("./images/bode-plots-reverse-engineering-example.png")

*Estimated transfer function*:
$ G(s) = mathred(1/s) mathgreen((G_1)) K $
$ "Low frequency gain" = #qty[16.5][dB] $
$ omega_r = #qty[11.5][rad], quad zeta approx 0.3 $

*Resonance frequency analysis*:
$ omega_r = omega_n sqrt(1 - 2 zeta^2) = 11.5 $
$ omega_n = 12.7 $
$ G_1 = frac(12.7^2, s^2 + 2(0.3)(12.7)s + 12.7^2) $

*Low frequency gain analysis*:
$
    20 lg lr(|lim_(s -> j) G(s)|) = 16.5
    quad -> quad lr(|lim_(s -> j) G(s)|) = 10^(16.5/20)
$
$ lr(|(K/j) (161/(-1 + 7.6j + 161))|) = 10^(16.5/20) $
$ K = 6.6 $

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,

    [*Estimated*], [*Actual*],

    $ G(s) = frac(1065, (s^2 + 7.6s + 161)s) $,
    $ G(s) = frac(1000, (s^2 + 5s + 150)s) $,
))

== Closed-loop response
The bode plot of *$G$ (open-loop transfer function)* also reveals the response
of the *unity feedback system*.

== Gain and phase margins
#cimage("./images/bode-plots-gain-and-phase-margins.png")

- *Gain margin (Stable $G_"OL"$)*
    + Occurs at the frequency when $angle G = - pi #unit[rad]$
        $mathred((omega_"gm"))$
    + #text(red)[Gain margin (GM) is given by:]
        $ mathred("GM" = 0 - lr(|G(s = j omega_"gm")|)_#unit[dB]) $

- *Phase margin (Stable $G_"OL"$)*
    + Occurs at the frequency when $|G| = #qty[0][dB]$ $mathgreen((omega_"pm"))$
    + #text(green)[Phase margin (#sym.gamma) is given by:]
        $ mathgreen(gamma = angle G(s = j omega_"pm" - (- pi))) $

- *Stability*

    Unity feedback is stable if and only if:
    $ mathred(gamma > 0 "and" G M > 0) $

- *Closed-loop $zeta_"cl"$*

    *$gamma$ increasing* implies that *$zeta_"cl"$* is increasing too.

== Bandwidth
#cimage("./images/bode-plots-bandwidth.png")

- *Bandwidth*:

    The frequency when $|G| = X - #qty[3][dB]$. It is denoted as $omega_"BW"$.

- *Closed loop $omega_(n,"cl")$*:

    *$omega_"BW"$ increasing* implies that $omega_(n,"cl")$ is increasing too.

- *Closed-loop poles*:
    $
        mathred(
            s_(1, 2) = -zeta_"cl" omega_(n,"cl")
            plus.minus j omega_(n,"cl") sqrt(1 - zeta_"cl"^2)
        )
    $

#pagebreak()

== Steady-state errors

=== Type 0 systems
#cimage("./images/bode-plots-steady-state-errors-type-0.png")

Steady-state error $e_(s s)$ (step inputs):
$ 1/(1 + K_p) $

Static position error constant:
$ K_p = lim_(s -> 0) G_"OL" $

For example:
$ #qty[14][dB] = 20 lg K_p $
$ K_p = 10^(14/20) = 5 $
$ e_(s s) = 1/(1 + 5) = 1/6 $

=== Type 1 systems
#cimage("./images/bode-plots-steady-state-errors-type-1.png")

Steady-state error $e_(s s)$ (ramp inputs):
$ 1/(K_v) $

For example:
$ K_v = omega_v = 21 $
$ e_(s s) = 1/21 $

=== Type 2 systems
#cimage("./images/bode-plots-steady-state-errors-type-2.png")

Steady-state error $e_(s s)$ (parabolic inputs):
$ 1/(K_a) $

For example:
$ omega_a = 10.8 $
$ K_a = 116 $
$ e_(s s) = 1/116 $

== Summary
+ Bode plot is the frequency response of the system.
+ Sketching techniques
    #enum(
        numbering: "a)",
        [Superposition principle],
        [Sketch the principal components],
        [Combine all the components together],
    )
+ Low-pass and high-pass filters
+ Reverse engineering
+ Unity feedback systems based on open-loop bode plots
    #enum(
        numbering: "a)",
        [Stability],
        [Transient response],
        [Steady-state errors],
    )
