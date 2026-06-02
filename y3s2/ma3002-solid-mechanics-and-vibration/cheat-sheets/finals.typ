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

// Imports
#import "@preview/fancy-units:0.1.1": qty, unit

// Centred image
#let cimage(..image_args) = align(center, image(..image_args))

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

// Set the grid properties
#set grid(column-gutter: 2em, row-gutter: 0.5em, align: center + horizon)

= Virtual displacements and work
- Forces that are *opposite* in direction to its displacement result in
    *negative work*.
- Internal forces come in action-reaction pairs and hence are equal in magnitude
    but opposite in direction.

== Virtual displacements
$delta W = 0 quad => quad
P_1 delta x_1 + P_2 delta x_2 + dots.c + P_n delta x_n = 0$

== Virtual work
$ delta W = delta U $

$
    P_1 delta x_1 + P_2 delta x_2 + dots.c + P_n delta x_n
    = F_1 delta e_1 + F_2 delta e_2 + dots.c + F_m delta e_m
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
    Delta_1 delta F_1 + Delta_2 delta F_2 + dots.c + Delta_n delta F_n
    = e_1 delta F_1 + e_2 delta F_2 + dots.c + e_m delta F_m
$

== Steps
+ Write $delta W^* = delta U^*$
+ Drop unwanted deflection terms ($Delta_n$), and leave only the desired
    deflection term from the question
+ Replace $e_m$ with $frac(F_m, k_m)$
+ Find the spring forces $F_1, F_2, dots, F_m$ using moments or force balance
+ Find the virtual forces $delta F_1, delta F_2, dots, delta F_m$ using virtual
    force or moment balance
    - Apply a virtual force $delta P$ at the desired deflection point *only*
    - There are no external virtual forces anywhere else
    - Find $delta F_1, delta F_2, dots, delta F_m$ in terms of $delta P$
+ Substitute the results from steps 4 and 5 into the step 3 equation, and solve
    for the desired deflection

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
+ Find internal moments of each segment $M_1, M_2, dots, M_n$
    - Take a cut at the segment
    - Wherever the cut is made, draw the internal moment, like $M_1$
    - Take $sum M = 0$ about the cutting point to find $M_1$
+ Perform virtual load (for linear displacement) or moment (for angular
    displacement) analysis
    - Remove all forces
    - For statically indeterminate structures, replace the unknown force or
        moment with a unit load or moment.
    - Apply unit load (#qty[1][N]) or moment (#qty[1][Nm]) at the point of
        interest (deflection point)
    - Find unknown reaction forces
    - Find internal virtual moment in each segment $m_1, m_2, dots, m_n$
    - The internal virtual moments must be in the *same direction* as the actual
        internal moments.
+ Substitute $M_1, M_2, dots, M_n,$ and $m_1, m_2, dots, m_n$ into $Delta$ and
    evaluate the integral

For statically indeterminate structures, find a point that has *zero* deflection
in one direction, like a slot, then apply the unit load method with the unit
load in the same direction to find the unknown internal force. Then proceed with
solving the question using the found force.

== Useful equations
$s = r theta wide dif s = r dif theta$

= Impact loads

== Gradual release
#grid(
    columns: 2,
    $ Delta_s = frac(m g, k) $,
    image(
        "../images/maximum-deflection-for-impact-loads-gradual.png",
    ),
)

== Instant release
#grid(
    columns: 2,
    $Delta_"dyn" = 2 Delta_s = frac(2 m g, k)$,
    image("../images/maximum-deflection-for-impact-loads-instant.png"),
)

== Dropped from height
#grid(
    columns: 2,
    $Delta_"dyn" = Delta_s (1 + sqrt(1 + frac(2h, Delta_s)))$,
    image(
        "../images/maximum-deflection-for-impact-loads-dropped-from-height.png",
    ),
)

== Types of supports and their reaction forces
#cimage("../images/support-reaction-forces.png")

= Brittle fracture

== Strain energy release rate
$G = frac(pi sigma^2 a, E)k$

- $a$ is *half* the crack length
- $k = 1$ for a thin plate (plane stress)
- $k = (1 - nu^2)$ for a thick block (plane strain)

== Stress intensity factor
$K_I = Y sigma sqrt(pi a)$

$sigma_"tip" = frac(K_I, sqrt(2 pi r))$

- $Y$ is the geometric correction factor, which is usually 1.

=== Geometric correction factor
Finite width plate: $Y = (frac(W, pi a) tan frac(pi a, W))^(1/2)$

Double-edge crack:
$Y = (frac(W, pi a) tan frac(pi a, W)
    + frac(0.2W, pi a) sin frac(pi a, W))^(1/2)$

Internal penny crack: $Y = 2/pi$

== Variation of fracture toughness
#[
    #set image(height: 8em)

    === Bending
    #grid(
        columns: 2,
        $K_Q = frac(F_Q, B W^(1/2)) f_1 (a/W)$,
        image(
            "../images/fracture-toughness-experimental-procedure-bending.png",
        ),
    )

    === Compact tension
    #grid(
        columns: 2,
        $K_Q = frac(F_Q, B W^(1/2)) f_2 (a/W)$,
        image(
            "../images/fracture-toughness-experimental-procedure-tension.png",
        ),
    )
]

=== Valid test criterion
$frac(F_"max", F_Q) < 1.1$

=== Valid $K_(I C)$ criteria
$B, a, (W - a) >= 2.5 (frac(K_Q, sigma_y))^2$

$0.45 < a/W < 0.55$

= Crack tip plasticity

== Plastic zone correction
$K = sigma sqrt(pi (a + r_p))$

#grid(
    columns: 2,
    grid.header([*Plane stress*], [*Plane strain*]),
    $r_p = frac(1, 2pi) (K/sigma_y)^2$, $r_p = frac(1, 6pi) (K/sigma_y)^2$,
)

== Crack tip opening displacement (COD) method
#grid(
    columns: 2,
    column-gutter: 0em,
    align: left + horizon,

    [
        Bending: $K_c = frac(F_c, B sqrt(W)) f_1 (a/W)$

        Crack tip opening displacement:

        $delta_c = frac(K_c^2 (1 - nu^2), 2 sigma_y E)
        + frac(0.4(W - a) V_p, 0.4W + 0.6a + z)$

        Plane stress: $delta_c = frac(K_(I C)^2, lambda sigma_y E)$

        Plane strain: $delta_c = frac(K_(I C)^2 (1 - nu^2), lambda sigma_y E)$
    ],
    image("../images/crack-tip-opening-displacement-bending.png", height: 8em),
)

== J-integral
$J = integral_C {w thin dif y - bold(t) (frac(partial bold(u), partial x))}
thin dif s$, $w = integral_0^epsilon sigma thin dif epsilon$

- $w$ is the strain energy density, $bold(u)$ is the displacement vector
- $bold(T)$ is the traction vector, $bold(T) = bold(s) dot bold(n)$

For linear elastic materials: $J_c = G_c$, $therefore K_c = sqrt(E J_c)$

$J = - 1/B frac(partial U, partial a) = frac(2 U, B (W - a))$
- $U$ is the strain energy, $a$ is *half* the crack length
- $B$ is the specimen thickness, $W$ is the specimen width

Plane stress: $K_c = sqrt(E G_C)$

= Cyclic stresses
Stress amplitude: $S_a = sigma_a = 1/2 (sigma_"max" - sigma_"min")$

Mean stress: $S_m = sigma_m = 1/2 (sigma_"max" + sigma_"min")$

Stress ratio: $R = sigma_"min"/sigma_"max"$

#grid(
    columns: 2,
    align: left + horizon,

    [
        Stress range:

        $ S_r = sigma_r = sigma_"max" - sigma_"min" $

        For the completely reversed stress cycle, only the tensile part
        contributes to crack growth, so the stress range *for crack growth* is
        only the tensile part of the cycle, i.e.

        $ S_r = sigma_r = sigma_"max" - 0 = sigma_"max" $
    ],
    image("../images/completely-reversed-stress-cycle.png", height: 9em),
)


$S_e$ is the endurance limit, $S_u$ is the ultimate tensile strength.

$S_e = 0.5 S_u$ for steels with $S_u < #qty[690][MPa]$

$S_e = 0.4 S_u$ for aluminium alloys with $S_u < #qty[131][MPa]$

$S_e = 0.4 S_u$ for copper alloys with $S_u < #qty[96.5][MPa]$

Safety factor against fatigue failure =
$frac("Endurance limit," S_u, "Stress amplitude," S_a)$

$"SF" = S_e/S_a, quad sigma = frac(M y, I),
quad I = frac(pi D^4, 64), quad y = D/2$

$S_e = S'_e C_"size" C_"load" C_"surface-finish"$

- $S_e$ is the modified endurance limit
- $S'_e$ is the test specimen endurance limit.

For circular rods:

$C_"size" = cases(
    1.0 quad "if" d <= #qty[8][mm] "for bending",
    1.189 d^(-0.097) quad "if" #qty[8][mm] <= d <= #qty[250][mm]
    "for torsional load",
    1.0 quad "for axial load",
)$

$C_"load" = cases(
    1.0 "for bending loads in the component",
    0.7 "for axial loads in the component",
    0.577 "for torsional loads in the component",
)$

$S_e = frac(S'_e C_"size" C_"load" C_"surface-finish", K_f)$
- $K_f$ is the fatigue strength reduction factor

$q = frac(K_f - 1, K_t) quad => quad K_f = q (K_t - 1) + 1$
- $q$ is the notch sensitivity factor, $0 <= q <= 1$
- $K_t$ is the theoretical elastic stress concentration factor

== Stress criteria
The below criteria are for *NO* fatigue failure.
#grid(
    columns: 3,

    [*Goodman*],
    $S_a/S_e + S_m/S_u <= 1$,
    $frac(S_a times "SF", S_e) + S_m/S_u <= 1$,

    [*Gerber*],
    $S_a/S_e + (S_m/S_u)^2 <= 1$,
    $frac(S_a times "SF", S_e) + (S_m/S_u)^2 <= 1$,

    [*Soderberg*],
    $S_a/S_e + S_m/S_y <= 1$,
    $frac(S_a times "SF", S_e) + S_m/S_m <= 1$,
)

If mean stress is 0:
$"SF" = frac(S_e, S_a) -> frac(S_a times "SF", S_e) = 1$

If the mean stress is non-zero, look at the right side of the equation.

== Miner's rule for cumulative fatigue damage
$D = n_1/N_1 + n_2/N_2 + ... + n_k/N_k = 1, wide N = 1/D$
- $D$ is the damage, so if $D >= 1$, the material will fail
- $n_k$ number of cycles of operation at stress level $S_k$
- $N_k$ number of cycles to failure at stress level $S_k$

== Crack growth
Fatigue crack growth rate: $frac(dif a, dif N)$

Stress intensity factor range ($Delta K$):

$Delta K = K_"max" - K_"min" = Y S_r sqrt(pi a) = Y^m S_r^m pi^(m/2) a^(m/2)$

$S_r = sigma_"max" - sigma_"min"$

Paris law: $frac(dif a, dif N) = C (Delta K)^m = C(Y^m S_r^m pi^(m/2) a^(m/2))$

$N_f = frac(2, C(Y S_r)^m pi^(m/2) (2-m)) (a_f^(1 -m/2) - a_0^(1 - m/2))$

$N_f$ is the number of fatigue cycles, *all stresses in #unit[MPa]* for $N_f$

$m$ is a coefficient, and $a$ is half the crack length

Stress ratio: $R = K_"min"/K_"max" = S_"min"/S_"max"$

Forman equation:
$frac(dif a, dif N) = frac(C (Delta K)^m, (1 - R) K_c - Delta K)$

Walker equation: $frac(dif a, dif N) = C (frac(Delta K, (1 - R)^(1 - gamma)))^m$

= Impact testing
Impact strength (energy absorbed): $E = m g H_"before" - m g H_"after"$

= Stiffness formulas

== General
$k = F/Delta$

- $F$ is the force
- $Delta$ is the deflection

== Torsional stiffness
#grid(
    columns: 2,
    $ k = frac(E I, l) $,
    image("../images/stiffness-formula-not-provided-1.png", height: 3em),
)

- $E$ is the modulus of elasticity, and $l$ is the total length
- $I$ is the moment of inertia of the cross-sectional area

== Axial force on a bar
#grid(
    columns: 2,
    $ k = frac(E A, l) $,
    image("../images/stiffness-formula-not-provided-2.png", height: 2em),
)

- $A$ is the cross-sectional area

== Torque on a bar
#grid(
    columns: 2,
    $ k = frac(G J, l) $,
    image("../images/stiffness-formula-not-provided-3.png", height: 3em),
)

- $G$ is the shear modulus or modulus of rigidity
- $J$ is the moment of inertia

== Force on the end of cantilever beam
#grid(
    columns: 2,
    $ k = frac(3 E I, l^3) $,
    image("../images/stiffness-formula-not-provided-4.png", height: 3em),
)

Note that $k$ is at the position of the load.

== Force in the middle of a bar
#grid(
    columns: 2,
    $ k = frac(48 E I, l^3) $,
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
    $J_o = m r^2$,
    image("../images/mass-moment-of-inertia-not-provided-1.png", height: 4em),
)

== Bar
#grid(
    columns: 2,
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
        $J = J_G + M d^2$

        - $J$ is the moment of inertia needed
        - $J_G$ is the moment of inertia about its own centre of gravity
        - $M$ is the mass of the body
        - $d$ is the distance between the axes
    ],
    image("../images/parallel-axis-theorem.png"),
)

= Vibrations
Angular motion: $theta = Theta sin (omega t - phi.alt)$

Rectilinear motion: $x = X sin (omega t - phi.alt)$

Frequency: $f = 1/tau space (#unit[Hz])$

Angular frequency: $omega = 2 pi f space (#unit[rad s^-1])$

== Simple pendulum
Equation of motion: $J_o dot.double(theta) = sum M_o$

Natural frequency:

$omega_n &= sqrt(k/m) space (#unit[rad s^-1]),
quad f_n &= frac(omega_n, 2 pi) space (#unit[Hz])$

Natural period: $tau_n = frac(1, f_n)$

$theta = Theta sin (omega_n t + phi.alt)$

== Spring mass system
#cimage("../images/base-excitation-spring-mass-system.png")

Equation of motion: $m dot.double(theta) = sum F$

Natural frequency:

$omega_n &= sqrt(k/m) space (#unit[rad s^-1]),
quad f_n &= frac(omega_n, 2 pi) space (#unit[Hz])$

Natural period: $tau_n = frac(1, f_n)$

$x = X sin (omega_n t + phi.alt)$

=== Harmonic force excitation
$F(t) = F_0 sin omega t$

Newton's second law: $m dot.double(x) = sum F$

Equation of motion: $m dot.double(x) + k x = F_0 sin omega t$

Steady state response:

$x = X sin (omega t - phi.alt) wide
dot.double(x) = - omega^2 X sin (omega t - phi.alt)$

Phase: $phi.alt = 0$

Amplitude: $X = frac(F_0, k - m omega^2) = frac(F_0/k, 1 - (omega/omega_n)^2)$

=== Rotating unbalance
Newton's second law: $M dot.double(x) = sum F$
- $M$ is the total mass inclusive of $m$.

Equation of motion:
$M dot.double(x) + k x = m e omega^2 sin omega t$

Steady state solution: $x_p = X sin (omega t - phi.alt)$

Amplitude: $X = frac(m e omega^2, k - M omega^2)$

Magnification factor:
$frac(M X, m e) = frac((omega/omega_n)^2, 1 - (omega/omega_n)^2)$

Phase: $phi.alt = 0$

== Spring mass damper system
#cimage("../images/base-excitation-spring-mass-damper-system.png")

Equation of motion: $m dot.double(x) + c dot(x) + k x = 0$

Critical damping constant:
$c_c = 2 sqrt(2 k m) = 2 m omega_n = frac(2 k, omega_n)$

=== Harmonic force excitation
$F(t) = F_0 sin omega t$

Newton's second law: $m dot.double(x) = sum F$

Equation of motion: $m dot.double(x) + c dot(x) + k x = F_0 sin omega t$

Steady state response:

$x = X sin (omega t - phi.alt) wide
dot.double(x) = - omega^2 X sin (omega t - phi.alt)$

Amplitude: $X = frac(F_0, sqrt((k - m omega^2)^2 + (c omega)^2))$

Magnification factor:
$frac(k X, F_0) = 1/sqrt(
    (1 - omega^2/omega_n^2)^2 + (frac(2 zeta omega, omega_n))^2
)$

Phase:
$phi.alt = arctan frac(c omega, k - m omega^2)
= arctan frac(frac(2 zeta omega, omega_n), 1 - omega^2/omega_n^2)$

At resonance, $omega = omega_n$, amplitude: $X_"res" = frac(F_0, 2 k zeta)$

=== Rotating unbalance
Newton's second law: $M dot.double(x) = sum F$
- $M$ is the total mass inclusive of $m$.

Equation of motion:
$M dot.double(x) + k x = m e omega^2 sin omega t$

Steady state solution: $x_p = X sin (omega t - phi.alt)$

Amplitude: $X = frac(m e omega^2, sqrt((k - M omega^2)^2 + (c omega)^2))$

$phi.alt = arctan frac(c omega, k - m omega^2)
= arctan frac(frac(2 zeta omega, omega_n), 1 - omega^2/omega_n^2)$

Magnification factor:
$frac(M X, m e) = frac(
    (omega/omega_n)^2,
    sqrt((1 - omega^2/omega_n^2)^2 + (frac(2 zeta omega, omega_n))^2)
)$

== Shaft-disc system
Equation of motion: $J_o dot.double(theta) = sum M_o$

Natural frequency:

$omega_n &= sqrt(k/m) space (#unit[rad s^-1]),
quad f_n &= frac(omega_n, 2 pi) space (#unit[Hz])$

Torsional stiffness of the shaft:

$k_o = frac(G J, L) space (#unit[Nm rad^-1])$
- $L$ is the length of the shaft
- $J$ is the polar moment of inertia, $J = frac(pi d^4, 32)$

Natural period: $tau_n = frac(1, f_n)$

Steady-state response: $theta = Theta sin (omega_n t - phi.alt)$

#colbreak()

== Viscous damping
$F_d = c dot(x) wide c = frac(mu A, h)$
- $F_d$ is the viscous force on the mass (#unit[N])
- $mu$ is the dynamic viscosity (#unit[Pa s])
- $A$ is the contact area (#unit[m^2])
- $h$ is the film thickness (#unit[m])

#{
    set image(height: 8em)

    grid(
        columns: 2,
        [
            *Parallel-plate (shear) damper*

            $ c = frac(mu A, h) $

            $ F_d = c dot(x) $
        ],
        image("../images/parallel-plate-damper.png", height: 5em),

        [
            *Axial damper (dashpot)*

            $ c = frac(3 pi mu D^3 L, 4 d^3) (1 + frac(2 d, D)) $

            $ F_d = c dot(x) $
        ],
        image("../images/axial-damper.png"),

        [
            *Torsion damper*

            $ c_theta = frac(pi mu D^3 (L - h), 4d) + frac(pi mu D^4, 32 h) $

            $ T_d = c_theta dot(theta) $
        ],
        image("../images/torsion-damper.png"),
    )
}

== Equations of motion
$m dot.double(x) + c dot(x) + k x = 0$ \
$J_o dot.double(theta) + c_theta dot(theta) + k_theta theta = 0$

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
#grid(
    columns: 2,
    align: left + horizon,

    [
        $ delta = ln x_1/x_2 = frac(2 pi zeta, sqrt(1 - zeta^2)) $

        - $x_1$ is the amplitude of the first cycle
        - $x_2$ is the amplitude of the second cycle
    ],
    image("../images/under-damped-system-log-measurement.png", height: 8em),
)

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
$x = A cos omega_n t + B sin omega_n t + X sin (omega t - phi.alt)$ \
$x = X_h sin (omega_n t + phi.alt_h) + X_p sin (omega t - phi.alt_p)$

=== Steady-state solution
$x_p = X sin (omega t - phi.alt)$

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

=== Over-damped
Damping ratio: $zeta > 1$

$x = C_1 e^(r_1 t) + C_2 e^(r_2 t)$ \
$dot(x) = C_1 r_1 e^(r_1 t) + C_2 r_2 e^(r_2 t)$ \
$dot.double(x) = C_1 r_1^2 e^(r_1 t) + C_2 r_2^2 e^(r_2 t)$ \
$r_1 = - zeta omega_n + omega_n sqrt(zeta^2 - 1)$ \
$r_2 = - zeta omega_n - omega_n sqrt(zeta^2 - 1)$

=== Phase
$phi.alt = arctan (frac(c omega, k - m omega^2))
= arctan (frac(frac(2 zeta omega, omega_n), 1 - omega^2/omega_n^2))$

== Damped forced vibrations

=== Equation of motion
$m dot.double(x) + c dot(x) + k x = F_0 sin omega t$

Unbalanced mass: $M dot.double(x) + c dot(x) + k x = m e omega^2 sin omega t$

- $M$ is the effective mass, adding all the masses together
- $m$ is the unbalanced mass
- $e$ is the eccentricity

=== Displacement
$x = e^(- zeta omega_n) (A cos omega_d t + B sin omega_d t)
+ X sin (omega t - phi.alt)$

$omega_d = omega_n sqrt(1 - zeta^2)$

=== Steady-state solution
$x_p = X sin (omega t - phi.alt)$

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

== Force transmission ratio
Without damping:

$"TR" = lr(|F_T/F_0|) = lr(|frac(k X, F_0)|)
= frac(k, lr(|k - m omega^2|))
= frac(1, lr(|1 - (omega/omega_n)^2|))$

With damping:

$"TR" = F_T/F_0 = frac(X sqrt(k^2 + (c omega)^2), F_0)
&= frac(sqrt(k^2 + (c omega)^2), sqrt((k - m omega^2)^2 + (c omega)^2)) \
&= frac(
    sqrt(1 + (frac(2 zeta omega, omega_n))^2),
    sqrt((1 - omega^2/omega_n^2)^2 + (frac(2 zeta omega, omega_n))^2)
)$

For torsional vibrations, replace $F_T$ and $F_0$ in the above equations with
$M_T$ and $M_0$ respectively.

== Transient vibrations

=== Due to initial conditions
Without damping:

$m dot.double(x) + k x = F_0 sin omega t$

$x = x_h (t) + x_p (t)
= A cos omega_n t + B sin omega_n t + X sin (omega t - phi.alt)$

With damping:

$m dot.double(x) + c dot(x) + k x = F_0 sin omega t$

$x &= x_h (t) + x_p (t) \
&= e^(- zeta omega_n t) (A cos omega_d t + B sin omega_d t)
+ X sin (omega t - phi.alt)$

$omega_d = omega_n sqrt(1 - zeta^2)$

=== Spring mass system under step loading
$x = F_0/k (1 - cos omega_n t)$

=== Spring mass system with sudden load
$x = frac(m g, k) (1 - cos omega_n t)$

=== Drop test without damping
$x(t) = sqrt((frac(m g, k))^2 + (frac(v_0, omega_n))^2)
sin (omega_n t + phi.alt) + frac(m g, k)$

$phi.alt = arctan(-frac(m g omega_n, k v_0))$

$dot(x) (t) = omega_n sqrt((frac(m g, k))^2 + (frac(v_0, omega_n))^2)
cos (omega_n t + phi.alt)$

$dot.double(x) (t) = - omega_n^2 sqrt((frac(m g, k))^2 + (frac(v_0, omega_n))^2)
sin (omega_n t + phi.alt)$

$Delta_"st" = g/omega_n^2 = frac(m g, k)$

$frac(- dot.double(x)_"max", g) = sqrt(1 + frac(2 h, Delta_"st"))$

=== Drop test with damping
#grid(
    columns: 2,
    align: left,

    $zeta > 1$, $x(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t) + frac(m g, k)$,
    $zeta = 1$, $x(t) = (C_1 + C_2 t) e^(- omega_n t) + frac(m g, k)$,

    $zeta < 1$,
    $x(t) &= e^(- zeta omega_n t) (A cos omega_d t + B sin omega_d t)
    + frac(m g, k) \
    &= X e^(- zeta omega_n t) sin (omega_d t + phi.alt) + frac(m g, k)$,
)

Initial conditions: $x(0) = 0$ and $dot(x) (0) = v_0 = sqrt(2 g h)$

== Cramer's rule
For the equation of motion:
$ bmat(2 k - m omega^2, -k; -k, 2 k - m omega^2) cvec(X_1, X_2) = cvec(F_1, 0) $

For $X_1$, replace the *first column* of the matrix in the numerator with the
force vector:
$
    X_1 = frac(
        lr(mat(F_1, -k; 0, 2 k - m omega^2; delim: "|")),
        lr(mat(2 k - m omega^2, -k; -k, 2 k - m omega^2; delim: "|"))
    )
    = frac(F_1 (2 k - omega^2 m), (2 k - omega^2 m)^2 - k^2)
$

For $X_2$, replace the *second column* of the matrix in the numerator with the
force vector:
$
    X_2 = frac(
        lr(mat(2 k - m omega^2, F_1; -k, 0; delim: "|")),
        lr(mat(2 k - m omega^2, -k; -k, 2 k - m omega^2; delim: "|"))
    )
    = frac(F_1 k, (2 k - omega^2 m)^2 - k^2)
$

== General steps
+ Find the equation of motion using Newton's 2nd law for all the masses involved
    with the $x$ or $theta$ terms on the left-hand side:
    $ "Forces:" m dot.double(x) = sum F $
    $ "Moments:" J_o dot.double(theta) = sum M_o $
+ Assume the steady state solution is one of the following:
    $
        "Forces:" x(t) = X sin (omega t - phi.alt),
        wide dot.double(x) = - omega^2 x
    $
    $
        "Moments:" theta(t) = Theta sin (omega t - phi.alt),
        wide dot.double(x) = - omega^2 theta
    $

=== Natural frequency of 2-DOF systems
+ Always assume that the displacement of the current is greater than the
    displacement of the other mass, i.e. if the current mass' displacement is
    $x_1$, assume $x_1 > x_2$.
+ Set the determinant of the matrix of the equation of motions to 0 to find the
    characteristic equation.
+ Solve for the roots of the characteristic equation to get the natural
    frequencies.

=== Mode shapes of 2-DOF systems
+ Use any of the equations of motion and make the amplitude ratio
    $(X_2/X_1 "or" X_1/X_2)$ the subject.
+ Substitute the natural frequency into the amplitude ratio equation.
+ Set either $X_1$ or $X_2$ as 1, then calculate the other value to form the
    mode shape vector.

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

== Solutions to $sin theta = c$
$alpha = arcsin c$

$theta = cases(2k pi + alpha, (2k + 1) pi - alpha)
quad "where" k = 0, 1, 2, 3, dots$

$theta = alpha, pi - alpha, 2pi + alpha, 3pi - alpha, dots$

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
