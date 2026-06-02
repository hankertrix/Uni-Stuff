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

= Virtual displacements and work

== Virtual displacements
$delta W = 0 quad => quad
P_1 delta x_1 + P_2 delta x_2 + ... + P_n delta x_n = 0$

== Virtual work
$ delta W = delta U $

$
    P_1 delta x_1 + P_2 delta x_2 + ... + P_n delta x_n
    = F_1 delta e_1 + F_2 delta e_2 + ... + F_m delta e_m
$

== Steps
+ Set up a coordinate system with the origin at a *fixed point*
+ Assign displacement coordinates to each force
+ Write out $delta W = 0$ (virtual displacements) or $delta W = delta U$
    (virtual work)
+ Express all coordinate systems to a common variable (usually given) using
    $delta y = frac(dif y, dif x) delta x$
+ Drop the common infinitesimal variable ($delta x$)
+ Solve for the applied force

= Virtual complementary work
$ delta W^* = delta U^* $

$
    Delta_1 delta F_1 + Delta_2 delta F_2 + ... + Delta_n delta F_n
    = e_1 delta F_1 + e_2 delta F_2 + ... + e_m delta F_m
$

== Steps
+ Write $delta W^* = delta U^*$
+ Drop unwanted deflection terms ($Delta_n$), and leave only the desired
    deflection term from the question
+ Replace $e_m$ with $frac(F_m, k_m)$
+ Find the spring forces $F_1, F_2, ..., F_m$ using moments or force balance

= Unit load method
$Delta = delta U^*$

== Equilibrium equations
$ sum F_x = 0, quad sum F_y = 0, quad sum M = 0 $

== Degree of indeterminacy
$ n = N_"unknowns" - 3 $

== Steps
+ Write:
    $ Delta = delta U^* $
    $
        Delta = sum^n integral_0^L_1 frac(M_i m_i, E I_i) thin dif x
        + sum^n frac(F_i f_i, k_i)
    $
    - How to decide where does a segment end?
        - Force changes
        - Beam changes (E, I or cross-section)
+ Solve for unknown reaction forces
+ Find internal moments of each segment $M_1, M_2, ..., M_n$
    - Take a cut at the segment
    - Wherever the cut is made, draw the internal moment, like $M_1$
    - Take $sum M = 0$ about the cut to find $M_1$
+ Perform virtual load (for linear displacement) or moment (for angular
    displacement) analysis
    - Remove all forces
    - For statically indeterminate structures, replace the unknown force or
        moment with a unit load or moment.
    - Apply unit load (1 N) or moment (1 Nm) at the point of interest
    - Find unknown reaction forces
    - Find internal virtual moment in each segment $m_1, m_2, ..., m_n$
+ Sub $M_1, M_2, ..., M_n, m_1, m_2, ..., m_n$ into $Delta$ and evaluate the
    integral

= Impact loads

== Gradual release
$Delta_s = frac(m g, k)$

== Instant release
$Delta_"dyn" = frac(2 m g, k)$

== Dropped from height
$Delta_"dyn" = Delta_s (1 + sqrt(1 + frac(2h, Delta_s)))$

= Brittle fracture

== Strain energy release rate
$G = frac(pi sigma^2 a, E)k$

- $a$ is *half* the crack length
- $k = 1$ for a thin plate (plane stress)
- $k = (1 - nu^2)$ for a thick block (plane strain)

== Stress intensity factor
$K_I = Y sigma sqrt(pi a)$

== Variation of fracture toughness

=== Bending
$K_Q = frac(F_Q, B W^(1/2)) f_1 (a/W)$

=== Compact tension
$K_Q = frac(F_Q, B W^(1/2)) f_2 (a/W)$

=== Valid test criterion
$frac(F_"max", F_Q) < 1.1$

=== Valid $K_(I C)$ criteria
$B, a, (W - a) >= 2.5 (frac(K_Q, sigma_Y))^2$

$0.45 < a/W < 0.55$

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
