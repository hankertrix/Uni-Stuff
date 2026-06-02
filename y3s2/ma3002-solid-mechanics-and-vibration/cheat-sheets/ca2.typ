// The cheat sheet format
#let cheat_sheet(font_size: 6pt, number_of_columns: 5, body) = {
    //

    // Constants
    let special_colour = cmyk(100%, 72%, 0%, 38%)
    let line_skip = 0.35em

    // Formatting for cheat sheet
    set page(
        columns: number_of_columns,
        paper: "a4",
        flipped: true,
        margin: 0.25in,
    )

    set columns(gutter: 0.5em)

    set text(size: font_size)
    set heading(numbering: "1.1")

    set block(spacing: line_skip)
    set par(leading: line_skip, spacing: line_skip)

    show heading: set text(special_colour, size: font_size)
    show heading: set block(
        above: line_skip,
        below: line_skip,
    )

    show math.equation: set text(special_colour)
    show math.equation.where(block: false): set text(
        top-edge: "bounds",
    )

    body
}

// Use the cheat sheet format
#show: cheat_sheet

// Bracket matrix
#let bmat = math.mat.with(delim: "[")

// Curly braces vector
#let cvec = math.vec.with(delim: "{")

// The evaluated at symbol
#let evaluated(expression, size: 100%) = $lr(#expression|, size: #size)$

// Red colour in math mode
#let mathred(content) = text(fill: red, $#content$)

// The red colour cancel
#let redcancel = math.cancel.with(stroke: red)

// Constants
#let COLUMN-GUTTER = 2em

= Stiffness formulas

== General
$k = F/Delta$

Where:
- $F$ is the force
- $Delta$ is the deflection

== Torsional stiffness
#grid(
    columns: 2,
    column-gutter: COLUMN-GUTTER,
    align: center + horizon,
    $k = frac(E I, l)$,
    image("../images/stiffness-formula-not-provided-1.png", height: 3em),
)

Where:
- $E$ is the modulus of elasticity
- $I$ is the moment of inertia of the cross-sectional area
- $l$ is the total length

== Axial force on a bar
#grid(
    columns: 2,
    column-gutter: COLUMN-GUTTER,
    align: center + horizon,
    $k = frac(E A, l)$,
    image("../images/stiffness-formula-not-provided-2.png", height: 2em),
)

Where:
- $A$ is the cross-sectional area

== Torque on a bar
#grid(
    columns: 2,
    column-gutter: COLUMN-GUTTER,
    align: center + horizon,
    $k = frac(G J, l)$,
    image("../images/stiffness-formula-not-provided-3.png", height: 3em),
)

Where:
- $G$ is the shear modulus or modulus of rigidity
- $J$ is the moment of inertia

== Force on the end of cantilever beam
#grid(
    columns: 2,
    column-gutter: COLUMN-GUTTER,
    align: center + horizon,
    $k = frac(3 E I, l^3)$,
    image("../images/stiffness-formula-not-provided-4.png", height: 3em),
)

Note that $k$ is at the position of the load.

== Force in the middle of a bar
#grid(
    columns: 2,
    column-gutter: COLUMN-GUTTER,
    align: center + horizon,
    $k = frac(48 E I, l^3)$,
    image("../images/stiffness-formula-not-provided-5.png", height: 4em),
)

Note that $k$ is at the position of the load.

== Springs in series
#image("../images/stiffness-formula-springs-in-series.png", width: 70%)
$k_"eff" = frac(1, 1/k_1 + 1/k_2)$,

== Springs in parallel
#image(
    "../images/stiffness-formula-springs-in-parallel.png",
    height: 4em,
)

$k_"eff" = k_1 + k_2$

= Moment of inertia formulas

== Point mass
#grid(
    columns: 2,
    column-gutter: 1em,
    align: center + horizon,
    $J_o = m r^2$,
    image("../images/mass-moment-of-inertia-not-provided-1.png", height: 4em),
)

== Bar
#grid(
    columns: 2,
    column-gutter: COLUMN-GUTTER,
    align: center + horizon,
    [
        $J_z = 1/12 m L^2$ \
        $J_A = J_B = 1/3 m L^2$
    ],
    image("../images/mass-moment-of-inertia-not-provided-2.png", height: 4em),
)

Note that $z$ is the centre of the bar, and $A$ and $B$ are at the ends of the
bar.

== Disc
#grid(
    columns: 2,
    column-gutter: COLUMN-GUTTER,
    align: center + horizon,
    [
        $J_z = 1/2 m R^2$ \
        $J_x = J_y = 1/4 m R^2$
    ],
    image("../images/mass-moment-of-inertia-not-provided-3.png", height: 4em),
)

Note that $z$ is the centre of the disc, and $x$ and $y$ are at the edge of the
disc.

== Parallel axis theorem
#grid(
    columns: 2,
    column-gutter: 1em,
    align: horizon,
    [
        $ J = J_G + M d^2 $

        Where:
        - $J$ is the moment of inertia needed
        - $J_G$ is the moment of inertia about its own centre of gravity
        - $M$ is the mass of the body
        - $d$ is the distance between the axes
    ],
    image("../images/parallel-axis-theorem.png"),
)

= Vibrations

== Equations of motion
$m dot.double(x) + c dot(x) + k x = 0$ \
$J_o dot.double(theta) + c_theta dot(theta) + k_theta theta = 0$

Where:
- $m$ and $J_o$ are the effective masses
- $c$ and $c_theta$ are the damping constants
- $k$ and $k_theta$ are the effective stiffness

== Natural frequency
$omega_n = sqrt("Effective stiffness"/"Effective mass")
= sqrt(k/m)
= sqrt(k_theta/J_o)$

$f_n = frac(1, 2 pi) sqrt("Effective stiffness"/"Effective mass")
= frac(1, 2 pi) sqrt(k/m)
= frac(1, 2 pi) sqrt(k_theta/J_o)$

== Under-damped frequency
$omega_d = omega_n sqrt(1 - zeta^2)$

== Critical damping constant
$c_c = 2 sqrt(k m) = 2 m omega_n = frac(2k, omega_n)$ \
$(c_theta)_c = 2 sqrt(k_theta J_o) = 2 J_o omega_n = frac(2k_theta, omega_n)$

== Damping ratio
$zeta = c/c_c = frac(c, 2 sqrt(k m)) = frac(c, 2 m omega_n)
= frac(c omega_n, 2 k)$

$zeta = c/(c_theta)_c = frac(c, 2 sqrt(k_theta J_o)) = frac(c, 2 J_o omega_n)
= frac(c omega_n, 2 k_theta)$

$zeta = sqrt(frac(delta^2, 4 pi^2 + delta^2))$

== Logarithmic decrement
$delta = ln x_1/x_2 = frac(2 pi zeta, sqrt(1 - zeta^2))$

Where:
- $x_1$ is the amplitude of the first cycle
- $x_2$ is the amplitude of the second cycle

== Static analysis
$sum F = 0$ \
$sum M = 0$

Static analysis is required when there is a spring with an unknown extension in
static equilibrium, like it is counteracting the weight of the object.

== Dynamic analysis
Newton's 2nd law: \
$m dot.double(theta) = sum F wide J_o dot.double(theta) = sum M_o$

== Undamped free vibrations

=== Equation of motion
$m dot.double(x) + k x = 0$

=== Displacement, velocity and acceleration
$x = X sin (omega_n t + phi.alt)$ \
$dot(x) = omega_n X cos (omega_n t + phi.alt)$ \
$dot.double(x) = - omega_n^2 X sin (omega_n t + phi.alt)$ \

=== Amplitude
$X = sqrt(x_0^2 + (frac(dot(x)_0, omega_n))^2)$

=== Phase
$phi.alt = arctan (frac(x_0 omega_n, dot(x)_0)) + 180 degree$

== Undamped forced vibrations

=== Equation of motion
$m dot.double(x) + k x = F_0 sin omega t$

=== Displacement
$x = x_h + x_p$ \
$x = A cos omega_n t + B sin omega_n t + X sin (omega t + phi.alt)$ \
$x = X_h sin (omega_n t + phi.alt_h) + X_p sin (omega t + phi.alt_p)$

=== Steady-state solution
$x_p = X sin (omega t + phi.alt)$

=== Amplitude
$X = frac(F_0/k, 1 - (omega/omega_n)^2) = frac(F_0, k - m omega^2)$ \
$frac(X, (F_0/k)) = frac(1, 1 - (omega/omega_n)^2)$

=== Phase
$phi.alt = 0$

== Damped free vibrations

=== Equation of motion
$m dot.double(x) + c dot(x) + k x = 0$

=== Under-damped
Damping ratio: $zeta < 1$

$x = e^(- zeta omega_n t) X sin (omega_d t + phi.alt)$

$dot(x) &= - zeta omega_n e^(- zeta omega_n t) X sin (omega_d t + phi.alt)
+ e^(- zeta omega_n t) omega_d X cos (omega_d t + phi.alt) \
&= -zeta omega_n x + e^(- zeta omega_n t) omega_d X cos (omega_d t + phi.alt)$

$dot.double(x) = &e^(- zeta omega_n t) X sin (omega_d t + phi.alt)
(zeta^2 omega_n^2 - omega_d^2) \
&- 2 e^(- zeta omega_n t) zeta omega_d omega_n X cos (omega_d t + phi.alt) \
= &x (zeta^2 omega_n^2 - omega_d^2)
- 2 e^(- zeta omega_n t) zeta omega_d omega_n X cos (omega_d t + phi.alt)$

$omega_d = omega_n sqrt(1 - zeta^2)$

=== Critically damped
Damping ratio: $zeta = 1$

$x = (C_1 + C_2 t) e^(-omega_n t)$

$dot(x) &= C_2 e^(- omega_n t) - omega_n (C_1 + C_2 t) e^(-omega_n t) \
&= C_2 e^(- omega_n t) - omega_n x$

$dot.double(x) &= omega_n^2 (C_1 + C_2 t) e^(- omega_n t)
- 2 C_2 omega_n e^(- omega_n t) \
&= x - 2 C_2 omega_n e^(- omega_n t)$

#colbreak()

=== Over-damped
Damping ratio: $zeta > 1$

$x = C_1 e^(r_1 t) + C_2 e^(r_2 t)$ \
$dot(x) = C_1 r_1 e^(r_1 t) + C_2 r_2 e^(r_2 t)$ \
$dot.double(x) = C_1 r_1^2 e^(r_1 t) + C_2 r_2^2 e^(r_2 t)$ \
$r_1 = - zeta omega_n + omega_n sqrt(zeta^2 - 1)$ \
$r_2 = - zeta omega_n - omega_n sqrt(zeta^2 - 1)$

== Damped forced vibrations

=== Equation of motion
$m dot.double(x) + c dot(x) + k x = F_0 sin omega t$

Unbalanced mass: $M dot.double(x) + c dot(x) + k x = m e omega^2 sin omega t$

Where:
- $M$ is the effective mass, adding all the masses together
- $m$ is the unbalanced mass
- $e$ is the eccentricity

=== Displacement
$x = e^(- zeta omega_n) (A cos omega_d t + B sin omega_d t)
+ X sin (omega t + phi.alt)$

$omega_d = omega_n sqrt(1 - zeta^2)$

=== Steady-state solution
$x_p = X sin (omega t + phi.alt)$

=== Amplitude
$X = frac(F_0, sqrt((k - m omega^2)^2 + (c omega)^2))$

At resonant frequency:
$X_"res" = frac(F_0, sqrt((k - m omega_n^2)^2 + (c omega_n)^2))$

Unbalanced mass:
$X = frac(m e omega^2, sqrt((k - M omega^2)^2 + (c omega)^2))$

=== Magnification factor or ratio
$frac(X, (F_0/k)) = frac(
    1,
    sqrt((1 - omega^2/omega_n^2)^2 + (frac(2 zeta omega, omega_n))^2)
)$

$frac(X_"res", (F_0/k)) = frac(1, 2 zeta) "when" omega = omega_n$

Unbalanced mass:
$frac(M X, m e) = frac(
    (omega/omega_n)^2,
    sqrt((1 - omega^2/omega_n^2)^2 + (frac(2 zeta omega, omega_n))^2)
)$

$frac(M X_"res", m e) = frac(1, 2 zeta) "when" omega = omega_n$

=== Phase
$phi.alt = arctan (frac(c omega, k - m omega^2))
= arctan (frac(frac(2 zeta omega, omega_n), 1 - omega^2/omega_n^2))$

= Maths

// == Laplace transforms
//
// $cal(L) {k} = k / s, "where" k "is a constant"$
//
// $cal(L) {t} = 1 / s^2$
//
// $cal(L) {a t} = a / s^2$
//
// $cal(L) {frac(a t^n, n !)} = a / s^(n + 1)$
//
// $cal(L) {e^(- a t)} = frac(1, s + a)$
//
// $cal(L) {t e^(- a t)} = frac(1, (s + a)^2)$
//
// $cal(L) {frac(1, ( n - 1 ) !) t^(n - 1) e^(- a t)}
// = frac(1, (s + a)^n)$
//
// $cal(L) {sin omega t} = frac(omega, s^2 + omega^2)$
//
// $cal(L) {cos omega t} = frac(s, s^2 + omega^2)$
//
// $cal(L) {t sin omega t} = frac(2 omega s, (s^2 + omega^2)^2)$
//
// $cal(L) {t cos omega t} = frac(s^2 - omega^2, (s^2 + omega^2)^2)$
//
// $cal(L) {e^(- a t) sin omega t} = frac(omega, (s + a)^2 + omega^2)$
//
// $cal(L) {e^(- a t) cos omega t} = frac(s + a, (s + a)^2 + omega^2)$
//
// $cal(L) {1 - e^(- a t)} = frac(a, s (s + a))$
//
// $cal(L) {t - frac(1 - e^(- a t), a)} = frac(a, s^2 (s + a))$
//
// $cal(L) {e^(- a t) - e^(- b t)} = frac(b - a, (s + a) (s + b))$
//
// $cal(L) {b e^(- b t) - a e^(- a t)}
// = frac((b - a) s, (s + a) (s + b))$
//
// $cal(L) {(1 - a t) e^(- a t)} = frac(s, (s + a)^2)$
//
// $cal(L) {1 - frac(b, b - a) e^(- a t) + frac(a, b - a) e^(- b t)}
// = frac(a b, s (s + a) (s + b))$
//
// $cal(L) {1 - e^(a t) (cos b t + a/b sin b t)}
// = frac(a^2 + b^2, s[(s + a^2) + b^2])$
//
// $cal(L) {frac(e^(- a t), (b - a) (c - a))
//     + frac(e^(- b t), (c - a) (a - b))
//     + frac(e^(- c t), (a - c) (b - c))}
// = frac(1, (s + a) (s + b) (s + c))$
//
// $cal(L) {frac(omega, sqrt(1 - zeta^2)) e^(- zeta omega t) sin omega
//     sqrt(1 - zeta^2) t} = frac(omega^2, s^2 + 2 zeta omega s + omega^2)$
//
// $cal(L){1 - 1/(1 - zeta^2) e^(- zeta omega t)
//     sin (omega sqrt(1 - zeta^2) t + phi.alt)}
// = frac(omega^2, s(s^2 + 2 zeta omega s + omega^2)),
// "where" cos phi.alt = zeta$

== Small angle approximation
$sin theta approx theta$ \
$cos theta approx 1$ \
$tan theta approx theta$

== Derivatives

Chain rule: \
$frac(d z, d x) = frac(d z, d y) dot.op frac(d y, d x)$

Product rule: \
$frac(d, d x) (u dot.op v) = frac(d u, d x) dot.op v + u dot.op frac(d v, d x)$

Quotient rule: \
$frac(d, d x) (frac(f (x), g (x))) = frac(f' (x) g (x) - f (x) g' (x), g (x)^2)$

Standard derivatives: \
$frac(d, d x) (sin x) = cos x$ \
$frac(d, d x) (cos x) = - sin x$ \
$frac(d, d x) (tan x) = - sec^2 x$ \
$frac(d, d x) (arcsin x) = 1 / sqrt(1 - x^2)$ \
$frac(d, d x) (arccos x) = - 1 / sqrt(1 - x^2)$ \
$frac(d, d x) (arctan x) = frac(1, 1 + x^2)$ \
$frac(d, d x) (sec x) = sec x tan x$ \
$frac(d, d x) (csc x) = - csc x cot x$ \
$frac(d, d x) (cot x) = - csc^2 x$ \

== Integrals
$integral 1/x = ln lr(|x|)$

$integral sin x thin d x = - cos x$

$integral cos x thin d x = sin x$

$integral tan x thin d x = ln |sec x|$

$integral frac(1, x^2 + a^2) thin d x = 1 / a arctan (x / a)$

$integral 1 / sqrt(a^2 - x^2) thin d x = arcsin (x / a)$

$integral frac(1, x^2 - a^2) thin d x
= frac(1, 2 a) ln lr(|frac(x - a, x + a)|)$

$integral frac(1, a^2 - x^2) thin d x
= frac(1, 2 a) ln lr(|frac(a + x, a - x)|)$

$integral 1 / sqrt(x^2 - a^2) thin d x = ln lr(|sqrt(x^2 - a^2) + x|)$

$integral sec x thin d x = - ln |sec x + tan x|$

$integral csc x thin d x = - ln |csc x + cot x|$

$integral cot x thin d x = ln |sin x|$

#colbreak()

Integration by parts: \
$integral u thin d v = u v - integral v thin d u$

Preference for $u$:
+ L: $log$ or $ln$.
+ I: Inverse trigonometric functions.
+ A: Algebraic functions.
+ T: Trigonometric functions.
+ E: Exponential functions.

== Trigonometric identities

Quotient identities: \
$tan theta = frac(sin theta, cos theta)$ \
$cot theta = frac(cos theta, sin theta)$

Reciprocal identities: \
$sin theta = frac(1, csc theta)$ \
$csc theta = frac(1, sin theta)$ \
$cos theta = frac(1, sec theta)$ \
$sec theta = frac(1, cos theta)$ \
$tan theta = frac(1, cot theta)$ \
$cot theta = frac(1, tan theta)$

Pythagorean identities: \
$sin^2 theta + cos^2 theta = 1$ \
$sec^2 theta - tan^2 theta = 1$ \
$csc^2 theta - cot^2 theta = 1$

Even/odd identities: \
$sin (- theta) = - sin theta$ \
$cos (- theta) = cos theta$ \
$tan (- theta) = - tan theta$ \
$cot (- theta) = - cot theta$ \
$csc (- theta) = - csc theta$ \
$sec (- theta) = sec theta$

Co-function identities: \
$sin (pi / 2 - theta) = cos theta$ \
$cos (pi / 2 - theta) = sin theta$ \
$tan (pi / 2 - theta) = cot theta$ \
$cot (pi / 2 - theta) = tan theta$ \
$csc (pi / 2 - theta) = sec theta$ \
$sec (pi / 2 - theta) = csc theta$ \
$pi / 2 "radians" = 90 degree$

Sum/difference identities: \
$sin (theta plus.minus phi.alt)
= sin theta cos phi.alt plus.minus cos theta sin phi.alt$ \
$cos (theta plus.minus phi.alt)
= cos theta cos phi.alt minus.plus sin theta sin phi.alt$ \
$tan (theta plus.minus phi.alt)
= frac(tan theta plus.minus tan phi.alt, 1 minus.plus tan theta tan phi.alt)$

Double angle identities: \
$sin (2 theta) = 2 sin theta cos theta$ \
$cos (2 theta) = cos^2 theta - sin^2 theta$ \
$cos (2 theta) = 2 cos^2 theta - 1$ \
$cos (2 theta) = 1 - 2 sin^2 theta$ \
$tan (2 theta) = frac(2 tan theta, 1 - tan^2 theta)$

Half angle identities: \
$sin^2 theta = frac(1 - cos (2 theta), 2)$ \
$cos^2 theta = frac(1 + cos (2 theta), 2)$ \
$tan^2 theta = frac(1 - cos (2 theta), 1 + cos (2 theta))$

Sum to product of 2 angles:

$sin theta + sin phi.alt
= 2 sin (frac(theta + phi.alt, 2)) cos (frac(theta - phi.alt, 2))$

$sin theta - sin phi.alt
= 2 cos (frac(theta + phi.alt, 2)) sin (frac(theta - phi.alt, 2))$

$cos theta + cos phi.alt
= 2 cos (frac(theta + phi.alt, 2)) cos (frac(theta - phi.alt, 2))$

$cos theta - cos phi.alt
= - 2 sin (frac(theta + phi.alt, 2)) sin (frac(theta - phi.alt, 2))$

Product to sum of 2 angles:

$sin theta sin phi.alt = frac(cos (theta - phi.alt) - cos (theta + phi.alt), 2)$

$cos theta cos phi.alt = frac(cos (theta - phi.alt) + cos (theta + phi.alt), 2)$

$sin theta cos phi.alt = frac(sin (theta + phi.alt) + sin (theta - phi.alt), 2)$

$cos theta sin phi.alt = frac(sin (theta + phi.alt) - sin (theta - phi.alt), 2)$

Law of sines: \
$frac(a, sin A) = frac(b, sin B) = frac(c, sin C)$

Law of cosines: \
$a^2 = b^2 + c^2 - 2 b c cos A$

Area of a triangle: \
$A = 1 / 2 a b sin C$
