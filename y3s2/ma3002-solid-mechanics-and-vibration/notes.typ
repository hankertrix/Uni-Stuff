#set page(numbering: "1")
#set heading(numbering: "1.1")
#show link: text.with(blue)
#{
    set document(
        title: "MA3002 Solid Mechanics and Vibration Notes",
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
#let bmat = math.mat.with(delim: "[")
#let cvec = math.vec.with(delim: "{")
#let labelled_equation(content, label) = math.equation(
    block: true,
    numbering: _ => ("(", str(label), ")").join(""),
    content,
)
#let makegreen(content) = text(rgb("#47d45a"), content)
#let makeblue(content) = text(rgb("#46b1e1"), content)
#let makepurple(content) = text(rgb("#7030a0"), content)
#let makered(content) = text(red, content)
#let fillcolour(colour, content) = box(fill: colour, inset: 0.5em, content)
#let fillgreen(content) = fillcolour(rgb("#47d45a"), content)
#let fillblue(content) = fillcolour(rgb("#46b1e1"), content)
#let fillred(content) = fillcolour(red, content)
#let fillblack(content) = fillcolour(black, text(white, content))

= Definitions

== Work done ($W$)
The *work done* by *$P$* is a function of the force acting through distance $x$:
$ W = integral P thin dif x $

== Virtual work
*Virtual work* is defined as the work done by force *$P$* moving through the
*virtual displacement* $delta x$:
$ delta W = P delta x $

Virtual work is *imaginary*, and *does not necessarily follow* the direction of
the force.

== Virtual strain energy
- All *work done* by the external force becomes *internal energy* of the spring.
- The *strain energy* of the spring is a function of the spring stiffness $k$
    and elongation $e$.
    $ U = integral k e thin dif e $
- By disturbing the system, some *virtual work* was done, which contributes to
    the *virtual internal energy* of the spring.
- The *virtual strain energy* is the spring force multiplied by the *virtual
    elongation* $delta e$:
    $ delta U = F delta e $

#pagebreak()

== Principle of virtual displacements (PVD)
The principle of virtual displacements is:

#align(center)[
    "When a set of rigid bodies that are in equilibrium under the action of a
    set of external forces is subjected to virtual rigid body displacements that
    are consistent with the geometric constraints of the system, then the total
    virtual work done by all the external forces is zero."
]

Essentially:
$ delta W = 0 $

=== Conditions
+ Rigid bodies are required, means there is *no deformation and deflection*. The
    beam or bar cannot bend or stretch.
+ External forces must be in equilibrium.
    - The set of rigid bodies is experiencing one or more external forces.
    - The set of rigid bodies static, not dynamic or not moving.
+ Imagine that the system is displaced by a small amount. The virtual
    displacements must lie along the same path of action as the forces.
+ Displacements obey the paths of motion of the system. Virtual displacements
    are arbitrary in magnitude but not direction, which means the system should
    only be perturbed in a way that makes physical sense.
+ External force #sym.times virtual displacement = virtual work.
+ Net work done must be zero for the system to be in equilibrium.
    - Each external force moves through its corresponding virtual displacement.
    - The virtual work done is the dot product of the force and the
        corresponding virtual displacement.
    - The total virtual work done is the sum of these dot products, and it must
        be zero.
    - Hence, all virtual displacements must be 0.

#pagebreak()

== Principle of virtual work (PVW)
The principle of virtual work is:

#align(center)[
    "If a deformable structure in equilibrium under the action of a system of
    forces is given a virtual displacement, then the virtual work done by the
    external forces is equal to the virtual work done by the internal forces
    (virtual strain energy)."
]

Essentially:
$ delta W = delta U $

Where:
- $delta W$ is the virtual work done
- $delta U$ is the virtual strain energy

This principle is useful for solving problems involving rigid bodies with
deformable structures.

=== Conditions
+ Deformable structures are able to move.
+ Loads can be internal forces or externally-applied.
    - Typically, we consider systems acted on by 2 or more forces.
+ Virtual displacements apply to deformations.
    - The spring extension also undergoes virtual elongation.
+ Virtual work = real external load #sym.times virtual displacement.
+ Virtual strain energy = internal force #sym.times virtual extension.
    - Internal forces are typically expressed in terms of system properties.
    - In the case of a spring, the stiffness coefficient ($k$) and the extension
        or compression ($e$).

=== Basic example
For the rigid lever shown, determine the force $P$ that results in elongations
$e_1$ and $e_2$ of the springs. Use the Principle of Virtual Work (PVW). Assume
zero friction at the fulcrum.

#grid(
    columns: 2,
    column-gutter: 1em,
    [
        $
            delta W = delta U,
            quad P delta y = k e_1 delta e_1 + k e_2 delta e_2
        $

        Using similar triangles:
        $ e_1 = a_1/b y, quad e_2 = a_2/b y $

        Substituting $e_1$, $e_2$, $delta e_1$, and $delta e_2$:
        $ P delta y = k a_1/b y a_1/b delta y + k a_2/b y a_2/b delta y $
        $ P = k y/b^2 (a_1^2 + a_2^2) $
    ],
    image("./images/virtual-work-basic-example.png"),
)

== Complementary work ($W^*$)
- Work done is the integral product of a force and the displacement it acts
    through.
- The physical interpretation of work is that the force is a function of
    displacement.
- Complementary work $W*$ is the *mathematical opposite* of work.
- It is an energy term based on the integral of displacement as a function of
    force.
$ W = integral P thin dif x, quad W^* = integral x thin dif P $

== Virtual complementary work
Virtual complementary work is the product of the real displacement and virtual
force.
$ delta W = P delta x, quad delta W^* = x delta P $

== Overview of real and virtual work terms
#cimage("./images/overview-of-real-and-virtual-work-terms-diagram.png")
#grid(
    columns: 2,
    column-gutter: 1em,
    align: center + horizon,
    grid(
        columns: 2,
        column-gutter: 1em,
        row-gutter: 1em,
        align: center + horizon,
        fillgreen()[
            Virtual work:
            $ delta W = P delta x $
        ],
        fillgreen()[
            Virtual strain energy:
            $ delta U = F delta e $
        ],

        fillblue()[
            Virtual complementary work:
            $ delta W^* = x delta P $
        ],
        fillblue()[
            Virtual complementary strain energy:
            $ delta U^* = e delta F $
        ],

        [
            Work:
            $ W = integral_0^x P thin dif x $
        ],
        [
            Strain energy:
            $ U = integral_0^e F thin dif e $
        ],

        fillblack()[
            Complementary work:
            $ W^* = integral_0^P x thin dif P $
        ],
        fillblack()[
            Complementary strain energy:
            $ U^* = integral_0^F e thin dif F $
        ],
    ),
    image("./images/overview-of-real-and-virtual-work-terms-graph.png"),
)

#pagebreak()

== The principle of virtual complementary work (PVCW)
$ delta W^* = delta U^* $

Where:
- $delta W^*$ is the virtual complementary work done by all external forces.
- $delta U^*$ is the virtual complementary strain energy of all deformable
    bodies.

=== Comparisons with other principles
#grid(
    row-gutter: 3em,
    [
        - When using the principle of virtual work, we apply *virtual
            displacements* to each external load and internal force.
        - When using the principle of virtual complementary work, we apply a
            *virtual force* to a *point of interest* on the structure.
    ],
    [
        - When using the principle of virtual work, we seek to *eliminate
            virtual displacements*.
        - This allows us to solve problems dealing with, "What is the
            relationship between this load and the other loads?"
    ],
    [
        - When using the principle of virtual complementary work, we seek to
            *eliminate the virtual force*.
        - This allows to solve problems dealing with, "What is the deflection
            seen at this location on the structure?"
    ],
)

== Unit load method
From the principle of virtual complementary work:
$ delta W^* = delta U^* $

In real structures, there can be any number of displacements and deformations.
For example:
$
    delta P_1 dot Delta_1 + delta P_2 dot Delta_2
    + delta P_3 dot Delta_3 + ... + delta P_n dot Delta_n = delta U^*
$

However, since virtual forces are *arbitrary in magnitude*, this equation can be
greatly simplified by:
- Only considering *one virtual force* at a time.
- Setting the magnitude of the *virtual force to 1*.

The unit load equation:
$ 1 dot Delta_i = Delta U^* $

#pagebreak()

== Engesser's First Theorem
The partial derivative of complementary strain energy $U^*$ with respect to any
load $P_i$ is equal to the corresponding displacement $Delta_i$.

#cimage("./images/energy-theorems.png")

A structure contains:
- Rigid bodies
- Springs
- Deformable bars, beams, shafts, etc.
- Elastically yielding supports

Which means the total *complementary* strain energy can be expressed as:
$
    U^* = integral_0^L (frac(P^2, 2 E A)) dif x
    + integral_0^L frac(M^2, 2 E I) dif x
    + integral_0^L frac(Q^2, 2 G A) dif x
    + integral_0^L frac(T^2, 2 G J) dif x
    + ...
$

Then, the displacement at any point can be obtained by applying:
$ frac(partial U^*, partial P_i) = Delta_i $

=== Example: Statically determinate structure,, combined loading
The cranked beam $A B C$ is of circular cross-section. Obtain an expression for
the vertical deflection at point $C$ due to load $P$. Consider only bending and
torsional effects. Take $G = 0.4 E$ and $J = 2I$.

#cimage("./images/engessers-first-theorem-example.png")

First, determine the complementary strain energy $U^*$:

$
    U^* = (integral_0^L frac(M^2, 2 E I) dif x
        + integral_0^L frac(T^2, 2 G J) dif x)_(A B)
    + (integral_0^L frac(M^2, 2 E I) dif x)_(B C)
$

#grid(
    columns: 2,
    column-gutter: 5em,
    [
        Analysis of $A B$:
        $ M = P x wide T = P L $
    ],
    [
        Analysis of $B C$:
        $ M = P x $
    ],
)

Note that there is no need for a virtual load analysis.

To find the deflection $Delta_C$ of point $C$, apply Engesser's theorem.

$
    Delta_C = frac(partial U^*, partial P)
    = frac(partial, partial P) (
        integral_0^L frac((P x)^2, 2 E I) dif x
        + integral_0^L frac((P L)^2, 2 (0.4 E) (2 I)) dif x
        + integral_0^L frac((P x)^2, 2 E I) dif x
    )
    = frac(dif, dif P) [frac(P^2 L^3, E I) (1/3 + 1/1.6)]
$
$ Delta_C = 23/12 frac(P L^3, E I) $

#pagebreak()

== Castigliano's Theorem
+ The partial derivative of strain energy $U$ with respect to any displacement
    $Delta_i$ is equal to the corresponding load $P_i$.
+ The partial derivative of strain energy $U$ with respect to any load $P_i$ is
    equal to the corresponding displacement $Delta_i$.

#cimage("./images/energy-theorems.png", height: 20em)

A structure contains:
- Rigid bodies
- Springs
- Deformable bars, beams, shafts, etc.
- Elastically yielding supports

Which means the total *complementary* strain energy can be expressed as:
$
    U^* = integral_0^L (frac(P^2, 2 E A)) dif x
    + integral_0^L frac(M^2, 2 E I) dif x
    + integral_0^L frac(Q^2, 2 G A) dif x
    + integral_0^L frac(T^2, 2 G J) dif x
    + ...
$

From part 1 of Castigliano's theorem:

The partial derivative of strain energy $U$ with respect to any displacement
$Delta_i$ is equal to the corresponding load $P_i$.

The external load at any point can be obtained by applying:
$ frac(partial U, partial Delta_i) = P_i $

However, it is rare for strain energy to be expressed in terms of displacement.

From part 2 of Castigliano's theorem:

The partial derivative of strain energy $U$ with respect to any load $P_i$ is
equal to the corresponding displacement $Delta_i$.

The displacement at any point can be obtained by applying:
$ frac(partial U, partial P_1) = Delta_i $

=== Example
Two linear springs of stiffness $k$ extend from the centre points of rigid links
$A B$ and $B C$. The top end of each spring can move horizontally so that the
springs remain vertical at all times. Determine the forces $P_B$ and $P_C$
(separately) in terms of the deflections $Delta_B$ and $Delta_C$. Assume zero
friction at all joints.

#cimage("./images/virtual-work-example-3.png", height: 20em)

Express the total strain energy $U$ in terms of displacements $Delta_B$ and
$Delta_C$.

Strain energy comes from the two linear elastic springs:
$ U = 1/2 k e_1^2 + 1/2 k e_2^2 $

However, to determine $P_B$ ($P_C$), we need an expression containing $Delta_B$
($Delta_C$).

$ e_1 = 1/2 Delta_B wide e_2 1/2 (Delta_B + Delta_C) $

Applying the first part of Castigliano's Theorem:
$
    P_B = frac(partial U, partial Delta_B)
    &= frac(partial, partial Delta_B)
    (1/8 k Delta_B^2 + 1/8 k (Delta_B + Delta_C)^2) \
    &= 1/4 k (2 Delta_B + Delta_C)
$

$
    P_C = frac(partial U, partial Delta_C)
    &= frac(partial, partial Delta_C)
    (1/8 k Delta_B^2 + 1/8 k(Delta_B + Delta_C)^2) \
    &= 1/4 k (Delta_B + Delta_C)
$

#pagebreak()

= Applying the principle of virtual displacements
Generic problem statement:

Express applied force $P$ in terms of other forces $W_1$, $W_2$, lengths $L_1$,
$L_2$, or angles $theta_1$, $theta_2$, ...

+ (If required) Remove one member of a truss and replace it with 2 forces to
    ensure the system stays in equilibrium.
+ Prescribe a suitable coordinate system:
    - Observe the direction of the force.
    - Begin from the location of the fixed point or pivot.
+ Apply virtual displacements.
+ Apply the principle of virtual displacements, *$delta W = 0$*.
+ Identify geometric relationships between virtual displacements.
+ Eliminate virtual displacements.
+ The final expression is in *real forces and dimensions only*.

== Example 1
A rigid bar $A B$ of length $L$ is hinged to the floor at $A$ and subjected to a
vertical force $P$ at $B$ as shown. Determine the horizontal force $F$ required
at the mid-point of the bar to balance the bar in the position shown in terms of
$P$. Ignore the weight of the bar. Assume zero friction at the hinge.

#cimage("./images/virtual-displacements-example-1.png", height: 20em)

=== Step 1: Selecting coordinate systems
- Force $P$ acts in the *vertical* direction at point *B*.
- Hence, to evaluate the work done by $P$, we prescribe coordinate $h_1$.
- $h_1$ represents the *vertical displacement* from the *fixed pivot* to point
    $B$.
#linebreak()

- Force $F$ acts in the *horizontal* direction at point $C$.
- $h_2$ represents the *horizontal displacement* from the fixed pivot to point
    $C$.
- The positive direction of displacements should be *outward from the fixed
    point*.

=== Step 2: Apply virtual displacements
#cimage("./images/virtual-displacements-example-step-2.png", height: 15em)
- Virtual displacements are prescribed in the *same direction* as the
    corresponding *real displacements*.
- Virtual displacement $delta h_1$ represents an imaginary vertical displacement
    that force $P$ moves through.
- Virtual displacement $delta h_2$ represents imaginary horizontal displacement
    that force $F$ moves through.

=== Step 3: Apply principle of virtual displacement (PVD)
$ delta W = 0 $
- Virtual work is defined as the product of *real force* and *virtual
    displacement*.
- Virtual work done by $P$: $(-P) delta h_1$
- Virtual work done by $F$: $(-F) delta h_2$

$ -P delta h_1 - F delta h_2 = 0 $

- The above is technically the final expression obtained from the application of
    the principle of virtual displacement.
- However, it is *not a useful expression* unless we can eliminate the arbitrary
    virtual displacements.

=== Step 4: Geometric relationship between $delta h_1$ and $delta h_2$
In most problems, there are numerous ways to describe a relationship between
virtual displacements.

Using:
$ L^2 = h_1^2 + (2h_2)^2 $

$ h_1 = sqrt(L^2 - 4h_2^2) delta h_2 $

Taking the derivative of $delta h_1$ with respect to $delta h_2$:
$ frac(delta h_1, delta h_2) = frac(dif h_1, dif h_2) $

$ delta h_1 = - frac(4h_2, sqrt(L^2 - 4h_2^2)) delta h_2 $

=== Step 5: Eliminate virtual displacements
$
    L^2 = h_1^2 + (2h_2)^2,
    quad h_1 = sqrt(L^2 - 4h_2^2),
    quad delta h_1 = - frac(4h_2, sqrt(L^2 - 4h_2^2)) delta h_2
$

$ -P delta h_1 - F delta h_2 = 0 $
$
    frac(4P h_2, sqrt(L^2 - 4h_2^2)) redcancel(delta h_2)
    - F redcancel(delta h_2) = 0
$

=== Step 6: Final expression in real forces and dimensions
$
    frac(4P h_2, sqrt(L^2 - 4h_2^2)) redcancel(delta h_2)
    - F redcancel(delta h_2) = 0
$

$ F = frac(4P h_2, sqrt(L^2 - 4h_2^2)) = 4P h_2/h_1 $

#pagebreak()

== Example 2
#cimage("./images/virtual-displacements-example-2.png")
The mechanism shown is made of 4 pin-jointed links of lengths $L$. Determine the
moment $M$ required to hold the mechanism in the position shown, in terms of
$P$. Ignore the weight of the links. Assume zero friction at the pin-joints.

Applying the principle of virtual displacements:
$ delta W = 0, quad P delta x + M delta theta = 0 $

$ x = 0.5L cos theta + 0.5L cos theta + H $
$ L^2 = y^2 + H^2 $
$ y = 0.5L sin theta $

$ x = L cos theta + sqrt(L^2 - (0.5 L sin theta)^2) $

Taking derivatives with respect to $delta theta$:
$
    delta x = - (L sin theta + frac(
            L^2 sin theta cos theta, sqrt(L^2 - 1/4 L^2 sin^2 theta)
        )) delta theta
$

Substitute and eliminate virtual displacements:
$
    M = P (L sin theta + frac(
            L^2 sin theta cos theta,
            sqrt(L^2 - 1/4 L^2 sin^2 theta)
        ))
$

== Example 3: System of trusses (zero degrees of freedom)
A structure consisting of trusses arranged to form three equilateral triangles
experiences a load $W$ at point $E$. Determine the internal force in link $C D$
by using the method of virtual work.

#cimage("./images/virtual-displacements-example-3.png")
#pagebreak()

=== Step 1: Removing the link
- The link $C D$ is removed. The resulting structure now has 1 *degree of
    freedom*.
- By simply removing $C D$, the structure is no longer in equilibrium.
- Adding $F_(C D)$ and $F_(D C)$, the structure *returns to equilibrium*.
- $F_(C D)$ and $F_(D C)$ replace the internal forces of link $C D$.
- The aim is to express internal force $F_(C D)$ in terms of load $W$.

#cimage("./images/virtual-displacements-example-3-step-1.png")

=== Applying the rest of the steps
$ delta W = 0 $
$ -2 F_(C D) delta x + W delta y = 0 $

Simplified because $F_(C D)$ and $F_(D C)$ are the same and *the geometry has
symmetry*.

Assuming each truss is of length $L$:
$ x = L cos theta, quad y = L sin alpha = L sin (pi/3 - theta) $

Taking derivatives with respect to $delta theta$:
$
    delta x = - L sin theta delta theta,
    quad delta y = -L cos (pi/3 - theta) delta theta
$

Substitute and eliminate virtual displacements:
$ 2 F_(C D) L sin theta - W L cos (pi/3 - theta) = 0 $
$ F_(C D) = frac(W cos (pi/3 - theta), 2 sin theta) $

= Applying the principle of virtual work
Generic problem statement:

Express applied force $P$ in terms of spring stiffness $k$ and elongation $e$,
dimensions $L$ and $theta$, etc.

+ Prescribe a suitable coordinate system:
    - Direction of external applied force
    - Direction of spring elongation or compression
    - Location of fixed point
+ Apply virtual displacements and changes in the spring length
+ Apply the principle of virtual work, $delta W =delta U$
+ Identify geometric relationships between virtual displacements.
+ Eliminate virtual displacements.
+ The final expression is in real forces and dimensions only.

== Example 1
The structure shown here has rigid members $A B$ and $B C$ connected to a linear
spring as shown. At the equilibrium position, express the force $P$ in terms of
the spring stiffness $k$, the length of each link $L$ and the angle $alpha$
shown. Ignore the weights of all parts and frictional effects.

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Applying the principle of virtual work:
        $ delta W = delta U $
        $ - P delta h = k e delta e $

        Pin $B$ is pulling the spring to the left, and strain energy considers
        forces *acting on* the *spring*, so $k e$ is positive.

        Express $h$ and $e$ in terms of the common angle $alpha$.
        #grid(
            columns: 2,
            column-gutter: 1em,
            row-gutter: 1em,
            $h = 2L cos alpha$, $e = L sin alpha$,
            $delta h = -2L sin alpha delta alpha$,
            $delta e = L cos alpha delta alpha$,
        )

        Substitute back into the principle of virtual work expression, and
        eliminate virtual terms:
        $
            - P (-2L sin alpha delta alpha)
            = k(L sin alpha)(L cos alpha delta alpha)
        $

        $ P = frac(k L cos alpha, 2) $
    ],
    image("./images/virtual-work-example-1.png"),
)

#pagebreak()

== Example 2
The mechanism shown is made of 4 pin-jointed members of lengths $L$ and $0.5L$
respectively. The spring is in an unstretched condition when the angle $theta$
is 30#sym.degree. Determine the force $P$ required to hold the mechanism in
place as shown, in terms of stiffness $k$ and $L$. Assume zero friction at the
pin-joints.

#cimage("./images/virtual-work-example-2.png", height: 25em)

Apply the principle of virtual work:
$ delta W = delta U $
$ - P delta x = k e delta e $

Pin $D$ is pulling upwards on the spring. The upward tensile force is the *same
direction* as the coordinate $e$.

Express $h$ and $e$ in terms of the common angle $alpha$.

First, finding the unstretched condition:
$ 0.5L sin pi/6 + 0.5L sin pi/6 = 0.5L $
#align(center, grid(
    columns: 2,
    column-gutter: 1em,
    row-gutter: 1em,
    $ x = 1.5L cos theta $, $ e = L sin theta - 0.5L $,

    $ delta x = -1.5L sin theta delta theta $,
    $ delta e = L cos theta delta theta $,
))

Substitute back into the principle of virtual work expression, and eliminating
virtual terms:
$
    -P(-1.5L sin theta delta theta)
    = k (L sin theta - 0.5L)(L cos theta delta theta)
$
$ P = frac(k L, 1.5) cos theta (1 - frac(1, 2 sin theta)) $

#pagebreak()

=== Compression variation
#cimage("./images/virtual-work-example-2-compression.png")

Apply the principle of virtual work:
$ delta W = delta U $
$ P delta x = - k e delta e $

Pin $D$ is pressing downward on the spring. The downward compressive force
*opposes* the coordinate $e$.

Express $h$ and $e$ in terms of the common angle $alpha$.

First, finding the unstretched condition:
$ 0.5L sin pi/6 + 0.5L sin pi/6 = 0.5L $
#align(center, grid(
    columns: 2,
    column-gutter: 1em,
    row-gutter: 1em,
    $ x = 1.5L cos theta $, $ e = L sin theta - 0.5L $,

    $ delta x = -1.5L sin theta delta theta $,
    $ delta e = L cos theta delta theta $,
))

Substitute back into the principle of virtual work expression, and eliminating
virtual terms:
$
    P(-1.5L sin theta delta theta)
    = - k (L sin theta - 0.5L)(L cos theta delta theta)
$
$ P = frac(k L, 1.5) cos theta (1 - frac(1, 2 sin theta)) $

#pagebreak()

=== Compression variation with unstretched length larger than current length
#cimage(
    "./images/virtual-work-example-2-compression-and-length-larger.png",
)

Apply the principle of virtual work:
$ delta W = delta U $
$ P delta x = k e delta e $

Pin $D$ is pressing downward on the spring. The downward compressive force is in
the *same direction* as the coordinate $e$.

Express $h$ and $e$ in terms of the common angle $alpha$.

Geometry dictates that $e$ should be initial - final lengths.

#align(center, grid(
    columns: 2,
    column-gutter: 1em,
    row-gutter: 1em,
    $ x = 1.5L cos theta $, $ e = 0.5L - L sin theta $,

    $ delta x = -1.5L sin theta delta theta $,
    $ delta e = -L cos theta delta theta $,
))

Substitute back into the principle of virtual work expression, and eliminating
virtual terms:
$
    -P(-1.5L sin theta delta theta)
    = - k (0.5 L - L sin theta)(-L cos theta delta theta)
$
$ P = frac(k L, 1.5) cos theta (1 - frac(1, 2 sin theta)) $

== Example 3
Two linear springs of stiffness $k$ extend from the centre points of rigid links
$A B$ and $B C$. The top end of each spring can move horizontally so that the
springs remain vertical at all times. Determine the forces $P_B$ and $P_C$
(separately) in terms of the deflections $Delta_B$ and $Delta_C$. Assume zero
friction at all joints.

#cimage("./images/virtual-work-example-3.png", height: 20em)

The extension of spring 2 also includes the deflection of point $B$.

Applying the principle of virtual work:
$ delta W = delta U $
$
    P_B delta Delta_B + P_C delta Delta_c
    = k e_1 delta e_1 + k e_2 delta e_2
$

From the geometry, we can use the fact that the springs are connected at
mid-span:
$ e_1 =1/2 Delta_B $
$ e_2 = 1/2 (Delta_B + Delta_C) $

#cimage("./images/virtual-work-example-3-geometry.png", width: 60%)
$
    delta e_2 = frac(partial, partial Delta_B) [1/2 (Delta_B + Delta_C)]
    delta Delta_B
    + frac(partial, partial Delta_C) [1/2 (Delta_B + Delta_C)]
    delta Delta_C
$

$
    delta e_1 = 1/2 delta Delta_b,
    quad delta e_2 = 1/2 delta Delta_B + 1/2 delta Delta_C
$

$ P_B delta Delta_B + P_C delta Delta_C = k e_1 delta e_1 + k e_2 delta e_2 $

Substituting the spring extension terms into the principle of work equation:
#labelled_equation(
    $
        P_B delta Delta_B + P_C delta Delta_C =
        k(1/2 Delta_B) (1/2 delta Delta_B)
        + k(1/2 (Delta_B + Delta_C)) (1/2 delta Delta_B + 1/2 delta Delta_C)
    $,
    1,
)

However, this equation contains too many unknowns, and we cannot eliminate
$delta Delta_B$ and $delta Delta_C$ together.

To solve for $P_B$, we let $delta Delta_C$ be zero, since virtual displacements
are arbitrary.

$
    P_B delta Delta_B = k (1/2 Delta_B) (1/2 delta Delta_B)
    + k(1/2 (Delta_B + Delta_C)) (1/2 delta Delta_B)
$
$
    P_B = 1/2 k Delta_B + 1/4 k Delta_C
    quad "or" quad
    P_B = 1/2 k e_1 + 1/2 k e_2
$

From (1), to solve for $P_C$, let $delta Delta_B$ be 0, since virtual
displacements are arbitrary.
$ P_C delta Delta_C + k (1/2(Delta_B + Delta_C)) (1/2 delta Delta_C) $

$ P_C = 1/4 k Delta_B + 1/4 k Delta_C quad "or" quad P_C = 1/2 k e_2 $

#pagebreak()

= Applying the principle of virtual complementary work

== Example
Two linear springs of stiffness $k$ extend from the centre points of rigid links
$A B$ and $B C$. The top end of each spring can move horizontally so that the
springs can remain vertical at all times. Determine the deflections $Delta_B$
and $Delta_C$ (separately), in terms of the forces $P_B$ and $P_C$. Assume zero
friction at all joints.

A *real load analysis* and *virtual load analysis* are required to solve this
problem (free-body diagrams). However, this is not immediately obvious, so we
start by applying the principle of virtual complementary work:
$ delta W^* = delta U^* $

To apply the virtual load, we first do 2 things:
+ Remove all real external loads and internal forces.
+ Identify the point of interest. In this case, we choose to solve for $Delta_B$
    first.

#cimage("./images/virtual-complementary-work-example.png", height: 40em)
#pagebreak()

=== Solving for $Delta_B$
Now, we apply an arbitrary virtual load $delta P_B$ at point $B$. The virtual
load also induces a corresponding virtual spring force $delta F_1$ and
$delta F_2$ is springs 1 and 2, which is necessary for the system to remain in
equilibrium.

By the principle of virtual complementary work:
$ Delta_B delta P_B = e_1 delta F_1 + e_2 delta F_2 $

For a linear spring,
$ e_1 = F_1/k, quad e_2 = F_2/k $

Expressing in terms of loads and virtual loads:
#labelled_equation($ Delta_B delta P_B = F_1/k delta F_1 + F_2/k delta F_2 $, 1)

However, there is not much that can be done from here, as $Delta F_1$ and
$Delta F_2$ are *not derivatives* of $F_1$ and $F_2$ respectively.

#pagebreak()

==== Free body diagrams
<principle-of-virtual-complementary-work-delta-b>
#cimage("./images/virtual-complementary-work-example-b-real-forces.png")
#cimage("./images/virtual-complementary-work-example-b-virtual-forces.png")

From the free body diagram analysis above, we get:
#align(center, grid(
    columns: 2,
    column-gutter: 5em,
    row-gutter: 1em,
    $ F_1 = 2(P_B - P_C) $, $ delta F_1 = 2 delta P_B $,
    $ F_2 = 2 P_C $, $ delta F_2 = 0 $,
))

Substituting the equations above into the main equation, equation (1):
$ Delta_B delta P_B = 2 frac(P_B - P_C, k) (2 delta P_B) + 2 P_C/k (0) $

$delta P_B$ can now be eliminated, hence:
$ Delta_B = frac(4(P_B - P_C), k) $

#pagebreak()

=== Solving for $Delta_C$
Applying the principle of virtual complimentary work to solve for the deflection
$Delta_C$ at point $C$:
$ Delta W^* = delta U^* $

For a linear spring:
$ e_1 = F_1/k, quad e_2 = F_2/k $

Expressing in terms of loads and virtual loads:
#labelled_equation($ Delta_C delta P_C = F_1/k delta F_1 + F_2/k delta F_2 $, 2)

==== Free body diagrams
<principle-of-virtual-complementary-work-delta-c>
For the real forces, there is no change, so we can use the previous result.
#cimage(
    "./images/virtual-complementary-work-example-b-real-forces.png",
    width: 75%,
)
#cimage(
    "./images/virtual-complementary-work-example-c-virtual-forces.png",
    width: 75%,
)

From the free body diagram analysis above, we get:
#align(center, grid(
    columns: 2,
    column-gutter: 5em,
    row-gutter: 1em,
    $ F_1 = 2(P_B - P_C) $, $ delta F_1 = -2 delta P_C $,
    $ F_2 = 2 P_C $, $ delta F_2 = 2 delta P_C $,
))

Substituting the equations above into the main equation, equation (2):
$
    Delta_C delta P_C
    = 2 frac(P_B - P_C, k) (- 2 delta P_C) + 2 P_C/k (2 delta P_C)
$

$delta P_C$ can now be eliminated, hence:
$ Delta_C = frac(4(2 P_C - P_B), k) $

= Applying the unit load method

== Example 1
Two linear springs of stiffness $k$ extend form the centre points of rigid links
$A B$ and $B C$. The top end of each spring can move horizontally so that the
springs remain vertical at all times. Determine the deflections $Delta_B$ and
$Delta_C$ (separately) in terms of the forces $P_B$ and $P_C$. Assume zero
friction at all joints.

Applying the unit load method:
$ 1 dot Delta = delta U^* $

Start from the deflection of point $B$. For *virtual load analysis*, remove all
real loads and place a *unit load* at the point of interest.

#cimage("./images/virtual-complementary-work-example.png", height: 45em)
#pagebreak()

=== Solving for $Delta_B$
The unit load still imposes virtual forces on the two springs, hence:
$ 1 dot Delta_B = F_1/k delta F_1 + F_2/k delta F_2 $

From the free-body analysis, same as
@principle-of-virtual-complementary-work-delta-b:
#align(center, grid(
    columns: 2,
    column-gutter: 5em,
    row-gutter: 1em,
    $ F_1 = 2(P_B - P_C) $, $ delta F_1 = 2 $,
    $ F_2 = 2 P_C $, $ delta F_2 = 0 $,
))

Substituting all terms on the right-hand side:
$ Delta_B = frac(2 (P_B - P_C), k) (2) = frac(4(P_B - P_C), k) $

=== Solving for $Delta_C$
The unit load still imposes virtual forces on the two springs, hence:
$ 1 dot Delta_C = F_1/k delta F_1 + F_2/k delta F_2 $

From the free-body analysis, which is the same as
@principle-of-virtual-complementary-work-delta-c:
#align(center, grid(
    columns: 2,
    column-gutter: 5em,
    row-gutter: 1em,
    $ F_1 = 2(P_B - P_C) $, $ delta F_1 = -2 $,
    $ F_2 = 2 P_C $, $ delta F_2 = 2 $,
))

Substituting all terms on the right-hand side:
$ Delta_C = frac(2(P_B - P_C), k) (-2) + 2 P_C (2) = frac(4 (2 P_C - P_B), k) $

#pagebreak()

== Example 2
<unit-load-method-example-2-point-e>
The cantilever type system contains four torsional springs at joints $A$ to $D$
with stiffness $k$ (#unit[Nm rad^-1]). Determine the deflection at the tip $E$
in terms of the external force $P$. Assume that the deflections are small, and
hence small-angle approximation is valid.

Moment experienced at each joint is proportional to the distance from $P$.
$ M_A = 4 P L wide M_B = 3 P L wide M_C = 2 P L wide M_D = P L $

Recall that $delta M$ is *not the derivative of $M$*.
$
    theta_A = M_A/k wide
    theta_B = M_B/k wide theta_C = M_C/k wide theta_D = M_D/k
$

We determine $delta M$ terms by removing $P$ and placing a unit load at point
$E$.
$ delta M_A = 4 L wide delta M_B = 3 L wide delta M_C = 2 L wide delta M_D = L $

Applying the unit load method for point $E$:
$ 1 dot Delta_E = delta U^* $

Torsional springs also store virtual strain energy. However, instead of
$delta U^* = e delta F$, we express it as $delta U^* = theta delta M$:
#labelled_equation(
    $
        Delta_E = theta_A delta M_A
        + theta_B delta M_B + theta_C delta M_C + theta_D delta M_D
    $,
    1,
)

Substituting all the $theta$, $M$, and $delta M$ terms into the right-hand side:
$
    Delta_E & = frac(4 P L, k) (4L) + frac(3 P L, k) (3L)
              + frac(2 P L, k) (2 L) + frac(P L, k) (L) \
            & = 30 frac(P L^2, k)
$

#cimage("./images/unit-load-example-2.png")
#pagebreak()

=== Obtaining the deflection at $D$ instead
Same steps as @unit-load-method-example-2-point-e, just that $delta M_D = 0$.

From (1), substituting all the $theta$, $M$, and $delta M$ terms into the
right-hand side:
$
    Delta_D & = frac(4 P L, k) (4L) + frac(3 P L, k) (3L)
              + frac(2 P L, k) (2 L) + frac(P L, k) (0) \
            & = 20 frac(P L^2, k)
$

#cimage("./images/unit-load-example-2-d.png")

=== Obtaining the deflection at $B$ instead
Same steps as @unit-load-method-example-2-point-e, just that
$delta M_D = delta M_C = delta M_B = 0$.

From (1), substituting all the $theta$, $M$, and $delta M$ terms into the
right-hand side:
$
    Delta_D & = frac(4 P L, k) (4L) + frac(3 P L, k) (0)
              + frac(2 P L, k) (0) + frac(P L, k) (0) \
            & = 4 frac(P L^2, k)
$

#cimage("./images/unit-load-example-2-b.png")

= Axial loading of a solid element
#cimage("./images/axial-loading-of-a-solid-element-1.png")

#cimage("./images/axial-loading-of-a-solid-element-2.png")

#pagebreak()

#fillgreen()[
    *Virtual strain energy ($delta U$)*
]

Real #text(red)[force] #sym.times
#makegreen()[virtual displacement]

$
    #makered()[$sigma dif x dif z$] dot #makegreen()[$delta Delta$]
    = sigma thin #makegreen()[$delta epsilon$]
    thin dif x #makegreen()[$dif y$] dif z
    = sigma thin #makegreen()[$delta epsilon$] thin dif V
$

$ delta U = integral_V sigma thin delta epsilon thin dif V $

#fillblue()[
    *Virtual complementary strain energy ($delta U^*$)*
]

#makeblue()[Virtual force] #sym.times real #makepurple()[displacement]

$
    #makeblue()[$delta (sigma dif x dif z)$] dot #makepurple()[$Delta$]
    = epsilon thin #makeblue()[$delta sigma thin dif x$] dif y
    #makeblue()[$dif z$]
    = epsilon thin #makeblue()[$delta sigma$] thin dif V
$

$ delta U^* = integral_V epsilon thin delta sigma thin dif V $

*Strain energy ($U$)*

Integral of the real #makered()[force] with respect to
#makepurple()[displacement]

$
    integral_0^epsilon (#makered()[$sigma thin dif x dif z$])
    dif (#makepurple()[$epsilon dif y$])
    = integral_0^epsilon sigma thin dif epsilon thin dif V
$

$ U = integral_V (integral_0^epsilon sigma thin dif epsilon) dif V $

#fillblack()[*Complementary strain energy ($U^*$)*]

Integral of the real #makepurple()[displacement] with respect to
#makered()[force]

$
    integral_0^sigma #makepurple()[$epsilon thin dif y$]
    dif (#makered()[$sigma thin dif x dif z$])
    = integral_0^sigma epsilon thin dif sigma thin dif V
$

$ U^* = integral_V (integral_0^sigma epsilon thin dif sigma) dif V $

#pagebreak()

= Virtual strain energy expressions of a general solid
For *linear elastic* materials, $sigma = E epsilon$, where $E$ is the Young's
modulus.

The aim is to express the strain energy equations in terms of $sigma$ (remove
$epsilon$ from equation).

#align(center, fillblue()[$
    delta U = integral_V sigma thin delta epsilon thin dif V
    = integral_V sigma thin delta (sigma/E) dif V
    = integral_V sigma/E delta sigma thin dif V
$])

#align(center, fillgreen()[$
    delta U^* = integral_V epsilon thin delta sigma thin dif V
    = integral_V sigma/E delta sigma thin dif V = delta U
$])

$
    U = integral_V (integral_0^epsilon sigma thin dif epsilon) dif V
    = integral_V (integral_0^epsilon E epsilon thin dif epsilon) dif V
    = integral_V (frac(E epsilon^2, 2)) dif V
    = integral_V (frac(sigma^2, 2 E)) dif V
$

#align(center, fillblack()[$
    U^* = integral_V (integral_0^sigma epsilon thin dif sigma) dif V
    = integral_V (integral_0^sigma sigma/E thin dif sigma) dif V
    = integral_V (frac(sigma^2, 2E)) dif V = U
$])

= Axial loading of uniform bars
#cimage("./images/axial-loading-of-uniform-bars.png", width: 90%)

If the bar is uniform across its length:
$ sigma = P/A wide dif V = A thin dif x $

Expressions for strain energy and complementary strain energy:
$
    U = U^* = integral_V (frac(sigma^2, 2E)) dif V
    = integral_0^L (frac(P^2, A^2) 1/(2E)) A thin dif x
    = integral_0^L (frac(P^2, 2 E A)) thin dif x
$

Expressions for virtual strain energy and virtual complementary strain energy:
$
    delta U = delta U^* = integral_V (sigma/E delta sigma) dif V
    = integral_0^L (frac(P, E A) delta P/A) A thin dif x
    = integral_0^L (frac(P, E A) delta P) dif x
    = integral_0^L (frac(P p, E A)) dif x
    = 1 dot Delta_i
$

Where:
- $P$ is the axial force due to real load
- $p$ is the axial force due to *unit* virtual load

#pagebreak()

= Pure bending of uniform beams
#cimage("./images/pure-bending-of-uniform-beams.png", width: 90%)

If the beam is uniform across its length:
$ sigma = frac(M y, I) wide dif V = dif A thin dif x $

Expressions for strain energy and complementary strain energy:
$
    U = U^* = integral_V (frac(sigma^2, 2E)) dif V
    = integral_0^L integral_A (frac(M^2 y^2, I^2) 1/(2E)) dif A thin dif x
    = integral_0^L (frac(M^2, 2 E I^2))
    redcancel((integral_A y^2 thin dif A)) dif x
    = integral_0^L (frac(M^2, 2 E I)) dif x
$

Expressions for virtual strain energy and virtual complementary strain energy:
$
    delta U = delta U^* = integral_V (sigma/E delta sigma) dif V
    = integral_0^L integral_A (frac(M y, E I) delta frac(M y, I))
    dif A thin dif x
    = integral_0^L (frac(M delta M, E I^2))
    redcancel((integral_A y^2 thin dif A)) dif x
    = integral_0^L (frac(M m, E I)) dif x
    = 1 dot Delta_i
$

Where:
- $M$ is the moment due to real load
- $m$ is the moment due to *unit* virtual load

#pagebreak()

= Shear loading of uniform bars
#cimage("./images/shear-loading-of-uniform-bars.png")
If the bar is uniform across its length:
$ tau = Q/A wide dif V = A thin dif x $

Expressions for strain energy and complementary strain energy:
$
    U = U^* = integral_V frac(tau^2, 2 G) dif V
    = integral_0^L (frac(Q^2, A^2) frac(1, 2G)) A thin dif x
    = integral_0^L (frac(Q^2, 2 G A)) dif x
$

Expressions for virtual strain energy and virtual complementary strain energy:
$
    delta U = delta U^* = integral_V (tau/G delta tau) dif V
    = integral_0^L (frac(Q, G A) delta frac(Q, A)) A thin dif x
    = integral_0^L (frac(Q, G A) delta Q) thin dif x
    = integral_0^L (frac(Q q, G A)) dif x
    = 1 dot Delta_i
$

Where:
- $Q$ is the shear force due to real load
- $q$ is the shear force due to *unit* virtual load

#pagebreak()

= Torsional loading of uniform shafts
#cimage("./images/torsional-loading-of-uniform-shafts.png")

If the shaft is uniform across its length:
$ tau = frac(T r, J) wide dif V = dif A thin dif x $

Expressions for strain energy and complementary strain energy:
$
    U = U^* = integral_V (frac(tau^2, 2 G)) dif V
    = integral_0^L integral_A (frac(T^2 r^2, J^2) frac(1, 2G)) dif A thin dif x
    = integral_0^L (frac(T^2, 2 G J^2))
    redcancel((integral_A r^2 thin dif A)) dif x
    = integral_0^L (frac(T^2, 2 G J)) dif x
$

Expressions for virtual strain energy and virtual complementary strain energy:
$
    delta U = delta U^* = integral_V (tau/G delta tau) dif V
    = integral_0^L integral_V (frac(T r, G J) delta frac(T r, J))
    dif A thin dif x
    = integral_0^L (frac(T delta T, G J^2))
    redcancel((integral_A r^2 thin dif A)) dif x
    = integral_0^L (frac(T t, G J)) dif x = 1 dot Delta_i
$

Where:
- $T$ is the torque due to real load
- $t$ is the torque due to *unit* virtual load

#pagebreak()

= Virtual strain energy expressions

== Various types of loading
#table(
    columns: 3,
    column-gutter: 1em,
    row-gutter: 1em,
    stroke: none,
    table.header(
        [],
        [Strain energy ($U$ and $U^*$)],
        [Virtual strain energy ($delta U$ and $delta U^*$)],
    ),

    [Axial loading of uniform bars],
    $ integral_0^L (frac(P^2, 2 E A)) dif x $,
    $ integral_0^L (frac(P p, E A)) dif x $,

    [Pure bending of uniform beams],
    $ integral_0^L (frac(M^2, 2 E I)) dif x $,
    $ integral_0^L (frac(M m, E I)) dif x $,

    [Shear loading of uniform beams],
    $ integral_0^L (frac(Q^2, 2 G A)) dif x $,
    $ integral_0^L (frac(Q q, G A)) dif x $,

    [Torsional loading of uniform shafts],
    $ integral_0^L (frac(T^2, 2 G J)) dif x $,
    $ integral_0^L (frac(T t, G J)) dif x $,
)

#pagebreak()

== Combined loading
$ 1 dot Delta_i = delta U^* $
$
    1 dot Delta_i
    = integral_0^L (frac(P p, E A)) dif x
    + integral_0^L (frac(M m, E I)) dif x
    + integral_0^L (frac(Q q, G A)) dif x
    + integral_0^L (frac(T t, G J)) dif x
$

Any deformable structure can experience stretching, bending, shear and torsion,
and can be at the same time too.

Structures can be composite, consisting of multiple deformable components.
- Divide the structure into individual bar, beam, or shaft components.
- Determine the types of loading present on each individual bar, beam, or shaft
    components.
- Expand and solve each necessary virtual strain energy term.

#grid(
    columns: 3,
    column-gutter: 1em,
    image("./images/virtual-strain-energy-expressions-1.png"),
    image("./images/virtual-strain-energy-expressions-2.png"),
    image("./images/virtual-strain-energy-expressions-3.png"),
)

$
    1 dot Delta_i & = (
                        redcancel(integral_0^L frac(P p, E A) dif x)
                        + integral_0^L frac(M m, E I) dif x
                        + integral_0^L frac(Q q, G A) dif x
                        + integral_0^L frac(T t, G J) dif x
                    )_(A B) \
                  & + (
                        redcancel(integral_0^L frac(P p, E A) dif x)
                        + integral_0^L frac(M m, E I) dif x
                        + integral_0^L frac(Q q, G A) dif x
                        + redcancel(integral_0^L frac(T t, G J) dif x)
                    )_(B C) \
                  & + (
                        integral_0^L frac(P p, E A) dif x
                        + redcancel(integral_0^L frac(M m, E I) dif x)
                        + redcancel(integral_0^L frac(Q q, G A) dif x)
                        + redcancel(integral_0^L frac(T t, G J) dif x)
                    )_(C D)
$

#pagebreak()

== Example 1: Statically determinate structure, pure bending
Evaluate the central deflection of the simply supported beam carrying a
uniformly distributed load of $w$ Newtons per unit length. Consider only bending
effects.

#cimage("./images/statically-determinate-structure-example-1-1.png")

To find the value of $Delta_C$, or an expression for $Delta_C$, we will apply
the unit load method at point $C$:
$ 1 dot Delta_C = delta U^* $

To evaluate the virtual load, we:
- Remove all real loads and reactions from the beam.
- Apply a unit load at point $C$ and determine the virtual reaction forces due
    to this applied unit load.

This causes a *discontinuity (sudden change)* in the *internal shear*
experienced by the beam.

The analysis for each self-continuous section is to be carried out separately,
hence:
$
    1 dot Delta_C & = (
                        integral_0^(L/2) (frac(P p, E A)) dif x
                        + integral_0^(L/2) (frac(M m, E I)) dif x
                        + integral_0^(L/2) (frac(Q q, G A)) dif x
                        + integral_0^(L/2) (frac(T t, G J)) dif x
                    )_(A C) \
                  & + (
                        integral_0^(L/2) (frac(P p, E A)) dif x
                        + integral_0^(L/2) (frac(M m, E I)) dif x
                        + integral_0^(L/2) (frac(Q q, G A)) dif x
                        + integral_0^(L/2) (frac(T t, G J)) dif x
                    )_(B C)
$

Fortunately, the structure only experiences pure bending:
$
    1 dot Delta_C = integral_0^(L/2) (frac(M m, E I))_(A C) dif x
    + integral_0^(L/2) (frac(M m, E I))_(B C) dif x
$

To solve this integral, we need the real and virtual bending moment expressions
for sections $A C$ and $B C$.

#pagebreak()

=== Evaluating the real load on section $A C$
#cimage(
    "./images/statically-determinate-structure-example-1-2.png",
    height: 15em,
)

To evaluate real load on section $A C$:
- Prescribe a coordinate system, such as $x$.
- The coordinate system can begin from end $A$ or $C$, but it is *typically
    easier to start from a free end if possible*.
- Cut section $A C$ at an arbitrary point $P$. Then, only consider section $A P$
    (from $x = 0$ to $x = P$).
- Write down all bending moments in section $A P$ acting around point $P$.

Assuming that *clockwise* is positive:
$ M_(A C) = (1/2 w L) x - w x (1/2 x) $

=== Evaluating the real load on section $B C$
#cimage(
    "./images/statically-determinate-structure-example-1-3.png",
    height: 15em,
)

To evaluate real load on section $B C$:
- Prescribe a coordinate system, such as $x$ (you can reuse $x$).
- Starting from the free end $B$, since it is simpler.
- Cut section $B C$ at an arbitrary point $P$ and consider section $B P$ (from
    $x = 0$ to $x = P$).

Write down all bending moments in section $B P$ acting around point $P$.

Assuming that *counter-clockwise* is positive:
$ M_(B C) = (1/2 w L) x - w x (1/2 x) $

#pagebreak()

=== Evaluating the virtual load on section $A C$
#cimage(
    "./images/statically-determinate-structure-example-1-4.png",
    height: 15em,
)

To evaluate the virtual load on section $A C$:
- The coordinate system remains the same as the one used for real load.
- The same cutting point $P$ is used, again considering section $A P$ (from
    $x = 0$ to $x = P$)
- Write down all the virtual bending moments in section $A P$ acting around
    point $P$.
- The clockwise positive assumption must also remain the same.

Assuming clockwise is positive:
$ m_(A C) = 1/2 x $

=== Evaluating the virtual load on section $B C$
#cimage(
    "./images/statically-determinate-structure-example-1-5.png",
    height: 15em,
)

To evaluate the virtual load on section $B C$:
- The coordinate system remains the same as the one used for real load.
- The same cutting point $P$ is used, again considering section $A P$ (from
    $x = 0$ to $x = P$)
- Write down all the virtual bending moments in section $B P$ acting around
    point $P$.
- The counter-clockwise positive assumption must also remain the same.

Assuming counter-clockwise is positive:
$ m_(B C) = 1/2 x $

#pagebreak()

=== Solving for $Delta_C$
Since the structure only experiences pure bending:
$
    1 dot Delta_C
    = integral_0^(L/2) (frac(M m, E I))_(A C) dif x
    + integral_0^(L/2) (frac(M m, E I))_(B C) dif x
$

$
    1 dot Delta_C = integral_0^(L/2)
    underbrace((1/2 w L x - 1/2 w x^2), M_(A C))
    underbrace((1/2 x), m_(A C)) dif x
    + integral_0^(L/2)
    underbrace((1/2 w L x - 1/2 w x^2), M_(B C))
    underbrace((1/2 x), m_(B C)) dif x
$

Final step: Expand and solve the integrals:
$ 1 dot Delta_C = frac(2, E I) [1/12 w L x^3 - 1/16 w x^4]_0^(L/2) $
$ Delta_C = 5/384 frac(w L^4, E I) $

#pagebreak()

== Example 2: Statically determinate structure, combined loading
The cranked beam $A B C$ is of circular cross-section. Obtain an expression for
the vertical deflection at point $C$ due to load $P$. Consider only bending and
torsional effects. Take $G = 0.4 E$ and $J = 2I$.

#cimage(
    "./images/statically-determinate-structure-example-2-1.png",
    width: 80%,
)

To find $Delta_C$, apply the unit load equation:
$
    1 dot Delta_C =
    (
        integral_0^L frac(M m, E I) dif x
        + integral_0%L frac(T t, G J) dif x
    )_(A B)
    + (integral_0^L frac(M m, E I) dif x)_(B C)
$

#align(center, grid(
    columns: 2,
    column-gutter: 5em,
    [
        Analysis of $A B$:
        $ M = p x wide T = P L $
        $ m = x wide t = l $
    ],
    [
        Analysis of $B C$:
        $ M = P x $
        $ m = x $
    ],
))

$
    1 dot Delta_C & = (
                        integral_0^L frac((P x) (x), E I) dif x
                        + integral_0%L frac((P L)(L), G J) dif x
                    )_(A B)
                    + (integral_0^L frac((P x) (x), E I) dif x)_(B C) \
                  & = frac(P L^3, 3 E I) + frac(P L^3, G J)
                    + frac(P L^3, 3 E I) \
                  & = frac(P L^3, 3 E I) + frac(5 P L^3, 4 E I)
                    + frac(P L^3, 3 E I) \
$
$ therefore Delta_C = 23/12 frac(P L^3, E I) $

== Example 3: Statically determinate structure, pure bending of curved beam
The curved beam of flexural rigidity $E I$ is subjected to a horizontal load $P$
at $B$. Obtain an expression for the *horizontal deflection* and
*cross-sectional rotation* at point $B$. Consider only bending effects.

=== Obtaining $Delta_B$
#grid(
    columns: 2,
    column-gutter: 1em,
    image("./images/statically-determinate-structure-example-3-1.png"),
    image("./images/statically-determinate-structure-example-3-2.png"),
)

To find $Delta_B$, apply the unit load equation:

$ 1 dot Delta_B = (integral_0^L frac(M m, E I) dif s)_(A B) $

Taking counter-clockwise as positive:
$ M = P R sin theta $
$ m = R sin theta $

$
    1 dot Delta_B = (integral_0^L frac(M m, E I) dif s)_(A B)
    = (integral_0^(pi/2) frac(M m, E I) R dif theta)_(A B)
$

$
    1 dot Delta_B =
    1/(E I) integral_0^(pi/2) (P R sin theta) (R sin theta) dif theta
$

$ Delta_B = frac(P R^3, E I) integral_0^(pi/2) sin^2 theta thin dif theta $
$ Delta_B = frac(P R^3, E I) [1/2 theta - 1/4 sin 2 theta]_0^(pi/2) $
$ Delta_B = frac(pi P R^3, 4 E I) $

=== Obtaining $theta_B$
#grid(
    columns: 2,
    column-gutter: 1em,
    image("./images/statically-determinate-structure-example-3-1.png"),
    image("./images/statically-determinate-structure-example-3-3.png"),
)

To find $theta_B$, apply the unit load equation:
$ 1 dot theta_B = (integral_0^L frac(M m, E I) thin dif s)_(A B) $

Taking counter-clockwise as positive:
$ M = P R sin theta $
$ m = 1 $

$
    1 dot theta_B = (integral_0^L frac(M m, E I) dif s)_(A B)
    = (integral_0^(pi/2) frac(M m, E I) R thin dif theta)_(A B)
$

$
    1 dot theta_B
    = 1/(E I) integral_0^(pi/2) (P R sin theta) (1) R thin dif theta
$

$ theta_B = frac(P R^2, E I) integral_0^(pi/2) sin theta thin dif theta $
$ theta_B = [- frac(P R^2, E I) cos theta]^(pi/2)_0 $
$ theta_B = frac(P R^2, E I) $

= Statically indeterminate structures
#cimage("./images/statically-indeterminate-structures.png")

Number of unknown support reactions:
$ r = 4 space (H_A, M_A, V_A, R_B) $

Number of useful static equilibrium equations:
$ n = 3 space ("Always 3 from the application of Newton's laws") $

#align(center, grid(
    columns: 3,
    column-gutter: 1em,
    align: center + horizon,
    [
        Sum of horizontal forces:
        $ H_A = 0 $
    ],
    [
        Sum of vertical forces:
        $ V_A + R_B = w L $
    ],
    [
        Sum of moments:
        $ M_A = frac(w L^2, 2) - R_B L $
    ],
))

Degree of indeterminacy (out of luck if $>=$ 1):
$ r - n = 1 $

The unit load equation can give us one more independent equation:
$ 1 dot Delta_B = integral_0^L frac(M m, E I) dif x = 0 $

#pagebreak()

== Example: Propped (over-supported) cantilever
#cimage(
    "./images/statically-indeterminate-structures-example-1.png",
    height: 25em,
)

Replace support B with a reaction force $R_B$ and treat $R_B$ like an external
force.

Instead of solving for deflection, apply the unit load to solve for $R_B$.

Taking clockwise as positive for moments about point $P$:
$ M = frac(w x^2, 2) - R_B x wide m = 1 dot x $
$
    1 dot Delta_B & = integral_0^L frac(M m, E I) dif x \
                  & = integral_0^L
                    frac((frac(w x^2, 2) - R_B x) (x), E I) dif x \
                  & = frac(1, E I) integral_0^L
                    (frac(w x^2, 2) - R_B x) x thin dif x \
                  & = frac(1, E I) integral_0^L frac(w x^3, 2) - R_B x^2 dif x \
                  & = frac(1, E I) [frac(w x^4, 8) - frac(R_B x^3, 3)]_0^L = 0
$

$ therefore frac(R_B L^3, 3) = frac(w L^4, 8) $
$ R_B = 3/8 w L $

#cimage(
    "./images/statically-indeterminate-structures-example-2.png",
    height: 25em,
)

$R_B$ is now known. Treating $R_B$ as an externally applied force, apply unit
load method for point $C$.

Treating $R_B$ as an externally applied force, apply unit load method for point
$C$.

Note that a discontinuity is introduced by applying the unit load method at
point $C$.

$
    1 dot Delta_C = integral_0^(L/2) (frac(M m, E I))_(A C) dif x
    + integral_0^(L/2) (frac(M m, E I))_(B C) dif x
$

Starting from the free end,
$ M_(B C) = frac(w x^2, 2) - 3/8 w L x wide wide m_(B C) = 0 $

Moving to segment $A C$, #makegreen()[internal forces] and
#makepurple()[moments] are to be transferred from $B C$.

$
    M_(A C) = #makered()[$frac(w x^2, 2)$]
    + (#makegreen()[$frac(w L, 2) - 3/8 w L$]) x
    + #makepurple()[
        $(frac(w L, 2))(L/4) - (3/8 w L) (L/2)$
    ] m_(A C) = 1 dot x
$

#cimage("./images/statically-indeterminate-structures-example-3.png")

Where:
- #makegreen()[$frac(w L, 2)$] is the sum of the distributed load in $B C$
- #makegreen()[$frac(3 w L, 8)$] is the reaction force $R_B$
- #makepurple()[$frac(w L, 2) dot L/4$] is the moment at $C$ due to
    #makegreen()[$frac(w L, 2)$] acting at the midpoint of $B C$
- #makepurple()[$frac(3 w L, 8) dot L/2$] is the moment at $C$ due to $R_B$
    acting across distance $L/2$

#pagebreak()

#cimage(
    "./images/statically-indeterminate-structures-example-2.png",
    height: 25em,
)

$
    1 dot Delta_C & = frac(1, E I) integral_0^(L/2) [
                        #makered()[$frac(w x^2, 2)$]
                        + (#makegreen()[$frac(w L, 2) - 3/8 w L$]) x
                        + #makepurple()[
                            $(frac(w L, 2)) (L/4) - (3/8 w L) (L/2)$
                        ]
                    ] (1 dot x) thin dif x \
          Delta_C & = frac(1, E I) integral_0^(L/2) [
                        #makered()[$frac(w x^3, 2)$]
                        + #makegreen()[$frac(w L x^2, 8)$]
                        - #makepurple()[$frac(w L^2 x, 16)$]
                    ] \
                  & = frac(1, E I) integral_0^(L/2) [
                        #makered()[$frac(w x^4, 8)$]
                        + #makegreen()[$frac(w L x^3, 24)$]
                        - #makepurple()[$frac(w L^2 x^2, 32)$]
                    ]_0^(L/2) \
                  & = frac(1, E I) integral_0^(L/2) [
                        #makered()[$frac(w L^4, 8(16))$]
                        + #makegreen()[$frac(w L^4, 24(8))$]
                        - #makepurple()[$frac(w L^4, 32(4))$]
                    ] \
                  & = frac(1, E I) integral_0^(L/2) [
                        #makered()[$frac(w L^4, 128)$]
                        + #makegreen()[$frac(w L^4, 192)$]
                        - #makepurple()[$frac(w L^4, 128)$]
                    ] \
                  & = frac(w L^4, 192 E I)
$

#pagebreak()

= Elastically yielding supports
#cimage("./images/elastically-yielding-supports-1.png")

Both the beam and the spring (compliant support) store energy by deforming.

The inclusion of a compliant support simply introduces another *virtual
complementary strain energy* term.

$ delta U^* = e delta F $
$ delta U^* = F/k delta F $

We don't know much about $e$, but spring force $F$ can be determined. Hence, the
general expression for the deflection at $B$ is simply:
$
    1 dot Delta_B = integral_0^L frac(M m, E I) dif x
    + #makepurple()[$frac(F_B f_B, K_B)$]
$

Where $f_B$ is the virtual load on the spring.

#cimage("./images/elastically-yielding-supports-2.png")

The concept works similarly with torsional springs.

Assume the fixed end $A$ is compliant, allowing a degree of rotation (with
resistance).

Hence, the general expression for deflection at $B$ now includes the internal
energy of the torsional spring:
$
    1 dot Delta_B = integral_0^L frac(M m, E I) dif x
    + #makered()[$frac(M_A m_A, k_A)$]
    + #makepurple()[$frac(F_B f_B, K_B)$]
$

Note that this is also an *over-supported cantilever*. However, only the new
point $B_0$ has zero displacement.

Point $B$ itself will experience some deflection when the spring is deformed.

#pagebreak()

== Example: Statically indeterminate propped cantilever with elastic supports
Determine the reaction at end $B$ for the propped cantilever beam. The spring
constants for the supports at $A$ and $B$ are #qty[2][kNm rad^-1] and
#qty[10][kN m^-1] respectively. Assume $E = #qty[200][GPa]$ and
$I = 10^(-8) #unit[m^4]$.

#cimage("./images/elastically-yielding-supports-example.png")

Replace the elastic support $B$ with a spring and rigid support $B_0$

Replace the rigid support $B_0$ with reaction force $R_(B 0)$.

Taking clockwise to be positive:
$ M = frac(w x^2, 2) - R_(B 0) x = 100 x^2 - R_(B 0) x $
$ m = 1 dot x $

Taking moments about end $A$:
$ M_A = 200(2)(1) - R_(B 0) wide m_A = 1 dot 2 $

Taking tensile spring force to be positive:
$ F_B = - R_(B 0) wide f_B = 1 $

The direction of the unit load chosen earlier implies the spring is in tension
during virtual analysis.

$
    1 dot Delta_(B 0) & = integral_0^L frac(M m, E I) dif x
                        + frac(M_A m_A, k_A) + frac(F_B f_B, k_B) \
                      & = integral_0^L
                        frac(
                            (100x^2 - R_(B 0) x) (-x),
                            (200 times 10^9) (10^(-8))
                        ) dif x
                        + frac(2 (400 - 2R_(B 0)), 2 times 10^3)
                        - frac(R_(B 0), 10 times 10^3) \
                      & = 0.6 - (3.43 times 10^(-3)) R_(B 0) = 0
$

$ therefore R_(B 0) = #qty[174.9][N] $

Finding the deflection of point $B$:
$
    1 dot Delta_(B 0) & = integral_0^L frac(M m, E I) thin dif x
                        + frac(M_A m_A, k_A) + frac(F_B f_B, k_B) \
                      & = integral_0^2 frac(
                            (100x^2 - R_(B 0) x (-x)),
                            (200 times 10^9)(10^(-8))
                        ) thin dif x
                        - frac(2(400 - R_(B 0)), 2 times 10^3)
                        + frac(R_(B 0), 10 times 10^3) \
                      & = (- 1/5 - 8/6000 R_(B 0)) - (2/5 - 1/500 R_(B 0))
                        + frac(R_(B 0), 10000)
$

$ therefore Delta_B = #qty[0.03449][m] $

#pagebreak()

= Maximum deflection for impact loads

=== Gradual release
<gradual-release>
#figure(
    image("./images/maximum-deflection-for-impact-loads-gradual.png"),
    caption: [
        Gradual release: Visualise it like stop motion, a series of static
        equilibrium positions. Force increases from 0 to $m g$ over a period.
    ],
)

$ W = U $
$ 1/2 m g Delta_s = 1/2 k Delta_s^2 $
$ Delta_s = frac(m g, k) $

=== Instant release
<instant-release>
#figure(
    image("./images/maximum-deflection-for-impact-loads-instant.png"),
    caption: [
        Instant release: Dropped from the same initial position as the #link(
            <gradual-release>,
        )[gradual release case]. Sudden force application of magnitude $m g$.
    ],
)

$ "Change in gravitational potential energy" = U $
$ m g Delta_"dyn" = 1/2 k Delta_"dyn"^2 $
$ Delta_"dyn" = frac(2 m g, k) $

=== Dropped from height
#figure(
    image(
        "./images/maximum-deflection-for-impact-loads-dropped-from-height.png",
    ),
    caption: [
        Dropped from height: Dropped from a higher position than the #link(
            <instant-release>,
        )[instant release case]. Sudden force application of $m g$.
    ],
)

$ "Change in gravitational potential energy" = U $
$ m g (h + Delta_"dyn") = 1/2 k Delta_"dyn"^2 $
$ k Delta_"dyn"^2 - 2 m g Delta_"dyn" - 2 m g h = 0 $
$ Delta_"dyn" = frac(m g, k) plus.minus frac(m g, k) sqrt(1 + frac(2 k h, F)) $

Substituting $Delta_s = frac(m g, k)$:
$ Delta_"dyn" = Delta_s plus.minus Delta_s sqrt(1 + frac(2 h, Delta_s)) $
$ Delta_"dyn" = Delta_s (1 + sqrt(1 + frac(2h, Delta_s))) $

#pagebreak()

= Brittle fracture

== Fracture behaviour and ductility
The image below shows the stress-strain behaviour of brittle materials compared
to that of more ductile materials.

#cimage("./images/fracture-behaviour-and-ductility.png", height: 25em)
#cimage("./images/ductile-and-brittle-fractures.png")

== Surface energy ($U_s$)
Surface energy is the energy required to form a new solid surface.

#cimage("./images/surface-energy-diagram.png", height: 25em)

== Strain energy ($U_e$)
#cimage("./images/strain-energy-diagram.png")

$ delta_"max" = frac(P l^3, 3 E I) $
$ U_e = P delta_"max" = frac(P^2 l^3, 3 E I) $

#pagebreak()

== Strain energy release rate
$
    frac(dif U_"Total", dif a) = frac(
        dif (overbrace(U_s, "Surface energy")
            + overbrace(U_e, "Strain energy")),
        dif underbrace(a, "Crack length")
    ) = 0
$

#cimage("./images/strain-energy-release-rate-graph.png")
#pagebreak()

=== Centre crack
#align(center, grid(
    columns: 3,
    column-gutter: 3em,
    align: center + horizon,
    [
        *Surface energy*

        $ U_s = (2 a) 2 gamma = (2 a) G $
    ],
    [
        *Strain energy*

        $ U_e = - frac(pi sigma^2 a^2, E) $
    ],
    image(
        "./images/strain-energy-release-rate-crack-diagram.png",
        height: 12em,
    ),
))

Where $G$ is the energy absorbed by crack surfaces when the crack grows by a
unit length.

Change in surface energy:
$ Delta U_s = frac(dif U_s, dif a) Delta a = (2 G) Delta a $

Change in strain energy:
$
    Delta U_e = frac(dif U_e, dif a) Delta a =
    - (2 frac(pi sigma^2 a, E) k) Delta a
$

$ Delta U_s + Delta U_e = 0 $
$ G = frac(pi sigma^2 a, E) k $

Where:
- $k = 1$ for a thin plate, or plane stress situation
- $k = (1 - nu^2)$ for a thick block, or plane strain situation

=== Difference between $G$ and $G_c$
- $G$ is the strain energy release rate (#unit[J m^-2]).
- This is a measure of the tendency of the crack to grow, leading to a fracture.
- It is calculated based on the given stress level $s$ and crack length $a$.
    $ G = frac(pi sigma^2 a, E) $

- $G_c$ is the *critical* strain energy release rate (#unit[J m^-2]).
- This is a material property determined by experiments.

    $ G_c = frac(pi sigma_f^2 a_c, E) $

    Where:
    - $sigma_f$ is the fracture stress, or the stress level at which fracture
        takes place.
    - $a_c$ is the critical crack half-length, or half the crack length at which
        the fracture takes place.
- Fracture criteria:
    - If $G >= G_c$, fracture takes place, i.e. the crack becomes unstable.
    - If $G < G_c$, fracture does not take place, i.e. the crack is stable.

=== Condition for crack growth
A high value of $G_c$ for a given material means that it is hard for cracks to
propagate in that material, which means the material has a high fracture
resistance. For example:
$ G_c approx #qty[0.01][kJ m^-2] "for glass" $
$ G_c approx #qty[10][kJ m^-2] "for copper" $

Copper has a higher fracture strength than glass.

Units of $G$ or $G_c$ is #unit[kJ m^-2] or #unit[kN m^-1].

=== Example problem 1
Consider a thin infinite plate of glass with Young's modulus $E = #qty[69][GPa]$
(#unit[GN m^-2]) having a single through-thickness crack of length
$2a = #qty[0.42][mm]$. When the tensile stress $sigma$ is increased to
#qty[33][MPa m^-2], the crack becomes unstable and the glass plate fractures.
Determine the $G_c$ for glass. Assume plane stress condition.

#cimage("./images/strain-energy-release-rate-example-1.png", height: 30em)

$
    G_c & = frac(pi sigma_f^2 a_c, E) \
        & = frac(pi (33 times 10^6)^2 (0.21 times 10^(-3)), 68 times 10^9) \
        & = #qty[10.41][J m^-2] \
        & = #qty[0.01041][kJ m^-2]
$

#pagebreak()

=== Example problem 2
Consider a thin infinite plate of glass with $G_c = #qty[0.01][kJ m^-2]$ and
$E = #qty[69][GPa]$ (#unit[GN m^-2]). Determine a few combinations of stress
levels and crack lengths that will cause fracture, i.e. that will make the crack
unstable. What is your conclusion from these values? Assume plane stress
condition.

#cimage("./images/strain-energy-release-rate-example-2.png")

$ G_c = frac(pi sigma^2 a_c, E) $
$ frac(G_c E, pi) = sigma^2 a $
$
    sigma^2 a = frac((0.01 times 10^3) (69 times 10^9), pi dot 1)
    = 2.196 times 10^(11)
$
$ a = frac(2.196 times 10^(11), sigma^2) $
$ 2a = frac(4.393 times 10^(11), sigma^2) $

Hence, assuming $sigma$ to calculate $a$:
$ sigma = 100 times 10^6 quad => quad 2a = 43.93 times 10^(-6) $
$ sigma = 75 times 10^6 quad => quad 2a = 78.09 times 10^(-6) $
$ sigma = 50 times 10^6 quad => quad 2a = 175.72 times 10^(-6) $
$ sigma = 50 times 10^6 quad => quad 2a = 702.88 times 10^(-6) $

If the stress level is low, a larger crack length is tolerated.

== Stress concentration
#cimage("./images/stress-concentration.png")
#cimage("./images/stress-concentration-graph.png")
#pagebreak()

== Linear elastic fracture mechanics (LEFM)
The equations for the *stress distribution in the vicinity of a crack tip* (for
a central crack in an infinite plate) are as follows:
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        $
            sigma_x = frac(K_I, (2 pi)^(1/2)) cos (theta/2)
            [1 - sin (theta/2) sin (frac(3 theta, 2))]
        $

        $
            sigma_y = frac(K_I, (2 pi r)^(1/2)) cos (theta/2)
            [1 + sin (theta/2) sin (frac(3 theta, 2))]
        $
        $
            tau_(x y) = frac(K_I, (2 pi r)^(1/2)) cos (theta/2)
            sin (theta/2) cos (frac(3 theta, 2))
        $
        $
            sigma_z = frac(2 nu_I, (2 pi r)^(1/2)) cos (theta/2)
            quad "plane strain"
        $
        $ sigma_z = 0 quad "plane stress" $
    ],
    image("./images/linear-elastic-fracture-mechanics.png"),
)


=== Stress intensity factor
- Cracks and flaws cause *stress concentration*.
- Linear elastic fracture mechanics (LEFM)
    - Brittle fracture
    - Stress field at crack tip

#cimage(
    "./images/linear-elastic-fracture-mechanics-stress-intensity.png",
    height: 25em,
)

$ sigma_"tip" = frac(K_I, sqrt(2 pi r)) $

The stress the at tip exceeds the yield stress:
$ r -> 0; quad sigma -> oo $

== Fracture toughness ($K_(I)$)
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        The fracture starts at a place where stress concentration is the
        highest.
        $ K_I = Y sigma sqrt(pi a) $

        Where:
        - $K_I$ is the stress intensity factor
        - $sigma$ is the applied nominal stress
        - $a$ is half the edge crack length
        - $Y$ is a geometric constant

        Fracture criteria:
        $ K_I > K_(I C) $

        Where $K_(I C)$ is the critical value of the stress intensity factor
        (fracture toughness) as is defined as follows:

        $ K_(I C) = Y sigma_f sqrt(pi a_c) $

        Where:
        - $sigma_f$ is the fracture stress
        - $a_c$ is the critical crack half-length

        The higher the $K_(I C)$ value, the tougher the metal.
    ],
    image("./images/irwins-theory-of-fracture.png"),
)

=== Typical fracture toughness
#cimage("./images/typical-fracture-toughness.png")
#pagebreak()

=== Demonstration with pre-cracked paper
$ K_(I C) = Y sigma_f sqrt(pi a_c) $

- For a material with fixed fracture toughness, increasing the crack length will
    reduce fracture stress.
- Under the same stress, the material fails when the crack length exceeds the
    critical length ($a_c$).
- $a_c$ increases with decreasing applied stress.

=== Example problem 1
A structural plate component of an engineering design must support
#qty[207][MPa] (#unit[Mn m^-2]) in tension. If aluminium alloy 2024-T851 is used
for this application, what is the largest internal crack size that this material
can support? Use $Y = 1$.

#cimage("./images/fracture-toughness-example-1.png")

$ K_(I C) = Y sigma_f sqrt(pi a_c) $

From the table, $K_(I C) = #qty[26.4][MPa m^1/2]$ (#unit[MN m^-3/2]).
$
    a_c = 1/pi (frac(K_(I C), Y sigma_f))^2
    = 1/pi (frac(#qty[26.4][MPa m^1/2], 1 times #qty[207][MPa]))^2
    = #qty[0.00518][m]
    = #qty[5.18][mm]
$

Thus, the largest internal crack size that this material can support is
$2 a = #qty[10.36][mm]$.

#pagebreak()

=== Example problem 2
A thin pressure vessel is to be fabricated from *large* plates of steel, which
may be high strength steel with a design stress $sigma = #qty[950][MPa]$ and
fracture toughness $K_(I C) = #qty[82][MPa m^1/2]$, or low carbon steel with
design stress $sigma = #qty[250][MPa]$ and fracture toughness
$K_(I C) = #qty[50][MPa m^1/2]$. Which of these two plates of steel has better
tolerance to defects?

- A material is said to have better tolerance to defects if it can tolerate a
    larger defect size without fracture.
- So, first, we need to calculate the maximum defect size tolerated by the two
    steel materials.
- Then, we can conclude which one of them has higher tolerance to defects.

$ K_(I C) = sigma_f (pi a_c)^(1/2) $

For high strength steel:
$ K_(I C) = #qty[82][MPa m^1/2], quad sigma = #qty[950][MPa] $
$ a_c = frac(K_(I C)^2, pi sigma_f^2) = #qty[0.0024][m] = #qty[2.37][mm] $

For low carbon steel:
$ K_(I C) = #qty[50][MPa m^1/2], quad sigma = #qty[250][MPa] $
$ a_c = frac(K_(I C)^2, pi sigma_f^2) = #qty[0.01273][m] = #qty[12.73][mm] $

Low carbon steel permits a larger defect size, so it has better tolerance to
defects.

=== Relation between $G_c$ and $K_(I C)$

The critical stress intensity factor ($K_(I C)$) is also called the fracture
toughness. Fracture toughness is a material property.

$ K_(I C) = sigma_f (pi a_c)^(1/2) $

Where:
- $sigma_f$ is the fracture stress
- $a_c$ is half-length of the crack just before fracture

Strain energy release rate:
$ G_c = frac(pi sigma_f^2 a_c, E) k $

$k = 1$ for *plane stress* and $k = (1 - nu^2)$ for *plane strain*.

$
    frac(E G_c, k) = pi sigma_f^2 a_c quad
    -> quad (frac(E G_c, k))^(1/2) = sigma_f (pi a_c)^(1/2)
$

Relation between $G_c$ and $K_(I C)$:
$ K_(I C) = (frac(E G_c, k))^(1/2) $

=== Example problem 3
Consider a thin infinite plate of glass with Young's modulus $E = #qty[69][GPa]$
having a single through crack of length $2a = #qty[0.42][mm]$. When the tensile
stress ($s$) is increased to #qty[33][MPa], the glass plate fractures. Determine
the fracture toughness ($K_c$) for glass. Therefore, determine the critical
strain energy release rate ($G_c$). Assume plane stress condition.

We know:
$ K_(I C) = sigma_f (pi a_c)^(1/2) $
$
    K_(I C) = 33 (pi times 0.21 times 10^(-3))^(1/2)
    = #qty[0.847][MPa m^1/2]
    = #qty[847615][N m^-3/2]
$

We know $G_c$ and $K_(I C)$ are related:
$ (E G_c)^(1/2) = K_(I C) quad ("Plane stress") $
$
    therefore G_c = frac((K_(I C))^2, E)
    = frac((847615)^2, E)
    = #qty[10.41][J m^2]
    = #qty[0.01041][kJ m^-2]
$

=== Fracture toughness vs strength
#cimage("./images/fracture-toughness-vs-strength.jpg")

=== Geometry correction factor ($Y$) [Given in the exam]
#cimage("./images/geometry-correction-factor.png", width: 70%)

$ K_I = Y sigma sqrt(pi a) $

==== Large sheet

$ K_I = sigma sqrt(pi a) underbrace((1), Y) $

==== Finite width plate
#cimage(
    "./images/geometry-correction-factor-finite-width-plate.png",
    height: 15em,
)

$
    K_I = sigma sqrt(pi a)
    underbrace((frac(W, pi a) tan frac(pi a, W))^(1/2), Y)
$

==== Double-edge crack
#cimage(
    "./images/geometry-correction-factor-double-edge-crack.png",
    height: 15em,
)

$
    K_I = sigma sqrt(pi a) underbrace(
        (
            frac(W, pi a) tan frac(pi a, W) +
            frac(0.2 W, pi a) sin frac(pi a, W)
        )^(1/2),
        Y
    )
$

==== Single-edge crack
#cimage(
    "./images/geometry-correction-factor-single-edge-crack.png",
    height: 15em,
)

$
    K_I = sigma sqrt(pi a) underbrace(
        [1.12 - 0.23 (a/W) + 10.6 (a/W)^2 - 21.7 (a/W)^3 + 30.4 (a/W)^4],
        Y
    )
$

#pagebreak()

==== Internal penny crack
#cimage(
    "./images/geometry-correction-factor-internal-penny-crack.png",
    height: 15em,
)

$ K_I = sigma sqrt(pi a) underbrace((2/pi), Y) $

==== Elliptical surface crack
#cimage(
    "./images/geometry-correction-factor-elliptical-surface-crack.png",
    height: 15em,
)

$ K_I = sigma sqrt(pi a) underbrace((frac(1.12, phi.alt^(1/2))), Y) $

#pagebreak()

==== 3-point bending
#cimage("./images/geometry-correction-factor-3-point-bending.png", height: 15em)

$
    K_I = frac(3 F L, 2 B W^(3/2)) underbrace(
        [
            1.93 (a/W)^(1/2) - 3.07 (a/W)^(3/2) + 14.53 (a/W)^(5/2)
            - 25.11 (a/W)^(7/2) + 25.8 (a/W)^(9/2)
        ],
        Y
    )
$

#cimage(
    "./images/geometry-correction-factor-elliptical-crack-graph.png",
    height: 15em,
)

#pagebreak()

=== Example problem 4
A finite rectangular plate of length #qty[300][mm], width #qty[100][mm] and
thickness #qty[10][mm] has a central crack of #qty[10][mm] length and carries a
tensile load of #qty[100][kN]. Determine the stress intensity factor $K$. Check
if the plate will fracture. The plate is made of "alloy steel 4340" with a
fracture toughness $K_(I C) = #qty[60.4][MPa m^1/2]$. You may treat the material
as brittle.

$
    K_I = sigma sqrt(pi a)
    underbrace((frac(W, pi a) tan frac(pi a, W))^(1/2), Y)
$

$ W = #qty[100][mm] = #qty[0.1][m] $
$ B = #qty[10][mm] = #qty[0.01][m] $
$ P = #qty[100][kN] = 100 times 10^3 N $

$ sigma = frac(P, W B) = 100 times 10^6 #unit[Pa] = #qty[100][MPa] $
$ a = 10/2 #unit[mm] = 5 times 10^(-3) #unit[m] $

$
    therefore K_I = 100 (pi times 5 times 10^(-3))^(1/2)
    overbrace(
        (
            frac(0.1, pi times 5 times 10^(-3))
            tan frac(pi times 5 times 10^(-3), 0.1)
        )^(1/2),
        Y = 1.004
    )
    = #qty[12.64][MPa m^1/2]
$

$ K_(I C) = #qty[60.4][MPa m^1/2] space ("given") $

Since $K < K_(I C)$, the plate will not fracture.

=== Modes of fracture
There are three modes of fracture.

#cimage("./images/modes-of-fracture.png")

Thus, one can calculate the stress intensity factors corresponding to each of
the modes, $K_"I"$, $K_"II"$, $K_"III"$, corresponding to mode I, II, III,
respectively. One can also talk about fracture toughness $K_("IC'")$,
$K_("IIC'")$, $K_("IIIC'")$, corresponding to mode I, II, III, respectively.

#pagebreak()

=== Fracture toughness testing
3 point bending tests.

#cimage("./images/fracture-toughness-testing.png")

=== Variation of fracture toughness with plate thickness
It has been well established that the fracture toughness decreases with the
increase in plate thickness as shown.

For *thin* plates, *plane stress* condition prevails, and the fracture is
*ductile* (shear in nature).

For *thick* plates, *plane strain* conditions prevails, and the fracture is
*brittle* in nature.

The measured fracture toughness reaches the lowest (*most conservative*) value
for the thickest specimen, i.e. under plane strain condition.

=== Plane stress vs plane strain
#cimage("./images/plane-stress-vs-plane-strain-1.png")
#cimage("./images/plane-stress-vs-plane-strain-2.png")

=== Variation of fracture toughness with plate thickness
#cimage("./images/variations-of-fracture-toughness-with-plate-thickness.png")
In the experimental determination of fracture toughness, we must always ensure
plane strain condition exists to obtain the lowest (most conservative) possible
estimate for fracture toughness. This value of fracture toughness denoted by the
symbol $K_(I C)$ and is often called the *plane strain fracture toughness*. This
value of fracture toughness denoted by the symbol $K_(I C)$ and is often called
the *plane strain fracture toughness*. $K_(I C)$ is commonly used in all design
calculations.

=== Experimental determination of plane strain fracture toughness, $K_(I C)$
Two common types of *test specimens* are used:
#cimage("./images/fracture-toughness-experimental-test-specimens.png")

In real life, you must refer to testing standards for fine details of the
experimental procedure (i.e. *ASTM E399*).

==== Procedure
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        The specimens have a carefully machined notch which may have *plane
        front* or *chevron profile*. Chevron profile is useful to keep the crack
        in a plane. This helps reproducibility of results.

        To get a sharp *pre-crack*, the specimen with the machined notch is
        subjected to cyclically varying force. Thereby, a sharp crack is
        initiated due to *fatigue mechanism*. A crack length of at least
        #qty[1.25][mm] is produced by this process.

        The specimen is then loaded gradually in a testing machine until
        fracture.
    ],
    image("./images/fracture-toughness-experimental-procedure-1.png"),
)

#cimage("./images/fracture-toughness-experimental-procedure-2.png")

#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 2em,
    image("./images/fracture-toughness-experimental-procedure-bending.png"),
    image(
        "./images/fracture-toughness-experimental-procedure-tension.png",
        height: 20em,
    ),

    [
        *Bending*

        $ K_Q = frac(F_Q, B W^(1/2)) f_1 (a/W) $
    ],
    [
        *Compact tension*

        $ K_Q = frac(F_Q, B W^(1/2)) f_2 (a/W) $
    ],
)

The values of $f_1 (a/W)$ and $f_2 (a/W)$ are to be chosen from the table below
(given in the exam):
#let table-3-1 = [
    #table(
        columns: 12,
        align: center + horizon,
        table.header(table.cell(colspan: 12)[*Table 3.1*]),

        $a/W$,
        [0.45],
        [0.46],
        [0.47],
        [0.48],
        [0.49],
        [0.5],
        [0.51],
        [0.52],
        [0.53],
        [0.54],
        [0.55],

        $f_1 (a/W)^*$,
        [9.1],
        [9.37],
        [9.66],
        [9.96],
        [10.28],
        [10.61],
        [10.96],
        [11.33],
        [11.71],
        [12.12],
        [12.55],

        $f_2 (a/W)^Ϯ$,
        [8.34],
        [8.57],
        [8.81],
        [9.06],
        [9.32],
        [9.6],
        [9.9],
        [10.21],
        [10.54],
        [10.89],
        [11.26],
    )

    Where:
    - \* is 3-point bending (for support span = #qty[4][W])
    - Ϯ is tension
]

#table-3-1

Note that in *Type I*, $F_"max"$ occurs outside the initial slope line and 95%
slope line. In *Type I*, the following condition must be satisfied for the test
to be valid:
$ F_"max"/F_Q < 1.1 $

If this condition is not met, the test procedure is aborted, as plane strain
behaviour does not exist for the given material.

The tentative value of $K_Q$ is thus calculated and accepted as a valid estimate
of plane strain fracture toughness $K_(I C)$, only if the following conditions
are satisfied:
$
    "We take" bold(K_(I C) = K_Q) "if" cases(
        B\, a\, (W - a)
        >= 2.5 (frac(K_Q, sigma Y))^2,
        0.45 < (a/W) < 0.55
    )
$

#pagebreak()

= Crack tip plasticity

== Ductile vs brittle fractures
#cimage("./images/ductile-vs-brittle-fractures.png")

== Linear elastic fracture mechanics
#cimage("./images/linear-elastic-fracture-mechanics-graph.png")

=== For moderately ductile materials (Irwin's modification)
#cimage("./images/linear-elastic-fracture-mechanics-irwins.png")

Original crack:
$ sigma_y = frac(K_I, sqrt(2 pi r)) "where" K_I = sigma sqrt(pi a) $

Modified crack:
$
    sigma_y = frac(K_I^*, sqrt(2 pi r^*)) "where" K_I^*
    = sigma sqrt(pi (a + r_p))
$

#cimage("./images/effective-vs-actual-crack.png")
#pagebreak()

=== Plastic zone
The *plastic zone correction* helps us to treat a moderately ductile fracture
problem as an equivalent brittle fracture problem (i.e. as a LEFM problem) *as
long as the size of the plastic zone is small*.

$ K = sigma sqrt(pi a') = sigma sqrt(pi (a + r_p)) $

#grid(
    columns: 3,
    column-gutter: 2em,
    image("./images/plastic-zone-diagram.png"),
    image("./images/plastic-zone-actual-shape.png"),
    image("./images/plastic-zone-crack.png", height: 15em),
)

==== Radius of plastic zone ($r_p$)
#cimage("./images/plastic-zone-actual-shape.png", height: 15em)

The *radius of plastic zone* $r_p$ can be calculated using:

For plane stress:
$ r_p = frac(1, 2 pi) (frac(K, sigma_y))^2 $

For plane strain:
$ r_p = frac(1, 6 pi) (frac(K, sigma_y))^2 $

Where:
- $K$ is the stress intensity factor
- $sigma_y$ is the yield stress

=== Example 1
A large thin sheet of aluminium alloy has a central through-thickness crack of
#qty[25][mm] length. If the fracture stress for the sheet is #qty[200][MPa] and
the yield stress for the material is #qty[400][MPa], calculate an estimate of
fracture toughness ($K_c$) of the material using:
+ LEFM (brittle fracture theory)
+ The plastic zone correction. You may assume plane stress state. The assumption
    is reasonable because the sheet is thin.

#cimage("./images/crack-tip-plasticity-example-1.png", height: 15em)

+ *LEFM*
    $
        K_(I C) & = sigma (pi a_c)^(1/2) \
                & = 200 (pi (0.025/2))^(1/2) \
                & = #qty[36.9][MPa m^1/2]
    $

    The above is the uncorrected fracture toughness.

+ *Plastic zone correction*
    $
        r_p & = frac(1, 2 pi) (frac(K, sigma_y))^2
              = frac(1, 2 pi) (39.6/400)^2 \
            & = #qty[0.0015625][m]
    $
    $
        K_(I C) & = sigma sqrt(pi (a + r_p)) quad ("corrected") \
                & = 200 (pi (0.025/2 + 0.0015625))^(1/2) \
                & = #qty[42.0][MPa m^1/2]
    $

    The above is the corrected fracture toughness.

The percentage change in $K$ due to correction is about 6%.

#pagebreak()

=== Example 2
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        A #qty[20][mm] thick large plate of alloy steel contains a central
        through-thickness crack of length #qty[16][mm]. The plate is subjected
        to a tensile stress of #qty[350][MPa]. The yield stress of the material
        is #qty[1400][MPa].

        Calculate the radius of plastic zone and the corrected stress intensity
        factor, taking into account the crack tip plasticity.

        If the yield stress of the material dropped to #qty[385][MPa] due to
        welding (high temperature) during service, what would be the new radius
        of plastic zone under the same applied stress of #qty[350][MPa]? Is the
        LEFM approach valid for this case?
    ],
    image("./images/crack-tip-plasticity-example-2.png", height: 15em),
)


Infinite plate solution:
$
    K_I & = sigma sqrt(pi a) \
        & = 350 (pi (0.016/2))^(1/2) \
        & = #qty[55.49][MPa m^1/2]
$

Assume plane stress state with a larger plastic zone ($r_p$), leading to a
larger value of corrected stress intensity factor $K_I$, which is a more
conservative estimate.

Yield strength = #qty[1400][MPa]:
$
    r_p = frac(1, 2 pi) (frac(K, sigma_y))^2
    = frac(1, 2 pi) (55.49/1400)^2 = #qty[0.00025][m] = #qty[0.25][mm]
$

$
    K_(I space ("corrected")) = sigma sqrt(pi (a + r_p))
    = 350 (pi (0.016/2 + 0.00025))^(1/2)
    = #qty[56.35][MPa m^1/2]
$

The percentage change in $K$ due to correction is about 1.5%.

Infinite plate solution:
$ K_I = #qty[55.49][MPa m^1/2] $

Yield strength dropped from #qty[1400][MPa] to #qty[385][MPa] due to welding:
$
    r_p = frac(1, 2 pi) (frac(K, sigma_y))^2
    = frac(1, 2 pi) (55.49/385)^2 = #qty[0.00331][m] = #qty[3.31][mm]
$
$
    K_(I space ("corrected")) = sigma sqrt(pi (a + r_p))
    = 350 (pi (0.016/2 + 0.00331))^(1/2) = #qty[65.97][MPa m^1/2]
$

The percentage change in $K$ due to plastic zone correction is about 18.9%. When
the applied stress is near yield strength, LEFM may not be conservative.

= Ductile fracture

== Limitations of plastic zone correction
#grid(
    columns: 2,
    column-gutter: 2em,
    image("./images/ductile-vs-brittle-fractures.png"),
    image(
        "./images/linear-elastic-fracture-mechanics-irwins.png",
    ),

    $ r_p = frac(1, 2pi) (frac(K_I, sigma_y))^2 quad ("plane stress") $,
    $ r_p = frac(1, 6pi) (frac(K_I, sigma_y))^2 quad ("plane strain") $,
)

== Crack tip opening displacement (COD)
#cimage("./images/crack-tip-opening-displacement.png")

- Due to large plasticity at the crack tip, the *crack tip is opened up
    permanently* due to the plastic deformation at the crack tip.
- Alan Wells (1961) proposed the use of critical value of *crack-tip opening
    displacement ($delta_c$)* as the plastic correction to the fracture
    toughness.

#pagebreak()

=== Method
Most laboratory measurements of COD have been made on edge-cracked specimens
loaded in three-point bending.

$
    delta_c = underbrace(frac(K_c^2 (1 - nu^2), 2 sigma_y E), "Elastic")
    + underbrace(frac(0.4 (W - a) V_p, 0.4 W + 0.6a + z), "Plastic")
$

#cimage("./images/crack-tip-opening-displacement-elastic-and-plastic.png")

#grid(
    columns: 2,
    column-gutter: 2em,
    image("./images/crack-tip-opening-displacement-bending.png"),
    image(
        "./images/crack-tip-opening-displacement-bending-graph.png",
        height: 19.9em,
    ),
)

Bending:
$ K_c = frac(F_C, B W^(1/2)) f_1 (a/W) $
$
    delta_C = frac(K_c^2 (1 - nu^2), 2 sigma_y E)
    + frac(0.4(W - a) V_p, 0.4 W + 0.6a + z)
$

#table-3-1

#pagebreak()

==== Steps
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        + The $F$ versus $V_g$ graph is drawn as shown above, on the right side.
        + The *peak force* $F_c$ corresponding to the onset of crack extension
            is noted.
        + The *plastic part of the clip gauge displacement* $V_p$ (marked in the
            graph) is determined.
        + The *critical stress intensity factor* $K_(I C)$ (now corrected for
            the plastic zone), can be determined from the formulas:

            For plane stress:
            $ delta_c = frac(K_(I C)^2, lambda sigma_y E) $

            For plane strain:
            $ delta_c = frac(K_(I C)^2 (1 - nu^2), lambda sigma_y E) $
    ],
)

#cimage("./images/crack-tip-opening-displacement-method.png")

As per the theory, $1 <= lambda <= 2$. However, experimental measurements have
shown it to be $approx 1$ for both plane stress and plane strain. So we can take
a value of unity (1) for all our calculations.

The method requires a *fine mesh* in finite element method (FEM) to simulate the
crack tip opening. AS a result, it is computationally intensive for complex 3D
geometry.

#cimage("./images/crack-tip-opening-displacement-fine-mesh.png", height: 20em)

== J-integral
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - The *integral is path independent*, which means you may choose any
            contour around the crack for evaluating the contour integral.
        - It is defined as follows:
            $
                J = integral_C
                {w thin dif y - bold(T) (frac(partial bold(u), partial x))}
                thin dif s
            $
            $ w = integral_0^epsilon sigma thin dif epsilon $

            Where:
            - The integral is a *line integral along any contour* $C$
                surrounding the crack tip (starting from the lower crack surface
                and moving *anticlockwise* to the supper crack surface as shown
                in the figure)
            - $w$ is the strain energy density
            - $bold(T)$ is the traction vector, $bold(T) = bold(s) dot bold(n)$
            - $dif s$ is the infinitesimal length along the contour
            - $bold(u)$ is the displacement vector
    ],
    image("./images/j-integral-diagram.png", height: 15em),
)

The *critical value* of $J$ corresponding to the onset of crack extension is
denoted as $J_c$. For *linear elastic materials*:
$ J_c equiv G_c $

Hence, $J$ represents the energy released per unit area of crack extension.

=== Physical interpretation
Physically, the $J$ value may be interpreted as the *difference in the strain
energy* or *external work done* between two identically loaded plates with one
having crack length $a$ and the other having crack length $a + dif a$, divided
by the increase in surface area of the crack. This interpretation gives a simple
expression for the J-integral:

$ J = - 1/B frac(partial U, partial a) quad (#unit[J m^-2]) $

Where:
- $U$ is the strain energy or the work done (the area under the
    force-displacement curve)
- $a$ is half of the crack length
- $B$ is the thickness of the specimen

#cimage("./images/j-integral-physical-interpretation.png")
#pagebreak()

=== Determining $J$ by experiment
If standard test specimens are used, the $J$ value corresponding to any
particular load can be calculated easily using the formula:

$ J = frac(2 U, B (W - a)) $

#cimage("./images/j-integral-experiment.png")

Where:
- $U$ is the strain energy or work done (the total area under the
    force-displacement curve)
- $B$ is the specimen thickness
- $W$ is the specimen width
- $a$ is half of the crack length
- $F$ is the force
- $u$ is the load-line displacement

==== Example
A mild steel bend test specimen has a thickness ($B$) of #qty[20][mm] and width
($W$) of #qty[25][mm] and is loaded as shown. At the onset of crack extension,
the crack length ($a$) is 15.#qty[3][mm] and the area under the
load-displacement graph is 14.#qty[71][J]. If the Young’s modulus of steel is
#qty[207][GPa], calculate $J_c$ and hence the fracture toughness $K_c$. Assume
plane stress.

#cimage("./images/j-integral-example.png", width: 45%)

$
    J_c = frac(2 U, B (W - a))
    = frac(2(14.71), 0.02(0.025 - 0.0153))
    = #qty[151546.1][J m^-2]
    = #qty[151.5][kJ m^-2]
$

$ (E G_c)^(1/2) = K_c quad ("for plane stress") $
$ (E J_c)^(1/2) = K_c quad because J_c = G_c $

$
    therefore K_c = (207 times 10^9 times 151.1 times 10^3)^(1/2) #unit[Nm^-3/2]
    = #qty[177][MPa m^1/2]
$

#pagebreak()

== Impact testing
There are two forms of *traditional quality control tests* widely used in
practice:
- Charpy impact test
- Izod impact test

These test are useful to determine *how much energy is absorbed by materials
before fracture*. This energy is called the *impact strength* and characterises
the fracture toughness of materials in some sense.

$ "Impact strength" = "Difference in potential energy before and after impact" $
$ E = m g H_1 - m g H_2 $

#cimage("./images/impact-testing-pendulum.png")
#pagebreak()

=== Charpy V-notch test
#figure(
    image("./images/charpy-v-notch-test.png"),
    caption: [
        Two Charpy V-notch specimens, thickness #qty[10][mm]. Brittle failure in
        the font specimen tested below the transition temperature, and ductile
        failure in the rear specimen tested above the transition temperature.
    ],
)

#cimage("./images/charpy-correlation-data.png")

=== Correlation between fracture toughness and impact strength
Impact strength measurements do not translate to fracture toughness, but they
are linearly related to fracture toughness. Because of the linear relation, they
are widely used in industries in quality control tests.

#cimage(
    "./images/correlation-between-fracture-toughness-and-impact-strength.png",
)

#pagebreak()

= Fatigue
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - Metals often fail at much lower stress at *cyclic loading* compared to
            static loading.
        - Crack nucleates at region of stress concentration and propagates due
            to cyclic loading.
        - Failure occurs when the cross-sectional area of the metal is too small
            to withstand the applied load.
    ],
    image(
        "./images/fatigue-fractured-surface-of-keyed-shaft.png",
        height: 10em,
    ),
)

== Crack initiation
#figure(
    image("./images/crack-initiation-diagram.png", height: 20em),
    caption: [
        *Stage I (Crack initiation)* and Stage II (Crack growth) of
        polycrystalline material.
    ],
)

Mechanism of the formation of slip band extrusions and intrusions:

#cimage(
    "./images/formation-of-slip-band-extrusions-and-intrusions.png",
)

- Slip band with extrusion and intrusion is formed on the surface of a grain
    subjected to cyclic stress.
- Crack nucleation occurs at intrusion.
- Since the extrusion and intrusion are formed on the surface, *crack
    initiation* is highly dependent on the *state of the surface*.

=== In fatigue testing
Alternating *compression and tension* loads are applied on the metal piece
tapered towards the centre.

#figure(
    image("./images/reversed-bending-fatigue-machine.png", width: 70%),
    caption: [Reversed-bending fatigue machine],
)

#cimage("./images/crack-initiation-fatigue-testing.png", width: 60%)

- It is possible to do the fatigue test without rotation just by cyclically
    varying the applied bending load.
- The advantage of this type of test is that we can apply a *mean bending stress
    plus the cyclically varying bending stress*.
- Thus, the effect of mean bending stress can be investigated using this test.
- Other examples:
    - Electromagnetic actuation (often aided by a resonant vibration system)
    - Actuation by out-of balance rotating mass
    - Actuation by hydraulic pulsation

#figure(
    image("./images/tensile-fatigue-machine.png", height: 15em),
    caption: [Tensile fatigue machine],
)

== Types of fatigue
+ Low cycle fatigue (LCF)
    - Low frequency cyclic loading
    - Examples:
        - MRT door opening
        - Starting a car engine
    - *Thousands* of cycles

+ High cycle fatigue (HCF)
    - High frequency cyclic loading
    - Vibration resonance
    - Examples:
        - Rotating engine components
        - Motorcycle tail pipe
    - *Millions* of cycles

+ Thermo-mechanical fatigue (TMF)
    - Coupling between mechanical load and thermal load
    - Thermal load due to thermal gradient (expansion and contraction)
    - Examples:
        - Jet engine turbine blade
        - Heating furnace
    - *Thousands* of cycles

== Cyclic stresses
Different types of stress cycles are possible (axial, torsional and flexural).

#grid(
    columns: 3,
    column-gutter: 2em,
    image("./images/completely-reversed-stress-cycle.png"),
    image("./images/repeated-stress-cycle-with-equal-min-and-max.png"),
    image("./images/random-stress-cycle.png"),
)

$ "Stress amplitude" = S_a = sigma_a = frac(sigma_"max" - sigma_"min", 2) $
$ "Stress range" = S_R = sigma_r = sigma_"max" - sigma_"min" $
$ "Mean stress" = S_m = sigma_m = frac(sigma_"max" + sigma_"min", 2) $
$ "Stress ratio" = R = frac(sigma_"max", sigma_"min") $

=== Material life
#cimage("./images/material-life-under-cyclic-loading.png")

== $S$-$N$ curve
$S$-$N$ curves are curves where the *stress amplitude* ($S$) is plotted on the
vertical axis and the *number of cycles to failure* ($N$) is plotted on the
horizontal axis.

There are 3 ways of plotting $S$-$N$ curve as shown below:
#cimage("./images/ways-of-plotting-s-n-curves.png")

Quite often, the $S$-$N$ curves are plotted as Figure (b).

#pagebreak()

=== Steel
The graph below will be provided in the exam if needed:

#cimage("./images/s-n-curve-steel.png")

- For steel, the $S$-$N$ curve flattens out after about $10^7$ cycles.
- The stress amplitude at which the curve flattens out is called the *endurance
    limit*, $S_e$.
- From the figure above, the endurance limit for steel is #qty[210][MPa].
- If the stress amplitude is less than the endurance limit (#qty[210][MPa]), the
    material will not fail by fatigue.
- *Endurance limit* ($S_e$) is also sometimes called the *fatigue limit*.
- *For infinite life*, we must have *$S_a < S_e$*.

#pagebreak()

=== Aluminium
#cimage("./images/s-n-curve-aluminium.png")

- For aluminium, the $S$-$N$ curve shows an ever decreasing trend.
- Hence, there is *no flattening of the $S$-$N$* for aluminium material.
- Therefore, it is usual to define *endurance limit* as the stress amplitude
    that will give a sufficiently long life, usually taken as *$50 times 10^6$*
    cycles.
- From the figure above, the endurance limit for aluminium is close to
    #qty[140][MPa].
- *For infinite life*, we must have *$S_a < S_e$*.

=== Empirical relation between $S_u$ and $S_e$
- $S_e$ is the endurance limit.
- $S_u$ is the ultimate tensile strength or tensile strength
- $S_e = 0.5 S_u$ for steels with $S_u < #qty[690][MPa]$
- $S_e = 0.4 S_u$ for aluminium alloys with $S_u < #qty[131][MPa]$
- $S_e = 0.4 S_u$ for copper alloys with $S_u < #qty[96.5][MPa]$

So, if the $S_e$ value is not readily known for these materials, we can use
these empirical formulas above to get an estimate of it.

#pagebreak()

=== Safety factor ($S F$)
$
    bold("Safety factor") space ("against fatigue failure")
    = frac("Endurance limit" space (S_e), "Stress amplitude" space (S_a))
$

Basically:
$
    S F = frac(S_e, S_a) quad => quad frac(S_a times S F, S_e) = 1
    quad => quad frac(S_a, frac(S_e, S F)) = 1
$

#cimage("./images/safety-factor-graph.png")
#pagebreak()

=== Example
A mild steel (1020HR) shaft has a pulley mounted at each end and is supported
symmetrically in between two bearings. When rotating under load, the portion of
the shaft in between the bearings is subjected to a cyclical bending moment of
#qty[1.2][kNm] amplitude. Using a safety factor (SF) of 2 and the data in the
figure below, determine a suitable diameter for the shaft for infinite *fatigue
life*.

#cimage("./images/s-n-curve-example-graph.png")

Endurance limit from the graph is #qty[210][MPa].

Therefore, the allowable stress amplitude (considering the safety factor) is:
$ S_a = 210/2 = #qty[105][MPa] $

$ sigma = frac(M y, I) wide I = frac(pi d^4, 64) wide y = d/2 $

$ therefore 105 times 10^6 = frac((1.2 times 10^3) (d/2), frac(pi d^4, 64)) $
$ => d = #qty[0.04882][m] = #qty[48.82][mm] $

#pagebreak()

== Factors affecting fatigue strength and life
+ Stress concentration
    - Fatigue strength is reduced by stress raisers like notches, holes,
        keyways, sharp changes in cross-section, etc.
+ Surface roughness
    - Smoother surfaces increase the fatigue strength.
+ Surface condition
    - Surface treatments like *carburising* and *nitriding* increases fatigue
        life.
+ Environment
    - Chemically reactive environments may result in corrosion, decreasing
        fatigue life.

== Modification factors for endurance limit
The endurance limit or fatigue strength determined by experiment is usually
multiplied by modification factors to account for various factors affecting the
actual fatigue life of the components, and the modified endurance limit is used
for all design calculations:
$ S_e = S'_e C_"size" C_"load" C_("surface-finish") dots.h $

Where:
- $S_e$ is the modified endurance limit, which is used for calculations
- $S'_e$ is the test specimen endurance limit *based on a bending test
    specimen*.

#cimage("./images/bending-test-specimen.png")

=== $C_"size"$ for circular rods
$
    C_"size" = cases(
        1.0 quad "if" d <= #qty[8][mm] "for bending",
        1.189 d^(-0.097) quad "if" #qty[8][mm] <= d <= #qty[250][mm]
        "for torsional load",
        1.0 quad "for axial load",
    )
$

=== Load parameter ($C_"load"$)
$
    "Load parameter" = C_"load" = cases(
        1.0 "for bending loads in the component",
        0.7 "for axial loads in the component",
        0.577 "for torsional loads in the component",
    )
$

=== Surface finish ($C_"surface-finish"$)
#cimage("./images/surface-finish-endurance-limit-modifier.png")
#grid(
    columns: 2,
    [
        - Choose this parameter from the chart based on the finishing process
            used to produced the component.
        - To use the graph, you need to know the *ultimate tensile strength*
            $S_u$ of the material used for making the component (look at the
            horizontal axis of the graph).
        - The graph will be given in the exam if needed.
    ],
    figure(
        image("./images/surface-finish-as-forged.png", height: 10em),
        caption: [As forged surface finish],
    ),
)

Conversion:
$ #qty[1][MPa] = #qty[0.1450377][ksi] $

#pagebreak()

=== Example
A *hot-rolled* steel bar of #qty[20][mm] diameter and #qty[225][MPa] endurance
limit (based on bending test specimen) is subjected to *a cyclic axial load* in
the form $10000 sin (50 t)$ (#unit[N]). Determine if the bar will have infinite
life (no fatigue failure). Consider endurance modification factors.

Stress amplitude:
$
    S_a = frac(P, A) = frac(10000, frac(pi d^2, 4))
    = 31.83 times 10^6 #unit[Pa]
    = #qty[31.83][MPa]
$

Now find the modified endurance limit ($S_e$):
$ S_e = S'_e C_"size" C_"load" C_"surface-finish" $

$
    C_"size" = cases(
        1.0 quad "if" d <= #qty[8][mm] "for bending",
        1.189 d^(-0.097) quad "if" #qty[8][mm] <= d <= #qty[250][mm]
        "for torsional load",
        1.0 quad "for axial load",
    )
$

$ d = #qty[20][mm], "axial load (given)" $

$ therefore C_"size" = 1.0 $
$
    "Load parameter" = C_"load" = cases(
        1.0 "for bending loads in the component",
        0.7 "for axial loads in the component"
        0.577 "for torsional loads in the component"
    )
$

The given steel bar has axial load (given):
$ therefore C_"load" = 0.7 $

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [

        The given component is hot-rolled (given).

        From the graph:
        $ S_u = #qty[450][MPa] $
        $ S_u = 0.1450377 times #qty[450][MPa] $
        $ S_u = #qty[65.27][ksi] $

        Therefore, $C_"surface-finish" approx 0.7$.
    ],
    image(
        "./images/surface-finish-endurance-limit-modifier.png",
        height: 18.7em,
    ),
)

$
    therefore S_e = S'_e C_"size" C_"load" C_"surface-finish" \
    = S'_e (1.0) (0.7) (0.7)
    = S'_e (0.49)
    = 225 (0.49)
    = #qty[110.25][MPa]
$

We find that $S_a < S_e$, which means the stress amplitude is less than the
endurance limit, so the component will have infinite life.

*Safety factor* with respect to fatigue failure:
$ frac(S_e, S_a) = frac(110.25, 31.83) approx 3.5 $

#pagebreak()

=== Car engine crankshaft
Internal combustion (IC) engine crankshafts are often mirror polished at the
fillets of crank pins and journals to reduce the chances of fatigue failure.
Before polishing, the crank shaft is also case-hardened by nitrogen diffusion,
which is commonly known as "nitriding".

#cimage("./images/car-engine-crankshaft.png")
#pagebreak()

=== Shot peening
Shot peening is a cold working process used to produce a compressive residual
stress layer and modify mechanical properties of metals. It entails impacting a
surface with shot (round metallic, glass, or ceramic particles) with force
sufficient to create plastic deformation.

#cimage("./images/shot-peen-1.png")
#cimage("./images/shot-peen-2.png")
#pagebreak()

== $S$-$N$ curve test
When the shaft rotates, the surface in the middle alternates between the top and
bottom surface. Due to the bending load from the weight, it sees the tensile
load on top and the compression load when it reaches the bottom.

#cimage("./images/s-n-curve-test.png")
#pagebreak()

== Notch effect

=== Stress concentration
$ K_t = frac(sigma_"max", sigma_"norm") $

#grid(
    columns: 2,
    column-gutter: 2em,
    image("./images/notch-effect-stress-concentration-at-notch.png"),
    image("./images/notch-effect-stress-concentration-notch-ratio.png"),
)

#cimage("./images/notch-effect-stress-concentration-graphs.png")
#pagebreak()

=== Notch sensitivity
$ q = frac(K_f - 1, K_t - 1) $

Where:
- $K_f$ is the actual fatigue stress concentration
- $K_t$ is the theoretical fatigue stress concentration

#cimage("./images/notch-effect-notch-sensitivity.png", width: 80%)

=== Fatigue strength reduction factor ($K_F$)
Geometrical discontinuities such as notches, grooves, holes, and steps in the
component cause stress concentration and thereby reduce the fatigue strength or
endurance limit. So, we need to correct the endurance limit as follows:
$ S_e = frac(S'_e C_"size" C_"load" C_"surface-finish" dots, K_f) $

$K_f$ can be calculated using the formula:
$ q = frac(K_f - 1, K_t) $
$ K_f = q (K_t - 1) + 1 $

Where:
- $K_t$ is the theoretical elastic stress concentration factor
- $q$ is the notch sensitivity factor, $0 <= q <= 1$

#pagebreak()

=== Example
A stepped steel shaft shown is subjected to bending load. Using the charts for
theoretical stress concentration factor $K_t$ and notch sensitivity factor $q$
(given below), determine the fatigue strength reduction factor $K_f$. Take $S_u$
to be #qty[400][MPa].

$ r/d = 3.75/25 = 0.15 $
$ D/d = 37.5/25 = 1.5 $

#grid(
    columns: 2,
    column-gutter: 2em,
    image("./images/notch-effect-example-graph-1.png"),
    image("./images/notch-effect-example-graph-2.png"),
)

From the graph on the left, $K_t approx 1.525$.

$ r = #qty[3.75][mm] space ("given") $
$ r = #qty[400][MPa] = #qty[0.4][GPa] space ("given") $

From the graph on the right, $q approx 0.78$.

For the given geometry and data, we can read from the charts:
$ K_t approx 1.525, quad q approx 0.78 $

From the equation, $q = frac(K_f - 1, K_t - 1)$, we can determine $K_f$ as:
$ K_f = 1 + q(K_t - 1) = 1 + 0.78(1.525 - 1) = 1.4 $

Note that $K_f < K_t$.

#pagebreak()

== Mean stress
#cimage("./images/mean-stress-1.png")
#cimage("./images/mean-stress-2.png")
#pagebreak()

=== Goodman relationship
#cimage("./images/mean-stress-goodman-relationship.png")

=== Other relationships
Goodman, Gerber and Soderberg proposed that *fatigue failure will occur* (and
hence the component will only have finite life) when:
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        $ "Goodman": frac(S_a, S_e) + frac(S_m, S_u) > 1 $
        $ "Gerber": frac(S_a, S_e) + frac(S_m, S_u)^2 > 1 $
        $ "Soderberg": frac(S_a, S_e) + frac(S_m, S_Y) > 1 $
    ],
    image("./images/mean-stress-other-relationships.png"),
)

=== Example
A hot-rolled steel bar of #qty[20][mm] diameter and #qty[225][MPa] endurance
limit (based on bending test specimen) is subjected to a fluctuating axial load
in the form $10^5 + 10^4 sin (50t)$ (#unit[N]). Determine if the bar will have
infinite life (i.e., no fatigue failure). Consider endurance modification
factors. Yield strength is #qty[250][MPa] and the tensile strength is
#qty[450][MPa].

#cimage("./images/mean-stress-example-stress-graph.png", height: 9em)

Stress amplitude:
$ S_a = P/A = frac(10^4, frac(pi d^2, 4)) = #qty[31.83][MPa] $

Mean stress:
$ S_m = P/A = frac(10^5, frac(pi d^2, 4)) = #qty[318.3][MPa] $

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        Modified endurance limit, $S_e$:

        $
            S_e & = S'_e C_"size" C_"load" C_"surface-finish" \
                & = S'_e (1.0) (0.7) (0.7) \
                & = S'_e (0.49) \
                & = 225 (0.49) \
                & = #qty[110.25][MPa]
        $

        $ S_u = #qty[450][MPa] space ("given") $
        $ S_Y = #qty[250][MPa] space ("given") $
    ],
    image(
        "./images/mean-stress-example-endurance-limit-graph.png",
        height: 15em,
    ),
)

Goodman:
$ 31.83/110.25 + 318.3/450 = 0.996 < 1 $

Gerber:
$ 31.83/110.25 + (318.3/450)^2 = 0.789 < 1 $

Soderberg:
$ 31.83/110.25 + 318.3/250 = 1.56 > 1 $

Note that the Soderberg criterion is usually too conservative when the mean
stress is below the yield strength, so it is seldom used in practice.

#pagebreak()

=== Safety factor ($S F$)
When the mean stress is 0 ($S_m = 0$), the safety factor is defined as:
$
    S F = frac(S_e, S_a) quad
    => quad frac(S_a times S F, S_e) = 1 quad
    "or" quad frac(S_a, frac(S_e, S F)) = 1
$

When the mess stress is not zero ($S_m != 0$):

#grid(
    columns: 4,
    column-gutter: 1em,
    align: horizon,
    [*Goodman*],
    $ frac(S_a times S F, S_e) + S_m/S_u = 1 $,
    [or],
    $ frac(S_a, frac(S_e, S F)) + S_m/S_u = 1 $,

    [*Gerber*],
    $ frac(S_a times S F, S_e) + (S_m/S_u)^2 = 1 $,
    [or],
    $ frac(S_a, frac(S_e, S F)) + (S_m/S_u)^2 = 1 $,

    [*Soderberg*],
    $ frac(S_a times S F, S_e) + S_m/S_Y = 1 $,
    [or],
    $ frac(S_a, frac(S_e, S F)) + S_m/S_Y = 1 $,
)

=== Final equations
#grid(
    columns: 4,
    column-gutter: 1em,
    row-gutter: 1em,
    align: horizon,
    [*Goodman*],
    $ frac(S_a times S F, S_e/K_f) + S_m/S_u = 1 $,
    [or],
    $ frac(S_a, frac(S_e, K_f S F)) + S_m/S_u = 1 $,

    [*Gerber*],
    $ frac(S_a times S F, S_e/K_f) + (S_m/S_u)^2 = 1 $,
    [or],
    $ frac(S_a, frac(S_e, K_f S F)) + (S_m/S_u)^2 = 1 $,

    [*Soderberg*],
    $ frac(S_a times S F, S_e/K_f) + S_m/S_Y = 1 $,
    [or],
    $ frac(S_a, frac(S_e, K_f S F)) + S_m/S_Y = 1 $,
)

== Variable amplitude loading
#cimage("./images/variable-amplitude-loading-graph.png")
#pagebreak()

=== Miner's rule for cumulative fatigue damage
Miner's loading rule is as follows:

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $ n_1/N_1 + n_2/N_2 + ... + n_k/N_k = 1 $

        Where:
        - $n_1$ is the number of cycles of operation at stress level $S_1$
        - $N_1$ is the number of cycles to failure at stress level $S_1$
        - $n_2$ is the number of cycles of operation at stress level $S_2$
        - $N_2$ is the number of cycles to failure at stress level $S_2$
        - $n_k$ is the number of cycles of operation at stress level $S_k$
        - $N_k$ is the number of cycles to failure at stress level $S_k$
    ],
    image("./images/miners-rule-diagrams.png"),
)

Each of the ratios $n_1/N_1, n_2/N_2, n_k/n_k$ represents the fractional damage
caused by the individual segments of loading.

#pagebreak()

==== Example
The S-N curve of an aluminium alloy is as shown in the figure on the next slide.
A component made of this material is designed to be subjected to 100,000 cycles
at stress #qty[70][MPa], 50,000 cycles at stress #qty[140][MPa], and 4,000
cycles at stress #qty[210][MPa]. Check if the component will indeed survive
(without fatigue failure) that long.

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        #table(
            columns: 2,
            table.header($S$, $n$),
            qty[70][MPa], [100,000],
            qty[140][MPa], [50,000],
            qty[210][MPa], [4,000],
        )

        $ n_1/N_1 + n_2/N_2 + n_3/N_3 = 1 $
    ],
    image("./images/miners-rule-example-graph.png"),
)

From the data:
#table(
    columns: 4,
    table.header($S$, $n$, $N$, $n/N$),
    qty[70][MPa], [100,000], $oo$, [0],
    qty[140][MPa], [50,000], $10^5$, [0.5],
    qty[210][MPa], [4,000], $10^4$, [0.4],
)

$ sum n/N = 0 + 0.5 + 0.4 + 0.9 < 1 $

Hence, the component will survive.

#pagebreak()

= Uniaxial vs multi-axial loading
#cimage("./images/uniaxial-vs-multi-axial-loading.png")

von Mises failure criterion:
$
    sigma_v^2 = 1/2 [
        (sigma_11 - sigma_22)^2 + (sigma_22 - sigma_33)^2
        + (sigma_33 - sigma_11)^2 + 6(sigma_23^2 + sigma_31^2 + sigma_12^2)
    ]
$

== Fatigue failure under multi-axial loading
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Stress amplitude:
        $
            {
                sigma_(x a), sigma_(y a), sigma_(z a),
                tau_(x y a), tau_(y z a), tau_(z x a)
            }
        $

        Mean stress:
        $
            {
                sigma_(x m), sigma_(y m), sigma_(z m),
                tau_(x y m), tau_(y z m), tau_(z x m)
            }
        $
    ],
    image("./images/multi-axial-loading-stress-graph.png"),
)

The *effective uniaxial stress amplitude* is:
$
    overline(sigma_a) = 1/sqrt(2) sqrt(
        (sigma_(x a) - sigma_(y a))^2 + (sigma_(y a) - sigma_(z a))^2
        + (sigma_(z a) - sigma_(x a))^2
        + 6(tau_(x y a)^2 + tau_(y z a)^2 +tau_(z x a)^2)
    )
$

The *effective uniaxial mean stress* is:
$
    overline(sigma_m) = sigma_(x m) + sigma_(y m) + sigma_(z m)
$

Once we calculate $overline(sigma_a)$ and $overline(sigma_m)$, a multi-axial
loading problem can be simply treated as a uni-axial loading problem by treating
$overline(sigma_a)$ and $overline(sigma_m)$ as equivalent uniaxial stress
amplitude, $S_a$ and mean stress $S_m$, respectively.

=== Checking for fatigue failure
We can check if fatigue failure will occur as usual (by using Goodman, Gerber,
and Soderberg criterion). For instance, if we use the Goodman criterion, we can
check if:
$ overline(sigma_a)/S_e + overline(sigma_m)/S_u > 1 $

If the condition is satisfied, fatigue failure will occur.

=== Calculating fatigue life
+ Calculate the *equivalent completely reversed uniaxial stress*, $S_(e q)$,
    using the formula:
    $
        S_(e q) = frac(overline(sigma_a), 1 - overline(sigma_m)/S_u)
        quad ("Using Goodman relation")
    $

+ From the uniaxial $S$-$N$ diagram, determine the fatigue life, $N_f$,
    corresponding to $S_(e q)$ as usual.
    #cimage("./images/s-n-curve-s-eq.png", height: 19em)

= Crack growth
#figure(
    image("./images/crack-growth-diagram.png", height: 20em),
    caption: [
        Stage I (Crack initiation) and *Stage II (Crack growth)* of
        polycrystalline material.
    ],
)

== Fatigue striations
- The spacing between striations is a measure of *advance distance* of the crack
    front during a *single stress cycle*.
- Striation width *increases* with *increasing stress range*.
- Fatigue striations on the fracture surface *can be observed by using a
    microscope*.

#cimage("./images/crack-growth-fatigue-striations.png")
#pagebreak()

== Fatigue crack propagation
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $ "Fatigue crack growth rate" = frac(dif a, dif N) $

        - When $a$ is small, $frac(dif a, dif N)$ is also small.
        - $frac(dif a, dif N)$ increases with increasing *crack length*.
        - Increase in $sigma$ increases crack growth rate.
    ],
    image("./images/crack-growth-rate-diagram.png", height: 20em),
)

#cimage(
    "./images/crack-growth-fatigue-crack-propagation-graph.png",
    height: 20em,
)

Stress field at the crack tip:
$ sigma = frac(K_I, sqrt(2 pi r)) $
$ frac(dif a, dif N) prop f(sigma, a) $
$ frac(dif a, dif N) = C (Delta K)^m $
$ Delta K = K_"max" - K_"min" = Y S_R sqrt(pi a) space (#unit[MPa m^1/2]) $

Where:
- $C, m$ are constants related to material, environment, frequency, temperature
    and stress ratio
- $S_R$ is the stress range, $S_R = sigma_"max" - sigma_"min"$
- $Delta K$ is the stress intensity factor range

=== Fatigue crack growth rate versus $Delta K$
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Fatigue crack growth rate vs stress intensity factor range:
        $
            log (frac(dif a, dif N)) = log (C (Delta K)^m) \
            = m log (Delta K) + log (C)
        $

        The graph is a straight line with slope $m$.

        Limiting the value of $Delta K$ below which there is no measurable crack
        growth is called the *stress intensity factor range threshold*
        $Delta K_"th"$.
    ],
    image("./images/fatigue-crack-growth-rate-vs-delta-k.png"),
)

== Paris' law
If $S_"max"$ and $S_"min"$ are both tensile, we take $S_R$ as
$S_R = S_"max" - S_"min"$.

In a reversed loading cycle, $S_"max"$ is tensile and $S_"min"$ is compressive.
It is usual to assume that the crack grows only during the tensile part of the
stress cycle and not in the compressive part. Therefore, for crack length
calculations, we only consider the tensile part of the cycle and take
$S_R = S_"max"$.

#cimage("./images/crack-growth-rate-paris-law.png")
#pagebreak()

== Fatigue life calculation
$ frac(dif a, dif N) = C (Delta K)^m $

Integrating from the initial crack size $a_0$ to the final crack size at failure
$a_f$ and the number of fatigue cycles from 0 to that at failure $N_f$:

Since:
$ Delta K = Y S_R sqrt(pi a) = Y S_R pi^(1/2) a^(1/2) $
$ therefore (Delta K)^m = Y_m S_R^m pi^(m/2) a^(m/2) $
$ therefore frac(dif a, dif N) = C(Y_m S_R^m pi^(m/2) a^(m/2)) $
$
    therefore integral_(a_0)^(a_f) dif a
    = C Y_m S_R^m pi^(m/2) a^(m/2) integral_0^(N_f) dif N
$

Integrating and solving for $N_f$:
$ N_f = frac(2, C (Y S_R)^m pi^(m/2) (2 - m)) (a_f^(1 - m/2) - a_0^(1 - m/2)) $

Assuming $Y$ is independent of the crack length, and $m != 2$.

Where:
- $N_f$ is the number of fatigue cycles.
- $C$ is a coefficient
- $Y$ is the geometry correction factor
- $S_R$ is the stress range in #unit[MPa], which is $sigma$ for fully reversed
    cycles as only the tensile region is applicable to the crack growth, and
    $2 sigma$ for normal cycles
- $m$ is a coefficient
- $a_0$ is half of the initial crack length
- $a_f$ is half of the final crack length

For this equation, all *stresses must be in #unit[MPa]*.

=== Applications
$ N_f = frac(2, C (Y S_R)^m pi^(m/2) (2 - m)) (a_f^(1 - m/2) - a_0^(1 - m/2)) $

+ Knowing the initial crack length and final crack length before fracture,
    determine the fatigue life (for replacement or repair).
+ Knowing the final crack length before fracture and the initial crack length
    for non-destructive testing (NDT), determine the inspection interval.
+ Knowing the initial crack length, determine the stress limit for the required
    fatigue life (design consideration).

The final crack length is determined by the fracture toughness of the material
and the working stress levels.

#pagebreak()

=== Example 1
A large aluminium alloy plate contains a central crack of length #qty[1][cm].
The plate is subjected to a cyclic tensile stress as shown in the figure below
with $S_"min" = #qty[6][MPa]$ and $S_"max" = #qty[60][MPa]$. The Paris' law
exponent is 3. Assume that $Y = 1.02$, a constant throughout the crack growth.
How many loading cycles are needed for the crack to grow to a length of
#qty[2][cm]? Given that $Delta K = #qty[2.8][MPa m^1/2]$ at
$frac(dif a, dif N) = 10^(-9) #unit[m cycle^-1]$.

$ N_f = frac(2, C (Y S_R)^m pi^(m/2) (2 - m)) (a_f^(1 - m/2) - a_0^(1 - m/2)) $

#cimage("./images/crack-growth-fatigue-life-example-1.png")

$ a_0 = frac(#qty[1][cm], 2) = #qty[0.005][m] $
$ a_f = frac(#qty[2][cm], 2) = #qty[0.01][m] $
$ S_R = 60 - 6 = #qty[54][MPa] $
$ m = 3, quad Y = 1.02 $

$C$ is not given, but can be determined using Paris' law:
$ frac(dif a, dif N) = C (Delta K)^m quad ("Paris' law") $
$
    therefore C = frac(frac(dif a, dif N), (Delta K)^m)
    = frac(10^(-9), 2.8^3) = 4.55 times 10^(-1)
$

$
    therefore N_f & = frac(
                        2,
                        (4.55 times 10^(-11) (1.02 times 54)^3 pi^(3/2) (2 - 3))
                    ) (0.01^(1 - 3/2) - 0.005^(1 - 3/2)) \
                  & = #qty[195674][cycles]
$

In reality, as the crack grows, $Y$ will keep changing, i.e. $Y$ is a function
of $a$. In such a case, the integral becomes:
$
    integral_0^(N_f) dif N
    = integral_(a_0)^(a_f) frac(dif a, C (Y(a) S_R sqrt(pi a))^m)
    = 1/(C (S_R sqrt(pi))^m)
    integral_(a_0)^(a_f) {Y(a)}^(-m) a^(-m/2) thin dif a
$

#pagebreak()

=== Example 2
An alloy steel plate is subjected to constant-amplitude uniaxial fatigue cyclic
tensile and compressive stresses of magnitudes of #qty[120][MPa] and
#qty[30][MPa], respectively. The static properties of the plate are a yield
strength of #qty[1400][MPa] and a fracture toughness KIC of #qty[45][MPa m^1/2].
If the plate contains a uniform through thickness edge crack of #qty[1.00][mm],
how many fatigue cycles are estimated to cause fracture? Use the equation
$frac(dif a, dif N) space (#unit[m cycle^-1])
= 2.0 times 10^(-12) Delta K^3 space (#unit[MPa m^1/2])^3$. Assume $Y = 1$ in
the fracture toughness equation.

$ K_(I C) = Y sigma_f sqrt(pi a) $
$ frac(dif a, dif N) = C (Delta K)^m $

#cimage("./images/crack-growth-fatigue-life-example-2.png", height: 17em)

$
    frac(dif a, dif N) space (#unit[m cycle^-1])
    = 2.0 times 10^(-12) Delta K^3 space (#unit[MPa m^1/2])^3
$

Thus,
$ C = 2.0 times 10^(-12), quad m = 3, quad Y = 1 $
$
    S_R = (120 - 0) #unit[MPa]
    space ("compressive stress of" #qty[30][MPa] "is ignored")
$

The initial crack size $a_0 = #qty[1.00][mm] = #qty[0.001][m]$.

The final crack size is determined from the fracture toughness equation:
$
    K_(I C) = Y sigma_f sqrt(pi a) quad => quad
    a_f = 1/pi (frac(K_(I C), Y sigma_f))^2
$

$
    a_f = 1/pi (frac(K_(I C), Y sigma_f))^2
    = 1/pi (frac(#qty[45][MPa m^1/2], 1 times #qty[120][MPa]))^2
    = #qty[0.045][m]
$

$
    N_f & = frac(
              2,
              C (Y S_R)^m pi^(m/2) (2 - m)
          ) (a_f^(1 - m/2) - a_0^(1 - m/2)) \
        & = frac(
              2,
              (2.0 times 10^(-12)) (1.0 times #qty[120][MPa])^3 pi^(3/2) (2 - 3)
          ) (0.045^(1 - 3/2) - 0.001^(1 - 3/2)) \
        & = 2.79 times 10^6 #unit[cycles]
$

== Effect of stress ratio ($R$)
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Stress ratio:
        $ R = frac(K_"min", K_"max") = frac(S_"min", S_"max") $

        Higher stress ratio, implying increasing mean stress, leads to *faster
        crack growth*.

        Forman equation:
        $ frac(dif a, dif N) = frac(C (Delta K)^m, (1 - R) K_c - Delta K) $

        Walker equation:
        $ frac(dif a, dif N) = C (frac(Delta K, (1 - R)^(1 - gamma)))^m $
    ],
    image("./images/crack-growth-effect-of-stress-ratio.png"),
)

== Damage tolerance concept
- Stress determination using finite element tools
- Collection of load spectrum
- Crack growth analysis
- Periodic inspection

#cimage("./images/crack-growth-damage-tolerance-concept.png")
#pagebreak()

= Vibration
- Vibration is the periodic motion of an elastic body or a rigid body, around
    *its equilibrium position*.
- The terms vibration and oscillation are sometimes used interchangeably.

#cimage("./images/vibration-example.png")

== Effects of vibrations
Useful effects:
- Pendulum oscillations drive pendulum clocks.
- Vibration of wires in the guitar or violin produces music.
- Accelerometers and seismometers make use of the vibration of a spring-mass
    system.
- Vibration in compactors helps to compact level surfaces.
- Vibration in hackers help to break rocks.

Harmful effects:
- Vibration can cause noise and discomfort.
- Excessive vibration can break machines and components.
- Even controlled vibration can lead to fatigue failure.
- Machines and instruments can malfunction due to foundation vibration.

#pagebreak()

=== Catastrophic effects of vibrations
+ Collapse of a bridge due to wind induced vibrations.
    - Tacoma Narrows Bridge in Washington was opened for traffic on 7 Nov 1940.
    - Just 4 months later, it collapsed due to excessive wind-induced torsional
        oscillations when the wind was blowing at #qty[64][km h^-1].
    #cimage("./images/castastrophic-effect-of-vibrations-1.png")
+ Self destruction of a helicopter (Eurocopter AS350) due to "Ground Resonance"
    #cimage("./images/castastrophic-effect-of-vibrations-2.png")

== Classification of the types of variations

=== Based on the number of degrees of freedom (DOF)
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Vibration of systems with a finite number of degrees of freedom
        - Vibration of 1-DOF systems
        - Vibration of 2-DOF systems
        - Vibration of n-DOF systems
    ],
    image("./images/vibration-of-systems-with-finite-number-of-dof.png"),
)

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Vibration of systems with infinite number of DOF
        - Examples:
            - Axial vibration of rods
            - Bending vibration of beams
            - Torsional vibration of shafts
            - Vibration of general solids
    ],
    image("./images/vibration-of-systems-with-infinite-number-of-dof.png"),
)

=== Based on damping
- Undamped vibration
- Damped vibration

#pagebreak()

=== Based on the nature of excitation
- Free vibration (no excitation)
- Forced vibration:
    + Vibration due to force excitation
        - Harmonic force (sinusoidal force)
        - General periodic force
        - Non-periodic general force
        - Random force
    #cimage("./images/vibration-due-to-force-excitation.png", height: 20em)

    + Vibration due to base excitation
        - Harmonic base motion (sinusoidal base motion)
        - General periodic base motion
        - Non-periodic general base motion
        - Random base motion (earthquake excitation)
    #cimage("./images/vibration-due-to-base-excitation.png", height: 20em)

== Simple harmonic motion (SHM)
- The motion of particles during vibration can often be modelled as a *simple
    harmonic motion* (SHM).
- A simple harmonic motion can be described by a *sinusoidal function*.

=== Pendulum
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        For *small amplitudes of oscillations*, the motion of a pendulum is a
        simple harmonic motion and is described as:
        $ theta = Theta sin (omega t + phi.alt) $

        Where:
        - $theta$ is the displacement (#unit[rad] or #unit[deg])
        - $Theta$ is the displacement amplitude or maximum displacement
            (#unit[rad] or #unit[deg])
        - $omega$ is the frequency of oscillation, $omega = 2 pi f$ (#unit[rad
                s^-1])
        - $phi.alt$ is the phase angle (#unit[rad])
        - $f$ is the frequency of oscillation, $f = 1/tau$ (#unit[Hz])
        - $tau$ is the time period of oscillation (#unit[s])
    ],
    image("./images/simple-harmonic-motion-pendulum.png", height: 20em),
)

=== Spring-mass system
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        For *small amplitudes of oscillations* of a spring-mass system, the
        motion of the mass is a simple harmonic motion and is described as:
        $ x = X sin (omega t + phi.alt) $

        Where:
        - $x$ is the displacement (#unit[m])
        - $X$ is the displacement amplitude or maximum displacement (#unit[m])
        - $omega$ is the frequency of oscillation, $omega = 2 pi f$ (#unit[rad
                s^-1])
        - $phi.alt$ is the phase angle (#unit[rad])
        - $f$ is the frequency of oscillation, $f = 1/tau$ (#unit[Hz])
        - $tau$ is the time period of oscillation (#unit[s])
    ],
    image("./images/simple-harmonic-motion-spring-mass.png"),
)

=== Graphical representation
#grid(
    columns: 2,
    column-gutter: 2em,
    image("./images/graphical-representation-pendulum.png"),
    image("./images/simple-harmonic-motion-spring-mass.png"),

    [
        $ theta = Theta sin (omega t + phi.alt) $
        $ omega = 2 pi f $
        $ f = 1/tau $
        $ theta_"max" = Theta $

        The amplitude ($Theta$) represents the maximum possible value of
        $theta$.
    ],
    [
        $ x = X sin (omega t + phi.alt) $
        $ omega = 2 pi f $
        $ f = 1/tau $
        $ x_"max" = X $

        The amplitude ($X$) represents the maximum possible value of $x$.
    ],
)

=== Displacement, velocity and acceleration
#table(
    columns: 3,
    table.header([], [*Angular motion*], [*Rectilinear motion*]),

    [Displacement],
    $ theta = Theta sin (omega t + phi.alt) $,
    $ x = X sin (omega t + phi.alt) $,

    [Velocity],
    $ dot(theta) = omega Theta cos (omega t + phi.alt) $,
    $ dot(x) = omega X cos (omega t + phi.alt) $,

    [Acceleration],
    $
        dot.double(theta) = -omega^2 Theta sin (omega t + phi.alt) \
        arrow.double.b \
        dot.double(theta) = -omega^2 theta
    $,
    $
        dot.double(x) = -omega^2 X sin (omega t + phi.alt) \
        arrow.double.b \
        dot.double(x) = -omega^2 x
    $,
)

=== Maximum displacement, velocity and acceleration
Angular motion:
$
    theta = Theta sin (omega t + phi.alt)
    quad => quad #text(red)[$theta_"max" = Theta$]
$
$
    dot(theta) = omega Theta cos (omega t + phi.alt)
    quad => quad #text(red)[$dot(theta)_"max" = omega Theta$]
$
$
    dot.double(theta) = -omega^2 Theta sin (omega t + phi.alt)
    quad => quad #text(red)[$dot.double(theta)_"max" = omega^2 Theta$]
$

Rectilinear motion:
$
    x = X sin (omega t + phi.alt)
    quad => quad #text(red)[$x_"max" = X$]
$
$
    dot(x) = omega X cos (omega t + phi.alt)
    quad => quad #text(red)[$dot(x)_"max" = omega X$]
$
$
    dot.double(x) = -omega^2 X sin (omega t + phi.alt)
    quad => quad #text(red)[$dot.double(x)_"max" = omega^2 X$]
$

=== Example 1
The displacement amplitude and frequency of vibration of a spring-mass system
are #qty[0.1][m] and #qty[10][rad s^-1], respectively. Calculate the maximum
acceleration experienced by the mass.

Given:
$ x = #qty[0.1][m], quad omega = #qty[10][rad s^-1] $

The maximum acceleration is given by:
$ dot.double(x)_"max" = omega^2 X = 10^2 (0.1) = #qty[10][m s^-2] $

=== Example 2
The mass of a simple pendulum is pulled to $theta = 3 degree$ position (as
shown) and released gently at $t = 0$. The pendulum executes SHM with a
frequency $omega = #qty[5][rad s^-1]$. Determine the amplitude of oscillation
($Theta$) and the phase angle ($phi.alt$).

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $ "SHM": theta = Theta sin (omega t + phi.alt) $

        Given:
        #labelled_equation($ theta = 3 degree "at" t = 0 $, 1)
        #labelled_equation(
            $ dot(theta) = 0 "at" t = 0 space ("released gently") $,
            2,
        )

        Sub (1) in $theta = Theta sin (omega t + phi.alt)$:
        #labelled_equation($ 3 degree = theta sin phi.alt $, 3)

        Sub (2) in $dot(theta) = omega Theta cos (omega t + phi.alt)$
        #labelled_equation($ 0 = 5 Theta cos phi.alt $, 4)

        Dividing equation (3) by (4):
        $ frac(3 degree, 0) = 1/5 tan phi.alt $
        $ phi.alt = pi/2 $

        Sub $phi.alt = pi/2$ in equation (3), we get:
        $ Theta = 3 degree $

        Hence, the expression for the motion of the pendulum:
        $
            theta & = Theta sin (omega t + phi.alt) \
                  & = 3 degree sin (5 t + pi/2) \
                  & = 3 degree cos (5t)
        $
    ],
    image("./images/simple-harmonic-motion-example-2.png"),
)

=== Example 3
A simple pendulum is initially at rest with $theta = 0 degree$. The mass is
suddenly imparted with a velocity $dot(theta) = #qty[10][#sym.degree s^-1]$ to
the right so that the angular velocity at $t = 0$ (as shown). The pendulum
executes SHM with a frequency $omega = #qty[5][rad s^-1]$. Determine the
amplitude of oscillation ($Theta$) and the phase angle ($phi.alt$).

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $ "SHM": theta = Theta sin (omega t + phi.alt) $

        Given:
        #labelled_equation(
            $ theta = 0 degree "at" t = 0 space ("initially at rest") $,
            5,
        )
        #labelled_equation(
            $ dot(theta) = #qty[10][#sym.degree s^-1] "at" t = 0 $,
            6,
        )

        Sub (5) in $theta = Theta sin (omega t + phi.alt)$:
        #labelled_equation($ 0 = Theta sin phi.alt $, 7)

        Sub (6) in $dot(theta) = omega Theta cos (omega t + phi.alt)$
        #labelled_equation($ 10 = 5 Theta cos phi.alt $, 8)

        Dividing equation (7) by (8):
        $ 0/10 = 1/5 tan phi.alt $
        $ phi.alt = 0 $

        Hence, the expression for the motion of the pendulum:
        $
            theta & = Theta sin (omega t + phi.alt) \
                  & = 2 degree sin (5 t + 0) \
                  & = 2 degree cos (5t)
        $
    ],
    image("./images/simple-harmonic-motion-example-3.png"),
)

= Undamped free vibration of 1-DOF systems

== Simple pendulum

=== Free body diagram
#cimage("./images/simple-pendulum-free-body-diagram.png")

=== Equation of motion (EOM)
#labelled_equation($ J_o dot.double(theta) = sum M_o $, 1)
$ J_o = m L^2 $
$ m L^2 dot.double(theta) = - m g dot L sin theta $

Since $sin theta approx theta$ by small angle approximation:
$ m L^2 dot dot.double(theta) + m g L theta = 0 $
#labelled_equation($ L dot.double(theta) + g theta = 0 $, 2)

The solution to this equation of motion is:
#labelled_equation($ theta = Theta sin (omega_n t + phi.alt) $, 3)
#pagebreak()

=== Natural frequency
$ L dot.double(theta) + g theta = 0 $

We know the solution form:
$ theta = Theta sin (omega_n t + phi.alt) $
$ dot.double(theta) = - omega_n^2 Theta sin (omega_n t + phi.alt) $

Substituting for $theta$ and $dot.double(theta)$ in the equation of motion:
$
    - L dot omega_n^2 redcancel(Theta) redcancel(sin (omega_n t + phi.alt))
    + g redcancel(Theta) redcancel(sin (omega_n t + phi.alt)) = 0
$
$ - L dot omega_n^2 + g = 0 $

Natural frequency (#unit[rad s^-1]):
#labelled_equation($ omega_n = sqrt(g/L) $, 4)

Natural frequency (#unit[Hz]):
#labelled_equation($ f_n = omega_n/(2 pi) $, 5)

Natural period (#unit[s]):
#labelled_equation($ tau_n = 1/f_n $, 6)

=== Free vibration response
<pendulum-free-vibration-response>
The free vibration response is given by equation (7) or (8):
#labelled_equation($ theta = Theta sin (omega_n^2 + phi.alt) $, 7)
#labelled_equation($ theta = A cos omega_n t + B sin omega_n t $, 8)

The constants $(Theta, phi.alt)$ or $(A, B)$ are to be determined from the
initial conditions:
#labelled_equation($ theta(0) = theta_0 quad ("At" t = 0, theta = theta_0) $, 9)
#labelled_equation(
    $ theta(0) = theta_0 quad ("At" t = 0, theta = theta_0) $,
    10,
)

#let theta-phi-a-b-relationship = [
    $(Theta, phi.alt)$ and $(A, B)$ are related by the following equations:

    #grid(
        columns: 2,
        column-gutter: 2em,
        row-gutter: 0.5em,
        labelled_equation($ Theta = sqrt(A^2 + B^2) $, 11),
        labelled_equation($ theta = arctan (A/B) + 180 degree $, 12),

        [
            If $A$ and $B$ are known, $Theta$ and $phi.alt$ can be calculated
            using these two equations.
        ],
        [
            Add $180 degree$ if the denominator ($B$) is negative, otherwise add
            nothing.
        ],
    )
]

#theta-phi-a-b-relationship
#pagebreak()

=== Determining $(Theta, phi.alt)$ from the initial conditions (I.Cs)
Given:
$ theta = Theta sin (omega_n t + phi.alt) $

Initial conditions:
$ theta(0) = theta_0, quad dot(theta)(0) = dot(theta)_0 $

Determine $Theta$ and $phi.alt$:
$ theta = Theta sin (omega_n t + phi.alt) $
$ dot(theta) = omega_n Theta cos (omega_n t + phi.alt) $

$ theta(0) = theta_0 $
$ Theta sin (redcancel(omega_n dot 0) + phi.alt) = theta_0 $
#labelled_equation($ Theta sin phi.alt = theta_0 $, 13)

$ dot(theta) (0) = dot(theta)_0 $
$ omega_n Theta cos (redcancel(omega_n dot 0) + phi.alt) dot(theta)_0 $
#labelled_equation($ Theta cos phi.alt = frac(dot(theta)_0, omega_n) $, 14)

Squaring both equations (13) and (14), and adding them together:
#labelled_equation(
    $ Theta = sqrt(dot(theta)_0^2 + (dot(theta)_0/omega_n)^2) $,
    15,
)

Dividing equation (13) by equation (14):
#labelled_equation(
    $ phi.alt = arctan (frac(theta_0, dot(theta)_0/omega_n)) + 180 degree $,
    16,
)

Add $180 degree$ if the denominator $(dot(theta)_0/omega_n)$ is negative,
otherwise, add nothing.
#pagebreak()

=== Determining $(A, B)$ from the initial conditions
Given:
$ theta = A cos omega_n t + B sin omega_t $

Initial conditions:
$ theta(0) = theta_0, quad dot(theta)(0) = dot(theta)_0 $

Determine $A$ and $B$:
$ theta = A cos omega_n t + B sin omega_n t $
$ dot(theta) = - omega_n A sin omega_n t + omega_n B cos omega_n t $

$ theta(0) = theta_0 $
$ A cos (omega_n dot 0) + redcancel(B sin (omega_n dot 0)) = theta_0 $
$ A = theta_0 $

$ dot(theta)(0) = dot(theta)_0 $
$
    - omega_n redcancel(A sin (omega_n dot 0)) + omega_n B cos (omega_n dot 0)
    = dot(theta)_0
$
$ B = dot(theta)_0/omega_n $

Hence:
$ A = theta_0, quad B = dot(theta)_0/omega_n $

Hence, the free vibration response can be written as:
#labelled_equation(
    $ theta = theta_0 cos omega_n t + dot(theta)_0/omega_n sin omega_n t $,
    17,
)

== Spring-mass system
<spring-mass-system>
#cimage("./images/spring-mass-system-diagram.png")

=== Free body diagram
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,
    align: horizon,
    grid.header([*Static analysis*], [*Dynamic analysis*]),

    image("./images/spring-mass-system-static-free-body-diagram.png"),
    image("./images/spring-mass-system-dynamic-free-body-diagram.png"),

    [
        #labelled_equation(
            $
                sum F = 0 quad & => quad m g - k Delta = 0 \
                               & => m g = k Delta
            $,
            18,
        )
    ],
    [
        We shall use this free body diagram to derive the equation of motion
        (EOM).
    ],
)

#pagebreak()

=== Equation of motion (EOM)
Newton's 2nd law:
$ m dot.double(x) = sum F_x $
$ m dot.double(x) = m g - k (Delta + x) $
$
    m dot.double(x) = redcancel(m g) - redcancel(k Delta) + k x
    quad because m g = k Delta space ("from static analysis")
$

#labelled_equation($ m dot.double(x) + k x = 0 $, 19)
Note that the static forces $m g$ and $k Delta$ do not appear in the equation of
motion.

The solution of this equation of motion is of the form:
#labelled_equation($ x = X sin (omega_n t + phi.alt) $, 20)

=== Natural frequency
Equation of motion:
$ m dot.double(x) + k x = 0 $

We know the solution form:
$ x = X sin (omega_n t + phi.alt) $
$ dot.double(x) = - omega_n^2 X sin (omega_n t + phi.alt) $

Substituting for $theta$ and $dot.double(theta)$ in the equation of motion:
$
    - m dot omega_n^2 redcancel(X) redcancel(sin omega_n t + phi.alt)
    + k dot redcancel(X) redcancel(sin (omega_n t + phi.alt)) = 0
$
$ - m dot omega_n^2 + k = 0 $
$ omega_n = sqrt(k/m) $

Natural frequency (#unit[rad s^-1]):
#labelled_equation($ omega_n = sqrt(k/m) $, 21)

Where:
- $k$ is the stiffness of the spring
- $m$ is the mass

Natural frequency (#unit[Hz]):
#labelled_equation($ f_n = omega_n/(2 pi) $, 22)

Natural period (#unit[s]):
#labelled_equation($ tau_n = 1/f_n $, 23)
#pagebreak()

=== Free vibration response
#labelled_equation($ x = X sin (omega_n t + phi.alt) $, 24)
#labelled_equation($ x = A cos omega_n t + B sin omega_n t $, 25)

The constants $(X, phi.alt)$ or $(A, B)$ are to be determined from the initial
conditions, like the initial displacement and the initial velocity.

Initial conditions
#labelled_equation($ x(0) (x = x_0 "at" t = 0) = x_0 $, 26)
#labelled_equation($ dot(x)(0) (x = x_0 "at" t = 0) = dot(x)_0 $, 27)

#theta-phi-a-b-relationship

=== Determining $(Theta, phi.alt)$ from the initial conditions (I.Cs)
Given:
$ x = X sin (omega_n t + phi.alt) $

Initial conditions:
$ x(0) = x_0, quad dot(x)(0) = dot(x)_0 $

Determine $X$ and $phi.alt$:
$ x = X sin (omega_n t + phi.alt) $
$ dot(x) = omega_n X cos (omega_n t + phi.alt) $

$ x(0) = x_0 $
$ X sin (omega_n dot 0 + phi.alt) = x_0 $
#labelled_equation($ X sin phi.alt = x_0 $, 30)

$ dot(x)(0) = dot(x)_0 $
$ omega_n X cos (omega_n dot 0 + phi.alt) = dot(x)_0 $
#labelled_equation($ X cos phi.alt = dot(x)_0/omega_n $, 31)

Squaring both equations (30) and (31), and adding them together:
#labelled_equation($ X = sqrt(x_0^2 + (dot(x)_0/omega_n)^2) $, 32)

Add $180 degree$ if the denominator $(dot(x)_0/omega_n)$ is negative, otherwise,
add nothing.

=== Determining $(A, B)$ from the initial conditions
Given:
$ x = A cos omega_n t + B sin omega_n t $

Initial conditions:
$ x(0) = x_0, quad dot(x)(0) = dot(x)_0 $

Determine $A$ and $B$:
$ x = A cos omega_n t + B sin omega_n t $
$ dot(x) = - omega_n A sin omega_n t + omega_n B cos omega_n t $

$ x(0) = x_0 $
$ A cos (omega_n dot 0) + B sin (omega_n dot 0) = x_0 $
$ A = x_0 $

$ dot(x)(0) = dot(x)_0 $
$ - omega_n A sin (omega_n dot 0) + omega_n B cos (omega_n dot 0) = dot(x)_0 $
$ B = dot(x)_0/omega_n $

Hence:
#labelled_equation($ A = x_0 $, "34a")
#labelled_equation($ B = dot(x)_0/omega_n $, "34b")

Hence:
#labelled_equation(
    $ x = x_0 cos omega_n t + dot(x)_0/omega_n sin omega_n t $,
    "34c",
)

#pagebreak()

== Shaft-disc system
We assume that the shaft is massless.

Torsional stiffness of the shaft (#unit[Nm rad^-1]):
$ k_theta = (G J)/L wide J = frac(pi d^4, 32) $

#cimage("./images/shaft-disc-system.png")

=== Equation of motion (EOM)
Newton's 2nd law:
#labelled_equation($ J_o dot.double(theta) = sum M_o $, 35)
$ J_o dot.double(theta) = - k_theta theta $

#labelled_equation($ J_o dot.double(theta) + k_theta theta = 0 $, 36)

$
    J_o = frac(m R^2, 2) space ("for disc")
    wide k_theta = (G J)/L space ("for circular shaft")
$

#labelled_equation($ theta = Theta sin (omega_n t + phi.alt) $, 37)
#pagebreak()

=== Natural frequency
The equation of motion:
$ J_o dot dot.double(theta) + k_theta theta = 0 $

We know the solution form:
$ theta = Theta sin (omega_n t + phi.alt) $
$ dot.double(theta) = - omega_n^2 Theta sin (omega_n t + phi.alt) $

Substituting for $theta$ and $dot.double(theta)$ in the equation of motion:
$
    - J_o dot omega_n^2 redcancel(Theta) redcancel(sin (omega_n t + phi.alt))
    + k_theta dot redcancel(Theta) redcancel(sin (omega_n t + phi.alt)) = 0
$
$ - J_o dot omega_n^2 + k_theta = 0 $
$ omega_n = k_theta/J_o $

Natural frequency (#unit[rad s^-1]):
$ omega_n = sqrt(k_theta/J_o) $

Where:
- $k_theta$ is the torsional stiffness of the shaft
- $J_o$ is the polar mass moment of inertia of the disc

Natural frequency (#unit[Hz]):
$ f_n = omega_n/(2 pi) $

Natural period (#unit[s]):
$ tau_n = 1/f_n $

=== Free vibration response
Similar to that of the #link(<pendulum-free-vibration-response>)[pendulum].

== Other examples of 1-DOF systems

=== Example 1
#cimage("./images/1-dof-systems-example-1.png")

$ J_o dot.double(theta) = sum M_o $
$ frac(m L^2, 3) dot dot.double(theta) = - m g dot L/2 redcancel(sin) theta $
$
    frac(m L^2, 3) dot dot.double(theta)
    = - m g dot L/2 theta quad because sin theta approx theta
$

Equation of motion:
$ frac(m L^2, 3) dot dot.double(theta) + frac(m g L, 2) theta = 0 $

$ theta = Theta sin (omega_n t + phi.alt) $
$ omega_n = sqrt(frac(frac(m g L, 2), frac(m L^2, 3))) = sqrt(frac(3g, 2 L)) $

=== Example 2
#cimage("./images/1-dof-systems-example-2.png")

$ J_o dot.double(theta) = sum M_o $
$
    (m_1 L_1^2 + m_2 L_2^2) dot.double(theta)
    = - m_1 g L_1 redcancel(sin) theta + m_2 g L_2 redcancel(sin) theta
    quad because sin theta approx theta
$
$
    (m_1 L_1^2 + m_2 L_2^2) dot.double(theta)
    = - m_1 g L_1 theta + m_2 g L_2 theta
$

Equation of motion:
$
    (m_1 L_1^2 + m_2 L_2^2) dot.double(theta)
    + (m_1 g L_1 - m_2 g L_2) theta = 0
$

$ theta = Theta sin (omega_n t + phi.alt) $
$ omega_n = sqrt(frac(m_1 g L_1 - m_2 g L_2, m_1 L_1^2 + m_2 L_2^2)) $

=== Example 3
#cimage("./images/1-dof-systems-example-3.png")

$ J_o dot.double(theta) = sum M_o $
$
    2 frac(m L^2, 3) dot.double(theta)
    = - 2 m g overbrace(L/2 cos 30 degree, O G) dot redcancel(sin) theta
    quad because sin theta approx theta
$
$
    2 frac(m L^2, 3) dot.double(theta)
    = - 2 m g overbrace(L/2 cos 30 degree, O G) dot theta
$

Equation of motion:
$ 2 frac(m L^2, 3) dot.double(theta) + m g L cos 30 degree dot theta = 0 $

$ theta = Theta sin (omega_n t + phi.alt) $

$
    omega_n = sqrt(frac(m g L cos 30 degree, frac(2 m L^2, 3)))
    = sqrt(frac(3 g dot cos 30 degree, 2 L))
$

#pagebreak()

=== Example 4
#cimage("./images/1-dof-systems-example-4.png")

$ m dot.double(x) = sum F_x $
$ m dot.double(x) = - k x $

Equation of motion:
$ m dot.double(x) + k x = 0 $

$ x = X sin (omega_n t + phi.alt) $
$ omega_n = sqrt(k/m) $

Note that the natural frequency discussed is the same as the #link(
    <spring-mass-system>,
)[vertical spring-mass system discussed above]. The orientation of the
spring-mass system, whether vertical or horizontal, does not affect its natural
frequency.

=== Example 5
<1-dof-systems-example-5>
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        In the figure shown, the rod has negligible mass and the spring is
        unstrained.
        + Derive the equation of motion and hence determine the natural
            frequency of vibration of the system.
        + If at $t = 0$, a bullet of mass $m$ with speed $v_0$ hits the
            pendulum, determine the subsequent motion of the mass $M$ assuming
            that the bullet remains embedded in the pendulum mass after the
            impact.

        $ J_o dot.double(theta) = sum M_o $

        $
            M l^2 dot.double(theta)
            = - M g l sin theta - k l/2 sin theta dot l/2 cos theta
        $
        $
            sin theta approx theta, quad cos theta approx 1
            space ("small angle approximation")
        $

        $ M l^2 dot.double(theta) = - M g l theta - k (l/2)^2 theta $

        Equation of motion:
        $ M l^2 dot.double(theta) + (M g l + frac(k l^2, 4)) theta = 0 $

        So the natural frequency:
        $
            omega_n = sqrt(frac(M g l + frac(k l^2, 4), M l^2))
            = sqrt(g/l + k/(4 M))
        $
    ],
    image("./images/1-dof-systems-example-5-1.png"),
)

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        After the impact, the bullet remains embedded in the mass with the
        pendulum mass. So the new mass is $M + m$. So the new equation of motion
        is:
        $
            (M + m) l^2 dot.double(theta)
            + [(M + m) g l + frac(k l^2, 4)] theta = 0,
            quad t > 0
        $

        So, the new natural frequency:
        $
            omega'_n = sqrt(frac((M + m) g l + frac(k l^2, 4), (M + m) l^2))
            = sqrt(g/l + frac(k, 4 (M + m))), quad t > 0
        $

        So, the motion (response) after impact is given by:
        $ theta = Theta sin (omega'_n t + phi.alt), quad t > 0 $

        The constants $(Theta, phi.alt)$ are to be determined from the initial
        conditions. For the given problem, the initial conditions are:
        $ theta(0) = theta_0 = 0 $
        $ dot(theta)(0) = dot(theta)_0 $

        The initial velocity of $(M + m)$ is yet to be calculated, but it can be
        found from the conservation of momentum.

    ],
    image("./images/1-dof-systems-example-5-2.png"),
)

Conservation of *angular momentum* about $O$ gives:
$ "Angular momentum after impact" = "Angular momentum before impact" $
$ (M + m) l dot(theta)_0 l = m v_0 dot l + redcancel(M dot 0 dot l) $
$ dot(theta)_0 = frac(m, (M + m) l) v_0 $

Using the initial conditions, we already have the expression for
$(Theta, phi.alt)$ before, so we can use them here:
$
    Theta = sqrt(theta_0^2 + (frac(dot(theta)_0, omega'_n))) quad => quad
    Theta = frac(dot(theta)_0, omega'_n) = frac(m v_0, (M + m) l omega'_n)
$

$
    phi.alt = arctan (frac(theta_0, frac(dot(theta)_0, omega'_n))) quad => quad
    phi.alt = arctan(0) = 0 degree = 0 #unit[rad]
$

So the motion after impact becomes:
$ theta = Theta sin (omega'_n t + phi.alt) $
$ theta = frac(m v_0, (M + m) l omega'_n) sin (omega'_n t) $

== Summary of equations
#table(
    columns: 3,
    table.header(
        [],
        [*Angular / rotational vibrating systems*],
        [*Rectilinear vibrating systems*],
    ),

    [*Equation of motion*],
    $
        underbrace((...), J_o) dot.double(theta)
        + underbrace((...), k_theta) theta = 0
    $,
    $ underbrace((...), m) dot.double(x) + underbrace((...), k) x = 0 $,

    [*Solution*],
    $ theta = Theta sin (omega_n t + phi.alt) $,
    $ x = X sin (omega_n t + phi.alt) $,

    [*Natural frequency*],
    $ omega_n = sqrt(k_theta/J_o) $,
    $ omega_n = sqrt(k/m) $,

    [*Initial conditions*],
    $
        theta(0) = theta_0 \
        dot(theta)(0) = dot(theta)_0
    $,
    $
        x(0) = x_0 \
        dot(x)(0) = dot(x)_0
    $,
)

Where:
- $J_o$ is the mass moment of inertial about the centre of rotation (#unit[kg
        m^2])
- $k_theta$ is the rotational stiffness (#unit[Nm rad^-1])
- $m$ is the mass (#unit[kg])
- $k$ is stiffness (#unit[N m^-1])

#pagebreak()

== Concept of the equivalent spring-mass system
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Taking the equation of motion in #link(
            <1-dof-systems-example-5>,
        )[Example 5] and substituting $theta$ in terms of $x$:
        $ (M l^2) dot.double(theta) + (M g l + frac(k l^2, 4)) theta = 0 $

        Substitute:
        $ theta = frac(x, l/2) = frac(2 x, l) $
        $ dot.double(theta) = frac(2 dot.double(x), l) $

        $
            therefore (M l^2) frac(2 dot.double(x), l)
            + (M g l + frac(k l^2, 4)) frac(2 x, l) = 0
        $

        Equation of motion for the equivalent spring-mass system:
        $
            underbrace(
                (4 M),
                m_"eff" \ #text(red)[Effective mass]
            ) dot.double(x) + underbrace(
                (frac(4 M g, l) + k),
                k_"eff" \ #text(red)[Effective stiffness]
            ) x = 0
        $
    ],
    image("./images/equivalent-spring-mass-system-1.png"),
)

#cimage("./images/equivalent-spring-mass-system-2.png")

#grid(
    columns: 2,
    column-gutter: 2em,
    $ (M l^2) dot.double(theta) + (M g l + frac(k l^2, 4)) theta = 0 $,
    $
        underbrace((4 M), m_"eff") dot.double(x)
        + underbrace((frac(4 M g, l) + k), k_"eff") x = 0
    $,
)

- The given vibrating system can be looked upon as a spring-mass system with an
    *effective stiffness* $k_"eff"$ and an *effective mass* $m_"eff"$.
- Both systems are equivalent in the sense that they will have the same natural
    frequency and similar vibration response.
- For studying the vibration behaviour, the equivalent spring-mass system can be
    used instead of the original system.

== Other methods to construct equivalent spring-mass systems

=== Example 1
A cantilever beam carries a mass $m$ at the tip. Ignore the mass of the beam
itself. Construct an equivalent spring-mass system.

$
    "Beam length" = L, quad "Young's modulus" = E,
    quad "Cross-sectional area" M . l = I
$
#cimage("./images/equivalent-spring-mass-system-example-1-1.png")

$ "Tip deflection:" delta = frac(F L^3, 3 E I) $

So, the effective stiffness felt *at the tip of the beam*:
$ k_"eff" = frac(F, delta) = frac(3 E I, L^3) $

The effective mass *at the tip of the beam*:
$ m_"eff" = m $

$ therefore omega_n = sqrt(frac(k_"eff", m_"eff")) = sqrt(frac(3 E I, m L^3)) $

#cimage("./images/equivalent-spring-mass-system-example-1-2.png")
#pagebreak()

=== Example 2
A simply supported beam carries a mass $m$ at the mid-section as shown. Ignore
the mass of the beam itself. Construct an equivalent spring-mass system.

$
    "Beam length" = L, quad "Young's modulus" = E,
    quad "Cross-sectional area" M . l = I
$
#cimage("./images/equivalent-spring-mass-system-example-2-1.png")

$ "Central deflection:" delta = frac(F L^3, 48 E I) $

So, the effective stiffness felt *at the mid-section of the beam*:
$ k_"eff" = frac(F, delta) = frac(48 E I, L^3) $

Effective mass *at the mid-section of the beam*:
$ m_"eff" = m $

$ therefore omega_n = sqrt(k_"eff"/m_"eff") = sqrt(frac(48 E I, m L^3)) $

#cimage("./images/equivalent-spring-mass-system-example-2-2.png")
#pagebreak()

=== Example 3
The roller shown rolls without slipping. Determine the effective mass of the
roller in terms of the linear coordinate $x$, and thereby construct an
equivalent spring-mass system. Assume small displacements. Ignore the mass of
the spring.

The roller has kinetic energy due to translation as well as rotation.

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $ J_o = frac(m r^2, 2) $
        $ dot(theta) = dot(x)/r $

        $ "KE" = 1/2 m dot(x)^2 + 1/2 J_o dot(theta)^2 $
        $
            therefore "KE" & = 1/2 m dot(x)^2 + 1/2 J_o (dot(x)/r)^2 \
                           & = 1/2 (m + J_o/r^2) dot(x)^2
        $
        $ m_"eff" = m + frac(J_o, r^2) $

        Equation of motion:
        $ m_"eff" dot.double(x) + k x = 0 $
    ],
    image("./images/equivalent-spring-mass-system-example-3.png"),
)

#pagebreak()

=== Example 4
Determine the effective mass of the system considering the mass of the spring
($m_s$). We assume here the mass of the spring is *not* negligible.

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $
            "KE" & = "KE due to the mass" + "KE due to the spring" \
                 & = 1/2 M dot(x)^2 + 1/2 integral_0^L dif m dot v^2
        $
        $
            1/2 integral_0^L dif m dot v^2
            &= 1/2 integral_0^L (m_s/L dif y) dot (dot(x)/L y)^2 \
            &= 1/2 m_s/L (dot(x)/L)^2 integral_0^L y^2 thin dif y \
            &= 1/2 m_s/L (dot(x)/L)^2 L^3/3 \
            &= 1/2 (m_s/3) dot(x)^2
        $

        $
            therefore "KE" = 1/2 M dot(x)^2 + 1/2 (m_s/3) dot(x)^2
            = 1/2 (M + m_s/3) dot(x)^2
        $
        $ m_"eff" = M + m_s/3 $

        Only $1/3$ of the spring mass takes part in vibration.
    ],
    image("./images/equivalent-spring-mass-system-example-4.png"),
)

== Solutions of ordinary differential equation

=== $L dot.double(theta) + g theta = 0$
$ L dot.double(theta) + g theta = 0 $
- This is a second-order linear homogenous differential equation with constant
    coefficients ($L$ and $g$). We can rewrite it as:
    #labelled_equation(
        $
            L dot.double(theta) + g/L theta = 0
            quad => quad dot.double(theta) + g/L theta = 0
        $,
        1,
    )

- This differential equation admits solution in the exponential form, so we can
    write:
    #labelled_equation($ theta = C e^(s t) $, 2)
    #labelled_equation($ therefore dot(theta) = s C e^(s t) $, 3)
    #labelled_equation($ therefore dot.double(theta) = s^2 C e^(s t) $, 4)

    Where $C$ and $s$ are some constants yet to be determined.

- Substituting for $theta$ and $dot.double(theta)$ in equation (1) and
    cancelling common terms, we get the characteristic equation as:
    $ s^2 redcancel(C e^(s t)) + g/L C e^(s t) = 0 $
    #labelled_equation($ s^2 + g/L = 0 $, 5)

- The two roots of the characteristic equations are:
    #labelled_equation(
        $
            s_(1, 2) = plus.minus sqrt(- g/L)
            = plus.minus sqrt(-1) sqrt(g/L)
            = plus.minus i sqrt(g/L)
        $,
        6,
    )

- Defining $omega_n equiv sqrt(g/L)$, the two roots are:
    $ s_1 = + i omega_n "and" s_2 = -i omega_n $

- Substituting these roots in equation (2), we get two possible solutions:
    #labelled_equation(
        $
            cases(
                reverse: #true,
                theta_1 = C e^(+i omega_n t),
                theta_2 = C e^(-i omega_n t),
            )
        $,
        7,
    )

- The above two equations are two linearly independent solutions to equation
    (1). Any linear combination of them will also be a solution. So, the general
    solution can be written as a linear combination of them:
    #labelled_equation(
        $ theta = C_1 e^(+i omega_n t) + C_2 e^(-i omega_n t) $,
        8,
    )

- The constants $C_1$ and $C_2$ can be determined from the initial conditions:
    $ theta(t = 0) = theta_0 "and" dot(theta)(t = 0) = dot(theta)_0 $

- The solution (8) is in *complex exponential form*.
- Using Euler's formula $e^(i x) = cos x + i sin x$, we can write:
    #labelled_equation($ e^(i omega_n t) = cos omega_n t + i sin omega_n t $, 9)
    #labelled_equation(
        $ e^(i omega_n t) = cos omega_n t - i sin omega_n t $,
        10,
    )

- Substituting equation (9) and (10) into equation (8), we get
    #labelled_equation(
        $
            theta = (C_1 + C_2) cos omega_n t
            + i (C_1 - C_2) sin omega_n t
        $,
        11,
    )

- Since $C_1$ and $C_2$ are arbitrary constants, we can rewrite equation (11)
    using another set of constants $A$ and $B$ as:
    $ A equiv (C_1 + C_2) $
    $ B equiv i (C_1 - C_2) $
    #labelled_equation($ theta = A cos omega_n t + B sin omega_n t $, 12)

- The constants $A$ and $B$ can be determined based on the initial conditions.
    The general solution given by equation (12) is in *trigonometric form* which
    is more useful than the complex form in equation (8).
- We can also write equation (12) equivalently as shown below:
    #labelled_equation($ theta = Theta sin (omega_n t + phi.alt) $, 13)
- The constants $Theta$ and $phi.alt$ can be determined based on initial
    conditions.
- Both forms of the solution are equivalent.
- To express $Theta$ and $phi.alt$ in terms of $A$ and $B$, we expand equation
    (13) as:
    #labelled_equation(
        $
            theta
            = Theta (sin omega_n t cos phi.alt + cos omega_n t sin phi.alt)
        $,
        14,
    )
- Equate the coefficients of $sin omega_n t$ and $cos omega_n t$ in equations
    (12) and (14) as:
    #labelled_equation($ Theta sin phi.alt = A $, 15)
    #labelled_equation($ Theta cos phi.alt = B $, 16)

- Squaring both sides of the above two equations and adding, we get:
    #labelled_equation($ Theta = sqrt(A^2 + B^2) $, 17)

- Dividing equation (15) by equation (16) gives:
    #labelled_equation($ phi.alt = arctan(A/B) + 180 degree $, 19)

    Add $180 degree$ to the calculated value of $phi.alt$ if the denominator
    $(B)$ is negative, otherwise, add nothing.

#pagebreak()

==== Summary
- The general solution to the ODE:
    #labelled_equation($ L dot.double(theta) + g theta = 0 $, 1)

- The above can be expressed in 3 different forms:
    #labelled_equation(
        $ theta = C_1 e^(+ i omega_n t) + C_2^(-i omega_n t) $,
        8,
    )
    #labelled_equation($ theta = A cos omega_n t + B sin omega_n t $, 12)
    #labelled_equation($ theta = Theta sin (omega_n t + phi.alt) $, 13)

    $ omega_n = sqrt(g/L) $
    $ Theta = sqrt(A^2 + B^2) $
    $ phi.alt = arctan (A/B) $
- The last two forms are the most important.

=== $m dot.double(x) + k x = 0$
- The derivation is similar to that of the equation
    $L dot.double(theta) + g theta = 0$ above with the following substitutions:
    $ L -> m quad theta -> x $
    $ g -> k quad Theta -> X $
- Thus, the solution can be expressed in any of the 3 equivalent forms:
    #labelled_equation(
        $ x = C_1 e^(+ i omega_n t) + C_2^(-i omega_n t) $,
        8,
    )
    #labelled_equation($ x = A cos omega_n t + B sin omega_n t $, 12)
    #labelled_equation($ x = X sin (omega_n t + phi.alt) $, 13)

    $ omega_n = sqrt(g/L) $
    $ Theta = sqrt(A^2 + B^2) $
    $ phi.alt = arctan (A/B) $

== Why add $180 degree$ to $phi.alt$?
$ phi.alt = arctan (A/B) $

In the above formula, $B$ and $A$ are actually the horizontal and vertical
components of a vector and $phi.alt$ is the angle of inclination of the vector
with respect to the $x$-axis as shown below.

=== $A$ and $B$ are both positive
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Let's take $A = 1$ and $B = 2$ for example. The vector is in the 1st
        quadrant.
        $ phi.alt = arctan (1/2) = 26.6 degree $

        The angle calculated is correct. The angle is supposed to be positive
        and less than $90 degree$, so we can take it as is.
    ],
    image("./images/phase-both-a-and-b-are-positive.png"),
)

=== $A$ is negative and $B$ is positive
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Let's take $A = -1$ and $B = 2$ for example. The vector is in the 4th
        quadrant.
        $ phi.alt = arctan (-1/2) = -26.6 degree $

        The angle calculated is correct. The angle is supposed to be negative,
        so we can take it as is.
    ],
    image("./images/phase-a-is-negative-and-b-is-positive.png"),
)

=== $A$ is positive and $B$ is negative
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Let's take $A = 1$ and $B = -2$ for example. The vector is in the 2nd
        quadrant.
        $ phi.alt = arctan (1/(-2)) = -26.6 degree #text(red)[(Wrong)] $

        The angle calculated is wrong. From the figure, the angle is supposed to
        be more than $90 degree$ but the calculated angle is not. Also, the
        calculated angle is the same as that in the second case.

        Hence, we need to add $180 degree$ to the calculated value to get it
        right.

        The correct angle is:
        $ - 26.6 degree + 180 degree = 153.4 degree $
    ],
    image("./images/phase-a-is-positive-and-b-is-negative.png"),
)

=== Both $A$ and $B$ are negative
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Let's take $A = -1$ and $B = -2$ for example. The vector is in the 3rd
        quadrant.
        $
            phi.alt = arctan (frac(-1, -2)) = -26.6 degree
            space #text(red)[(Wrong)]
        $

        The angle calculated is wrong. From the figure, the angle is supposed to
        be more than $90 degree$ but the calculated angle is not. Also, the
        calculated angle is the same as that in the first case.

        Hence, we need to add $180 degree$ to the calculated value to get it
        right.

        The correct angle is:
        $ 26.6 degree + 180 degree = 206.6 degree $
    ],
    image("./images/phase-a-is-positive-and-b-is-negative.png"),
)

=== Conclusion
The calculated angle is wrong only when $B$ is negative. Thus, if the
denominator $B$ is negative, we need to add $180 degree$ to the calculated angle
to get it right.

#pagebreak()

== Stiffness formulas

=== Not provided
#grid(
    columns: 3,
    column-gutter: 2em,
    row-gutter: 1em,
    align: (center + horizon, center + horizon, left + horizon),
    grid.header([*Diagram*], [*Formula*], [*Variables*]),

    image("./images/stiffness-formula-not-provided-1.png", height: 5em),
    $ k = frac(E I, l) $,
    [
        - $I$ is the moment of inertia of the cross-sectional area
        - $l$ is the total length
    ],

    image("./images/stiffness-formula-not-provided-2.png"),
    $ k = frac(E A, l) $,
    [
        - $A$ is the cross-sectional area
    ],

    image("./images/stiffness-formula-not-provided-3.png"),
    $ k = frac(G J, l) $,
    [
        - $J$ is the polar moment of inertia of the cross-sectional area
    ],

    image("./images/stiffness-formula-not-provided-4.png"),
    $ k = frac(3 E I, l^3) $,
    [
        - $k$ is at the position of the load
    ],

    image("./images/stiffness-formula-not-provided-5.png"),
    $ k = frac(48 E I, l^3) $,
    [],
)

==== Effective stiffness of springs in series
#cimage("./images/stiffness-formula-springs-in-series.png", width: 85%)

$ k_"eff" = frac(1, 1/k_1 + 1/k_2) $

==== Effective stiffness of springs in parallel
#cimage("./images/stiffness-formula-springs-in-parallel.png", width: 85%)

$ k_"eff" = k_1 + k_2 $

=== Provided
#grid(
    columns: 3,
    column-gutter: 2em,
    row-gutter: 1em,
    align: (center + horizon, center + horizon, left + horizon),

    grid.header([*Diagram*], [*Formula*], [*Variables*]),

    image("./images/stiffness-formula-provided-1.png"),
    $ k = frac(G d^4, 64 n R^3) $,
    [
        - $n$ is the number of turns
    ],

    image("./images/stiffness-formula-provided-2.png", height: 6em),
    $ k = frac(192 E I, l^3) $,
    [],

    image("./images/stiffness-formula-provided-3.png", height: 6em),
    $ k = frac(768 E I, 7 l^3) $,
    [],

    image("./images/stiffness-formula-provided-4.png", height: 6em),
    $ k = frac(3 E I l, a^2 b^2) $,
    $ y_x = frac(P b x, 6 E I l) (l^2 - x^2 - b^2) $,

    image("./images/stiffness-formula-provided-5.png"),
    $ k = frac(12 E I, l^3) $,
    [],

    image("./images/stiffness-formula-provided-6.png"),
    $ k = frac(3 E I, (l + a) a^2) $,
    [],

    image("./images/stiffness-formula-provided-7.png"),
    $ k = frac(24 E I, a^2 (3l + 8a)) $,
    [],
)

== Mass moment of inertia formulas

=== Not provided
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,

    grid.header([*Diagram*], [*Formula*]),

    image("./images/mass-moment-of-inertia-not-provided-1.png"),
    $ J_o = m r^2 space ("for point mass") $,

    image("./images/mass-moment-of-inertia-not-provided-2.png"),
    $ J_z = frac(1, 12) m L^2 wide J_A = J_B = 1/3 m L^2 $,

    image("./images/mass-moment-of-inertia-not-provided-3.png"),
    $ J_z = 1/2 m R^2 wide J_x = J_y = 1/4 m R^2 $,
)

=== Provided
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,

    grid.header([*Diagram*], [*Formula*]),

    image("./images/mass-moment-of-inertia-provided-1.png"),
    $ J_z = 2/5 m R^2 wide J_x = J_y = J_z $,

    image("./images/mass-moment-of-inertia-provided-2.png"),
    $
        J_x = J_y = frac(1, 12) m (3 R^2 + h^2) \
        J_z = 1/2 m R^2
    $,
)

#pagebreak()

=== Parallel axis theorem
This theorem will not be provided in the exam.

#cimage("./images/parallel-axis-theorem.png")

$ J = J_G + M d^2 $

Where:
- $J$ is the moment of inertia needed
- $J_G$ is the moment of inertia about its own centre of gravity
- $M$ is the mass of the body
- $d$ is the distance between the axes

#pagebreak()

= Damped free vibration of 1-DOF systems

== Damping and its effect
Damping in vibrating systems is an *energy dissipating mechanism*.

Effects of damping:
- Displacement due to initial disturbances dies out with time.
- The system eventually returns to its equilibrium state.

#cimage("./images/damped-1-dof-systems-damping-graph.png", height: 20em)

Under-damped (lightly damped) system:
- Oscillatory return to equilibrium state with decaying amplitudes.

Critically damped (just nicely damped) system:
- Fastest exponential return to equilibrium state.

Over-damped (heavily damped) system:
- Slow exponential return to equilibrium state.

== Damping mechanism
Typically, there are 3 damping mechanisms.

=== Viscous damping
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Caused by the *viscous forces* due to fluid surrounding a moving part.
        - The damping force ($F_d$) is proportional to the relative velocity
            $dot(x)$ of the part with respect to the fluid, and is *opposite* in
            direction.

            #labelled_equation($ F_d = c dot(x) $, 1)
        - The constant of proportionality ($c$) is called the *damping constant*
            or *damping coefficient*.
        - For simple problems such as the ones shown on the right, the damping
            constant ($c$) can be derived from Newton's law of viscosity.
    ],
    image("./images/viscous-damping.png", height: 29em),
)

Derivation of the viscous damping constants $c$ for a spring-mass system with
the mass sliding on oil film:

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Using Newton's law of viscosity:
        $ F_d = mu A frac(dif v, dif h) $

        Where:
        - $F_d$ is the viscous force on the mass (#unit[N])
        - $mu$ is the dynamic viscosity (#unit[Pa s])
        - $A$ is the contact area (#unit[m^2])
        - $frac(dif v, dif h)$ is the velocity gradient (#unit[s^-1])

        $ frac(dif v, dif h) = dot(x)/h $
        #labelled_equation(
            $ therefore F_d = mu A dot(x)/h = frac(mu A, h) dot(x) $,
            2,
        )

        Comparing equations (1) and (2):
        $ c = frac(mu A, h) $
    ],
    image("./images/viscous-damping-constant-derivation.png"),
)

=== Coulomb (dry-friction) damping
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Caused by the *sliding friction* between the moving part and the
            stationary part.
        - The damping force ($F_d$) is proportional to the normal reaction
            ($N$), and is opposite to the direction of motion.

        $ F_d = mu_s N $

        Where $mu_s$ is the sliding friction coefficient.
    ],
    image("./images/coulomb-damping.png"),
)

=== Hysteresis, structural, material or solid damping
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Caused by *internal friction* in solids.
        - Depends on the frequency of vibration ($omega$)

        $ F_d = h dot(x)/omega $

        Where:
        - $F_d$ is the damping force
        - $h$ is the hysteresis constant
        - $dot(x)$ is the velocity
        - $omega$ is the frequency of vibration of the solid
    ],
    image("./images/hysteresis-damping.png"),
)

== Viscous damper designs
#grid(
    columns: 3,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,

    grid.header(
        [*Parallel-plate (shear) damper*],
        [*Axial damper (dashpot)*],
        [*Torsion damper*],
    ),

    image("./images/parallel-plate-damper.png"),
    image("./images/axial-damper.png"),
    image("./images/torsion-damper.png"),

    $ c = frac(mu A, h) $,
    $ c = frac(3 pi mu D^3 L, 4 d^3) (1 + frac(2d, D)) $,
    $ c_theta = frac(pi mu D^3 (L - h), 4 d) + frac(pi mu D^4, 32 h) $,

    grid.cell(stroke: red, inset: 0.5em, $ F_d = c dot(x) $),
    grid.cell(stroke: red, inset: 0.5em, $ F_d = c dot(x) $),
    grid.cell(stroke: red, inset: 0.5em, $ T_d = c_theta dot(theta) $),
)

== Practical axial viscous dampers
- Axial viscous dampers are also called *dashpots*.
- In practical axial viscous dampers, a viscous fluid is forced through small
    orifices in the piston.
- The energy spent in forcing the fluid through the orifices is dissipated in
    the form of heat.
- This loss of energy (heat) causes the damping effect.

#cimage("./images/practical-axial-viscous-dampers.png")

=== Typical applications
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - In applications such as motorcycles and scooters, *a combination of an
            axial viscous damper and a spring* is used.
        - Such a combination is often called a *shock absorber*.
    ],
    image("./images/shock-absorbers.png", height: 10em),
)

#cimage("./images/typical-applications-of-axial-dampers-1.png", height: 20em)
#cimage("./images/typical-applications-of-axial-dampers-2.png", width: 90%)

== Spring-mass-damper system

=== Derivation of the equation of motion
#cimage("./images/spring-mass-damper-system.png")

$ m dot.double(x) = sum F_x $
$ m dot.double(x) = redcancel(m g) - k (redcancel(Delta) + x) - c dot(x) $
$ m dot.double(x) + c dot(x) + k x = 0 quad "(EOM)" $

Notice that the static forces $m g$ and $k Delta$ do not appear in the equation
of motion.

=== Solution to the equation of motion
$ m dot.double(x) + c dot(x) + k x = 0 $
- This equation of motion is a second order linear differential equation with
    constant coefficients and hence has solutions in the exponential form:

    Substitute:
    $
        x(t) = C e^(r t) wide dot(x) = r C e^(r t) wide
        dot.double(x) = r^2 C e^(r t)
    $

    $
        m r^2 redcancel(C) redcancel(e^(r t))
        + c r redcancel(C) redcancel(e^(r t))
        + k redcancel(C) redcancel(e^(r t)) = 0
    $
    $ m r^2 + c r + k = 0 $
    $
        r^2 + c/m r + k/m = 0 quad => quad
        r_1, r_2 = - frac(c, 2m) plus.minus sqrt((frac(c, 2 m))^2 - k/m)
    $

- Thus, there are two independent solutions:
    $ C e^(r_1 t) "and" C e^(r_2 t) $
- The general solution is given by a linear combination of these solutions.
- So, the general solution is written as $x(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t)$

    $
        therefore x(t) = C_1 e^(t(- frac(c, 2m) + sqrt((frac(c, 2m))^2 - k/m))
        + C_2 e^(t(- frac(c, 2m) - sqrt((frac(c, 2m))^2 - k/m)))
    $

=== Three different cases of the solution
- The solution characteristics depend on the radical:
    $ sqrt((frac(c, 2m))^2 - k/m) $
- 3 different cases of the solution are possible:
    #grid(
        columns: 4,
        column-gutter: 1em,
        row-gutter: 0.5em,
        align: center + horizon,

        $ "Case 1": (frac(c, 2m))^2 > k/m $,
        $ => $,
        $ c > 2 sqrt(k m) $,
        [*Over-damped* system],

        $ "Case 2": (frac(c, 2m))^2 = k/m $,
        $ => $,
        $ c = 2 sqrt(k m) $,
        [*Critically damped* system],

        $ "Case 3": (frac(c, 2m))^2 < k/m $,
        $ => $,
        $ c < 2 sqrt(k m) $,
        [*Under-damped* system],
    )

=== Critical damping constant
- The *critical damping constant* ($c_c$) is defined as:
    $ c_c = 2 sqrt(k m) = 2 m omega_n = frac(2k, omega_n) $
- A system is said to be critically damped if its damping constant $c$ is equal
    to $c_c$, i.e. if:
    $ c = c_c $
- With this definition, the classification of the 3 solutions can also be
    interpreted in terms of $c_c$ as follows:
    #grid(
        columns: 6,
        column-gutter: 1em,
        align: center + horizon,

        $ "Case 1": (frac(c, 2m))^2 > k/m $,
        $ => $,
        $ c > 2 sqrt(k m) $,
        $ => $,
        $ c > c_c $,
        [*Over-damped* system],

        $ "Case 2": (frac(c, 2m))^2 = k/m $,
        $ => $,
        $ c = 2 sqrt(k m) $,
        $ => $,
        $ c = c_c $,
        [*Critically damped* system],

        $ "Case 3": (frac(c, 2m))^2 < k/m $,
        $ => $,
        $ c < 2 sqrt(k m) $,
        $ => $,
        $ c < c_c $,
        [*Under-damped* system],
    )

=== Damping ratio
- The *damping ratio* ($zeta$) is defined as:
    $
        zeta = c/c_c = frac(c, 2 sqrt(k m)) = c frac(c, 2 m omega_n)
        = frac(c, frac(2k, omega_n))
    $
- A system is said to be critically damped if its damping ratio $zeta = 1$.
- With this definition, the classification of the 3 solutions can also be
    interpreted in terms of $zeta$ as follows:
    #grid(
        columns: 6,
        column-gutter: 1em,
        row-gutter: 0.5em,
        align: center + horizon,

        $ "Case 1": c > 2 sqrt(k m) $,
        $ => $,
        $ c > c_c $,
        $ => $,
        $ zeta > 1 $,
        [*Over-damped* system],

        $ "Case 2": c = 2 sqrt(k m) $,
        $ => $,
        $ c = c_c $,
        $ => $,
        $ zeta = 1 $,
        [*Critically damped* system],

        $ "Case 3": c < 2 sqrt(k m) $,
        $ => $,
        $ c < c_c $,
        $ => $,
        $ zeta < 1 $,
        [*Under-damped* system],
    )

#pagebreak()

=== Rewriting the solution in terms of the damping ratio
#labelled_equation(
    $
        x(t) = C_1 e^(t(- frac(c, 2m) + sqrt((frac(c, 2m))^2) - k/m))
        + C_2 e^(t(- frac(c, 2m) - sqrt((frac(c, 2m))^2 - k/m)))
    $,
    4,
)

$ zeta = c/c_c wide omega_n sqrt(k/m) $
$
    frac(c, 2m) = c/c_c frac(c_c, 2m) = zeta frac(c_c, 2m)
    = zeta frac(2 sqrt(k m), 2m)
    = zeta frac(sqrt(k) redcancel(sqrt(m)), sqrt(m) redcancel(sqrt(m)))
    = zeta omega_n
$
$ k/m = omega_n^2 $

Substituting for $frac(c, 2 m)$ and $k/m$ in equation (4):
$
    x(t) = C_1 e^(t(- frac(c, 2m) + sqrt((frac(c, 2m))^2) - k/m))
    + C_2 e^(t(- frac(c, 2m) - sqrt((frac(c, 2m))^2 - k/m)))
$

$
    x(t) = C_1 e^(t(- zeta omega_n + sqrt((zeta omega_n)^2 - omega_n^2)))
    + C_2 e^(t(- zeta omega_n - sqrt((zeta omega_n)^2 - omega_n^2)))
$

#labelled_equation(
    $
        x(t) = C_1 e^(t(- zeta omega_n + omega_n sqrt(zeta^2 - 1)))
        + C_2 e^(t(- zeta omega_n - omega_n sqrt(zeta^2 - 1)))
    $,
    5,
)

==== Over-damped system ($zeta > 1$)
- From equation (5):
    #labelled_equation(
        $
            x(t) = C_1 e^(t(- zeta omega_n + omega_n sqrt(zeta^2 - 1)))
            + C_2 e^(t(- zeta omega_n - omega_n sqrt(zeta^2 - 1)))
        $,
        5,
    )

- Let:
    $ r_1 = - zeta omega_n + omega_n sqrt(zeta^2 - 1) $
    $ r_2 = - zeta omega_n - omega_n sqrt(zeta^2 - 1) $

- For $zeta > 1$, we can show both roots $r_1$ and $r_2$ are negative real
    numbers.
- So, we can write the solution for the over-damped system as:
    #labelled_equation($ x(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t) $, 6)

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Both $r_1$ and $r_2$ are negative real numbers. Thus the solution
            contains *negative exponential terms*.
        - Hence, with an initial displacement $x_0$, the displacement of the
            system decays exponentially and eventually the system returns to the
            equilibrium state as $t -> oo$.
    ],
    image("./images/over-damped-system-graph.png"),
)

#pagebreak()

==== Critically damped system ($zeta = 1$)
- From equation (5):
    #labelled_equation(
        $
            x(t) = C_1 e^(t(- zeta omega_n + omega_n sqrt(zeta^2 - 1)))
            + C_2 e^(t(- zeta omega_n - omega_n sqrt(zeta^2 - 1)))
        $,
        5,
    )

- Let:
    $ r_1 = - zeta omega_n + omega_n redcancel(sqrt(zeta^2 - 1)) $
    $ r_2 = - zeta omega_n - omega_n redcancel(sqrt(zeta^2 - 1)) $

- For $zeta = 1$, we get $r_1 = r_2 = - omega_n equiv r$.
- Since the roots are repeated, the solution for this case is of the form:
    #labelled_equation(
        $ x(t) = (C_1 + C_2 t) e^(r t) = (C_1 + C_2 t) e^(- omega_n t) $,
        7,
    )

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - The solution is dominated by the negative exponential term.
        - With an initial displacement $x_0$, the displacement decays
            exponentially and eventually the system returns to the equilibrium
            state as $t -> oo$.
        - However, a *critically damped system* has the *fastest* approach
            towards equilibrium state.
    ],
    image("./images/critically-damped-system-graph.png"),
)

#pagebreak()

==== Under-damped system ($zeta < 1$)
- From equation (5):
    #labelled_equation(
        $
            x(t) = C_1 e^(t(- zeta omega_n + omega_n sqrt(zeta^2 - 1)))
            + C_2 e^(t(- zeta omega_n - omega_n sqrt(zeta^2 - 1)))
        $,
        5,
    )

- Let:
    $ r_1 = - zeta omega_n + omega_n sqrt(zeta^2 - 1) $
    $ r_2 = - zeta omega_n - omega_n sqrt(zeta^2 - 1) $
- For $zeta < 1$, we can write:
    $ r_(1, 2) = - zeta omega_n plus.minus i omega_n sqrt(1 - zeta^2) $
- The roots are complex, and hence the solution for this case is of the form:
    #labelled_equation(
        $
            x(t) = C_1 e^(t(- zeta omega_n + omega_n sqrt(1 - zeta^2)))
            + C_2 e^(t(- zeta omega_n - i omega_n sqrt(1 - zeta^2)))
        $,
        8,
    )
- This complex form of the solution is not very useful in engineering, so the
    solution is often written in 2 equivalent trigonometric forms:
    #labelled_equation(
        $ x = e^(- zeta omega_n t) (A cos omega_d t + B sin omega_n t) $,
        9,
    )
    #labelled_equation($ omega_d = omega_n sqrt(1 - zeta^2) $, 10)
    #labelled_equation(
        $ x = X e^(- zeta omega_n t) sin (omega_d t + phi.alt) $,
        11,
    )

    Where $omega_d = omega_n sqrt(1 - zeta^2)$ is called the *frequency of
    damped vibration*.

- Note that the frequency of damped vibration ($omega_d$) is *less than* the
    frequency of the undamped vibration ($omega_n$), which is also known as the
    natural frequency, i.e.
    $ omega_d < omega_n $

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Considering the solution of the following form:
            $ x = X e^(- zeta omega_n t) sin (omega_d t + phi.alt) $
        - The solution contains a negative exponential term and a sinusoidal
            term.
        - Thus, with an initial displacement $x_0$, the system executes harmonic
            oscillations with exponentially decaying amplitudes.
        - The sinusoidal term controls oscillations and the negative exponential
            term controls the decay of amplitudes.
        - Many vibrating systems in mechanical engineering are under-damped.
    ],
    image("./images/under-damped-system-graph.png"),
)

=== Summary
#table(
    columns: 3,

    table.header([*Damping*], [*Form of solution*], [*Characteristics*]),

    $ zeta > 1 $,
    $
        x(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t) \
        "where" r_1, r_2 = - zeta omega_n plus.minus omega_n sqrt(zeta^2 - 1)
    $,
    [
        *Over-damped*
        - Slow exponential return to the equilibrium state.
        - Non-oscillatory solution.
    ],

    $ zeta = 1 $,
    $ x(t) = (C_1 + C_2 t) e^(- omega_n t) $,
    [
        *Critically damped*
        - Fastest exponential return to the equilibrium state.
        - Non-oscillatory solution.
    ],

    $ zeta < 1 $,
    $
                   x(t) & = e^(- zeta omega_n t)
                          (A cos omega_d t + B sin omega_d t) \
        bold("or") x(t) & = e^(- zeta omega_n t) X sin (omega_d t + phi.alt) \
        "where" omega_d & = sqrt(1 - zeta^2) omega_n
    $,
    [
        *Under-damped*
        - Oscillatory return to the equilibrium state with exponentially
            decaying amplitudes.
        - Oscillatory solution.
    ],

    $ zeta < 1 $,
    $
                   x(t) & = A cos omega_n t + B sin omega_n t \
        bold("or") x(t) & = X sin (omega_n t + phi.alt) \
        "where" omega_n & = sqrt(k/m)
    $,
    [
        *Undamped*
        - Perpetual oscillations with constant amplitude.
    ],

    table.cell(colspan: 3)[
        *Note*: The unknown constants $C_1$ and $C_2$, or $A$ and $B$, or $X$
        and $phi.alt$ are to be determined from the initial conditions, like the
        initial displacement and velocity.
    ],
)

=== Example 1
Given: A 1-DOF system has mass $m = #qty[1][kg]$, stiffness $k = #qty[9][N
    m^-1]$, and damping constant $c = #qty[6][Ns m^-1]$.
#[
    #set enum(numbering: "a)")
    + Find its natural frequency.
    + Find its critical damping constant, damping ratio, and hence frequency of
        damped vibration.
    + Find the free vibration response if the mass is released from a distance
        of #qty[30][mm] below the equilibrium position with zero velocity.
    + If the damping constant is changed to #qty[15][Ns m^-1], what would be the
        free vibration response?
    + If the damping constant is changed to #qty[1][Ns m^-1], what would be the
        free vibration response?
]

#cimage("./images/spring-mass-damper-example-1.png", height: 15em)
#pagebreak()

==== a) Natural frequency
$ omega_n = sqrt(k/m) = sqrt(9/1) = #qty[3][rad s^-1] $
$ f_n = frac(omega_n, 2 pi) = #qty[0.477][Hz] $

==== b) Critical damping constant, damping ratio, and damped frequency
Critical damping constant:
$ c_c = 2 sqrt(k m) = 2 sqrt(9 times 1) = #qty[6][Ns m^-1] $

Damping ratio:
$ zeta = c/c_c = 6/6 = 1 quad "(Critically damped)" $

Damped frequency of vibration:
$
    omega_d = omega_n sqrt(1 - zeta^2) = sqrt(1 - 1^2) (3) = 0
    quad "(No oscillation)"
$

==== c) Free vibration response with an initial displacement of #qty[30][mm]
The system is critically damped ($zeta = 1$), so the free vibration response
will be as follows:
$ x(t) = (C_1 + C_2 t) e^(- omega_n t) $

The initial conditions are given:
$ x(0) = #qty[30][mm] = #qty[0.03][m] wide dot(x) (0) = 0 $

Substituting the initial conditions:
$
    x(0) = #qty[0.03][m] quad => quad 0.03 = (C_1 + C_2 dot 0)
    e^(- omega_n dot 0) => C_1 = 0.03
$

$
    dot(x) (0) = 0 quad => quad
    & dot(x) = (C_1 + C_2 t) (- omega_n) e^(- omega_n t)
    + (0 + C_2) e^(- omega_n t) \
    & 0 = (C_1 + C_2 dot 0) (- omega_n)
    e^(- omega_n dot 0) + (0 + C_2) e^(- omega_n dot 0) \
    & 0 = - C_1 omega_n + C_2 \
    & C_2 = C_1 omega_n = (0.03)(3) = 0.09
$

Hence, the under-damped free vibration response becomes:
$ x(t) = (0.03 + 0.09 t) e^(- 3t) $

#pagebreak()

==== d) Response when the damping constant is changed to #qty[15][Ns m^-1]
The damping ratio becomes > 1:
$ zeta = c/c_c = 15/6 = 2.5 quad "(Over-damped)" $

So the vibration response is given by:
$ x(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t) $

Where:
$ r_1, r_2 = omega_n (- zeta plus.minus sqrt(zeta^2 - 1)) $
$ therefore r_1, r_2 = 3 (- 2.5 plus.minus sqrt(2.5^2 - 1)) = -0.626, -14.374 $

Substituting the initial conditions:
$
    x(0) = #qty[0.03][m] quad => quad
    0.03 = C_1e^(r_1 dot 0) + C_2 e^(r_2 dot 0) quad => quad C_1 + C_2 = 0.03
$

$ dot(x) (0) = 0 $
$ dot(x) = r_1 C_1 e^(r_1 t) + r_2 C_2 e^(r_2 t) $
$ 0 = r_1 C_1 e^(r_1 dot 0) + r_2 C_2 e^(r_2 0) $
$ r_1 C_1 + r_2 C_2 = 0 $

Solving the equations:
$ C_1 = 0.0314, quad C_2 = -0.00137 $

So the solution becomes:
$ x(t) = C_1 e^(-0.626 t) + C_2 e^(-14.374 t) $

#pagebreak()

==== e) Response when the damping constant is changed to #qty[1][Ns m^-1]
The damping ratio becomes < 1:
$ zeta = c/c_c = 1/6 = 0.167 quad "(Under-damped)" $

So the vibration response is given by:
$ x(t) = e^(- zeta omega_n t) A cos omega_d t + B sin omega_d t $

Where:
$ omega_d = omega_n sqrt(1 - zeta^2) $
$ omega_d = 3 times sqrt(1 - 0.167^2) = 2.958 $

Substituting the initial conditions:
$
    x(t = 0) = 0.03 quad => quad
    0.03 = e^(- zeta omega_n dot 0) (A cos omega_d dot 0 + B sin omega_d dot 0)
    quad => quad A = 0.03
$

$
    dot(x) =
    (- zeta omega_n) e^(- zeta omega_n t) (A cos omega_d t + B sin omega_d t)
    + e^(-zeta omega_n t) (- omega_d A sin omega_d t + omega_d B cos omega_d t)
$
$ dot(x) (t = 0) = 0 $
$ 0 = (- zeta omega_n) A + omega_d B $
$ -0.167 times 3 times 0.03 + 2.958 B = 0 $
$ B = 0.00508 $

So, the solution becomes:
$ x(t) = e^(-0.501t) (0.03 cos 2.958 t + 0.00508 sin 2.958 t) $

#pagebreak()

=== Example 2
#cimage("./images/spring-mass-damper-example-2-trucks.png", width: 80%)

How does the added mass affect the vibration characteristics?

The added mass has 3 important effects:
+ It *reduces* the *damping ratio*. Hence, the vibration characteristics can
    change completely. AN originally critically damped system or over-damped
    system can become under-damped.
+ It *reduces* the *natural frequency*.
+ It *increases* the *static deflection*.

A truck is designed to be critically damped (with a damping ratio of $zeta = 1$)
at the recommended payload. If the actual payload on a particular day is more
than the recommended payload by 20% (i.e., the mass increases from $m$ to
$1.2 m$), will the system still be critically damped? Assume the stiffness and
the damping coefficient of the system remain the same.

#cimage("./images/spring-mass-damper-example-2.png", width: 80%)

No, the system will not be critically damped.

Original damping ratio:
$ zeta_"original" = c/c_"cr" = frac(c, 2 sqrt(k m)) $

New damping ratio:
$
    zeta_"new" = c/c_"cr" = frac(c, 2 sqrt(k (1.2 m)))
    = frac(c, 2 sqrt(k m)) frac(1, sqrt(1.2)) = 0.91 quad "(Under-damped)"
$

Note that an *increase* in *stiffness* will also have a similar effect.

== Damping measurement in under-damped systems
- An under-damped system executes harmonic oscillations with exponentially
    decaying amplitudes, expressed as:
    $ x(t) = X e^(- zeta omega_n t) sin (omega_d t + phi.alt) $
- Damped natural frequency ($omega_d$) can be expressed in terms of undamped
    natural frequency ($omega_n$) as:
    $ omega_d = omega_n sqrt(1 - zeta^2) $
- The damped period is given by:
    $ tau_d = frac(2 pi, omega_d) $

#cimage("./images/under-damped-system-measurement.png")
#pagebreak()

=== Logarithmic decrement
$ x(t) = X e^(- zeta omega_n t) sin (omega_d t + phi.alt) $

Let the displacement at some time $t_1$ be:
$ x_1 = x(t_1) $

Let the displacement after one time period be:
$ x_2 = x(t_1 + tau_d) $

Logarithmic decrement $delta$ is defined as:
$
    delta equiv ln x_1/x_2 & =
                             ln frac(
                                 X e^(-zeta omega_n t_1)
                                 redcancel(sin (omega_d t_1 + phi.alt)),
                                 X e^(-zeta omega_n (t_1 + tau_d))
                                 redcancel(
                                     sin (
                                         omega_d (t_1 + tau_d) + phi.alt
                                     )
                                 )
                             ) \
                           & = ln frac(
                                 e^(-zeta omega_n t_1),
                                 e^(-zeta omega_n (t_1 + tau_d))
                             ) \
                           & = ln frac(
                                 redcancel(e^(-zeta omega_n t_1)),
                                 redcancel(e^(-zeta omega_n t_1))
                                 e^(-zeta omega_n tau_d)
                             ) \
                           & = ln e^(zeta omega_n tau_d) \
                           & = zeta omega_n tau_d \
                           & = zeta omega_n frac(2pi, omega_d) \
                           & = zeta omega_n frac(
                                 2 pi,
                                 omega_n sqrt(1 - zeta^2)
                             ) \
                           & = frac(2 pi zeta, sqrt(1 - zeta^2))
$

#pagebreak()

=== Experimental determination of damping ratio
- Assume that the displacement reduces from *$x_1$ to $x_2$ in one cycle* in the
    free vibration trace.

    $ delta = ln x_1/x_2, wide delta = frac(2 pi zeta, sqrt(1 - zeta^2)) $
- First, calculate $zeta$ by substituting $x_1$ and $x_2$ in the formula:
    $ delta equiv x_1/x_2 $
- Next, calculate $zeta$ by substituting $delta$ in
    $delta = frac(2 pi zeta, sqrt(1 - zeta^2))$ as:
    $ zeta = sqrt(frac(delta^2, 4 pi^2 + delta^2)) $
- Assume that the displacement reduces from $x_1$ to $x_4$ in *three cycles*.
    #cimage("./images/experimental-determination-of-damping-ratio.png")
- To determine $zeta$, let $(x_1, x_2, x_3, x_4)$ by displacements at time
    $(t_1, t_1 + tau, t_1 + 2 tau, t_1 + 3 tau)$.
- Calculate $delta$ as follows:
    $
        ln x_1/x_4 & = ln (x_1/x_2 x_2/x_3 x_3/x_4) \
                   & = ln x_1/x_2 + x_2/x_3 + ln x_3/x_4 quad
                     (
                         because "for viscous damping:"
                         x_1/x_2 = x_2/x_3 = x_3/x_4
                     ) \
                   & = delta + delta + delta = 3 delta
    $
    $ delta = 1/3 ln x_1/x_4 $
- Calculate $zeta$ as follows:
    $ zeta = sqrt(frac(delta^2, 4 pi^2 + delta^2)) $

#pagebreak()

=== Example 1
From a free vibration trace, the amplitudes corresponding to first and second
peak were found to be #qty[0.05][m] and #qty[0.005][m], respectively. Determine
the damping ratio.

#cimage("./images/under-damped-system-measurement-example-1.png", height: 15em)

$ X_1 = #qty[0.05][m] wide X_2 = #qty[0.005][m] $
$ delta = ln X_1/X_2 = ln 0.05/0.005 = 2.303 $
$
    zeta = sqrt(frac(delta^2, 4 pi^2 + delta^2))
    = sqrt(frac(2.303^2, 4 pi^2 + 2.303^2)) = 0.344
$

=== Example 2
In a vibration experiment, the amplitudes corresponding to *second* and *fourth
peak* were found to be #qty[0.05][m] and #qty[0.005][m], respectively. Determine
the damping ratio.

#cimage("./images/under-damped-system-measurement-example-2.png", height: 15em)

$ X_2 = #qty[0.05][m] wide X_4 = #qty[0.005][m] $

*Two cycles* are completed between $X_2$ and $X_4$.
$ delta = 1/2 ln X_2/X_4 = 1/2 ln 0.05/0.005 = 1.1515 $
$
    zeta = sqrt(frac(delta^2, 4 pi^2 + delta^2))
    = sqrt(frac(1.1515^2, 4 pi^2 + 1.1515^2)) = 0.18
$

=== Example 3
Consider a spring-mass-damper system with $m = #qty[5][kg], k = #qty[500][N
    m^-1]$ damping ratio $zeta = 0.1$. The mass is pulled down by a distance
(#qty[10][mm]) below the static equilibrium position (SEP) and released gently
(with zero velocity). The mass undergoes damped oscillations. What is the time
taken for the mass to reach the first peak displacement from the initial
position (of #qty[10][mm] below SEP)?

#cimage("./images/under-damped-system-measurement-example-3.png", width: 90%)

- The equation of motion is:
    $ m dot.double(x) + c dot(x) + k x = 0 $
    $ omega_n = sqrt(k/m) = sqrt(500/5) = #qty[10][rad s^-1] $
    $
        omega_d = omega_n sqrt(1 - zeta^2)
        = 10 sqrt(1 - 0.1^2) = #qty[9.95][rad s^-1]
    $
- As this is an under-damped system ($zeta = 0.1$), the free vibration response
    (solution to the equation of motion) is given by:
    $ x(t) = X e^(- zeta omega_n t) sin (omega_d t + phi.alt) $
    $
        dot(x) (t) = - zeta omega_n X e^(- zeta omega_n t)
        sin (omega_d t + phi.alt) + omega_d X e^(- zeta omega_n t)
        cos (omega_d t + phi.alt)
    $
- Substituting the initial conditions $x(0) = #qty[10][mm], dot(x)(0) = 0$:
    $ 10 = X sin phi.alt $
    $ 0 = - zeta omega_n X sin phi.alt + omega_d X cos phi.alt $
- Solving these two equations for $X sin phi.alt$ and $X cos phi.alt$:
    $ X sin phi.alt = 10 $
    $ X cos phi.alt = frac(10 zeta omega_n, omega_d) $
- Squaring both sides of the above two equations and adding:
    $
        X^2 sin^2 phi.alt + X^2 cos^2 phi.alt = 10^2
        + (frac(10 zeta omega_n, omega_d))^2
    $
    $ X^2 = 10^2 + (frac(10 (0.1) (10), 9.95))^2 $
    $ X = 10.05 $

#pagebreak()

- Dividing the first equation by the second equation:
    $
        tan phi.alt = frac(omega_d, zeta omega_n) = frac(sqrt(1 - zeta^2), zeta)
        = frac(1 - zeta^2, zeta) = frac(9.95, (0.1)(10)) = 9.95
    $
    $ phi.alt = #qty[1.47][rad] $
- Thus, the response becomes:
    $ x(t) = X e^(- zeta omega_n t) sin (omega_d t + phi.alt) $
    $ x(t) = 10.05 e^(-t) sin (9.95 t+ 1.47) $
- The first peak (maximum) amplitude occurs when $frac(dif x, dif t) = 0$ for
    the first time:
    $
        frac(dif x, dif t) equiv dot(x) (t)
        = - zeta omega_n redcancel(X) redcancel(e^(-zeta omega_n t))
        sin (omega_d t + phi.alt)
        + omega_d redcancel(X) redcancel(e^(- zeta omega_n t))
        cos (omega_d t + phi.alt) = 0
    $
    $
        frac(sin (omega_d t+ 1.47), cos (omega_d t + 1.47))
        = frac(omega_d, zeta omega_n)
        = frac(omega_n sqrt(1 - zeta^2), zeta omega_n)
        = frac(sqrt(1 - zeta^2), zeta)
    $
    $ tan(omega_d t + 1.47) = frac(sqrt(1 - zeta^2), zeta) $
    $
        omega_d t redcancel(+ 1.47) = n pi +
        redcancel(arctan frac(sqrt(1 - zeta^2), zeta))
    $

    Note:
    - Calculate $arctan$ in radian mode.
    - Note the $n$ in the final equation.
- $n = 1$ corresponds to the first peak. Substituting the values of $n, omega_d$
    and $zeta$:
    $
        t = frac(pi + redcancel(arctan frac(1 - zeta^2, zeta) - 1.47), omega_d)
        = #qty[0.316][s]
    $

#pagebreak()

== A damped rotational system
In the figure below, the system is in equilibrium with a rigid bar in the
horizontal position. THe bar is of negligible mass.
#[
    #set enum(numbering: "a)")
    + Write the equation of motion.
    + Determine the damping ratio.
    + Determine the frequency of the damped oscillations.
]

#cimage("./images/damped-rotational-system.png")

- The system is in equilibrium with the rod remaining horizontal.
- This means the weight $M g$ of the mass is already balanced by the downward
    force due to the stretching of the spring.
- Let the stretching of the spring be $Delta$.

#pagebreak()

=== a) Equation of motion
The free body diagrams for static and dynamic analyses are shown below:
#cimage("./images/damped-rotational-system-free-body-diagrams.png")

- For static analysis:
    $ sum M_o = 0 $
    $ - k Delta dot a + M g dot (L - a) = 0 $
- For dynamic analysis:
    $ J_o dot.double(theta) = sum M_o $
    $
        M (L - a)^2 dot.double(theta) = redcancel(- k Delta dot a)
        - k a theta dot a) redcancel(+ M g (L - a)) - c (b dot(theta)) dot b
        quad (because -k Delta dot a + M g dot (L - a) = 0)
    $
    $ M (L - a)^2 dot.double(theta) = - k a^2 theta - c b^2 dot(theta) $
    $
        underbrace(M (L - a)^2, J_o) dot.double(theta)
        + underbrace(c b^2 dot(theta), c_theta)
        + underbrace(k a^2 theta, k_theta) = 0 quad "(equation of motion)"
    $

The equation of motion is rewritten in the form:
$ J_o dot.double(theta) + c_theta dot(theta) + k_theta theta = 0 $
$ J_o equiv M (L - a)^2 wide c_theta equiv c b^2 wide k_theta equiv k a^2 $

#pagebreak()

=== b) Damping ratio
Generating the necessary equations for a rotation system from those of a
rectilinear system:
#align(center, pad(x: -3em, table(
    columns: 3,
    align: center + horizon,
    stroke: none,

    table.vline(stroke: red, x: 0),
    table.vline(stroke: red, x: 1),
    table.hline(stroke: red, end: 1),

    table.vline(stroke: red, x: 2),
    table.vline(stroke: red, x: 3),
    table.hline(stroke: red, start: 2),

    [*Rectilinear vibrating system*],
    table.cell(rowspan: 7, text(red, $ => $)),
    [*Rotational vibrating system*],

    $ m dot.double(x) + c dot(x) + k x = 0 $,
    $ J_o dot.double(theta) + c_theta dot(theta) + k_theta theta = 0 $,

    $ omega_n = sqrt(k/m) $, $ omega_n = sqrt(k_theta/J_o) $,

    $ c_c = 2 sqrt(k m) $, $ (c_theta)_c = 2 sqrt(k_theta J_o) $,

    $ zeta = c/c_c = frac(c, 2 sqrt(k m)) $,
    $ zeta = c_theta/(c_theta)_c = frac(c_theta, 2 sqrt(k_theta J_o)) $,

    $ omega_d = omega_n sqrt(1 - zeta^2) $,
    $ omega_d = omega_n sqrt(1 - zeta^2) $,

    grid(
        columns: 2,
        column-gutter: 2em,
        row-gutter: 0.5em,
        $ zeta > 1 $, $ x(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t) $,
        $ zeta = 1 $, $ x(t) = (C_1 + C_2 t) e^(- omega_n t) $,
        $ zeta < 1 $,
        $
                       & x(t) = e^(- zeta omega_n t)
                         (A cos omega_d t + B sin omega_d t) \
            bold("or") & x(t) = X e^(- zeta omega_n t)
                         sin (omega_d t + phi.alt)
        $,
    ),

    grid(
        columns: 2,
        column-gutter: 2em,
        row-gutter: 0.5em,

        $ zeta > 1 $, $ theta(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t) $,
        $ zeta = 1 $, $ theta(t) = (C_1 + C_2 t) e^(- omega_n t) $,
        $ zeta < 1 $,
        $
                       & theta(t) = e^(- zeta omega_n t)
                         (A cos omega_d t + B sin omega_d t) \
            bold("or") & theta(t) = Theta e^(- zeta omega_n t)
                         sin (omega_d t + phi.alt)
        $,
    ),

    table.hline(stroke: red, end: 1),
    table.hline(stroke: red, start: 2),
)))

- The damping ratio is given by:
    $ zeta = frac(c_theta, (c_theta)_c) = frac(c_theta, 2 sqrt(k_theta J_o)) $

    Substituting for $c_theta, k_theta$ and $J_o$:
    $ zeta = frac(c b^2, 2 sqrt(k a^2 M (L - a)^2)) $

- The natural frequency is given by:
    $ omega_n = sqrt(k_theta/J_o) $

    Substituting for $k_theta$ and $J_o$:
    $ omega_n = sqrt(frac(k a^2, M (L - a)^2)) $

=== c) Frequency of damped oscillations
$ omega_d = omega_n sqrt(1 - zeta^2) $

Substituting for $omega_n$ and $zeta$:
$
    omega_d = sqrt(frac(k a^2, M (L - a)^2))
    sqrt(1 - (frac(c b^2, 2 sqrt(k a^2 M (L - a)^2)))^2)
$

#pagebreak()

= Forced vibration of 1-DOF systems under harmonic excitation
- In forced vibration analysis, two kinds of excitations are possible:
    + Force excitation
    + Base excitation

    #cimage("./images/force-and-base-excitation.png", height: 20em)

- Force excitation may be:
    + Harmonic
    + General periodic
    + Non-periodic

    #cimage("./images/force-excitation-types.png", height: 20em)

- Harmonic force excitations usually of the form:
    #grid(
        columns: 2,
        column-gutter: 2em,

        $
            F (t) = underbrace(F_0, "Force amplitude")
            sin underbrace(omega, "Excitation frequency") t
        $,
        image("./images/harmonic-force-excitation.png"),
    )

== Spring-mass system under harmonic force excitation

=== Derivation of the equation of motion (EOM)
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Consider a spring-mass system subjected to a harmonic force:
            $ F (t) = F_0 sin omega t $
        - Applying Newton's second law to the free body diagram
            $ m dot.double(x) = sum F_x $
            $ m dot.double(x) = F_0 sin omega t - k (Delta + x) + m g $
            $
                m dot.double(x) + k x = F_0 sin omega t
                quad "(equation of motion)"
            $
    ],
    image("./images/harmonic-force-excitation-equation-of-motion.png"),
)

=== Complete solution to the equation of motion
$ m dot.double(x) = k x = F_0 sin omega t $

- The above is a *non-homogenous* differential equation, which means the right
    side of the equation is not 0.
- So, the *complete solution* ($x$) is written as a sum of the *homogenous
    solution* ($x_h$) and the *particular solution* ($x_p$):
    $
        x & = x_h (t) + x_p (t) \
          & = underbrace(
                (A cos omega), #text[
                    Homogenous solution \
                    (Free vibration response) \
                    (Transient response)
                ]
            )
            + underbrace(
                overbrace(X, "Amplitude") sin (
                    overbrace(omega, "Same as excitation frequency") t
                    - overbrace(phi.alt, "Phase lag")
                ), #text[
                    Particular solution \
                    (Forced vibration response) \
                    (Steady-state response)
                ]
            )
    $
- If there is any damping in the system, the free vibration response will
    eventually die out. Hence, the *free vibration response* is sometimes called
    the *transient response*. Transient means short-lived, or temporary.

#pagebreak()

=== Steady-state response (forced vibration response)
$ m dot.double(x) + k x = F_0 sin omega t $

The steady-state response is in the form:
$
    x = X sin (omega t - phi.alt) wide dot.double(x)
    - omega^2 X sin (omega t - phi.alt)
$

Substituting the above into the equation of motion:
$
    - m omega^2 X sin (omega t - phi.alt) + k X sin (omega t - phi.alt)
    = F_0 sin omega t
$
$ (k X - m omega^2 X) sin omega t - phi.alt) = F_0 sin omega t $
$
    (k x - m omega^2 X) (sin omega t cos phi.alt - cos omega t sin phi.alt)
    = F_0 sin omega t
$

Equating the coefficients of *$cos omega t$* and *$sin omega t$* on both sides:
#labelled_equation($ - (k X - m omega^2 X) sin phi.alt = 0 $, "A")
#labelled_equation($ (k X - m omega^2 X) cos phi.alt = F_0 $, "B")

Squaring both sides of equation (A) and (B) and adding, we get:
$ (k X - m omega^2 X)^2 = F_0^2 $
$ X = frac(F_0, k) = frac(F_0/k, 1 - (omega/omega_n)^2) $

Dividing equation (A) by equation (B):
$ tan phi.alt = 0 quad => quad phi.alt = 0 $

#pagebreak()

==== Form 1
$ x_p (t) = X sin (omega t - phi.alt) $

Where:
$ X = frac(F_0/k, 1 - (omega/omega_n)^2) = frac(F_0, k - omega^2 m) $
$ phi.alt = 0 $

Plot of the steady-state response:
#cimage("./images/harmonic-force-excitation-form-1-plots.png")
#pagebreak()

==== Form 2
$ x_p (t) = X sin (omega t - phi.alt) $

Where:
$
    X equiv = frac(
        F_0/k,
        underbrace(lr(|1 - (omega/omega_n)^2|), "Note the absolute sign")
    )
$
$ phi.alt = 0, quad omega/omega_n < 1 $
$ phi.alt = pi, quad omega/omega_n > 1 $

Plots of the steady-state response:
#cimage("./images/harmonic-force-excitation-form-2-plots.png")
#pagebreak()

==== Deriving form 2 from form 1
$
    x_p (t) = X sin (omega t - phi.alt)
    quad "where" quad X = frac(F_0/k, 1 - (omega/omega_n)^2)
$

Note that:
$ 1 - (omega/omega_n)^2 #text[will be *positive* when] omega < omega_n $
$ 1 - (omega/omega_n)^2 #text[will be *negative* when] omega > omega_n $

Hence:
#align(center)[$X$ will be *positive* when $omega < omega_n$]
#align(center)[$X$ will be *negative* when $omega > omega_n$]

Redefining $X$ as:
$ X equiv = frac(F_0/k, lr(|1 - (omega/omega_n)^2|)) $

So, form 1 can equivalently rewritten as:
$
    x_p (t) &= X sin (omega t) "for" omega < omega_n
    &= - X sin (omega t) "for" omega > omega_n
$

Absorbing the *minus sign* into the sine term, this can also be written as:
$
    x_p (t) &= X sin (omega t) "for" omega < omega_n
    &= X sin (omega t - pi) "for" omega > omega_n
$

Or alternatively, giving form 2:
$ x_p (t) = X sin (omega t - phi.alt) $

Where:
$ phi.alt = 0, quad omega/omega_n < 1 $
$ phi.alt = pi, quad omega/omega_n > 1 $

#pagebreak()

==== Interpretation of phase lag ($phi.alt$)
Using form 2 for the interpretation:
#cimage("./images/harmonic-force-excitation-phase-lag.png")

- When $phi.alt = 0$, $F(t)$ and $x_p (t)$ are *in phase*.
- When $phi.alt = pi$, $x_p (t)$ *lags behind* $F(t)$ by an angle of $pi$
    radians.

#pagebreak()

=== Plot of the complete solution
$ x = x_h (t) + x_p (t) $

Form 1:
$
    x = A cos omega_n t + B sin omega_n t
    + frac(F_0/k, 1 - (omega/omega_n)^2) sin omega t
$

Form 2:
$
    x = A cos omega_n t + B sin omega_n t
    + frac(F_0/k, lr(|1 - (omega/omega_n)^2|)) sin (omega t - phi.alt)
$
$ phi.alt = 0, quad omega/omega_n < 1 $
$ phi.alt = pi, quad omega/omega_n > 1 $

#cimage("./images/harmonic-force-excitation-complete-solution-plot.png")
#pagebreak()

=== Example 1: Steady state amplitude
A #qty[5][kg] fan is supported on a platform of mass #qty[3][kg] which is in
turn resting on a spring of mass #qty[6][kg] and stiffness of #qty[1000][N
    m^-1]. The platform is guided to move vertically. The fan rotates at
#qty[60][rpm]. Because of eccentric mass off the axle of rotation, the rotating
fan generates a harmonic force with an amplitude of #qty[5][N] in the vertical
direction.

Calculate the steady-state vibration amplitude of the fan at the given speed.
#cimage("./images/harmonic-force-excitation-example-1.png", width: 90%)

#cimage(
    "./images/harmonic-force-excitation-example-1-free-body-diagrams.png",
    width: 95%,
)

Static analysis:
$ k Delta = m g $

Dynamic analysis:
$ m dot.double(x) = sum F_x $
$
    m dot.double(x)
    = F_0 sin omega t + redcancel(k Delta) - redcancel(m g) - k x
$
$ m dot.double(x) + k x = F_0 sin omega t quad "(equation of motion)" $

Steady-state solution:
$ x_p = X sin (omega t - phi.alt) $

Substituting the steady-state solution into the equation of motion:
$
    X = frac(F_0, lr(|k - m omega^2|)) = frac(5, lr(|1000 - 10 (2 pi)^2|))
    = 8.26 times 10^(-3) #unit[m] = #qty[8.26][mm]
$

=== Example 2: Total response
Consider the fan in the example above again.

Assume that, at time $t = 0$, the initial displacement is #qty[-0.01][m] and the
initial velocity is zero (i.e., the platform and the fan are depressed by a
distance #qty[0.01][m] and then they are gently released with the fan running at
#qty[60][rpm]).

Determine subsequent response of the system.

The subsequent response refers to the total response of the system.

The initial conditions are:
$ x(0) = #qty[-0.01][m], wide dot(x) (0) = 0 $

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    [
        $ omega_n = sqrt(k/m) = sqrt(1000/10) = #qty[10][rad s^-1] $
        $ omega/omega_n = frac(2 pi, 10) = 0.628 $

        Total response:
        $
            x = & A cos omega_n t + B sin omega_n t \
                & + frac(F_0/k, 1 - (omega/omega_n)^2)
                  sin (omega t) quad "(Form 1)"
        $

        $
            dot(x) = & - omega_n A sin omega_n t + omega_n B cos omega_n t \
                     & + frac(F_0/k, 1 - (omega/omega_n)^2) omega cos (omega t)
        $
    ],
    image("./images/harmonic-force-excitation-example-2.png"),
))

Substituting the initial conditions:
$ x(0) = #qty[-0.01][m] quad => quad A = - 0.01, wide dot(x) (0) = 0 $
$ 0 = omega_n B + frac(F_0/k, 1 - (omega/omega_n)^2) omega $
$ B = - frac(F_0/k, 1 - (omega/omega_n)^2) omega/omega_n $
$ B = - frac(5/1000, 1 - (0.628)^2) times 0.628 = -0.00518 $

$ frac(F_0/k, 1 - (omega/omega_n)^2) = frac(5/1000, 1 - (0.628)^2) = 0.00826 $

So, the total response is:
$ x = -0.01 cos omega_n t - 0.00518 sin omega_n t + 0.00826 sin (omega t) $

== Spring-mass-damper system under harmonic force excitation

=== Derivation of the equation of motion
#grid(
    columns: 2,
    [
        - Consider a spring-mass-damper system with harmonic excitation:
            $ F(t) = F_0 sin omega t $
        - Apply Newton's second law:
            $ m dot.double(x) = sum F_x $
            $
                m dot.double(x) = F_0 sin omega t - k (redcancel(Delta) + x)
                - c dot(x) + redcancel(m g)
            $
            $
                m dot.double(x) + c dot(x) + k x = F_0 sin omega t
                quad "(Equation of motion)"
            $
    ],
    image(
        "./images/harmonic-force-excitation-damper-equation-of-motion.png",
        height: 16em,
    ),
)

=== Complete solution to the equation of motion
$ m dot.double(x) + c dot(x) + k x = F_0 sin omega t $

The complete solution:
$
    x & = x_h (t) + x_p (t) \
      & = underbrace(
            e^(- zeta omega_n t) (A cos omega_d t + B sin omega_d t),
            #text[
                Free vibration response \
                Transient response \
                (assuming under-damped system)
            ]
        )
        + underbrace(
            overbrace(X, "Amplitude") sin (
                overbrace(omega, "Same as excitation frequency") t
                - overbrace(phi.alt, "Phase lag")
            ),
            #text[
                Forced vibration response \
                Steady-state response
            ]
        )
$

#cimage("./images/harmonic-force-excitation-damper-complete-solution.png")

As time passes, the transient response dies out due to damping and the total
solution ($x$) essentially contains only the steady-state response.

=== Steady-state response (forced vibration response)
$
    m dot.double(x) + c dot(x) + k x = F_0 sin omega t
    quad "(equation of motion)"
$

Steady-state solution is in the form:
$ x = X sin (omega t - phi.alt) $
$
    dot(x) = omega X cos (omega t - phi.alt), wide
    dot.double(x) = - omega^2 X sin (omega t - phi.alt)
$

Substituting the steady-state solution into the equation of motion:
$
    - m dot omega^2 X sin (omega t - phi.alt)
    + c dot omega X cos (omega t - phi.alt)
    + k dot X sin (omega t -phi.alt)
    = F_0 sin omega t
$

Using the below two trigonometric identities:
$ sin (A - B) = sin A cos B - cos A sin B $
$ cos (A - B) = cos A cos B + sin A sin B $

The equation of motion becomes:
$
    (k - m omega^2) X (sin omega t cos phi.alt - cos omega t sin phi.alt)
    + c omega X (cos omega t cos phi.alt + sin omega t sin phi.alt)
    = F_0 sin omega t
$

Equating the coefficients of *$sin omega t$* and *$cos omega t$* appearing on
both sides:
#labelled_equation(
    $ (k - m omega^2) X cos phi.alt + c omega X sin phi.alt = F_0 $,
    "A",
)
#labelled_equation(
    $ - (k - m omega^2) X sin phi.alt + c omega X cos phi.alt = 0 $,
    "B",
)

Rewriting equations (A) and (B) as:
$
    bmat(
        c omega, (k - m omega^2);
        - (k - m omega^2), c omega;
    ) cvec(X sin phi.alt, X cos phi.alt)
    = cvec(F_0, 0)
$

Solving the above equation for *$X sin phi.alt$* and *$X cos phi.alt$* by
Cramer's rule to get:
#labelled_equation(
    $ X sin phi.alt = frac(F_0 c omega, (k - m omega^2)^2 + (c omega)^2) $,
    "C",
)
#labelled_equation(
    $
        X cos phi.alt = frac(
            F_0 (k - m omega^2),
            (k - m omega^2)^2 + (c omega)^2
        )
    $,
    "D",
)

Squaring both sides of equations (C) and (D) and adding, we get:
$
    X = frac(F_0, sqrt((k - m omega^2)^2 + (c omega)^2))
    quad "or" quad
    underbrace(frac(X, F_0/k)) =
    frac(
        1,
        sqrt((1 - frac(omega^2, omega_n^2))^2 + (frac(2 zeta omega, omega_n))^2)
    )
$

Dividing equation (C) by equation (D):
$
    phi.alt = arctan frac(c omega, k - m omega^2) quad "or" quad
    phi.alt = arctan frac(
        frac(2 zeta omega, omega_n),
        1 - frac(omega^2, omega_n^2)
    )
$

=== Amplitude response
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $
            M = frac(X, F_0/k) = frac(
                1,
                sqrt(
                    (1 - omega^2/omega_n^2)^2 +
                    (frac(2 zeta omega, omega_n))^2
                )
            )
        $

        The plot of *magnification factor* $(M = frac(X, F_0/k))$ versus
        *frequency ratio* $(omega/omega_n)$ is shown beside.

        Observations from the plot:
        + With zero damping, $M$ tends to infinity at $omega/omega_n = 1$.
            $omega = omega_n$ is called the *resonant frequency*.
        + With non-zero damping, $M$ reaches a finite value $omega/omega_n = 1$.
        + The higher the damping, the lower the value of $M$. THis is true at
            any frequency ratio.
        + At zero excitation frequency $(omega/omega_n = 0)$, $M = 1$.
        + At very high excitation frequencies, $(omega/omega_n >> 1)$, $M$ tends
            to reduce to 0. This is true for any value of damping.
    ],
    image("./images/harmonic-force-excitation-damper-amplitude-response.png"),
)

=== Phase response
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $
            phi.alt = arctan frac(
                frac(2 zeta omega, omega_n),
                1 - omega^2/omega_n^2
            )
        $

        The plot of the phase lag $(phi.alt)$ versus the frequency ratio
        $(omega/omega_n)$ is shown beside.

        Observations from the plot:
        + For zero damping, the phase is zero for $omega/omega_n < 1$ and $pi$
            for $omega/omega_n > 1$. There is a sudden phase change from
            $0 degree$ to $pi$ at $omega = omega_n$.
        + For any non-zero damping $(0 < zeta < 1)$, the phase is $pi/2$ at
            resonant frequency $(omega/omega_n = 1)$.
        + For small values of the frequency ratio $(omega/omega_n -> 0)$, the
            phase is close to zero for any value of damping.
        + For very high values of the frequency ratio $(omega/omega_n -> oo)$,
            the phase tends towards $pi$ for any value of damping.
    ],
    image("./images/harmonic-force-excitation-damper-phase-response.png"),
)

=== Resonant amplitude
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - The amplitude at resonance ($omega = omega_n$) is called the *resonant
            amplitude*, $X_"res"$.
            $
                frac(X, F_0/k) = frac(
                    1,
                    sqrt((1 - omega^2/omega_n^2)^2 + (2 zeta omega/omega_n)^2)
                )
            $

            At $omega = omega_n$,
            $ frac(X_"res", F_0/k) = frac(1, 2 zeta) $

        - Thus, the *magnification factor at resonance* is inversely
            proportional to the damping ratio $zeta$.
        - At resonance, the magnification factor is entirely determined by the
            damping ratio.
        - The amplitude at resonance becomes:
            $ X_"res" = frac((F_0/k), 2 zeta) $
    ],
    image("./images/harmonic-force-excitation-damper-resonant-amplitude.png"),
)

== Rotational systems with harmonic moment excitation
We obtain the rotational systems by comparing with the *translational systems*.
#align(center, pad(x: -3em, table(
    columns: 3,
    align: center + horizon,
    stroke: none,

    table.vline(stroke: red, x: 0),
    table.vline(stroke: red, x: 1),
    table.hline(stroke: red, end: 1),

    table.vline(stroke: red, x: 2),
    table.vline(stroke: red, x: 3),
    table.hline(stroke: red, start: 2),

    [*Translational system*],
    table.cell(rowspan: 6, text(red, $ => $)),
    [*Rotational system*],

    $ m dot.double(x) + c dot(x) + k x = F_0 sin omega t $,
    $
        J_o dot.double(theta) + c_theta dot(theta) + k_theta theta
        = M_0 sin omega t
    $,

    $ x = x_h (t) + x_p (t) $, $ theta = theta_h (t) + theta_p (t) $,

    $ x_p (t) = X sin (omega t - phi.alt) $,
    $ theta_p (t) = Theta sin (omega t - phi.alt) $,

    $
        X = frac(
            F_0/k,
            sqrt((1 - omega^2/omega_n^2)^2 + (frac(2 zeta omega, omega_n))^2)
        )
    $,
    $
        Theta = frac(
            M_0/k_theta,
            sqrt((1 - omega^2/omega_n^2)^2 + (frac(2 zeta omega, omega_n))^2)
        )
    $,

    table.hline(stroke: red, end: 1),
    table.hline(stroke: red, start: 2),

    grid(
        columns: 2,
        column-gutter: 2em,
        row-gutter: 0.5em,
        $ zeta > 1 $, $ x_h (t) = C_1 e^(r_1 t) + C_2 e^(r_2 t) $,
        $ zeta = 1 $, $ x_h (t) = (C_1 + C_2 t) e^(- omega_n t) $,
        $ zeta < 1 $,
        $ x_h (t) = e^(- zeta omega_n t) (A cos omega_d t + B sin omega_d t) $,
    ),

    grid(
        columns: 2,
        column-gutter: 2em,
        row-gutter: 0.5em,

        $ zeta > 1 $, $ theta_h (t) = C_1 e^(r_1 t) + C_2 e^(r_2 t) $,
        $ zeta = 1 $, $ theta_h (t) = (C_1 + C_2 t) e^(- omega_n t) $,
        $ zeta < 1 $,
        $
            theta_h (t)
            = e^(- zeta omega_n t) (A cos omega_d t + B sin omega_d t)
        $,
    ),

    table.hline(stroke: red, end: 1),
    table.hline(stroke: red, start: 2),
)))

== Excitation due to rotating unbalance

=== What is rotating unbalance?
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Consider a uniform disc of mass $m_"disc"$ mounted on a shaft and
            rotating about its axis.
        - If we attach a mass ($m$) at a distance ($e$) from the axis, the
            unbalanced mass ($m$) will cause a centrifugal force as the disc
            rotates.
            $ "Centrifugal force" = m e omega^2 $
            $ "Horizontal component" = m e omega^2 cos omega t $
            $ "Vertical component" = m e omega^2 sin omega t $
        - The *centrifugal force* is a *rotating force*. As it rotates, its
            horizontal and vertical components change harmonically with time.
        - The harmonically varying horizontal and vertical components can excite
            the system and can cause vibration if the structure is flexible.
    ],
    image("./images/rotating-unbalance.png", height: 25em),
)

=== Vertical excitation due to rotating unbalance
- Consider an unbalanced system with vertical guides as shown.
- In this case the *vertical component* ($m e omega^2 sin omega t$) *excites*
    the system.
- The *horizontal component does not excite the system* as the *vertical guides
    prevent horizontal motion*.
- The system can be equivalently looked upon as a spring-mass system excited by
    the vertical component as shown:

    #cimage("./images/rotating-unbalance-vertical-excitation.png")

    Equation of motion:
    $ M dot.double(x) + k x = m e omega^2 sin omega t $

=== Horizontal excitation due to rotating unbalance
- Consider an unbalanced system with horizontal guides as shown.
- In this case the *horizontal component* ($m e omega^2 cos omega t$) *excites*
    the system.
- The *vertical component does not excite the system* as the *horizontal guides
    prevent vertical motion*.
- The system can be equivalently looked upon as a spring-mass system excited by
    the horizontal component as shown:

    #cimage("./images/rotating-unbalance-horizontal-excitation.png")

    Equation of motion:
    $ M dot.double(x) + k x = m e omega^2 cos omega t $

=== Spring-mass system with rotating unbalance
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - $M$ is the total mass inclusive of $m$.
        - Equation of motion:
            $ M dot.double(x) = sum F $
            $ M dot.double(x) = m e omega^2 sin omega t - k x $
            $ M dot.double(x) + k x = m e omega^2 sin omega t $

        - Steady state solution:
            $ x_p = X sin (omega t - phi.alt) $

        - Substituting the steady state solution into the equation of motion, we
            get:

            - Amplitude:
                $
                    X = frac(m e omega^2, k - M omega^2)
                    quad "or" quad
                    underbrace(frac(M X, m e), "Magnification factor")
                    = frac((omega/omega_n)^2, 1 - (omega/omega_n)^2)
                $

            - Phase:
                $ phi.alt = 0 $
    ],
    image("./images/rotating-unbalance-spring-mass-system.png", height: 30em),
)

==== Plot of the steady-state response due to rotating unbalance
$
    "Magnification factor" = frac(M X, m e)
    = frac((omega/omega_n)^2, 1 - (omega/omega_n)^2)
$
$ "Phase:" phi.alt = 0 $

#cimage("./images/rotating-unbalance-plot.png", width: 75%)

==== Alternative plot of the steady-state response
$
    "Magnification factor" = frac(M X, m e)
    = frac((omega/omega_n)^2, lr(|1 - (omega/omega_n)^2|))
$
$
    "Phase:" phi.alt & = 0, quad omega/omega_n < 1 \
             phi.alt & = pi, omega/omega_n > 1
$

#cimage("./images/rotating-unbalance-alternative-plot.png", width: 75%)

=== Spring-mass-damper system with rotating unbalance
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - $M$ is the total mass inclusive of $m$.
        - Equation of motion:
            $ M dot.double(x) = sum F_x $
            $ M dot.double(x) = m e omega^2 sin omega t - k x - c dot(x) $
            $ M dot.double(x) + c dot(x) + k x = m e omega^2 sin omega t $

        - Steady state solution:
            $ x_p = X sin (omega t - phi.alt) $
        - Substituting the steady state solution into the equation of motion, we
            get:

            - Amplitude:
                $ X = frac(m e omega^2, sqrt((k - M omega^2)^2 + (c omega)^2)) $

            - Phase:
                $ phi.alt = arctan frac(c omega, k - M omega^2) $
    ],
    image("./images/rotating-unbalance-spring-mass-damper-system.png"),
)

- In non-dimensional form, the amplitude and phase can be written as:
    #grid(
        columns: 2,
        column-gutter: 5em,
        row-gutter: 0.5em,
        align: center + horizon,

        grid.header([*Magnification factor*], [*Phase*]),

        $
            frac(M X, m e) = frac(
                (omega/omega_n)^2,
                sqrt(
                    (1 - omega^2/omega_n^2)^2 +
                    (frac(2 zeta omega, omega_n))^2
                )
            )
        $,

        $
            phi.alt = arctan frac(
                frac(2 zeta omega, omega_n),
                1 - omega^2/omega_n^2
            )
        $,
    )

#cimage("./images/rotating-unbalance-spring-mass-damper-system-plots.png")

=== Rotating unbalance due to a hole drilled out
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Assume *a hole is drilled out* of a uniform disc of mass $m_"disc"$ at
            radius $e$. Let the mass lost be $m$.
        - A mass $m$ drilled out at a radius $e$ creates an *apparent unbalanced
            mass $m$ at the diametrically opposite side* at the same radius $e$.
            Hence:
            $ "Centrifugal force" = m e omega^2 $
            $ "Horizontal component" = m e omega^2 cos omega t $
            $ "Vertical component" = m e omega^2 sin omega t $
        - If the disc is support on a spring and guided to move in the vertical
            or horizontal direction, then the equation of motions will be:
            $ M = m_"disc" - m $
            $
                M dot.double(x) + k x = m e omega^2 sin omega t \
                "or" \
                M dot.double(x) + k x = m e omega^2 sin omega t
            $
    ],
    image(
        "./images/rotating-unbalance-due-to-hole-drilled-out.png",
        height: 30em,
    ),
)

== Harmonic base excitation

=== 2 examples of base excitation
#cimage("./images/base-excitation-examples.png")

=== Spring-mass system with base excitation
#cimage("./images/base-excitation-spring-mass-system.png")

$ m dot.double(x) = sum F_x quad => m dot.double(x) = - k (x - y) $
$ m dot.double(x) + k x = k y $

Where:
$ y = Y sin omega t $

Equation of motion:
$ m dot.double(x) + k x = underbrace(k Y sin omega t, "Excitation term") $

The excitation term is of the form:
$ F_0 sin omega t $

Where:
$ F_0 equiv k Y $

- Thus, a harmonic base excitation problem can be equivalently viewed as a
    harmonic force excitation problem with $F_0$ replaced by $k Y$.
- So, the solution to a harmonic base excitation problem can simply by obtained
    by substituting $F_0 = k Y$ in all the expressions and equations that have
    been derived for the harmonic force excitation problem.

#pagebreak()

=== Spring-mass-damper system with base excitation
#cimage("./images/base-excitation-spring-mass-damper-system.png")

$ m dot.double(x) = sum F_x $
$ m dot.double(x) = - k (x - y) - c (dot(x) - dot(y)) $
$
    m dot.double(x) + c dot(x) + k x & = k overbrace(y, y = Y sin omega t)
    + c overbrace(dot(y), omega Y cos omega t) \
    & = k Y sin omega t
    + c omega Y cos omega t \
    &= sqrt((k Y)^2 + (c omega Y)^2) sin (omega t + alpha)
    wide "where" alpha = arctan (frac(c omega, k)) \
    &= Y sqrt(k^2 + (c omega)^2) sin (omega t + alpha) \
$

Hence, the equation of motion is:
$
    m dot.double(x) + c dot(x) + k x = F_"eq" sin (omega t + alpha)
    quad "where" quad F_"eq" equiv Y sqrt(k^2 + (c omega)^2)
$

Steady-state solution:
$ x = X sin (omega t + alpha - phi.alt) $
$ X = frac(F_"eq", sqrt((k - m omega^2)^2 + (c omega)^2)) $

Substitute for $F_"eq"$:
#grid(
    columns: 3,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,

    $
        X = frac(
            Y sqrt(k^2 + (c omega)^2),
            sqrt((k - m omega^2)^2 + (c omega)^2)
        )
    $,
    "OR",
    $
        overbrace(X/Y, "Displacement transmissibility") = frac(
            sqrt(1 + (frac(2 zeta omega, omega_n))^2),
            sqrt((1 - omega^2/omega_n^2)^2 + (frac(2 zeta omega, omega_n))^2)
        )
    $,

    $
        phi.alt = arctan frac(c omega, k - m omega^2)
    $,
    "OR",
    $
        phi.alt = arctan frac(
            frac(2 zeta omega, omega_n),
            1 - omega^2/omega_n^2
        )
    $,
)

- *Displacement transmissibility* gives a *measure of what fraction of the base
    motion is transmitted to the mass*.
- In a car, this gives the vibration of the car body and the occupants as a
    fraction of the vibration of road wheels.

==== Plot of displacement transmissibility
$
    X/Y = frac(
        sqrt(1 + (frac(2 zeta omega, omega_n))^2),
        sqrt((1 - omega^2/omega_n^2) + (frac(2 zeta omega, omega_n))^2)
    )
$
#cimage("./images/displacement-transmissibility-plot.png")

- In the region $omega/omega_n > sqrt(2)$, we find $X/Y < 1$ for any damping
    value.

    So, to reduce transmissibility, we must ensure $omega > sqrt(2) omega_n$.

- In the region $omega/omega_n > sqrt(2)$, we find that when there is less
    damping, there is less transmissibility.

    So, to reduce transmissibility in the region $omega > sqrt(2) omega_n$,
    reduce damping.

=== Example
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - A car weighing #qty[1007][kg] travels at a speed of #qty[40][km h^-1]
            on a wavy road with sinusoidal profile having peaks of height
            #qty[0.01][m] spaced #qty[6][m] apart. Assuming that the car has a
            suspension system with #qty[400][kN m^-1] stiffness and #qty[10][kN
                s m^-1] damping constant.
        - Calculate:
            #[
                #set enum(numbering: "a)")
                + Base excitation frequency.
                + Displacement transmissibility ($X/Y$) at the given speed.
                + Resonant speed of the car.
            ]
    ],
    image("./images/base-excitation-worked-example.png"),
)

==== a) Base excitation frequency
The base excitation frequency is given by:
$ omega = 2 pi V/L = 2 pi frac(40/3.6, 6) = #qty[11.64][rad s^-1] $

==== b) Displacement transmissibility
The displacement transmissibility is given by:
$
    X/Y & = frac(
              sqrt(k^2 + (c omega)^2),
              sqrt((k - m omega^2)^2 + (c omega)^2)
          ) \
        & = frac(
              sqrt((400 times 10^3)^2 + (10 times 10^3 times 11.64)^2),
              sqrt(
                  (400 times 10^3 - 1007 times 11.64^2)^2
                  + (10 times 10^3 times 11.64)^2
              )
          ) \
        & = 1.45
$

==== c) Resonant speed of the car
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $
            omega = omega_n = sqrt(k/m)
            = sqrt(frac(400 times 10^3, 1007)) = #qty[19.93][rad s^-1]
        $
        $ omega = 2 pi V/L $
        $ 19.93 = 2 pi V/6 $
        $
            V = frac(19.93 times 6, 2 pi)
            = #qty[19.03][m s^-1] = #qty[68.5][km h^-1]
        $
    ],
    image("./images/base-excitation-worked-example-car-speed.png"),
)

== Summary
For the equations below:
$ macron(omega) = omega/omega_n $

+ Harmonic excitation, $F_0 sin omega t$:
    $
        "Magnification ratio:" frac(X, F_0/k) = frac(
            1,
            sqrt((1 - macron(omega)^2)^2 + (2 zeta macron(omega))^2)
        )
    $
+ Rotating unbalance, $m e omega^2$:
    $
        "Magnification ratio:" frac(M X, m e) = frac(
            macron(omega)^2,
            sqrt((1 - macron(omega)^2)^2 + (2 zeta macron(omega))^2)
        )
    $
+ Base excitation, $m e omega^2$:
    $
        "Displacement transmissibility:" frac(X, Y) = frac(
            sqrt(1 + (2 zeta macron(omega))^2),
            sqrt((1 - macron(omega)^2)^2 + (2 zeta macron(omega))^2)
        )
    $

#pagebreak()

= Force transmission and vibration isolation in 1-DOF systems

== What is force transmission and vibration isolation?
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - ALl rotation machines generate unbalanced forces, however small they
            may be. These forces get transmitted to the supporting structure and
            the floor.
        - These transmitted forces may cause severe vibration to the supporting
            structure or floor.
        - *Vibration isolation* is a process by which the force transmission is
            reduced.
        - Basically, it involves inserting a resilient member, like a spring or
            rubber pad, between the vibrating machine and supporting structure
            or floor so that force transmission is reduced.
        - In mobile phones, however, the transmitted force of the vibration
            motor causes desirable vibrations that helps to alert the user of
            incoming calls.
    ],
    image(
        "./images/force-transmission-and-vibration-isolation.png",
        height: 25em,
    ),
)

== Force transmission to the base

=== Machine mounted directly on the floor
#cimage("./images/force-transmission-floor.png")

Note that it is the *dynamic force* that can be reduced by mounting the machine
on a *resilient member*, not the static force.

#grid(
    columns: 2,
    column-gutter: 1.5em,
    align: horizon,

    $
        cases(
            #text[Amplitude of dynamic force *transmitted*] = F_0,
            #text[Amplitude of dynamic force *applied*] = F_0,
            reverse: #true,
        )
    $,
    [
        No vibration isolation as the dynamic force applied is fully transmitted
        to the floor.
    ],
)

Thus, if the machine is *directly mounted on the floor*, all the applied force
is *fully transmitted* to the floor and there is *no vibration isolation*.

=== Machine mounted on a resilient member without damping
#cimage("./images/force-transmission-resilient-member-no-damping.png")

Dynamic force transmitted:
$ f_T = k x, wide x = X sin (omega t - phi.alt) $
$ therefore f_T = k X sin (omega t - phi.alt) equiv F_t sin (omega t- phi.alt) $

Amplitude of dynamic force *transmitted*:
$ F_T equiv k X $

Amplitude of dynamic force *applied* is $F_0$.

Force transmission ratio:
$
    "TR" = lr(|F_T/F_0|) = lr(|frac(k X, F_0)|)
$

Substituting $X = frac(F_0, k - m omega^2)$:
$
    "TR" = k/F_0 frac(F_0, lr(|k - m omega^2|))
    = frac(k, lr(|k - m omega^2|))
    = frac(1, lr(|1 - (omega/omega_n)^2|))
$

=== Machine mounted on a resilient member with damping
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Dynamic force transmitted:
        $ f_T = k x + c dot(x) $

        Where:
        $ x = X sin (omega t - phi.alt) $
        $ dot(x) = omega X cos (omega t - phi.alt) $

        $
            therefore f_T & = k X sin (omega t- phi.alt)
                            + c omega X cos (omega t - phi.alt) \
                          & = underbrace(sqrt((k X)^2 + (c omega X)^2), F_t)
                            sin (omega t - phi.alt + alpha)
        $

        Where:
        $ alpha = arctan frac(c omega, k) $
    ],
    image("./images/force-transmission-resilient-member-damping.png"),
)

Amplitude of the dynamic force *transmitted*:
$ F_t = X sqrt(k^2 + (c omega)^2) $

Amplitude of the dynamic force *applied* is $F_0$.

Force transmission ratio:
$ "TR" = F_T/F_0 = frac(X sqrt(k^2 + (c omega)^2), F_0) $

Substituting $X = frac(F_0, sqrt((k - m omega^2)^2 + (c omega)^2))$:
$ "TR" = frac(sqrt(k^2 + (c omega)^2), sqrt((k - m omega^2)^2 + (c omega)^2)) $

#pagebreak()

=== Plot of the force transmission ratio (TR)
$
    "TR" = F_T/F_0
    = frac(sqrt(k^2 + (c omega)^2), sqrt((k - m omega^2)^2 + (c omega)^2))
    = frac(
        sqrt(1 + (frac(2 zeta omega, omega_n))^2),
        sqrt((1 - omega^2/omega_n^2)^2 + (frac(2 zeta omega, omega_n))^2)
    )
$

#cimage("./images/force-transmission-ratio-plot.png")

Important observations:
- In the region $omega/omega_n > sqrt(2)$, we find $F_T/F_0 < 1$ for any damping
    value.

    So, *to reduce* $F_T/F_0$, or the transmitted force, *ensure*
    $omega > sqrt(2) omega_n$.

- In the region $omega/omega_n > sqrt(2)$, we find $F_T/F_0 < 1$ for any damping
    value.

    So, *to reduce* $F_T/F_0$ in the region $omega > sqrt(2) omega_n$, *reduce
    damping*.

#pagebreak()

== Practical vibration isolation tips
To reduce the transmitted force, we must:
#[
    #set enum(numbering: "(i)")
    + Ensure $omega > sqrt(2) omega_n$
    + Reduce damping
]

=== (i) To ensure $omega > sqrt(2) omega_n$
- Increase $omega$, if $omega_n$ is fixed.
- Decrease $omega$, if $omega$ is fixed.

    $ omega_n = sqrt(k/m) $

    This can be achieved by:
    - Decreasing $k$, by using a softer spring or rubber pad
    - Increasing $m$, by mounting the machine on a heavy block of mass $M$ so
        that the new mass is $M + m$, then support the block on soft springs or
        rubber pads, as shown below.

        #cimage("./images/practical-vibration-isolation-tips-1.png")

#pagebreak()

=== (ii) To reduce damping
Use materials for springs and rubber pads that have the *least damping*.
#cimage("./images/practical-vibration-isolation-tips-2.png")
#pagebreak()

== Example: Vibration isolation
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        An electric motor has a mass of #qty[10][kg] and is set on four
        identical springs, each with a stiffness of #qty[1.6][N mm^-1]. The mass
        M.I of the motor assembly is #qty[0.1][kg m^2] =. If the operating speed
        of the motor is #qty[1750][rpm], determine the transmission ratio for
        vertical vibration and torsional vibration.
    ],
    image("./images/vibration-isolation-example.png", height: 14em),
)

There are two types of vibrations:
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,

    grid.header([*Vertical vibration*], [*Torsional vibration*]),

    image("./images/vibration-isolation-example-vertical-vibration.png"),
    image("./images/vibration-isolation-example-torsional-vibration.png"),

    $
        m dot.double(x) = sum F_x \
        m dot.double(x) = F_o sin omega t - 4 k x
    $,
    $
        J_o dot.double(theta) = sum M_o \
        J_o dot.double(theta) = M_o sin omega t - 2 dot (2 k dot r theta) dot r
    $,
)

$ m = #qty[10][kg] $
$ k = #qty[1.6][N mm^-1] = 1.6 times 10^3 #unit[N m^-1] $
$
    omega = #qty[1750][rpm] = 1750/60 times 2 pi #unit[rad s^-1]
    = #qty[183.17][rad s^-1]
$
$ J_o = #qty[0.1][kg m^2] $

=== Vertical vibration
Equation of motion:
$ m dot.double(x) + 4 k x = F_o sin omega t $

Natural frequency of vertical vibration:
$ omega_n = sqrt(frac(4k, m)) = #qty[25.3][rad s^-1] $

Transmission ratio:
$ "TR" = lr(|F_T/F_o|) = frac(1, lr(|1 - (omega/omega_n)^2|)) = 0.0194 $

=== Torsional vibration
Equation of motion:
$ J_o dot.double(theta) + 4 k r^2 theta = M_o sin omega t $

Natural frequency of torsional vibration:
$ omega_n = sqrt(frac(4 k r^2, J_o)) = #qty[31.6][rad s^-1] $

Transmission ratio:
$ "TR" = lr(|M_T/M_o|) = frac(1, lr(|1 - (omega/omega_n)^2|)) = 0.0031 $

Where $M_T$ is the transmitted moment.

#pagebreak()

= Transient vibration of 1-DOF systems
- A temporary component of motion is called *transient vibration*.
- Transient vibrations may be caused in two ways.

== Transient vibrations due to sudden loading
#cimage("./images/transient-vibrations-sudden-loading-types.png")

A typical response due to step loading is shown below:
#cimage("./images/transient-vibrations-sudden-step-loading.png")

== Transient vibrations due to initial conditions
- This is the *free vibration response* caused by initial displacement and
    initial velocity.
- For undamped vibrations:

    Equation of motion:
    $ m dot.double(x) + k x = F_0 sin omega t $

    Response:
    $
        x & = x_h (t) + x_p (t) \
          & = underbrace(
                A cos omega_n t + B sin omega_n t,
                #text(red)[Transient response]
            )
            + underbrace(
                X sin (omega t - phi.alt),
                #text(blue)[Steady-state response]
            )
    $
- For damped vibrations:

    Equation of motion:
    $ m dot.double(x) + c dot(x) + k x = F_0 sin omega t $

    Response:
    $
        x & = x_h (t) + x_p (t) \
          & = underbrace(
                e^(- zeta omega_n t) A cos omega_d t + B sin omega_d t,
                #text(red)[Transient response]
            )
            + underbrace(
                X sin (omega t - phi.alt),
                #text(blue)[Steady-state response]
            )
    $

== Examples

=== Horizontal spring-mass system under step loading
<horizontal-spring-mass-system-under-step-loading>
#cimage("./images/horizontal-spring-mass-system-under-step-loading.png")

Equation of motion:
$ m dot.double(x) + k x = F(t) $

Where:
$
    F(t) = cases(
        0 "for" (t < 0),
        F_0 "for" (t >= 0)
    )
$

We are interested in $t >= 0$. So, the equation of motion we need to solve is:
$ m dot.double(x) + k x = F(t) wide t >= 0 $

General solution:
#labelled_equation($ x = A cos omega_n t + B sin omega_n t + F_0/k $, 1)

Once can determine $A$ and $B$ using the initial conditions:
$ x(0) = 0, quad dot(x) (0) = 0 $

Thus, equation (1) gives the response due to step loading as:
$ x = F_0/k (1 - cos omega_n t) $

Plotting the response:
#cimage(
    "./images/spring-mass-system-under-step-loading-graph.png",
    height: 18em,
)

#pagebreak()

=== Vertical spring-mass system under step loading
#cimage("./images/vertical-spring-mass-system-under-step-loading.png")

- Assume that, in both of the above examples, the *displacement* is measured
    from the *static equilibrium position* (#text(red)[SEP]).
- In such a case, the equation of motion and the derivation of the transient
    response will be exactly the same as that for #link(
        <horizontal-spring-mass-system-under-step-loading>,
    )[horizontal spring-mass system].
- Equation of motion:
    $ x = F_0/k (1 - cos omega_n t) $
- Plot of the response:
    #cimage("./images/spring-mass-system-under-step-loading-graph.png")

=== Vertical spring-mass system under suddenly applied weight
#cimage("./images/vertical-spring-mass-system-sudden-weight.png")

- Assume that, in both cases, the mass initially supported by the hand at the
    free length of the spring, and released suddenly at time $t = 0$.
- In both cases, as the mass is released, the weight is *suddenly applied*. This
    leads to a step loading.
    $
        F(t) = cases(
            0 "for" t < 0,
            m g "for" t >= 0
        )
    $
- We can get the transient response as follows:

    The equation of motion is:
    $ m dot.double(x) + k x = F(t) $

    Where:
    $
        F(t) = cases(
            0 "for" t < 0,
            m g "for" t >= 0
        )
    $

    We are interested in $t >= 0$, so the equation of motion we need to solve
    is:
    $ m dot.double(x) + k x = m g wide t >= 0 $

    General solution:
    $ A cos omega_n t + B sin omega_n t + frac(m g, k) $

    Constants $A$ and $B$ are determined using initial conditions:
    $ x (0) = 0, quad dot(x) (0) = 0 $

    Thus, the response due to step loading becomes:
    $ x = frac(m g, k) (1 - cos omega_n t) $

#pagebreak()

==== Plot
Plotting the response:
#cimage("./images/vertical-spring-mass-system-sudden-weight-graph.png")

- From the plot shown, we observe that the maximum spring deflection due to the
    suddenly applied weight is $frac(2 m g, k)$.
- Thus, the *maximum dynamic deflection* is *twice the static deflection*
    ($frac(m g, k)$) that would result with gradually applied weight.

== Drop test
- Considerations such as how high a body can be dropped without incurring
    damages are important in problems such as *a plane landing* or the
    *cushioning of packaged articles*.
    #cimage("./images/drop-test-examples.png")
- Often, the object under test is dropped from a height $h$ and the *maximum
    deceleration* that the object can withstand is of interest.
- For drop test studies, the system is often modelled as a spring-mass assembly
    dropped from a height $h$.

=== Modelling drop test without damping
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Consider a spring-mass system dropped from a height $h$.
        - The velocity of the mass when the spring contacts the ground is:
            $ 1/2 m v_0^2 = m g h quad => quad v_0 = sqrt(2 g h) $
        - The displacement $x$ and time $t$ are measured from the instant when
            the spring first contacts the floor.
        - The differential equation of motion (EOM) for the mass $m$ shown below
            applies as long as the spring remains in contact with the floor.
            $ m dot.double(x) + k x = m g wide t >= 0 $
        - Initial conditions, which is when the spring touches the floor, are:
            $ x(0) = 0 "and" dot(x) (0) = v_0 = sqrt(2 g h) $

            The above can be used to determine the constants $A$ and $B$ in the
            general solution:
            $ x(t) = A cos omega_n t + B sin omega_n t + frac(m g, k) $
        - Displacement initial condition yields:
            $
                x(0) = 0 quad => quad 0 = A + frac(m g, k)
                quad => quad A = - frac(m g, k)
            $
        - Differentiating $x(t)$ with respect to time:
            $ dot(x) (t) = - omega_n A sin omega_n t + omega_n B cos omega_n t $
        - Velocity initial conditions yields:
            $
                dot(x) (0) = v_0 quad => quad v_0 = omega_n B
                quad => quad B = v_0/omega_n
            $
        - Hence, the general solution becomes:
            $
                x(t) = - frac(m g, k) cos omega_n t
                + frac(v_0, omega_n) sin omega_n t + frac(m g, k)
            $
    ],
    image("./images/drop-test-without-damping.png"),
)

#pagebreak()

- The sine and cosine terms can be combined into a sinusoidal term:
    #labelled_equation(
        $
            x(t) = sqrt(
                (frac(m g, k))^2 + (v_0/omega_n)^2
            ) sin (omega_n t + phi.alt) + frac(m g, k)
        $,
        4,
    )

    Where:
    $ phi.alt = arctan frac(- frac(m g, k), v_0/omega_n) $

- Velocity is obtained by differentiating equation (4) with respect to time:
    #labelled_equation(
        $
            dot(x) (t) = omega_n sqrt((frac(m g, k)^2) + (v_0/omega_n)^2)
            cos (omega_n t + phi.alt)
        $,
        5,
    )
- Acceleration is obtained by differentiating equation (5) with respect to time:
    $
        dot.double(x) (t) = - omega_n^2 sqrt(
            (frac(m g, k))^2 + (v_0/omega_n)^2
        ) sin (omega_n t + phi.alt)
    $
- Maximum acceleration is given by the amplitude:
    $ v_0 = sqrt(2 g h) wide k/m = omega_n^2 $
    $
        dot.double(x)_"max" &= - omega_n^2 sqrt(
            (frac(m g, k))^2 + (v_0/omega_n)^2
        ) \
        &= - omega_n^2 sqrt((g/omega_n^2)^2 + (v_0/omega_n)^2) \
        &= - omega_n^2 sqrt((g/omega_n^2)^2 + frac(2 g h, omega_n^2)) \
        &= - omega_n^2 (g/omega_n^2) sqrt(1 + frac(2 h, g/omega_n^2)) \
        &= - g sqrt(1 + frac(2 h, Delta_"st")) quad
        because g/omega_n^2 = frac(m g, k) = Delta_"st"
    $
    #labelled_equation(
        $ - frac(dot.double(x)_"max", g) = sqrt(1 + frac(2 h, Delta_"st")) $,
        6,
    )
- Equation (6) gives the magnitude of *maximum deceleration* experienced by the
    mass (normalised with respect to gravitation acceleration $g$).
    #cimage("./images/drop-test-without-damping-graph.png")
- The plot above shows that the maximum deceleration experienced during the
    drop-test increases with the height of the drop.

=== Modelling drop test with damping
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $ dot.double(x) + c dot(x) + k x = m g wide t >= 0 $
        - The *transient response* depends on the *value of $zeta$*:
            #grid(
                columns: 2,
                column-gutter: 2em,
                row-gutter: 1em,
                $ zeta > 1 $,
                $
                    x(t) = underline(C_1 e^(r_1 t) + C_2 e^(r_2 t))
                    + frac(m g, k)
                $,

                $ zeta = 1 $,
                $
                    x(t) = underline((C_1 + C_2 t) e^(- omega_n t))
                    + frac(m g, k)
                $,

                $ zeta > 1 $,
                $
                    x(t) & = underline(
                        e^(- zeta omega_n t)
                        (A cos omega_d t + B sin omega_d t)
                    ) + frac(m g, k) \
                    & = underline(
                        X e^(- zeta omega_n t) sin (omega_d t + phi.alt)
                    ) + frac(m g, k)
                $,
            )

        - Initial conditions:
            $ x(0) = 0 "and" dot(x) (0) = v_0 = sqrt(2 g h) $
        - Use the initial conditions to determine the constants $(A, B)$ or
            $(C_1, C_2)$ or $(X, phi.alt)$ as the case may be.
    ],
    image("./images/drop-test-with-damping.png", width: 15em),
)

#pagebreak()

= Free vibration of 2-DOF systems
A 1-DOF system requires only *one independent coordinate* to describe its motion
completely, while a 2-DOF system requires *2 independent coordinates*.
#cimage("./images/1-dof-vs-2-dof-systems.png")

== Mode shape
- A 1-DOF system has only one natural frequency ($omega_n$), while a 2-DOF has
    *2 natural frequencies* ($omega_1, omega_2$).
- A $n$-DOF system has $n$ natural frequencies.
- For each natural frequency, there is an associated vibration configuration of
    the system referred to as a *"mode shape"*.
- Mode shape is an important concept associated with systems with multiple
    degrees of freedom (DOF > 1).

#cimage("./images/mode-shape.png")
#pagebreak()

=== Mode shapes for continuous systems
- A continuous system has an *infinite number of natural frequencies* and a
    corresponding *infinite number of mode shapes*.
- Only the first 3 mode shapes are shown below for illustration:
    #cimage("./images/mode-shape-for-continuous-systems.png")

#pagebreak()

== Determination of natural frequencies and mode shapes of 2-DOF systems

=== Horizontal spring-mass system
<2-dof-systems-horizontal>
#cimage("./images/2-dof-systems-horizontal.png")
- While drawing free body diagrams for the masses, it is convenient to assume
    that $x_1 > x_2$ for mass $m_1$, and $x_2 > x_1$ for mass $m_2$.

==== Equations of motion
#grid(
    columns: 2,
    column-gutter: 2em,
    inset: 0.5em,

    grid.vline(x: 1),

    figure(
        image("./images/2-dof-systems-horizontal-mass-1.png"),
        caption: [Free body diagram of mass 1],
    ),
    figure(
        image("./images/2-dof-systems-horizontal-mass-2.png"),
        caption: [Free body diagram of mass 2],
    ),

    [
        Newton's second law:
        $
            overbrace(m dot.double(x), stretch(->)^+)
            = sum overbrace(F_x, stretch(->)^+)
        $
        $ m_1 dot.double(x)_1 = - k_1 (x_1 - 0) - k_2 (x_1 - x_2) $

        Equation of motion of mass 1:
        #labelled_equation(
            $ m_1 dot.double(x)_1 + (k_1 + k_2) x_1 - k_2 x_2 = 0 $,
            1,
        )
    ],
    [
        Newton's second law:
        $
            overbrace(m dot.double(x), stretch(->)^+)
            = sum overbrace(F_x, stretch(->)^+)
        $
        $ m_2 dot.double(x)_2 = - k_2 (x_2 - x_1) - k_3 (x_2 - 0) $

        Equation of motion of mass 2:
        #labelled_equation(
            $ m_2 dot.double(x)_2 - k_2 x_1 + (k_2 + k_3) x_2 = 0 $,
            2,
        )
    ],
)

#pagebreak()

==== Natural frequencies
<2-dof-systems-horizontal-natural-frequencies>
- Equations of motions from the previous slide:
    #labelled_equation(
        $ m_1 dot.double(x)_1 + (k_1 + k_2) x_1 - k_2 x_2 = 0 $,
        1,
    )

    #labelled_equation(
        $ m_2 dot.double(x)_2 - k_2 x_1 + (k_2 + k_3) x_2 = 0 $,
        2,
    )

- Equation of motions in matrix form:
    #labelled_equation(
        $
            underbrace(bmat(m_1, 0; 0, m_2), "Mass matrix")
            underbrace(
                cvec(dot.double(x)_1, dot.double(x)_2),
                "Acceleration vector"
            )
            + underbrace(
                bmat(k_1 + k_2, -k_2; -k_2, k_2 + k_3),
                "Stiffness matrix"
            )
            underbrace(cvec(x_1, x_2), "Displacement vector")
            = underbrace(cvec(0, 0), "Force vector")
        $,
        3,
    )
- For simplicity, we take:
    $ m_1 = m_2 = m, quad k_1 = k_2 = k_3 = k $
- Hence, the equation of motion becomes:
    #labelled_equation(
        $
            bmat(m, 0; 0, m)
            cvec(dot.double(x)_1, dot.double(x)_2)
            + bmat(2k, -k; -k, 2k)
            cvec(x_1, x_2)
            = cvec(0, 0)
        $,
        4,
    )
- These differential equations have constant coefficients, and hence have
    harmonic solutions of the form:
    $
        x_1 = X_1 sin omega t quad => quad
        dot.double(x)_1 = - omega^2 X_1 sin omega t
    $
    $
        x_2 = X_2 sin omega t quad => quad
        dot.double(x)_2 = - omega^2 X_2 sin omega t
    $
- Substituting this into equation (4):
    $
        - omega^2 bmat(m, 0; 0, m) cvec(X_1, X_2) redcancel(sin omega t)
        + bmat(2k, -k; -k, 2k) cvec(X_1, X_2) redcancel(sin omega t)
        = cvec(0, 0)
    $
- Cancelling out $sin omega t$:
    $
        - omega^2 bmat(m, 0; 0, m) cvec(X_1, X_2)
        + bmat(2k, -k; -k, 2k) cvec(X_1, X_2) = cvec(0, 0)
    $
- The above can be written as:
    #labelled_equation(
        $
            bmat(2 k - m omega^2, -k; -k, 2k - m omega^2) cvec(X_1, X_2)
            = cvec(0, 0)
        $,
        5,
    )
- For a non-trivial solution, the *determinant of the system matrix must be
    zero*:
    $ det bmat(2k - m omega^2, -k; -k, 2k - m omega^2) = 0 $
- This gives the *characteristic equation*:
    $
           & det bmat(2k - m omega^2, -k; -k, 2k - m omega^2) = 0 \
        => & omega^4 - (4 k/m) omega^2 + 3 (k/m)^2 = 0
    $

#pagebreak()

- The roots of the characteristic equation gives the *natural frequencies
    (#unit[rad s^-1])*:
    $ (omega^2)^2 - (4 k/m) omega^2 + 3 (k/m)^2 = 0 $
- This is a quadratic equation in $omega^2$, so we solve for $omega^2$:
    $
        omega^2 = frac(
            - (- 4 k/m) plus.minus sqrt((- 4 k/m)^2 - 4 times 3 (k/m)^2),
            2
        )
    $
    $ omega^2 = frac(3 k, m) "or" k/m $
    $
        omega = plus.minus sqrt(frac(3k, m)) "or" sqrt(k/m)
        quad "(Ignore negative values)"
    $
- Hence, the *two natural frequencies* are:
    $ "1st natural frequency:" omega_1 = sqrt(k/m) $
    $ "2nd natural frequency:" omega_2 = sqrt(frac(3k, m)) $

#pagebreak()

==== Mode shapes
- Associated with each natural frequency is a mode shape which characterises the
    relative motion of the two masses in that mode.
- To determine mode shape, either of the two equations in (5) can be used:
    #labelled_equation(
        $
            bmat(2 k - m omega^2, -k; -k, 2k - m omega^2) cvec(X_1, X_2)
            = cvec(0, 0)
        $,
        5,
    )
- From the first equation, we determine the *amplitude ratio*:
    $ (2k - m omega^2) X_1 - k X_2 = 0 $
    $ X_1/X_2 = frac(k, 2k - m omega^2) $
- For the *1st mode*, $omega = omega_1 = sqrt(k/m)$. The *amplitude ratio*
    becomes:
    $
        (X_1/X_2)^((1)) = frac(k, 2k - m omega^2) = frac(k, 2k - m omega_1^2)
        = frac(k, 2k - m dot (k/m)) = 1
    $
- For the *2nd mode*, $omega = omega_2 = sqrt(frac(3k, m))$. The *amplitude
    ratio* becomes:
    $
        (X_1/X_2)^((1)) = frac(k, 2k - m omega^2) = frac(k, 2k - m omega_2^2)
        = frac(k, 2k - m dot (frac(3k, m))) = -1
    $
- Amplitude ratios:
    #grid(
        columns: 2,
        column-gutter: 5em,
        row-gutter: 1em,
        align: center + horizon,

        grid.header([*First mode*], [*Second mode*]),

        $ (X_1/X_2)^((1)) = frac(k, 2k - omega_1^2 m) = 1.0 $,
        $ (X_1/X_2)^((2)) = frac(k, 2k - omega_2^2 m) = -1.0 $,
    )
- Using the second equation in (5) instead of the first will yield the same
    amplitude ratios as above.
- Mode shape vector:

    Letting $X_2 = 1$, we calculate $X_1$ from the amplitude ratios, and arrange
    these values of $X_1$ and $X_2$ in vector form as shown below.

    The resulting vectors are called the *mode shape vectors*:
    $
        {phi.alt}_1 = cvec(X_1, X_2)^((1)) = cvec(1.0, 1.0)
        quad "(1st mode shape vector)"
    $
    $
        {phi.alt}_2 = cvec(X_1, X_2)^((2)) = cvec(-1.0, 1.0)
        quad "(2nd mode shape vector)"
    $

==== Mode shape plot
#cimage("./images/2-dof-systems-horizontal-mode-shape-plot.png")

=== Vertical spring-mass system
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Assume that the displacements $x_1$ and $x_2$ are measured from the
            respective static equilibrium positions (*SEP*) of masses.
        - In such a case, the equations of motions, the natural frequencies, and
            the mode shapes will all be exactly the same as that for the #link(
                <2-dof-systems-horizontal>,
            )[horizontal spring-mass system].
        - This suggests that the static deflections of masses have no effect on
            the natural frequencies and mode shapes.
    ],
    image("./images/2-dof-systems-vertical.png"),
)

=== Rotational-translational system
The figure below shows a 2-DOF system with $m = #qty[10][kg], k = #qty[20][kN
    m^-1]$ and $a = 0.2m$. The pendulum rod is assumed to be rigid and
weightless. Derive the equations of motion and thereby determine the natural
frequencies and mode shapes of the system.

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        *Note*:
        - The motion of the block is described using the coordinate $x$.
        - The motion of the rod is described using the coordinate $theta$.
        - Hence, this example involves a mix of linear and angular coordinates.
    ],
    image("./images/2-dof-systems-rotational-translational.png"),
)

==== Equations of motion
#grid(
    columns: 2,
    column-gutter: 1em,
    [
        - Assume $x > 2 a theta$.
        - The lower spring will be compressed by $(x - 2 a theta)$, and the
            upper spring by $theta a$.
        - Hence, the spring forces are $k (x - 2 a theta)$ and $k a theta$, the
            directions of which are shown in the figure beside.
        - *Equation of motion of the block*:
            $ m dot.double(x) = sum F_x $
            $ m dot.double(x) = - k (x - 2 a theta) $
            #labelled_equation($ m dot.double(x) + k x - 2 k a theta = 0 $, 6)
        - *Equation of motion of the pendulum*:
            $ J_o dot.double(theta) = sum M_o $
            $
                m (3 a)^2 dot.double(theta) = - k a theta dot a
                + k (x - 2 a theta) 2 a - m g dot 3 a theta
            $
            $
                9 m a^2 dot.double(theta)
                - 2 k a x + (5 k a^2 + 3 m g a) theta = 0
            $
    ],
    image("./images/2-dof-systems-rotational-translational-fbd.png"),
)

#pagebreak()

==== Natural frequencies
- Substituting numerical values into the equations of motion:
    $ 10 dot.double(x) + 20000 x - 8000 theta = 0 $
    $ 3.6 dot.double(theta) - 8000 x+ 4058.8 theta = 0 $
- In matrix form:
    #labelled_equation(
        $
            underbrace(bmat(10, 0; 0, 3.6), "Mass matrix")
            underbrace(
                cvec(dot.double(x), dot.double(theta)),
                "Acceleration vector",
            )
            + underbrace(
                bmat(20000, -8000; -8000, 4058.8),
                "Stiffness matrix",
            )
            underbrace(cvec(x, theta), "Displacement vector")
            = cvec(0, 0)
        $,
        8,
    )
- Solution will be harmonic in the form:
    $
        x = X sin omega t quad => quad
        dot.double(x) = - omega^2 X sin omega t
    $
    $
        theta = Theta sin omega t quad => quad
        dot.double(theta) = - omega^2 Theta sin omega t
    $
- Substituting this into equation (8):
    $
        - omega^2 bmat(10, 0; 0, 3.6) cvec(X, Theta) sin omega t
        + bmat(20000, -8000; -8000, 4058.8) cvec(X, Theta) sin omega t
        = cvec(0, 0)
    $
    $
        - omega^2 bmat(10, 0; 0, 3.6) cvec(X, Theta) redcancel(sin omega t)
        + bmat(20000, -8000; -8000, 4058.8) cvec(X, Theta)
        redcancel(sin omega t)
        = cvec(0, 0)
    $
- The above can be written as:
    #labelled_equation(
        $
            bmat(
                20000 - 10 omega^2, -8000;
                -8000, 4058.8 - 3.6 omega^2;
            )
            cvec(X, Theta) = cvec(0, 0)
        $,
        9,
    )
- For the non-trivial solution, the determinant of the system matrix must be
    zero:
    $
        det bmat(
            20000 - 10 omega^2, -8000;
            -8000, 4058.8 - 3.6 omega^2;
        ) = 0
    $
- Which gives the characteristic equation (frequency equation):
    $ (20000 - 10 omega^2)(4058.8 - 3.6 omega^2) - 8000^2 = 0 $
    $ 36 omega^4 - 112588 omega^2 17176000 = 0 $
- The roots of the characteristic equations give us the natural frequencies:
    $ omega_1^2 = 160.827, wide omega_2^2 = 2966.62 $
    $ omega_1 = #qty[12.68][rad s^-1], wide omega_2 = #qty[54.47][rad s^-1] $

#pagebreak()

==== Mode shapes
- From the first equation in (9), we find the *amplitude ratio*:
    $ (20000 - 10 omega^2) X - 8000 Theta = 0 $
    $ X/Theta = frac(8000, 20000 - 10 omega^2) $
- Putting $omega = omega_1 = #qty[12.68][rad s^-1]$, the *1st mode shape vector*
    is obtained as:
    $
        (X/Theta)^((1)) = frac(8000, 20000 - 10 times 12.68^2) = 0.43498
        quad => quad cvec(X, Theta)^((1)) = cvec(0.43498, 1)
    $
- Putting $omega = omega_2 = #qty[54.47][rad s^-1]$, the *2nd mode shape vector*
    is obtained as:
    $
        (X/Theta)^((2)) = frac(8000, 20000 - 10 times 54.47^2) = -0.8276
        quad => quad cvec(X, Theta)^((2)) = cvec(-0.8276, 1)
    $

#pagebreak()

== Interesting problems that can be modelled as 2-DOF systems

=== A branch with 2 durians
#cimage("./images/2-dof-systems-branch-with-2-durians.png")

=== A 2-storey building
#cimage("./images/2-dof-systems-2-storey-building.png")
#pagebreak()

= Forced vibration of 2-DOF systems
- We only consider *harmonic excitation*.
- When a 2-DOF system is excited by a harmonic excitation force, the system's
    response will be similar to the response of a 1-DOF system.
- In a 1-DOF system, resonance occurs when the forcing frequency equals the
    natural frequency.
- We know a 2-DOF system has *2 natural frequencies*. Hence, *resonance can
    occur #text(red)[twice] in 2-DOF systems*:
    - When the excitation frequency is equal to the first natural frequency.
    - When the excitation frequency is equal to the second natural frequency.
- Similar to 1-DOF systems, at each resonance, the amplitudes of vibration build
    up to large values, and *tend to infinity if there is no damping*.

== Forced response of a 2-DOF horizontal spring-mass system
<2-dof-systems-forced-horizontal>
#cimage("./images/2-dof-systems-forced-horizontal.png")

- While drawing the free body diagram for masses, similar to the free vibration
    analysis, we assume $x_1 > x_2$ for mass $m_1$, and $x_2 > x_1$ for mass
    $m_2$.
- By doing so, we know for sure that the spring forces (restoring forces) acting
    on each mass $m_1$ and mass $m_2$, will be directed opposite to their
    respective displacements, $x_1$ and $x_2$.
- This helps to quickly determine the directions of spring forces while drawing
    the free body diagrams, particularly in $n$-DOF systems.

#pagebreak()

=== Equations of motion
#grid(
    columns: 2,
    column-gutter: 3em,
    row-gutter: 1em,

    figure(
        image("./images/2-dof-systems-forced-horizontal-mass-1.png"),
        caption: [Free body diagram of mass 1],
    ),
    figure(
        image("./images/2-dof-systems-forced-horizontal-mass-2.png"),
        caption: [Free body diagram of mass 2],
    ),

    [
        Newton's second law:
        $
            overbrace(m dot.double(x), stretch(->)^+)
            = sum overbrace(F_x, stretch(->)^+)
        $
        $
            m_1 dot.double(x)_1 = - k_1 (x_1 - 0) - k_2 (x_1 - x_2)
            + F_1 sin omega t
        $

        Equation of motion of mass 1:
        #labelled_equation(
            $
                m_1 dot.double(x)_1 + (k_1 + k_2) x_1 - k_2 x_2
                = F_1 sin omega t
            $,
            1,
        )
    ],
    [
        Newton's second law:
        $
            overbrace(m dot.double(x), stretch(->)^+)
            = sum overbrace(F_x, stretch(->)^+)
        $
        $
            m_2 dot.double(x)_2 = - k_2 (x_2 - x_1) - k_3 (x_2 - 0)
            + F_2 sin omega t
        $

        Equation of motion of mass 2:
        #labelled_equation(
            $
                m_2 dot.double(x)_2 - k_2 x_1 + (k_2 + k_3) x_2
                = F_2 sin omega t
            $,
            2,
        )
    ],
)

#pagebreak()

=== Forced vibration amplitudes
- Equations of motion:
    #labelled_equation(
        $
            m_1 dot.double(x)_1 + (k_1 + k_2) x_1 - k_2 x_2
            = F_1 sin omega t
        $,
        1,
    )

    #labelled_equation(
        $
            m_2 dot.double(x)_2 - k_2 x_1 + (k_2 + k_3) x_2
            = F_2 sin omega t
        $,
        2,
    )
- Equations of motion in matrix form:
    #labelled_equation(
        $
            bmat(m_1, 0; 0, m_2) cvec(dot.double(x)_1, dot.double(x)_2)
            + bmat(k_1 + k_2, -k_2; -k_2, k_2 + k_3) cvec(x_1, x_2)
            = cvec(F_1 sin omega t, F_2 sin omega t)
        $,
        3,
    )
- For simplicity, we take:
    $ m_1 = m_2 = m, quad k_1 = k_2 = k_3 = k, quad F_2 = 0 $
- Hence, the equation of motion becomes:
    #labelled_equation(
        $
            bmat(m, 0; 0, m) cvec(dot.double(x)_1, dot.double(x)_2)
            + bmat(2k, -k; -k, k_2 + k_3) cvec(x_1, x_2)
            = cvec(F_1, 0) sin omega t
        $,
        4,
    )
- Note that the mass and stiffness matrices are the same as in the #link(
        <2-dof-systems-horizontal-natural-frequencies>,
    )[free vibration analysis]. The only thing that is new is that the *force
    vector* on the right side of equation (4) is *non-zero*.
- These differential equations have harmonic solutions in the form:
    $
        x_1 = X_1 sin omega t quad => quad
        dot.double(x)_1 = - omega^2 X_1 sin omega t
    $
    $
        x_2 = X_2 sin omega t quad => quad
        dot.double(x)_2 = - omega^2 X_2 sin omega t
    $

    Where $omega$ refers to the excitation frequency.
- Substituting the above into equation (4):
    $
        - omega^2 bmat(m, 0; 0, m) cvec(X_1, X_2) redcancel(sin omega t)
        + bmat(2k, -k; -k, k_2 + k_3) cvec(x_1, x_2) redcancel(sin omega t)
        = cvec(F_1, 0) redcancel(sin omega t)
    $
- Cancelling out $sin omega t$:
    $
        - omega^2 bmat(m, 0; 0, m) cvec(X_1, X_2)
        + bmat(2k, -k; -k, k_2 + k_3) cvec(x_1, x_2)
        = cvec(F_1, 0)
    $
- The above can be written as:
    #labelled_equation(
        $
            bmat(2k - m omega^2, -k; -k, 2k - m omega^2) cvec(X_1, X_2)
            = cvec(F_1, 0)
        $,
        5,
    )

#pagebreak()

- Using Cramer's rule to calculate $X_1$:
    #labelled_equation(
        $
            X_1 = frac(
                overbrace(
                    det bmat(F_1, -k; 0, 2k - omega^2 m),
                    #text[The *first column* is replaced by the force vector],
                ),
                underbrace(
                    det bmat(2k - omega^2 m, -k; -k, 2k - omega^2 m),
                    "Determinant of the system matrix",
                )
            )
            = frac(F_1 (2k - omega^2 m), (2 k - omega^2 m)^2 - k^2)
        $,
        6,
    )
- Using Cramer's rule to calculate $X_2$:
    #labelled_equation(
        $
            X_2 = frac(
                overbrace(
                    det bmat(2k - omega^2 m, F_1; -k, 0),
                    #text[The *second column* is replaced by the force vector],
                ),
                underbrace(
                    det bmat(2k - omega^2 m, -k; -k, 2k - omega^2 m),
                    "Determinant of the system matrix",
                )
            )
            = frac(F_1 k, (2 k - omega^2 m)^2 - k^2)
        $,
        7,
    )
- We know #link(<2-dof-systems-horizontal>)[(from free vibration analysis)]:
    $ omega_1 = sqrt(k/m), quad omega_2 = sqrt(frac(3 k, m)) $
- If $omega = omega_1$ or $omega = omega_2$, the determinant of the system
    matrix will reduce to 0. This is because the *natural frequencies* are found
    by *setting the determinant to 0*.
- Thus, when $omega -> omega_1$ or $omega -> omega_2$, the amplitudes $X_1$ as
    well as $X_2$ tend to infinity, which means *resonance occurs at these
    frequencies*.
- The amplitude expressions can also be rewritten as:
    #labelled_equation(
        $
            X_1 = frac(F_1 (2k - m omega^2), (2 k - m omega^2)^2 - k^2)
            = frac(
                F_1 (2 k - m omega^2),
                m^2 (omega^2 - omega_1^2) (omega^2 - omega_2^2)
            )
        $,
        8,
    )
    #labelled_equation(
        $
            X_2 = frac(F_1 k, (2 k - m omega^2)^2 - k^2)
            = frac(
                F_1 k,
                m^2 (omega^2 - omega_1^2) (omega^2 - omega_2^2)
            )
        $,
        9,
    )
- Now, it is easy to see that when $omega -> omega_1$ or $omega -> omega_2$,
    both $X_1$ and $X_2$ tend to infinity, which correctly predicts resonance.
- Finally, the *forced vibration response* can be written as:
    $
        x_1 = X_1 sin omega t
        = frac(
            F_1 (2 k - m omega^2),
            m^2 (omega^2 - omega_1^2) (omega^2 - omega_2^2)
        ) sin omega t
    $
    $
        x_2 = X_2 sin omega t
        = frac(
            F_1 k,
            m^2 (omega^2 - omega_1^2) (omega^2 - omega_2^2)
        ) sin omega t
    $
- We started off by assuming the solution to be in the sine form:
    $ x_1 = X_1 sin omega t wide x_2 = X_2 sin omega t $
- We can also assume it in the *cosine* form:
    $ x_1 = X_1 cos omega t wide quad x_2 = X_2 cos omega t $
- In such a case, the only change needed in the derivations will be to replace
    the sine term with the cosine term in all expressions.

=== Amplitude response
#cimage("./images/2-dof-systems-forced-horizontal-response.png")

- Note that the amplitude of mass $m_1$ is zero at a particular frequency
    between $omega_1$ and $omega_2$.
- Thus, if the excitation frequency is set to this value, *mass $m_1$* does *not
    vibrate* at all.
- This observation is useful in *vibration suppression or isolation problems*.

=== Amplitude in absolute form
#cimage("./images/2-dof-systems-forced-horizontal-response-absolute.png")

- These plots above, in absolute form, helps us visualise resonance clearly.
- The peaks signify resonance. There are two peaks.
- Thus, in a 2-DOF system, there are two *resonant frequencies*
    ($omega_1, omega_2$).

== Force transmission to supports
- Considering the #link(
        <2-dof-systems-forced-horizontal>,
    )[same 2-DOF system discussed above].
- *Forces transmitted to the supports* can be found as follows:
    #cimage("./images/2-dof-systems-force-transmission-to-supports.png")

    #grid(
        columns: 2,
        column-gutter: 2em,
        $
            k x_1 & = k X_1 sin omega t \
                  & = underbrace(
                        k frac(
                            F_1 (2 k - m omega^2),
                            m^2 (omega^2 - omega_1^2) (omega^2 - omega_2^2)
                        ), #text[
                            Amplitude of force \
                            transmitted to the \
                            *left support*
                        ]
                    ) sin omega t
        $,
        $
            k x_2 & = k X_2 sin omega t \
                  & = underbrace(
                        k frac(
                            F_1 k,
                            m^2 (omega^2 - omega_1^2) (omega^2 - omega_2^2)
                        ), #text[
                            Amplitude of force \
                            transmitted to the \
                            *right support*
                        ]
                    ) sin omega t
        $,
    )

== Forced response of a 2-DOF vertical spring-mass system
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - If the displacements $x_1$ and $x_2$ are measured from the respective
            equilibrium positions (*SEP*) of the masses as shown in the figure
            beside, then the equations of motion and amplitude expressions will
            be *exactly the same as #link(
                <2-dof-systems-forced-horizontal>,
            )[the horizontal spring-mass system]* that have been discussed
            above.
        - This suggest that the static deflection of masses have no effect on
            the vibration amplitudes $X_1$ and $X_2$.
    ],
    image("./images/2-dof-systems-forced-vertical.png"),
)

== A 2-DOF system under harmonic base excitation
#cimage("./images/2-dof-systems-harmonic-base-excitation.png")

- Excitation of a car by a rough road is an example of base excitation.
- We assume that the road profile is sinusoidal.

#cimage("./images/1-dof-vs-2-dof-model-of-car.png")
#pagebreak()

=== Numerical example
Vertical motion of a car is modelled with a two spring-mass system (without
damper). The mass of the car and driver (excluding the wheels and axles)
$m_2 = #qty[1909][kg]$, that of the wheels and axles $m_1 = #qty[227][kg]$, the
effective spring constant of all four suspension springs $k_2 = #qty[5270][N
    m^-1]$ and the effective spring constant of all four tyres
$k_1 = #qty[17700][N m^-1]$.

If the car is excited on a test bed vibrating up and down at #qty[1.8][Hz] with
an amplitude of #qty[25][mm], determine the amplitude of vertical motion of the
car and driver. Assume that the car does not have rocking motion and all the
wheels have identical vertical motion.

#cimage(
    "./images/2-dof-systems-harmonic-base-excitation-example.png",
    width: 80%,
)

$ omega = 2 pi times #qty[1.8][rad s^-1] = #qty[11.310][rad s^-1] $

==== Equation of motion
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Referring to the free-body digrams on the right and applying Newton's
            law to each mass yields:
            $ m_1 dot.double(x)_1 = -k_1 (x_1 - y) - k_2 (x_1 - x_2) $
            $ m_2 dot.double(x)_2 = -k_2 (x_2 - x_1) $
        - Rearranging, the equations of motion (EOM) are obtained as:
            $ m_1 dot.double(x)_1 + (k_1 + k_2) x_1 - k_2 x_2 = k_1 y $
            $ m_2 dot.double(x)_2 - k_2 x_1 + k_2 x_2 = 0 $

            Where the base excitation is:
            $ y = Y sin omega t $
        - These differential equations have constant coefficients and damping is
            zero, so they have a harmonic solution of the form:
            $
                x_1 = X_1 sin omega t quad => quad
                dot.double(x) = - omega^2 X_1 sin omega t
            $
            $
                x_2 = X_2 sin omega t quad => quad
                dot.double(x) = - omega^2 X_2 sin omega t
            $
    ],
    image("./images/2-dof-systems-harmonic-base-excitation-example-fbd.png"),
)

==== Harmonic response
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Substituting for $x_1, x_2$ and $y$ in the equation of motion yields:
            $ (- m_1 omega^2 + k_1 + k_2) X_1 - k_2 X_2 = k_1 Y $
            $ -k_2 X_1 + (- m_2 omega^2 + k_2) X_2 = 0 $
        - In matrix form, the equation of motion becomes:
            $
                bmat(-m_1 omega^2 + k_1 + k_2, -k_2; -k_2, -m_2 omega^2 + k_2)
                cvec(X_1, X_2) = cvec(k_1 Y, 0)
            $
        - The amplitude of motion of the car and driver by Cramer's rule:
            $
                X_2 & = frac(
                          mat(
                              -m_1 omega^2 + k_1 + k_2, k_1 Y;
                              -k_2, 0;
                              delim: "|",
                          ),
                          mat(
                              -m_1 omega^2 + k_1 + k_2, - k_2;
                              -k_2, -m_2 omega^2 + k_2;
                              delim: "|"
                          )
                      ) \
                    & = frac(2.332 times 10^6, 1.421 times 10^9) \
                    & = #qty[0.00164][m] \
                    & = #qty[1.64][mm]
            $
    ],
    image(
        "./images/2-dof-systems-harmonic-base-excitation-example-response.png",
    ),
)
