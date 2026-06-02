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
#show: cheat_sheet.with(font_size: 5pt, number_of_columns: 6)

// Set the grid properties
#set grid(
    column-gutter: 0.5em,
    row-gutter: 0.5em,
    align: center + horizon,
)

// Set the table properties
#set table(stroke: 0.1em, inset: 0.4em)

// Import the units library
#import "@preview/fancy-units:0.1.1": qty, unit

// Function definitions
#let cimage(..image_args) = align(center, image(..image_args))
#let bmat = math.mat.with(delim: "[")
#let pmat = math.mat.with(delim: "(")
#let cmat = math.mat.with(delim: "{")
#let amat(..content) = $<mat(..content, delim: #none)>$

#let true-blue = rgb(0, 0, 255)

= Crystalline solids
*Unit cell*: Single basic structural repeat unit that, when duplicated and
translated, reproduces the entire crystal structure.

*Coordination number*: The number of nearest neighbouring atoms touching it.

Non-close packed: 8 for BCC.

#{
    set image(height: 5em)

    table(
        columns: 4,

        table.cell(rowspan: 2)[Closed packed:],
        [AAA (6)], [ABA (12)], [ABC (6), FCC],

        image("./images/aaa-stacking.png"),
        image("./images/aba-stacking.png"),
        image("./images/abc-stacking.png"),
    )
}

*Number of atoms per unit cell*: How many unit-cells has this atom?
- Simple: $1$
- BCC: $1 + 8 (1/8) = 2$
- FCC: $8 (1/8) + 6 (1/2) = 4$
- $N = sum n_i times "Part of atom"_i "in unit cell"$

*Atomic radius and unit cell dimensions relation*:

#{
    set image(height: 7em)

    grid(
        columns: 3,

        [
            - Simple: $a = 2r$
            - BCC: $a = frac(4 r, sqrt(3))$
            - FCC: $a = 2 sqrt(2) r$
        ],

        align(center)[
            BCC

            #image("./images/body-centred-cubic-unit-cell.png")
        ],

        align(center)[
            FCC
            #image("./images/face-centred-cubic-unit-cell.png")
        ],
    )
}

*Atomic packing factor*: How efficient the atoms are packed in a crystal
structure.

$"APF" = frac(
    "Total volume of atoms in a unit cell," V_s,
    "Total volume of unit cell," V_c
)$

FCC: Face centre = $1/2$, corner = $1/8$ atom, so

$"APF" = (1/2 times 6) + (1/8 times 8) = 4$

BCC: Centre = $1$, corner = $1/8$ atom, so
$1 + (1/8 times 8) = 2$

*Density of unit cell*:

$rho_c = frac(n A_m, N_A V_c) space (#unit[g cm^-3])$

- $n$ is the number of atoms per unit cell
- $A_m$ is the atomic mass of an atom
- $N_A = 6.023 times 10^(23)$
- $V_c$ is the volume of a unit cell

#table(
    columns: 2,

    table.header([*Single crystal*], [*Polycrystalline*]),

    [
        - Perfect 3D periodic arrangement of atoms through the entire structure.
        - All unit cells interlock in the same way and have the *same
            crystallographic orientation*.
        - Varying degrees of *anisotropy (direction dependent)*, depending on
            the symmetry of the crystal structure.
    ],
    [
        - Solids made from many small *crystals or grains*.
        - Grain boundaries are formed where crystals meet.
        - Tend to be *isotropic (direction independent)* due to random
            crystallographic orientations of individual grains.
    ],
)

= Crystallography
*Point coordinates*: Location of atom in a unit cell.

*Crystallographic directions*: Vector connecting coordinate origin and a
specific point in a unit cell, $bmat(u, v, w)$.

Selecting origin: Number is negative ($bmat(macron(1))$)? Shift the origin to 1.

#table(
    columns: 2,

    table.header([*Indices given*], [*Direction drawn*]),

    [
        + Select origin.
        + Reduce maximum number to 1.
        + Locate vector direction from the new origin.
        + Draw the vector.
    ],
    [
        + Select origin (*start of the vector*).
        + Determine the coordinate of the end point of the vector from the
            origin.
        + Reduce values to *whole numbers*.
        + Place within "[]".
    ],
)

#grid(
    columns: 2,
    align: center + horizon,
    grid.header([*FCC*], [*BCC*]),

    [
        Direction: $amat(1, 1, 0)$

        Planes: $cmat(1, 1, 1)$
    ],
    [
        Direction: $amat(1, 1, 1)$

        Planes: $cmat(1, 1, 0)$
    ],

    image("./images/dislocations-slip-systems-in-fcc-metals.png"),
    image("./images/dislocations-bcc-slip-systems.png"),
)

*Families of directions in a unit cell*: Set of directions that are
crystallographically identical, $amat(u, v, w)$.
- Members of the same crystallographic direction have the same properties, like
    packing density and physical properties.
- Directions must be unique, i.e. not parallel to each other.
- Family example: $amat(1, 1, 0)$
    #grid(
        columns: 4,

        $bmat(1, 1, 0)$,
        $bmat(macron(1), 1, 0)$,
        $bmat(1, macron(1), 0)$,
        $bmat(macron(1), macron(1), 0)$,

        $bmat(1, 0, 1)$,
        $bmat(macron(1), 0, 1)$,
        $bmat(1, 0, macron(1))$,
        $bmat(macron(1), 0, macron(1))$,

        $bmat(0, 1, 1)$,
        $bmat(0, macron(1), 1)$,
        $bmat(0, 1, macron(1))$,
        $bmat(0, macron(1), macron(1))$,
    )
*Crystallographic planes*: Set of parallel and equally spaced planes that pass
through atom centres (#underline[no centre must be situated between planes]),
$pmat(h, k, l)$.
- Distance between successive planes depends on their direction in relation to
    the arrangement of atomic centres.
- Planes are important for mechanical deformation of metals (anisotropy and
    isotropy) and transportation or electrons or conductivity.

*Family of planes*: Members of planes in the same unit crystal that are
crystallographically equivalent, $cmat(h, k, l)$.
- Same packing density, atomic environment, mechanical and physical properties.
- For $cmat(1, 0, 0), pmat(macron(1), 0, 0) pmat(0, 1, 0)
    pmat(0, macron(1), 0) pmat(0, 0, 1) pmat(0, 0, macron(1))$. Basically,
    having the "1" makes it the same family.

#table(
    columns: 2,
    table.header([*Miller indices given*], [*Drawn plane*]),

    [
        + Select origin.
        + Reciprocate indices $(1/0 = oo = "parallel")$.
        + Reciprocated indices is the intercept.
        + Mark intercept along the $x$-$y$-$z$ axes.
        + Connect intercepts to get plane, and note the importance of
            parallelism.
    ],

    [
        + Choose the closest corner (*plane cannot touch origin*).
        + Select corner as the origin.
        + FInd intercepts with the $x$-$y$-$z$ axis.
        + Take reciprocals of the intercepts.
        + Reduce multiples, eliminate fractions and add bar for negative.
        + Round brackets.
    ],
)

*Linear density*: Determines directional equivalence of a single crystal. Vector
*MUST* cut through the middle of the atom.
$
    "LD" = frac(
        #text[Number of atoms #text(red)[centred] on directional vector],
        "Length of directional vector"
    )
$

#grid(
    columns: 2,
    align: center + horizon,

    [
        FCC:
        $ "LD" = frac(1/2 + 1 + 1/2, R + 2R + R) = frac(1, 2R) $
    ],
    image("./images/linear-density-example.png"),
)
*Planar density*:
$
    "PD" = frac(
        #text[Number of atoms #text(red)[centred] on a plane],
        "Area of the plane"
    )
$
- Plane must cut through the *CENTRE* of the atom.

#{
    set image(height: 7em)

    grid(
        columns: 2,
        align: center + horizon,

        [
            BCC: $pmat(1, 1, 0)$

            #image("./images/planar-density-bcc-100.png")

            $N = (1/4 times 4) + 1 = 2$

            $A = sqrt(2) a times a = sqrt(2) a^2$

            $"PD" = frac(2, a^2 sqrt(2))$
        ],
        [
            FCC: $pmat(1, 0, 0)$

            #image("./images/planar-density-fcc-100.png")

            $N = (1/4 times 4) + 1 = 2$

            $A = a times a = sqrt(2) a^2$

            $"PD" = frac(2, a^2)$
        ],

        [
            $pmat(1, 1, 1)$ does not cut the centre atom:

            #image("./images/planar-density-bcc-111.png")

            $N = (1/6 times 3) = 1/2$

            $A = frac(8R^2, sqrt(3))$

            $"PD" = 1/2 div frac(8R^2, sqrt(3)) = frac(sqrt(3), 16 R^2)$
        ],
        [
            $pmat(1, 1, 1)$

            #image("./images/planar-density-fcc-111.png")

            $N = (1/6 times 3) + (1/2 times 3) = 2$

            $A = frac(8R^2, sqrt(3))$

            $"PD" = 2 div frac(8R^2, sqrt(3)) = frac(sqrt(3), 4R^2)$
        ],
    )
}

= Defects
*Point defects*: Vacancies and self-interstitials
#grid(
    columns: 2,

    [*Vacancies:*], image("./images/point-defects-vacancies.png"),

    [*Self-interstitials:*],
    image("./images/point-defects-self-interstitials.png"),
)

#{
    set image(height: 5em)

    align(center, grid(
        columns: 2,

        grid.header([*Substitutional impurity*], [*Interstitial impurity*]),

        image("./images/substitutional-impurity.png"),
        image("./images/interstitial-impurity.png"),
    ))
}


*Energy cost of crystalline defects*: Most crystalline defects create strain and
distorts the lattice #sym.arrow increasing the energy of the system ($G$). The
system will tend to reach an equilibrium state, minimising $G$.

$ G = H - T S wide Delta G = Delta H - T Delta S $
- $H$ is the enthalpy, the energy cost to break atomic bonds
- $S$ is the entropy, the energy associated with the creation of states
- $T$ is the temperature (#unit[K])

*Arrhenius law*: $n/N = exp(- frac(Q_v, k T))$,
$N = frac(
    rho "(density)" times 6.023 times 10^(23),
    A_(c v) "(weight of 1 atom)"
)$
- $n$ is the number of defects (vacancies)
- $N$ is the number of atomic sites
- $Q_v$ is the activation energy for vacancy formation (#unit[J mol^-1] or
    #unit[eV atom^-1])
- $k$ is the Boltzmann's constant, $1.38 times 10^(-23) #unit[J atom^-1 K^-1]$
    or $8.62 times 10^(-5) #unit[eV atom^-1]$.

== Formation of point defects
- *Annealing and quenching*: Kinetically trapping defects.
- *Irradiation by high energy particles*.
- *Ion implantation*: High energy ions implemented in material.
- *Cold working*: Irreversible mechanical deformation at low temperatures.

#grid(
    columns: 2,
    align: left + horizon,

    [
        == Polycrystalline materials
        *Grain boundaries*: Regions between crystals.
        - Transition line from lattice to lattice.
        - Slightly disordered.
        - Low density of atomic packing in grain boundaries.
    ],
    image("./images/microscopy-techniques-and-grain-boundary-examination.png"),
)

- High mobility, diffusivity and chemical reactivity.
- Can be equiaxed (same size), or columnar (elongated).

== Dislocations
- Burgers vector, *$b$*: Magnitude and direction of the lattice distortion of a
    dislocation.
    #grid(
        columns: 2,

        [Edge dislocation: *$b$* perpendicular to the dislocation],
        [Screw dislocation: *$b$* parallel to the dislocation],

        image("./images/screw-dislocation-burgers-vector.png"),
        image("./images/edge-dislocation-burgers-vector.png", height: 7em),
    )

== Microscopy
#grid(
    columns: 2,
    align: (left, right),

    [
        *Optical microscopy*:
        - 2000X magnification.
        - Boundaries revealed as dark lines, and change in crystal orientations
            can be observed.
        - Can use polarised light to increase contrast and to observe
            transparent samples.
    ],
    image("./images/optical-microscopy-example.png", height: 4em),
)

#grid(
    columns: 2,
    column-gutter: 1em,
    align: (left, right),

    [
        *Electron microscopy*:
        - $10^(-7) #unit[m]$. Higher resolution, higher frequency.
    ],
    image("./images/electron-microscopy-example.png", height: 3em),
)

= Phase diagrams
- Solubility limit: The max concentration for a single phase solution to exist.
- Equilibrium phase diagrams: All phase diagrams are computed when the system is
    at thermodynamic equilibrium ($G_"min"$), i.e. unchanging with time, and
    temperature is constant.
- Solute is the minority component in an alloy.
- Solvent is the majority component in an alloy.

== Hume-Rothery rules for complete solid solutions
+ Atomic size factor: Difference in atomic radii between atoms is less than
    $plus.minus 15%$.
+ Crystal structure: Crystal structures formed by both atoms must be of the same
    type, FCC, etc.
+ Electronegativity: Both components' atoms must be similar, if not ions will be
    formed.
+ Valency: Combining capacity of both elements must be similar.

More than 2 elements can form a solid solution, including ions (of similar
charge).

== Isomorphous ($L + alpha$) binary phase diagram
- 2 independent variables, temperature and concentration. Pressure is
    #qty[1][atm].

#grid(
    columns: 2,
    align: (left, right),

    [
        === Phase composition
        - $B$: Both $alpha$ and $L$ present.
        - Liquid: $C_L = 32%$ (trace left)
        - Solid: $C_alpha = 32%$ (trace right)
        - At $A$, only $L$ present.
        - At $C$, only $alpha$ present.

        === Phase weight fraction
        Take the line opposite the current phase. For the weight fraction of the
        liquid, take the line for the solid.

        $S = C_alpha - C_0 "(line to solidus)"$

        $W_L = frac(S, R + S) wide W_alpha = frac(R, R + S)$
    ],

    image("./images/determination-of-phase-weight-fractions.png"),
)

#grid(
    columns: 2,
    align: (left, right),

    [
        === Solidification during cooling
        - Trace concentration line down as temperature decreases.
        - Faster rate of cooling results in a cored structure.
        - Slower rate of cooling results in an equilibrium structure.
    ],
    image("./images/solidification-during-cooling.png", height: 10em),
)

== Binary eutectic system
- Above the solubility limit, a new phase is formed ($beta$).
- $beta$ has different compositions from $alpha$ (both solutions).
- May have different crystal structures.
- Multiple phases coexist when immiscible or at solubility limit.
- Contains 3 single phase regions ($L, alpha, beta$):
    - $T_E$: No liquid below $T_E$ (eutectic temperature)
    - $C_E$: Composition at temperature $T_E$
- Weight compositions: Similar to isomorphous.
    + Find the point with temperature and concentration.
    + Extend to the right and left to find the phases present.
    + Calculate using the "opposite" line.

#{
    set image(height: 12em)
    set align(center)

    grid(
        columns: 2,
        align: center + horizon,

        image(
            "./images/microstructural-developments-in-eutectic-systems-1.png",
        ),
        image(
            "./images/microstructural-developments-in-eutectic-systems-2.png",
        ),
    )
}

=== Development of eutectic alloy
#{
    set image(height: 2.5em)

    grid(
        columns: 2,
        align: left + horizon,

        [
            - $2 < C_0 < 18.3$:

                Formation of polycrystalline with #text(
                    true-blue,
                    sym.alpha,
                ) grains and #text(red, sym.beta)-phase particles.
        ],
        image("./images/polycrystalline-with-particles.png"),

        [
            - $18.3 < C_0 < C_E$:

                Formation of *near-eutectic* alloys.
        ],
        image("./images/eutectic-with-particles.png"),

        [
            - $C_0 = C_E$:

                Direction formation of #text(true-blue, sym.alpha) and #text(
                    red,
                    sym.beta,
                ) lamellar eutectic microstructure.
        ],
        image("./images/eutectic-lamellar.png"),

        [
            - $C_E = C_0 < 97.8$:

                Formation of *near-eutectic* alloys.
        ],
        image("./images/eutectic-with-particles.png"),

        [
            - $97.8 < C_0 < 99$:

                Formation of polycrystalline with #text(true-blue, sym.beta)
                grains #text(
                    red,
                    sym.alpha,
                )-phase particles.
        ],
        image("./images/polycrystalline-with-particles.png"),
    )
}

#cimage("./images/hypoeutectic-and-hypereutectic.png", height: 12em)

Treat intermetallic compounds as 2 different phase diagrams that are conjoined.

Eutectic: Liquid $stretch(harpoons.rtlb)_"heat"^"cool"$ solid 1 + solid 2

Eutectoid: Solid 1 $stretch(harpoons.rtlb)_"heat"^"cool"$ solid 2 + solid 3

Peritectic: Liquid + solid 1 $stretch(harpoons.rtlb)_"heat"^"cool"$ solid 2

=== Phase diagram uses
- Explains what process to use to control composition, size and arrangement of
    phases in a certain system.
- We control the microstructure of the alloy through such processes to achieve
    the alloy properties that we want.

== Fe-C phase diagram
#grid(
    columns: (1fr, 2fr),
    align: left,

    [
        - Eutectic (A):

            $L -> gamma + "Fe"_3"C"$

        - Eutectoid (B):

            $gamma -> alpha + "Fe"_3"C"$

            #image("./images/fe-c-phase-diagram-grains.png")
    ],
    image("./images/fe-c-phase-diagram.png"),
)

#table(
    columns: 2,

    table.header([*Pearlite*], [*Martensite*]),

    [
        - The combination of cemenite and ferrite makes pearlite a tough phase.
        - Ferrite is soft and ductile, while cementite is hard and brittle.
        - For this reason, perlite is ideal for a blade's body.
    ],
    [
        - Martensite comes from rapid cooling or quenching of austenite.
        - It is a non-equilibrium phase, does not show up in the Fe-C phase
            diagram.
        - It is the strongest and hardest phase available in the Fe-C system.
        - It is ideal for the cutting edge of a blade.
        - Cementite decomposes to ferrite and graphite.
    ],
)

*Differential quenching* is the quenching process of cooling down a single piece
of metal at different rates, using different thickness clay layers to control
the rate the metal cools.

*Metal alloys*: Ferrous means iron-based, non-ferrous means non-iron-based.
Ferrous alloys have high densities, low electrical conductivities, and poor
corrosion resistance.

*Cast iron*: More than 2.1 wt% C (usually 3 - 4.5). Low melting point, generally
brittle.

= Mechanical properties of materials
*Engineering stress*
#grid(
    columns: (1fr, 1fr),

    [Tensile: $sigma = frac(F_t, A_0) space (#unit[N m^-2])$],
    [Shear: $tau = frac(F_s, A_0) space (#unit[N m^-2])$],
)

$A_0$ is the original area before load.

*Engineering strain*
#grid(
    columns: (2fr, 1fr, 1fr),

    [
        Tensile strain:

        $ epsilon = frac(delta, L_0) = frac(L - L_0, L_0) $
    ],
    [
        Shear strain:

        $ gamma = frac(Delta x, y) = tan theta $
    ],
    image("./images/engineering-strain-shear-strain.png", height: 5em),
)

#grid(
    columns: (auto, 15em),
    align: left,
    [
        - *Young's modulus* is the linear portion gradient.
        - *Yield strength* is $sigma_Y$ at 0.2% *plastic* strain.
        - *Ultimate tensile strength* is the *peak of the plastic curve*, the
            max stress a material can withstand before breaking.
        - *Toughness* is the area under the curve. It's the energy required to
            break a unit volume of material.
    ],
    image("./images/stress-strain-curve-all-properties.png"),
)

*Ductility (%EL)*: $frac("Final length" - "Original length", "Original length")$

*Area reduction (%RA)*: $frac("Final area" - "Original area", "Original area")$

*Elastic strain energy or resilience*: The ability to store energy through
deformation. Equal to the area under the elastic region of the stress-strain
curve. The limit of elastic behaviour, and the beginning of plastic behaviour.

$U_r = 1/2 sigma epsilon = frac(E epsilon^2, 2) = frac(sigma^2, 2 E)$

*Yield strength*: Stress where noticeable plastic deformation has occurred (0.2%
plastic strain).

*Toughness*: Energy required to break a unit volume of material.

*True stress*: $sigma_T = F/A_i = sigma (1 + epsilon)$, $epsilon$ is engineering
strain.

*True strain*: $epsilon_T = ln (l_i/l_o) = ln (1 + epsilon)$

*Hardness*: Resistance of a material to permanent indentation.
$"Hardness" = frac(P_"max", "Area")$

*Work or strain hardening*: Increase in $sigma_Y$ due to plastic deformation.

$sigma_T = K(epsilon_T)^n$
- $sigma_T$ is the true stress
- $epsilon_T$ is the true strain
- $n$ is the work hardening exponent, 0.15 for some steels and 0.5 for copper.

= Dislocations and strengthening mechanisms
Plastic deformation occurs by slip. Edge dislocation slides over adjacent
planes.

*Dislocation motion*: Moves along slip plane in a lip direction (same as *$b$*)
perpendicular to dislocation line. Dislocation requires successive bumping of
half plane of atoms. Bond are broken and remade in succession.

#{
    set image(height: 5em)

    grid(
        columns: (1fr, 1fr),
        grid.header([*Edge*], [*Screw*]),

        image("./images/edge-dislocation-direction.png"),
        image("./images/screw-dislocation-direction.png"),
    )
}

Dislocations are defects that increase the energy of the system proportional to
$bold(b)^2$ (Burgers vector).

*Dislocation interaction*:

Same sign repel, opposite sign attract and cancel each other out.

#{
    set image(height: 5em)
    set align(center)

    grid(
        columns: 2,
        column-gutter: 2em,

        image("./images/dislocations-lattice-strain-repulsion.png"),
        image("./images/dislocations-lattice-strain-attraction.png"),
    )
}

*LD and Burgers vector*: Min *$b$* will be in the direction of the max linear
density. Atoms area closer, and require less energy to move along atoms. Hence,
the energy required is lower.
- FCC: Min *$b$* along unit cell face
- BCC: Min *$b$* across diagonal

*Slip*: The slip plane has the highest planar density, and the slip direction
has the highest linear density.

*Stress and dislocation motion*:
+ Resolve tensile stress and shear area: \
    Resolved shear stress: $tau_R = sigma m = sigma cos lambda cos phi.alt$
    - $lambda$ is the angle between the slip plane and the force.
    - $phi.alt$ is the angle between the slip plane normal and the force.
    - Max $tau_R = sigma/2$, both angle is $45 degree$. $m$ is the Schmid
        factor.

#cimage("./images/dislocations-stress-and-dislocation-motion.png", height: 10em)

*Non-metals*:
- Ionic, avoid similar signed atoms.
- Covalent, little slip systems with angular bonds and complex dislocation
    structure.
- Ceramics, few slip systems and breaks before plastic deformation.

== Strengthening methods
+ *Grain boundary strengthening*:
    - At temperatures less than $0.5 T_m$ (melting temperature), boundaries act
        as barriers to dislocation motion. Higher energy required for change in
        direction.
    - Smaller grain size, more barriers to slip, higher stress required, hence
        higher strength.

        Yield strength: $sigma_y = sigma_0 + k D^(0.5)$

        Where $sigma_0$ and $k$ are constants, $D$ is the grain size.

+ *Solid solution*: Addition of a solute to generate a strain field to resist
    dislocation. It acts as a barrier to dislocation. Smaller atoms tend to
    concentrate at regions of compressive strains, causing cancellation of
    dislocation compressive strains, reducing dislocation mobility.

+ *Cold work*: $sigma_y arrow.t$, tensile strength #sym.arrow.t, ductility
    #sym.arrow.b (trade off)
    - Dislocations multiply and entangle, causing dislocation motion to be more
        difficult. Cold work occurs at room temperature.

        $% C W = frac(A_0 - A_d, A_0)$

        - $A_0$ is the original cross-sectional area of the material (before
            deformation).
        - $A_d$ is the final cross-sectional area of the material (after
            deformation).
        #cimage("./images/strengthening-methods-drawing.png", width: 50%)

== Annealing
Cold work uses intermittent annealing to restore ductility. Nullifies the effect
of cold work due to heating.
+ Recovery:
    + Diffusion: Atoms move to regions of tension and annihilate dislocations to
        form a perfect plane.
    + Climbing: Dislocations climb into vacant slots after diffusion to reduce
        dislocation density.
+ Recrystallisation: New grains form to have low dislocation densities making
    dislocation easier, smaller size, consume and replace parent (cold work)
    grains.
+ Grain growth: Large grains grow and small grains disappear or shrink.

    $d^n - d_0^n = K t$
    - $d$ is the grain diameter at time $t$
    - $d_0$ is the original grain diameter
    - $K$ is a coefficient dependent on the material and temperature. $t$ is the
        elapsed time and $n = 2$.

    $0.3 T_m < T_R < 0.6 T_m$, $T_R$ (recrystallisation temperature) is the
    temperature where crystallisation finishes in #qty[1][hr]. Depends on:

    #grid(
        columns: 2,
        column-gutter: 2em,

        $% C W: T_R arrow.t "as" % C W arrow.t$,
        $"Purity": T_R arrow.b "as purity" arrow.t$,
    )

*Hot working*: Deformations *ABOVE* $T_R$. Soft high ductility grains
recrystallise and prevent strain hardening.

*Cold working*: Deformations *BELOW* $T_R$ to get final product. Grains deform
and elongate, leading to strain hardening.

= Overview of manufacturing
Metal casting - casting, metal forming - extrusion, metal machining - drilling
and milling, metal joining - welding.

*Additive manufacturing*: Increase weight (3D printing, soldering, surface
welding, laser cladding).

*Subtractive manufacturing*: Decrease weight (milling, cutting, punching,
blanking, machining).

*Formative manufacturing*: No weight change (casting, moulding, bending,
drawing, casting, extrusion, blowing).

*Net shape process*: Little to no waste and minimal machining required.

*Environmentally-conscious manufacturing*: Proper choice of materials, design
products that minimise environmental impact. Manufacturing processes that are
environmentally friendly.

*Dimensions*: Part sizes desired by the designer if the part could be made with
no errors or variations.

*Tolerance*: Total amount by which a specific dimension is permitted to vary.

$"Tolerance" = "Positive tolerance" space – space ("Negative tolerance")$

*Accuracy*: True value of the quantity.

*Precision*: Degree of repeatability.

*Apparatus*: For diameter, micrometre, vernier calliper, bevel protractor, sine
bar ($sin "Angle" = "Height"/"Length"$)

*Surface roughness*: Average vertical deviations from nominal surface over a
specified surface length.

$R_a = sum_(i = 1)^n frac(lr(|y_i|), n) = frac(y_1 + y_2 + dots.c, n)$

= Metal casting
*Pros*: Create complex geometries for both external and internal shapes. Large
parts, suited for mass productions. Near net shape.

*Cons*: Environmental problems, safety hazards to workers, poor dimensional
accuracy and surface finish, limitations on mechanical properties.

*Terminology*: Cope (Upper half of mould), Drag (Bottom half), Flask (Box
contains the mould halves), Parting Line, Core (Used for interior geometry),
Down sprue (a runner towards the main cavity), Pouring cup, Riser (Compensate
for shrinkage and freeze later), Gate

*Flow velocity*: $V = sqrt(2 g h) space (#unit[cm s^-1])$

*Fluidity*: How fast to fill the cavity.
- High viscosity means low fluidity, test using the spiral test.

*Continuity law*: $Q_1 = Q_2 => A_1 ("Vel")_1 = A_2 ("Vel")_2$

*Mould filling*: $t = "Vol"/Q$

*Chvorinov's rule (solidification)*: $T_"ST" = C_m (frac("Vol", A))^n$
- $C_m$ is the mould constant, dependent on the type of metal, density,
    temperature, and heat capacity.
- $A$ is the surface area of casting, and $n = 2$

== Pouring of metal
*Pouring temperature*: Raise temperature to melting point, add the latent heat
of fusion, then raise temperature to desired pouring temperature.

*Rate*: If slow, the metal freezes before filling cavity. If *fast*, turbulence
occurs, creating cavities and degrades casting quality due to irregular flow.
Tapered sprue prevents aspiration of air.

*Riser design*: $T_"ST"$ for riser to solidify > $T_"ST"$ for the rest of
casting to solidify. Maximise $V/A$ to compensate for shrinking.

*Casting quality*: Fluidity (too hard), pouring temperature (too low), velocity
(too slow), improper design, turbulence, shrinkage.

== General casting defects
*Misrun*: Casting solidified before completely filling mould cavity (temperature
low, pouring rate too slow).

*Cold shut*: Two positions of metal flow together, but there is a lack of fusion
due to premature freezing (low temperature).

*Cold shot*: Metal splatters during pouring leading to formation of globules,
which become trapped in the casting. Needs additional molten metal to fill gaps
caused by shrinkage, else cavities form.

*Shrinkage cavity*: Occurs due to thermal contraction during cooling of metal.
Material outside the boundary of the cavity solidifies and shrink first.
- *Cast iron with high carbon content doesn't shrink*, as graphitisation, the
    formation of graphite flakes occurs during the final stages of freezing,
    causing expansion.

*Microporosity*: Small voids distributed throughout the casting caused by
localised solidification shrinkage of the final molten metal within dendritic
structure (exothermic padding, external/internal chills, control cooling).

*Bernoulli's equation*: $frac(P_1, rho g) + frac(v_1^2, 2g) + z_1 - f
= frac(P_2, rho g) + frac(v_2^2, 2g) + z_2$
- $f$ is the frictional loss
- If $P_1 = P_2$, $v_1 = 0$, $z_2 = 0$ and $f = 0$, then:

    $z_1 = frac(v_2^2, 2g) quad => quad v_2 = sqrt(2 g h)$

== Hot tears
- Casting restrained from contraction due to the mould. Occurs at the final
    stages of solidification or the early stage of cooling.
- Exothermic (heat-producing) compounds may be used to control cooling to
    prevent hot tears.
#cimage("./images/metal-casting-hot-tears-2.png", width: 90%)

Chills (internal or external heat sink that cause rapid freezing in certain
regions of the casting).

#{
    set image(height: 7em)
    set align(center)

    grid(
        columns: 2,
        column-gutter: 2em,

        image("./images/metal-casting-external-chills.png"),
        image("./images/metal-casting-internal-chills.png"),
    )
}

== Solidification time
#{
    set image(height: 8em)

    grid(
        columns: (1fr, 1fr),

        grid.header([*Alloy*], [*Pure metal*]),

        image("./images/solidification-metallic-alloy-grain-structure-1.png"),
        image("./images/solidification-pure-metal-grain-structure-1.png"),

        image("./images/solidification-metallic-alloy-graph-only.png"),
        image("./images/solidification-pure-metal-graph.png"),
    )
}

== Product design considerations
#[
    #set image(width: 80%)

    - Geometric simplicity to improve castability.
    - Avoid sharp corners and angles. Have generous fillets on corners and sharp
        edges should be blended.
    - Avoid hot spots and use small cores to prevent cavities.
        #cimage("./images/metal-casting-small-cores.png")
    - Maintain uniform cross-section to prevent cavities.
        #cimage("./images/metal-casting-uniform-cross-section.png")
]

*Expendable mould casting*: Investment casting, sand casting.

*Sand casting*: Most widely used, nearly all alloys can be used, varying sizes
can be done, high quantities produced, but surface finish not good.

== Investment casting
+ Wax pattern is produced.
+ Patterns attached to sprue to form pattern tree.
+ Tree is coated with layer of refractory material.
+ Full mould is formed by covering coated tree with sufficient refractory
    material to make it rigid.
+ Mould held in inverted position and heated to melt wax and permit it to leak
    out of the cavity.
+ Mould preheated to high temperatures, to ensure all contaminants are
    eliminated and permits liquid metal to flow into cavity.
+ Mould is broken away from the finished casting and parts are separated from
    the sprue.

*Pros*: Net shape process, wax can be reused. High accuracy and good surface
finish.

*Cons*: Expensive and many steps required.

== Permanent mould casting (steel or cast iron)
Mould is preheated and coated for lubrication & heat dissipation. Cores (if
used) are inserted, and mould is closed. Molten metal poured into mould and
solidifies.

*Pros*: Dimensional control and surface finish. Rapid solidification results in
finer grain structure, so casting is stronger. Mould can be reused. Economical
for large production. Thin sections possible.

*Cons*: Generally limited to metals of lower melting point. Simpler part
geometries compared to sand casting because of the need to open mould. Expensive
mould.

*Die casting*: High pressure to force metal into die cavity.

*Hot chamber die casting*: Casting metals: zinc, tin, lead, and magnesium. Low
melting point, heated chamber.

Steps: With the die closed and plunger withdrawn, molten metal flows into
chamber. Plunger force metal flow to die under constant pressure. Withdraw ram,
open die, eject parts.

*Cold chamber die casting*: Casting metals: aluminium, brass, and magnesium
alloys. Unheated chamber.

Steps: With the die closed and ram withdrawn, molten metal is ladled (thus extra
time) into chamber. Ram forces metal to flow into die, maintaining pressure
during cooling and solidification. Withdraw ram, open die, eject parts.

*Pros*: Economic for large production, good accuracy, thin section possible,
rapid cooling provides small grain size and good strength.

*Cons*: Limited to metal with low melting point, and part geometry must allow
removal from the die cavity.

= Metal forming
*Sheet metal working*: Thickness of sheet metal is #qty[0.4][mm] to #qty[6][mm].
Larger thickness is a plate.

*Rolling*: Hot rolling is above $T_"recrys"$ (recrystallisation temperature).
Cold rolling is below $T_"recrys"$.

2/3-high rolls: Used for hot rolling (3 reverse direction).

4-high rolls: Smaller diameter rolls, lower rolling force, reduce spreading.
Usually cold rolling (planetary).

*Rotary tube piercing*: Hot-working process for long, thick-walled seamless
pipes. Round bar is subjected to radial compressive forces and develops tensile
stresses at its centre, forming a cavity. Internal mandrel expands hole and
defines tube bore.

== Sheet metal forming
Bending operations, deep or cup drawing, shearing processes like blanking and
punching.

*Pros*: Strong, dimensionally accurate, good surface finish, low cost, mass
production.

*Rollover*: Depression made by punch.

*Burnish*: Smooth region due to penetration.

*Fracture zone*: Quite rough surface due to fracture.

*Burr*: Sharp corner edge due to elongation of metal.

*Shearing*: Separate large sheets.

*Blanking*: Cut part perimeters from sheet metal.

*Punching*: Make holes. Clearance usually 2-10% thickness.

*Clearance*: As $c$ #sym.arrow.t, sheet pulled into clearance zone instead of
sheared, gives rougher edges, burr height #sym.arrow.t, punch force
#sym.arrow.b, die wear #sym.arrow.b.

$c = a t$, $a$ is allowance, and $t$ is thickness.

#table(
    columns: 2,
    table.header([*Metal group*], [*Allowance ($a$)*]),

    [1100S and 5052S aluminium alloys, all tempers], [0.045],

    [
        2024ST and 6061ST aluminium alloys; brass, soft cold rolled steel, soft
        stainless steel
    ],
    [0.060],

    [Cold rolled steel, half hard; stainless steel, half hard and full hard],
    [0.075],
)

When metal hardness *increases*, clearance required *increases*.

#table(
    columns: 2,
    table.header([*Insufficient clearance*], [*Excessive clearance*]),

    [
        + Fracture lines passing each other.
        + Double burnishing and larger cutting force.
    ],

    [
        + Metal becoming pinched between the cutting edges.
        + Excessive or oversized burrs.
    ],
)

*Round blank $D_b$*:
#grid(
    columns: 2,
    column-gutter: 2em,
    [Punch diameter: $D_b - 2c$], [Blanking die diameter: $D_b$],
)

*Round hole $D_h$*:
#grid(
    columns: 2,
    column-gutter: 2em,
    [Punch diameter: $D_b - 2c$], [Hole die diameter: $D_b$],
)

*Angular clearance*: Allow blank to drop ($0.25 degree$ to $1.5 degree$).

*Max punch force*: $F = 0.7 ("UTS") T L = S T L$

$S$ is shear strength, $T$ is sheet thickness, $L$ is length of shear
(perimeter), UTS is ultimate tensile strength.

*Changing punch* reduces cutting force.
#cimage("./images/bevel-punch-and-die.png")

=== Other shearing operations
*Shaving*: Extra material removed to get straight edge (small clearance between
punch and die).

*Fine blanking*: Blanking with a cushion below and pressure pads.

== Bending

#grid(
    columns: 2,
    column-gutter: 0em,
    align: left,

    [
        *Bend allowance, $L_b$*

        $L_b = alpha (R + k T)$

        $alpha + A' = 180 degree$

        $k = cases(0.33 "if" R < 2T, 0.5 "if" R >= 2T)$

        - $alpha$ is the bend angle (#unit[rad])
        - $R$ is the bend radius
        - $T$ is the sheet metal thickness
    ],
    image("./images/bending-diagram.png"),
)

*Minimum bend radius*: $epsilon = (frac(2R, T) + 1)^(-1)$

As $R/T$ #sym.arrow.b, tensile strain at outer fibre #sym.arrow.t, causing
cracks. Cracks first occur at min bend radius. Usually expressed in terms of
$T$.

*Anisotropy*: Different behaviour in diff directions, acquired during sheet
metal processing (rolling).

+ Preferred grain direction caused by compression of equiaxed grains, boundaries
    align horizontally (preference in grain orientation)
+ Mechanical fibering: Alignment of impurities, inclusions, and voids during
    deformation. Bending should be done perpendicular to rolling direction

*Springback*: Elastic recovery after load removed, bend angle #sym.arrow.b, bend
radius #sym.arrow.t

$R_i/R_f = 4 (frac(R_i Y, E T)) - 3 (frac(R_i Y, E T)) + 1$

- $R_i$ is the initial bend radius, $R_f$ is the final bend radius.
- $Y$ is the yield stress, $E$ is the elastic modulus.

Compensation: *Over-bending*, *bottoming* (high compressive pressure causes
plastic deformation to reduce thickness at bend area) and *stretch bending*
(sheet stretched past yield stress then bent). Including ribs or darts can
increase stiffness and #sym.arrow.b springback.

#grid(
    columns: 3,

    image("./images/spring-back-compensation-overbending.png"),
    image("./images/spring-back-compensation-bottoming.png"),
    image("./images/spring-back-compensation-stretch-bending.png"),

    [*Over-bending*: Require bend angle of $90 degree$],
    [
        *Bottoming*: High compressive pressure causes plastic deformation and
        reduces thickness at bend area.
    ],
    [
        *Stretch bending*: Sheet metal is stretched beyond its yield stress and
        is bent over the punch.
    ],
)

#{
    set image(height: 6em)

    grid(
        columns: 2,

        grid.header([*V-die bending*], [*Wiping die*]),

        image("./images/bending-v-die-force.png"),
        image("./images/bending-wipe-force.png"),

        [Simple cheap, acute and obtuse angle],
        [Complicated, high quantity, precise],
    )
}


*Bending force*: $P = frac(k ("TS") L T^2, W)$
- $k$ is 1.33 for V-die, and 0.33 for wiping die
- $L$ is the bend length, and $"TS"$ is the tensile strength
- $T$ is the thickness of the workpiece
- $W$ is the die opening or width of the V-die

*Deep drawing*: Clearance is $1.1T$
+ Blank holder holds sheet metal in place.
+ Punch moves down, bends sheet metal.
+ Straighten to form cup wall, high tension along walls and high compression in
    flange, causes tearing and wrinkling respectively.

*Blank holder force*: Too high #sym.arrow tearing, too low #sym.arrow wrinkles.

*Drawability*: $"DR" < 2.0$, $r < 0.5$, $t/D_b > 0.01$

*Drawing ratio (DR)*: $frac("Blank diameter", "Punch diameter") = D_b/D_p < 2.0$

*Reduction ($r$)*: $frac(D_b - D_p, D_b) < 0.5$

*Thickness to diameter ratio*: $t/D_b > 0.01$

$t/D_b$ #sym.arrow.b, tendency to wrinkle #sym.arrow.t

If drawability conditions are not met, redrawing is required, with annealing
between each drawing.

#grid(
    columns: 2,

    grid.header([*Redrawing*], [*Reverse (less force)*]),

    image("./images/deep-drawing-redrawing.png"),
    image("./images/deep-drawing-reverse-drawing.png"),
)

#cimage("./images/deep-drawing-defects.png")

Common defects in drawn parts: (a) wrinkling occurs either in the flange or (b)
in the wall (due to compression), (c) tearing (due to high tensile stresses,
causing thinning and failure), (d) earing (due to anisotropy), and (e) surface
scratches (due to poor lubrication, punch/die not smooth).

*Blank size*: Initial blank volume = final blank volume of cup.

*Drawing force*: $F = pi D_p t ("TS") (D_b/D_p - 0.7)$
- $D_b$ = Starting blank diameter, $t$ = Original sheet thickness

*Blank holder force*:

$F_h = 0.015 Y pi {D_b^2 - (D_p + 2.2t + 2 R_d)^2}$
- $R_d$ is the die corner radius

= Metal machining
*Pros*: Good dimensional accuracy and surface finish.

*Cons*: Waste materials, takes a long time to shape.

*Cutting models*: Oblique ($< 90 degree$) and Orthogonal ($90 degree$)

#grid(
    columns: 2,
    align: (left + horizon, center + horizon),

    [
        - $V$ is the cutting velocity
        - $alpha$ is the rake angle
        - $phi.alt$ is the shear angle
        - $t_0$ is the undeformed thickness
        - $t_c$ is the chip thickness
    ],
    image("./images/orthogonal-cutting-model.png"),
)

*Merchant's equation*: $phi.alt = 45 degree + alpha/2 - beta/2$

Assumed that $phi.alt$ adjusts itself to give minimum cutting force. Use only
when given. $beta$ is the friction angle.

#grid(
    columns: 2,
    [
        $R = sqrt(F_c^2 + F_t^2)$

        Friction coeff: $mu = F/N = tan beta$

        $"Shear stress" = F_s/A_s = frac(F_s sin phi.alt, w t_0)$

        Cutting ratio: $r = t_0/t_c$

        Shear angle: $tan phi.alt = frac(r cos alpha, 1 - r sin alpha)$
    ],
    image("./images/force-circle-diagram-2.png", height: 10em),
)

*Power and material removal rate (MRR)*
#grid(
    columns: 2,
    align: left,

    [
        $F_c V = F_s V_s + F V_c$ \
        $"MRR" = w t_0 V$ \
        $"Specific energy" = P/"MRR" = frac(F V, "MRR")$
        - $F_c$ is cutting, $F_s$ is shearing
        - $F V_c$ is friction
        - $V_c$ is chip velocity
        - $w$ is workpiece width
        - $t_0$ is workpiece thickness
        - $V$ is the cutting velocity

    ],
    image("./images/velocity-diagram.png"),
)

*Temperature*: Energy lost converted to heat $=>$ shear zone and tool chip
interface

Temperature #sym.arrow.t:
+ Strength, hardness, wear resistance #sym.arrow.b (cutting tool)
+ Dimensional inaccuracies in workpiece, thermal damage, fail easier.
+ Uneven temps distort machine, difficult to control dimensions (machine tools).

*Cutting fluid*: Lubricant and coolant (oils)

#grid(
    columns: 2,
    align: left,

    [
        *Tool wear*: flank (rubbing of tool and high temps) and crater (high
        temp & chemical affinity with workpiece #sym.arrow use coated with TiN)

        *Signs for replacement*:
        + Obvious tool wear.
        + Workpiece surface finish gets worse.
        + $F_c$ #sym.arrow.t or $T$ #sym.arrow.t significantly.
    ],
    image("./images/tool-wear-on-turning-tool.png"),
)

*Taylor's tool life equation*: $V T^n = C$
- $V$ = Cutting speed, $T$ = Min tool life, $n < 1$, $C$ is a constant

*Good cutting tool material*: Hot hardness, toughness, thermal shock and wear
resistant, chemically stable and inert.

*Types of chips*:
- Continuous: Ductile material, good surface finish, entangles tools. Change
    machining parameters or use chip breaker.
- Discontinuous: Brittle materials, hard impurities, cutting force varies during
    cutting.
- Built-up edge (BUE): Layers of workpiece deposited on tool. BUE #sym.arrow.t,
    tool breaks. Some BUE will be deposited on workpiece surface, poor surface
    finish. BUE also makes tool dull.
- Serrated: Low thermal conductivity and strength decreases with temperature.

*Surface finish factors*: Chip types, feed mark left by cutting and vibration.
Forced vibration from machine tool, chattering is self-excitation vibration from
interaction of cutting process and machine tool. Starts from disturbance in
cutting.

$R_a = frac(f^2, 32 R), R_t = frac(f^2, 8R)$, $R_a/R_t$ #sym.arrow.t, finish
#sym.arrow.b.
- $R_a$ is average derivation from mean, overall surface texture.
- $R_t$ is the distance between highest and lowest peak.

== Turning
$"MRR" = "Depth of cut" times "Feed" times "Cutting velocity"$

$V = pi D_"avg" N$, $N$ (#unit[rev min^-1]), $f$ (#unit[mm rev^-1]),
$D_"avg" = frac(D_i + D_f, 2)$

Cut at high $f$, then lower $f$ for good surface finish.

== Drilling
$"MRR" = frac(pi D^2, 4) f N$, $f$ is feed. Cutting time
$t = frac("Length cut", f N) = frac(l, f N)$

$"Drill tip length," A = 1/2 D tan (90 degree - theta/2)$, $theta$ is the drill
angle.

$"Power" = "Torque" times "Rotational speed" space (#unit[rad s^-1])$

== Milling
#grid(
    columns: 2,
    align: left,

    [
        Slab milling, face milling, end milling.

        Conventional milling is counter clockwise.

        Climb milling is clockwise.

        Chip affects:
        + Surface finish of workpiece.
        + Cutting operations (tool life, vibration chattering).
    ],

    grid(
        columns: 2,

        grid.header([*Conventional milling*], [*Climb milling*]),

        image("./images/milling-conventional.png"),
        image("./images/milling-climb.png"),
    ),
)

*Conventional*: max thickness at end of cut, does not affect tool life, will
chatter so need clamp workpiece.

*Climb*: max thickness at start of cut (bad), downward cutting force holds
workpiece in place (good), scales will cause cutter damage, high impact forces
require rigid set up.

*Grinding*: Dimensional accuracy and surface finish.

= Metal joining
*Fusion welding*: Melts base metal, sometimes have filler metal (if without, is
autogenous).

*Solid state welding*: No melting of base metal, no filler metal is added.
Pressure with heat, or just pressure.

*Power*: $"Power density" = P/A$

$"Unit energy for melting," U_m = k T_m^2$, $k = 3.33 times 10^(-6)$, T in
#unit[K].

*Heat transfer*: $H R_w = f_1 f_2 E I = U_m ("WVR")$
- $f_1$ is the heat received by workpiece over total heat
- $f_2$ is the proportion of heat received by the work piece used for melting
- $H R_w$ is the heat rate for welding, $E$ is voltage and $I$ is current.

*Welding speed*: $frac(v = f_1 f_2 H R_w, U_m A_w)$
- $A_w$ is the cross-sectional area of the weld

*Welding volume rate*: $"WVR" = frac(H R_w, U_m)$

*Arc welding*: Use electrical arc to heat metal.

#cimage("./images/arc-welding-setup.png")

*Shielding*: Inert gas or flux (flux prevents formation of oxides and provides
protective atmosphere). Stabilises arc, reduce spattering.

*Application of flux*: Coat electrode with flux which melts during welding. Or
flux contained in core of consumable electrode, flux released as it is consumed.

*Electrodes*: Consumable, like welding rod or wire, uses filler metal.
Non-consumable electrodes are like gas tungsten and arc welding, which gradually
deplete.

*Resistance spot welding*: Current flow through cross-section of spot weld,
generate heat with resistance.

*Solid state welding*:
- Roll bonding: Roll metal together with pressure.
- Friction welding: Twist parts in contact to generate heat, narrow heat
    affected zone (HAZ), join dissimilar metals
- Explosive welding: Clad metals over large areas

#grid(
    columns: 2,
    align: left,

    [
        *Weld quality*: In HAZ, microstructural changes to metals that
        experience temperature below melting, usually negative.
    ],
    image("./images/typical-fusion-welded-joint.png"),
)

*Weld defects*: Incomplete fusion due to low quality weld beads, formation of
oxide, incomplete fusion at grooves.

#grid(
    columns: 3,
    image("./images/incomplete-fusion-1.png"),
    image("./images/incomplete-fusion-2.png"),
    image("./images/incomplete-fusion-3.png"),
)

#grid(
    columns: 3,

    grid.header([*Underfill*], [*Undercut + Excessive overlap*], [*Good*]),
    image("./images/poor-weld-profile-underfill.png"),
    image("./images/poor-weld-profile-undercut.png"),
    image("./images/poor-weld-profile-good-weld.png"),
)

*Cracks*:
#grid(
    columns: 2,
    align: left,

    [
        Toe, transverse, underbead, longitudinal, and crater cracks.

        Crackk factors:
        + Thermal stress (temperature gradient)
        + Variation in composition
        + Embrittlement of grain boundaries (segregation)
        + Hydrogen embrittlement
        + Inability to contract
    ],
    image("./images/cracks-in-welded-joints-2.png", height: 12em),
)

*Distortion*: After welding, differential thermal expansion and contraction of
different parts of the welded assembly.

*Brazing*: Filler metal of low melting point ($> 450 degree"C"$), no melting of
base metal, only filler. For metals of poor weldability and ceramics. Increased
contact area is good.

*Soldering*: Brazing but melting point $< 450 degree"C"$. Filler metal called
solder, usually for electronics.

*Adhesive bonding*: Basically glue, need large contact areas for good bond.

= Polymers

*Polymer molecule*: Monomer unit (H-C-H) joined by covalent bonds.

*Linear polymer*: Chains of polymer lying on each other, weak interchain bonds.

*Branched Polymer*: Like a tree (chain packing efficiency #sym.arrow.b)

*Cross-linked polymer*: Adjacent linear chain joined by strong covalent bonds,
achieved by growth at high temps and is irreversible, i.e. rubber.

*Network polymer*: Tri-functional monomer units that form more than 3 covalent
bonds, 3-D network, i.e. epoxies.

*Thermoplastics*: Soften upon heating, made to flow with stress. When cooled,
solid or rubbery solid. Recyclable. Examples: Polystrene, ABS, PVC, acrylic,
polyethylene, and polypropylene.

*Thermosets*: Becomes irreversibly hard or rigid when heated. Chain motion
restricted. Examples: Expoxy and sillicone.

*Amorphous material*: No well defined melting point.

*Can be recycled (reversible)*: Solid $stretch(harpoons.rtlb)_"cool"^"heat"$
Liquid (melt)

*Cannot be recycled (irreversible)*: More brittle, harder, stronger, but better
dimensional stability.

#table(
    columns: 2,
    table.header([*Polymer*], [*Shrinkage (#unit[mm mm^-1])*]),

    [Nylon 6, 6], [0.020],
    [Polyethylene], [0.025],
    [Polystyrene], [0.004],
    [PVC], [0.005],
)

*Elastomers*: Like rubber, linear or cross-linked. Chains extend on deformation
but don’t flow due to cross-links or physical domains. Returns to original shape
on removal of stress.

*Glass transition temperature ($T_g$)*: Temperature that polymer turns rubbery.
Rubbery *above* $T_g$ and brittle like glass *below* $T_g$.
- Easily deformed means low $T_g$.
- Larger molecular weight means $T_g$ #sym.arrow.t.
- Cross-linking will increase $T_g$. Above $T_g$, polymer chains have more
    motion.

*Polymer melts*: Hot thermoplastic acts like a liquid.

*Viscosity*: How much a fluid resists flowing freely. Polymers have high
vicoscity. #sym.arrow.t shear rate or temperature, viscosity #sym.arrow.b

*Viscoelasticity*: Exhibits both viscous and elastic behaviour. Polymer melts
are viscoelastic, and need time to react. E.g. die swell extruded polymer
returns to its previous shape.

#cimage("./images/viscoelasticity.png", height: 11.5em)

== Polymer forming processes
Net shape process, less energy than metals, no plating required, unlimited
geometry.

*Casting*: Same as metal.

*Extrusion*:
- Barrel: Electric heater melts feed stock.
- Screw: Feed (pellets), compression (transform into fluid, air extracted,
    material compressed) metering (melt homogenised and pumped through die
    opening)
- Die: Pass through screen pack (filter, build pressure, straighten flow of
    polymer melt)

=== Injection moulding
#image("./images/injection-moulding-components.png")

*Injection system*: Much like extrusion, screw used for mixing and ramming
molten plastic into mould. Contains non-return valves to prevent backflow

*Clamping system*: Holds 2 halves of mould, keeps mould closed during injection
with force

*Moulds*:
- 2 plate, 2 cavities to produce 2 times of expected mould. Oversized to allow
    for shrinkage. Contains ejection system with pins to eject moulded part.
    Cooling system (water circulated) and air vents for evacuation of air.
- 3 plate, uses 3 plates to separate sprue and runner when mould opens. The
    runner and parts disconnect when mould opens, allows automatic operation.

*Hot-runner*: heaters around sprue and runner so no solidification of polymers
(reduce waste)

*Shrinkage*: $"Linear shrinkage" - D_c = D_p + D_p S + D_p S^2$

$D_c$ is the dimension of the cavity, $D_p$ is for moulded part and $S$ is the
shrinkage.

*Factors*:
+ Injection pressure #sym.arrow.t, shrinkage #sym.arrow.b
+ Compaction time #sym.arrow.t, shrinkage #sym.arrow.b
+ Temperature #sym.arrow.t, shrinkage #sym.arrow.b
+ Thicker part, more shrinkage

*Defects*:
- Short shot: Solidified before cavity filled. Increase temperature and pressure
    to fix.
- Flash: Polymer squeeze into parting surface/around ejection pins. Causes:
    large vents/clearance, high injection pressure, temperature too high.
- Sink marks: Moulded section too thick, insufficient material. Increase
    pressure and design similar thickness sections.
- Weld line: Never join fully when polymers meet, increase temperature and
    pressure to fix.

*Compression moulding*: Pellets, compress, hold, open Simpler than injection
mould, no sprue and runner, simpler geometry, mould must be heated. Example:
Socket plug.

*Transfer moulding*: Compression moulding as fluid. Thermoset loaded into
chamber, heated, then pressure applied on soft polymer to flow into heated
mould, cured

- Pot: Charge injected from a pot
- Plunger: injects charge from a heated well


*Compression vs transfer moulding*:
+ Both have unreusable scrap (cull)
+ Transfer moulding more intricate as its fluid, good for moulding with inserts

*Blow moulding*: Thermoplastic only, using air pressure to inflate soft plastic
into mould cavity.
+ Form the starting tube (parison) extrusion/injection
+ Inflation of tube types:
    - Extrusion blow moulding: Parison extruded.
    - Injection blow moulding: Parison injected into mould before blowing.
    - Stretch blow moulding: Injection, stretching (by blowing rod) then blow.

*Thermoforming*: Sheet is heated, placed over mould cavity, and vacuum draws
sheet to form shape, and then cured. *THERMOPLASTICS ONLY*.

#grid(
    columns: 2,
    align: left,

    [
        *Pressure thermoforming*: Done in pressure box to use pressure from
        above to push plastic down.
    ],
    [
        *Mechanical thermoforming*: Positive mould pushes from above. Good
        dimensional control and surface details on both sides, but costly.
    ],

    image("./images/thermoforming-pressure.png"),
    image("./images/thermoforming-mechanical.png"),
)

#grid(
    columns: 4,

    grid.header(grid.cell(colspan: 4)[*Vacuum thermoforming*]),

    image("./images/thermoforming-vacuum-1.png"),
    image("./images/thermoforming-vacuum-2.png"),
    image("./images/thermoforming-vacuum-3.png"),
    image("./images/thermoforming-vacuum-4.png"),
)


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

// == Solutions to $sin theta = c$
// $alpha = arcsin c$
//
// $theta = cases(2k pi + alpha, (2k + 1) pi - alpha)
// quad "where" k = 0, 1, 2, 3, dots$
//
// $theta = alpha, pi - alpha, 2pi + alpha, 3pi - alpha, dots$

== Surface areas
Cylinder: $2 pi r h + 2 pi r^2$ \
Sphere: $4 pi r^2$

== Volume
Cup: $pi r^2 t + 2 pi r t h$ \
Cylinder: $pi r^2 h$ \
Sphere: $4/3 pi r^3$

== Trigonometric identities

Law of sines: \
$frac(a, sin A) = frac(b, sin B) = frac(c, sin C)$

Law of cosines: \
$a^2 = b^2 + c^2 - 2 b c cos A$

Area of a triangle: \
$A = 1 / 2 a b sin C$

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
