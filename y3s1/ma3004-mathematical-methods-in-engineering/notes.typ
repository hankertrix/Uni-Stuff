#set page(numbering: "1")
#set heading(numbering: "1.1")
#show link: text.with(blue)
#{
    set document(
        title: "MA3004 Mathematical Methods in Engineering Notes",
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
#let evaluated(expression, size: 100%) = $lr(#expression|, size: #size)$
#let cimage(..image_args) = align(center, image(..image_args))
#let labelled_equation(content, label) = math.equation(
    block: true,
    numbering: _ => ("(", str(label), ")").join(""),
    content,
)
#let redcancel = math.cancel.with(stroke: red)
#let vertcancel = math.cancel.with(stroke: red, angle: 0deg)
#let horzcancel = math.cancel.with(stroke: red, angle: 90deg)
#let crosscancel(content) = math.cancel(
    math.cancel($#content$, stroke: red, angle: 0deg),
    stroke: red,
    angle: 90deg,
)


// Square bracket ([]) matrix
#let bmat = math.mat.with(delim: "[")

// Square bracket ([]) vector
#let bvec = math.vec.with(delim: "[")

// Curly braces ({}) vector
#let cvec = math.vec.with(delim: "{")

#show math.equation.where(block: false): set text(top-edge: "bounds")

= Definitions

== Partial differentiation
To differentiate partially, you essentially treat all other variables that are
not the target variable as constants and perform regular differentiation.

Note that for any general function $f (x, y)$ that have 2nd order partial
derivatives:
$ (partial^2 f)/(partial x partial y) = (partial^2 f)/(partial y partial x) $

=== Example
Given:
$ f (x , y) = x^3 - 2 x^2 y + 3 x y^2 $

$
    frac(partial f, partial x)
    &= mathred(frac(partial, partial x))
    (mathred(x^3) - 2 mathred(x^2) y + 3 mathred(x) y^2)
    = 3 mathred(x^2) - 4 mathred(x) y + 3y^2 \
    //
    frac(partial f, partial y)
    &= mathred(frac(partial, partial y))
    (x^3 - 2 x^2 mathred(y) + 3 x mathred(y^2))
    = 3 x^2 - 4 x mathred(y) + 3 mathred(y^2) \
    //
    frac(partial^2 f, partial y partial x)
    &= mathred(frac(partial, partial y)) (frac(partial f, partial x))
    = mathred(frac(partial, partial y)) (3x^2 - 4 x mathred(y) + 3 mathred(y^2))
    = -4x + 6 mathred(y) \
    //
    frac(partial^2 f, partial x partial y)
    &= mathred(frac(partial, partial x)) (frac(partial f, partial y))
    = mathred(frac(partial, partial x)) (-2 mathred(x^2) + 6 mathred(x) y)
    = -4 mathred(x) + 6 y \
$

Then:
$
    therefore quad (partial^2 f)/(partial x partial y)
    = (partial^2 f)/(partial y partial x)
$

#pagebreak()

== Partial differential equation (PDE)
- A partial differential equation is an equation containing partial derivatives
    of a real function of two or more variables.
- Let $(x, y, z)$ be a general point in space with reference to a $O x y z$
    Cartesian coordinate system and let $phi.alt$ be a function of the Cartesian
    coordinates $x, y$ and $z$.

=== Laplace's equation
An example of a partial differential equation in $phi.alt (x, y, z)$ is:
$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2)
    + frac(partial^2 phi.alt, partial z^2) = 0
$

The equation above is called Laplace's equation. The 2D Laplace's equation is:
$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2) = 0
$

=== Helmholtz equation
Another example of a partial differential equation in $phi.alt (x, y, z)$ is:
$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2)
    + frac(partial^2 phi.alt, partial z^2) + k^2 phi.alt = 0
$

Where:
- $k$ is a constant

The above equation is called the Helmholtz equation, which appears in acoustic
analysis.

=== Diffusion or heat equation
- Let $phi.alt$ be a function of the Cartesian coordinates $x, y$ and $z$ and
    time $t$.
- The partial differential equation below is called the diffusion or heat
    equation.
- In the case of mass transfer, it describes the diffusion of mass due to
    Brownian motion and may be derived from the law of conservation of mass with
    $phi.alt$ being the concentration of the diffusion substance.

$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2)
    + frac(partial^2 phi.alt, partial z^2)
    = alpha frac(partial phi.alt, partial t)
$

=== Wave equation
- Let $phi.alt$ be a function of the Cartesian coordinates $x, y$ and $z$ and
    time $t$.
- The partial differential equation below is called the wave equation.
- The one dimensional version of this partial differential equation, where
    $phi.alt$ is a function of time $t$ and only one Cartesian coordinate,
    describes the motion of a vibrating string and may be derived from Newton's
    law of motion with $phi.alt$ being the displacement of the string

$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2)
    + frac(partial^2 phi.alt, partial z^2)
    = alpha frac(partial phi.alt, partial t)
$

#pagebreak()

== Order of a partial differential equation
The order of a partial differential equation in $phi.alt$ is given by the order
of the highest order partial derivative of $phi.alt$ present in the partial
differential equation.

$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2)
    + frac(partial^2 phi.alt, partial z^2) = 0
$

The Laplace's equation above contains only 2nd order partial derivatives, hence
it is a 2nd order partial differential equation.

$
    frac(partial^4 phi, partial x^2)
    + 2 frac(partial^4 phi, partial x^2 partial y^2)
    + frac(partial^4 phi, partial y^4) = 0
$

The partial differential equation in $phi (x, y)$ above is called the biharmonic
equation. It is a 4th order partial differential equation.

$
    frac(partial^2 T, partial x^2)
    + tau_1 frac(partial^3 T, partial x^2 partial t)
    = alpha (frac(partial T, partial t) + tau_1 frac(partial^2 T, partial t^2))
$

The partial differential equation in $T (x, t)$ above is of order 3. It occurs
in the analysis of 1D microscale heat conduction.

#pagebreak()

== Solutions of a partial differential equation
Consider a partial differential equation in $phi.alt$. A given function $f$ is
said to be a solution of the partial differential equation if we find that the
left-hand side and the right-hand side of the partial differential equation are
equal to each other when we replace $phi.alt$ by $f$ in the left-hand side and
the right-hand side.

For example, we can check that $phi.alt = e^(2 x) sin 2 y$ is a solution of the
2D Laplace's equation as follows:

$
    frac(partial phi.alt, partial x)
    &= frac(partial, partial x) e^(2x) sin 2y = 2e^(2x) sin 2y \
    //
    frac(partial^2 phi.alt, partial x^2)
    &= frac(partial, partial x) e^(2x) 2 sin 2y = mathred(4e^(2x) sin 2y) \
    //
    frac(partial phi.alt, partial y)
    &= e^(2x) frac(partial, partial y) sin 2y = 2e^(2x) cos 2y \
    //
    frac(partial^2 phi, partial y^2)
    &= 2e^(2x) frac(partial, partial y) cos 2y = mathred(-4e^(2x) sin 2y)
$

Left-hand side of 2D Laplace's equation:

$
    frac(partial^2 phi.alt, partial x^2) + frac(partial^2 phi.alt, partial y^2)
    &= 4e^(2x) sin 2y - 4e^(2x) sin 2y \
    &= 0 \
    &= "Right-hand side of the 2D Laplace's equation"
$

Using a similar method, all the functions given below is a solution of 2D
Laplace's equation at all points $(x, y)$.
$ phi.alt = x^2 - y^2 $
$ phi.alt = 2 x y $
$ phi.alt = e^(- y) cos x + 2 e^x sin y $

You can also verify that $phi.alt = ln (x^2 + y^2)$ is a solution of the 2D
Laplace's equations at all points $(x, y)$ except $(0, 0)$.

A given partial differential equation can have infinitely many solutions.

In general, it is difficult, if not impossible, to solve a partial differential
equation to obtain all its solutions.

Below is an example of a first order partial differential equation in
$u (x, y, z)$ which can be easily solved by direct integration for all its
solutions.
$
    frac(partial u, partial y) = x + 2 y z quad arrow.double.r quad
    integral frac(partial u, partial y) d y = integral (x + 2 y z) thin dif y
$

When integrating with respect to $y$, think of $x$ and $z$ as constants, just
like in partial differentiation. Hence:
$ u = x y + y^2 z + F (x, z) $

Where:
- $F (x, z)$ is an arbitrary function of $x$ and $z$

#pagebreak()

== Linear partial differential equations
A partial differential equation in $phi.alt$ is said to be linear if *all* its
terms containing $phi.alt$ or a partial derivative of $phi.alt$ are of the
linear form:
$
    c phi.alt "or" c dot.op ("a partial derivative of " phi.alt)
$

Where the coefficient $c$ is either a constant or a function of the independent
variables of $phi.alt$, like $x, y$ and $t$. The coefficient $c$ in a linear
term is free of $phi.alt$ and its partial derivatives.

=== Examples
$
    frac(partial^2 phi.alt, partial x^2) +
    5 frac(partial^2 phi.alt, partial y^2)
    + 2 frac(partial^2 phi.alt, partial z^2) + x^2 z - y = 0
$

In the partial differential equation above, the coefficients of all the terms
containing $phi.alt$ or a partial derivative of $phi.alt$ are constants.

$
    frac(partial^2 u, partial x^2)
    - x^2 frac(partial^2 u, partial t^2) + t x u = 0
$

In the partial differential equation above, the coefficients of all the terms
containing $u (x, t)$ or a partial derivative of $u$ are either a constant or a
function of the independent variables $x$ and $t$.

== Non-linear partial differential equations
A partial differential equation in $phi.alt$ is non-linear if any of its terms
containing $phi.alt$ or a partial derivative of $phi.alt$ is not of the linear
form.

=== Examples
$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2)
    + mathred(phi.alt^2) = 0
$

The third term on the left-hand side of the above partial differential equation
is not linear.

$
    frac(partial^2 u, partial x^2)
    - mathred(2 u frac(partial^2 u, partial t^2)) = 0
$

The second term on the left-hand side of the above partial differential equation
is not linear.

$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi, partial y^2)
    + frac(partial^2 phi.alt, partial z^2) - z^3
    = mathred(sin phi.alt)
$

The term $sin phi.alt$ is not linear in the above partial differential equation.

#pagebreak()

== Homogeneous linear partial differential equations
A linear partial differential equation in $phi.alt$ is said to be homogeneous if
*all* the non-zero terms in the partial differential equation contain either
$phi.alt$ or a partial derivative of $phi.alt$.

=== Examples
$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2)
    + frac(partial^2 phi.alt, partial z^2) + phi.alt = 0
$

All the non-zero terms in the partial differential equation above contain either
$phi.alt$ or a 2nd order partial derivative of $phi.alt$.

$
    frac(partial^2 u, partial x^2)
    - x^2 frac(partial^2 u, partial t^2)
    + t x frac(partial u, partial t) = 0
$

All the non-zero terms in the partial differential equation above contain a
partial derivative of $u$.

== Non-homogeneous linear partial differential equations
- A non-homogeneous linear partial differential equation has terms that do not
    contain either $phi.alt$ or a partial derivative of $phi.alt$.
- If $phi.alt = 0$ is not a solution of a linear partial differential equation
    in $phi.alt$, then the partial differential equation is non-homogeneous.

=== Example
$
    frac(partial^2 phi.alt, partial x^2) + frac(partial^2 phi.alt, partial y^2)
    + frac(partial^2 phi.alt, partial z^2) + mathred(1) = 0
$

The 4th term on the left-hand side of the equation, that is, 1, is non-zero and
does not contain $phi.alt$ or a partial derivative of $phi.alt$.

#heading(
    level: 2,
    "Superposition of solutions for "
        + "homogeneous linear partial differential equations",
)
- If $phi.alt_1$ and $phi.alt_2$ are two solutions of a homogeneous linear
    partial differential equation, then so is $alpha phi.alt_1 + beta phi.alt_2$
    for all real numbers $alpha$ and $beta$.
- This theorem is true for any homogeneous linear partial differential equation.

#pagebreak()

=== Example using the 2D Laplace's equations
If $phi.alt_1$ and $phi.alt_2$ are solutions of the 2D Laplace's equations, then
we can write:
$
    frac(partial^2 phi.alt_1, partial x^2)
    + frac(partial^2 phi.alt_1, partial y^2) = 0
$
$
    frac(partial^2 phi.alt_2, partial x^2)
    + frac(partial^2 phi.alt_2, partial y^2) = 0
$

Substituting $alpha phi.alt_1 + beta phi.alt_2$ into the left-hand side of the
Laplace's equations, we find that:

$
    frac(partial^2, partial x^2) (alpha phi.alt_1 + beta phi.alt_2)
    + frac(partial^2, partial y^2) (alpha phi.alt_1 + beta phi.alt_2)
    &= alpha (frac(partial^2 phi_1, partial x^2)
        + frac(partial^2 phi.alt_1, partial y^2))
    + beta (frac(partial^2 phi_2, partial x^2)
        + frac(partial^2 phi_2, partial y^2))
    &= 0
$

Hence, $alpha phi.alt_1 + beta phi.alt_2$ is a solution of the Laplace's
equation for all real numbers $alpha$ and $beta$.

=== Example using a non-homogeneous partial differential equation
Using the non-homogeneous linear partial differential equation below:
$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2) = 1
$

If $phi.alt_1$ and $phi.alt_2$ are solutions of the non-homogeneous linear
partial differential equation, we can write:
$
    frac(partial^2 phi.alt_1, partial x^2)
    + frac(partial^2 phi.alt_1, partial y^2) = 1
$
$
    frac(partial^2 phi.alt_2, partial x^2)
    + frac(partial^2 phi.alt_2, partial y^2) = 1
$

Substituting $alpha phi.alt_1 + beta phi.alt_2$ into the left-hand side of the
non-homogeneous linear partial differential equation, we find:

$
    frac(partial^2, partial x^2) (alpha phi.alt_1 + beta phi.alt_2)
    + frac(partial^2, partial y^2) (alpha phi.alt_1 + beta phi.alt_2)
    &= alpha (frac(partial^2 phi.alt_1, partial x^2)
        + frac(partial^2 phi.alt_1, partial y^2))
    + beta (frac(partial^2 phi.alt_2, partial x^2)
        + frac(partial^2 phi_2, partial y^2))
    &= alpha + beta
$

Hence, $alpha phi.alt_1 + beta phi.alt_2$ may or may not be a solution of the
non-homogeneous partial differential equation, depending on $alpha$ and $beta$.
It is a solution for only some $alpha$ and $beta$, that is, for
$alpha + beta = 1$.

== Boundary conditions (BCs)
The conditions given at all points on the boundary are known as *boundary
conditions (BCs)*. For time-dependent problems, boundary conditions are given at
all time $t > 0$.

== Initial conditions (ICs)
For time dependent problems, conditions on the solutions at all points in the
physical solution domain at time $t = 0$, known as *initial conditions (ICs)*,
are needed in addition to boundary conditions to ensure that the problem under
consideration has a unique solution.

#pagebreak()

== Boundary value problem (BVP)
A *boundary value problem (BVP)* is a problem that involves solving a time
*independent* partial differential equation in a physical domain subject to the
given boundary conditions.

=== 1D example
A 1D boundary value problem for the deflection of an elastic beam.

Solve:
$
    frac(d^2, d x^2) (E I frac(d^2 w, d x^2)) = q (x) "for" 0 < x < L
$

Subject to:
$
    w (0) = 0, quad evaluated(frac(d^2 w, d x^2))_(x = 0) = 0, quad
    w (L) = 0 "and" evaluated(frac(d^2 w, d x^2))_(x = L) = 0
$

- The elastic beam lies on the $x$ axis from $x = 0$ to $x = L$ when it is not
    deformed.
- The physical solution domain of this problem is given by $0 < x < L$ and the
    boundary points are $x = 0$ and $x = L$.
- When the beam is acted upon by a given external load $q (x)$, the vertical
    displacement of the beam from the $x$ axis is given by a function $w$ of one
    variable $x$.
- So, we have an ordinary differential equation (ODE) instead of a partial
    differential equation.
- The 4th order ordinary differential equation is derived from physics.
- Note that $E$ and $I$ are the Young's modulus and moment of inertia of the
    beam respectively.
- The boundary conditions are those for a beam that is simply supported at the
    ends at $x = 0$ and $x = L$.
- For a given $E, I$ and $q (x)$, we may solve the ordinary differential
    equation by integrating it with respect to $x$ 4 times.
- The 4 arbitrary constants from integration can then be determined using the
    given boundary conditions.

#pagebreak()

=== 2D example
A 2D boundary value problem governed by the 2D Laplace's equation.

Solve:
$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2) = 0 "for" 0 < x < a, 0 < y < b
$

Subject to:
$ phi.alt (x, 0) = 0, "and" phi.alt (x, b) = f (x) "for" 0 < x < a $
$ phi.alt (0, y) "and" phi.alt (a, y) = 0 "for" 0 < y < b $

- The required solution $phi.alt$ is a function of the Cartesian coordinates in
    $x$ and $y$.
- The physical solution domain is the rectangular region given by
    $0 < x < a, 0 < y < b$ on the $O x y$ plane.
- The boundary of the physical solution domain comprises the four sides of the
    rectangular region given by $x = 0$ and $x = a$ for $0 < y < b$ (vertical
    sides) and by $y = 0$ and $y = b$ for $0 < x < a$ (horizontal sides).
- For the boundary conditions, $phi.alt = 0$ on the bottom horizontal side
    ($y = 0$) and on the two vertical sides ($x = 0 "and" x = a$) and
    $phi.alt = f (x)$ on the top horizontal side $y = b$. Note that $f (x)$ is a
    given function of $x$.

#image("./images/2d-boundary-value-problem-graph.png")

#pagebreak()

=== 3D example
A 3D boundary value problem for steady state heat conduction in a spherical
solid.

Solve:
$
    frac(partial^2 T, partial x^2) + frac(partial^2 T, partial y^2)
    + frac(partial^2 T, partial z^2) = 0 "for" x^2 + y^2 + z^2 < a^2
$

Subject to:
$ T = T_0 "on" x^2 + y^2 + z^2 = a^2 "for" z gt.eq 0 $
$
    x frac(partial T, partial x) + y frac(partial T, partial y)
    + z frac(partial T, partial z) = 0 "on" x^2 + y^2 + z^2 = a^2 "for" z < 0
$

- We are interested in finding the steady state temperature $T$ inside a solid
    occupying the spherical region $x^2 + y^2 + z^2 < a^2$.
- The spherical region is the physical solution domain of the boundary value
    problem here, which is the spherical surface $x^2 + y^2 + z^2 = a^2$.
- The 3D Laplace's equation governing the steady state temperature $T$ can be
    derived from the law of conservation of energy and the Fourier law of heat
    conduction for thermally isotropic materials.
- For the boundary conditions, the spherical boundary $x^2 + y^2 + z^2 = a^2$ is
    divided into two parts.
- On the part where $z gt.eq 0$, the temperature is given by $T_0$. The part
    where $z < 0$ is thermally insulated, which means the normal heat flux
    flowing into the sphere is zero on that part.
- Note that the normal heat flux into the sphere on the spherical boundary
    $x^2 + y^2 + z^2 = a^2$ is proportional to
    $x frac(partial T, partial x) + y frac(partial T, partial y)
    + z frac(partial T, partial z)$ on the spherical boundary.

#image("./images/3d-boundary-value-problem-graph.png")

#pagebreak()

== Initial-boundary value problem (IBVP)
An *initial-boundary value problem (IBVP)* is a problem that involves solving a
time *dependent* partial differential equation in a physical domain subject to
the given initial conditions and boundary conditions.

=== 1D example
A 1D initial-boundary value problem for the vibration of a thin elastic string.

Solve:
$
    frac(partial^2 u, partial x^2) = 1 / c^2
    frac(partial^2 u, partial t^2) "for" 0 < x < L "and" t > 0
$

Subject to the following initial conditions:
$
    u (x, 0) = G (x), "and"
    evaluated(frac(partial u, partial t))_(t = 0) = 0 "for" 0 < x < L
$

And the following boundary conditions:
$
    u (0, t) = 0 "and" u (L, t) = 0 "for" t > 0
$

- The elastic string lies on the $x$ axis from $x = 0$ to $x = L$ when it is not
    vibrating.
- The physical solution is given by $0 < x < L$ and the boundary points are
    $x = 0$ and $x = L$.
- When the string vibrates, its upward displacement $u$ from the $x$ axis
    changes from point to point and from time to time.
- So, $u$ is a function of the $x$ coordinate and time $t$.
- The boundary conditions are those for a string with ends at $x = 0$ and
    $x = L$ that are fixed (not allowed to move).
- The first initial condition describes the shape of the string at time $t = 0$.
- The shape is given by $y = G (x)$, where $G (x)$ is a given function.
- The second states that the string is at rest at $t = 0$.

#heading(
    level: 2,
    [Solving 1st and 2nd order homogeneous linear ordinary differential
        equations with constant coefficients],
)

Consider a homogeneous linear ordinary differential equation in $y (x)$ given
by:
$ a frac(d^2 y, d x^2) + b frac(d y, d x) + c y = 0 $

Where $a, b$ and $c$ are constant coefficients. To construct the general
solution of this ordinary differential equation, we let
$mathred(y(x) = e^(lambda x))$, where $lambda$ is a constant.

Hence:
$
    frac(d y, d x)
    = lambda e^(lambda x) "and" frac(d^2, d x^2) = lambda^2 e^(lambda x)
$

Substituting into the ordinary differential equation gives:
$ e^(lambda x) (a lambda^2 + b lambda + c) = 0 $
$ a lambda^2 + b lambda + c = 0 $

#pagebreak()

=== Case 1 ($a = 0, b eq.not 0$)
For this case, $a = 0, b eq.not 0$. The ordinary differential equation is of
order 1, which means it is given by:
$ b frac(d y, d x) + c y = 0 $

Solving the equation in $lambda$, we obtain $mathred(lambda = -c/b)$. The
general solution of the 1st order ordinary differential equation is given by:
$ mathred(y = A e^(-(c x)/b)) $

Where $A$ is an arbitrary constant. Note that the general solution of a 1st
order ordinary differential equation has only one arbitrary constant in it.

For example, the general solution of $frac(d y, d x) - 8 y = 0$ is
$y = A e^(8 x)$.

=== Case 2 ($a eq.not 0, b^2 - 4 a c > 0$)
For this case, $a eq.not 0, b^2 - 4 a c > 0$. In this case, the quadratic
equation in $lambda$ has two distinct real solutions. If the two distinct real
solutions are given by $mathred(lambda = lambda_1)$ and
$mathred(lambda = lambda_2)$ ($lambda_1 eq.not lambda_2$), then the general
solution of the 2nd order ordinary differential equation is:

$ mathred(y = A e^(lambda_1 x) + B e^(lambda_2 x)) $

Where $A$ and $B$ are arbitrary constants.

For example, for the ordinary differential equation:
$ frac(d^2 y, d x^2) - frac(d y, d x) - 2 y = 0 $

We obtain the quadratic equation $lambda^2 - lambda - 2 = 0$, which has
solutions $lambda = 2$ and $lambda = - 1$. Hence, the general solution of the
ordinary differential equation is:
$ y = A e^(2 x) + B e^(- x) $

=== Case 3 ($a eq.not 0, b^2 - 4 a c = 0$)
In this case, $a eq.not 0, b^2 - 4 a c = 0$. The quadratic equation in $lambda$
has only one solution which is given by $mathred(lambda = - b/(2a))$. The
general solution of the 2nd order ordinary differential equation is:
$ mathred(y = (A x + B) e^(-frac(b x, 2 a))) $

Where $A$ and $B$ are arbitrary constants.

For example, for the ordinary differential equation:
$ frac(d^2 y, d x^2) - 6 frac(d y, d x) + 9 y = 0 $

We obtain the quadratic equation $lambda^2 - 6 lambda + 9 = 0$, which has only
one solution $lambda = 3$. Hence, the general solution of the ordinary
differential equation is:
$ y = (A x + B) e^(3 x) $

#pagebreak()

=== Case 4 ($a eq.not 0, b^2 - 4 a c < 0$)
In this case, $a eq.not 0, b^2 - 4 a c < 0$. The quadratic equation in $lambda$
has two distinct complex solutions. If the two complex solutions are given by
$mathred(lambda = alpha + i beta)$ and $mathred(lambda = alpha - i beta)$, where
$i = sqrt(- 1)$ and $alpha$ and $beta$ are real numbers, then the general
solution of the 2nd order ordinary differential equation is:

$ mathred(y = e^(alpha x)(A cos beta x + B sin beta x)) $

Where $A$ and $B$ are arbitrary constants.

For example, the ordinary differential equation:
$ frac(d^2 y, d x^2) + 16 y = 0 $

We obtain the quadratic equation $lambda^2 + 16 = 0$, which gives
$lambda = plus.minus 4 i$, so $alpha = 0$ and $beta = 4$. Hence, the general
solution of the ordinary differential equation is:
$ y = A cos 4 x + B sin 4 x $

#pagebreak()

== Fourier series problem 1 (FSP1)
If $f (x)$ is a continuous function over the interval $0 < x < L$, can we
represent $f (x)$ by a cosine series, that is, can we find constants
$a_m med (m = 0, 1, 2, 3, dots.h)$ such that:
$
    a + sum_(n = 1)^oo a_n cos (frac(n pi x, L)) = f (x) "for" 0 < x < L
$

=== Solution
By taking:
$ a_0 = 1 / L integral_0^L f (x) thin dif x $
$
    a_n = 2 / L integral_0^L f (x) cos (frac(n pi x, L)) thin dif x
    "for" n = 1, 2, 3, ...
$

We can make:
$ a_0 + sum_(n = 1) a_n cos (frac(n pi x, L)) = f (x) "for" 0 < x < L $

=== Example
Consider the function $f (x) = x$ for $0 < x < 1$. This function is continuous
over the given interval and can be made equal to the cosine series. Working out
the coefficients of the terms in the cosine series, we obtain:
$ a_0 = integral_0^1 x thin dif x = 1 / 2 $
$
    a_n & = 2 integral_0^1 x cos (n pi x) dif x \
        & = (2 cos (n pi) - 1)/(n^2 pi^2) "for" n = 1, 2, 3, ...
$

Hence:
$
    1 / 2 + sum_(n = 1)^oo frac(2 (cos (n pi) - 1), n^2 pi^2) cos (n pi x)
    = x "for" 0 < x < 1
$

To check, take $x = 1 / 4$ and evaluate the left-hand side by computing only the
first 20 terms in the series:

$
    1/2 + sum_(n = 1)^(20) (2 cos (n pi) - 1)/(n^2 pi^2) cos (frac(n pi, 4))
    = 0.24993189 ... quad ("close to" 1/4 "as expected")
$

#pagebreak()

== Fourier series problem 2 (FSP2)
If $f (x)$ is a continuous function over the interval $0 < x < L$, can we
represent $f (x)$ by a sine series, that is, can we find constants
$b_n med (n = 0, 1, 2, 3, dots.h)$ such that:
$ sum_(n = 1)^oo b_n sin (frac(n pi x, L)) = f (x) "for" 0 < x < L $

=== Solution
By taking:
$
    b_n = 2 / L integral_0^L f (x) sin (frac(n pi x, L)) thin dif x
    "for" n = 1, 2, 3, dots.h
$

We can make:
$ sum_(n = 1)^oo b_n sin (frac(n pi x, L)) = f (x) "for" 0 < x < L $

=== Example
This function $f (x) = x$ for $0 < x < 1$ can also be made equal to the sine
series. Working out the coefficients of the terms in the sine series, we obtain:
$
    b_n = 2 integral_0^1 x sin (n pi x) thin dif x = - frac(2 cos (n pi), n pi)
    "for" n = 1, 2, 3, dots.h
$

Hence:
$
    - sum_(n = 1)^oo frac(2 cos (n pi), n pi) sin (n pi x) = x "for" 0 < x < 1
$

To check, take $x = 1 / 4$ and evaluate the left-hand side by computing only the
first 500 terms in the series:

$
    - sum_(n = 1)^500 frac(2 cos n pi, n pi) sin (frac(n pi, 4))
    = 0.251318 ... quad ("close to" 1/4 "as expected")
$

#pagebreak()

= A vibrating string problem <vibrating-string-problem>

#image("./images/vibrating-string-problem.png")

A thin elastic string lies horizontally on the $x$ axis from $x = 0$ to $x = L$
when it is not vibrating. The ends of the string at $x = 0$ and $x = L$ are
attached to the walls and are not allowed to move.

#image("./images/vibrating-string-problem-initial.png")

At time $t = 0$, every point on the string is slightly displaced upward to give
the string a certain shape and the string is released from rest to vibrate. We
are interested in predicting how the string vibrates.

#image("./images/vibrating-string-problem-time-t.png")

Above is a sketch of the shape of the string at a general fixed time instant
$t$.

Let $u$ be the upward displacement of the string from the $x$ axis. We can see
that $u$ varies from point to point along the $x$ axis. The displacement $u$
also changes with $t$, as the shape of the string changes with time. Hence, the
displacement $u$ is a function of two variables $x$ and $t$.

The problem of is the find the displacement $u (x, t)$.

#pagebreak()

== Derivation of the 1D wave equation for the vibrating string
If $f$ is a real function of the $x$ coordinate and time $t$, we define the
first order partial derivative:
$
    frac(partial f, partial x) = lim_(Delta x arrow.r 0)
    frac(f (x + Delta x, t) - f (x, t), Delta x)
$

It follows that:
$
    frac(partial^2 f, partial x^2)
    = frac(partial (frac(partial f, partial x)), partial x)
    = lim_(Delta x arrow.r 0)
    frac(
        evaluated(frac(partial f, partial x))_((x + Delta x, t))
        - evaluated(frac(partial f, partial x))_((x, t)), Delta x
    )
$

For a fixed $t$, plotting the function $f (x, t)$ against $x$ is as follows:
#cimage(
    "./images/vibrating-string-problem-function-plot.png",
    height: 15em,
)

$
    "Slope of the tangent" = evaluated(frac(partial f, partial x))_((X, t))
$
$ "Slope of the tangent" = tan theta $
$ therefore quad evaluated(frac(partial f, partial x))_((X, t)) = tan theta $

Divide the string up into many small portions and examine the motion of a
typical portion lying between $x$ and $x + Delta x$. If the density (mass per
unit length) of the string is a constant given by $rho$, the mass of the portion
is given by $rho Delta x$.

#image("./images/vibrating-string-problem-small-portion.png")

Assumptions:

- The vibration of the string is very small.
- The portion of the string moves up and down vertically.
- The only force acting on the string is the tension in the string.

Below is a sketch of the portion of the string at a fixed time $t$.

#cimage(
    "./images/vibrating-string-problem-small-portion-function-plot.png",
    height: 15em,
)

Having no sideway motion implies no net horizontal force.
$ T_1 cos theta_1 = T_2 cos theta_2 $

Tension force at $A$ is tangential to the string at $A$:
$ evaluated(frac(partial u, partial x))_((x, t)) = tan theta_1 $

Tension force at $B$ is tangential to the string at $B$:
$ evaluated(frac(partial u, partial x))_((x + Delta x, t)) = tan theta_2 $

#cimage(
    "./images/vibrating-string-problem-"
        + "small-portion-function-plot-a-and-b.png",
    height: 10em,
)

Net upward force acting on the portion of the string is given by:
$ T_2 sin theta_2 - T_1 sin theta_1 $

Newton's law of motion ($F = m a$) gives:
$
    T_2 sin theta_2 - T_1 sin theta_1
    = rho Delta x evaluated(frac(partial^2 u, partial t^2))_((xi, t))
$

Note that the centre of mass of the portion is located at $x = xi$.

No sideway motion implies no net horizontal force:
$ T_1 cos theta_1 = T_2 cos theta_2 = T med ("positive constant") $

$ therefore quad T_1 = frac(T, cos theta_1) "and" T_2 = frac(T, cos theta_2) $

#pagebreak()

Newton's law of motion:
$
    T_2 sin theta_2 - T_1 sin theta_1
    = rho Delta x evaluated(frac(partial^2 u, partial t^2))_((xi, t))
$
$
    T (tan theta_2 - tan theta_2)
    = rho Delta x evaluated(frac(partial^2 u, partial t^2))_((xi, t))
$

Tension forces at $A$ and $B$ are tangential to the string at $A$ and $B$:
$ evaluated(frac(partial u, partial x))_((x, t)) = tan theta_1 $
$ evaluated(frac(partial u, partial x))_((x + Delta x, t)) = tan theta_2 $

Newton's law of motion can be rewritten as:
$
    frac(
        evaluated(frac(partial u, partial x))_((x + Delta x, t))
        - evaluated(frac(partial u, partial x))_((x, t)), Delta x
    )
    = rho / T evaluated(frac(partial^2 u, partial t^2))_((xi, t))
$

Taking the limit of $Delta x arrow.r 0$:
$
    lim_(Delta x arrow.r 0)
    frac(
        evaluated(frac(partial u, partial x))_((x + Delta x, t))
        - evaluated(frac(partial u, partial x))_((x, t)), Delta x
    )
    = lim_(Delta x arrow.r 0) rho / T
    evaluated(frac(partial^2 u, partial t^2))_((xi, t))
$

Using:
$
    frac(partial^2 f, partial x^2)
    = frac(partial (frac(partial f, partial x)), partial x)
    = lim_(Delta x arrow.r 0)
    frac(
        evaluated(frac(partial f, partial x))_((x + Delta x, t))
        - evaluated(frac(partial f, partial x))_((x, t)), Delta x
    )
$

Note that $xi arrow.r x$ as $Delta x arrow.r 0$. We obtain the 1D wave equation:
$
    1 / c^2 frac(partial^2 u, partial t^2)
    = frac(partial^2 u, partial x^2) "if we let"
    1 / c^2 = rho / T quad ("that is," c = sqrt(T / rho))
$

The above is the partial differential equation to solve for the displacement
$u (x, t)$ of the vibrating string.

#pagebreak()

== D'Alembert solution for the 1D wave equation
Can we find solutions of the form $u (x, t) = f (x + p t)$, where $p$ is a
constant and $f$ is twice differentiable function of one variable, for the 1D
wave equation?

For example, if we take $f (x) = x^5$, can we find solutions of the form
$u (x, t) = (x + p t)^5$, where $p$ is a constant, for the 1D wave equation?

If we let $xi = x + p t$, then $u (x, t) = xi^5$ and:
$
    frac(partial u, partial x)
    = frac(d, d xi) (xi^5) dot.op frac(partial xi, partial x) = 5 xi^4
$
$
    frac(partial^2 u, partial x^2)
    = frac(d, d xi) (5 xi^4) dot.op frac(partial xi, partial x) = 20 xi^3
$
$
    frac(partial u, partial t)
    = frac(d, d xi) (xi^5) dot.op frac(partial xi, partial t) = 5 p xi^4
$
$
    frac(partial^2 u, partial t^2)
    = frac(d, d xi) (5 p xi^4) dot.op frac(partial xi, partial t) = 20 p^2 xi^3
$

$ 1 / c^2 frac(partial^2 u, partial t^2) = frac(partial^2 u, partial x^2) $
$ frac(20 p^2 xi^3, c^2) = 20 xi^3 $
$ p^2 / c^2 = 1 $
$ p = plus.minus c $

#pagebreak()

Hence, $u (x, t) = (x + c t)^5$ and $u (x, t) = (x - c t)^5$ are solutions of
the 1D wave equation.

More generally, if we let $u (x, t) = f (x + p t)$ and $xi = x + p t$, then
$u (x, t) = f (xi)$ and:
$
    frac(partial u, partial x)
    = frac(d f, d xi) dot.op frac(partial xi, partial x) = frac(d f, d xi)
$
$
    frac(partial^2 u, partial x^2)
    = frac(d, d xi) (frac(d f, d xi)) dot.op frac(partial xi, partial x)
    = frac(d^2 f, d xi^2)
$
$
    frac(partial u, partial t)
    = frac(d f, d xi) dot.op frac(partial xi, partial t) = p frac(d f, d xi)
$
$
    frac(partial^2 u, partial t^2)
    = frac(d, d xi) (p frac(d f, d xi)) = p^2 frac(d^2 f, d xi^2)
$

$ 1 / c frac(partial^2 u, partial t^2) $
$ p^2 / c^2 frac(d^2 f, d xi^2) = frac(d^2 f, d xi^2) $
$ p^2 / c^2 = 1 $
$ p = plus.minus c $

Hence, $u (x, t) = F (x + c t)$ and $u (x, t) = G (x - c t)$ are solutions of
the 1D wave equation, if $F (x)$ and $G (x)$ are any arbitrary twice
differentiable functions of $x$.

Since the 1D wave equation is homogeneous linear, we can write:
$ u (x, t) = F (x + c t) + G (x - c t) $

== Interpretation of the parameter $c$ in the 1D wave equation
Consider an infinitely long string lying on the $x$ axis from $- oo$ to $oo$.
From D'Alembert solution, let the displacement of the string by given by
$u (x, t) = G (x - c t)$, (if we take $F (x + c t) = 0$).

#image("./images/interpretation-of-the-parameter-c-graph.png")

- The graph of $y = G (x - c tau$ is obtained by shifting the graph of
    $y = G (x)$ by $c tau$ units to the right.
- Hence, if $y = G (x)$ is a pulse in the string at $t = 0$, the pulse travels
    to the right by a distance of $c tau$ during a time period of $tau$, that is
    with a speed $c$.
- This gives us a physical interpretation for $c$, which is the speed at which a
    wave travels on the string.
- We refer to $c$ as the wave speed of the string.
- We can also see that the D'Alembert solution gives us the sum of waves
    travelling with speed $c$ to the left and the right.

== Initial-boundary value problem for the vibrating string
The initial-boundary value problem for the vibrating string problem here is
stated as follows. Solve:
$
    frac(partial^2 u, partial x^2)
    = 1 / c^2 frac(partial^2 u, partial t) "for" 0 < x < L "and" t > 0
$

Subject to:
$
    u (x, 0) = G (x)
    "and" evaluated(frac(partial u, partial t))_(t = 0) = 0 "for" 0 < x < L
$
$
    u (0, t) = 0
    "and" u (L, t) = 0 "for" t > 0
$

- For an initial-boundary value problem, the number of initial conditions needed
    is given by the highest order of the time derivative of the unknown function
    in the partial differential equation.
- The wave equation has the 2nd order time derivative of the displacement as the
    highest order time derivative.
- Hence, we have two initial conditions in the initial-boundary value problem
    for the vibrating string.

== Solving the initial-boundary value problem for the vibrating string

=== Step 1
Apply the method of separation of variables on the partial differential equation
to obtain a set of ordinary differential equations.

- Let $u (x, t) = X (x) T (t)$.
- Working out the partial derivatives in the partial differential equation:
    $
        frac(partial^2 u, partial x^2)
        = frac(d^2 X, d x^2) dot.op T (t) = X'' (x) T (t)
    $
    $
        frac(partial^2 u, partial t^2)
        = X (x) dot.op frac(d^2 T, d t^2) = X (x) T'' (t)
    $
- Substituting into the partial differential equation:
    $ X'' (x) T (t) = 1 / c^2 X (x) T'' (t) $
- Divide both sides by $X (x) T (t)$:
    $
        frac(X'' (x), X (x)) = 1 / c^2 frac(T'' (t), T (t))
        = gamma med ("arbitrary constant")
    $
- We obtain a pair of ordinary differential equations:
    $ X'' (x) - gamma X (x) = 0 $
    $ T'' (t) - gamma c^2 T (t) = 0 $

=== Step 2
- Solve the ordinary differential equations to find non-trivial (non-zero)
    solutions satisfying the boundary conditions.
- The ordinary differential equations have different forms of general solutions
    depending on whether $gamma$ is zero, positive or negative.
- So, we will consider 3 separate cases.

==== Case $gamma = 0$

- The ordinary differential equations are given by $X'' (x) = 0$ and
    $T'' (t) = 0$.
- Integrating each ordinary differential equation twice, we obtain the general
    solutions:
    $ X (x) = A x + B $
    $ T (t) = C t + D $
    Where $A, B, C$ and $D$ are arbitrary constants.
- Thus, we obtain $u (x, t) = (A x + b) (C t + D)$.
- The boundary condition $u (0, t) = 0$ gives $B (C t + D) = 0$.
- If we take $(C t + D) = 0$, we end up with the trivial solution
    $u (x, t) = 0$.
- To avoid the trivial solution here, we have to choose $B = 0$.
- Similarly, the boundary condition $u (L, t) = 0$ gives
    $(A L + B) (C t + D) = 0$, which gives $A L + B = 0$.
- Hence, with $B = 0$, we find that $A = 0$ and end up with only the trivial
    solution $u (x, t) = 0$ for $gamma = 0$.

#pagebreak()

==== Case $gamma = p^2$

- Here $p$ is a non-zero real number, so that $gamma$ is positive.
- For $X (x)$:
    $ X'' (x) - p^2 X (x) = 0 $
    $ X (x) = e^(lambda x) $
    $ lambda^2 - p^2 = 0 $
    $ lambda = p "and" lambda = - p $
- General solution for $X (x)$:
    $ X (x) = A e^(p x) + B e^(- p x) $
- For $T (t)$:
    $ T'' (t) - p^2 c^2 T (t) = 0 $
    $ T (t) = e^(lambda t) $
    $ lambda^2 - p^2 c^2 = 0 $
    $ lambda = p c "and" lambda = - p c $
- General solution for $T (t)$:
    $ T (t) = C e^(p c t) + D e^(- p c t) $
- Thus, we obtain:
    $
        u (x, t) = (A e^(p x) + B e^(- p x)) (C e^(p c t) + D e^(- p c t))
    $
- The boundary condition $u (0, t) = 0$ gives:
    $ mathred((A + B)) (C e^(p c t) + D e^(-p c t)) = 0 $
- The boundary condition $u (L, t) = 0$ gives:
    $ mathred((A e^(p L) + B e^(-p L)))(C e^(p c t) + D e^(-p c t)) = 0 $
- From $mathred((A + B) = 0)$ and $mathred((A e^(p L) + B e^(-p L)) = 0)$, we
    obtain:
    $ A = 0 "and" B = 0 $
- Again, we end up with only the trivial solution $u (x, t) = 0$ for
    $gamma = p^2$.

#pagebreak()

==== Case $gamma = - p^2$

- Here $p$ is a non-zero real number, so that $gamma$ is negative.

- For $X (x)$:
    $ X'' (x) - p^2 X (x) = 0 $
    $ X (x) = e^(lambda x) $
    $ lambda^2 + p^2 = 0 $
    $ lambda = i p "and" lambda = - i p $

- General solution for $X (x)$:
    $ X (x) = A sin p x + B cos p x $

- For $T (t)$:
    $ T'' (t) + p^2 c^2 T (t) = 0 $
    $ T (t) = e^(lambda t) $
    $ lambda^2 + p^2 c^2 = 0 $
    $ lambda = i p c "and" lambda = - i p c $

- General solution for $T (t)$:
    $ T (t) = C sin p c t + D cos p c t $

- Thus, we obtain:
    $
        u (x, t) = (A sin p x + B cos p x) (C sin p c t + D cos p c t)
    $

- The boundary condition $u (0, t) = 0$ gives:
    $ B (C sin p c t + D cos p c t) = 0 $
    $ therefore quad B = 0 $

- Letting $E = A C$ and $F = A D$:
    $ u (x, t) = (E sin p c t + F cos p c t) sin p x $

- The boundary condition $u (L, t) = 0$ gives:
    $ (E sin p c t + F cos p c t) sin p L = 0 $

- This gives $sin p L = 0$, that is:
    $
        p L = n pi
        "for" n = 0, plus.minus 1, plus.minus 2, plus.minus 3, dots.h
    $

#pagebreak()

- The second boundary condition is satisfied if we choose $p L = n pi$ for
    $n = 0, plus.minus 1, plus.minus 2, plus.minus 3, dots.h$.

- For a given integer $n$, we have a non-trivial solution satisfying both
    boundary conditions.

- For a given positive integer $n$, we denote the solution by:
    $
        u_n (x, t) = (E_n sin frac(n pi c t, L)
            + F_n cos frac(n pi c t, L)) sin frac(n pi x, L)
        "for" n = 1, 2, 3, dots.h
    $

    Where:
    - $E_n$ and $F_n$ are arbitrary constants.

- We ignore $n = 0$ as it gives the trivial solution $u (x, t) = 0$.

- Negative integers $n$ can also be ignored, as they give solutions of
    essentially the same form as positive $n$.

#pagebreak()

=== Step 3
- Sum up the non-trivial (non-zero) solutions satisfying the boundary conditions
    to obtain a series solution.
    $
        u_n (x, t) = (E_n sin frac(n pi c t, L)
            + F_n cos frac(n pi c t, L)) sin frac(n pi x, L)
        "for" n = 1, 2, 3, dots.h
    $
- The 1D wave equation, the partial differential equation in the
    initial-boundary value problem, is homogeneous linear.
- According to the linear theorem of superposition of solutions of a homogeneous
    linear partial differential equation, the sum of all these solutions is
    still a solution of the 1D wave equation.
- Summing up all the solutions satisfying the boundary conditions, we obtain the
    series solution:
    $
        u (x, t) = sum_(n = 1)^oo (E_n sin frac(n pi c t, L)
            + F_n cos frac(n pi c t, L)) sin frac(n pi x, L)
    $
- We can easily verify that the series solutions also satisfies the two boundary
    conditions by substituting $x = 0$ and $x = L$ into the series.

=== Step 4
- Tackling the initial conditions:
    $
        u (x, t) = sum_(n = 1)^oo (E_n sin frac(n pi c t, L)
            + F_n cos frac(n pi c t, L)) sin frac(n pi x, L)
    $
    $
        frac(partial u, partial t)
        &= sum_(n = 1)^oo frac(partial, partial t) (E_n sin frac(n pi c t, L)
            + F_n cos frac(n pi c t, L)) sin frac(n pi x, L) \
        &= sum_(n = 1)^oo (E_n cos frac(n pi c t, L)
            - F_n sin frac(n pi c t, L)) sin frac(n pi x, L)
    $
    $
        evaluated(frac(partial u, partial t))_(t = 0)
        = sum_(n = 1)^oo frac(n pi c, L) E_n sin frac(n pi x, L)
    $
    $ evaluated(frac(partial u, partial t))_(t = 0) = 0 $
    $
        sum_(n = 1)^oo frac(n pi c, L) E_n sin frac(n pi x, L) = 0
        "for" 0 < x < L
    $
- The second initial condition is satisfied if we choose $E_n = 0$.
- The series solution of the partial differential equation is reduced to:
    $
        u (x, t) = sum_(n = 1)^oo F_n cos frac(n pi c t, L) sin frac(n pi x, L)
    $
- Since:
    $ u (x, 0) = G (x) "for" 0 < x < L $
- Then:
    $
        sum_(n = 1)^oo sin frac(n pi x, L) = G (x) "for" 0 < x < L
    $

#pagebreak()

- The above is Fourier series problem 2, which can be expressed as:
    $
        F_n = 2 / L integral_0^L G (x) sin frac(n pi x, L) thin dif x
        "for" n = 1, 2, 3, dots.h
    $
- Once the coefficients $F_n$ are determined, they can be substituted into the
    series solution above to obtain the final solution of the initial-boundary
    value problem.

#pagebreak()

== Example 1
#image("./images/vibrating-string-problem-example-1.png")

Initial shape of the string:

$
    G(x) = cases(
        x/10 "for" 0 < x <= L/2,
        (L - x)/10 "for" L/2 < x < L
    )
$

$
    F_n & = 2/L integral_0^L G(x) sin frac(n pi x, L) thin dif x \
        & = 2/L integral_0^(L/2) x/10 sin frac(n pi x, L) thin dif x
          + 2/L integral_(L/2)^L frac(L - x, 10) sin frac(n pi x, L) thin dif x
$

$ F_n = frac(2L sin frac(n pi, 2), 5n^2 pi^2) $

The required final solution is:

$
    u(x, t) & = sum_(n = 1)^oo F_n cos frac(n pi c t, L) sin frac(n pi x, L) \
            & = sum_(n = 1)^oo frac(2L sin frac(n pi, 2), 5n^2 pi^2)
              cos frac(n pi c t, L) sin frac(n pi x, L)
$

#pagebreak()

== Example 2
Initial shape of the string:
$ G (x) = 2 sin frac(3 pi x, L) - 3 sin frac(5 pi x, L) $
$
    sum_(n = 1)^oo sin frac(n pi x, L)
    = 2 sin frac(3 pi x, L) - 3 sin frac(5 pi x, L) "for" 0 < x < L
$

In this example, instead of using the integral formula in Fourier series problem
2 to work out $F_n$, we can do a direct comparison of the left-hand side and the
right-hand side in the equation above to find $F_n$.

- The 1st term on the right-hand side appears in the 3rd term (given by $n = 3$)
    in the series.
- So $F_3 = 2$.
- The 2nd term on the right-hand side appears in the 5th term (given by $n = 5$)
    in the series.
- So $F_5 = - 3$.
- All other coefficients $F_n$ are taken to be zero.

The final solution is:
$
    u (x, t) = 2 cos frac(3 pi c t, L) sin frac(3 pi x, L)
    - 3 cos frac(5 pi c t, L) sin frac(5 pi x, L)
$

#pagebreak()

= Equations for linear heat conduction in solids

== Solid
#cimage("./images/heat-conduction-solid-graph.png", height: 20em)
Consider a solid occupying a 3D region denoted by $R$. With reference to a
Cartesian coordinate system, a point in the region $R$ is denoted by
$(x, y, z)$.

According to the linear theory of heat conduction, the temperature $phi.alt$ in
$R$, which is a function of the point $(x, y, z)$ and time $t$, satisfies the
partial differential equation:

$
    mathred(
        frac(
            partial^2
            phi, partial x^2
        ) + frac(partial^2 phi, partial y^2) +
        frac(partial^2 phi, partial z^2) = frac(rho c, k) frac(
            partial
            phi, partial t
        )
    )
$

Where:
- $rho$ is the density of the solid
- $c$ is the specific heat of the solid
- $k$ is the thermal conductivity of the solid

This partial differential equation, know as the *heat equation*;, may be derived
from the law of conservation of energy by assuming the solid is homogeneous and
thermally isotropic and that there is no internal heat generation.

#pagebreak()

== Surface
#cimage(
    "./images/heat-conduction-surface-graph.png",
    height: 20em,
)
Consider a surface. The surface denoted by $S$ may be a virtually created one
inside the solid that occupies the region $R$, or it may be part of the boundary
of the solid. Let $[n_x, n_y, n_z]$ be a unit normal (perpendicular) vector to
the surface $S$ at the point $(x, y, z)$.

At the point $(x, y, z)$, the heat flux (thermal energy per unit are per unit
time) flowing through the surface $S$ along the direction of the normal vector
$[n_x, n_y, n_z]$ is given by:

$
    mathred(
        -k (n_x frac(partial phi.alt, partial x)
            + n_y frac(partial phi.alt, partial y)
            + n_z frac(partial phi.alt, partial z))
    )
$

If the surface is a thermally insulated part of the boundary of the solid then:
$
    n_x frac(partial phi.alt, partial x)
    + n_y frac(partial phi.alt, partial y)
    + n_z frac(partial phi.alt, partial z) = 0 "at all points on" S
$

#pagebreak()

== Initial-boundary value problem with no temperature specified on the boundary
<ibvp-no-temp>

- A solid occupies the region between two planes $x = 0$ and $x = L$.

- Below is the cross-section of the solid.

    #cimage(
        "./images/heat-conduction-solid-cross-section.png",
        height: 20em,
    )

- The temperature $phi.alt$ varies with only the Cartesian coordinate $x$ and
    time $t$, and it satisfies the 1D heat equation:
    $
        frac(partial^2 phi.alt, partial x^2)
        = frac(rho c, k) frac(partial phi.alt, partial t)
    $

- The temperature $phi.alt$ is maintained at 0 on the planes $x = 0$ and $x = L$
    for $t > 0$.

- The temperature $phi.alt$ is known at time $t = 0$ for $0 < x < L$.

- We are interested in finding the temperature $phi.alt (x, t)$ for $0 < x < L$
    and $t > 0$.

- The initial-boundary value problem of interest is to solve:
    $
        frac(partial^2 phi.alt, partial x^2)
        = frac(rho c, k) frac(partial phi.alt, partial t)
        "for" 0 < x < L "and" t > 0
    $

    Subject to:
    $ phi.alt (x, 0) = f (x) "for" 0 < x < L $
    $
        phi.alt (0, t) "and" phi.alt (L, t) = 0 "for" t > 0
    $

- Note that the order of the highest order partial derivative of $phi.alt$ with
    respect to time $t$ in the partial differential equation is one.

- Hence, only one initial condition is specified in the initial-boundary value
    problem.

- The initial temperature is given by the function $f (x)$.

#pagebreak()

=== Step 1
Apply the method of separation of variables on the 1D heat equation to obtain a
set of ordinary differential equations.

- Let $phi.alt (x, t) = X (x) T (t)$.
- Substitute into the 1D heat equation:
    $ X'' (x) T (t) = frac(rho c, k) X (x) T' (t) $
- Divide both sides by $X (x) T (t)$:
    $
        frac(X'' (x), X (x))
        = frac(rho c, k) frac(T' (t), T (t)) = gamma med ("constant")
    $
- We obtain a set of ordinary differential equations:
    $ X'' (x) - gamma X (x) = 0 $
    $ T' (t) - frac(gamma k, rho c) T (t) = 0 $

=== Step 2
Solve the ordinary differential equations to find non-trivial (non-zero)
solutions satisfying the boundary conditions.

==== Case $gamma = 0$

- The ordinary differential equations are given by $X'' (x) = 0$ and
    $T' (t) = 0$.
- The general solution of the ordinary differential equation in $X (x)$ is
    $mathred(X(x) = A x + B)$, where $A$ and $B$ are arbitrary constants.
- The general solution of the ordinary differential equation in $T (t) = C$,
    where $C$ is an arbitrary constant.
- We obtain $phi(x, t) = C(A x + B) = mathred(D x + E)$, where $D$ and $E$ are
    arbitrary constants.
- From the boundary conditions $phi.alt (0, t) = 0$ and $phi.alt (L, t) = 0$, we
    obtain $D = 0$ and $E = 0$, so we end up with only the trivial solution
    $phi.alt (x, t) = 0$ for $gamma = 0$.

#pagebreak()

==== Case $gamma = p^2$

- Here $p$ is a non-zero real number, so that $gamma$ is positive.
- For $X (x)$:
    $ X'' (x) - p^2 X (x) = 0 $
- General solution for $X (x)$:
    $ X (x) = A e^(p x) + B e^(- p x) $
- For $T (t)$:
    $ T' (t) - frac(p^2 k, rho c) T (t) = 0 $
- General solution for $T (t)$:
    $ T (t) = C e^(frac(p^2 k t, rho c)) $
- Thus, we obtain:
    $
        phi.alt (x, t) = (D e^(p x) + E e^(- p x)) e^(frac(p^2 k t, rho c))
    $
- The boundary condition $phi.alt (0, t) = 0$ gives:
    $ (D + E) e^(frac(p^2 k t, rho c)) = 0 $
- The boundary condition $phi.alt (L, t) = 0$ gives:
    $ (D e^(p L) + E^(- p L)) e^(frac(p^2 k t, rho c)) = 0 $
- From $(D + E) = 0$ and $(D e^(p L) + E e^(- p L)) = 0$, we obtain $D = 0$ and
    $E = 0$.
- We end up with only the trivial solution $phi.alt (x, t) = 0$ for
    $gamma = p^2$.

#pagebreak()

==== Case $gamma = - p^2$

- Here $p$ is a non-zero real number, so that $gamma$ is negative.
- For $X (x)$:
    $ X'' (x) - p^2 X (x) = 0 $
- General solution for $X (x)$:
    $ X (x) = A sin p x + B cos p x $
- For $T (t)$:
    $ T' (t) - frac(p^2 k, rho c) T (t) = 0 $
- General solution for $T (t)$:
    $ T (t) = C e^(- frac(p^2 k t, rho c)) $
- Thus, we obtain:
    $
        phi.alt (x, t) = (D sin p x + E cos p x) e^(- frac(p^2 k t, rho c))
    $
- The boundary condition $phi.alt (0, t) = 0$ gives:
    $ E e^(- frac(p^2 k t, rho c)) = 0 $
    $ therefore quad E = 0 $
- The boundary condition $phi.alt (L, t) = 0$ gives:
    $ D sin (p L) e^(- frac(p^2 k t, rho c)) = 0 $
- To avoid the trivial solution $phi.alt (x, t) = 0$, we take $sin p L = 0$,
    which is:
    $
        p L = n pi
        "for" n = 0, plus.minus 1, plus.minus 2, plus.minus 3, dots.h
    $
- Hence:
    $ phi.alt (x, t) = D sin (p x) e^(- frac(p^2 k t, rho c)) $
- The first boundary condition is satisfied.
- The second boundary condition is satisfied if we choose $p L = n pi$ for
    $n = 0, plus.minus 1, plus.minus 2, plus.minus 3, dots.h$.
- For a given integer $n$, we have a non-trivial solution satisfying both
    boundary conditions.
- For a given positive integer $n$, we denote the solution by:
    $
        phi.alt_n (x, t) = D_n sin (frac(n pi x, L))
        e^(- frac(n^2 pi^2 k t, rho c L^2)) "for" n = 1, 2, 3, dots.h
    $
- Note that $D_n$ is an arbitrary constant.

#pagebreak()

=== Step 3
- Sum up the non-trivial *non-zero* solution satisfying the boundary conditions
    to obtain a series solution:
    $
        phi.alt_n (x, t) = D_n sin (frac(n pi x, L))
        e^(- frac(n^2 pi^2 k t, rho c L^2)) "for" n = 1, 2, 3, dots.h
    $
- The 1D heat equation is homogeneous linear.
- So, the sum of all these solutions is still a solution of the 1D heat
    equation.
- Summing up all the solutions satisfying the boundary conditions, we obtain the
    series solution:
    $
        phi.alt (x, t) = sum_(n = 1)^oo D_n sin (frac(n pi x, L))
        e^(- frac(n^2 pi^2 k t, rho c L^2))
    $
- We can easily verify that the series solution also satisfies the two boundary
    conditions by substituting $x = 0$ and $x = L$ into the series.

=== Step 4
Tackling the initial conditions:
$
    phi.alt (x, t) = sum_(n = 1)^oo D_n sin (frac(n pi x, L))
    e^(- frac(n^2 pi^2 k t, rho c L^2))
$
$
    phi.alt (x, 0) = sum_(n = 1)^oo D_n sin (frac(n pi x, L))
    = f (x) "for" 0 < x < L
$
$
    D_n = 2 / L integral_0^L f (x) sin (frac(n pi x, L)) thin dif x
    "for" n = 1, 2, 3, dots.h
$

#pagebreak()

== Initial-boundary value problem with thermally insulated boundary
- As before, consider the solid occupy the region between two planes $x = 0$ and
    $x = L$ and having temperature $phi.alt (x, t)$.

    #cimage(
        "./images/heat-conduction-solid-cross-section.png",
        height: 20em,
    )

- A unit normal vector the planes is $[n_x, n_y, n_z] = [1, 0, 0]$.

- The heat flux flowing through the planes in the positive $x$ direction is
    given by:
    $
        - k (n_x frac(partial phi.alt, partial x)
            + n_y frac(partial phi.alt, partial y)
            + n_z frac(partial phi.alt, partial z))
        = - k frac(partial phi.alt, partial x)
    $

- For the initial-boundary value problem, we take the planes $x = 0$ and $x = L$
    to be *thermally insulated*, which means the boundary conditions are given
    by:
    $
        frac(partial phi.alt, partial x) = 0 "on" x = 0 "and" x = L
    $

- The initial-boundary value problem is stated as follows. Solve:
    $
        frac(partial^2 phi.alt, partial x^2)
        = frac(rho c, k) frac(partial phi.alt, partial t)
        "for" 0 < x < L "and" t > 0
    $

    Subject to:
    $ phi.alt (x, 0) = f (x) "for" 0 < x < L $
    $
        evaluated(frac(partial phi.alt, partial x))_(x = 0) = 0 "and"
        evaluated(frac(partial phi.alt, partial x))_(x = L) = 0 "for" t > 0
    $

#pagebreak()

=== Step 1
Apply the method of separation of variables on the 1D heat equation to obtain a
set of ordinary differential equations.

- Let $phi.alt (x, t) = X (x) T (t)$.
    $ X'' (x) - gamma X (x) = 0 $
    $ T' (t) - frac(gamma k, rho c) T (t) = 0 $

=== Step 2
Solve the ordinary differential equations to find non-trivial (non-zero)
solutions satisfying the boundary conditions.

==== Case $gamma = 0$

- As in the previous initial-boundary value problem, we got
    $phi.alt (x, t) = D x + E$, where $D$ and $E$ are arbitrary constants.
- It follows that $frac(partial phi.alt, partial x) = D$.
- To satisfy the boundary conditions at $x = 0$ and $x = L$, we take $D = 0$.
- There is no restriction on the constant $E$.
- Hence, we have a non-trivial solution for $gamma = 0$,
    $phi.alt_0 (x, t) = E_0$, where $E_0$ is an arbitrary constant.

==== Case $gamma = p^2$ (positive)

- As in the previous initial-boundary value problem, we got:
    $
        phi.alt (x, t) = (D e^(p x) + E e^(- p x)) e^(frac(p^2 k t, rho c))
    $
- It follows that:
    $
        frac(partial phi.alt, partial x)
        = p (D e^(p x) - E e^(- p x)) e^(frac(p^2 k t, rho c))
    $
- To satisfy the boundary conditions at $x = 0$ and $x = L$, we take $D - E = 0$
    and $D e^(p L) - E e^(- p L) = 0$, which give $D = 0$ and $E = 0$.
- We end up with only the trivial solution $phi.alt (x, t) = 0$ for
    $gamma = p^2$.

#pagebreak()

==== Case $gamma = - p^2$ (negative)

- As in the previous initial-boundary value problem, we got:
    $
        phi.alt (x, t) = (D sin p x + E cos p x) e^(- frac(p^2 k t, rho c))
    $
- It follows that:
    $
        frac(partial phi.alt, partial x) = p (D e^(p x) - E e^(- p x))
        e^(frac(p^2 k t, rho c))
    $
    $ evaluated(frac(partial phi.alt, partial x))_(x = 0) "gives" D = 0 $
- To avoid ending up with only the trivial solution $phi.alt (x, t) = 0$ when
    satisfying the thermally insulated BC at $x = L$, we take $sin p L = 0$,
    which is:
    $
        p L = n pi
        "for" n = 0, plus.minus 1, plus.minus 2, plus.minus 3, dots.h
    $
- Hence:
    $ phi.alt (x, t) = E cos (p x) e^(- frac(p^2 k t, rho c)) $
- The first boundary condition is satisfied.
- The second boundary condition is satisfied if we choose $p L = n pi$ for
    $n = 0, plus.minus 1, plus.minus 2, plus.minus 3, dots.h$.
- For a given integer $n$, we have a non-trivial solution satisfying both
    boundary conditions.
- For a given positive integer $n$, we denote the solution by:
    $
        phi.alt_n (x, t) = E_n cos (frac(n pi x, L))
        e^(- frac(n^2 pi^2 k t, rho c L^2)) "for" n = 1, 2, 3, dots.h
    $
- Note that $E_n$ are arbitrary constants.

#pagebreak()

=== Step 3
- Sum up non-trivial (non-zero) solutions satisfying the boundary conditions to
    obtain a series solution.
    $
        phi.alt_n (x, t) = E_n cos (frac(n pi x, L))
        e^(- frac(n^2 pi^2 k t, rho c L^2)) "for" n = 1, 2, 3, dots.h
    $
- Let us not forget the non-trivial solution $phi.alt_0 (x, t) = E_0$, which we
    obtained for the case $gamma = 0$.
- Summing up all the solutions satisfying the boundary conditions, we obtain the
    series solution:
    $
        phi.alt (x, t) = E_0 + sum_(n = 1)^oo cos (frac(n pi x, L))
        e^(- frac(n^2 pi^2 k t, rho c L^2))
    $
- We can easily verify that the series solutions also satisfies the two boundary
    conditions by substituting $x = 0$ and $x = L$ into the series for the
    partial derivative of $phi.alt$ with respect to $x$.

=== Step 4
Tackling the initial conditions:
$
    phi.alt (x, t) = E_0 + sum_(n = 1)^oo E_n cos (frac(n pi x, L))
    e^(- frac(n^2 pi^2 k t, rho c L^2))
$
$
    phi.alt (x, 0) = E_0 + sum_(n = 1)^oo E_n cos (frac(n pi x, L))
    = f (x) "for" 0 < x < L
$
$ E_0 = 1 / L integral_0^L f (x) thin dif x $
$
    E_n = 2 / L integral_0^L f (x) cos (frac(n pi x, L)) thin dif x
    "for" n = 1, 2, 3, dots.h
$

= Reformulating initial-boundary value problems
- Consider a 1D initial-boundary value problem governed by a linear partial
    differential equation in $phi.alt (x, t)$ with linear boundary conditions.

- If the partial differential equation or the boundary conditions are
    non-homogeneous, we can try to reformulate the initial-boundary value
    problem by using the substitution:
    $ mathred(phi(x, t) = U(x, t) + psi(x, t)) $

    Where $U (x, t)$ is *any* function that satisfies the partial differential
    equation and the boundary conditions.

- If $U (x, t)$ can be found, we can reformulate the initial-boundary value
    problem in terms of $psi (x, t)$ with homogeneous linear partial
    differential equation and boundary conditions in $psi (x, t)$.

- Finding $U (x, t)$ may not be an easy task, but it may be easier than solving
    the initial-boundary value problem, since we do not have to worry about
    satisfying the initial conditions.

#pagebreak()

== Example 1
Solve:
$
    frac(partial^2, partial x^2) = frac(partial phi.alt, partial t)
    "for" 0 < x < 2 "and" t > 0
$

Subject to:
$ phi.alt (x, 0) = 2 x "for" 0 < x < 2 $
$
    phi.alt (0, t) = 1 "and" phi.alt (2, t) = 5 "for" t > 0
$

- In this example, the partial differential equation is homogeneous linear and
    the boundary conditions are linear but not homogeneous.

- Reformulate the initial-boundary value problem as one with homogeneous linear
    partial differential equation and boundary conditions by letting:
    $ phi.alt (x, t) = U (x, t) + psi (x, t) $

- We will first look for any function $U (x, t)$ such that
    $frac(partial^2 U, partial x^2) = frac(partial U, partial t)$ and
    $U (0, t) = 1$ and $U (2, t) = 5$.

- Since the nonhomogeneous terms in the boundary conditions are independent of
    time $t$ in this example, we can try looking for $U$ that is independent of
    $t$, so we let $U (x, t) = V (x)$.

- With $U (x, t) = V (x)$, the partial differential equation
    $frac(partial U^2, partial x^2) = frac(partial U, partial t)$ is reduced to
    the ordinary differential equation $frac(d^2 V, d x^2) = 0$, and the
    boundary conditions $U (0, t) = 1$ and $U (2, t) = 5$ become $V (0) = 1$ and
    $V (2) = 5$.

- Integrating $frac(d^2 V, d x^2) = 0$ twice, we obtain $V (x) = A x + B$, where
    $A$ and $B$ are arbitrary constants from the integration.

- From the boundary conditions $V (0) = 1$ and $V (2) = 5$, we find that $A = 2$
    and $B = 1$. Hence, we may take $U (x, t) = 2 x + 1$.

- Reformulate the initial-boundary value problem by letting:
    $ phi.alt (x, t) = 2 x + 1 + psi (x, t) $

- It follows that:
    $
        frac(partial^2 phi.alt, partial x^2)
        = frac(partial^2, partial x^2) (2 x + 1 + psi (x, t))
        = frac(partial^2 psi, partial x^2)
    $
    $
        frac(partial phi.alt, partial t)
        = frac(partial, partial t) (2 x + 1 + psi (x, t))
        = frac(partial psi, partial t)
    $

- The partial differential equation
    $frac(partial^2 phi.alt, partial x^2) = frac(partial phi.alt, partial t)$
    can be written as
    $frac(partial^2 psi, partial x^2) = frac(partial psi, partial t)$.

- From the first boundary condition:
    $ phi.alt (0, t) = 1 + psi (0, t) = 1 $
    $ psi (0, t) = 0 $

#pagebreak()

- From the second boundary condition:
    $ phi.alt (2, t) = 5 + psi (2, t) = 5 $
    $ psi (2, t) = 0 $

- From the initial condition:
    $ phi.alt (x, 0) = 2 x + 1 + psi (x, 0) = 2 x $
    $ psi (x, 0) = - 1 $

- Hence, with $phi.alt (x, t) = 2 x + 1 + psi (x, t)$, the initial-boundary
    value problem of interest here can be reformulated as one that requires
    solving for $psi (x, t)$ as follows. Solve:
    $
        frac(partial^2 psi, partial x^2)
        = frac(partial psi, partial t) "for" 0 < x < 2 "and" t > 0
    $

    Subject to:
    $ psi (x, 0) = - 1 "for" 0 < x < 2 $
    $
        psi (0, t) = 0 "and" psi (2, t) = 0 "for" t > 0
    $

- The partial differential equation and the boundary conditions in the
    reformulated initial-boundary value problem above are homogeneous linear.

- From the #link(<ibvp-no-temp>)[previous section], the series solution of the
    reformulated initial-boundary value problem is given by:
    $
        psi (x, t) = sum_(n = 1)^oo D_n sin (frac(n pi x, 2))
        e^(- frac(n^2 pi^2 t, 4))
    $
    $
        D_n = - integral_0^2 sin frac(n pi x, 2) thin dif x
        = frac(2, n pi) (cos n pi - 1) "for" n = 1, 2, 3, dots.h
    $

- The required solution of the original initial-boundary value problem is given
    by:
    $
        phi.alt (x, t) = 2 x + 1 + sum_(n = 1)^oo frac(2, n pi) (cos n pi - 1)
        sin (frac(n pi x, 2)) e^(- frac(n^2 pi^2 t, 4))
    $

#pagebreak()

== Example 2
- Solve:
    $
        frac(partial^2 phi.alt, partial x^2) + pi^2 / 4 cos frac(pi x, 2)
        = 4 frac(partial phi.alt, partial t) "for" 0 < x < 1 "and" t > 0
    $

    Subject to:
    $ phi.alt (x, 0) = 1 "for" 0 < x < 1 $
    $
        phi.alt (0, t) = 0 "and" phi.alt (1, t) = 2 "for" t > 0
    $

- The partial differential equation and the boundary conditions in the
    initial-boundary value problem above are linear but not homogeneous.

- Reformulate the initial-boundary value problem above in terms of $psi (x, t)$
    by letting:
    $ phi.alt (x, t) = U (x, t) + psi (x, t) $

- We will first find a function $U (x, t)$ such that
    $frac(partial^2 U, partial x^2) + pi^2 / 4 cos frac(pi x, 2)
    = 4 frac(partial U, partial t)$
    and $U (0, t) = 0$ and $U (1, t) = 2$.

- Since the non-homogeneous terms in the partial differential equation and
    boundary conditions are independent of time $t$, we try $U (x, t) = V (x)$.

- The partial differential equation in $U (x, t)$ is reduced to
    $frac(d^2 V, d x^2) = - pi^2 / 4 cos frac(pi x, 2)$ with $V (0) = 0$ and
    $V (1) = 2$.

- Integrate the ordinary differential equation twice:
    $
        frac(d V, d x) = - pi^2 / 4 integral cos frac(pi x, 2) thin dif x
        = - pi / 2 sin frac(pi x, 2) + A
    $
    $ V (x) = integral (- pi / 2 sin (frac(pi x, 2)) + A) thin dif x $
    $ V (x) = cos frac(pi x, 2) + A x + B $

- Applying the boundary conditions $V (0) = 0$ and $V (1) = 2$, we obtain
    $B = - 1$ and $A = 3$.

- Hence, we make the substitution:
    $ phi.alt (x, t) = cos frac(pi x, 2) + 3 x - 1 + psi (x, t) $

#pagebreak()

- With $phi.alt (x, t) = cos frac(pi x, 2) + 3 x - 1 + psi (x, t)$, we can
    verify directly that the originally given initial boundary value problem in
    $phi.alt$ can be reformulated in terms of the initial-boundary value problem
    in $psi$ given below. Solve:
    $
        frac(partial^2 psi, partial x^2)
        = 4 frac(partial psi, partial t) "for" 0 < x < 1 "and" t > 0
    $

    Subject to:
    $
        psi (x, 0) = 2 - cos frac(pi x, 2) - 3 x "for" 0 < x < 1
    $
    $
        psi (0, t) = 0 "and" psi (1, t) = 0 "for" t > 0
    $

- The partial differential equation and the boundary conditions in the
    reformulated initial-boundary value problem above are homogeneous linear.

- The initial condition may be a bit more complicated than before, but the
    initial-boundary value problem can be solved by the method of separation of
    variables together with Fourier series.

#pagebreak()

== Example 3
- Solve:
    $
        frac(partial^2 phi.alt, partial x^2) - 6 x e^(- t)
        = frac(partial^2 phi.alt, partial t^2)
        + frac(partial phi.alt, partial t) "for" 0 < x < 1 "and" t > 0
    $

    Subject to:
    $
        phi.alt (x, 0) = x^2 (x - 1)
        "and" evaluated(frac(partial phi.alt, partial t))_(t = 0)
        = 0 "for" 0 < x < 1
    $
    $
        phi.alt (0, t) = 0 "and" phi.alt (1, t) = e^(- t) "for" t > 0
    $

- The partial differential equation and the boundary conditions in the
    initial-boundary value problem above are linear but not homogeneous.

- Reformulating the initial-boundary value problem above in terms of
    $psi (x, t)$ by letting:
    $ phi.alt (x, t) = U (x, t) + psi (x, t) $

- We will first find a function $U (x, t)$ such that
    $frac(partial^2 U, partial x^2) - 6 x e^(- t)
    = frac(partial^2 U, partial t^2) + frac(partial U, partial t)$
    and $U (0, t) = 0$ and $U (1, t) = e^(- t)$.

- The non-homogeneous terms in the partial differential equation and boundary
    conditions contain the factor $e^(- t)$.

- So, we try:
    $ U (x, t) = e^(- t) V (x) $

- Substitute $U (x, t) = e^(- t) V (x)$ into the partial differential equation
    and simplify to obtain the ordinary differential equation:
    $ frac(d^2 V, d x^2) = 6 x $

- The boundary conditions $U (0, t) = 0$ and $U (1, t) = e^(- t)$ give
    $V (0) = 0$ and $V (1) = 1$.

- Integrate $frac(d^2 V, d x^2) = 6 x$ twice to obtain:
    $ V (x) = x^3 + A x + B $

- From $V (0) = 0$ and $V (1) = 1$, we find that $A = 0$ and $B = 0$.

- Hence, to reformulate the initial-boundary value problem, we let:
    $ phi.alt (x, t) = x^3 e^(- t) + psi (x, t) $

#pagebreak()

- With $phi.alt (x, t) = x^3 e^(- t) + psi (x, t)$, we can verify directly that
    the original initial-boundary value problem in $phi.alt$ can be reformulated
    as the initial-boundary value problem in $psi$ given below. Solve:
    $
        frac(partial^2 psi, partial x^2)
        = frac(partial^2 psi, partial t^2)
        + frac(partial psi, partial t) "for" 0 < x < 1 "and" t > 0
    $

    Subject to:
    $
        psi (x, 0) = - x^2 "and" evaluated(frac(partial psi, partial t))_(t = 0)
        = x^3 "for" 0 < x < 1
    $
    $
        psi (0, t) = 0 "and" psi (1, t) = 0 "for" t > 0
    $

- The partial differential equation and the boundary conditions in the
    reformulated initial-boundary value problem above are homogeneous linear.

#pagebreak()

= 2D steady heat conduction in a rectangular beam
- Consider a beam of uniform rectangular cross-section lying along the $z$ axis.

- The beam is infinitely long with its ends extending to $- oo$ and $oo$ on the
    $z$ axis.

- Below is a sketch of the rectangular cross-section of the beam, given by
    $0 < x < a, 0 < y < b$.

    #cimage(
        "./images/steady-heat-conduction-rectangular-beam.png",
        height: 20em,
    )

- The temperature $phi.alt$ in the beam does not vary with the coordinate $z$
    and time $t$.

- The steady state temperature $phi.alt$ is a function of the Cartesian
    coordinates $x$ and $y$.

- From suitably given information on the thermal conditions on the four sides of
    the rectangular region, we are interested in finding the temperature
    $phi.alt (x, y)$ at all points $(x, y)$ on the cross-section of the beam.

- The heat equation is:
    $
        frac(partial^2 phi.alt, partial x^2)
        + frac(partial^2 phi.alt, partial y^2)
        + frac(partial^2 phi.alt, partial z^2)
        = frac(rho c, k) frac(partial phi.alt, partial t)
    $

- For the steady temperature $phi.alt (x, y)$ in the beam, the heat equation
    reduces to the 2D Laplace's equation:
    $
        frac(partial^2 phi.alt, partial x^2)
        + frac(partial^2 phi.alt, partial y^2) = 0
    $

- The task of finding $phi.alt (x, y)$ can be formulated as a boundary value
    problem that requires solving the 2D Laplace's equation in the rectangular
    region $0 < x < a, 0 < y < b$, subject to suitably given boundary conditions
    on the four sides of the rectangular region.

#pagebreak()

== Boundary value problem with temperature specified on the boundary
<bvp-temperature-specified>

Solve:
$
    frac(partial^2 phi.alt, partial x^2)
    + frac(partial^2 phi.alt, partial y^2) = 0 "for" 0 < x < a, 0 < y < b
$

Subject to:
$
    phi.alt (x, 0) = 0 "and" phi.alt (x, b) = f (x) "for" 0 < x < a
$
$
    phi.alt (0, y) = 0 "and" phi.alt (a, y) = 0 "for" 0 < y < b
$

A sketch of the boundary value problem:

#cimage(
    "./images/steady-heat-conduction-"
        + "rectangular-beam-specified-temperature.png",
    height: 20em,
)

- Use the method of separation of variables together with Fourier series to
    solve the boundary value problem.
- For an analogy with the initial-boundary value problem for the #link(
        <vibrating-string-problem>,
    )[vibrating string], the boundary conditions $phi.alt = 0$ on the two
    vertical sides $(x = 0 "and" x = a)$ in the boundary value problem here are
    like the boundary conditions $u = 0$ at the ends of the string.
- The boundary conditions on the horizontal sides $(y = 0 "and" y = b)$ are like
    the initial conditions in the initial conditions in the initial-boundary
    value problem for the vibrating string.
- When solving the boundary value problem, we will satisfy the boundary
    conditions on the two vertical sides first.
- The boundary conditions on the two horizontal sides will be tackled later on
    as Fourier series problems.
- Use the method of separation of variables together with Fourier series to
    solve the boundary value problem.

#pagebreak()

=== Step 1
Apply the method of separation of variables on the partial differential equation
to obtain a set of ordinary differential equations.

- Let $phi.alt (x, y) = X (x) Y (y)$.
- Substitute into the 2D Laplace's equation:
    $ X'' (x) Y (y) + X (x) Y'' (y) = 0 $
- Divide both sides by $X (x) Y (y)$:
    $ frac(X'' (x), X (x)) + frac(Y'' (y), Y (y)) = 0 $
- Separating the variables:
    $
        - frac(X'' (x), X (x)) = frac(Y'' (y), Y (y)) = gamma med ("constant")
    $
- Obtain a set of ordinary differential equations:
    $ X'' (x) + gamma X (x) = 0 $
    $ Y'' (y) + gamma Y (y) = 0 $

=== Step 2
Solve the ordinary differential equations to find non-trivial (non-zero)
solutions satisfying the boundary conditions.

==== Case $gamma = 0$

- The ordinary differential equations are given by $X'' (x) = 0$ and
    $Y'' (y) = 0$.
- The ordinary differential equations can be easily integrated twice to obtain
    the general solutions $X (x) = A x + B$ and $Y (y) = C y + D$.
- Hence:
    $ phi.alt (x, y) = (A x + B) (C y + D) $
- The boundary condition $phi.alt (0, y) = 0$ gives $B (C y + D) = 0$, which
    gives $B = 0$.
- The boundary condition $phi.alt (a, y) = 0$ gives $(a A + B) (C y + D) = 0$,
    which gives $a A + B = 0$.
- With $B = 0$, $a A + B = 0$ gives $A = 0$.
- We end up obtaining only the trivial solution $phi.alt (x, y) = 0$ for
    $gamma = 0$.

#pagebreak()

==== Case $gamma = - p^2$ (negative)

- The ordinary differential equations are given by:
    $ X'' (x) - p^2 X (x) = 0 $
    $ Y'' (y) + p^2 Y (y) = 0 $.
- The general solutions of the ordinary differential equations are:
    $ X (x) = A e^(p x) + B e^(- p x) $
    $ Y (y) = C sin p y + D cos p y $
- Hence:
    $
        phi.alt (x, y) = (A e^(p x) + B e^(- p x)) (C sin p y + D cos p y)
    $
- The boundary condition $phi.alt (0, y) = 0$ gives
    $(A + B) (C sin p y + D cos p y) = 0$, which gives $A + B = 0$.
- The boundary condition $phi.alt (a, y) = 0$ gives
    $(A e^(p a) + B e^(- p a)) (C sin p y + D cos p y) = 0$, which gives
    $A e^(p a) + B e^(- p a) = 0$.
- We obtain $A = 0$ and $B = 0$.
- Hence, we end up with only the trivial solution $phi.alt (x, y) = 0$ for
    $gamma = - p^2$.

#pagebreak()

==== Case $gamma = p^2$ (positive)

- The ordinary differential equations are given by:
    $ X'' (x) + p^2 X (x) = 0 $
    $ Y'' (y) - p^2 Y (y) = 0 $
- The general solutions of the ordinary differential equations are:
    $ X (x) = A sin p x + B cos p x $
    $ Y (y) = C e^(p y) + D e^(- p y) $
- Hence:
    $
        phi.alt (x, y) = (A sin p x + B cos p x) (C e^(p y) + D e^(- p y))
    $
- The boundary condition $phi.alt (0, y) = 0$ gives
    $B (C e^(p y) + D e^(- p y) = 0)$, which gives $B = 0$.
- With $B = 0$, we can write:
    $ phi.alt (x, y) = (E e^(p y) + F e^(- p y)) sin p x $
- The boundary condition $phi.alt (a, y) = 0$ gives:
    $ (E e^(p y) + F e^(- p y)) sin p a = 0 $
- This gives $sin p a = 0$, which is:
    $
        p a = n pi "for"
        n = 0, plus.minus 1, plus.minus 2, plus.minus 3, dots.h
    $
- The boundary condition at $x = a$ (right vertical side) gives:
    $
        p a = n pi "for"
        n = 0, plus.minus 1, plus.minus 2, plus.minus 3, dots.h
    $
- For a given integer $n$, we have a non-trivial solution satisfying both
    boundary conditions ($x = 0$ and $x = a$).
- For a given positive integer $n$, we denote the solution by:
    $
        phi.alt_n (x, y) = (E_n e^(frac(n pi y, a)) +
            F_n e^(- frac(n pi y, a))) sin frac(n pi x, a)
        "for" n = 1, 2, 3, dots.h
    $
- Note that $E_n$ and $F_n$ are arbitrary constants.

=== Step 3
Sum up the solutions obtained in Step 2 to form a series solution.

- Equation from step 2:
    $
        phi.alt_n (x, y) = (E_n e^(frac(n pi y, a))
            + F_n e^(- frac(n pi y, a)))
        sin frac(n pi x, a) "for" n = 1, 2, 3, dots.h
    $
- Since the Laplace's equation is homogeneous linear, the sum of the solutions
    is still a solution.
- We form the series solution:
    $
        phi.alt (x, y) = sum_(n = 1)^oo (E_n e^(frac(n pi y, a))
            + F_n e^(- frac(n pi y, a))) sin frac(n pi x, a)
    $
- The boundary conditions on the two vertical sides are in homogeneous linear
    form.
- The series solution also satisfies the boundary conditions on the two vertical
    sides.
- We can easily verify by substituting $x = 0$ and $x = a$ into the series
    solution.

#pagebreak()

=== Step 4
Tackling the remaining boundary conditions.

- Equation from step 3:
    $
        phi.alt (x, y) = sum_(n = 1)^oo (E_n e^(frac(n pi y, a))
            + F_n e^(- frac(n pi y, a))) sin frac(n pi x, a)
    $
- The series solution in step 3 satisfies the partial differential equation and
    the boundary conditions on the two vertical sides of the rectangular
    solution domain.
- From the boundary condition on the bottom horizontal side $(y = 0)$, which is
    $phi.alt (x, 0) = 0 "for" 0 < x < a$, we obtain:
    $ sum_(n = 1)^oo (E_n + F_n) sin frac(n pi x, a) = 0 "for" 0 < x < a $
- This gives:
    $ E_n + F_n = 0 $
    $ F_n = - E_n $
- Hence, the series solution reduces to:
    $
        phi.alt (x, y) = sum_(n = 1)^oo E_n (e^(frac(n pi y, a))
            - e^(- frac(n pi y, a))) sin frac(n pi x, a)
    $
- Only the boundary condition on the top horizontal side $(y = b)$, which is
    $phi.alt (x, b) = f (x) "for" 0 < x < a$, remains to be satisfied.
- This boundary condition gives:
    $
        phi.alt (x, b) = sum_(n = 1)^oo E_n (e^(frac(n pi b, a))
            - e^(- frac(n pi b, a))) sin frac(n pi x, a) = f (x) "for" 0 < x < a
    $
- We obtain:
    $
        E_n (e^(frac(n pi b, a)) - e^(- frac(n pi b, a)))
        = 2 / a integral_0^a f (x) sin frac(n pi x, a) thin dif x
        "for" n = 1, 2,, 3, dots.h
    $

#pagebreak()

== Boundary value problem with mixed boundary conditions
- Solve:
    $
        frac(partial^2 phi.alt, partial x^2) +
        frac(partial^2 phi.alt, partial y^2) = 0 "for" 0 < x < a, 0 < y < b
    $

    Subject to:
    $ phi.alt (x, 0) = 0 "and" phi.alt (x, b) = 0 "for" 0 < x < a $
    $
        evaluated(frac(partial phi.alt, partial x))_(x = 0) = q_0
        "and" phi.alt (a, y) = 0 "for" 0 < y < b
    $

- $q_0$ is a given constant.

- Below is a sketch of the boundary value problem:

    #image(
        "./images/steady-heat-conduction-"
            + "rectangular-mixed-boundary-conditions.png",
    )

- We may apply the method of separation of variables together with the Fourier
    series to solve this boundary value problem, following the same four steps
    in the solution procedure for the #link(
        <bvp-temperature-specified>,
    )[previous boundary value problem].

- In the second step of the solution procedure for this boundary value problem,
    we find non-trivial solutions that satisfy the boundary conditions on the
    horizontal sides, since $phi.alt = 0$ on the two horizontal sides in this
    boundary value problem.

- This is unlike in the solution of the #link(
        <bvp-temperature-specified>,
    )[previous boundary value problem] where we look for non-trivial solutions
    satisfying the boundary conditions on the vertical sides.

- For the boundary value problem here, the boundary conditions on the vertical
    sides are tackled in the 4th (last) step after forming the series solution.

- After the first three steps in the solution procedure, we obtain the series
    solution:
    $
        phi.alt (x, y) = sum_(n = 1)^oo (E_n e^(frac(n pi x, b))
            + F_n e^(- frac(n pi x, b))) sin frac(n pi y, b)
    $

- We can easily verify by direct substitution that the series solution above
    satisfies the 2D Laplace's equation and the boundary conditions on the two
    horizontal sides.

- From the boundary condition on the right vertical side $(x = a)$, we find
    that:
    $
        phi.alt (a, y) = sum_(n = 1)^oo (E_n e^(frac(n pi a, b))
            + F_n e^(- frac(n pi a, b))) sin frac(n pi y, b) = 0 "for" 0 < y < b
    $

- This gives:
    $ E_n e^(frac(n pi a, b)) + F_n e^(- frac(n pi a, b)) = 0 $
    $ F_n = - E_n e^(frac(2 n pi a, b)) $

- From $F_n = E_n e^(frac(2 n pi a, b))$, the series becomes:
    $
        phi.alt (x, y) = sum_(n = 1)^oo E_n (e^(frac(n pi x, b))
            - e^(frac(2 n pi a, b)) e^(- frac(n pi x, b))) sin frac(n pi y, b)
    $

- It follows that:
    $
        frac(partial phi.alt, partial x) = sum_(n = 1)^oo frac(n pi E_n, b)
        (e^(n pi x) b + e^(frac(2 n pi a, b))
            e^(- frac(n pi x, b))) sin frac(n pi y, b)
    $

- From the boundary conditions on the left vertical side ($x = 0$), we obtain:
    $
        evaluated(frac(partial phi.alt, partial x))_(x = 0)
        = sum_(n = 1)^oo frac(n pi E_n, b) (1 + e^(frac(2 n pi a, b)))
        sin frac(n pi y, b) = q_0 "for" 0 < y < b
    $
    $
        frac(n pi E_n, b) (1 + e^(frac(2 n pi a, b)))
        = 2 / b integral_0^b q_0 sin frac(n pi y, b) thin dif y
        = frac(2 q_0, n pi) (1 - cos n pi) "for" n = 1, 2, 3, dots.h
    $

- The required solution of the boundary value problem here is given by:
    $
        phi.alt (x, y) = sum_(n = 1)^oo
        frac(
            2 b q_0 (1 - cos n pi),
            n^2 pi^2 (1 + e^(frac(2 n pi a, b)))
        ) (e^(frac(n pi x, b))
            - e^(frac(2 n pi a, b)) e^(- frac(n pi x, b))) sin frac(n pi y, b)
    $

#pagebreak()

= Finite element method (FEM)
- Finite element method (FEM) is a *numerical method* commonly used for solving
    boundary value problems (BVPs).
- Boundary value problems:
    - Occur in many branches of engineering.
    - Often too complex to solve analytically.
    - Several numerical methods are available.
    - Finite element method is a powerful numerical method for solving boundary
        value problems.
- Major complexities that challenge analytical solutions include:
    - Irregular geometrical shapes.
    - Spatial and temporal variations of applied loads, boundary conditions, and
        material properties.
- Attractive features of finite element method:
    - No restriction on the geometrical shape of the problem domain.
    - Spatial and temporal variations of loads, boundary conditions and material
        properties can be dealt with easily.
    - Highly amenable to computer implementation.
    - Can be applied to any field problem:
        - Stress analysis
        - Heat transfer analysis
        - Fluid flow analysis
        - Magnetic field analysis
        - Electrostatic field analysis
- Nonlinear behaviour of structures due to nonlinear material behaviour or large
    deformations can be handled effectively.
- Once a computer program is developed for finite element method, even less
    skilled people can use it to solve many practical problems with very little
    knowledge of finite element method.
- Several commercial software packages, like ANSYS, NASTRAN, ABAQUS, and ADINA,
    are available for finite element analysis.
- Typical areas of applications of finite element method.
    + Mechanical, aerospace and civil engineering
        - Stress analysis, both linear and nonlinear.
        - Dynamic analysis, like free or forced vibration, impact, etc.
        - Buckling analysis.
        - Conduction, convection and radiation analysis.
        - Fluid flow and seepage analysis.
    + Electrical engineering
        - Electrostatic, magnetic and electromagnetic analysis.
    + Biomechanical engineering
        - Bone mechanics
        - Cardiac mechanics
        - Soft tissue mechanics

== Terminology

#cimage("./images/finite-element-mesh.png")

=== Finite element
The given domain is divided into several subdomains. Each subdomain is called a
*finite element*.

=== Node
A node is a point of interest where we want to calculate displacements. Nodes
are also points through which the adjacent elements are connected with one
another.

=== Finite element mesh
A finite element mesh is a collection of all the finite elements interconnected
with one another at nodal points.

=== Nodal displacements
Nodal displacements are the displacements associated with each node. In 2D
elasticity problems, each node has two displacements, $x$-displacement and
$y$-displacement.

=== Number of nodal degrees of freedom (DOF)
Number of nodal degrees of freedom is the total number of nodal displacements
per node. In the example shown above, each node has 2 degrees of freedom.

#pagebreak()

=== Number of degrees of freedom (DOF) of an element
Number of degrees of freedom (DOF) of an element is the total number of nodal
displacements of all the nodes in an element. In the example shown below, it
is 8.

#cimage("./images/finite-element.png", height: 15em)
#pagebreak()

== Basic steps
+ Discretise (mesh) the geometry:
    - Divide the problem domain into a finite number of interconnected
        subdomains called "*finite elements*".
    #cimage("./images/discretisation.png")

+ Generate element equilibrium equations:
    - In each finite element, a simple displacement interpolation is assumed in
        terms of the *unknown nodal displacements*.
+ Obtain global equilibrium equations:
    - Element equilibrium equations are assembled together to obtain *global
        equilibrium equations*.
+ Solve global equations:
    - The *boundary conditions* are imposed on the global equilibrium equations
        and the global equations are then solved for the unknown *nodal
        displacements*.
+ Perform additional computations if needed:
    - Displacements, strains and stresses at the interior points of the
        elements, and reaction forces at the supports can also be calculated, if
        needed.

=== Things to note
- *Finite element (FE) solution* is an *approximate solution*.
- This does not mean the solution will be useless in practice.
- An accurate solution is always possible if we use a *finer mesh*.
- Generally, with progressively finer meshes, the accuracy will improve
    progressively, and the solution will eventually approach the exact solution.
    Thus, *accuracy to any desired degree* is, in principle, possible.

== Spring element
<spring-element>
#cimage("./images/spring-element.png")

Consider a spring with two nodes. $F_1$ and $F_2$ are *external forces* acting
on nodes 1 and 2, respectively. $U_1$ and $U_2$ are corresponding nodal
displacements.

Force balance at node 1:
$
    F_x = 0
    quad arrow.double.r quad -k(U_1 - U_2) + F_1 = 0
    quad arrow.double.r quad k U_1 - k U_2 = F_1
$

Force balance at node 2:
$
    F_x = 0
    quad arrow.double.r quad -k(U_2 - U_1) + F_1 = 0
    quad arrow.double.r quad -k U_1 + k U_2 = F_1
$

The above element equilibrium equations can be written in matrix form as:
$
    underbrace(bmat(k, -k; -k, k), "Element stiffness matrix") quad
    underbrace(cvec(U_1, U_2), "Element displacement vector")
    = underbrace(cvec(F_1, F_2), "Element force vector")
$

#pagebreak()

=== Example 1
Determine the *deflection* at the loaded end of the spring shown below using the
*spring element*.

#cimage("./images/spring-element-example-1.png")

The *element equilibrium equations* for a spring element can be written as:
$ bmat(k, -k; -k, k) cvec(U_1, U_2) = cvec(F_1, F_2) $

#cimage("./images/spring-element-example-1-fe-model.png", height: 18em)

Comparing the finite element model with the given problem:
$ k = 10, quad U_1 = 0 quad F_1 = R_1, quad F_2 = #qty[1][N] $

Hence, the element equilibrium equations can be written as:
$ bmat(10, -10; -10, 10) cvec(0, U_2) = cvec(R_1, 1) $

Carrying out the matrix product on the left side of the above equation:
#labelled_equation($-10 U_2 = R_1$, 1)
#labelled_equation($10 U_2 = 1$, 2)

Solving $(2)$, we get
$ U_2 = 1/10 quad bold("(Ans)") $

Using this displacement in the first equation, we calculate the *reaction force*
as:
$
    - 10 U_2 = R_1
    R_1 = #qty[-1][N]
$

=== Example 2
<spring-element-example-2>
Determine the *displacement* at the loaded end of the two-spring assembly shown
below.
#cimage("./images/spring-element-example-2.png")

The finite element model of the problem:
#cimage("./images/spring-element-example-2-fe-model.png")

$ "Nodal displacements": U_1, U_2, U_3 $
$ "Nodal forces": F_1 F_2 F_3 $
The nodal forces are the external forces acting on the nodes.

The free body diagram of the nodes:
#cimage("./images/spring-element-example-2-free-body-diagrams.png")

From the free body diagrams, the equilibrium equations ($sum F_x = 0$) for the
nodes are:
#labelled_equation($"At node 1": -k_1 (U_1 - U_2) + F_1 = 0$, 1)
#labelled_equation(
    $"At node 2": -k_1 (U_2 - U_1) - k_2 (U_2 - U_3) + F_2 = 0$,
    2,
)
#labelled_equation($"At node 3": -k_2 (U_3 - U_2) + F_3 = 0$, 3)

The global equilibrium equations $(1), (2)$ and $(3)$ can be written in matrix
form as:
#labelled_equation(
    $
        underbrace(
            bmat(
                k_1, -k_1, 0;
                -k_1, k_1 + k_2, -k_2;
                0, -k_2, k_2;
            ), "Global stiffness matrix"
        ) quad
        underbrace(cvec(U_1, U_2, U_3), "Global displacement vector")
        = underbrace(cvec(F_1, F_2, F_3), "Global force vector")
    $,
    4,
)

For the given problem, the left end of the spring assembly is *fixed*. So,
$U_1 = 0$. The external force acting on node 1 is just the reaction force $R_1$,
so $F_1 = R_1$.

There is no external force acting on node 2, so $F_2 = 0$.

The external acting on node 3 is #qty[1][N], so $F_3 = #qty[1][N]$.

Applying the boundary condition $U_1 = 0$ and the above forces:
#labelled_equation(
    $
        bmat(
            k_1, -k_1, 0;
            -k_1, k_1 + k_2, -k_2;
            0, -k_2, k_2;
        )
        cvec(0, U_2, U_3) = cvec(R_1, 0, 1)
    $,
    5,
)

$ k_1 = #qty[20][N m^-1] $
$ k_2 = #qty[10][N m^-1] $

Carrying out the matrix product on the left side of the above equation:
#labelled_equation($-20 U_2 = R_1$, 6)
#labelled_equation($30 U_2 - 10 U_3 = 0$, 7)
#labelled_equation($-10 U_2 + 10 U_3 = 1$, 8)

Solving equations $(7)$ and $(8)$ simultaneously, we get:
$ U_2 = 1/20, quad U_3 = 3/20 quad bold("(Ans)") $

Using this value of $U_2$ in equation $(6)$, we get the reaction force $R_1$ as:
$ R_1 = -20 U_2 = -20(1/20) = -1 $

Equations $(7)$ and $(8)$ shown on the previous slide can be obtained quickly
and easily from equation $(5)$ just by crossing out the row and column
corresponding to node 1, which is the node that has the zero-displacement
boundary condition as shown below:

#cimage("./images/spring-element-example-2-easy-way-to-apply-bcs.png")

The above technique can be applied whenever we have zero-displacement boundary
conditions, like homogeneous boundary conditions.

Once the displacements $U_2$ and $U_3$ are calculated by solving the above two
equations, we can substitute them in the first equation, which is the equation
that we crossed out, to calculate the reaction force $R_1$.

#pagebreak()

== Finite element assembly process
- The force balance method used in the #link(
        <spring-element-example-2>,
    )[previous example] can be extended to this problem.
- However, the force balance method is cumbersome, particular for problems
    involving many nodes, i.e. many finite elements.
- A convenient way to obtain the *global equilibrium equations* of the given
    spring assembly is by "assembling" the *element stiffness matrices* of
    individual elements.

=== Example 1
#enum(
    numbering: "a)",
    [Obtain the global equilibrium equations by *assembling* element equilibrium
        equations.],
    [Solve the resulting global equations for the nodal displacements taking
        $k_1 = #qty[1][N m^-1], k_2 = #qty[2][N m^-1]$ and $k = #qty[3][N
            m^-1]$],
)

#cimage("./images/assembly-process-example-1.png")
#pagebreak()

==== (a)
+ Start off with the finite element model as shown below. Consider the supports
    later. Label the *element numbers, node numbers, nodal displacements and
    external nodal forces.* In principle, you can label elements and nodes in
    any order as you like. Labelling them as shown below:
    #cimage("./images/assembly-process-example-1-fe-model.png")

+ Set up the element equilibrium equations and *label the rows and columns*:
    - Element number 1:
        #v(-2em)
        #grid(
            columns: 2,
            align: center + horizon,
            $
                #stack(
                    spacing: 0.2em,
                    $ mat(delim: #none, column-gap: #2.2em, #sub[4], #sub[2]) $,
                    $ vec(delim: #none, #super[4], #super[2])
                    bmat(k_1, -k_1; -k_1, k_1) $,
                )
                #stack(
                    spacing: 0.5em,
                    "",
                    $ cvec(U_4, U_2) = vec(delim: #none, #super[4], #sub[2])
                    cvec(f_4^((1)), f_2^((1))) $,
                )
            $,
            image(
                "./images/assembly-process-example-1-nodes-4-and-2.png",
                width: 65%,
            ),
        )

        $f_4^((1))$ and $f_2^((1))$ are *internal forces* on element *1* at
        nodes *4* and *2*, respectively.
    - Element number 2:
        #v(-2em)
        #grid(
            columns: 2,
            align: center + horizon,
            $
                #stack(
                    spacing: 0.2em,
                    $ mat(delim: #none, column-gap: #2.2em, #sub[2], #sub[3]) $,
                    $ vec(delim: #none, #super[2], #super[3])
                    bmat(k_2, -k_2; -k_2, k_2) $,
                )
                #stack(
                    spacing: 0.5em,
                    "",
                    $ cvec(U_2, U_3) = vec(delim: #none, #super[2], #sub[3])
                    cvec(f_2^((2)), f_3^((2))) $,
                )
            $,
            image(
                "./images/assembly-process-example-1-nodes-2-and-3-elem-2.png",
                width: 65%,
            ),
        )

        $f_2^((2))$ and $f_3^((2))$ are *internal forces* on element *2* at
        nodes *2* and *3*, respectively.
    - Element number 3:
        #v(-2em)
        #grid(
            columns: 2,
            align: center + horizon,
            $
                #stack(
                    spacing: 0.2em,
                    $ mat(delim: #none, column-gap: #2.2em, #sub[2], #sub[3]) $,
                    $ vec(delim: #none, #super[2], #super[3])
                    bmat(k_2, -k_2; -k_2, k_2) $,
                )
                #stack(
                    spacing: 0.5em,
                    "",
                    $ cvec(U_2, U_3) = vec(delim: #none, #super[2], #sub[3])
                    cvec(f_2^((3)), f_3^((3))) $,
                )
            $,
            image(
                "./images/assembly-process-example-1-nodes-2-and-3-elem-3.png",
                width: 65%,
            ),
        )

        $f_2^((3))$ and $f_3^((3))$ are *internal forces* on element *3* at
        nodes *2* and *3*, respectively.
    - Element number 4:
        #v(-2em)
        #grid(
            columns: 2,
            align: center + horizon,
            $
                #stack(
                    spacing: 0.2em,
                    $ mat(delim: #none, column-gap: #2.2em, #sub[3], #sub[1]) $,
                    $ vec(delim: #none, #super[3], #super[1])
                    bmat(k_3, -k_3; -k_3, k_3) $,
                )
                #stack(
                    spacing: 0.5em,
                    "",
                    $ cvec(U_3, U_1) = vec(delim: #none, #super[3], #sub[1])
                    cvec(f_3^((4)), f_1^((4))) $,
                )
            $,
            image(
                "./images/assembly-process-example-1-nodes-3-and-1.png",
                width: 65%,
            ),
        )

        $f_3^((4))$ and $f_1^((4))$ are *internal forces* on element *4* at
        nodes *3* and *1*, respectively.
        #v(3em)

+ Set up the global equilibrium equations initially with zero stiffness matrix
    and zero load vector:
    $
        bmat(
            0, 0, 0, 0;
            0, 0, 0, 0;
            0, 0, 0, 0;
            0, 0, 0, 0;
        )
        cvec(U_1, U_2, U_3, U_4)
        = cvec(0, 0, 0, 0)
    $

    These are 4 nodes, with 4 nodal displacements, in the spring assembly. So,
    the global stiffness matrix will have four rows and four columns. The global
    load vector will have four rows.

+ Assemble element stiffness matrices and load vectors into global equations.
    - Global equations after assembling element number 1:
        $
            bmat(
                0, 0, 0, 0;
                0, mathred(k_1), 0, mathred(-k_1);
                0, 0, 0, 0;
                0, mathred(-k_1), 0, mathred(k_1);
            )
            cvec(U_1, U_2, U_3, U_4)
            = cvec(0, mathred(f_2^((1))), 0, mathred(f_4^((1))))
        $
    - Global equations after assembling element number 2 and 3:
        $
            bmat(
                0, 0, 0, 0;
                0, k_1 mathred(+ 2k_2), mathred(-2k_2), -k_1;
                0, mathred(-2k_2), mathred(2k_2), 0;
                0, -k_1, 0, k_1;
            )
            cvec(U_1, U_2, U_3, U_4)
            = cvec(
                0,
                f_2^((1)) mathred(+ f_2^((2)) + f_2^((3))),
                mathred(f_3^((2)) + f_3^((3))),
                f_4^((1))
            )
        $
    - Global equations after assembling element number 4:
        $
            bmat(
                mathred(k_3), 0, mathred(-k_3), 0;
                0, k_1 + 2k_2, -2k_2, -k_1;
                mathred(-k_3), -2k_2, 2k_2 mathred(+ k_3), 0;
                0, -k_1, 0, k_1;
            )
            cvec(U_1, U_2, U_3, U_4)
            = cvec(
                mathred(f_1^((4))),
                f_2^((1)) + f_2^((2)) + f_2^((3)),
                f_3^((2)) + f_3^((3)) mathred(+ f_3^((4))),
                f_4^((1))
            )
        $

+ For the equilibrium of forces at each node, the _sum_ of all the internal
    forces acting on springs should be equal to the *external force* acting on
    that node. So we can replace the sum of internal forces by the external
    forces as follows:
    $ f_4^((1)) -> F_4 $
    $ f_2^((1)) + f_2^((2)) + f_2^((3)) -> F_2 $
    $ f_3^((2)) + f_3^((3)) + f_3^((4)) -> F_3 $
    $ f_1^((4)) -> F_1 $

    The global equilibrium equations become:
    $
        bmat(
            k_3, 0, -k_3, 0;
            0, k_1 + 2k_2, -2k_2, -k_1;
            -k_3, -2k_2, 2k_2 + k_3, 0;
            0, -k_1, 0, k_1;
        )
        cvec(U_1, U_2, U_3, U_4) = cvec(F_1, F_2, F_3, F_4)
    $

==== (b)
Solve the global equilibrium equations.

Node 4 is fixed to a support, so $U_4 = 0$ and $F_4 = R$. Hence the global
equilibrium equations become:
$
    bmat(
        k_3, 0, -k_3, 0;
        0, k_1 + 2k_2, -2k_2, -k_1;
        -k_3, -2k_2, 2k_2 + k_3, 0;
        0, -k_1, 0, k_1;
    )
    cvec(U_1, U_2, U_3, redcancel(U_4) mathred(= 0))
    = cvec(F_1, F_2, F_3, redcancel(F_4) mathred(= R))
$

The reaction force $R$ is unknown as of now.

Substituting the given stiffness values and externally applied nodal forces
($k = 1, k_2 = 2, k_3 = 3, F_2 = 1, F_3 = 2$ and $F_1 = 3$):
#labelled_equation(
    $
        bmat(
            3, 0, -3, vertcancel(0);
            0, 5, -4, vertcancel(-1);
            -3, -4, 7, vertcancel(0);
            horzcancel(0), horzcancel(-1), horzcancel(0), crosscancel(1)
        )
        cvec(U_1, U_2, U_3, 0)
        = cvec(3, 1, 2, cancel(R, stroke: #red, angle: #90deg))
    $,
    1,
)

The boundary condition $U_4$ is associated with node 4. So, we can cross out the
4th row as well as the 4th column, as shown above, to get the reduced system of
equations as follows:
$
    bmat(
        3, 0, -3;
        0, 5, -4;
        -3, -4, 7;
    )
    cvec(U_1, U_2, U_3) = cvec(3, 1, 2)
$

Solving this system:
$ U_1 = 8.25, quad U_2 = 6, U_3 = 7.25 quad (bold("ans")) $

Substituting these displacements and $U_4 = 0$ into equation $(1)$, the reaction
force $R$ is:
$ 0 U_1 + (-1) U_2 + 0 U_3 + 1 U_4 = R $
$ => quad R = -6 $

$R$ is equal and opposite to the total applied forces, $3 + 1 + 2$, as it should
be.

==== How to calculate the internal forces in the springs?
Internal forces can be calculated using the element equilibrium equations. For
example, for spring element 1, we can calculate the internal forces as follows:
$
    bmat(
        k_1, -k_1;
        -k_1, k_1
    ) cvec(U_4, U_2) = cvec(f_4^((1)), f_2^((1)))
$

Substituting the numerical values of $k_1, U_4$ and $U_2$:
$
    bmat(
        1, -1;
        -1, 1
    ) cvec(0, 6) = cvec(f_4^((1)), f_2^((1)))
    quad => quad f_4^((1)) = -6, quad f_2^((1)) = 6
$

Apply the same technique for the other elements to get their internal forces.

#pagebreak()

==== Sum of internal forces is equal to the external force for each node
At each node, it is easy to verify that:
$ "Sum of internal forces acting on springs" = "External force acting on node" $

#cimage("./images/assembly-process-example-1-force-verification.png")
#pagebreak()

== Bar element
Consider a bar of length $L$, corss-sectional area $A$, Young's modulus $E$
subjected to an axial force $P$. The axial deflection #sym.delta can be written
as:
$ delta = frac(P L, A E) $

Defining the *equivalent axial stiffness* of the bar ($k_b$) as:
$ k_b = P/delta = (A E)/L $

#cimage("./images/bar-element.png", height: 25em)

Having calculated the stiffness $k_b$, we can treat the "bar element" as a
"spring element" with an equivalent stiffness $k_b$. So the stiffness matrix for
the bar element can simply be written as:
$ bmat(k_b, -k_b; -k_b, k_b) cvec(u_1, u_2) = cvec(f_1, f_2) $

#pagebreak()

=== Example
#cimage("./images/bar-element-example.png")
Obtain the global equilibrium equations for the stepped bar shown below:

The equivalent axial stiffness values of the two bars can be expressed as:
$ k_1 = (A_1 E_1)/L_1 quad k_2 = (A_2 E_2)/L_2 $

The stepped bar can be equivalently modelled as a "two-spring assembly" as shown
below:
#cimage("./images/bar-element-example-spring-model.png")
#pagebreak()

== Heat conduction element
#cimage("./images/heat-conduction-element.png", height: 20em)
The element equations for the heat conduction element can be derived from
Fourier law of heat conduction.
$ q= k_T A frac(Delta T, Delta L) $

Where:
- $k_T$ is thermal conductivity (#unit[Js^-1 m^-1 °C^-1])
- $T$ is the temperature (#unit[°C])
- $A$ is the cross sectional area (#unit[m^2])
- $q$ is the heat flow through the slab, from high to low temperature
    (#unit[Js^-1])

Consider the heat conduction through a *wall* or a *rod* as shown in the figures
below. We shall derive the equations by *nodal heat balance*.

=== Models
#cimage("./images/heat-conduction-element-models.png", height: 25em)

=== Heat balance at node 1
$ q_1^((e)) = k_T A (T_1 - T_2)/L $
$ q_1^((e)) = (k_T A)/L T_1 - (k_T A)/L T_2 $

When we write the equation for node 1, we assume $T_1 > T_2$.

=== Heat balance at node 2
$ q_2^((e)) = k_T A (T_2 - T_1)/L $
$ q_2^((e)) = (k_T A)/L T_2 - (k_T A)/L T_1 $

When we write the equation for node 1, we assume $T_2 > T_1$.

=== Matrix form
The above two element equations can be written in matrix form as:
$ (k_T A)/L bmat(1, -1; -1, 1) cvec(T_1, T_2) = cvec(q_1^((e)), q_2^((e))) $

Where:
- $q_1^((e))$ is the heat *entering* element through node 1 (#unit[Js^-1])
- $q_2^((e))$ is the heat *entering* element through node 2 (#unit[Js^-1])
- $T_1$ is the temperature at node 1
- $T_2$ is the temperature at node 2

=== Pipe element
#cimage("./images/pipe-element.png")
The element equations can be derived based on the following equation for
*laminar fluid flow* (from high pressure to low pressure) *through a uniform
tube*:
$ q = frac(pi D^4, 128 mu) frac(Delta P, Delta L) $

Where:
- $mu$ is the dynamic viscosity of the fluid (#unit[Ns m^-2])
- $P$ is the pressure (#unit[Pa])
- $D$ is the diameter of the tube (#unit[m])
- $q$ is the fluid flow through the pipe (#unit[m^3 s^-1])
- $L$ is the length of the element (#unit[m])

Using *nodal flow balance*, which is similar to *nodal heat balance*, at node 1:
$ q_1^((e)) = frac(pi D^4, 128 mu) frac(P_1 - P_2, L) $
$ q_1^((e)) = frac(pi D^4, 128 mu L) P_1 - frac(pi D^4, 128 mu L) P_2 $

At node 2:
$ q_2^((e)) = frac(pi D^4, 128 mu) frac(P_2 - P_1, L) $
$ q_2^((e)) = frac(pi D^4, 128 mu L) P_2 - frac(pi D^4, 128 mu L) P_1 $

The above equations can be written in matrix form as:
$
    frac(pi D^4, 128 mu L) bmat(1, -1; -1, 1) cvec(P_1, P_2)
    = cvec(q_1^((e)), q_2^((e)))
$

Where:
- $q_1^((e)), q_2^((e))$ is the fluid flow (#unit[m^3 s^-1]) *entering* element
    through node 1 and 2, respectively.
- $P_1, P_2$ is the pressure (#unit[Pa]) at node 1 and 2, respectively.

== Beam element
<beam-element>
#cimage("./images/beam-element.png", height: 15em)
The beam element has two *nodal degrees of freedom* per node as shown below. The
*direct stiffness method* is used to create the stiffness matrix. First, we
write the element equations in terms of symbols as:
$
    bmat(
        k_(11), k_(12), k_(13), k_(14);
        k_(21), k_(22), k_(23), k_(24);
        k_(31), k_(32), k_(33), k_(34);
        k_(41), k_(42), k_(43), k_(44);
    ) cvec(v_1, theta_1, v_2, theta_2)
    = cvec(F_1, M_1, F_2, M_2)
$

To determine the entries in the first column of the stiffness matrix, we apply a
unit displacement to the *first* degree of freedom and zero displacements to
other degrees of freedom:
#cimage("./images/beam-element-first-dof.png", height: 15em)

$
    bmat(
        mathred(k_(11)), k_(12), k_(13), k_(14);
        mathred(k_(21)), k_(22), k_(23), k_(24);
        mathred(k_(31)), k_(32), k_(33), k_(34);
        mathred(k_(41)), k_(42), k_(43), k_(44);
    ) cvec(1, 0, 0, 0)
    = cvec(F_1, M_1, F_2, M_2)
$

The left side of the above matrix equation can be simplified as:
$
    bvec(k_(11), k_(21), k_(31), k_(41))
    = cvec(F_1, M_1, F_2, M_2)
$

This implies that $k_(11), k_(21), k_(31)$ and $k_(41)$ are the forces and
moments ($F_1, M_1, F_2$ and $M_2$, respectively) that need to be applied on the
nodes to impose unit displacement to the *first* degree of freedom and zero
displacements to the other degrees of freedom.

The forces and moments $F_1, M_1, F_2$, and $M_2$ are basically the *reactions*
the supports will apply on the beam when we impose unit displacements to the
left support and zero displacement to the right support as shown in the figure
below:
#cimage("./images/beam-element-first-dof.png", height: 15em)

$ k_(11) = F_1 = (12 E I)/L^3 $
$ k_(21) = M_1 = (6 E I)/L^2 $
$ k_(31) = F_2 = -(12 E I)/L^3 $
$ k_(41) = M_2 = (6 E I)/L^2 $

#pagebreak()

Similarly, to determine the entries in the second column of the stiffness
matrix, we apply unit "displacement" (rotation) to the *second* degree of
freedom and zero displacements to the other degrees of freedom.

#cimage("./images/beam-element-second-dof.png", height: 15em)

$
    bmat(
        k_(11), mathred(k_(12)), k_(13), k_(14);
        k_(21), mathred(k_(22)), k_(23), k_(24);
        k_(31), mathred(k_(32)), k_(33), k_(34);
        k_(41), mathred(k_(42)), k_(43), k_(44);
    ) cvec(0, 1, 0, 0)
    = cvec(F_1, M_1, F_2, M_2)
    quad => quad
    bvec(k_(12), k_(22), k_(32), k_(42)) = cvec(F_1, M_1, F_2, M_2)
$

This implies that $k_(12), k_(22), k_(32)$ and $k_(42)$ are the forces
($F_1, M_1, F_2$ and $M_2$, respectively) to be applied to impose unit rotation
to the *second* degree of freedom and zero displacements to the other degrees of
freedom.

These forces are the reactions developed when we impose unit rotation to the
left support and zero displacement to the right support as shown above.

$ k_(12) = F_1 = (6 E I)/L^2 $
$ k_(22) = M_1 = (4 E I)/L $
$ k_(32) = F_2 = -(6 E I)/L^2 $
$ k_(42) = M_2 = (2 E I)/L $

Following a similar procedure, we can also determine the entries in the other
two columns of the stiffness matrix, and finally, obtain the stiffness matrix
for the beam element as shown below:
$
    (E I)/L^3 bmat(
        12, 6L, -12, 6L;
        6L, 4L^2, -6L, 2L^2;
        -12, -6L, 12, -6L;
        6L, 2L^2, -6L, 4L^2;
    ) cvec(v_1, theta_1, v_2, theta_2)
    = cvec(F_1, M_1, F_2, M_2)
$

The above method of generating the stiffness matrix is called the *direct
stiffness method*.

== Truss element

=== What is a truss structure?
A truss structure is a structure where all the members in the structure are
connected entirely by *pin joints*, and the external loads act only at the
pin-joints. As a result, the *internal force* in any member in the truss turns
out to be either a *tensile or compressive axial force* only. There is no
bending moment or shear force. A few examples are shown below.

#cimage("./images/truss-structure-examples.png")

A *truss* structure is a structure that is entirely made up of *axially loaded
members* oriented at different angles. Hence, each of the truss members can be
looked up on as a bar element inclined at some angle. An inclined bar element is
called a *truss element*. Deriving the stiffness matrix of a *truss element*
starts with the equations of a bar element and then accounting for the angle of
inclination of the element.

=== Stiffness matrix of a truss element
Consider a bar element oriented at an angle #sym.theta with respect to the
$x$-axis as shown below. The axial nodal displacements of the bar can be written
in terms of global nodal displacement components as:

#grid(
    columns: 3,
    align: center + horizon,
    [
        $ u_(1b) = U_1 cos theta + V_1 sin theta $
        $ u_(2b) = U_2 cos theta = V_2 sin theta $
        #v(2em)

        In matrix form,
        #labelled_equation(
            $
                cvec(u_(1b), u_(2b)) = bmat(
                    cos theta, sin theta, 0, 0;
                    0, 0, cos theta, sin theta;
                ) cvec(U_1, V_1, U_2, V_2)
            $,
            1,
        )

        For a bar element:
        #labelled_equation(
            $
                (A E)/L bmat(1, -1; -1, 1) cvec(u_(1b), u_(2b))
                = cvec(f_(1b), f_(2b))
            $,
            2,
        )
    ],
    image("./images/truss-element.png", width: 50%, height: 50%),
)

Substituting the displacement vector from equation $(1)$:
$
    (A E)/L bmat(1, -1; -1, 1) bmat(
        cos theta, sin theta, 0, 0;
        0, 0, cos theta, sin theta;
    ) cvec(U_1, V_1, U_2, V_2)
    = cvec(f_(1b), f_(2b))
$

#cimage("./images/truss-element-forces.png", height: 15em)

Premultiplying both sides of the above equation by the *transpose of the
transformation matrix $T$*, we get:
$
    bold(T)^T bold(K T) cvec(U_1, V_1, U_2, V_2) & = bold(T)^T bold(f) \
    bmat(
        cos theta, 0;
        sin theta, 0;
        0, cos theta;
        0, sin theta;
    )
    (A E)/L bmat(1, -1; -1, 1) bmat(
        cos theta, sin theta, 0, 0;
        0, 0, cos theta, sin theta
    ) cvec(U_1, V_1, U_2, V_2) & = bmat(
        cos theta, 0;
        sin theta, 0;
        0, cos theta;
        0, sin theta;
    ) cvec(f_(1b), f_(2b)) equiv cvec(F_(1X), F_(1Y), F_(2X), F_(2Y))
$

Denoting $l = cos theta$ and $m = sin theta$ and simplifying, the equation
becomes:
$
    k times underbrace(
        bmat(
            l^2, l m, -l^2, -l m;
            l m, m^2, -l m, -m^2;
            -l^2, -l m, l^2, l m;
            -l m, -m^2, l m, m^2;
        ), "Stiffness matrix of truss element"
    ) quad underbrace(
        cvec(U_1, V_1, U_2, V_2), "Displacement vector of truss element"
    ) = underbrace(
        cvec(F_(1X), F_(1Y), F_(2X), F_(2Y)), "Force vector of truss element"
    )
$

Where:
- $k = (A E)/L$
- $I equiv cos theta$
- $M equiv sin theta$

#pagebreak()

==== Note
The angle #sym.theta should be measured with respect to a horizontal line
passing through the chosen "reference node".

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        #image("./images/truss-element-reference-angle-node-1.png")

        If node 1 is taken as the "reference node", measure the angle as shown
        above.
    ],
    [
        #image("./images/truss-element-reference-angle-node-2.png")

        If node 2 is taken as the "reference node", measure the angle as shown
        above.
    ],
)

You can choose node 1 or node 2 as the "reference node" for measure the angle,
*but* the stiffness matrix and force vector need to be *labelled accordingly*.

#pagebreak()

=== Example
A truss of length #qty[1][m] and cross-sectional area #qty[0.01][m^2] is
inclined at an angle of #qty[30][#sym.degree] with respect to the horizontal
axis and carries a vertical load of #qty[100][kN] as shown in the figure. The
modulus of elasticity of the bar material is #qty[200][GPa]. Determine the
vertical displacement at the load point.

Taking node 2 as the "reference node", $theta = 30 degree$ with respect to
node 2.

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        $ l = cos theta = sqrt(3)/2, wide m = sin theta = 1/2 $
        $ k = (A E)/L = frac((0.01)(200 times 10^9), 1) = 200 times 10^7 $
        $
            k times bmat(
                l^2, l m, -l^2, -l m;
                l m, m^2, -l m, -m^2;
                -l^2, -l m, l^2, l m;
                -l m, -m^2, l m, m^2;
            ) cvec(U_2, V_2, U_1, V_1)
            = cvec(F_(2X), F_(2Y), F_(1X), F_(1Y))
        $

        Substituting the values of $l, m$ and $k$ in the element stiffness
        matrix:
        $
            k times bmat(
                3/4, sqrt(3)/4, -3/4, -sqrt(3)/4;
                sqrt(3)/4, 1/4, -sqrt(3)/4, -1/4;
                -3/4, -sqrt(3)/4, 3/4, sqrt(3)/4;
                -sqrt(3)/4, -1/4, sqrt(3)/4, 1/4;
            ) cvec(U_2, V_2, U_1, V_1)
            = cvec(F_(2X), F_(2Y), F_(1X), F_(1Y))
        $
    ],
    image("./images/truss-element-example.png"),
)

The forces can be identified as:
$
    F_(2x) equiv R_(2x), quad F_(2y) equiv R_(2y), quad F_(1x) equiv R_(1x),
    quad F_(1y) = -100 times 10^3 space #unit[N] space ("given")
$

Where $R_(2x), R_(2y)$ and $R_(1x)$ are reaction forces.

The boundary conditions are:
$ U_2 = 0, quad V_2 = 0, quad U_1 = 0 $

The boundary conditions can be easily applied by crossing out the respective
rows and columns of the stiffness matrix and load vector. This approach is
applicable for *zero-displacement boundary conditions*. Applying boundary
conditions and the load, the equations become:
$
    (200 times 10^7) times bmat(
        crosscancel(3 / 4), crosscancel(sqrt(3)/4), crosscancel(
            -3/4
        ), horzcancel(-sqrt(3)/4);
        crosscancel(sqrt(3)/4), crosscancel(1/4), crosscancel(
            -sqrt(3)/4
        ), horzcancel(-1/4);
        crosscancel(-3/4), crosscancel(-sqrt(3)/4), crosscancel(
            3/4
        ), horzcancel(sqrt(3)/4);
        crosscancel(-sqrt(3)/4), crosscancel(1 / 4), crosscancel(
            sqrt(3)/4
        ), 1/4;
    ) cvec(
        redcancel(U_2) mathred(= 0),
        redcancel(V_2) mathred(= 0),
        redcancel(U_1) mathred(= 0),
        V_1
    )
    = cvec(
        horzcancel(F_(2X)),
        horzcancel(F_(2Y)),
        horzcancel(F_(1X)),
        -100 times 10^3
    )
$

From the fourth equation, we get:
$
    (200 times 10^7) (1/4) V_1 = -100 times 10^3 quad => quad
    V_1 = -2 times 10^(-4) space #unit[m] = #qty[-0.2][mm] (bold("ans"))
$

Substituting the displacements
$U_2 = 0, V_2 = 0, U_1 = 0, V_1 = -2 times 10^(-4)$ in the first three equations
we crossed out, we can calculate the reaction forces $R_(2x), R_(2y), R_(1x)$.

== Generalised symbols for displacements and forces of beam elements
#grid(
    columns: 2,
    align: center + horizon,
    column-gutter: 10em,
    $
        bmat(
            k_(11), k_(12), k_(13), k_(14);
            k_(21), k_(22), k_(23), k_(24);
            k_(31), k_(32), k_(33), k_(34);
            k_(41), k_(42), k_(43), k_(44);
        ) cvec(v_1, theta_1, v_2, theta_2)
        = cvec(F_1, M_1, F_2, M_2)
    $,
    image(
        "./images/generalised-symbols-beam-element-specific.png",
        height: 10em,
    ),
)

Sometimes, the displacements and forces in the above equations are denoted using
*generalised symbols* as shown below:
#grid(
    columns: 2,
    align: center + horizon,
    column-gutter: 5em,
    $
        bmat(
            k_(11), k_(12), k_(13), k_(14);
            k_(21), k_(22), k_(23), k_(24);
            k_(31), k_(32), k_(33), k_(34);
            k_(41), k_(42), k_(43), k_(44);
        ) underbrace(cvec(Q_1, Q_2, Q_3, Q_4), "Generalised forces")
        = underbrace(cvec(F_1, F_2, F_3, F_4), "Generalised displacements")
    $,
    image(
        "./images/generalised-symbols-beam-element-general.png",
        height: 10em,
    ),
)

Similarly, the displacements and the forces of a *truss element* can be
represented in terms of *generalised symbols* as:
#grid(
    columns: 2,
    align: center + horizon,
    column-gutter: 10em,
    $
        bmat(
            l^2, l m, -l^2, -l m;
            l m, m^2, -l m, -m^2;
            -l^2, -l m, l^2, l m;
            -l m, -m^2, l m, m^2;
        ) cvec(Q_1, Q_2, Q_3, Q_4)
        = cvec(F_1, F_2, F_3, F_4)
    $,
    image(
        "./images/generalised-symbols-beam-element-general.png",
        height: 10em,
    ),
)

Similarly, the displacements and forces of a *spring element* can be represented
as:
#grid(
    columns: 2,
    align: center + horizon,
    column-gutter: 15em,
    $
        bmat(
            k, -k;
            -k, k;
        ) cvec(Q_1, Q_2)
        = cvec(F_1, F_2)
    $,
    image(
        "./images/generalised-symbols-beam-element-general.png",
        height: 10em,
    ),
)

#pagebreak()

== Methods to derive finite element matrices
+ Ad-hoc methods (node force balance, nodal heat balance, direct stiffness
    method)
    - Less mathematical and simple
    - Limited to simple elements
+ Variational methods
    - Particularly suitable for solids or structural mechanics applications.
    - These methods are based on variational principles.
    - An example of such a method is one that is based on the principle of
        *minimum potential energy*.
+ Method of weighted residuals
    - More general than the above two methods, and can be applied to any field
        problem (structural, thermal, fluid, electric potential, etc.)
    - One particular weighted residual method is called the *Galerkin weighted
        residual method* and it is very popular.

#pagebreak()

#heading(
    "Stiffness matrix of a spring element by the principle of "
        + "minimum potential energy",
    level: 2,
)

#grid(
    columns: 2,
    column-gutter: 3em,
    align: center + horizon,
    [
        $ "Strain energy": quad U = 1/2 k(U_2 - U_1)^2 $
        $ "Work done": quad W= F_1 U_1 + F_2 U_2 $
    ],
    image("./images/spring-element-principle-of-mpe.png", height: 10em),
)

Total potential energy:
$ Pi equiv U - W = 1/2 k(U_2 - U_1)^2 - (F_1 U_1 + F_2 U_2) $

$ "Principle of minimum potential energy": delta Pi = 0 $

Hence:
$
    delta Pi equiv frac(partial Pi, partial U_1) delta U_1
    + frac(partial Pi, partial U_2) delta U_2 = 0
$

Since $delta U_1$ and $delta U_2$ are arbitrary, $delta Pi = 0$ implies:
$ frac(partial Pi, partial U_1) = 0, quad frac(partial Pi, partial U_2) = 0 $

Since $frac(partial Pi, partial U_1) = 0$:
$ 1/2 k dot 2(U_2 - U_1)(-1) - F_1 = 0 $
#labelled_equation($k U_1 - k U_2 = F_1$, 1)

Since $frac(partial Pi, partial U_2) = 0$:
$ 1/2 k dot 2(U_2 - U_1) - F_2 = 0 $
#labelled_equation($-k U_1 + k U_2 = F_2$, 2)

The above two equations, equations $(1)$ and $(2)$, can be written in matrix
form as:
$ bmat(k, -k; -k, k) cvec(U_1, U_2) = cvec(F_1, F_2) $

Which is the same as the element equilibrium equations that is derived using
#link(<spring-element>)[nodal force balance method].

#pagebreak()

=== Note
The expression for the *total potential energy* can also be written in *matrix
form* as:
$
    Pi = 1/2 cvec(U_1, U_2)^T bmat(k, -k; -k, k) cvec(U_1, U_2)
    - cvec(U_1, U_2)^T cvec(F_1, F_2)
$

It can also be written in abstract form as:
$
    Pi = 1/2 {bold(u)^((e))}^T [bold(K)^((e))] {bold(u)^((e))}
    - {bold(u)^((e))}^T {bold(f)^((e))}
$

== Displacement interpolation for 2-node bar element
<displacement-interpolation-for-2-node-bar-element>
We need to be able to write the displacement at any point in the element in
terms of nodal displacements of the element. To do that, assume a *linear*
displacement variation in the form:
#labelled_equation($ u = a_1 + a_2 x $, 1)

Where $a_1$ and $a_2$ are unknown coefficients. Since the 2-node bar element has
just two nodes, only two unknown coefficients (a *linear* polynomial) can be
handled. The two coefficients can be determined using the following two boundary
conditions at nodes:

#grid(
    columns: 2,
    align: horizon,
    column-gutter: 2em,
    [
        $ "At node 1": x = x_1, quad u = u_1 $
        $ "At node 2": x = x_2, quad u = u_2 $

        Substituting these conditions into equation $(1)$:
        $ u_1 = a_1 + a_2 x_1 $
        $ u_2 = a_1 + a_2 x_2 $

        Solving these two equations for $a_1$ and $a_2$:
        $ a_1 = frac(x_2 u_1 - x_1 u_2, x_2 - x_1) $
        $ a_2 = frac(u_2 - u_1, x_2 - x_1) $
    ],
    image("./images/2-node-bar-element.png"),

    [

        Substituting the expressions for $a_1$ and $a_2$ back in equation $(1)$:
        $
            u = frac(x_2 u_1 - x_1 u_2, x_2 - x_1)
            + frac(u_2 - u_1, x_2 - x_1) x
        $

        We can rearrange this expression in the form:
        #labelled_equation(
            $u = frac(x_2 - x, x_2 - x_1) u_1 + frac(x - x_1, x_2 - x_1) u_2$,
            2,
        )
        #labelled_equation($u = N_1 u_1 + N_2 u_2$, 3)

        Where:
        $ N_2 = frac(x_2 - x, x_2 - x_1), quad N_2 = frac(x - x_1, x_2 - x_1) $
    ],
    image("./images/shape-function-plot.png", height: 20em),
)

The functions $N_1$ and $N_2$ are called *shape functions*.

Two important properties of shape functions:
+ $N_1$ takes a value of unity at node 1 and zero at node 2. $N_2$ takes a value
    of unity at node 2 and zero at node 1.
+ Sum of the shape functions is equal to 1:
    $ N_1 + N_2 = 1 $

We can write the element displacement interpolation in many different forms, as
shown below:
$ u = (frac(x_2 - x, x_2 - x_1)) u_1 + (frac(x - x_1, x_2 - x_1)) u_2 $
$ u = N_1 u_1 + N_2 u_2 $
$ u = bmat(N_1, N_2) cvec(u_1, u_2) $
#labelled_equation($u = [bold(N)] {bold(u)^((e))}$, 4) <equation-4>

Where:
$ N_1 = frac(x_2 - x, x_2 - x_1) $
$ N_2 = frac(x - x_1, x_2 - x_1) $
$ [bold(N)] equiv bmat(N_1, N_2) $
$ {bold(u)^((e))} = cvec(u_1, u_2) $

#pagebreak()

== Stiffness matrix of the 2-node bar element
#cimage("./images/2-node-bar-element-with-direction.png", height: 10em)

=== Step 1: Potential energy expression
Strain energy is given by:
$
    U = 1/2 integral_0^L sigma epsilon A thin dif x
    = 1/2 integral_0^L E epsilon^2 A thin dif x
$

Where $sigma = E epsilon$.

The work done is given by:
$ W = integral_0^L u T thin dif x $

The total potential energy is given by:
$
    Pi equiv U - W = 1/2 integral_0^L sigma epsilon A thin dif x
    - integral_0^L u T thin dif x
$

Where:
- $u$ is the displacement
- $epsilon equiv frac(dif u, dif x)$ is the strain
- $T$ is the distributed tensile load intensity, which can be a function of $x$

=== Step 2: Element displacement interpolation
This section has already been derived in
@displacement-interpolation-for-2-node-bar-element, so using the result here:
$ u = (frac(x_2 - x, x_2 - x_1)) u_1 + (frac(x - x_1, x_2 - x_1)) u_2 $
$ u = N_1 u_1 + N_2 u_2 $
$ u = bmat(N_1, N_2) cvec(u_1, u_2) $
$ u = [bold(N)] {bold(u)^((e))} $

Where:
$ N_1 = frac(x_2 - x, x_2 - x_1), wide N_2 = frac(x - x_1, x_2 - x_1) $
$ [bold(N)] equiv bmat(N_1, N_2), wide {bold(u)^((e))} = cvec(u_1, u_2) $

=== Step 3: Element strain
The element strain expression can be obtained by differentiating the element
displacement interpolation as follows:
$
    epsilon equiv frac(dif u, dif x)
    &= frac(dif, dif x) ([bold(N)] [bold(u)^e]) \
    &= frac(dif, dif x) (bmat(N_1, N_2) cvec(u_1, u_2)) \
    &= bmat(frac(dif N_1, dif x), frac(dif N_2, dif x)) cvec(u_1, u_2)
$

Where:
$ u = [bold(N)] {bold(u)^e}, quad [bold(N)] equiv bmat(N_1, N_2) $

The above equation can be written as:

#labelled_equation($epsilon = [bold(B)] {bold(u)^e}$, 5) <equation-5>

Where:
$
    [bold(B)] equiv = bmat(frac(dif N_1, dif x) frac(dif N_2, dif x)),
    quad {bold(u)^e} = cvec(u_1, u_2)
$

#pagebreak()

=== Step 4: Potential energy in matrix form
From the potential energy expression:
$
    Pi = 1/2 integral_0^L E epsilon^2 A thin dif x
    - integral_0^L u T thin dif x
$

Rewrite the expression for $Pi$ as:
$
    Pi = 1/2 integral_0^L epsilon^T E epsilon A thin dif x
    - integral_0^L u T thin dif x
$

From equations #link(<equation-4>)[$(4)$] and #link(<equation-5>)[$(5)$]:
$
    u = [bold(N)] {bold(u)^e} wide
    therefore quad u^T = {bold(u)^e}^T [bold(N)]^T
$
$
    epsilon = [bold(B)] {bold(u)^e} wide
    therefore quad epsilon^T = {bold(u)^e}^T [bold(B)]^T
$

Substituting for $epsilon, epsilon^T$ and $u^T$, $Pi$ becomes:
$
    Pi = 1/2 integral_0^L {bold(u)^e}^T [bold(B)]^T E [bold(B)] {bold(u)^e}
    A thin dif x
    - integral_0^L {bold(u)^e}^T [bold(N)]^T T thin dif x
$

Which can be rewritten as:
$
    Pi = 1/2 integral_0^L {bold(u)^e}^T ([bold(B)]^T E [bold(B)] A thin dif x)
    {bold(u)^e}
    - {bold(u)^e}^T (integral_0^L [bold(N)]^T T thin dif x)
$

This is in the form:
#labelled_equation(
    $Pi = 1/2 {u^((e))}^T [bold(K)^((e))] {bold(u)^((e))}
    - {bold(u)^((e))}^T {bold(f)^((e))}$,
    6,
)

Where:
$
    [bold(K)^((e))] equiv integral_0^L [bold(B)]^T E [bold(B)] A thin dif x
    quad "and" quad {bold(f)^((e))} equiv integral_0^L [bold(N)]^T T thin dif x
$
- $[bold(K)^((e))]$ is the *element stiffness matrix*
- ${bold(f)^((e))}$ is the *element force vector* due to the distributed tensile
    force.

#pagebreak()

=== Step 5: Obtaining element stiffness matrix and force vector
Element stiffness matrix:
$
    [bold(K)^((e))] & = integral_0^L [bold(B)]^T E [bold(B)] A thin dif x \
                    & = E A integral_0^L [bold(B)]^T [bold(B)] thin dif x \
                    & = E A integral_0^L
                      bmat(frac(dif N_1, dif x); frac(dif N_2, dif x))
                      bmat(frac(dif N_1, dif x), frac(dif N_2, dif x))
                      thin dif x \
                    & = E A integral_0^L bmat(-1/L; 1/L) bmat(-1/L, 1/L)
                      thin dif x \
                    & = E A integral_0^L bmat(1/L^2, -1/L^2; -1/L^2, 1/L^2)
                      thin dif x \
                    & = (E A)/L bmat(1, -1; -1, 1)
$

Where:
$ [bold(B)] equiv bmat(frac(dif N_2, dif x), frac(dif N_2, dif x)) $
$ N_1 = frac(x_2 - x, x_2 - x_1), quad N_2 = frac(x - x_1, x_2 - x_1) $
$ x_1 = 0, quad x_2 = L $
$ therefore quad N_1 = 1 - x/L, quad N_2 = x/L $

Element force vector:
$
    {bold(f)^((e))} & = integral_0^L [bold(N)]^T T thin dif x \
                    & = integral_0^L bmat(N_1, N_2)^T T thin dif x \
                    & = cvec(
                          integral_0^L N_1 T thin dif x equiv f_1,
                          integral_0^L N_2 T thin dif x equiv f_2
                      )
$

#pagebreak()

If the distributed tensile force is a constant ($T = c$):
#cimage("./images/tensile-force-constant.png", height: 10em)

#grid(
    columns: 2,
    column-gutter: 5em,
    align: horizon,
    $
        {bold(f)^((e))} = cvec(
            integral_0^L N_1 T thin dif x,
            integral_0^L N_2 T thin dif x,
        )
        = cvec(
            c integral_0^L N_1 thin dif x,
            c integral_0^L N_2 thin dif x,
        )
        = cvec(
            (c L)/2,
            (c L)/2,
        )
    $,
    image("./images/tensile-force-nodes-constant.png"),
)

If the distributed tensile force is a linearly varying force ($T = c x$):
#cimage("./images/tensile-force-linearly-varying.png")
#grid(
    columns: 2,
    column-gutter: 5em,
    align: horizon,
    $
        {bold(f)^((e))} = cvec(
            integral_0^L N_1 T thin dif x,
            integral_0^L N_2 T thin dif x,
        )
        = cvec(
            c integral_0^L N_1 x thin dif x,
            c integral_0^L N_2 x thin dif x,
        )
        = cvec(
            (c L^2)/6,
            (c L^2)/3,
        )
    $,
    image("./images/tensile-force-nodes-linearly-varying.png"),
)

#pagebreak()

== Stiffness matrix of a 3-node bar element
A 3 node bar element will give a more accurate solution than a 2-node bar
element.

=== Step 1: Element displacement interpolation
#cimage("./images/3-node-bar-element.png", height: 5em)
#labelled_equation(
    $u = a_1 + a_2 x + a_3 x^2 = bmat(1, x, x^2) cvec(a_1, a_2, a_3)$,
    7,
)

Boundary conditions at the nodes:
$ "At node 1": x = x_1, quad u = u_1 $
$ "At node 2": x = x_2, quad u = u_2 $
$ "At node 3": x = x_3, quad u = u_3 $

Imposing the conditions at the nodes:
#labelled_equation(
    $
        u_1 = a_1 + a_2 x_1 + a_3 x_1^2 \
        u_2 = a_1 + a_2 x_2 + a_3 x_2^2 \
        u_3 = a_1 + a_2 x_3 + a_3 x_3^2
    $,
    8,
)

In matrix form:
#labelled_equation(
    $
        cvec(u_1, u_2, u_3) = bmat(
            1, x_1, x_1^2;
            1, x_2, x_2^2;
            1, x_3, x_3^2;
        ) cvec(a_1, a_2, a_3)
    $,
    9,
)

The system of equations $(9)$ can be solved for $a_1, a_2$ and $a_3$. This
solution can be substituted back into equation $(7)$ which can then be
rearranged as follows:
#labelled_equation(
    $
        u & = bmat(1, x, x^2) cvec(a_1, a_2, a_3) \
          & = bmat(1, x, x^2) bmat(
                1, x_1, x_1^2;
                1, x_2, x_2^2;
                1, x_3, x_3^2;
            )^(-1) cvec(u_1, u_2, u_3) \
          & = frac((x - x_2)(x - x_3), (x_1 - x_2)(x_1 - x_3)) u_1
            + frac((x - x_1)(x - x_3), (x_2 - x_1)(x_2 - x_3)) u_2
            + frac((x - x_1)(x - x_2), (x_3 - x_1)(x_3 - x_2)) u_3
    $,
    10,
)

#pagebreak()

Defining the shape functions as:
#grid(
    columns: 2,
    align: horizon,
    column-gutter: 10em,
    $
        N_1 equiv frac((x - x_2)(x - x_3), (x_1 - x_2)(x_1 - x_3)) \
        N_2 equiv frac((x - x_1)(x - x_3), (x_2 - x_1)(x_2 - x_3)) \
        N_1 equiv frac((x - x_1)(x - x_2), (x_3 - x_1)(x_3 - x_2))
    $,
    image("./images/3-node-bar-element-shape-functions.png", height: 10em),
)

The displacement interpolation can be written as:
$ u = N_1 u_1 + N_2 u_2 + N_3 u_3 $
$ u = [bold(N)] {bold(u)^e} $

Where:
$ [bold(N) = bmat(N_1, N_2, N_3)], quad {bold(u)^e} = cvec(u_1, u_2, u_3) $

=== Step 2: Element strain
The strain expression can be obtained by differentiating displacement
interpolation as follows:
$
    epsilon equiv frac(dif u, dif x) & = frac(dif, dif x)
                                       ([bold(u)]{bold(u)^e}) \
                                     & = frac(dif, dif x) (
                                           bmat(N_1, N_2, N_3)
                                           cvec(u_1, u_2, u_3)
                                       ) \
                                     & = bmat(
                                           frac(dif N_1, dif x),
                                           frac(dif N_2, dif x),
                                           frac(dif N_3, dif x),
                                       )
                                       cvec(u_1, u_2, u_3)
$

Where:
$ u = [bold(N)] {bold(u)^e} quad [bold(N)] equiv bmat(N_1, N_2, N_3) $
$
    N_1 equiv frac((x - x_2)(x - x_3), (x_1 - x_2)(x_1 - x_3)) wide
    N_2 equiv frac((x - x_1)(x - x_3), (x_2 - x_1)(x_2 - x_3)) wide
    N_1 equiv frac((x - x_1)(x - x_2), (x_3 - x_1)(x_3 - x_2))
$

Which can be written as:
$ epsilon = [bold(B)] {bold(u)^e} $

Where:
$
    [bold(B)] equiv bmat(
        frac(dif N_1, dif x),
        frac(dif N_2, dif x),
        frac(dif N_3, dif x),
    ), quad {bold(u)^e} = cvec(u_1, u_2, u_3)
$

#pagebreak()

=== Step 3: Obtaining the element stiffness matrix and force vector
Having obtained the $[bold(N)]$ matrix and $[bold(B)]$ matrix in the previous
step, we can obtain the element stiffness matrix and element force vector using
the formulas:
$ [bold(K)^((e))] = integral_0^L [bold(B)]^T E [bold(B)] A thin dif x $
$ {bold(f)^((e))} = integral_0^L [bold(N)]^T T thin dif x $

Where:
$
    [bold(B)] = bmat(
        frac(dif N_1, dif x),
        frac(dif N_2, dif x),
        frac(dif N_3, dif x),
    ), quad
    [bold(N)] = bmat(N_1, N_2, N_3)
$
$
    N_1 equiv frac((x - x_2)(x - x_3), (x_1 - x_2)(x_1 - x_3)) wide
    N_2 equiv frac((x - x_1)(x - x_3), (x_2 - x_1)(x_2 - x_3)) wide
    N_1 equiv frac((x - x_1)(x - x_2), (x_3 - x_1)(x_3 - x_2))
$

For constant values of $E, A$ and $T$, the element stiffness matrix and force
vectors can be obtained by integration as follows:
$
    [bold(K)^((e))] = integral_0^L [bold(B)]^T E [bold(B)] A thin dif x
    = (E A)/L bmat(
        7/3, -8/3, 1/3;
        -8/3, 16/3, -8/3;
        1/3, -8/3, 7/3;
    )
$
$
    therefore quad {bold(f^((e)))} &= integral_0^L [bold(N)]^T T thin dif x \
    &= T integral_0^L cvec(N_1, N_2, N_3) thin dif x \
    &= T cvec(
        integral_0^L N_1 thin dif x,
        integral_0^L N_2 thin dif x,
        integral_0^L N_3 thin dif x,
    ) \
    &= cvec((T L)/6, (2T L)/6, (T L)/6)
$

#pagebreak()

== Stiffness matrix of 2-node beam element

=== Expression for potential energy (#sym.Pi)
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Strain energy due to bending:
        $
            U_b = 1/2 integral_0^L E I (frac(dif^2 w, dif x^2))^2 thin dif x
            quad (w = "vertical displacement")
        $

        Work done by the distributed force:
        $
            W = integral_0^L q w thin dif x
            quad (q = "distributed force" (#unit[N m^-1]))
        $
    ],
    image("./images/2-node-beam-element.png", height: 10em),
)

Total potential energy (#sym.Pi):
$
    Pi & = "Strain energy (due to bending)" - "Work done" \
       & = U_b - W \
       & = 1/2 integral_0^L E I (frac(dif^2 w, dif x^2))^2 thin dif x
         - integral_0^L q w thin dif x \
       & = underbrace(
             1/2 integral_0^L (frac(dif^2 w, dif x^2))^2
             E I (frac(dif^2 w, dif x^2)) thin dif x,
             "Strain energy due to bending"
         )
         - underbrace(integral_0^L w^T q thin dif x, "Work done")
$

=== Beam element derivation
#cimage("./images/2-node-beam-element-euler-bernoulli.png")
$ "Number of degrees of freedom per node" = 2 quad (w_i, theta_i) $
$
    "Number of degrees of freedom per element"
    = 4 quad (w_1, theta_1, w_2, theta_2)
$

#pagebreak()

==== Step 1: Displacement interpolation
#labelled_equation(
    $
        w = a_1 + a_2 x + a_3 x^2 + a_4 x^3 \
        theta = frac(dif w, dif x) = a_2 + 2 a_3 x + 3 a_4 x^2
    $,
    11,
) <equation-11>

At node 1 ($x = x_1$), we have $w = w_1$ and $frac(dif w, dif x) = theta_1$.
This gives us two equations:
$ w_1 = a_1 + a_2 x_1 + a_3 x_1^2 + a_4 x_1^3 $
$ theta_1 = a_2 + 2a_3 x_1 + 3a_4 x_1^2 $

At node 2 ($x = x_2$), we have $w = w_2$ and $frac(dif w, dif x) = theta_2$.
This gives us two more equations:
$ w_2 = a_1 + a_2 x_2 + a_3 x_2^2 + a_4 x_2^3 $
$ theta_1 = a_2 + 2a_3 x_2 + 3a_4 x_2^2 $

Letting $x_1 = 0$ and $x_2 = L$, the above four equations can be solved for the
polynomial coefficients as:
$ a_1 = w_1 quad a_3 = - frac(L(2 theta_1 + theta_2) + 3(w_1 - w_2), L^2) $
$ a_2 = theta_1 quad a_4 = frac(L(theta_1 + theta_2) + 2(w_1 - w_2), L^3) $

Substituting these expressions for the polynomial coefficients back in #link(
    <equation-11>,
)[equation $(11)$], the displacement interpolation can be re-arranged in the
form:
$ w = [bold(N)] {bold(u)^e} $

Where:
$ [bold(N)] = bmat(N_1, N_2, N_3, N_4) $
$ {bold(u)^e} = cvec(w_1, theta_1, w_2, theta_2) $

#grid(
    columns: 2,
    column-gutter: 5em,
    align: horizon,
    [
        Shape functions:
        $ N_1 = (2 x^3 - 3 L x^2 + L^3)/L^3 $
        $ N_2 = (x^3 - 2 L x^2 + L^2 x)/L^2 $
        $ N_3 = -(2x^3 - 3 L x^2)/L^3 $
        $ N_4 = (x^3 - L x^2)/L^2 $
    ],
    image(
        "./images/2-node-beam-element-shape-function-plots.png",
        height: 18em,
    ),
)

#pagebreak()

==== Step 2: Second derivative expression
$
    frac(dif^2 w, dif x^2)
    = frac(dif^2 ([bold(N)] {bold(u)^e}), dif x^2)
    = frac(dif^2 [bold(N)], dif x^2) {bold(u)^e}
    = [bold(B)] {bold(u)^e}
$

==== Step 3: Potential energy
$
    Pi & = overbrace(
             1/2 integral_0^L (frac(dif^2 w, dif x^2))^T E I
             (frac(dif^2 w, dif x^2)) thin dif x,
             "Strain energy"
         ) - overbrace(
             integral_0^L w^T q thin dif x,
             "Work done"
         ) \
    Pi & = 1/2 {bold(u)^e}^T (integral_0^L [bold(B)]^T E I [bold(B)] thin dif x)
         {bold(u)^e} - {bold(u)^e}^T integral_0^L [bold(N)]^T q thin dif x \
    Pi & = 1/2 {bold(u)^e}^T [bold(K)^e] {bold(u)^e}
         - {bold(u)^e}^T {bold(f)_q^e} \
$

Where:
$ [bold(N)] = bmat(N_1, N_2, N_3, N_4) $
$
    [bold(B)] equiv frac(dif^2 [bold(N)], dif x^2) = bmat(
        frac(dif^2 N_1, dif x^2),
        frac(dif^2 N_2, dif x^2),
        frac(dif^2 N_3, dif x^2),
        frac(dif^2 N_4, dif x^2),
    )
$
$ {bold(u)^e} = bmat(w_1, theta_1, w_2, theta_2)^T $
$ w = [bold(N)] {bold(u)^e}, quad w^T = {bold(u)^e}^T [bold(N)]^T $
$
    frac(dif^2 w, dif x^2) = [bold(B)] {bold(u)^e}, quad
    (frac(dif^2 w, dif x^2))^T = {bold(u)^e}^T [bold(B)]^T
$

Element stiffness matrix:
$ [bold(K)^e] = integral_0^L [bold(B)]^T E I [bold(B)] thin dif x $

Element force vector due to distributed load:
$ {bold(f)_q^e} = integral_0^L [bold(N)]^T q thin dif x $

#pagebreak()

=== Numerical evaluation of stiffness matrix and force vector
Once the nodal coordinates are known, the shape functions $N_1, N_2, N_3$ and
$N_4$ can be obtained. Using these shape functions, the $[bold(N)]$ matrix and
the $[bold(B)]$ matrix can be obtained. Using these matrices, the stiffness
matrix and element force vector can be obtained by integration which may in
general be tedious.

However, for constant values of $E, I$ and $q$, the element stiffness matrix and
force vector can be evaluated easily.

If $E I$ is constant:
$ [bold(K)^e] = integral_0^L [bold(B)]^T E I [bold(B)] thin dif x $
$
    [bold(K)^e] = (E I)/L^3 bmat(
        12, 6L, -12, 6L;
        6L, 4L^2, -6L, 2L^2;
        -12, -6L, 12, -6L;
        6L, 2L^2, -6L, 4L^2;
    )
$

Note that the stiffness matrix derived here is the same as the one obtained from
the #link(<beam-element>)[direct stiffness method].

If $q$ is constant:
$ {bold(f)_q^e} = integral_0^L [bold(N)]^T q thin dif x $
$ {bold(f)_q^e} = cvec((q L)/2, (q L^2)/12, (q L)/2, -(q L^2)/12) $

#cimage("./images/uniformly-distributed-load.png")
#pagebreak()

== General expressions for finite element matrices
*General* means that we do not refer to any particular element shape or number
of nodes in the element.

Potential energy expression for a general 2D solid is of the form:
$
    Pi =
    overbrace(1/2 integral_V {bold(epsilon)}^T {bold(sigma)} thin dif, "U") V
    - overbrace(
        integral_V {bold(u)}^T {bold(b)} thin dif V
        - integral_S {bold(u)}^T {bold(bar(macron(t)))} thin dif S, "W"
    )
$ <potential-energy-expression>

Where:
#table(
    columns: 5,
    align: center,
    stroke: none,
    $ {bold(u)} = cvec(u, v) $,
    $ {bold(b)} = cvec(b_x, b_y) $,
    $ {bold(macron(t))} = cvec(macron(t)_x, macron(t)_y) $,
    $ {bold(sigma)} = cvec(sigma_x, sigma_y, tau_(x y)) $,
    $ {bold(epsilon)} = cvec(epsilon_x, epsilon_y, gamma_(x y)) $,

    [*Displacement vector*],
    [*Body force vector*],
    [*Surface force vector*],
    [*"Stress vector"*],
    [*"Strain vector"*],

    [(#unit[m])],
    [(#unit[N m^-3])],
    [(#unit[N m^-2])],
    [(#unit[N m^-2])],
    [(no units)],
)

#cimage("./images/planar-elastic-body.png")
#pagebreak()

== Deriving the stiffness matrix and force vector

=== Step 1: Element displacement interpolation
$ u = N_1 u_1 + N_2 u_2 + N_3 u_3 + dots.c + N_n u_n $
$ v = N_1 v_1 + N_2 v_2 + N_3 v_3 + dots.c + N_n v_n $
$
    cvec(u, v) & = bmat(
                     N_1, 0, N_2, 0, N_3, 0, dots.c, N_n, 0;
                     0, N_1, 0, N_2, 0, N_3, dots.c, 0, N_n;
                 )
                 cvec(u_1, v_1, u_2, v_2, u_3, v_3, dots.v, u_n, v_n) \
     {bold(u)} & = [bold(N)]{bold(u)^((e))}
$

$
    [bold(N)] equiv bmat(
        N_1, 0, N_2, 0, N_3, 0, dots.c, N_n, 0;
        0, N_1, 0, N_2, 0, N_3, dots.c, 0, N_n;
    ) quad "(Shape function matrix)"
$

=== Step 2: Element strain expression
For plane stress and strain problems, the "strain vector" is written as:
$
    cvec(
        epsilon_x,
        epsilon_y,
        gamma_(x y)
    ) & = cvec(
            frac(partial u, partial x),
            frac(partial v, partial y),
            frac(partial u, partial y) + frac(partial v, partial x)
        )
        = bmat(
            partial/(partial x), 0;
            0, partial/(partial y);
            partial/(partial y), partial/(partial x)
        ) cvec(u, v) \
      & = bmat(
            partial/(partial x), 0;
            0, partial/(partial y);
            partial/(partial y), partial/(partial x)
        ) bmat(
            N_1, 0, N_2, 0, N_3, 0, dots.c, N_n, 0;
            0, N_1, 0, N_2, 0, N_3, dots.c, 0, N_n;
        )
        cvec(u_1, v_1, u_2, v_2, u_3, v_3, dots.v, u_n, v_n) \
      & = bmat(
            frac(
                partial N_1,
                partial x
            ), 0, frac(
                partial N_2,
                partial x
            ), 0, frac(
                partial N_3,
                partial x
            ), 0, dots.c, frac(
                partial N_n,
                partial x
            ), 0;
             //
            0, frac(
                partial N_1,
                partial x
            ), 0, frac(
                partial N_2,
                partial x
            ), 0, frac(
                partial N_3,
                partial x
            ), dots.c, 0, frac(
                partial N_n,
                partial x
            );
             //
            frac(partial N_1, partial y), frac(
                partial N_1, partial x
            ), frac(partial N_2, partial y), frac(
                partial N_2, partial x
            ), frac(partial N_3, partial y), frac(
                partial N_3, partial x
            ), dots.c, frac(partial N_n, partial y), frac(
                partial N_n,
                partial x
            );
        )
        cvec(u_1, v_1, u_2, v_2, u_3, v_3, dots.v, u_n, v_n)
$

$
    {bold(epsilon)}
    = [bold(B)] {bold(u)^((e))} quad "(Strain-displacement matrix)"
$

=== Step 3: Stress-strain expression
For plane stress or plane strain problems, the "stress vector" is related to the
"strain vector" as:
$ {bold(sigma)} = [bold(D)] {bold(epsilon)} $
$ {bold(sigma)} = [bold(D)] [bold(B)] {bold(u)^e} $

Where $[bold(D)]$ is called the *constitutive matrix of material property
matrix*.

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        For plane stress problems ($x y$-plane):
        $
            [bold(D)] = E/(1 - v^2) bmat(
                1, v, 0;
                v, 1, 0;
                0, 0, frac(1 - v, 2);
            )
        $

        For plane strain problems ($x y$-plane):
        $
            [bold(D)] = E/((1 + v) (1 - 2 v)) bmat(
                1 - v, v, 0;
                v, 1 - v, 0;
                0, 0, frac(1 - 2 v, 2);
            )
        $

        Where:
        - $E$ is Young's modulus
        - $v$ is Poisson's ratio
    ],
    [
        #figure(
            image("./images/thin-disc-in-plane-loading.png"),
            caption: [
                A *thin* disc subjected to an in-plane loading ($x y$-plane).
                Geometry and loading are prismatic, which means the geometry and
                the loading is uniform across the length of the disc.
            ],
        )

        #figure(
            image("./images/axially-constrained-cylinder.png"),
            caption: [
                An *axially constrained* cylinder subjected to in-plane loading
                ($x y$-plane). Geometry and loading are prismatic, which means
                the geometry and the loading is uniform across the length of the
                disc.
            ],
        )
    ],
)

#pagebreak()

=== Step 4: Identify element stiffness matrix and element load vectors
Substituting the expression ${bold(u)} = [bold(N)] {bold(u)^((e))}$,
${bold(epsilon)} = [bold(B)] {bold(u)^e}$,
${bold(epsilon)} = [bold(D)] [bold(B)] {bold(u)^e}$ into the #link(
    <potential-energy-expression>,
)[potential energy expression]:

$
    Pi = 1/2 integral_V {bold(epsilon)}^T {bold(sigma)} thin dif V
    - integral_V {bold(u)}^T {bold(b)} thin dif V
    - integral_S {bold(u)}^T {bold(macron(t))} thin dif S
$
$
    Pi = 1/2 integral_V {bold(u)^e}^T
    [bold(B)]^T [bold(D)] [bold(B)] {bold(u)^e} thin dif V
    - integral_V {bold(u)^e}^T [bold(N)]^T {bold(b)} thin dif V^e
    - integral_S {bold(u)^e}^T [bold(N)]^T {bold(macron(t))} thin dif S
$
$
    Pi = 1/2 {bold(u)^e}^T
    (integral_V [bold(B)]^T [bold(D)] [bold(B)] thin dif V) {bold(u)^e}
    - {bold(u)^e}^T (integral_V [bold(N)]^T {bold(b)} thin dif V^e)
    - {bold(u)^e}^T (integral_S [bold(N)]^T {bold(macron(t))} thin dif S)
$

The element matrices are:
$
    [bold(K)^e] = integral_V [bold(B)]^T [bold(D)] [bold(B)] thin dif V
    quad "(Element stiffness matrix)"
$
$
    [bold(f)_b^e] = integral_V [bold(N)]^T [bold(b)] thin dif V
    quad "(Element load vector due to body force)"
$
$
    [bold(f)_macron(t)^e] = integral_S [bold(N)]^T [bold(macron(t))] thin dif S
    quad "(Element load vector due to surface force)"
$

#pagebreak()

== Bilinear rectangular element

=== Step 1: Element displacement interpolation
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        #labelled_equation(
            $
                u equiv u (x, y) = alpha_1 + alpha_2 x + alpha_3 y
                + alpha_4 x y \
                v equiv v (x, y) = beta_1 + beta_2 x + beta_3 y + beta_4 x y
            $,
            1,
        )

        The $x y$ term is called the bilinear term.

        #labelled_equation(
            $
                u_1 = alpha_1 + alpha_2 x_1 + alpha_3 y_1 + alpha_4 x_1 y_1 \
                u_2 = alpha_2 + alpha_2 x_2 + alpha_3 y_2 + alpha_4 x_2 y_2 \
                u_3 = alpha_3 + alpha_2 x_3 + alpha_3 y_3 + alpha_4 x_3 y_3 \
                u_4 = alpha_4 + alpha_2 x_4 + alpha_3 y_4 + alpha_4 x_4 y_4
            $,
            2,
        )

        Equation $(2)$ in matrix form:
        #labelled_equation(
            $
                cvec(u_1, u_2, u_3, u_4) = bmat(
                    1, x_1, y_1, x_1 y_1;
                    1, x_2, y_2, x_2 y_2;
                    1, x_3, y_3, x_3 y_3;
                    1, x_4, y_4, x_4 y_4;
                )
                cvec(alpha_1, alpha_2, alpha_3, alpha_4)
            $,
            3,
        )
    ],
    [
        #image("./images/bilinear-rectangular-element.png")

        $ x_1 = -a, quad x_2 = a, quad x_3 = a, quad x_4 = -a $
        $ y_1 = -b, quad y_2 = -b, quad y_3 = b, quad y_4 = b $
        $ "Thickness" = t $
    ],
)

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Equation $(3)$ can be solved for $alpha_1, alpha_2, alpha_3$ and
        $alpha_4$. This solution can be substituted in equation $(1)$. Equation
        $(1)$ can then be re-arranged as:
        $ u = N_1 u_1 + N_2 u_2 + N_3 u_3 + N_4 u_4 $
        $ v = N_1 v_1 + N_2 v_2 + N_3 v_3 + N_4 v_4 $

        Where:
        $
            N_1 = frac((a - x) (b - y), 4 a b),
            quad N_2 = frac((a + x) (b - y), 4 a b)
        $
        $
            N_3 = frac((a + x) (b + y), 4 a b),
            quad N_4 = frac((a - x) (b + y), 4 a b)
        $

        The $u$ and $v$ displacements can be written in matrix form as:
        $
            cvec(u, v) = bmat(
                N_1, 0, N_2, 0, N_3, 0, N_4, 0;
                0, N_1, 0, N_2, 0, N_3, 0, N_4;
            )
            cvec(u_1, v_1, u_2, v_2, u_3, v_3, u_4, v_4)
        $

        $ {bold(u)} = [bold(N)] {bold(u)^e} quad "(Shape function matrix)" $

        The shape function for any node takes a value of 1 at that node and zero
        along edges not containing that node, as shown in the diagrams on the
        right.
    ],
    image("./images/shape-function-matrix-diagrams.png", height: 39em),
)

=== Step 2: Element strain expression
For plane stress or plane strain problems:
$
    cvec(
        epsilon_x,
        epsilon_y,
        gamma_(x y)
    ) & = cvec(
            frac(partial u, partial x),
            frac(partial v, partial y),
            frac(partial u, partial y) + frac(partial v, partial x)
        )
        = bmat(
            partial/(partial x), 0;
            0, partial/(partial y);
            partial/(partial y), partial/(partial x)
        ) cvec(u, v) \
      & = bmat(
            partial/(partial x), 0;
            0, partial/(partial y);
            partial/(partial y), partial/(partial x)
        ) bmat(
            N_1, 0, N_2, 0, N_3, 0, N_4, 0;
            0, N_1, 0, N_2, 0, N_3, 0, N_4;
        )
        cvec(u_1, v_1, u_2, v_2, u_3, v_3, u_4, v_4) \
      & = bmat(
            frac(
                partial N_1,
                partial x
            ), 0, frac(
                partial N_2,
                partial x
            ), 0, frac(
                partial N_3,
                partial x
            ), 0, frac(
                partial N_4,
                partial x
            ), 0;
             //
            0, frac(
                partial N_1,
                partial x
            ), 0, frac(
                partial N_2,
                partial x
            ), 0, frac(
                partial N_3,
                partial x
            ), 0, frac(
                partial N_4,
                partial x
            );
             //
            frac(partial N_1, partial y), frac(
                partial N_1, partial x
            ), frac(partial N_2, partial y), frac(
                partial N_2, partial x
            ), frac(partial N_3, partial y), frac(
                partial N_3, partial x
            ), frac(partial N_4, partial y), frac(
                partial N_4,
                partial x
            );
        )
        cvec(u_1, v_1, u_2, v_2, u_3, v_3, u_4, v_4)
$

$
    {bold(epsilon)}
    = [bold(B)] {bold(u)^((e))} quad "(Strain-displacement matrix)"
$

Where:
$
    [bold(N)] = bmat(
        N_1, 0, N_2, 0, N_3, 0, N_4, 0;
        0, N_1, 0, N_2, 0, N_3, 0, N_4;
    )
$

$
    [bold(B)] = bmat(
        frac(
            partial N_1,
            partial x
        ), 0, frac(
            partial N_2,
            partial x
        ), 0, frac(
            partial N_3,
            partial x
        ), 0, frac(
            partial N_4,
            partial x
        ), 0;
         //
        0, frac(
            partial N_1,
            partial x
        ), 0, frac(
            partial N_2,
            partial x
        ), 0, frac(
            partial N_3,
            partial x
        ), 0, frac(
            partial N_4,
            partial x
        );
         //
        frac(partial N_1, partial y), frac(
            partial N_1, partial x
        ), frac(partial N_2, partial y), frac(
            partial N_2, partial x
        ), frac(partial N_3, partial y), frac(
            partial N_3, partial x
        ), frac(partial N_4, partial y), frac(
            partial N_4,
            partial x
        );
    )
$

$
    N_1 = frac((a - x) (b - y), 4 a b),
    quad N_2 = frac((a + x) (b - y), 4 a b) \
    N_3 = frac((a + x) (b + y), 4 a b),
    quad N_4 = frac((a - x) (b + y), 4 a b) \
$

$
    [bold(B)] = (1/(4 a b)) bmat(
        -(b - y), 0, (b - y), 0, (b + y), 0, -(b + y), 0;
        0, -(a - x), 0, -(a + x), 0, (a + x), 0, (a - x);
         //
        -(a - x), -(b - y), -(a + x), (b - y), (a + x), (b + y), (a - x), -(
            b + y
        );
    )
$

Note that the $[bold(B)]$ matrix involves functions of $x$ and $y$ coordinates.

#pagebreak()

=== Step 3: Element stiffness matrix calculation
$ [bold(K)^e] = integral_V [bold(B)]^T [bold(D)] [bold(B)] thin dif V $
$
    integral_(A^e) [bold(B)]^T [bold(D)] [bold(B)] t thin dif A^e
    = integral_(-b)^b integral_(-a)^a [bold(B)]^T [bold(D)] [bold(B)] t
    thin dif x thin dif y
$
- The integrand will be a function of $x$ and $y$ coordinates.
- The integral can be integrated analytically but with some effort.
- Actual stiffness matrix is not shown here because it is extremely large.
- In finite element programs, the integral is carried out numerically.

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        Note that this element has a rectangular shape. hence, only problems
        involving rectangular geometry can be meshed or analysed with this
        element. For meshing non-rectangular geometries, we need to use other
        elements.
    ],
    image(
        "./images/bilinear-rectangular-element-simplified-diagram.png",
    ),

    [
        *Isoparametric (mapped) quadrilateral elements* can be conveniently used
        to mesh non-rectangular and even curved geometries.
    ],
    image("./images/quadrilateral-element.png", height: 20em),
)

#pagebreak()

=== Step 4: Element load vector due to body force
$ {bold(f)_b^e} = integral_V [bold(N)]^T {bold(b)} thin dif V $
$ dif V = t thin dif A = t thin dif x thin dif y $
$ {bold(f)_b^e} = integral_(A^e) [bold(N)]^T {bold(b)} t thin dif x thin dif y $
$
    {bold(f)_b^e} = integral_(A^e) bmat(
        N_1, 0;
        0, N_1;
        N_2, 0;
        0, N_2;
        N_3, 0;
        0, N_3;
        N_4, 0;
        0, N_4;
    ) cvec(b_x, b_y) t thin dif x thin dif y
    = cvec(
        t integral_(A^e) N_1 b_x thin dif x thin dif y,
        t integral_(A^e) N_1 b_y thin dif x thin dif y,
        t integral_(A^e) N_2 b_x thin dif x thin dif y,
        t integral_(A^e) N_2 b_y thin dif x thin dif y,
        t integral_(A^e) N_3 b_x thin dif x thin dif y,
        t integral_(A^e) N_3 b_y thin dif x thin dif y,
        t integral_(A^e) N_4 b_x thin dif x thin dif y,
        t integral_(A^e) N_4 b_y thin dif x thin dif y,
    )
    = cvec(
        t b_x integral_(A^e) N_1 thin dif x thin dif y,
        t b_y integral_(A^e) N_1 thin dif x thin dif y,
        t b_x integral_(A^e) N_2 thin dif x thin dif y,
        t b_y integral_(A^e) N_2 thin dif x thin dif y,
        t b_x integral_(A^e) N_3 thin dif x thin dif y,
        t b_y integral_(A^e) N_3 thin dif x thin dif y,
        t b_x integral_(A^e) N_4 thin dif x thin dif y,
        t b_y integral_(A^e) N_4 thin dif x thin dif y,
    )
    = cvec(
        t b_x a b = f_(1x),
        t b_y a b = f_(1y),
        t b_x a b = f_(2x),
        t b_y a b = f_(2y),
        t b_x a b = f_(3y),
        t b_y a b = f_(3y),
        t b_x a b = f_(4y),
        t b_y a b = f_(4y),
    )
$

#cimage("./images/rectangular-element-load-vector.png")
#pagebreak()

=== Step 5: Element load vector due to surface force
Considering a surface load of $q$ #unit[N m^-2] is acting on side 2-3. We want
to derive the *element load vector* corresponding to this load.

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Resolving the load into horizontal and vertical components:
        $
            {bold(macron(t))} = cvec(macron(t)_x, macron(t)_y)
            = cvec(q cos theta, q sin theta)
        $

        Element load vector formula:
        $
            {bold(f)_macron(t)^e}
            = integral_S [bold(N)]^T {bold(macron(t))} thin dif S
        $

        We can write:
        $ dif S = t thin dif y $

        Where $t$ is the thickness of the element and $dif y$ is the
        infinitesimal distance along side 2-3.

        Substituting for $dif S$, the element load vector formula becomes:
        $
            {bold(f)_macron(t)^e}
            = integral_S [bold(N)]^t {bold(macron(t))} t thin dif y
        $
    ],
    image("./images/rectangular-element-load-due-to-surface-force.png"),
)

Alongside 2-3, $x = a$. Hence, the shape functions become simpler:
$
    N_1 = frac((a - x) (b - y), 4 a b) = 0,
    quad N_2 = frac((a + x) (b - y), 4 a b) = frac((b - y), 2b)
$

$
    N_4 = frac((a - x) (b + y), 4 a b) = 0,
    quad N_3 = frac((a + x) (b + y), 4 a b) = frac((b + y), 2b)
$

$
    {bold(f)_macron(t)^e} = integral_(-b)^b bmat(
        redcancel(N_1) mathred(= 0), 0;
        0, redcancel(N_1) mathred(= 0);
        N_2, 0;
        0, N_2;
        N_3, 0;
        0, N_3;
        redcancel(N_4) mathred(= 0), 0;
        0, redcancel(N_4) mathred(= 0);
    ) cvec(macron(t)_x, macron(t)_y) t thin dif y
    = cvec(
        0,
        0,
        t integral_(-b)^b N_2 macron(t)_x thin dif y,
        t integral_(-b)^b N_2 macron(t)_y thin dif y,
        t integral_(-b)^b N_3 macron(t)_x thin dif y,
        t integral_(-b)^b N_3 macron(t)_y thin dif y,
        0,
        0,
    )
    = cvec(
        0,
        0,
        t macron(t)_x integral_(-b)^b frac((b - y), 2b) thin dif y,
        t macron(t)_y integral_(-b)^b frac((b - y), 2b) thin dif y,
        t macron(t)_x integral_(-b)^b frac((b + y), 2b) thin dif y,
        t macron(t)_y integral_(-b)^b frac((b + y), 2b) thin dif y,
        0,
        0,
    )
    = cvec(
        0 = f_(1x),
        0 = f_(1y),
        t b macron(t)_x = f_(2x),
        t b macron(t)_y = f_(2y),
        t b macron(t)_x = f_(3x),
        t b macron(t)_y = f_(3y),
        0 = f_(4x),
        0 = f_(4y),
    )
$

#cimage("./images/rectangular-element-load-vector.png", height: 7em)

== Practical finite element analysis (FEA)
- Several finite element software packages (e.g. ANSYS, NASTRAN, ABAQUS, COMSOL,
    LS-DYNA, Autodesk Simulation, DIANA and ADINA) are available for finite
    element analysis of practical problems.
- Popular element types that are available in finite element software packages:
    #cimage("./images/popular-element-types.png")

=== Typical 1D elements
#cimage("./images/typical-1d-elements-1.png", width: 90%)
#cimage("./images/typical-1d-elements-2.png", width: 90%)
#cimage("./images/typical-1d-elements-3.png")

Note that no transformation of the element conduction matrix needs to be
performed for the truss element, regardless of whether the problem is 1D, 2D or
3D.

=== Typical 2D elements
#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/typical-2d-elements-plane-elements.png"),
    [
        *Example plane stress case*: A thin planar sheet subjected to #text(
            red,
        )[in-plane loading].

        *Example plane strain case*: Prismatic members subjected to #text(
            red,
        )[in-plane loading] with #text(red)[end faces restrained]. The loading
        is in the $x y$ plane, or the cross-sectional plane.

        #image("./images/typical-2d-elements-plane-elements-example.png")
    ],
)

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    [
        #image("./images/typical-2d-elements-triangular-plate.png")

        - 3 degrees of freedom per node
        - Degrees of freedom are shown only for node 1.
        - Similar degrees of freedom apply to other nodes as well.
            - $Q_1$ is $y$-displacement
            - $Q_2$ is $z$-rotation
            - $Q_3$ is $x$-rotation

        #image("./images/typical-2-elements-quadrilateral-plate.png")

        The degrees of freedom on this element are the same as the triangular
        plate element.
    ],
    image("./images/typical-2d-elements-thin-plates.png"),
)

#pagebreak()

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    [
        #image("./images/typical-2d-elements-triangular-shell.png")

        - 6 degrees of freedom per node. The degrees of freedom are shown only
            for node 1.
        - 3 translations along 3 axes and 3 rotations about the 3 axes.
        - In-plane rotations are suppressed during formulation or derivation of
            the stiffness matrix.

        #image("./images/typical-2d-elements-quadrilateral-shell.png")

        The degrees of freedom on this element are the same as the triangular
        plate element.
    ],
    [
        #image("./images/typical-2d-elements-rectangular-shell-flat.png")
        Rectangular shell elements for modelling a flat shell structure.

        #image("./images/typical-2d-elements-rectangular-shell-curved.png")
        Rectangular shell elements for modelling a curved shell.
    ],
)

=== What element type to use for a given problem?

==== Example 1
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/type-of-element-to-use-1.png"),
    [
        - Consider a stepped cantilever bar subjected to tensile or compressive
            loading.
        - You may use the *bar element model* if you just want to compute the
            axial displacement.
        - You should use the *3D solid element model* if you want to compute the
            stresses (at the fillet in particular). This model is useful to
            determine both displacements and stresses.
    ],
)

==== Example 2
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/type-of-element-to-use-2.png"),
    [
        - Consider a hollow cylinder subjected to bending load.
        - You may use the *beam element model* if just nodal displacements are
            needed.
        - You may use the *shell element model* if the given cylinder is a thin
            cylinder ($d > 20 t$). This model is useful for determining both
            deformations and stresses.
        - You should use the *3D solid element model* if the given cylinder is a
            thick cylinder ($d < 20 t$). This model is useful to determine both
            deformations and stresses.
    ],
)

==== Other examples
#cimage("./images/type-of-element-to-use-3.png")

=== Major stages in practical finite element analysis

==== Preprocessing
- Building the geometrical model (CAD model)
- Meshing the geometrical model
- Applying boundary conditions and loads

==== Solution
- Choosing the type of analysis, like static, modal, harmonic, etc
- Solving finite element equations

==== Post-processing
- Plotting deformed shape
- Plotting contour plots of displacements and stresses or strains
- Animating deformed shape or mode shape
- Listing or probing the numerical values of results, like displacement, stress
    and strain, and reactions.

#pagebreak()

=== Practical aspects of finite element analysis
*Accuracy of finite element analysis results depends greatly on how accurately
we model*:
- Geometrical details
- Boundary conditions
- Loads

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        For geometrical details:
        - Try to model all geometrical details as accurately as possible.
        - However, features such as small holes, small cutouts, and logos will
            not usually affect the finite element analysis results significantly
            and hence such features can be ignored, if these features are
            located away from the region of interest.
    ],
    image("./images/modelling-geometrical-details.png"),
)

For boundary conditions (BCs):
- Try to model all boundary conditions as accurately as possible.
- However, if the region of interest is elsewhere, like away from the boundary
    conditions, simplified boundary conditions can be applied.

For loads:
- Try to model all loads as accurately as possible.
- However, if the region of interest is elsewhere, like away from the location
    of loads, simplified loads can be applied.

*Do not forget to apply boundary conditions*.
- In static analysis, finite element equations cannot be solved without applying
    boundary conditions. The stiffness matrix will be singular if the boundary
    conditions are not applied, and in such a case, the finite element analysis
    software will abort with a warning message.

*Use the minimum number of necessary boundary conditions*, so that finite
element equations can be solved.
- The boundary conditions applied should be capable of *restraining all the
    rigid body motions* of the body. In 2D analysis, there are three rigid body
    motions:
    + Translation along $x$-direction
    + Translation along $y$-direction
    + Rotation in $x y$-plane

    Assume that we want to solve the problem of a simply supported beam shown
    below:
    #grid(
        columns: 2,
        column-gutter: 2em,
        align: horizon,
        image("./images/insufficient-boundary-conditions.png"),
        [
            The boundary conditions shown are *insufficient* to restrain rigid
            body motion along the $x$-direction.
        ],

        image("./images/sufficient-boundary-conditions.png"),
        [
            The boundary conditions shown are *sufficient* to restrain all the 3
            rigid body motions of the body.
        ],
    )

#pagebreak()

*Accuracy also depends on mesh density*. *Coarse mesh* yields less accurate
results.
#cimage("./images/mesh-comparison.png")

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - In many cases, the mesh need not be refined uniformly everywhere.
        - Fine mesh may be necessary in _regions of stress concentration_ such
            as holes, grooves and re-entrant corners.
        - If regions of stress concentration are not known _a priori_ (before
            the finite element analysis), a course mesh can initially be used to
            identify such regions and then the mesh can be refined locally
            around these regions for subsequent analyses.
    ],
    image("./images/mesh-refinement.png"),
)

#pagebreak()

*Perform mesh convergence study* for reliable results.
#cimage("./images/mesh-convergence-study.png")

*Smooth stress contours* leads to accurate stress results.
- For reliable stress results, the stress contours must be smooth.
- Lack of smoothness implies the stress results are inaccurate or unreliable,
    which signals the need for a finer mesh.

#cimage("./images/stress-contours.png")

*Do not accept the finite element analysis results blindly*. Always check:
- If the results (displacement, stress, etc), are converged ones.
- If the results tally with common sense expectations.
- If the results tally with hand calculations using simple formulas where
    possible.

#pagebreak()

*Avoid severely distorted element shapes*.
- The *aspect ratio* of an element is defined as the ratio of the length of the
    longest side to that of the shortest side of the element.
- The aspect ratio of elements should be close to one (unity) for better element
    performance.
- This means, for the best element performance, all sides of the element should
    preferably be of the same size (e.g. an equilateral triangle, square,
    parallelogram).
- High aspect ratio elements produce inaccurate results.
- Finite element analysis software packages do have in-built *element shape
    quality checks*.
- Do pay attention to warning messages related to bad element shapes involving
    high aspect ratios. Re-mesh the geometry if necessary.

#cimage("./images/aspect-ratio-and-element-shapes.png", width: 70%)

*Exploit symmetry of geometry where possible*.
- Symmetry can be exploited to reduce the size of the finite element model and
    thereby the computation time. To exploit symmetry,
    - Geometry should be symmetric
    - Loads should be symmetric
    - Boundary conditions should be symmetric

#cimage("./images/exploit-symmetry-of-geometry.png")

#pagebreak()

= Computational fluid dynamics
- Computational fluid dynamics is a method of solving differential equations,
    particularly for fluids.
- It does so by a process called discretisation, which breaks up the domain into
    smaller segments, usually equally spaced except at the boundaries, and
    solves the equation at every segment using the basic gradient formula
    $(frac(y_2 - y_1, x_2 - x_1))$ instead of solving the differential equation.
- The equation at every segment will result in a system of linear equations,
    which can be easily solved by a computer, hence the "computational" in the
    name.

== Transport equation
$
    underbrace(frac(partial (rho phi.alt), partial t), "Temporal term")
    + underbrace(partial/(partial x) (rho phi.alt u), "Convection term")
    = underbrace(
        partial/(partial x) (Gamma partial/(partial x) phi.alt),
        "Conduction or diffusion term"
    )
    ) + underbrace(S, "Source term")
$

Where:
- $phi.alt$ is a function of space and time, i.e. $phi.alt(x, y, z, t)$, and can
    represent any physical quantity, like temperature, concentration, etc
- $rho$ represents density
- $u$ represents fluid velocity, which is positive when fluid flowing to the
    right, and negative when fluid is flowing to the left.
- $Gamma$ is a diffusivity constant
- The "temporal term" $(frac(partial (rho phi.alt), partial t))$ is a derivative
    of $phi$ with respect to *time*.
- The "convection term" $(frac(partial (rho phi.alt u ), partial t))$ is the
    *first* derivative of $phi$ with respect to *space*, $x$.
- The "conduction or diffusion term"
    $(partial/(partial x) (Gamma partial/(partial x) phi))$ is the *second*
    derivative of $phi$ with respect to *space*, $x$.
- The "source term" ($S$) represents the source of the physical quantity change,
    like a heat source.

// Function to generate the W-w-P-e-E line
#let west_east_line(
    labels,
    spacing: 5em,
    label_distance: true,
) = align(
    center,
    block(
        above: 2em,
        below: 2em,
        {
            //

            // Draw the line
            line(length: labels.slice(0, -1).map(_ => spacing).sum())

            // Enumerate over all the labels
            for (index, label) in labels.map(item => str(item)).enumerate() {
                //

                // Get if the label is the final label
                let is_last_label = index == labels.len() - 1

                // The x offset
                let x_offset = if is_last_label { 0.25em } else {
                    label.len() * 0.5em
                }

                // Get the position
                let position = index * spacing - (x_offset)

                // Place the tick mark and the label below
                place(
                    grid(
                        align: center,
                        row-gutter: 0.25em,
                        line(start: (0pt, 5pt), end: (0pt, -5pt)),
                        text(label),
                    ),
                    dx: position,
                )

                // If it's the last label, break out of the loop
                if is_last_label { break }

                // If labelling distance is wanted
                if label_distance {
                    //

                    // Place the distances above
                    place(
                        text($frac(delta x, 2)$),
                        dx: position + spacing / 2,
                        dy: -1.5em,
                    )
                }
            }
        },
    ),
)

#let internal_node_line = west_east_line.with(("W", "w", "P", "e", "E"))
#let start_boundary_line = west_east_line.with(("w", "P", "e", "E"))
#let end_boundary_line = west_east_line.with(("W", "w", "P", "e"))

== Internal nodes
Internal nodes are nodes that are *not at the boundaries* of the number line.
#west_east_line(range(1, 6), label_distance: false)
#place(
    center,
    ellipse(width: 1em, height: 3em, stroke: red),
    dx: -0.3em,
    dy: -3.1em,
)
#place(
    center,
    ellipse(width: 1em, height: 3em, stroke: red),
    dx: -5.3em,
    dy: -3.1em,
)
#place(
    center,
    ellipse(width: 1em, height: 3em, stroke: red),
    dx: 4.75em,
    dy: -3.1em,
)

== External nodes
External nodes are nodes that are at the *boundaries* of the number line.
#west_east_line(range(1, 6), label_distance: false)
#place(
    left,
    ellipse(width: 1em, height: 3em, stroke: red),
    dx: 9.8em,
    dy: -1.1em,
)
#place(
    center,
    ellipse(width: 1em, height: 3em, stroke: red),
    dx: 10em,
    dy: -1.1em,
)

#pagebreak()

== Finite difference method
The finite difference method takes the gradient by using the basic gradient
formula:
$ frac(dif phi.alt, dif x) = frac(phi.alt_2 - phi.alt_1, x_2 - x_1) $

== Central differencing scheme
<central-differencing-scheme>
#internal_node_line()
The central differencing scheme takes the point to the immediate right and
immediate left of the current point to evaluate the gradient.

=== At point P
$ frac(dif phi.alt, dif x) = frac(phi.alt_e - phi.alt_w, delta x) $

=== At point w
$ frac(dif phi.alt, dif x) = frac(phi.alt_P - phi.alt_W, delta x) $

=== At point e
$ frac(dif phi.alt, dif x) = frac(phi.alt_E - phi.alt_P, delta x) $

== Forward differencing scheme
#start_boundary_line()
- The forward differencing takes the point itself and the point to the immediate
    right of the current point to evaluate the gradient.
- This scheme is usually used for the start boundary.

=== At point w
$
    frac(dif phi.alt, dif x) = frac(phi.alt_P - phi.alt_w, frac(delta x, 2))
    = frac(2 phi.alt_P - 2 phi.alt_w, delta x)
$

== Backward differencing scheme
- The backward differencing takes the point itself and the point to the
    immediate left of the current point to evaluate the gradient.
- This scheme is usually used for the end boundary.
#end_boundary_line()

=== At point e
$
    frac(dif phi.alt, dif x) = frac(phi.alt_e - phi.alt_P, frac(delta x, 2))
    = frac(2 phi.alt_e - 2 phi.alt_P, delta x)
$

#pagebreak()

== Finite volume method
#internal_node_line()
The finite volume method integrates the equation over the control volume, and is
used when the equation has a second derivative with respect to space, or $x$.
For example:
$ dif/(dif x) (k frac(dif T, dif x)) + q = 0 $
$
    integral_w^e dif/(dif x) (k frac(dif T, dif x)) thin dif x
    + integral_w^e q thin dif x = integral_w^e 0 thin dif x
$
$ (k frac(dif T, dif x))_e - (k frac(dif T, dif x))_w + q_e - q_w = 0 $
$ (k frac(dif T, dif x))_e - (k frac(dif T, dif x))_w + delta x = 0 $

== Upwind scheme
The upwind scheme is used when there is high fluid velocity ($u$) to get the
values of $phi.alt_e$ and $phi.alt_w$. Essentially, the high fluid velocity
causes the fluid to be "blown" in the direction of the fluid velocity.

#let long_arrow(
    length,
    direction: right,
    colour: red,
    arrow_label: none,
) = block({
    grid(
        align: center,
        row-gutter: 0.3em,
        text(arrow_label, colour),
        line(length: length, stroke: colour),
    )
    let y_offset = 0em
    let x_offset = 0em
    if direction == right {
        place(
            line(
                start: (length, 0pt),
                end: (length - 0.5em, 0.25em),
                stroke: colour,
            ),
            dy: y_offset,
            dx: x_offset,
        )
        place(
            line(
                start: (length, 0pt),
                end: (length - 0.5em, -0.25em),
                stroke: colour,
            ),
            dy: y_offset,
            dx: x_offset,
        )
    } else if direction == left {
        place(
            line(
                start: (0pt, 0pt),
                end: (0.5em, 0.25em),
                stroke: colour,
            ),
            dy: y_offset,
            dx: x_offset,
        )
        place(
            line(
                start: (0pt, 0pt),
                end: (0.5em, -0.25em),
                stroke: colour,
            ),
            dy: y_offset,
            dx: x_offset,
        )
    }
})

=== Fluid flowing to the right
#align(center, grid(
    columns: 2,
    column-gutter: -3em,
    align: (right + top, horizon),
    long_arrow(3em, arrow_label: $u$), block(internal_node_line(), inset: 2em),
))

$ phi.alt_w = phi.alt_W $
$ phi.alt_e = phi.alt_P $

=== Fluid flowing to the left
#align(center, grid(
    columns: 2,
    column-gutter: -3em,
    align: (horizon, left + top),
    block(internal_node_line(), inset: 2em),
    long_arrow(3em, arrow_label: $u$, direction: left),
))

$ phi.alt_w = phi.alt_P $
$ phi.alt_e = phi.alt_E $

#pagebreak()

=== Peclet number
The Peclet number determines whether the #link(
    <central-differencing-scheme>,
)[central distancing scheme] is applicable in a problem with fluid velocity
($u$). It is given by:
$ "Pe" = frac(delta x rho u, mu) $

Where:
- $delta x$ is the distance between each segment
- $rho$ is the density of the fluid
- $u$ the fluid velocity
- $mu$ the dynamic viscosity of the fluid

It needs to be less than 2 for the #link(<central-differencing-scheme>)[central
    differencing scheme] to be applicable, i.e.
$ "Pe" < 2 $

== Transient response

=== Notation
$ "Future T:" T(Delta t) = T^((1)) $
$ "Past T:" T(0) = T^((0)) $

=== Implicit scheme (time)
The implicit scheme is a way of estimating an integral by using the *future*
value of the quantity ($f(Delta t)$) multiplied with the amount of time passed,
i.e.
$ integral_0^(Delta t) f(t) thin dif t = f(Delta t) Delta t $

=== Explicit scheme (time)
The explicit scheme is a way of estimating an integral by using the *previous*
or *past* value of the quantity ($f(0)$) multiplied with the amount of time
passed, i.e.
$ integral_0^(Delta t) f(t) thin dif t = f(0) Delta t $

==== Stability criterion
The criterion for stability is known as the Courant-Friedrichs-Lewy (CFL)
condition, which is shown below:
$ Delta t < frac((delta x)^2, 2 Gamma) $

This criterion makes the explicit scheme bad, as when there is a fine grid in
space (small $delta x$) the time step ($delta t$) becomes unnecessarily small,
resulting in a much longer computation time.

=== Estimation of space
The equation below estimates integral of a quantity ($f(x)$) with respect to
space.
$ integral_a^b f(x) thin dif x = f(frac(a + b, 2)) (b - a) $

#pagebreak()

== Iterative techniques
Using the example:
$ bmat(2, 1, 1; -1, 3, -1; 1, -1, 2) cvec(x_1, x_2, x_3) = cvec(7, 2, 5) $

In equation form:
$ 2x_1 + x_2 + x_3 = 7 $
$ -x_1 + 3x_2 - x_3 = 2 $
$ x_1 - x_2 + 2x_3 = 5 $

Always rearrange the first equation to place $x_1$ on the left-hand side, the
second equation to get $x_2$ on the left-hand side, and so on:
$ x_1 = (7 - x_2 - x^3)/2 $
$ x_2 = (2 + x_1 + x^3)/3 $
$ x_3 = (5 - x_1 + x^2)/2 $

#pagebreak()

=== Scarborough criterion (criterion for convergence)
- For every row in the matrix, look at the diagonal value in the matrix and take
    the absolute value. This term is denoted as $lr(|a_P|)$.
- Then, sum up the absolute values of the values beside that diagonal value.
    This term is denoted as $sum lr(|a_(n b)|)$.
- The Scarborough criterion is:
    $ frac(sum lr(|a_(n b)|), lr(|a_P|)) <= 1 "for every row" $

    And:
    $
        frac(sum lr(|a_(n b)|), lr(|a_P|)) < 1
        "for at least one row in the matrix"
    $

==== Example
$ bmat(2, 1, 1; -1, 3, -1; 1, -1, 2) cvec(x_1, x_2, x_3) = cvec(7, 2, 5) $

For row 1:
$
    lr(|a_P|) = 2, wide
    lr(sum |a_(n b)|) = |1| + |1| = 2, wide
    frac(sum lr(|a_(n b)|), lr(|a_P|)) = 2/2 = 1 <= 1
$

For row 2:
$
    lr(|a_P|) = 3, wide
    lr(sum |a_(n b)|) = |-1| + |-1| = 2, wide
    frac(sum lr(|a_(n b)|), lr(|a_P|)) = 2/3 < 1
$

For row 3:
$
    lr(|a_P|) = 2, wide
    lr(sum |a_(n b)|) = |1| + |-1| = 2, wide
    frac(sum lr(|a_(n b)|), lr(|a_P|)) = 2/2 = 1 <= 1
$

Hence, the Scarborough criterion is fulfilled.

#pagebreak()

=== General method (Jacobi method)
+ Guess values on the right-hand side, like setting everything to 0 for example.
+ New values can be calculated on the left-hand side.
+ Substitute the new values into the right-hand side and evaluate the left-hand
    side again.
+ Repeat the process until there is no more change in the solution.

=== Gauss-Seidel method
This method is similar to the Jacobi method, but instead of solving all the
simultaneous equations at the same time to get the value of each unknown, solve
each equation individually, then use the new value when solving the next
equation for the next unknown.

==== Example
#align(center, grid(
    columns: 2,
    column-gutter: 5em,
    $ x_1 = (7 - x_2 - x^3)/2 $,
    $ x_1^((1)) = (7 - x_2^((0)) - x_3^((0)))/2 = (7 - 0 - 0)/2 = 7/2 $,

    $ x_2 = (2 + x_1 + x^3)/3 $,
    $ x_2^((1)) = (2 + x_1^((1)) + x_3^((0)))/3 = (2 + 3.5 + 0)/3 = 11/6 $,

    $ x_3 = (5 - x_1 + x^2)/2 $,
    $ x_3^((1)) = (5 - x_1^((1)) + x_2^((1)))/2 = (5 - 3.5 + 1.8333)/2 = 5/3 $,
))

Where:
- $x^((0))$ denotes the start value, or iteration 0
- $x^((1))$ denotes iteration 1
- $x^((n))$ denotes iteration $n$
