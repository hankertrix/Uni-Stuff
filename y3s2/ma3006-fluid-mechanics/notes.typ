#set page(numbering: "1")
#set heading(numbering: "1.1")
#show link: text.with(blue)
#{
    set document(
        title: "MA3006 Fluid Mechanics Notes",
        author: "Hankertrix",
    )
    align(center, text(3em)[*#context document.title*])
    align(center, text(2em)[#context document.author.first()])
    outline()
    pagebreak()
}

// Imports
#import "@preview/fancy-units:0.1.1": qty, unit

// Function definitions
#let cimage(..image_args) = align(center, image(..image_args))
#let redcancel = math.cancel.with(stroke: red)

= Definitions

== Control volume (C.V.)
- A control volume is a volume in space through which fluid may or may not flow.
- A control volume is similar to the *free-body diagram* in dynamics.

#figure(image("./images/control-volume.png")) <control-volume>

- A control surface (C.S.) is a surface of a control volume.
- Sections (1) and (2) in (a) are control surfaces *with* flow passing through.
    The pipe wall is a control surface *without* flow passing through.
- Case (a) is a *fixed* control volume, but case (b) is a *deforming* control
    volume.
- In the control volume, the observers are usually stationary and observe the
    fluid's behaviour.
- Governing equations of fluid motion are stated in terms of fluid systems, not
    control volumes.

== Control surface (C.S.)
A control surface is a surface of a control volume.

== Ideal flow
Ideal flow is *frictionless* and *steady*.

== Dimensionless
A dimensionless quantity is a quantity that has no units.

== Pump types
#cimage("./images/pump-types.png")
#pagebreak()

=== Axial flow pump
- An axial flow pump accelerates water in a direction *parallel* to the shaft of
    the pump.
- It is mainly used when a *large volume flow rate* is needed, and the pressure
    of the output flow is not vital.

#cimage("./images/axial-flow-pump.png", height: 13em)

=== Centrifugal or radial flow pump
- A centrifugal or radial flow pump accelerates water in a direction
    *perpendicular* to the shaft of the pump.
- It is mainly used when *a large pressure rise* is needed.

#cimage("./images/centrifugal-pump.png", height: 15em)

=== Mixed-flow pump
A mixed-flow pump is a pump that is a mix of the axial flow pump and the
centrifugal pump.

== Prototype
A prototype is an *actual* physical object.

== Model
- A model is a *scaled* physical object designed and tested in laboratory
    conditions to predict the behaviour of a prototype.
- Modelling is used to achieve *similarity*.
    + Similarity between the model and the prototype.
    + Similarity between the test conditions and the operating conditions.

#pagebreak()

== Kinematic viscosity ($nu$)
Kinematic viscosity is defined as:
$ nu = frac(mu, rho) $

Where:
- $nu$ is the kinematic viscosity
- $mu$ is the dynamic viscosity
- $rho$ is the density

== Specific gravity ($S$)
Specific gravity is the ratio of a fluid's density with respect to water, which
is #qty[1000][kg m^-3], i.e.
$ S = frac(rho_"fluid", rho_"water") = frac(rho_"fluid", 1000) $
$ rho_"fluid" = S rho_"water" = 1000S $

== Cavitation
Cavitation refers to the formation of vapour cavities, which happens when the
*local pressure* drops below the *vapour pressure* of the liquid.

#pagebreak()

= Equations

== Bernoulli's equation
$ p + 1/2 rho V^2 + rho g z = "constant" $

Along a stream-line:
$ p/(rho g) + frac(V^2, 2g) + z = "constant" $

Where:
- $p$ is the pressure
- $rho$ is the density
- $g$ is the acceleration due to gravity
- $V$ is the velocity
- $z$ is the elevation

== Continuity equation
Mass flow rate is conserved, or the time rate of change of system mass
($M_"sys"$) is 0.

$
    D/D t M_"sys" = 0, quad "where" quad M_"sys" =
    integral_"sys" rho thin dif V
$

In terms of control volume and control surfaces:
$
    frac(partial, partial t) integral_"C.V." rho dif V
    + integral_"C.S." rho (arrow(v) dot hat(n)) thin dif A = 0
$

If the flow is steady then:
$
    frac(partial, partial t) integral_"C.V." rho thin d V = 0
    quad "and" quad integral_"C.S." rho (arrow(V) dot hat(n)) thin dif A = 0
$

Where:
- $dif A$ is the differential area $A$ on the control surface.
- $hat(n)$ is an outward normal vector.
- $arrow(V) dot hat(n)$ is the component of the velocity that is perpendicular
    to the control volume.

== Linear momentum equation
$ sum arrow(F) = sum (dot(m) arrow(V))_"out" - sum (dot(m) arrow(V))_"in" $
Where $dot(m) = rho (arrow(V) dot hat(n)) A$ is the mass flow rate through $A$.

For a "moving" control volume in steady flow:

- Continuity equation:
    $ 0 = integral_"C.S." rho (arrow(W) dot hat(n)) thin dif A $
- Linear momentum equation:
    $
        sum arrow(F) =
        integral_"C.S." arrow(W) rho (arrow(W) dot hat(n)) thin dif A
        quad "where" quad arrow(W) = arrow(V) - arrow(V)_"CV"
    $

#pagebreak()

=== Example 1
A jet of water exits a nozzle (area $A_1$) with a uniform speed $V_1$. It
strikes a vane and is deflected through an angle $theta$. Find the force needed
to hold the vane stationary. Ignore gravity and assume the flow is steady.

#cimage("./images/linear-momentum-equation-example-1.png")
#pagebreak()

Select the control volume and assign the axes.
#cimage("./images/linear-momentum-equation-example-1-solution.png")

$ arrow(V)_"in" = V_1 hat(i), quad dot(m)_"in" rho V_1 A_1 $

Continuity equation:
$ dot(m)_"out" = dot(m)_"in" = dot(m) $
$ arrow(V)_"out" = V_2 cos theta hat(i) + V_2 sin theta hat(k) $

Bernoulli's equation from (1) to (2):
$ p_1 + frac(rho V_1^2, 2) + rho g z_1 = p_2 + frac(rho V_2^2, 2) + rho g z_2 $

Ignoring gravity:
$ z_1 = z_2, quad p_1 = p_2 = p_"atm" $
$ V_1 = V_1 "and" A_1 = A_2 $

Force to hold vane:
$ F_(A x) hat(i) + F_(A z) hat(k) $

#grid(
    columns: 2,
    column-gutter: 5em,
    align: center + horizon,
    [
        Momentum equation in the $x$-direction:

        $ sum F_x = sum (dot(m) V_x)_"out" - sum (dot(m) V_x)_"in" $
        $
            F_(A x) & = dot(m) V_2 cos theta - dot(m) V_1 \
                    & = - dot(m) V_1 (1 - cos theta)
        $
    ],
    [
        Momentum equation in the $z$-direction:

        $ sum F_z = sum (dot(m) V_z)_"out" - sum (dot(m) V_z)_"in" $
        $
            F_(A x) & = dot(m) V_2 sin theta \
                    & = dot(m) V_1 sin theta
        $
    ],
)

=== Example 2
A jet engine is mounted on a thrust stand. Velocity at inlet $V_1$, at outlet
$V_2$, inlet area $A_1$, outlet area $A_2$ air density $rho$, inlet pressure
$p_1$ (absolute), outlet pressure $p_2$ (absolute). Find thrust $F_"th"$. The
flow is steady.

#cimage("./images/linear-momentum-equation-example-2.png")

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        Select control volume and assign axes:
        $ dot(m)_"in" = rho V_1 A_1 = dot(m)_"out" = dot(m) $

        Momentum equation in the $x$-direction:
        $ sum F_x = sum (dot(m) V_x)_"out" - sum (dot(m) V_x)_"in" $
        $
            F_"th" + p_1 A_1 - p_2 A_2 - p_"atm" (A_1 - A_2)
            = dot(m) (V_2 - V_1)
        $
        $
            F_"th" = - (p_1 - p_"atm") A_1 + (p_2 - p_"atm") A_2 +
            dot(m) (V_2 - V_1)
        $
    ],
    image("./images/linear-momentum-equation-example-2-solution.png"),
)

#pagebreak()

=== Example 3
Water enters a horizontal $180 degree$ pipe bend at speed $V_1$. Cross-sectional
area of the bend is uniform, $A_1 = A_2$. Internal gauge pressures at (1) and
(2) are $p_1$ and $p_2$. Find the force needed to hold the bend in place. The
flow is steady.

The weight of the nozzle $W_n$, and the weight of the water in the nozzle is
$W_w$.

#cimage("./images/linear-momentum-equation-example-3.png")
#pagebreak()

Select the control volume and assign axes.
#cimage("./images/linear-momentum-equation-example-3-solution.png")

$ arrow(V)_"in" = V_1 hat(j), quad dot(m)_"in" = rho V_1 A_1 $
$ arrow(V)_"out" = V_2 hat(j), quad dot(m)_"out" = rho V_2 A_2 $

Continuity:
$ dot(m)_"out" = dot(m)_"in" = dot(m) $
$ (rho A V)_"in" = (rho A V)_"out" $

As $A_1 = A_2 = A, V_1 = V_2$:
- Force: $F_(A x) hat(i) + F_(A y) hat(j) + F_(A z) hat(k)$
- Inlet $arrow(F)_1 = p_1 A hat(j)$, outlet $arrow(F)_2 = p_2 A hat(j)$

Momentum equation in the $y$-direction:
$ sum F_y = sum (dot(m) V_y)_"out" - sum (dot(m) V_y)_"in" $
$ sum F_y = F_(A y) + p_1 A + p_2 A = dot(m) (-V_1) - (dot(m) V_1) $

As $F_(A y)$ is negative, its direction is $- hat(j)$.

#grid(
    columns: 2,
    column-gutter: 5em,
    [
        $ sum F_x = sum (dot(m) V_x)_"out" - sum (dot(m) V_x)_"in" $
        $ F_(A x) = 0 $
    ],
    [
        $ sum F_z = sum (dot(m) V_z)_"out" - sum (dot(m) V_z)_"in" $
        $ F_(A z) - W_w - W_n = 0 $
    ],
)

#pagebreak()

=== Example 4
Water at a flow rate of #qty[0.6][L s^-1] exits a vertical nozzle of mass
$m = #qty[0.1][kg]$. Find the inlet pressure $p_1$, and the force to hold the
nozzle.

#grid(
    columns: 2,
    column-gutter: 1em,
    align: horizon,
    [
        - $F_A$ is the anchoring force that holds the nozzle in place
        - $W_n$ is the weight of the nozzle
        - $W_w$ is the weight of water contained in the nozzle
        - $p_1$ is the gauge pressure at section (1)
        - $A_1$ is the cross-sectional area at section (1)
        - $p_2$ is the gauge pressure at section (2)
        - $A_2$ is the cross-sectional area at section (2)
        - $V_1$ is the $z$-direction velocity at control volume entrance
        - $V_2$ is the $z$-direction velocity at control volume exit
        - Inlet (1) diameter: $d_1 = #qty[16][mm]$
        - Outlet (2) diameter: $d_2 = #qty[5][mm]$
        - $z_1 - z_2 = #qty[0.03][m]$
        - $V_n = 2.84 times 10^(-6) #unit[m^3]$
    ],
    image("./images/linear-momentum-equation-example-4.png"),
)

Steady flow: $Q = 0.6 times 10^(-3) #unit[m^3 s^-1]$

#pagebreak()

#grid(
    columns: 2,
    column-gutter: 5em,
    align: horizon,
    [
        Select control volume and assign $z$-axis.
        #grid(
            columns: 2,
            column-gutter: 2em,
            [
                $ arrow(V)_"in" = -V_1 hat(k) $
                $ Q = V_1 A_1 $
                $ V_1 = #qty[2.09][m s^-1] $
                $ arrow(V)_"out" = - V_2 hat(k) $
            ],
            [
                $ A_1 = pi (0.008)^2 $
                $ dot(m)_"in" = rho V_1 A_1 $
                $ A_2 = pi (0.0025)^2 $
                $ dot(m)_"out" = rho V_2 A_2 $
            ],
        )

        Continuity equation:
        $ dot(m)_"in" = dot(m)_"out" $
        $ V_2 = frac(V_1 A_1, A_2) = #qty[30.6][m s^-1] $
    ],
    image("./images/linear-momentum-equation-example-4.png"),
)

Bernoulli's equation from (1) to (2):
$
    p_1 + frac(rho V_1^2, 2) + rho g z_1 = p_2 + frac(rho V_2^2, 2) + rho g z_2
$
$ p_2 = p_"atm" = 0, quad z_1 - z_2 = #qty[0.03][m] $
$ p_1 = frac(rho (V_2^2 - V_1^2), 2) - rho g(z_1 - z_2) $

So, $p_1 = #qty[463.5][kPa] ("gauge")$

$ "Nozzle weight," W_n = 0.1 (9.81) #unit[N] $
$ "Water weight," W_w = 1000 (9.81) (2.84 times 10^(-6)) #unit[N] $

Pressure force at inlet:
$ F_1 = p_1 A_1 = #qty[93.3][N] $

Pressure force at outlet:
$ F_2 = p_2 A_2 = 0 $

Momentum equation in $z$-direction:
$ sum F_z = sum (dot(m) V_z)_"out" - sum (dot(m) V_z)_"in" $
$
    sum F_z & = F_A - W_n - W_w - F_1 + F_2 \
            & = dot(m) (-V_2) - dot(m) (-V_1)
$
$ F_1 = #qty[77.8][N] $

=== Example 5
The width of gate is $b$. The water depth is $H$ upstream of the gate. Find the
force required to hold the gate when h is the water depth downstream of the
gate. Ignore friction.

#cimage("./images/linear-momentum-equation-example-5.png")

Momentum equation:
$ sum F_x = sum (dot(m) V_x)_"out" - sum (dot(m) V_x)_"in" $

Hydrostatic force on section (1):
$ F_1 = rho g h_c A, quad h_c = H/2, quad A = H b $

Hydrostatic force on section (2):
$ F_2 = rho g (h/2) h b $
$ dot(m)_"in" = rho u_1 H b, quad dot(m)_"out" = rho u_2 h b $

If $R_x$ is the force from the gate onto the water, then:
$ F_x = - R_x + F_1 - F-2 $
$
    sum (dot(m) V_x)_"out" - sum (dot(m) V_x)_"in"
    &= dot(m)_"out" u_2 - dot(m)_"in" u_1 \
    &= rho u_2^2 h b - rho u_1^2 H b
$

Continuity equation:
$ dot(m)_"in" = dot(m)_"out" $
$ u_2 = u_1 H/h $

#grid(
    columns: 2,
    column-gutter: 5em,
    align: horizon,
    [
        Bernoulli's equation from $(x)$ to $(y)$:
        $ frac(u_1^2, 2) + g H = frac(u_2^2, 2) + g h $
        $ u_1 = sqrt(frac(2 g h^2, H + h)) $
        $ R_x = F_1 - F_2 - rho (u_1 H/h)^2 h b + rho u_1^2 H b $
    ],
    image("./images/linear-momentum-equation-example-5-bernoulli.png"),
)

#pagebreak()

=== Example 6
Water exits a nozzle ($A = 5.6 times 10^(−4) #unit[m^3]$) with a speed of
#qty[31][m s^-1]. It strikes a vane moving at speed #qty[7][m s^-1] and is
turned through angle $theta = 45 degree$. Find the force exerted by the water on
the vane. Ignore gravity. $W_w = #qty[2][N]$.

#cimage("./images/linear-momentum-equation-example-6.png", width: 75%)

Steady flow, so attach the control volume on the vane so that
$arrow(V)_"CV" = 7 hat(i)$.

At (1):
$ arrow(W)_1 = arrow(V)_1 - arrow(V)_"CV", quad arrow(V)_1 = 31 hat(i) $
$ arrow(W)_1 = arrow(W)_1 hat(i) = 24 hat(i) $

At (2):
$ arrow(W)_2 = arrow(W)_2 cos theta hat(i) + W_2 sin theta hat(k) $

Force on the control volume from the vane:
$ arrow(R) = - R_x hat(i) + R_z hat(k) $

Mass flow rate:
$ dot(m)_1 = rho W_1 A $

Continuity equation:
$ dot(m)_2 = rho W_2 A = dot(m)_1 $
$ W_2 = W_1 = #qty[24][m s^-1] $
$ sum arrow(F) = integral_"C.S." arrow(W) p (arrow(W) dot hat(n)) thin dif A $

Assume uniform $p(arrow(W) dot hat(n))$ at the inlet and outlet.

#grid(
    columns: 2,
    align: horizon,
    column-gutter: 5em,
    [
        $x$-direction:
        $ -R_x = (dot(m) W_x)_"out" - (dot(m) W_x)_"in" $
        $ -R_x = dot(m)_2 W_2 cos theta - dot(m)_1 W_1 $
        $ R_x = dot(m)_1 W_1 (1 - cos theta) = #qty[95][N] $
    ],
    [
        $z$-direction:
        $ R_z - W_w = (dot(m) W_z)_"out" - (dot(m) W_z)_"in" $
        $ R_z - W_w = dot(m)_2 W_x sin theta $
        $ R_z = W_w + dot(m)_1 W_1 sin theta = #qty[230][N] $
    ],
)

== Angular momentum equation
$
    sum arrow(r) times arrow(F) = frac(partial, partial t)
    integral_"C.V." (arrow(r) times arrow(V)) rho thin dif V
    + integral_"C.S." (arrow(r) times arrow(V))
    rho (arrow(V) dot hat(n)) thin dif A
$

#cimage("./images/angular-momentum-equation-fluid-particle.png", height: 15em)

The positive direction of rotation is found by the right-hand rule:
#grid(
    columns: 2,
    column-gutter: 5em,
    [
        For steady flow:
        $
            frac(partial, partial t)
            integral_"C.V." (arrow(r) times arrow(V)) rho thin dif V = 0
        $
        $
            sum arrow(r) times arrow(F) =
            integral_"C.S." (arrow(r) times arrow(V))
            rho (arrow(V) dot hat(n)) thin dif A
        $
    ],
    image("./images/angular-momentum-equation-right-hand-rule.png"),
)

If $(arrow(r) times arrow(V) rho (arrow(V) dot hat(n)))$ is uniform at the
inlets and outlets, then:
$
    integral_"C.S." (arrow(r) times arrow(V))
    rho (arrow(V) dot hat(n)) thin dif A
    = sum_"out" (arrow(r) times arrow(V)) rho (arrow(V) dot hat(n)) A
    + sum_"in" (arrow(r) times arrow(V) rho (arrow(V) dot hat(n))) A
$

$
    sum arrow(r) times arrow(F) =
    sum_"out" dot(M) (arrow(r) times arrow(V))
    - sum_"in" dot(M) (arrow(r) times arrow(V))
$

If a shaft is involved, then the shaft torque ($arrow(T)$):
$ arrow(T) = sum arrow(r) times arrow(F) $

Where:
- $arrow(r)$ is the position vector of the fluid particle having velocity
    $arrow(V)$
- $arrow(F)$ is the force of the fluid
- $dif A$ is the differential area $A$ on the control surface.
- $hat(n)$ is an outward normal vector.

#pagebreak()

=== Straight pipe vs slanted pipe
Straight pipe:
#cimage("./images/angular-momentum-equation-straight-pipe.png")
$ W_2 = V_2 + U_2 = (V_2 - (- U_2)) $
$ V_2 = W_2 - U_2 $

Slanted pipe:
#cimage("./images/angular-momentum-equation-slanted-pipe.png")

=== Example 1
<angular-momentum-equation-example-1>
Water enters a sprinkler from its base and leaves through two horizontal nozzles
in the tangential direction. Find the speed of water leaving the nozzle
(relative to the nozzle) if (a) the arms are stationary, and (b) each arm
rotates at #qty[600][rpm]. Note the direction of $omega$.
#grid(
    columns: 2,
    column-gutter: 1em,
    align: center + horizon,
    image("./images/angular-momentum-equation-example-1-1.png"),
    image("./images/angular-momentum-equation-example-1-2.png"),
)

- $arrow(W)_2$ is the velocity of the fluid relative to the control volume.
- $arrow(V)_2$ is the velocity of the fluid relative to the fixed ground.
$ arrow(V)_2 = arrow(W)_2 + arrow(V)_"C.V." $

Continuity equation:
$
    frac(partial, partial t) integral_"C.V." rho thin dif V +
    integral_"C.S." rho (arrow(V) dot hat(n)) thin dif A = 0
$
$
    frac(partial, partial t) integral_"C.V." rho thin dif V +
    integral_"C.S." rho (arrow(W) dot hat(n)) thin dif A = 0
$

Where $arrow(W) = arrow(V) - arrow(V)_"C.V."$.

For steady flow:
$ frac(partial, partial t) = 0 $
$
    integral_"C.S." rho (arrow(W) dot hat(n)) thin dif A = 0,
    quad dot(m)_2 - dot(m)_1 = 0
$

$ dot(m)_1 = rho Q, quad dot(m)_2 = rho (2A_2) W_2 $
$ W_2 = frac(Q, 2A_2) = #qty[16.7][m s^-1] $

$W_2$ is independent of $omega$.

=== Example 2
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        For the setting in @angular-momentum-equation-example-1, find:
        #enum(
            numbering: "(a)",
            [Torque to hold the sprinkler stationary (i.e. $omega = 0$)],
            [Torque when the sprinkler rotates at #qty[500][rpm]],
            [Angular speed of the sprinkler if the torque is 0],
        )
    ],
    image("./images/angular-momentum-equation-example-2-1.png"),
)

#pagebreak()

==== (a): Stationary sprinkler
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        Select a stationary control volume and the z-axis:
        $
            T_"shaft" hat(k) & = sum arrow(r) times arrow(F) \
                             & = sum_"out" dot(m) (arrow(r) times arrow(V))
                               - sum_"in" dot(m) (arrow(r) times arrow(V))
        $

        $ Q = 1000 times 10^(-6) #unit[m^3 s^-1] $

        At the inlet (1), $arrow(V)_1 = Q/A$. The velocity vector $arrow(V)_1$
        coincides with the $z$-axis. Therefore, $r_1$, which is the distance
        between $arrow(V)_1$ and the $z$-axis, is zero, i.e. $r_1 = 0$.
    ],
    image("./images/angular-momentum-equation-example-2-2.png", height: 15em),
)

#cimage("./images/angular-momentum-equation-example-2-3.png", height: 20em)

$
    sum_"in" dot(m) (arrow(r) times arrow(V))
    = dot(m) arrow(r)_1 times arrow(V)_1 = 0
$

At the outlet,
$ V_2 = Q/(2A_2) = #qty[16.67][m s^-1] $
$ A_2 = #qty[30][mm^2] $

Given $r_2 = #qty[200][mm]$:
$
    sum_"out" dot(m) (arrow(r)_2 times arrow(V)_2)
    = - dot(m) r_2 V_2 hat(k)
$
$ dot(m) = rho Q $

So:
$
    T_"shaft" hat(k) = sum arrow(r) times arrow(F)
    = -dot(m) r_2 V_s hat(k)
$
$
    T_"shaft"
    = -1000 (10^(-3)) (0.2) (16.67) #unit[Nm] = #qty[-3.34][Nm]
$

#pagebreak()

==== (b): Rotating arms
Select the control volume attached to the arms.
#grid(
    columns: 2,
    column-gutter: 1em,
    align: center + horizon,
    image("./images/angular-momentum-equation-example-2-4.png"),
    image("./images/angular-momentum-equation-example-2-5.png"),
)

From @angular-momentum-equation-example-1:
$ W_2 = Q/(2A_2) = #qty[16.67][m s^-1] $

Consider the direction of angular velocity $omega$. With the direction shown,
the control volume moves at:
$ V_"C.V." = - U_2 hat(i) = -r_2 omega hat(i) $

Where $U_2 = r_2 omega$ is the speed of each arm-tip.

From $arrow(V) = arrow(W) + arrow(V)_"C.V."$:
$ V_2 = W_2 + (-r_2 omega) $

As $omega = #qty[500][rpm]$, $r_2 = #qty[200][mm]$ and $W_2 = #qty[16.67][m
    s^-1]$, $V_2 = #qty[6.2][m s^-1]$

As $T_"shaft" hat(k) = sum arrow(r) times arrow(F) = dot(m) r_2 V_2 hat(k)$:
$ T_"shaft" = -1000 (10^(-3)) (0.2) (6.2) #unit[Nm] = #qty[-1.24][Nm] $

==== (c): Consider $T_"shaft" = 0$
As $T_"shaft" hat(k) = sum arrow(r) times arrow(F) = - dot(m) r_2 V_2 hat(k)$,
we can conclude that $V_2 = 0$ because $dot(m) != 0$, $r_2 != 0$.

Therefore:
$ W_2 = V_2 - (-r_2 omega) $
$ W_2 = 0 - (-r_2 omega) $

Or:
$ omega = frac(W_2, r_2) = #qty[797][rpm] $

== Energy equation

=== Variables
- $e$ is the total energy $e = breve(u) + frac(V^2, 2) + g z$ per unit $dot(m)$
- $breve(u)$ is the internal energy ($dot(m) c_P T$) per unit $dot(m)$, where
    $c_p$ is the heat capacity and $T$ is the temperature
- $frac(V^2, 2)$ is the kinetic energy ($dot(m) V^2/2$) per unit $dot(m)$
- $g z$ is the potential energy ($dot(m) g z$) per unit $dot(m)$

=== Equation
Insert $arrow(V)$ into the continuity equation:
$
    frac(D, D t) (M_"sys")
    = frac(partial, partial t) integral_"C.V." rho thin dif V
    + integral_"C.S." rho (arrow(V) dot hat(n)) thin dif A = 0
$

Gets the momentum equation:
$
    frac(D, D t) (M_"sys" arrow(V))
    = frac(partial, partial t) integral_"C.V." arrow(V) rho thin dif V
    + integral_"C.S." arrow(V) rho (arrow(V) dot hat(n)) thin dif A = 0
$

Insert $e$ into the continuity equation:
$
    frac(D, D t) (M_"sys")
    = frac(partial, partial t) integral_"C.V." rho thin dif V
    + integral_"C.S." rho (arrow(V) dot hat(n)) thin dif A = 0
$

Gets the energy equation:
$
    frac(D, D t) integral e rho thin dif V
    = frac(partial, partial t) integral_"C.V." e rho thin dif V
    + integral_"C.S." e rho (arrow(V) dot hat(n)) thin dif A
    = (sum dot(Q)_"in" - sum dot(Q)_"out")_"sys"
    + (sum dot(W)_"in" dot(W)_"out")_"sys"
$

Where:
- $dot(Q)_"in/out"$ is the rate of heat transfer in/out of the system
- $dot(W)_"in/out"$ is the rate of work done (or transfer) in/out of the system

$dot(Q)_"in"$ and $dot(W)_"in"$ are associated with the *'#sym.plus'* sign if
they are *into* the system.

$dot(Q)_"out"$ and $dot(W)_"out"$ are associated with the *'#sym.minus'* sign if
they are *out* the system.

=== Rotating shaft in a pump
#cimage("./images/work-done-by-a-rotating-shaft.png", width: 90%)

$ dot(W)_"in (shaft)" = T_"shaft" omega $

Where:
- $T_"shaft"$ is the shaft torque
- $omega$ is the angular speed of the shaft

=== Pressure
$
    dot(W)_"in (p)"
    = integral_"C.S." - p (arrow(V) dot hat(n)) thin dif A
$

Note that multiplying the force $(-p) thin dif A$ by velocity
$(dot(V) dot hat(n))$ gives the power.

In this course, the fluid flow is usually adiabatic, which means there is no
heat transfer.
$ (sum dot(Q)_"in")_"sys" = (sum dot(Q)_"out")_"sys" = 0 $

For steady adiabatic flow with
$dot(W)_"in" = dot(W)_"in (p)" + dot(W)_"in (shaft)"$, the energy equation is:

$
    frac(partial, partial t) integral_"C.V." e rho thin dif V
    + integral_"C.S." e rho (arrow(V) dot hat(n)) thin dif A
    = (sum dot(Q)_"in" - sum dot(Q)_"out")_"sys"
    + (sum dot(W)_"in" - dot(W)_"out")_"sys"
$

$
    integral_"C.S." e rho (arrow(V) dot hat(n)) thin dif A
    = integral_"C.S." (-p) (arrow(V) dot hat(n)) thin dif A
    + dot(W)_"in (shaft)" - sum dot(W)_"out"
$

Since $e = breve(u) + frac(V^2, 2) + g z$:
$
    integral_"C.S." e rho (arrow(V) dot hat(n)) thin dif A
    - integral_"C.S." (-p) (arrow(V) dot hat(n)) thin dif A
    = integral_"C.S." (breve(u) + p/rho + V_2/2 + g z)
    rho (arrow(V) dot hat(n)) thin dif A
$

Let $(breve(u) + p/rho + V^2/2 + g z)$ be uniform at inlets/outlets.
$
    & integral_"C.S." (breve(u) + p/rho +V^2/2 + g z)
      rho (arrow(V) dot hat(n)) thin dif A \
    & = (breve(u) + p/rho + V^2/2 + g z)_"out"
      integral_"out" rho (arrow(V) dot hat(n)) thin dif A \
    & + (breve(u) + p/rho + V^2/2 + g z)_"in"
      integral_"in" rho (arrow(V) dot hat(n)) thin dif A
$

$
    integral_"in" rho (arrow(V) dot hat(n)) dif A
    = - sum dot(m)_"in", wide wide
    integral_"out" rho (arrow(V) dot hat(n)) dif A = sum dot(m)_"out"
$

$
    sum_"out" dot(m) (breve(u) + p/rho + V^2/2 + g z)
    - sum_"in" dot(m) (breve(u) + p/rho + V^2/2 + g z)
    = dot(W)_"in (shaft)" - sum dot(W)_"out"
$

#pagebreak()

=== Example 1
The pump delivers water at $Q = #qty[0.02][m^3 s^-1]$. Find the pump power
$dot(W)_"in (shaft)"$, when $z_1 = z_2$, $D_1 = #qty[0.09][m]$,
$D_2 = #qty[0.025][m]$, $p_1 = #qty[124][kPa]$, $p_2 = #qty[414][kPa]$,
$breve(u)_2 - breve(u)_1 = #qty[279][J kg^-1]$, $rho = #qty[1000][kg m^-3]$.

#cimage("./images/energy-equation-example-1.png", width: 80%)

$ sum dot(W)_"out" = 0, wide dot(m) = rho Q = #qty[20][kg s^-1] $
$ V_1 = Q/A_1 = #qty[3.1][m s^-1] $
$ V_2 = Q/A_2 = #qty[40.7][m s^-1] $

$
    dot(m) (breve(u) + p/rho + V^2/2 + g z)_"out"
    - dot(m) (breve(u) + p/rho + V^2/2 + g z)_"in" = dot(W)_"in (shaft)"
$

$
    "LHS" = dot(m) (breve(u)_2 - breve(u)_1 + frac(p_2 - p_1, rho)
        + frac(V_2^2 - V_1^2, 2))
$
$ "LHS" = #qty[27882][W] = dot(W)_"in (shaft)" $

There is 1 inlet and 1 outlet (and $sum dot(W)_"out"$) in this example.
$
    dot(m) (breve(u) + p/rho + V^2/2 + g z)_"out"
    - dot(m) (breve(u) + p/rho + V^2/2 + g z)_"in" = dot(W)_"in (shaft)"
$

Or:
$
    (p/rho + V^2/2 + g z)_"out" + (breve(u)_"out" - breve(u)_"in")
    - (p/rho + V^2/2 + g z)_"in" = dot(W)_"in (shaft)"
$

Where:
- $breve(u)_"out" - breve(u)_"in"$ is the loss of energy per unit mass flow rate
    $dot(m)$, to overcome friction in fluid flow.
- $h_L = frac(breve(u)_"out" - breve(u)_"in", g)$ is the head loss.
- $m g h_L = dot(m) (breve(u)_"out" - breve(u)_"in")$ is the energy loss.

If $dot(W)_"in (shaft)" = 0$, then:
$
    (frac(p, rho g) + frac(V^2, 2 g) + z)_"in"
    = (frac(p, rho g) + frac(V^2, 2 g) + z)_"out" + h_L
$

If $h_L = 0$, then:
$
    (frac(p, rho g) + frac(V^2, 2 g) + z)_"in"
    = (frac(p, rho g) + frac(V^2, 2 g) + z)_"out" wide
    ("Bernoulli's equation")
$

#pagebreak()

=== Example 2
A fan inputs #qty[0.4][kW] of power to the blades to produce an air stream of
diameter $D_2 = #qty[0.6][m]$ at #qty[12][m s^-1]. Find $h_L$ and efficiency
$eta$ of the fan.

#cimage("./images/energy-equation-example-2.png", width: 70%)

Using the energy equation:
$
    (p/rho + V^2/2 + g z)_"out" + (breve(u)_"out" - breve(u)_"in")
    - (p/rho + V^2/2 + g z)_"in"
    = frac(dot(W)_"in (shaft)" - sum dot(W)_"out", dot(m))
$

$ h_L = frac(breve(u)_"out" - breve(u)_"in", g), wide V_2 = #qty[12][m s^-1] $
$ sum dot(W)_"out (shaft)" = 0, wide z_1 = z_2 $
$ p_1 = p_2 = p_"atm", wide V_1 approx 0 $
$ dot(m) = rho V_2 A_2 = rho V_2 frac(pi D_2^2, 4) = #qty[4.17][kg s^-1] $
$ dot(W)_"in (shaft)" = #qty[0.4][kW] $
$ frac(12^2, 2) + 9.81 h_L = frac(0.4(1000), 4.17) $
$ h_L = #qty[2.44][m], wide eta = frac(dot(W)_"output", dot(W)_"input") $
$
    eta = frac(dot(W)_"in (shaft)" - dot(m) g h_L, dot(W)_"in (shaft)")
    = 0.75 = 75%
$

25% of the input power is lost to overcome friction in air flow or dissipated as
heat.

#pagebreak()

=== Example 3
A pump adds #qty[7.5][kW] to deliver water from (B) to (A) with head loss
$h_L = #qty[4.6][m]$. Find $Q$ and the power loss. Let
$z_A - z_B = #qty[9.1][m]$.
#cimage("./images/energy-equation-example-3.png")

Using the energy equation:
$
    (p/rho + V^2/2 + g z)_"out" + (breve(u)_"out" - breve(u)_"in")
    - (p/rho + V^2/2 + g z)_"in"
    = frac(dot(W)_"in (shaft)" - sum dot(W)_"out", dot(m))
$

Where $h_L = frac(breve(u)_"out" - breve(u)_"in", g)$.

$ sum dot(W)_"in (shaft)" = dot(W)_"pump" = #qty[7.5][kW] $
$ sum dot(W)_"out (shaft)" = 0, wide h_L = #qty[4.6][m] $
$ p_A = p_B = p_"atm", wide V_1 approx 0, wide V_2 approx = 0 $
$ 9.81 (9.1 + 4.6) = frac(7500, dot(m)) $

With $dot(m) = rho Q = 1000 Q$:
$ Q = #qty[0.056][m^3 s^-1] $

Power loss $dot(W)_L = dot(m) g h_L = #qty[2.5][kW]$.

#pagebreak()

=== Example 4
Steam enters a turbine at speed #qty[30][m s^-1] with
$(breve(u) + p/rho) = #qty[3348][kJ kg^-1]$ and leaves the turbine at speed
#qty[60][m s^-1] with $(breve(u) + p/rho) = #qty[2550][kJ kg^-1]$. For adiabatic
flow with $z_1 = z_2$, find $dot(W)_"out (shaft)"/dot(m)$.

#cimage("./images/energy-equation-example-4.png")

Using the energy equation:
$
    (p/rho + V^2/2 + g z)_"out" + (breve(u)_"out" - breve(u)_"in")
    - (p/rho + V^2/2 + g z)_"in"
    = frac(dot(W)_"in (shaft)" - sum dot(W)_"out (shaft)", dot(m))
$

With $sum dot(W)_"in (shaft)" = 0$ and $z_1 = z_2$.

$
    (breve(u) + p/rho)_"out" - (breve(u) + p/rho)_"in"
    = 2550 - 3348 = #qty[-798][kJ kg^-1]
$

$ (V^2/2)_"out" - (V^2/2)_"in" = frac(60^2 - 30^2, 2) = #qty[1.35][kJ kg^-1] $
$
    - frac(dot(W)_"out (shaft)", dot(m)) = (breve(u) + p/rho)_"out"
    - (breve(u) - p/rho)_"in" + (V^2/2)_"out" - (V^2/2)_"in"
$

$ frac(dot(W)_"out (shaft)", dot(m)) = 798 - 1.35 = #qty[796.65][kJ kg^-1] $

#pagebreak()

=== Example 5
Steady adiabatic flow through the horizontal connection without
$dot(W)_"in (shaft)"$. Find the power lost in this horizontal connection.
$rho = #qty[1000][kg m^3]$.

#cimage("./images/energy-equation-example-5.png")

Continuity:
$ dot(m)_1 = dot(m)_2 + dot(m)_3 $
$ rho V_1 A_1 = rho V_2 A_2 + rho V_3 A_3 $
$ V_2 = #qty[16.4][m s^-1] $

Energy equation:
$
    dot(m)_2 (breve(u) + p/rho + V^2/2)_2
    + dot(m)_3 (breve(u) + p/rho + V^2/2)_3
    - dot(m)_3 (breve(u) + p/rho + V^2/2)_1
$

There are 2 outlets and 1 inlet.

Power lost is:
$
    dot(m) g h_L
    &= sum dot(m)_"out" breve(u)_"out" - sum dot(m)_"in" breve(u)_"in" \
    &= dot(m)_2 breve(u)_2 + dot(m)_3 breve(u)_3 - dot(m) breve(u)_1 \
    &= dot(m)_1 (p/rho + V^2/2)_1 -
    dot(m)_2 (p/rho + V^2/2)_2 - dot(m)_3 (p/rho + V^2/2)_3 \
    &= #qty[1.16][MW]
$

#pagebreak()

= Flow rate meters
Various flow-measuring devices are frequently used to determine the volume flow
rate $Q$ in a pipe experimentally.

Generally, for the nozzle and venturi meter, a decrease in cross-sectional area
$A$ in a pipe causes an increase in velocity $V$ because $Q = V A$.

And increasing $V$ leads to a drop in pressure $p$ at a given elevation $z$,
according to Bernoulli's equation:
$ frac(p, rho g) + frac(V^2, 2g) + z = "constant" $

== Nozzle meter: $D -> d$
#cimage("./images/nozzle-meter.png")

== Venturi meter: $D -> d$
#cimage("./images/venturi-meter.png")

== Orifice meter
It is a plate with a circular hole of diameter $D_2$ fitted in a pipe of
diameter $D_1 > D_2$. As the flow is partially blocked by the plate, a pressure
drop ($p_1 - p_2 > 0$) across the plate is expected. Two pressure taps are
drilled upstream and downstream of the plate to measure the pressure drop
($Delta p = p_1 - p_2$).

#cimage("./images/orifice-meter.png", width: 65%)

== Applications
#align(center, grid(
    columns: 2,
    figure(
        caption: [Turbine flow meter],
        image("./images/turbine-flow-meter.png", height: 20em),
    ),
    figure(
        caption: [Rotameter],
        image("./images/rotameter.png", height: 20em),
    ),
))

#figure(
    caption: [Gas meter],
    image("./images/gas-meter.png"),
)

== Derivation
Consider an incompressible fluid of density $rho$ flowing through a horizontal
pipe of diameter $D$ inserted with a restriction of diameter $d$.

#cimage("./images/flow-rate-meter.png", width: 95%)

For flow from (1) to (2):

Let $z_1 = z_2$. If the loss of energy $h_L = 0$, then
$ frac(p_1, rho g) + frac(V_1^2, 2 g) = frac(p_2, rho g) + frac(V_2^2, 2 g) $

Cancelling gravity $g$ and rearranging terms,
$ V_2^2 (1 - frac(V_1^2, V_2^2)) = frac(2(p_1 - p_2), rho) $

Continuity equation:
$ V_1 A_1 = V_2 A_2 quad => quad V_1 frac(pi D^2, 4) = V_2 frac(pi d^2, 4) $

If $beta = d/D$, then $V_1/V_2 = beta^2$, then:
$ V_2^2 (1 - beta^4) = frac(2(p_1 - p_2), rho) $
$ V_2 = sqrt(frac(2(p_1 - p_2), rho (1 - beta^4))) $

Define a theoretical or *ideal* flow rate as $Q_"ideal" = A_2 V_2$.

From $V_2$:
$ Q_"ideal" = A_2 sqrt(frac(2(p_1 - p_2), rho (1 - beta^4))) $

In reality, where $h_L != 0$,
$
    frac(p_1, rho g) + frac(V_1^2, 2 g)
    = frac(p_2, rho g) + frac(V_2^2, 2 g) + h_L
$

Where $z_1 = z_2$.

In the absence of an accurate "theoretical" formula for $h_L$, the actual flow
rate is taken to be $Q = C_n Q_"ideal"$. $C_n$ is the discharge coefficient
(subscript $n$ for nozzle) found from many experimental measurements.

== Discharge coefficient

=== Nozzle meter ($C_n$)
$C_n = f(beta, R e)$ is plotted as a function of $beta$ and
$R e = frac(rho D V, mu)$ where $V = V_1$, and $mu$ is the dynamic viscosity of
the fluid.

#cimage("./images/discharge-coefficient-nozzle-meter.png", height: 20em)

$R e$ is called the Reynolds number which indicates the nature of pipe flow
(either laminar or turbulent).

=== Orifice meter ($C_o$)
For an orifice meter of diameter $d$ fitted in a pipe of diameter $D > d, C_o$
(subscript $o$ for orifice) is the discharge coefficient in $Q = C_o Q_"ideal"$.

#cimage("./images/discharge-coefficient-orifice-meter.png", height: 20em)

The orifice meter, although not as accurate as the nozzle meter and the venturi
meter, is widely used because of its simplicity in design and cost involved.
Standards are available for values of $C_o$, $C_n$ and $C_v$ for various
specific geometric configurations.

=== Venturi meter ($C_v$)
For a venturi meter of diameter $d$ fitted in a pipe of diameter $D > d$, $C_v$
(subscript $v$ for venturi) is the discharge coefficient in $Q = C_v Q_"ideal"$.

#cimage("./images/discharge-coefficient-venturi-meter.png", height: 20em)

== Equations for flow rate meters

=== Velocity of fluid after the flow rate meter
$ V_2 = sqrt(frac(2 (p_1 - p_2), rho (1 - beta^4))) $

Where:
- $V_2$ is the velocity of the fluid after the flow rate meter
- $p_1$ is the pressure before the flow rate meter
- $p_2$ is the pressure after the flow rate meter
- $rho$ is the density of the fluid
- $beta = d/D$, where $D$ is the diameter of the pipe before the flow rate meter
    and $d$ is the diameter of the flow rate meter

=== Flow rate
$
    Q = C_n Q_"ideal" = C_n A_2 V_2
    = C_n A_2 sqrt(frac(2 (p_1 - p_2), rho (1 - beta^4)))
$

Where:
- $Q$ is the flow rate
- $C_n$ is the discharge coefficient
- $A_2$ is the area of the flow rate meter
- $V_2$ is the velocity of the fluid after the flow rate meter
- $p_1$ is the pressure before the flow rate meter
- $p_2$ is the pressure after the flow rate meter
- $rho$ is the density of the fluid
- $beta = d/D$, where $D$ is the diameter of the pipe before the flow rate meter
    and $d$ is the diameter of the flow rate meter

#pagebreak()

== Procedure of finding $Q$ when $d, D, rho$ and $mu$ are given
Given $d = #qty[0.05][m], D = #qty[0.08][m], q = #qty[1.4][kg m^-3]$ and
$mu = 1.97 times 10^(-5) #unit[N s m^-2]$

+ Measure $p_1 - p_2 = #qty[71.5][Pa]$
+ Calculate:
    $ beta = d/D = 0.625 wide A_1 = frac(pi D^2, 4) = #qty[0.005][m^3] $
    $
        A_2 = frac(pi d^2, 4) = #qty[0.002][m^3]
        wide
        Q_"ideal" = A^2 sqrt(
            frac(
                2(p_1 - p_2),
                rho (1 - beta^4)
            )
        ) = #qty[0.022][m^3]
    $
    #cimage("./images/procedure-to-find-q-pipe.png")
+ Let $Q = V_1 A_1 = C_n Q_"ideal"$

    From $R e = frac(rho D V_1, mu)$, form the linear equation in terms of
    variables $C_n$, $R e$:
    $ C_n = frac(mu A_1, rho D Q_"ideal") R e = 4 times 10^(-5) R e $

    Plot this linear relation (dashed line), on the linear-log graph of $C_n$
    versus $R e$.

    #cimage(
        "./images/procedure-to-find-q-discharge-coefficient.png",
        height: 23em,
    )
+ Add the curve corresponding to $beta approx 0.625$ (solid line) onto the
    graph.
+ Identify the intersection $(C_n^*, R e^*)$ between this linear relation and
    the curve.
+ $Q = C_n times Q_"ideal"$ is the required flow rate.
+ $R e^*$ is the Reynolds number at $Q$.

=== Example
Alcohol flows through a pipe $D = #qty[0.06][m]$ at $Q = #qty[0.003][m^3 s^-1]$.
If $p_1 - p_2 = #qty[4][kPa]$ across the nozzle is measured, find nozzle $d$.
Given $rho = #qty[789][kg m^-3]$, $mu = 1.19 times 10^(-3) #unit[Ns m^-2]$

#cimage("./images/flow-rate-meter-example.png")

$
    A_1 = frac(pi D_1^2, 4), wide V_1 = Q/A_1 = #qty[1.06][m s^-1],
    wide R e = frac(rho V_1 D, mu) = 42200
$

$ beta = d/D, wide d = ?, 0 < beta < 1 $
$ p_1 - p_2 = #qty[4][kPa] wide A_2 = frac(pi d^2, 4) $
$ Q = C_n Q_"ideal" = C_n A^2 sqrt(frac(2(p_1 - p_2), rho (1 - beta^4))) $
$ 1.2 times 10^(-3) = frac(C_n d^2, sqrt(1 - beta^4)) $

Solve the equation above for $d$ with the $C_n$ graph.

#pagebreak()

Assume $C_n = 1$ and $1 - beta^4 approx 1$:
#cimage(
    "./images/flow-rate-meter-example-discharge-coefficient-graph.png",
    height: 23em,
)

$ 1.2 times 10^-3 = d^2 $
$ d = #qty[0.034][m] $
$ beta = d/D = 0.577 $

With $R e = 42200$ and $beta = 0.577$,
$ C_n = 0.972 space ("from graph") $

Let $C_n = 0.972$, $beta = 0.577$,
$ 1.2 times 10^(-3) = frac(C_n d^2, sqrt(1 - beta^4)) $
$ d = #qty[0.0341][m] $
$ beta = 0.0341/0.06 = 0.568 $

With $R e = 42200$ and $beta = 0.568$, estimate $C_n tilde.eq 0.972$ from the
graph. As this value is near the previous one, the calculation is stopped.
Otherwise, repeat the calculation with $d = #qty[0.0341][m]$ until $C_n$ does
not change.

In practice, iterative calculations are carried out in a computer. If the lines
in the graph are expressed as a function of $beta$ and $R e$.
$
    C_n = 0.99 - 0.2262 beta^(4.1)
    - [0.00175 beta^2 - 0.003 beta^(4.15) (frac(10^6, R e)^(1.15))]
$

The above is for venturi meters over:
$ 0.3 <= beta <= 0.44, quad 7 times 10^4 <= R e <= 10^7 $

#pagebreak()

= Dimensional analysis
Dimensional analysis is a technique of grouping variables to reduce the number
of experiments to be conducted, saving experimental time and cost.

== Buckingham Pi theorem
If an equation involving $n$ variables is dimensionally homogeneous, it can be
reduced to a relationship among $(n - m)$ independent dimensionless products,
where $m$ is the minimum number of reference dimensions required to describe the
variables. The dimensionless groups are frequently referred to as #sym.pi terms
or #sym.pi groups.

== Basic dimensions
#let basic-dimensions = table(
    columns: 3,
    table.header([*Name*], [*Unit*], [*Dimension symbol*]),
    [Time], [Second (#unit[s])], $T$,
    [Length], [Meter (#unit[m])], $L$,
    [Mass], [Kilogram (#unit[kg])], $M$,
    [Electric current], [Ampere (#unit[A])], $I$,
    [Temperature], [Kelvin (#unit[K])], $Theta$,
    [Luminous intensity], [Candela (#unit[cv])], $J$,
    [Amount of substance], [Mole (#unit[mol])], $N$,
)

#align(center, basic-dimensions)
#pagebreak()

== Common physical quantities and their dimensions
#let common-physical-quantities = table(
    columns: 3,
    align: center + horizon,
    table.header(
        [*_Physical quantity_*], [*_SI Unit_*], [*_Dimension symbol_*]
    ),
    [*Velocity*], unit[m s^-1], $ L T^(-1) = L/T $,
    [*Acceleration*], unit[m s^-2], $ L T^(-2) = L/T^2 $,
    [*Density*], unit[kg m^-3], $ M L^(-3) = M/L^3 $,
    [*Force*], unit[N], $ M L T^(-2) = frac(M L, T^2) $,
    [*Pressure*], unit[Pa], $ M L^(-1) T^(-2) = frac(M, L T^2) $,
    [*Viscosity*], unit[Pa s], $ M L^(-1) T^(-1) = frac(M, L T) $,
    [*Torque*], unit[N m], $ M L^2 T^(-2) = frac(M L^2, T^2) $,
    [*Power*], unit[W], $ M L^(2) T^(-3) = frac(M L^2, T^3) $,
    [*Energy*], [#unit[N m] (#unit[J])], $ M L^(2) T^(-2) = frac(M L^2, T^2) $,
    [*Rotation speed*], unit[s^-1], $ T^(-1) = 1/T $,
    [*Volumetric flow rate*], unit[m^3 s^-1], $ L^3 T^(-1) = L^3/T $,
)

#align(center, common-physical-quantities)

Equations to figure out the units for more complex quantities:
$ "Force:" F = m a space (#unit[kg m s^-2]) $
$ "Power:" P = F v $
$ "Energy:" E = F times "distance" $
$ "Pressure" = frac(F, A) $

#pagebreak()

== Procedure
Using the equation below as an example:
$ Delta P_L = f(D, rho, mu, V) $

=== Step 1
List all the variables that are involved in the problem and find the total
number of variables, $n$.
- Variables are $Delta P_L$, $D$, $rho$, $mu$, $V$.
- So $n$ is 5.

=== Step 2
Express each of the variables in terms of the 7 basic dimensions, and find the
*total number* of *unique* basic dimensions.

#align(center, basic-dimensions)

$
    [Delta P_L] = frac(#unit[n], #unit[m^3])
    = frac(#unit[kg] dot #unit[m], #unit[s^2]) dot 1/#unit[m^3]
    = frac(M, L^2 T^2)
$
$ [D] = #unit[m] = L $
$ [rho] = frac(#unit[kg], #unit[m^3]) = frac(M, L^3) $
$
    [mu] = frac(#unit[N s], #unit[m^2])
    = frac(#unit[kg] dot #unit[m], #unit[s^2]) dot #unit[s]/#unit[m^2]
    = frac(M, L T)
$
$ [V] = #unit[m]/#unit[s] = L/T $

Basic dimensions are $M$, $L$, $T$, so $m$ is 3.

=== Step 3
<dimensional-analysis-step-3>
Determine the required number of #sym.pi terms by calculating $(n - m)$:
$ "Number of" pi "groups" = n - m = 5 - 3 = 2 $

=== Step 4
Select a number of $m$ repeating variables.
$ "We select" rho, V, D $

#pagebreak()

=== Step 5
Form #sym.pi groups and make each #sym.pi group dimensionless.
+ Assign the #sym.pi groups to the remaining variables that are *not selected*
    in the previous step.
    $ pi_1 = Delta P_L $
    $ pi_2 = mu $
+ Multiply the *selected variables* back onto the #sym.pi groups with an unknown
    power to make them dimensionless.
    $ pi_1 = Delta P_L rho^a V^b D^c $
    $ pi_2 = mu rho^a V^b D_c $
+ Substitute the variables basic dimensions (from step 2) into the #sym.pi group
    and simplify.
    $
        pi_1 = Delta P_L rho^a V^b D^c = frac(M, L^2 T^2) (M/L^3)^a (L/T)^b L^c
        = #text(blue)[$M^(1 + a) L^(-2 - 3a + b + c) T^(-2 - b)$]
    $
+ Set all the unknown powers to 0 and solve the system of linear equations.
    $
        cases(
            1 + a = 0,
            - 2 - 3a + b + c = 0,
            -2 - b = 0
        ) quad => quad cases(
            a = -1,
            b = -2,
            c = 1
        )
    $
    $
        therefore pi_1 = Delta P_L rho^(-1) V^(-2) D^1
        = frac(D Delta P_L, rho V^2)
    $
+ Repeat the same steps for the remaining #sym.pi groups.
    $
        pi_2 = mu rho^a V^b D^c = frac(M, L T) (M/L^3)^a (L/T)^b L^c
        = #text(blue)[$M^(1 + a) L^(-1 - 3a + b + c) T^(-1 - b)$]
    $
    $
        cases(
            1 + a = 0,
            - 1 - 3a + b + c = 0,
            -2 - b = 0
        ) quad => quad cases(
            a = -1,
            b = -1,
            c = -1
        )
    $
    $
        therefore pi_1 = Delta P_L rho^(-1) V^(-1) D^(-1)
        = frac(mu, rho V D)
    $

+ Express the final form as a relationship among the #sym.pi groups:
    $ frac(D Delta P_L, rho V^2) = f (frac(mu, rho V D)) $

#pagebreak()

#heading(level: 3)[
    Guidelines to selecting repeating variables (#link(
        <dimensional-analysis-step-3>,
    )[step 3])
]
Pick one variable from each of the 3 categories below:
- Geometry:
    - Length, height, width, diameter, roughness, etc.
- Material properties:
    - Density, viscosity, bulk modulus, etc.
- External force:
    - Linear or angular velocity, linear or angular acceleration, pressure,
        force, etc.

+ Each of the basic dimensions must be represented in the repeating variables.
+ *Do not* pick the dependent variable, which is $Delta P_L$ in the example.
+ *Do not* pick variables which are already dimensionless, like an angle.
+ *Do not* pick variables which are able to form a #sym.pi group all by
    themselves, like:
    - Length and area
    - Length, time, and velocity

== Example
The pressure rise, $Delta P$, across a pump depends on the fluid density
($rho$), the viscosity ($mu$), the flow rate ($Q$), and the diameter ($D$) and
angular velocity ($omega$) of the impeller.
+ Derive the suitable #sym.pi groups and a general relation for the pressure
    rise.
+ What is the #sym.pi group for the mechanical power input to the pump? Use
    $rho$, $omega$ and $D$ as repeating variables.

=== Part 1

==== Step 1
List all the variables:
$ Delta P, D, rho, mu, omega, Q $
$ therefore n = 6 $

==== Step 2
Express each of the variables in terms of basic dimensions:
$
    [Delta P] = frac(#unit[N], #unit[m^2])
    = frac(#unit[kg] dot #unit[m], #unit[s^2]) dot 1/#unit[m^2]
    = frac(M, L T^2)
$
$ [D] = #unit[m] = L $
$ [rho] = frac(#unit[kg], #unit[m^3]) = frac(M, L^3) $
$
    [mu] = frac(#unit[N s], #unit[m^2])
    = frac(#unit[kg] dot #unit[m], dot #unit[s^2]) dot #unit[s]/#unit[m^2]
    = frac(M, L T)
$
$ [omega] = 1/#unit[s] = 1/T $
$ [Q] = frac(#unit[m^3], #unit[s]) = frac(L^3, T) $

Number of basic dimensions:
$ m = 3 $

==== Step 3
Determine the number of #sym.pi terms:
$ n - m = 6 - 3 = 3 $

==== Step 4
Select $m$ repeating variables:
$ "Select" rho, omega, D space ("given") $

==== Step 5
Form #sym.pi groups and make each #sym.pi group dimensionless:
$ pi_1 = Delta P rho^a omega^b D^c $
$ pi_2 = mu rho^a omega^b D^c $
$ pi_3 = Q rho^a omega^b D^c $

$
    pi_1 = Delta P rho^a omega^b D^c = frac(M, L T^3) (M/L^3)^a (1/T)^b L^c
    = #text(blue)[$M^(1 + a) L^(-1 - 3a + c) T^(-2 - b)$]
$
$
    cases(
        1 + a = 0,
        -1 - 3a + c = 0,
        -2 - b = 0,
    ) quad => quad cases(
        a = -1,
        b = -2,
        c = -2
    ) wide
    therefore pi_1 = frac(Delta P, rho omega^2 D^2)
$

The $pi_1$ group is known as the *head coefficient*:
$ C_H = frac(Delta P, rho omega^2 D^2) $

$
    pi_2 = mu rho^a omega^b D^c = frac(M, L T) (M/L^3)^a (1/T)^b L^c
    = #text(blue)[$M^(1 + a) L^(-1 - 3a + c) T^(-1 - b)$]
$
$
    cases(
        1 + a = 0,
        -1 - 3a + c = 0,
        -1 - b = 0,
    ) quad => quad cases(
        a = -1,
        b = -1,
        c = -2
    ) wide
    therefore pi_2 = frac(mu, rho omega D^2)
$

The $pi_2$ group is the *Reynolds number*, and it is expressed as:
$ "Re" = frac(rho omega D^2, mu) $

$
    pi_3 = Q rho^a omega^b D^c & = frac(L^3, T) (M/L^3)^a (1/T)^b L^c \
                               & = M^(a) L^(3 - 3a + c) T^(-1 - b)
$
$
    cases(
        a = 0,
        3 - 3a + c = 0,
        -1 - b = 0,
    ) quad => quad cases(
        a = -0,
        b = -1,
        c = -3
    ) wide
    therefore pi_3 = frac(Q, omega D^3)
$

The $pi_3$ group is known as the *flow coefficient*:
$ C_Q = frac(Q, omega D^3) $

==== Step 6
Express the final form as a relationship among the #sym.pi groups:
$
    frac(Delta P, rho omega^2 D^2)
    = f(frac(mu, rho omega D^2), frac(Q, omega D^3))
$

=== Part 2
Recall that the power gain by a fluid in a pump is expressed as:
$ dot(W)_"fluid" = rho g h_"pump" Q = Delta P Q $

If we express $dot(W)_"fluid"$ in terms of the non-dimensional #sym.pi groups:
$
    dot(W)_"fluid"
    = frac(Delta P, rho omega^2 D^2) rho omega^2 D^2
    frac(Q, omega D^3) omega D^3
$
$
                           dot(W)_"fluid" & = pi_1 rho omega^2 D^2
                                            pi_3 omega D^3 \
    frac(dot(W)_"fluid", rho omega^3 D^5) & = C_H C_Q
$

Since both $C_H$ and $C_Q$ are dimensionless, $C_H C_Q$ is dimensionless, hence:
$ pi = frac(dot(W)_"fluid", rho omega^3 D^5) $

This #sym.pi group is called the *power coefficient*:
$ C_P = frac(dot(W)_"fluid", rho omega^3 D^5) $

== Common dimensionless groups

=== Head coefficient ($C_H$)
$ C_H = frac(Delta P, rho omega^2 D^2) $

=== Flow coefficient ($C_Q$)
$ C_Q = frac(Q, omega D^3) $

=== Power coefficient ($C_P$)
$ C_P = frac(dot(W)_"fluid", rho omega^3 D^5) $

=== Drag coefficient ($C_d$)
$ C_d = frac(F_D, 1/2 rho V^2 L^2) $

#pagebreak()

=== Reynolds number (Re)
$ "Re" = frac(rho omega L, mu) $

- Reynolds number is the measure of the ratio of the inertia force to the
    viscous force.
- It is a criterion which distinguishes between laminar and turbulent flow.
    #cimage("./images/reynolds-number-flow.png")

=== Froude number (Fr)
$ "Fr" = frac(V, sqrt(g l)) $

- Froude number is a measure of the ratio of the inertia force to the
    gravitational force.
- It is important in flows with a free surface where gravity is dominant, such
    as flows in open channel, and the study of water flow around a ship.

=== Mach number (M)
$ "M" = V/c $

Where $c$ is the speed of sound, #qty[340][m s^-1].

- Mach number is a measure of the ratio of the inertial force to the
    compressibility force.
- It is important for high speed flows.
- When $"M" < 0.3$, the compressibility effect of the fluid can be neglected.

=== Strouhal number (St)
$ "St" = frac(omega L, V) $

Where $omega$ is the frequency of oscillation of the fluid in #unit[rad s^-1].

- Strouhal number is a measure of the ratio of the inertia force caused by
    unsteadiness (local acceleration), and the inertia force caused by a
    convective acceleration.
- It is important in unsteady, oscillating flow problems.

=== Euler number (Eu)
$ "Eu" = frac(Delta P, rho V^2) $

- Euler number is a measure of the ratio of the pressure to the inertia force.
- It is normally used in problems where the pressure or pressure difference
    between two points is an important variable.

#pagebreak()

=== Weber number (We)
$ "We" = frac(rho V^2 L, sigma) $

Where $sigma$ is the surface tension in #unit[N m^-1].

- Weber number is a measure of the ratio of the inertia force to the surface
    tension force.
- It is important when there is an interface between two fluids.
- In this situation, the surface tension may play an important role in the
    phenomenon of interest.

#pagebreak()

= Modelling and similitude studies
- A *model* (a scaled physical object), is designed and tested in laboratory
    conditions to predict the behaviour of a *prototype* (an actual physical
    object) at a reduced cost.
- The basic requirement in modelling is to achieve *similarity* between the
    model and its test conditions, and the prototype and its operating
    conditions.

== Theory of models
- Based on the principle of dimensional analysis, any physical problem can be
    described in terms of a set of #sym.pi terms as:
    $ pi_1 = f(pi_2, pi_3, ..., pi_n) $
- If the form of $f$ is the same for the model and the prototype, and the model
    is designed and operated under the conditions that:
    $
        (pi_2)_"model" & = (pi_2)_"prototype" \
        (pi_3)_"model" & = (pi_3)_"prototype" \
           dots.v wide & wide dots.v \
        (pi_n)_"model" & = (pi_n)_"prototype" \
    $


    Then, the measure value of $pi_1$ obtained with the model is equal to the
    corresponding $pi_1$ for the prototype, i.e.
    $ (pi_1)_"model" = (pi_1)_"prototype" $

=== Example 1
The drag force ($F_D$) exerted by wind on a structure depends on the wind speed
($V$), the width ($w$) and height ($h$) of the structure, and the density
($rho$) and viscosity ($mu$) of the air. You are assigned to estimate the drag
force exerted by the wind on a building (prototype) of $w_p = #qty[30][m]$ and
$h_p = #qty[60][m]$. Field measurement shows that the maximum wind speed in this
area is $V_p = #qty[5][m s^-1]$. You would like to design a building model of
height $h_m = #qty[6][m]$ and measure the drag force ($F_(D, m)$) exerted by air
in a wind tunnel.

+ Determine model width ($w_m$) and the wind speed ($V_m$) in the wind tunnel.
+ Explain how to estimate the drag force on the prototype ($F_(D, p)$).

Use $rho$, $V$ and $h$ as repeating variables. Assume same air properties in the
field and wind tunnel.

#cimage("./images/similitude-example-1.png", height: 15em)

==== Part 1
- Put all the given values in a table:
    #table(
        columns: 5,
        table.header(
            [],
            [*Width*\ $w$ (#unit[m])],
            [*Height*\ $h$ (#unit[m])],
            [*Wind speed*\ $V$ (#unit[m s^-1])],
            [*Drag force*\ $F_D$ (#unit[N])],
        ),
        [*Prototype*], [30], [60], [5], [?],
        [*Model*], [?], [6], [?], [?],
    )
- Apply dimensional analysis to obtain:
    $ frac(F_D, rho V^2 h^2) = f(w/h, frac(rho V h, mu)) $
- To ensure that $frac(F_D, rho V^2 h^2)$ is the same for both the model and the
    prototype, we need to design our model such that:
    $ w_m/h_m = w_p/h_p quad => quad w_m = frac(w_p, h_p) h_m = #qty[3][m] $
    $
        frac(rho_m V_m h_m, mu_m) = frac(rho_p V_p h_p, mu_p) quad
        => quad V_m = frac(rho_p V_p h_p, mu_p) frac(mu_m, rho_m h_m)
        = #qty[50][m s^-1]
    $

==== Part 2
- Once we obtain $F_(D, m)$ from the wind tunnel test, we can then estimate
    $F_(D, p)$ by using:
    $
        frac(F_(D, m), rho_m V_m^2 h_m^2) = frac(F_(D, p), rho_p V_p^2 h_p^2)
        quad => quad
        F_(D, p) = frac(rho_p V_p^2 h_p^2, rho_m V_m^2 h_m^2) F_(D, m)
    $

==== Similarities used
- When we equate the #sym.pi groups involving length ratios, such as:
    $ (w/h)_"model" = (w/h)_"prototype" $

    We are requiring that there is complete *geometric similarity* between the
    model and the prototype. Essentially, the two objects' shape must be
    similar.
- When we equate the #sym.pi groups involving the ratio of forces, such as the
    Reynolds number (defined as the ratio of the inertia force and the viscous
    force):
    $ (frac(rho V h, mu))_"model" = (frac(rho V h, mu))_"prototype" $

    We are requiring that there is complete *dynamic similarity* between the
    model and the prototype. Basically, the ratio of forces in the model and the
    prototype is the same.

#pagebreak()

=== Example 2
The pressure rise of a mixed flow pump prototype is studied by a model of
similar geometry. The prototype is running at $N_p = #qty[2500][rpm]$ delivers
sea water (density $rho_p = #qty[1025][kg m^-3]$ and viscosity
$mu_p = #qty[0.0011][Ns m^-2]$) at the flow rate $Q_p = #qty[1.2][m^3 s^-1]$.
The impeller diameter of the prototype is $D_p = #qty[120][cm]$. The model is
tested in fresh water (density $rho_m = #qty[1000][kg m^-3]$ and viscosity
$mu_m = #qty[0.0010][Ns m^-2]$) and runs at $N_m = #qty[5000][rpm]$. The
pressure head of this model pump is measured to be $H_m = #qty[2.4][m]$.

+ Find the flow rate of the model ($Q_m$).
+ The pressure head ($H_p$) and mechanical power input ($dot(M)_"mech"$) of the
    prototype pump. Assume complete similarity and 70% pump efficiency.

#cimage("./images/pump-types.png")
#pagebreak()

==== Part 1
- Put all the given values in a table:
    #table(
        columns: 3,
        table.header([], [*Prototype*], [*Model*]),

        [$N$ (#unit[rpm])], [2500], [5000],
        [$rho$ (#unit[kg m^-3])], [1025], [1000],
        [$mu$ (#unit[Ns m^-2])], [0.0011], [0.0010],
        [$D$ (#unit[cm])], [120], [?],
        [$Q$ (#unit[m^3 s^-1])], [1.2], [?],
        [$H$ (#unit[m])], [?], [2.4],
    )
- Apply dimensional analysis to obtain:
    $ frac(Delta P, rho N^2 D^2) = f(frac(rho N D^2, mu), frac(Q, N D^3)) $

    Since $Delta P = rho g H$:
    $
        frac(redcancel(rho) g H, redcancel(rho) N^2 D^2)
        = f(frac(rho N D^2, mu), frac(Q, N D^3))
    $
    $ frac(g H, N^2 D^2) = f(frac(rho N D^2, mu), frac(Q, N D^3)) $

- To ensure that $frac(g H, N^2 D^2)$ is the same for both the model and the
    prototype, the model pump follows:
    $
        frac(rho_m N_m D_m^2, mu_m) = frac(rho_p N_p D_p^2, mu_p)
        quad => quad
        D_m = sqrt(frac(rho_P N_p D_p^2, mu_p) frac(mu_m, rho_m N_m))
        = #qty[0.819][m]
    $
    $
        frac(Q_m, N_m D_m^3) = frac(Q_p, N_p D_p^3)
        quad => quad
        Q_m = frac(Q_p, N_p D_p^3) N_m D_m^3 = #qty[0.763][m^3 s^-1]
    $

==== Part 2
- The pressure head and mechanical power input of the prototype pump therefore
    follow:
    $
        frac(g H_m, N_m^2 D_m^2) = frac(g H_p, N_p^2 D_p^2)
        quad => quad
        H_p = (frac(N_p D_p, N_m D_m))^2 H_m = #qty[1.29][m]
    $
    $
        eta = frac("Useful power", "Input power")
        = frac(rho_p g H_p, dot(W)_"mech")
    $
    $ therefore dot(W)_"mech" = frac(rho_p g H_p Q_p, eta) = #qty[22.2][kW] $

#pagebreak()

=== Example 3
A 1:25 scale model is tested in a towing tank to quantify the drag force ($F_D$)
exerted by seawater on a prototype vessel of characteristic length
$L = #qty[400][m]$ cruising at $V = #qty[10][m s^-1]$. Assume the same seawater
is used in the towing tank.

+ Is it possible to achieve complete dynamic similarity between the model and
    prototype?
+ If the dynamic similarity based on Froude number is enforced and the measured
    drag force on the model is #qty[320][N], determine the drag force on the
    prototype.

Use water density $rho$, $V$ and $L$ as repeating variables.

==== Part 1
- Put all the given values in a table:
    #table(
        columns: 3,
        table.header([], [*Prototype*], [*Model*]),

        [$L$ (#unit[m])], [400], [16],
        [$V$ (#unit[m s^-1])], [10], [?],
        [$F_D$ (#unit[N])], [?], [?],
    )
- Apply dimensional analysis to obtain:
    $
        underbrace(frac(F_D, rho V^2 L^2), "Dimensionless drag force")
        = f(
            underbrace(frac(rho V L, mu), "Reynolds number (Re)"),
            underbrace(frac(V, sqrt(g L)), "Froude number (Fr)")
        )
    $
- To ensure complete dynamic similarity, the model vessel should satisfy both:
    $
        frac(rho_m V_m L_m, mu_m) = frac(rho_p V_p L_p, mu_p)
        quad => quad
        V_m = frac(rho_p mu_m, rho_m mu_p) frac(L_p, L_m) V_p
        = #qty[250][m s^-1]
    $
    $
        frac(V_m, sqrt(g L_m)) = frac(V_p, sqrt(g L_p))
        quad => quad
        V_m = sqrt(L_m/L_p) V_p = #qty[2][m s^-1]
    $

    Since the $V_m$ obtained from the Reynolds number and the Froude number are
    not the same, they are contradictory and it is *impossible* to achieve
    *complete dynamic similarity*.

==== Part 2
- Experiments have found that at very high Reynolds number (in the completely
    turbulent region), the drag force is independent of Re.
- Hence, enforcing Froude number to be the same between the model and the
    prototype, we obtain:
    $
        frac(V_m, sqrt(g L_m)) = frac(V_p, sqrt(g L_p))
        quad => quad
        V_m = sqrt(L_m/L_p) V_p = #qty[2][m s^-1]
    $
- To estimate the drag force on the prototype vessel, we use:
    $
        frac(F_(D, m), rho_m V_m^2 L_m^2) = frac(F_(D, p), rho_p V_p^2 L_p^2)
        quad => quad
        F_(D, p) = frac(rho_p V_p^2 L_p^2, rho_m V_m^2 L_m^2) F_(D, m)
        = #qty[5000][kN]
    $

== Types of similarities

=== Geometric similarity
Similar geometry or similar shape.

=== Dynamic similarity
Similar force ratio.

=== Kinematic similarity
- Kinematic similarity states that the streamline patterns between the model and
    the prototype will be the same, and that corresponding velocity ratios and
    acceleration ratios are constant throughout the flow field.
- In short, similar stream line pattern, similar velocity ratio and acceleration
    ratio.
- This similarity is automatically satisfied when both *geometric* and *dynamic*
    similarity can be satisfied at the *same time*.

#cimage("./images/similitude-kinematic-similarity.png")

$
    frac((V_A)_"model", (V_A)_"prototype")
    = frac((V_B)_"model", (V_B)_"prototype")
    = frac((V_C)_"model", (V_C)_"prototype")
    = "Constant"
$

=== Complete similarity
Complete similarity refers to the situation where *geometric similarity* and
*dynamic similarity*, and hence *kinematic similarity* can be satisfied at the
*same time*.

=== Incomplete similarity
Incomplete similarity usually refers to a situation where *dynamic similarity*
cannot be achieved due to a conflict between two #sym.pi groups.

= Viscous flow in pipes

== Reynolds number (Re)
Reynolds number is the ratio of the inertia force to the viscous force.
$ "Re" = frac(rho V_"avg" D, mu) $

== Inviscid flow in pipes
Inviscid flow has a uniform velocity profile.
#cimage("./images/inviscid-flow-in-pipes.png")

== Viscous flow in pipes
Assuming no-slip on the pipe wall, $V_"wall" = 0$. The flow profile depends on
the Reynolds number (Re).
#cimage("./images/viscous-flow-in-pipes.png")
#pagebreak()

== Entrance region and fully developed flow
#cimage("./images/entrance-region-and-fully-developed-flow.png")

For most practical engineering problems with $10^4 < "Re" < 10^5$:
$ 20 D < L_e < 30 D $

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - For laminar flow:
            $ frac(L_e, D) = 0.06 "Re" $
        - For turbulent flow:
            $ frac(L_e, D) = 4.4 "Re"^(1/6) $
    ],
    image("./images/entrance-region-graph.png"),
)

== Fully developed turbulent flow in circular pipes
#cimage("./images/fully-developed-turbulent-flow-in-circular-pipes.png")
#pagebreak()

== Formulas

=== Flow related
#table(
    columns: (auto, 17em, 16em),
    align: (left + horizon, center + horizon, center + horizon),
    table.header(
        [],
        [*Laminar flow (Re #sym.lt.eq 2100)*],
        [*Turbulent flow (Re > 4000)*],
    ),

    [*Pressure drop vs shear stress*],
    table.cell(colspan: 2)[
        $ frac(Delta P, l) = - frac(2 tau, r) - rho g frac(Delta z, l) $
    ],

    [*Velocity profile*],
    $ V = frac((Delta P + rho g Delta z) D^2, 16 mu l) [1 - (frac(2 r, D))^2] $,
    $ overline(V) = V_c (1 - frac(2 r, D))^(1/n) $,

    [*Centreline velocity*],
    $ V_c = frac((Delta P + rho g Delta z) D^2, 16 mu l) $,
    [N.A.],

    [*Averaged velocity*],
    $ V_"avg" = 1/2 V_c = frac((Delta P + rho g Delta z) D^2, 32 mu l) $,
    $ V_"avg" = 2 V_c frac(n^2, (n + 1) (2n + 1)) $,

    [*Volume flow rate*],
    $ Q = frac((Delta P + rho g Delta z) pi D^4, 128 mu l) $,
    $ Q = 2 V_c (frac(pi D^2, 4)) frac(n^2, (n + 1) (2n + 1)) $,

    [*Shear stress*],
    $ tau = mu frac(dif V, dif r) = - frac((Delta P + rho g Delta z) r, 2 l) $,
    $ tau = mu frac(dif overline(V), dif r) + tau_"turb" $,
)

Always follow the flow direction, and use Point 1 (initial) - Point 2 (final):
$ Delta P = P_1 - P_2 $
$ Delta z = z_1 - z_2 $

=== Major loss in a pipe ($h_(L, "major")$)
The major loss in a pipe is defined as:
$ h_(L, "major") = frac(Delta P, rho g) = f l/D frac(V_"avg"^2, 2 g) $

Where:
- $f$ is the friction factor
- $V_"avg"$ is the average flow velocity in the control volume

#pagebreak()

=== Friction factor ($f$)
The Moody chart used to figure out the friction factor:
#cimage("./images/moody-chart.png")

==== Laminar flow
$ f = 64/"Re" $

Where Re is the Reynolds number.

#pagebreak()

==== Turbulent flow
Use the Colebrook formula:
$ 1/sqrt(f) = -2.0 log (frac(epsilon/D, 3.7) + frac(2.51, "Re" sqrt(f))) $

For the case of a smooth pipe ($epsilon = 0$) and Re < $10^5$, use the Blasius
formula:
$ f = frac(0.316, "Re"^(1/4)) $

Where
- Re is the Reynolds number
- $epsilon$ is the surface roughness, which measures the vertical deviations of
    a pipe surface from the mean height.

#cimage("./images/surface-roughness.png")
#pagebreak()

=== Minor loss in a pipe ($h_(L, "minor")$)
Minor loss in a pipe is defined as:
$ h_(L, "minor") = K_L frac(V_"larger"^2, 2g) $

Where:
- $K_L$ is the loss coefficient
- $V_"larger"$ is the *larger velocity* between the two pipes

==== Entrance loss (tank into pipe)
<entrance-loss>
#grid(
    columns: 3 * (1fr,),
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,

    figure(
        image("./images/entrance-loss-re-entrant.png"),
        caption: $ "Re-entrant:" K_L = 0.8 $,
    ),

    figure(
        image("./images/entrance-loss-sharp-edged.png"),
        caption: $ "Sharp-edged:" K_L = 0.5 $,
    ),

    figure(
        image("./images/entrance-loss-rounded.png"),
        caption: $ "Rounded:" K_L < 0.5 $,
    ),
)

#figure(
    image("./images/entrance-region-graph.png"),
    caption: [
        Larger rounding of the lip reduces or eliminates the vena contracta
        effect, and the entrance loss is reduced, i.e. $K_L$ is smaller.
    ],
)

#pagebreak()

==== Exit loss (pipe into tank)
<exit-loss>
$ K_L = 1.0 $

#cimage("./images/exit-loss.png")

- When fluid flow in a pipe enters into a tank, the entire kinetic energy of the
    exiting fluid is dissipated as it mixes with the fluid in the tank.
- *$K_L = 1.0$ regardless of the exit flow conditions*.

#pagebreak()

==== Sudden expansion
$ K_L = (1 - A_1/A_2)^2 $

Where:
- $A_1$ is the area of the *smaller pipe*
- $A_2$ is the area of the *larger pipe*

#cimage("./images/minor-loss-sudden-expansion-diagram.png")
#cimage("./images/minor-loss-sudden-expansion-graph.png")

- If $A_1 = A_2$, there is no change in the pipe diameter, and hence:
    $ K_L = 0 $
- If $A_1 << A_2$, $K_L$ is the same as the #link(<exit-loss>)[exit loss (pipe
        into tank)]:
    $ K_L = 1.0 $

==== Sudden contraction
#cimage("./images/minor-loss-sudden-contraction.png", width: 85%)

- If $A_1 = A_2$, there is no change in the pipe diameter, and hence:
    $ K_L = 0 $
- If $A_1 >> A_2$, $K_L$ is the same as the #link(<entrance-loss>)[entrance loss
        (tank into pipe)]:
    $ K_L = 0.5 $

==== Conical diffuser and conical contraction
- A *conical diffuser* is a device shaped to decelerate a fluid.
    #cimage("./images/minor-loss-conical-diffuser-graph.png", width: 85%)
- A *conical contraction* is also known as a nozzle, which reverse the flow
    direction of a conical diffuser and accelerates a fluid. THe typical loss
    coefficient ranges from $K_L = 0.02$ for $theta = 30 degree$ to $K_L = 0.07$
    for $theta = 60 degree$.

#pagebreak()

==== Pipe bends

#grid(
    columns: 3,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,

    grid.header(
        [*$90 degree$ mitered bend*],
        [*$45 degree$ elbow*],
        [*$180 degree$ elbow*],
    ),

    figure(
        image("./images/minor-loss-pipe-bend-90-degrees.png"),
        caption: $ K_L = 1.1 $,
    ),
    image("./images/minor-loss-pipe-bend-45-degree-elbow.png"),
    image("./images/minor-loss-pipe-bend-180-degree-return-bend.png"),
)
- $90 degree$ elbow:
    #cimage("./images/minor-loss-pipe-bend-90-degrees-elbow.png", width: 95%)

=== Hydraulic diameter ($D_h$)
$ D_h = frac(4 A, P) $

Where:
- $A$ is the cross-sectional area
- $P$ is the wetted perimeter of the non-circular pipe

==== Rectangular duct
#cimage("./images/rectangular-duct.png")

$ D_h = frac(4 A, P) = frac(4 w h, 2 (w + h)) = frac(2 w h, w + h) $

Replace the $D$ in the relevant formulas with $D_h$:
$ "Re" = frac(rho V D_h, mu) $
$ h_L = f l/D_h frac(V^2, 2 g) $
$ "Relative surface roughness" = epsilon/D_h $

#pagebreak()

== Grade lines
#cimage("./images/grade-lines.png")

=== Energy grade line (EGL)
<energy-grade-line>
Energy grade line (EGL) traces the total head available to the fluid.

$ "EGL" = frac(P, rho g) + frac(V^2, 2 g) + z $

Points to note:
+ *Pumps and minor losses* are represented with *vertical lines*.
+ The start and end points of the EGL must make sense for the system being
    analysed.

    If the start point is 0, and the end point is #qty[4][m] above, then the EGL
    must end at #qty[4][m].
+ The *gradient* of the lines due to the major loss in pipes must *correspond to
    the actual values*.

=== Hydraulic grade line (HGL)
Hydraulic grade line (HGL) measures the sum of the pressure head and the
elevation head available to the fluid.

$ "HGL" = frac(P, rho g) + z $
$ "HGL" = "EGL" - frac(V^2, 2 g) $

Points to note:
+ All the same points as the #link(<energy-grade-line>)[energy grade line
        (EGL)].
+ The *difference* between the EGL and the HGL must correspond to the *velocity
    in each of the pipes*.
+ For minor losses due to *sudden expansion*, the HGL must *recover*, i.e.
    *increase*.

== Multiple pipe system

=== Pipes in series
#cimage("./images/multiple-pipes-series.png")

- Volume flow rate:
    $ Q = Q_1 = Q_2 = Q_3 $
- Total head loss:
    $ h_(L, "total") = sum h_(L, "major") + sum h_(L, "minor") $

=== Pipes in parallel
#cimage("./images/multiple-pipes-parallel.png")

- Volume flow rate:
    $ Q = Q_1 + Q_2 + Q_3 $
- Total head loss:
    $
        h_L & = h_(L, "major" 1) + sum h_(L, "minor" 1) \
            & = h_(L, "major" 2) + sum h_(L, "minor" 2) \
            & = h_(L, "major" 3) + sum h_(L, "minor" 3)
    $

#pagebreak()

== Example 1
Oil (density $rho = #qty[900][kg m^3]$ and dynamic viscosity $mu = #qty[0.4][Ns
    m^2]$) flows downwards in a #qty[50][mm] diameter pipe inclined at the angle
$theta = 30 degree$. The steady-state centerline velocity of the flow is $V_c
= #qty[2][m s^-1]$. Determine the Reynolds number and the pressure drop per unit
length ($frac(Delta P, l)$).

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        $ V_"avg" = 0.5 V_c = #qty[1][m s^-1] $
        $ "Re" = frac(rho V_"avg" D, mu) = 112.5 $

        For laminar flow (Re < 2100):
        $ V_c = frac((Delta P + rho g Delta z) D^2, 16 mu l) $
        $ frac(Delta P, l) = frac(16 mu V_c, D^2) - frac(rho g Delta z, l) $
    ],
    image("./images/viscous-flow-in-pipes-example-1.png"),
)

Let $l$ be the distance from Point 1 (initial) to Point 2 (final). Recalling
that $Delta z = z_1 - z_2$, we have
$frac(Delta z, l) = frac(z_1 - z_2, l) = sin 30 degree$. Therefore:
$
    frac(Delta P, l) = frac(16 mu V_c, D^2) - rho g sin 30 degree
    = #qty[705.5][Pa m^-1]
$

== Example 2
Oil (density $rho = #qty[900][kg m^3]$ and dynamic viscosity $mu = #qty[0.8][Ns
    m^2]$) flows steadily through a horizontal pipe (length $l = #qty[40][m]$
and diameter $D = #qty[5][cm]$). If the magnitude of the shear stress on the
pipe wall is $tau_w = #qty[202.5][N m^2]$. Determine the volume flow rate in the
pipe ($Q$).

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        Let $l = #qty[40][m]$ be the distance from Point 1 (initial) and Point 2
        (final):
        $
            frac(Delta P, l) = - frac(2 tau, r)
            - redcancel(rho g frac(Delta z, l))
        $
        $
            Delta P = - frac(2 l tau, r)
            = - frac(2 times 40 times -202.5, 0.05/2)
            = #qty[648][kPa]
        $

        Assuming the flow is laminar, we have:
        $
            Q = frac((Delta P + redcancel(rho g Delta z)) pi D^4, 128 mu l)
            = 3.11 times 10^(-3) #unit[m^3 s^-1]
        $

        But, we must verify our laminar flow assumption:
        $
            "Re" = frac(rho V_"avg" D, mu) = frac(rho Q D, mu frac(pi D^2, 4))
            = 89 < 2100 space ("Verified")
        $
    ],
    image("./images/viscous-flow-in-pipes-example-2.png"),
)

Note that the shear stress $tau$ is always negative as it is opposite to the
flow direction.

== Example 3
Water (density $rho = #qty[1000][kg m^3]$ and viscosity $mu = #qty[0.001][Ns
    m^2]$) flows steadily in a horizontal pipe of diameter $D = #qty[0.5][m]$.
If the volume flow rate of the water $Q = #qty[0.1][m^3 s^-1]$, determine the
centreline velocity in the pipe.

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        Reynolds number:
        $
            "Re" = frac(rho V_"avg" D, mu) & = frac(
                                                 rho Q D,
                                                 mu frac(pi D^2, 4)
                                             ) \
                                           & = 2.55 times 10^5
                                             space ("Turbulent flow")
        $

        Find $n$ from the graph:
        - At $"Re" = 2.55 times 10^5, n = 7.6$.

        Find the centreline velocity:
        $ Q = 2 V_c (frac(pi D^2, 4)) frac(n^2, (n + 1) (2n + 1)) $
        $
            V_c = frac(Q (n + 1) (2n + 1), 2 n^2 (frac(pi D^2, 4)))
            = #qty[0.614][m s^-1]
        $
    ],
    image("./images/viscous-flow-in-pipes-example-3.png"),
)

== Example 4
Water flows steadily from Reservoir A to Reservoir B through a horizontal pipe.
Both reservoirs are exposed to the atmosphere. The pipe entrance and exit are
sharp-edged. Determine the volume flow rate in the pipe.

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    image("./images/viscous-flow-in-pipes-example-4.png"),
    table(
        columns: 2,
        table.header([], [*Pipe 1*]),

        [Length ($l$)], qty[100][m],
        [Diameter ($D$)], qty[0.1][m],
        [Frictional factor ($f$)], [0.02],
    ),
)

Apply the energy equation from section A to B:
$
    redcancel(frac(P_A, rho g)) + redcancel(frac(V_A^2, 2g)) + z_A
    - f l/D frac(V_1^2, 2g) - K_(L, "entrance") frac(V_1^2, 2 g)
    - K_(L, "exit") frac(V_1^2, 2 g)
    = redcancel(frac(P_B, rho g)) + redcancel(frac(V_B^2, 2g)) + z_B
$

$
    Q = V_1 A = frac(pi D^2, 4) sqrt(
        frac(
            2g (z_A - z_B),
            f l/D + K_(L, "entrance") + K_(L, "exit")
        )
    ) = #qty[0.0106][m^3 s^-1]
$

#pagebreak()

== Example 5
Water is driven by a pump and transferred steadily from a reservoir through
three pipes connected in series. Both the reservoir and exit of Pipe 2 are
exposed to the atmosphere. The pump head is #qty[12][m] and $K_L$ at the pipe
entrance and pipe bend are 0.6 and 0.3, respectively. If the flow rate in this
pipe system is $Q = #qty[0.05][m^3 s^-1]$, (a) determine the diameter of pipe 3
and (b) sketch EGL and HGL. Both major and minor losses should be considered.

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    image("./images/viscous-flow-in-pipes-example-5.png"),
    table(
        columns: 4,
        table.header([], [*Pipe 1*], [*Pipe 2*], [*Pipe 3*]),

        $l$, qty[20][m], qty[10][m], qty[10][m],
        $D$, qty[0.25][m], qty[0.10][m], [?],
        $f$, [0.02], [0.03], [0.03],
    ),
)

=== (a)
Applying the energy equation from section A to section B
$
    redcancel(frac(P_A, rho g)) + redcancel(frac(V_A^2, 2 g)) + z_A
    - K_(L, "entrance") frac(V_1^2, 2 g) - f_1 l_1/D_1 frac(V_1^2, 2g)
    - K_(L, "bend") frac(V_1^2, 2g) + h_p - f_2 l_2/D_2 frac(V_2^2, 2g)
    - f_3 l_3/D_3 frac(V_3^2, 2g)
    = redcancel(frac(P_B, rho g)) + redcancel(frac(V_B^2, 2 g)) + z_B
$

Where:
$ Q = frac(pi D_1^2, 4) V_1 = frac(pi D_2^2, 4) V_2 = frac(pi D_3^2, 4) V_3 $

Minor loss due to sudden expansion:
$ K_(L, "se") = (1 - A_2/A_3)^2 = (1 - D_2^2/D_3^2)^2 $

Solving for $D_3$ using an iterative method:
$ D_3 = #qty[0.160][m] $

#pagebreak()

=== (b)
$ l_1 = #qty[20][m], quad D_1 = #qty[0.25][m], quad f_1 = 0.02 $
$ l_2 = #qty[20][m], quad D_2 = #qty[0.20][m], quad f_2 = 0.03 $
$ l_3 = #qty[30][m], quad D_3 = #qty[0.339][m], quad f_3 = 0.03 $

#cimage("./images/viscous-flow-in-pipes-example-5-grade-lines.png")

Pay attention to:
- The magnitude of the slope:
    $
        f_2/D_2 frac(V_2^2, 2 g) > f_3/D_3 frac(V_3^2, 2 g)
        > f_1/D_1 frac(V_1^1, 2 g)
    $
- The gap between the EGL and the HGL:
    $ frac(V_2^2, 2g) > frac(V_3^2, 2g) > frac(V_1^2, 2g) $
- Initial and final points of the EGL and HGL:
    $ z_A - z_B < 0 $

#pagebreak()

= Turbomachines
#grid(
    columns: 2,
    column-gutter: 2em,

    image("./images/turbomachines-pumps.png"),
    [
        - *Pumps add energy* to the fluid.
        - Examples include fans, compressors, propellers, etc.
        - The pump *raises the pressure* of the fluid so it has more energy to
            travel further, but does not change the volume flow rate or fluid
            velocity
    ],

    image("./images/turbomachines-turbines.png"),
    [
        - *Turbines extract energy* from the fluid.
        - Examples include wind turbines, water turbines, gas turbines, etc.
        - An example is a hydro-electric power plant.
    ],
)

== Pumps

=== Axial flow pumps
#grid(
    columns: (1fr, 1fr),

    [
        Characteristics:
        - Straight through (axial)
        - *High flow rate*
        - *Low pressure rise*

        Typical use:
        - Cooling systems like PC fans, HVAC.
        - Ventilation
        - Wind tunnels
    ],
    image("./images/turbomachines-axial-flow-pumps.png", height: 16em),
)

=== Centrifugal flow pumps
#grid(
    columns: (1fr, 1fr),

    [
        Characteristics:
        - Perpendicular (radial)
        - *Moderate flow rate*
        - *High pressure rise*

        Typical use:
        - Water supply systems
        - Chemical transport
        - Oil and gas pipelines
    ],
    image("./images/turbomachines-centrifugal-pumps.png", height: 16em),
)

=== Energy equation
$
    underbrace(
        (frac(P, rho g) + frac(V^2, 2g) + z)_"in",
        #text[Energy head *entering* \ the control volume]
    ) + underbrace(h_"in", #text[Head \ gain])
    - underbrace(h_(L, "total"), #text[Total \ head loss])
    = underbrace(
        (frac(P, rho g) + frac(V^2, 2g) + z)_"out",
        #text[Energy head *leaving* \ the control volume]
    )
$

=== Pump head and power
#cimage("./images/turbomachines-pump-head-and-power.png")

The head developed across the pump, $h_p$, $h_a$, or $H$, is given as
$ h_p = frac(P_2 - P_1, rho g) + frac(V_2^2 - V_1^2, 2g) + z_2 - z_1 $

Power gained by the fluid is:
$ P_f = rho g Q h_p space (#unit[Watts]) $

Where:
- $P_2$ and $P_1$ are the final and initial pressures respectively
- $V_2$ and $V_1$ are the final and initial velocities respectively
- $z_2$ and $z_1$ are the final and initial heights respectively
- $rho$ is the density of the fluid
- $g$ is the gravitational acceleration
- $Q$ is the volumetric flow rate
- $h_p$ is the pump head

=== Efficiency
The effiicency of a pump is given by:
$
    eta = frac(
        #text(red)[Power gained by the fluid],
        "Shaft power driving the pump"
    ) = frac(P_f, W_"shaft") = frac(rho g Q h_p, W_"shaft")
$

=== Pump performance curve
#cimage("./images/turbomachines-pump-performance-curve.png")

Points to take note:
- Shutoff head
- Maximum efficiency
- Different rotational speeds have different pump curves

#pagebreak()

=== Pumps in series
Follow the same rules as resistance in series in electrical circuits, with
volumetric flow rate ($Q$) replacing current ($I$) and head ($H$) replacing
voltage ($V$).

The volumetric flow rate through the pumps is the same:
$ Q = Q_1 = Q_2 = Q_3 = dots.c $

The head provided by the pumps is:
$ H = H_1 + H_2 + dots.c + H_n $

For two identical pumps in series:
#cimage("./images/turbomachines-pumps-in-series.png")

==== Example
#cimage("./images/turbomachines-pumps-in-series-example.png")
$
    frac(P_1, rho g) + frac(V_1^2, 2g) + z_1 + h_s - h_"losses"
    = frac(P_2, rho g) + frac(V_2^2, 2g) + z_2
$

For two identical pumps in series:
$ 2 h_p = 2 (20 - 10 Q^2) = 40 - 20 Q^2 $
$ h_s = 2 h_p $

=== Pumps in parallel
Follow the same rules as resistance in parallel in electrical circuits, with
volumetric flow rate ($Q$) replacing current ($I$) and head ($H$) replacing
voltage ($V$).

The total volumetric flow rate of pumps in parallel is:
$ Q = Q_1 + Q_2 + Q_3 + dots.c $

Head provided by pumps in parallel is the same:
$ H = H_1 = H_2 = H_3 = dots.c $

For two identical pumps in parallel:
#cimage("./images/turbomachines-pumps-in-parallel.png")
#cimage("./images/turbomachines-pumps-in-parallel-graph.png")

==== Example
#cimage("./images/turbomachines-pumps-in-parallel-example.png")

$
    frac(P_1, rho g) + frac(V_1^2, 2g) + z_1 + h_s - h_"losses"
    = frac(P_2, rho g) + frac(V_2^2, 2g) + z_2
$

For two pumps in parallel:
$ H_s = 20 - 10 (Q/2)^2 = 20 - 2.5 Q^2 $

=== Dimensional analysis
There are 3 dimensionless parameters that are of vital importance in the design
and performance of pumps (given in exam):
- Flow coefficient ($C_Q$):
    $
        C_Q = frac(Q, omega D^3)
        #h(5em) (frac(Q, omega D^3))_1 = (frac(Q, omega D^3))_2
    $
- Head coefficient ($C_H$):
    $
        C_H = frac(g H, omega^2 D^2)
        #h(5em) (frac(g H, omega^2 D^2))_1 = (frac(g H, omega^2 D^2))_2
    $
- Power coefficient ($C_P$):
    $
        C_P = frac(W, rho omega^3 D^5)
        #h(5em) (frac(W, rho omega^3 D^5))_1 = (frac(W, rho omega^3 D^5))_2
    $

Note the hidden factors for *similitude* that are not included below.
- Reynolds number (Re):
    $
        "Re" = frac(rho V D, mu) = frac(rho omega D^2, 2 mu)
        #h(5em) (frac(rho omega D^2, mu))_1 = (frac(rho omega D^2, mu))_2
    $
- Efficiency ($eta$):
    $
        eta = frac(P_f, W_"shaft") = frac(rho g Q h_p, W_"shaft")
        #h(5em) (rho g Q h_p)_1 = (rho g Q h_p)_2
    $

Try using the above when the pump coefficients are insufficient for solving the
question. Additionally, list out all the variables in the question to make it
easy to identify which variables are unknown.

== Turbines

=== Impulse turbine
#grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,

    [
        Characteristics:
        - *High-speed jet*
        - Blades change the direction of the flow
        - Energy transfer is purely kinetic

        Typical use:
        - *High pressure difference*
        - *Low flow rate*
    ],
    image("./images/turbomachines-impulse-turbines.png", height: 23em),
)

=== Reaction turbine
#grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,

    [
        Characteristics:
        - *Pressure and velocity*
        - Energy transfer is pressure and kinetic energy

        Typical use:
        - *Large flow rates*
        - *Low to medium head*
        - Wind turbines
        - Gas turbines
    ],
    image("./images/turbomachines-reaction-turbines.png", height: 23em),
)

=== Energy equation
$
    underbrace(
        (frac(P, rho g) + frac(V^2, 2g) + z)_"in",
        #text[Energy head *entering* \ the control volume]
    ) + underbrace(h_"in", #text[Head \ gain])
    - underbrace(h_(L, "total"), #text[Total \ head loss])
    = underbrace(
        (frac(P, rho g) + frac(V^2, 2g) + z)_"out",
        #text[Energy head *leaving* \ the control volume]
    )
$

#pagebreak()

= Pump and system match

== System curve
Apply the energy equation to find the system curve.

$
    frac(P_1, rho g) + frac(V_1^2, 2 g) + z_1 + h_s - h_"losses"
    = frac(P_2, rho g) + frac(V_2^2, 2g) + z_2
$

Re-arranging:
$
    h_s = (z_2 - z_1) + underbrace(
        [f l/d frac(V^2, 2g) + sum K frac(V^2, 2g)],
        h_"losses"
    ) = (z_2 - z_1) + (f l/d + sum K) (frac(V^2, 2g)
$

Substituting $V = Q/A$:
$
    h_s & = (z_2 - z_1) + (f l/d + sum K) (frac((Q/A)^2, 2g)) \
        & = (z_2 - z_1) + (f l/d + sum K) (frac(Q^2, 2g A^2)) \
        & = underbrace((z_2 - z_1), Z_2 - Z_1)
          + underbrace((frac(f l/d + sum K, 2g A^2)), B) (Q^2) \
        & = Z_2 - Z_1 + B Q^2
$

The system curve is:
$ h_s = Z_2 - Z_1 + B Q^2 $

When the volumetric flow rate ($Q$) increases, the system head ($h_s$)
increases.

#pagebreak()

=== Increasing the system head
Increasing the system head will cause the system curve to shift upwards.

#cimage("./images/system-curve-shift-up-diagram.png")

== Pump curve
#cimage("./images/pump-curve.png", width: 75%)

The pump curve general form is:
$ h_p = Delta Z - A Q^2 $

Where:
- $Delta Z$ is the shutoff head, which is when $Q = 0$

When the volumetric flow rate ($Q$) increases, the pump head ($h_p$) decreases.

== Operating point
The operating point is when the system curve is equal to the pump curve, i.e.
$ h_p = h_s $
$ Delta Z - A Q^2 = (Z_2 - Z_1) + B Q^2 $

Steps:
+ Use the energy equation to calculate the system curve.
+ Equate the system curve and pump curve to get the volume flow rate.
+ From the volume flow rate, recalculate the pump head.

#cimage("./images/operating-point.png")
#pagebreak()

= Cavitation
- Cavitation refers to the formation of vapour cavities.
- This happens when the *local pressure drops below the vapour pressure of the
    liquid*.
- These cavities collapse when they reach regions of higher pressure.
    - At higher velocities, the pressure drops due to the Bernoulli effect.
    - If the pressure drops below the vapour pressure, *local boiling* occurs.
    - The *local boiling* results in *vapour bubbles*.
    - When the pressure recovers, the bubbles collapse violently.

#figure(
    image("./images/cavitation-damage.png"),
    caption: [
        In turbines or propellers, eliminating cavitation is necessary to avoid
        such damage.
    ],
)

== Cavitation in pipe flows
#cimage("./images/cavitation-in-pipe-flows.png")

- Apply the energy equation from A to B:
    $
        frac(P_A, rho g) + frac(V_A^2, 2 g) + z_A - h_L
        frac(P_B, rho g) + frac(V_B^2, 2 g) + z_B
    $
- Get $P_B$ and check its value with $P_v$:

    Cavitation occurs *if $P_B < P_v$*.

- Note that all the pressure values should be *#text(red)[absolute] pressure*.

== Net positive suction head ($N P S H$)
The net positive suction head at any point in a flow system is the *#text(
    red,
)[absolute] total pressure* over and above the vapour pressure of the liquid in
the unit of head.

$ N P S H = frac(P_s - P_v, rho g) + frac(V_s^2, 2 g) $

Where:
- $N P S H$ is the net positive suction head
- $P_s$ is the pressure at the *pump suction or inlet*
- $V_s$ is the velocity at the *pump suction or inlet*
- $P_v$ is the vapour pressure

=== Net positive suction head available (NPSH#sub[A])
#cimage("./images/npsh-a.png")

$ N P S H_A = frac(P_s - P_v, rho g) + frac(V_s^2, 2 g) $

Apply the energy equation between the suction surface (1) to the pump suction
(2):
$
    frac(P_"atm", rho g) redcancel(+ frac(V_1^2, 2 g)) + z_1 - h_L
    = frac(P_s, rho g) + frac(V_s^2, 2 g) + z_s
$

Subtracting $frac(P_v, rho g)$ on both sides:
$
    frac(P_"atm", rho g) + (- frac(P_v, rho g)) + z_1 - h_L
    = underbrace(
        frac(P_s, rho g) + (- frac(P_v, rho g)) + frac(V_s^2, 2 g),
        N P S H_A
    ) + z_s
$

Combining the equation for $N P S H_A$ and the energy equation:
$ N P S H_A = frac(P_"atm" - P_v, rho g) + (z_1 - z_s) - h_L $

$N P S H_A$ is a characteristic of the *system*. Hence, the location of the pump
($z_s$) and the head loss ($h_L$) is important.

=== Net positive suction head required ($N P S H_R$)
- As the net positive suction head available decreases, a point is reached where
    cavitation appears on the solid surface in contact with the liquid stream.
- The value of $N P S H$ corresponding to the first appearance of vapour
    bubbles, i.e. to the first measurable drop in pump performance, or the onset
    of noise attributed to cavitation, is called the required $N P S H$ or
    $N P S H_R$
- $N P S H_R$ is a characteristic of a machine and its operating conditions,
    which is provided by the manufacturer.
- Hence, *to avoid cavitation*:
    $ N P S H_A >= N P S H_R $
