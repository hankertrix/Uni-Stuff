#set page(numbering: "1")
#set heading(numbering: "1.1")
#show link: text.with(blue)
#{
    set document(
        title: "MA2024 Engineering Materials and Manufacturing Processes Notes",
        author: "Hankertrix",
    )
    align(center, text(3em)[*#context document.title*])
    align(center, text(2em)[#context document.author.first()])
    outline()
    pagebreak()
}

// Imports
#import "@preview/fancy-units:0.1.1": qty, unit
#import "@preview/cetz:0.4.2"

// Function definitions
#let cimage(..image_args) = align(center, image(..image_args))
#let bmat = math.mat.with(delim: "[")
#let pmat = math.mat.with(delim: "(")
#let cmat = math.mat.with(delim: "{")
#let amat(..content) = $<mat(..content, delim: #none)>$
#let degreeC = [#sym.degree\C]

= Definitions

== Gases
Atoms or molecules that are *not bound to each other* and are *free to move*
within the space allowed.

They have no structural order and are amorphous.

== Liquids
Unlike gases, atoms or molecules in liquids can interact with each other more
strongly through secondary bounds but *can be easily broken* by heat.

They have no structural order and are amorphous.

== Solids
Atoms and molecules are *held strongly in place* by either primary or secondary
bonds, and are allowed to *undergo thermal motion about their equilibrium
position*.

They can be amorphous or have a structural order.

== Mechanical properties

#align(center, cetz.canvas({
    import cetz.draw: *
    set-style(content: (padding: 0.5em))
    set-style(mark: (symbol: ">"))
    content(
        (-4, 2),
        frame: "rect",
        name: "stiffness",
        align(center)[
            Stiffness \
            Hard to be "deformed"
        ],
    )
    content(
        (4, 2),
        frame: "rect",
        name: "strength",
        align(center)[
            Strength \
            Hard to be "torn apart"
        ],
    )
    content(
        (0, -3),
        frame: "rect",
        name: "toughness",
        align(center)[
            Toughness \
            Hard to be "fractured"
        ],
    )

    line("toughness", "stiffness", name: "metals")
    line("toughness", "strength", name: "polymers")
    line("stiffness", "strength", name: "ceramics")

    content(
        "metals.mid",
        anchor: "east",
        align(center)[
            ⚓ \
            Metals
        ],
    )
    content(
        "polymers.mid",
        anchor: "west",
        align(center)[
            🧴 \
            Polymers
        ],
    )
    content(
        "ceramics.mid",
        anchor: "south",
        align(center)[
            🏺 \
            Ceramics
        ],
    )

    content(
        (0, 0),
        [Composites],
    )
}))

=== Stiffness
Stiffness refers to how difficult it is to deform a material.

=== Toughness
- Toughness refers to how difficult it is to fracture a material, or break it
    into pieces.
- It is defined as the *energy required* to break a *unit volume* of material.

=== Strength
- Strength refers to how difficult it is to tear a material apart.
- It is defined as the *force* needed to be applied to a material to *deform* it
    plastically or permanently.

=== Young's modulus ($E$)
Young's modulus, in #unit[GPa], tells us about the resistance offered by a
material to elastic deformation.

=== Yield strength ($sigma_y$)
Yield strength, in #unit[MPa], is the stress required to initiate plastic (or
permanent) deformation.

=== Ultimate tensile strength ($sigma_u$)
Ultimate tensile strength, in #unit[MPa], is the stress required to break a
tensile bar in 2.

=== Hardness ($H$)
Hardness, in #unit[GPa], is the resistance offered by a material to permanent
indentation.

=== Fracture toughness ($K_"ic"$)
Fracture toughness, in #unit[MPa m^0.5] is a measure of the resistance offered
by a material to cracking.

=== Endurance limit and fatigue crack growth
Endurance limit, and fatigue crack growth properties refer to the material's
resistance to failure under fluctuating (cyclic) loading conditions.

=== Creep properties
Creep properties refer to the material's resistance to time-dependent
deformation at high temperatures.

#pagebreak()

== Short-range order
There is *no structural order (periodicity)* in the arrangement of atoms.

#figure(
    caption: "Amorphous",
    image("./images/amorphous-structure.png", height: 15em),
)

== Long-range order
There is *structural order (periodicity)* in the arrangement of atoms
*throughout* the material.

#align(center, grid(
    columns: 2,
    column-gutter: 0.5em,
    figure(
        caption: "Crystalline",
        image("./images/crystalline-structure.png", height: 15em),
    ),
    figure(
        caption: "Polycrystalline",
        image("./images/polycrystalline-structure.png", height: 15em),
    ),
))

== Crystalline Melt Temperature ($T_m$)
The crystalline melt temperature is the temperature at which a crystalline solid
melts and becomes a liquid.

== Isotropic
Isotropic means that material properties are *directional*, and tests in
different orientations return *different* results.

== Anisotropic
Anisotropic means that material properties are *non-directional*, and tests in
different orientations return the *same* results.

#pagebreak()

== Unit cell
- The unit cell is the *single basic structural repeat unit* that, when
    duplicated and translated, reproduces the *entire crystal structure*.
- The unit cell represents the symmetry of the crystal structure and contains a
    small group of atoms.
- All atom positions in the crystal are generated by *integer* translation of
    the unit cell distances along each of its edges.
- It is not possible to create a *perfect crystal*.
- *Defects* alter mechanical properties of the material.

#cimage("./images/unit-cell.png", height: 15em)
#cimage("./images/unit-cell-models.png")
#pagebreak()

== Coordination number (CN)
The coordination number of an atom is the number of *nearest neighbouring atoms
touching it*.

== Atomic packing fraction (APF)
The atomic packing fraction is given as:
$ "APF" = "Volume of atoms in a unit cell"/"Total unit cell volume" $

=== Square closed packed example
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        - Because the atoms are square closed packed, $a = 2r$.
        - Volume of the cube:
            $ V_c = a^3 = (2r)^3 = 8r^3 $
        - Number of atoms per unit cell: $n = 8 times 1/8 = 1$
        - Total volume of atoms in unit cell:
            $ V_s = n times 4/3 pi r^3 $
        - Atomic packing fraction:
            $ "APF" = V_s/V_c = frac(4 pi r^3, 3) times frac(1, 8r^3) = pi/6 $
            $ "APF" approx 0.52 "or" 52% $
    ],
    image("./images/apf-square-close-packed.png", height: 15em),
)

=== Face-centred cubic example
#grid(
    columns: 2,
    align: horizon,
    column-gutter: 3em,
    [
        - Volume of the cube:
            $ V_c = a^3 = (2 sqrt(2) r)^3 $
        - Number of atoms per unit cell: $n = 8 times 1/8 + 6 times 1/2 = 4$
        - Total volume of atoms in unit cell:
            $ V_s = n times 4/3 pi r^3 $
        - Atomic packing fraction:
            $
                "APF" = V_s/V_c =
                frac(4 times 4/3 pi r^3, (2 sqrt(2) r^3)) approx 0.74
            $
    ],
    image("./images/apf-face-centred-cubic.png", height: 15em),
)

== Density of a unit cell ($rho_c$)
The density of a unit cell is given by:
$ rho_c = frac(n times A_m, N_a times V_c) $

Where:
- $n$ is the number of atoms per unit cell
- $A_m$ is the atomic mass of the atom
- $N_A$ is Avogadro's number
- $V_c$ is the volume of the unit cell

#pagebreak()

=== Example 1
For Pb (FCC):
- Atomic radius: #qty[0.175][nm]
- Atomic weight: #qty[207.2][g mol^-1]

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        $ R = a/sqrt(8) $

        Unit cell volume ($V_c$) is:
        $
            V_c = a^3 & = R^3 8 sqrt(8) \
                      & = (0.175 times 10^(-9))^3 times 8 sqrt(8) \
                      & = 1.213 times 10^(-28) #unit[m^3]
        $

        The density ($rho_c$) is:
        $
            rho & = frac(n A_m, N_a V_c) \
                & = frac(
                      4 times 207.2,
                      1.213 times 10^(-28) div (10^(-2))^3
                      times 6.023 times 10^(23)
                  ) \
                & = #qty[11.34][g cm^3]
        $
    ],
    image("./images/density-calculation-face-centred-cubic.png"),
)

=== Example 2
For Po (SC):
- Atomic radius: #qty[0.168][nm]
- Atomic weight: #qty[208.982][g mol^-1]

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        $ r = 1/2 a $

        Unit cell volume ($V_c$) is:
        $
            V_c = a^3 & = (2r)^3 \
                      & = (2 times 1.68 times 10^(-8))^3 \
                      & = 0.38 times 10^(-22) #unit[cm^3]
        $

        The density ($rho_c$) is:
        $
            rho & = frac(n A_m, N_a V_c) \
                & = frac(
                      1 times 208.982,
                      0.38 times 10^(-22) times 6.023 times 10^(23)
                  ) \
                & = #qty[9.132][g cm^3]
        $
    ],
    image("./images/apf-square-close-packed.png"),
)

#pagebreak()

== Enthalpy ($H$)
Enthalpy is the energy-cost to break atomic bonds and form a defect.

#cimage("./images/crystal-defects-higher-energy.png", height: 10em)

== Entropy ($T S$)
Entropy is the energy associated with the creation of states, which is the
configuration of the atoms in the lattice.

#cimage("./images/crystal-defects-more-states.png", height: 10em)

== Hooke's law
$ F = - k x $

Where:
- $F$ is the force (#unit[N])
- $x$ is the elongation (#unit[m])
- $k$ is the spring constant (#unit[N m^-1])

== Stress ($sigma$)
$ sigma = F/A $

Where:
- $F$ is the force
- $A$ is the cross-sectional area

Stress is normalised by the cross-sectional area.

=== Stress in terms of strain
$ sigma = E epsilon $

Where:
- $sigma$ is the stress
- $E$ is the Young's modulus
- $epsilon$ is the strain

== Strain ($epsilon$)
$ epsilon = frac(L - L_0, L_0) = frac(Delta L, L_0) $

Where:
- $Delta L$ is the elongation
- $L_0$ is the original length

Strain is to make elongation dimensionless, as it is a percentage of elongation.

== Solution
A solution can be a solid, liquid or gas solution, with only a single phase.

== Mixture
A mixture is a solution that contains more than one phase.

== Solubility limit
The solubility limit is the maximum concentration where only a single-phase
solution exists. It depends on temperature, pressure and composition.

== Components
Components are elements or compounds present in the alloy, like Al and Cu.

== Phases
The physically and chemically distinct regions within a material, like
#sym.alpha and #sym.beta phases.

== Alloys
Alloys are compounds formed by mixing more than one species of atoms.

== Polydisperse
Polydisperse refers to polymers having a range of molecular weight distribution,
and that not all polymeric chains have the same length.
#cimage("./images/polydisperse.png")
#pagebreak()

== Plastics
Plastics refer to *plastic formulation*, which are *polymers with additives*.
#cimage("./images/plastic-formulation.png", width: 80%)

== Reptation
Reptation refers to the ability of materials to move or slide next to each
other.
#cimage("./images/thermoplastics-reptation.png", height: 10em)

== Shear-thinning (pseudoplastic fluid)
Shear-thinning refers to the phenomenon of viscosity decreasing with shear rate.

== Viscoelasticity
Viscoelasticity refers to the phenomenon of fluids requiring a bit of time to
react when stress is applied to them.

== Parison
A parison is the starting tube used in blow moulding to mould thermoplastics.
#cimage("./images/blow-moulding-parison.png", height: 10em)

=== Metal casting mould terminology
#cimage("./images/metal-casting-mould-types.png")

==== Cope
The cope is the upper half of the mould.

==== Drag
The drag is the bottom half of the mould.

==== Flask
The flask is the box that contains the mould.

==== Parting line
The parting line is the line that separates the 2 halves of the mould.

== Faying surface
A faying surface is one of the surface that are in contact at a joint.

#pagebreak()

= Crystalline solids

== Overview
#cimage("./images/overview-of-crystalline-solids.png")

== Examples of crystalline solid structures
#cimage("./images/solid-crystalline-structures-example.png")

== Examples of amorphous solid structures
#cimage("./images/solid-amorphous-structures-example.png")

== Crystalline versus amorphous solids
All crystalline materials are solids, but *not all solid materials are
crystalline*.

=== Crystalline and polycrystalline solids (All 3 classes of materials)
Solids with long-range 3D ordered (periodicity) arrangement of atoms or
molecules in the material structure.

=== Amorphous solids
Short range order (no periodicity) arrangement of atoms or molecules in the
material structure.

=== Semi-crystalline solids (Ceramics and polymers)
An intermediate between crystalline and amorphous solids. They either have:
+ A crystalline phase dispersed in amorphous regions.
+ Or an amorphous phase surrounded by crystalline regions.

#pagebreak()

== Packing types

=== 1D close packing
There is only 1 way of arranging the atoms.

#cimage("./images/coordination-number-1d-close-packing.png")

=== 2D close packing
Close packing in 2D can be achieved by *stacking rows of 1 dimensionally close
packed atoms*.

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        *Square close packing*

        - Rows of atoms stacked directly above each other.
        - Stacking arrangement: #text(red)[*AAA*]
        - Coordination number: *4*

        #image("./images/square-close-packing.png")
    ],
    [
        *Hexagonal close packing*

        - Rows of atoms staggered when stacked on each other.
        - Stacking arrangement: #text(red)[*ABA*]
        - Coordination number: *6*

        #image("./images/hexagonal-close-packing.png")
    ],
)

#pagebreak()

=== 3D close packing

==== 3D square close packing
- 3D square close packing is stacking 2D squares close packed directly.
- The atoms are aligned vertically and horizontally (*AAA*) stacking.
- Coordination number: *6*.

#cimage("./images/3d-square-close-packing.png")

==== 3D hexagonal close packing
- The 3D hexagonal close packing is an ABA-stacked structure.
- Coordination number: *12*

#cimage("./images/3d-hexagonal-close-packing.png")
#pagebreak()

=== Hexagonal close packing (HCP) vs face-centred packing (FCC)
- Face-centred packing is very similar to hexagonal close packing, but one of
    the layers is rotated.
- Despite the difference in the final crystal structure, both have the same
    coordination number of *12*.

#grid(
    columns: 2,
    image("./images/hexagonal-close-pack-stacking.png"),
    image("./images/face-centred-cubic-stacking.png"),
)

== Single crystal versus polycrystalline structure

=== Single crystal solids
#cimage("./images/single-crystal-structure.png", height: 15em)

- There is only one grain, and the boundaries are only at the surfaces of the
    crystal.
- There is perfect 3D periodic arrangement of the atoms throughout the entire
    structure.
- All unit cells interlock in the same way and have the *same crystallographic
    orientation*.
- Varying degrees of *anisotropy (direction-dependent material properties)*
    depending on the symmetry of the crystal structure.

=== Polycrystalline solids
#grid(
    columns: 2,
    column-gutter: 3em,
    align: center + horizon,
    image("./images/polycrystalline-structure.png"),
    image("./images/polycrystalline-metal-micrograph.png"),
)

- Polycrystalline are solids made from many *crystals or grains*.
- *Grain boundaries* are formed where crystals meet.
- Random crystallographic orientations, as each grain has its own
    crystallographic orientation.
- Tend to be *isotropic (direction-dependent material properties)* due to random
    crystallographic orientation of individual grains.

#pagebreak()

== Physical differences

=== Amorphous
- More spaces between atoms and molecules, resulting in *lower* packing
    efficiency and hence a lower density.
- Lower strength.
- Isotropic, which means they have direction *independent* properties.
- Heating and cooling is reversible, and they have *no-phase change* when heated
    or cooled. An *amorphous* solid turns into an *amorphous* liquid, and vice
    versa, when heated or cooled.

=== Crystalline
- There is closer packing between atoms, ions and molecules, resulting in
    *higher* packing efficiency and hence a higher density.
- Higher strength.
- Anisotropic, which means they have direction *dependent* properties.
- Heating and cooling is reversible, and they have a *phase change* from
    *crystalline* solid to *amorphous* liquid, and vice versa, when heated or
    cooled.

== Crystalline structures
- Atoms arranged in periodic arrays (repeated) over large atomic distances.
- Long-range order (LRO) exists.
- Upon solidification, atoms will position themselves in repetitive 3D pattern,
    in which an atom is bonded to its nearest-neighbour atoms.
- For materials that do not crystallise, LRO is absent, and the structure is
    amorphous or non-crystalline.

=== Overview of crystal systems
#table(
    columns: 4,
    align: center + horizon,
    table.header([*Crystal System*], [*Axis*], [*Angles*], [*Unit Cell*]),

    text(red)[*Cubic*],
    $a = b = c$,
    $alpha = beta = gamma = 90 degree$,
    image("./images/cubic-unit-cell.png"),

    [Tetragonal],
    $a = b != c$,
    $alpha = beta = gamma = 90 degree$,
    image("./images/tetragonal-unit-cell.png"),

    [Orthorhombic],
    $a != b != c$,
    $alpha = beta = gamma = 90 degree$,
    image("./images/orthorhombic-unit-cell.png"),

    text(red)[*Hexagonal*],
    $a = b != c$,
    $alpha = beta = 90 degree, gamma = 120 degree$,
    image("./images/hexagonal-unit-cell.png"),

    [Rhombohedral],
    $a = b = c$,
    $alpha = beta = gamma != 90 degree$,
    image("./images/rhombohedral-unit-cell.png"),

    [Monoclinic],
    $a != b != c$,
    $alpha = gamma = 90 degree != beta$,
    image("./images/monoclinic-unit-cell.png"),

    [Triclinic],
    $a != b != c$,
    $alpha != beta != gamma = 90 degree$,
    image("./images/triclinic-unit-cell.png"),
)

== Crystal structures of metals
- *No* restrictions on the number and position of the nearest-neighbour atoms in
    metallic crystals (*metallic bonding*).
- *Dense* atomic packing for most metallic structures.
- Typically, only one element is present, so all atomic radii are the same.
- Metallic bonding is not directional.
- Nearest neighbour distances tend to be small to lower bond energy.
- Metals fall into 3 basic categories:
    - Simple cubic (not very common)
    - *FCC* (Face Centred Cubic)
    - *BCC* (Body Centred Cubic)
    - *HCP* (Hexagonal Close Packed)

=== Simple cubic structure (SC)
- A cubic unit cell with atoms located at the corners only.
- *One* atom per unit cell $(1/8 times 8 = 1)$.
- It is an *AAA* square packing structure.

#grid(
    columns: 2,
    image("./images/simple-cubic-unit-cell.png"),
    image("./images/simple-cubic-aaa-packing.png"),
)

#pagebreak()

=== Body-centred cubic structure (BCC)
- A cubic unit cell with atoms located at all 8 corners and a single atom in
    cube centre.
- The centre and corner atoms touch each other along cube diagonals.
- Cube edge length ($a$) and inter-atomic radius ($R$) are related by:
    $ a = frac(4R, sqrt(3)) $
- *2* atoms per unit cell $(1/8 times 8 + 1 = 2)$.
- Coordination number is 8.
- APF is 0.68.
- Body-centred cubic is *not* a closed packed system.
- Examples of metals with BCC are: Cr, W, Fe (#sym.alpha), Mo, V, Nb.

#grid(
    columns: 2,
    align: center + horizon,
    column-gutter: 3em,
    image("./images/body-centred-cubic-unit-cell.png"),
    image("./images/body-centred-cubic-packing.png"),
)

#pagebreak()

=== Face-centred cubic (FCC)
<fcc>
- A cubic unit cell with atoms located at the corners and centres of all cube
    faces.
- Atoms touch each other across face diagonal.
- Cube edge length ($a$) and atomic radius ($R$) are related by:
    $ a = 2R sqrt(2) $
- *Four* atoms per unit cell $(8 times 1/8 + 6 times 1/2)$.
- Coordination number is 12.
- APF is $frac(4 times 4/3 times pi R^3, a^3) = pi/(3 sqrt(2)) = 0.74$.
- It is an *ABC* hexagonal packing structure.
- Examples of metals with FCC are: Al, Ni, Cu and Au.

#grid(
    columns: 2,
    column-gutter: 3em,
    image("./images/face-centred-cubic-unit-cell.png"),
    image("./images/face-centred-cubic-abc-packing.png"),
)

=== Hexagonal closed-packing structure (HCP)
- Metallic structure with hexagonal unit cell.
- The ratio $c/a < 1.633$.
- Coordination number is 12.
- APF is 0.74, which is the same as #link(<fcc>)[FCC].
- The hexagon plane is the "basal plane".
- It is an *ABA* hexagonal packing structure.

#cimage("./images/hexagonal-closed-packing-unit-cell.png", height: 20em)
#pagebreak()

=== Crystal structures of various metals
#table(
    columns: 3,
    table.header([*Metal*], [*Crystal structure*], [*Radius (#unit[nm])*]),
    [Al], [FCC], [0.1431],
    [Cd], [HCP], [0.1490],
    [Cr], [BCC], [0.1249],
    [Cu], [FCC], [0.1278],
    [Ti (a)], [HCP], [0.1445],
    [Ag], [FCC], [0.1445],
    [Ni], [FCC], [0.1246],
    [Fe], [BCC], [0.1241],
)

== General description of crystalline solids
- A crystalline material has a *long range 3D* periodic or regular arrangement
    of structural units made up of atoms, ions or molecules.
- The periodicity of these structural units can be described by a *network of
    points in space* called the lattice.
- A 3-dimensional regular array of points is used to describe the structure of a
    crystal.

#cimage("./images/crystalline-structure-3d-array.png", height: 25em)

$ r_"uvw" = v_b + u_a + w_c $

== Crystallographic coordinates
- A set of *3 numbers or indices* are used to describe the following
    crystallographic parameters:
    - Point coordinates
    - Crystallographic direction
    - Crystallographic planes

== Point coordinates
- The location of any atom in a unit cell is given by its coordinates. These
    coordinates are the distances from the $bold(x)$, $bold(y)$, and $bold(z)$
    axes in terms of the lattice vectors $bold(a)$, $bold(b)$, and $bold(c)$.
- For a cubic crystal system, we are only concerned with the lattice parameter
    $bold(a)$ (as $bold(a) = bold(b) = bold(c)$)

=== Example 1
#cimage("./images/point-coordinates-example-1.png")
- The point coordinates for a unit cell *centre* are
    $(a/2, b/2, c/2) = (1/2, 1/2, 1/2)$.
- The point coordinates for a unit cell corner are $(1, 1, 1)$ or 111.
- $a$, $b$, and $c$ are also known as the *unit cell parameters* that describe
    the length of edges $a$, $b$ and $c$.

=== Example 2
#cimage("./images/point-coordinates-example-1.png")

Point is located at $(a/2, b/3, c/2)$. The coordinates of the point are
$(1/2, 1/3, 1/2)$.

#pagebreak()

= Crystallographic directions

== Definition
- Crystallographic direction is a *vector* connecting the *coordinate origin and
    a specific point of a unit cell*.
- The vector is defined by 3 direction indices *$bmat(u, v, w)$*.

== Rules for determining indices
- A vector of desired length is positioned to *pass through the origin of the
    coordinate system*. If it *does not*, we *need to translate* through a
    crystal lattice to *find a new origin*.
- The *length of the vector projection* on each axis is determined in terms of
    *unit cell dimensions* (a, b, c).
- The three numbers obtained are multiplied or divided by a common factor to
    *reduce them to integer values*.
- Notation in the *square bracket* *$bmat(u, v, w)$* defines the desired
    crystallographic direction.

== Rules for the selection of origin
- If there is a *bar* over the number (x, y, or z), it indicates that the
    *coordinates are negative values, like
    $bmat(macron(1), macron(2), macron(3))$*.
- *Need to create a new origin $O$* if there is a negative coordinate.
- Where the coordinate is *negative* the *new* origin for that *coordinate is
    labelled "1"*.
- The *non-negative coordinates* are labelled "0" in the same place as the
    unbarred number.

#table(
    columns: 2,
    table.header([*Direction*], [*New origin, $O'$*]),
    $bmat(1, 2, 3)$, $ x = 0, y = 0, z = 0 $,
    $bmat(macron(1), 1, 0)$, $ x = 1, y = 0, z = 0 $,
    $bmat(macron(2), macron(1), macron(2))$, $ x = 1, y = 1, z = 1 $,
)

=== Possible scenarios
#table(
    columns: 2,
    table.header(
        [*Indices given, so draw direction*],
        [*Direction drawn, so specific indices*],
    ),
    [
        - Select origin. Assign a new origin if any coordinate is negative.
        - Reduce the maximum number to 1.
        - Locate the vector direction from the origin or the new origin.
        - Draw.
    ],
    [
        - Select origin. The origin should be where the vector starts.
        - Find the coordinates to the end point of the vector from the origin.
        - Reduce values to whole numbers.
        - Place "[ ]" around integers.
    ],
)

#pagebreak()

=== Example 1
Draw direction $bmat(0, 1, 2)$.

#cimage("./images/crystallographic-directions-example-1.png", height: 15em)

Steps:
+ No negative numbers, so no change of origin.
+ Reduce the largest number to "1".
    $ bmat(0, 1, 2) -> 0, 1/2, 1 $
+ Locate $x = 0, y = 1/2, z = 1$.
+ Draw from the origin at $(0, 0, 0)$ to $(0, 1/2, 1)$ in the unit cell.

=== Example 2
Draw direction $bmat(macron(1), 3, 3)$.

#cimage("./images/crystallographic-directions-example-2.png", height: 15em)

Steps:
+ Negative number, so change to a new origin, $O'$:
    $ "New origin," O': x = 1, y = 0, z = 0 $
+ Reduce the largest number to "1".
    $ bmat(macron(1), 3, 3) -> -1/3, 1, 1 $
+ Locate $x = -1/3, y = 1, z = 1$.
+ Draw the vector from the new origin $O'$ at $(1, 0, 0)$ to $(-1/3, 1, 1)$ in
    the unit cell.

=== Example 3
Determine the indices of the vector:

#cimage("./images/crystallographic-directions-example-3.png", height: 15em)

Steps:
+ The vector starts from the origin $(0, 0, 0)$, so there is no need to relocate
    the origin.
+ Find coordinates from the tail of the vector with respect to the origin to the
    head of the vector, $(x, y, z)$
    $ x = 1/2, quad y = 1, quad z = 1/2 $
+ Eliminate fractions:
    $ x = 1, quad y = 2, quad z = 1 $
+ Square brackets on indices, $bmat(1, 2, 1)$.

=== Example 4
Determine the indices of the vector:

#cimage("./images/crystallographic-directions-example-4.png", height: 15em)

Steps:
+ Vector does not start from the origin $(0, 0, 0)$, so we need to *relocate the
    origin to $O'$*, i.e. where the tail of the vector is.
+ Label $O'$ and the new axes $x'$, $y'$, and $z'$.
    $ x = 1, quad y = -1, quad z = 1 $
+ Find coordinates from vector tail at $O'$ to head direction $x, y, z$.
+ Direction is $bmat(1, 1, 1)$.

== Families of directions in a unit cell
- Family of crystallographic directions in a crystal system are a set of
    directions that are identical, in the crystallographic sense.
- Members of the same crystallographic direction will have the same properties,
    such as the packing density, mechanical and physical properties.
- These directions must be *unique* in the unit cell directions to be considered
    equivalent. *Parallel directions are not unique*.
- In a cubic system, members of a family are given by all possible permutations
    of indices.
- These are denoted by capital integers in angled brackets, i.e. $amat(u, v, w)$

#cimage("./images/families-of-crystallographic-directions.png")

Consider the array of lattice points above:
- The 4 vectors pointing at 4 different directions.
- They are considered *equivalent* because the locations and distance to the
    neighbouring atoms are identical.
- However, this vector in purples is *not equivalent to any of the previous 4*.
    The vector is longer than the others, and has it has a *different
    "environment"*

#pagebreak()

=== Example
Determine the family of crystallographic directions $amat(1, 1, 0)$
#cimage(
    "./images/families-of-crystallographic-directions-example.png",
    height: 20em,
)

#grid(
    columns: 2,
    column-gutter: 1em,
    row-gutter: 1em,
    $bmat(1, 1, 0)$, $bmat(macron(1), 1, 0)$,
    $bmat(1, 0, 1)$, $bmat(macron(1), 0, 1)$,
    $bmat(0, 1, 1)$, $bmat(0, macron(1), 1)$,
)

= Crystallographic planes

== Miller indices
Miller indices are symbolic *vector representation for the orientation* of an
atomic *direction* or *plane* in a crystal lattice.

#cimage("./images/miller-indices-for-a-direction.png", height: 20em)

Miller indices for this vector $bmat(1, 1, 1)$. The "[ ]" indicates that it is a
direction vector.

== Definition
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        - Any set of parallel and equally spaced planes that pass through the
            centres of atoms in crystals. No centres are situated in between the
            planes.
        - The distance between successive planes in a set depends on their
            direction in relation to the arrangement of atomic centres.
        - Crystallographic planes are described using the form $pmat(h, k, l)$,
            where $h$, $k$, and $l$ are the Miller indices and the parentheses
            is the notation for the planes.
    ],
    image("./images/crystallographic-planes.png"),
)

Essentially, the $pmat(h, k, l)$ representation of the plane is the *normal
vector* to the plane.

== Importance
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        - Mechanical deformation of metals are highly dependent on the sliding
            of planes of atoms. The sliding occurs preferentially along specific
            crystallographic planes depending on the crystal structure.
        - In some crystalline solids, the transportation of heat or electrons
            are highly dependent on a particular plane whereby its more
            conductive in one and not the other.
    ],
    image("./images/crystallographic-planes-fcc-and-bcc.png"),
)

== Determining miller indices $pmat(h, k, l)$ for given planes
Steps:
+ The *plane cannot touch the origin*, so choose the closest corner.
+ *Choose origin $O$* in a unit cell, or a new $O'$ with axes $x'$, $y'$ and
    $z'$.
+ Find the intercepts:
    - From $O$ or $O'$ to $a$ intercept.
    - From $O$ or $O'$ to $b$ intercept.
    - From $O$ or $O'$ to $c$ intercept.
+ *Take reciprocals* of intercept positions.
+ Clean-up:
    - Reduce multiples.
    - Eliminate fractions.
+ Put the bar ($macron$) above *negative integers* in the indices.
+ Place *parentheses* around the integers.

=== Example 1
#cimage("./images/crystallographic-planes-example-1.png", height: 20em)

The plane cannot touch the origin, so choose the closest corner. The plane above
does not touch the origin, and its closest origin is $O$.

#table(
    columns: 4,
    align: center + horizon,
    table.cell(align: left)[*Choose origin*], [0], [0], [0],
    table.cell(align: left)[*Unit cell*], [a], [b], [c],
    table.cell(align: left)[*Intercept*], [1], [1], [1],
    table.cell(align: left)[*Reciprocal*], [1], [1], [1],
    table.cell(align: left)[*Miller indices*], [1], [1], [1],
)

Crystal plane is $pmat(1, 1, 1)$

=== Example 2
#cimage("./images/crystallographic-planes-example-2.png")

This plane does not touch the origin.

#table(
    columns: 4,
    align: center + horizon,
    table.cell(align: left)[*Choose origin ($O'$)*], [1], [1], [0],
    table.cell(align: left)[*Unit cell*], [a], [b], [c],
    table.cell(align: left)[*Intercept*], [-1], [$-1/2$], [1],
    table.cell(align: left)[*Reciprocal*], [-1], [-2], [1],

    table.cell(align: left)[*Miller indices*],
    [$macron(1)$],
    [$macron(2)$],
    [1],
)

$ O': x' = 1, y' = 1, z' = 0 $

Crystal plane is $pmat(macron(1), macron(2), 1)$.

#pagebreak()

=== Example 3: Draw the plane given the indices $pmat(0, 1, 1)$
Steps:
+ No negative indices, select the origin at $(0, 0, 0)$.
+ Enter the miller indices given in the table $pmat(0, 1, 1)$.
+ Mark the intercepts along $x$, $y$, and $z$ axes.
    $ x = oo space ("i.e. parallel to" x"-axis") $
    $ y = 1, z = 1 $
+ Draw the plane by connecting the intercepts.

#table(
    columns: 4,
    align: center + horizon,
    table.cell(align: left)[*Choose origin*], [0], [0], [0],
    table.cell(align: left)[*Miller indices*], [0], [1], [1],
    table.cell(align: left)[*Reciprocal*], [$1/0$], [$1/1$], [$1/1$],
    table.cell(align: left)[*Reciprocal value*], [$oo$], [1], [1],
    table.cell(align: left)[*Mark intercept*], [$parallel$], [1], [1],
)

#cimage("./images/crystallographic-planes-example-3.png")

The plane is parallel to the $x$-axis

#pagebreak()

=== Example 4: Draw $pmat(macron(1), 0, 2)$
+ Need new origin $O'$ due to negative index:
    $ O': x' = 1, quad y' = 0, quad z' = 0 $
+ Take *reciprocal of indices* to get $(1/h$, $1/k$, $1/l)$, which are the
    intercepts on the $a$, $b$, and $c$ edges.
    $ "Reciprocal:" (-1/1, 1/0, 1/2) $
+ Mark intercepts along $x$, $y$, and $z$ axes:
    $ a = - 1, quad b = oo, quad c = 1/2 $
+ Draw plane by connecting intercepts.

#cimage("./images/crystallographic-planes-example-4.png")

The plane is parallel to the $y$-axis.

#pagebreak()

== Family of planes
Family of planes are members of planes in the same unit crystal that are
crystallographically equivalent.

Characteristics of equivalent planes:
- Same packing density
- Same atomic environment
- Same mechanical and physical properties
- The Miller indices for the family of planes is shown by the indices enclosed
    without the curly braces $cmat(h, k, l)$

=== Cubic systems
In cubic systems only, the planes having the same indices, regardless of the
order and sign are equivalent.

==== Family of planes $cmat(1, 0, 0)$ in cubic crystal
#grid(
    columns: 2,
    column-gutter: 1em,
    row-gutter: 1em,
    $pmat(1, 0, 0)$, $pmat(macron(1), 0, 0)$,
    $pmat(0, 1, 0)$, $pmat(0, macron(1), 0)$,
    $pmat(0, 0, 1)$, $pmat(0, 0, macron(1))$,
)

6 planes in the $cmat(1, 0, 0)$ family of planes in a cubic crystal system.

==== Family of planes $cmat(1, 1, 0)$ in cubic crystal
#grid(
    columns: 3,
    column-gutter: 1em,
    row-gutter: 1em,
    $pmat(1, 1, 0)$, $pmat(1, 0, 1)$, $pmat(0, 1, 1)$,
    $pmat(macron(1), 0, 1)$, $pmat(macron(1), 0, 1)$, $pmat(0, macron(1), 1)$,
    $pmat(1, macron(1), 0)$, $pmat(1, 0, macron(1))$, $pmat(0, 1, macron(1))$,
    $pmat(1, 1, 0)$, $pmat(1, 0, 1)$, $pmat(0, 1, 1)$,
)

12 planes in the $cmat(1, 1, 0)$ family of planes in a cubic crystal system.

#pagebreak()

==== Family of planes $cmat(1, 1, 1)$ in cubic crystal
#grid(
    columns: 2,
    column-gutter: 1em,
    row-gutter: 1em,
    $pmat(1, 1, 1)$, $pmat(macron(1), macron(1), 1)$,
    $pmat(macron(1), 1, 1)$, $pmat(macron(1), macron(1), 1)$,
    $pmat(1, macron(1), 1)$, $pmat(macron(1), 1, macron(1))$,
    $pmat(1, 1, macron(1))$, $pmat(macron(1), macron(1), macron(1))$,
)

8 planes in the $cmat(1, 1, 1)$ family of planes in a cubic crystal system.

#cimage("./images/crystallographic-planes-111-examples.png")

== Notations in Miller indices
- Negative numbers or directions are denoted with a bar on top of the number.
- $bmat(h, k, l)$ represents a direction.
- $amat(h, k, l)$ represents a family of directions.
- $pmat(h, k, l)$ represents a plane.
- $cmat(h, k, l)$ represents a family of planes.

#pagebreak()

= Densities

== Linear density
- Determines the directional equivalence of a single crystal.
- In a particular crystal, equivalent directions must have identical linear
    densities.

$
    "LD" = frac(
        "Number of atoms centred on the directional vector",
        "Length of the direction vector"
    ) quad (#unit[m^-1])
$

- The units for linear density is of reciprocal length, i.e. #unit[nm^-1],
    #unit[m^-1].
- The vector *must cut through the middle of the atom*.

=== Example
Determine the linear density of an FCC crystal at $bmat(1, 1, 0)$.

#cimage("./images/linear-density-example.png")

$ "Number of atoms centred on the direction vector" bmat(1, 1, 0) = 2 $
$ "Length of direction vector" bmat(1, 1, 0) = 4R $
$ "Linear density," L D_(110) = frac(2, 4R) = frac(1, 2R) $

== Planar density
$ "PD" = frac("Number of atoms centred on a plane", "Area of the plane") $

The plane must cut through the *centre of the atom*, and only the *area of the
atom* within that plane is considered.

=== Example 1: Determine the planar density of the $pmat(1, 1, 0)$ plane for BCC
#grid(
    columns: 2,
    column-gutter: 3em,
    image("./images/planar-density-bcc-110-example-1.png"),
    image("./images/planar-density-bcc-110-example-2.png"),
)

#cimage("./images/planar-density-bcc-110-example-3.png")

$ "Number of atoms in the plane" = 1/4 times 4 + 1 = 2 $
$ "Area of the plane" = sqrt(2) a times a = sqrt(2) a^2 $
$ "PD" = 2/(a^2 sqrt(2)) $

=== Example 2: Determine the planar density of the $pmat(1, 1, 1)$ plane for BCC
#cimage("./images/planar-density-bcc-111-example-1.png")

At $pmat(1, 1, 1)$, or at equivalent planes, the plane does not pass through the
middle of the centre atom.

#cimage("./images/planar-density-bcc-111-example-2.png")

Since $pmat(1, 1, 1)$ *does not cut* through the *centre* of the body-centred
atom:
$ "Number of atoms centred in the plane" pmat(1, 1, 1) = 3 times 1/6 = 1/2 $
$
    "Area of the plane" pmat(1, 1, 1), "triangle" =
    frac(8R^2, sqrt(3)) = frac(8R^2 sqrt(3), 3)
$

$ "PD" = frac(sqrt(3), 16R^2) = frac(3, 16R^2 sqrt(3)) $

= Defects
- Defects make crystals interesting as the possibility of making imperfect
    crystalline materials that permits material scientists to tailor material
    properties like diffusivity, deformation, and electron conductivity, into
    the diverse combinations that modern engineering devices require.
- If materials were perfect crystals, then their properties would be dictated by
    their composition and crystal structure alone, which would restrict their
    property values and variety.
- It is impossible to make defect-free materials. Some defects are
    thermodynamically favourable.
- Crystallography helps us predict the position of atoms in a lattice at any
    distance and along any direction in space.
- Types of crystalline defects
    - 0D: Point defects
        - Interstitials, vacancies
    - 1D: Line defects
        - Dislocations
    - 2D: Interfacial defects
        - Grain boundaries, phase boundaries, surfaces
    - 3D: Bulk or volume defects
        - Voids inclusions, cracks, etc.

#pagebreak()

== Point defects
#cimage("./images/point-defects.png", width: 80%)

- Vacancy refers to a site where the atom is missing from its lattice site.
    #cimage("./images/point-defects-vacancies.png")
- Self-interstitial refers to an "extra" atom in-between the lattice sites.
    #cimage("./images/point-defects-self-interstitials.png")

#pagebreak()

=== Energy cost of forming crystalline defects
Most crystalline defects create *strain*, which distorts the lattice by
"pushing" or "pulling" atoms, and increase the overall energy of the system
(Gibbs free energy $G$).

The system tends to reach an equilibrium structural state, which minimises $G$,
due to the principle of minimum energy (2nd law of thermodynamics).

$ G = H - T S $

Where:
- $G$ is the Gibbs free energy
- $H$ is the enthalpy
- $T S$ is the entropy

=== Equilibrium concentration of vacancies at constant temperature
$ Delta G = Delta H - T Delta S $

Vacancy concentration:
$ frac(n, N) = e^(- frac(Q_v, k T)) $
$ N = frac(N_A rho, A) $

#cimage(
    "./images/equilibrium-concentration-of-vacancies-graph.png",
    height: 20em,
)

Where:
- $n$ is the number of defects (vacancies)
- $N$ is the number of atomic sites
- $Q_v$ is the activation energy for vacancy formation (#unit[J mol^-1]) or
    (#unit[eV atom^-1])
- $k$ is the Boltzmann's constant, which is
    $1.38 times 10^(-23) #unit[J atom^-1 K^-1]$
    or $8.62 times 10^(-5) #unit[eV atom^-1 K^-1]$
- $Omega$ is the number of ways of arrange $n$ vacancies and $N$ atoms in
    $N + n$ sites or "states"
- $N_A$ is the Avogadro constant, $6.023 times 10^(-23) #unit[mol^-1]$
- $rho$ is the density of the material
- $A$ is atomic weight of the material

#pagebreak()

=== Measuring the activation energy ($Q_v$)
- We can get $Q_v$ from an experiment.
- Measure the defect concentration against temperature.
    #cimage("./images/activation-energy-graph.png", height: 20em)
- Since $frac(n, N) = e^(frac(- Q_v, k T))$, re-plot it to form a straight line
    graph:
    #cimage("./images/activation-energy-ln-graph.png", height: 20em)

#pagebreak()

=== Impurities
There are 2 ways impurities exist in metal lattice:
- Interstitial impurity
- Substitutional impurity

#cimage("./images/point-defects-impurities.png")

==== Interstitial sites in FCC structure
#cimage("./images/interstitial-sites-in-fcc-structure.png")

==== Interstitial sites in BCC structure
#cimage("./images/interstitial-sites-in-bcc-structure.png")

=== Non-equilibrium defects
Point defects can be formed by several processes:
+ *Annealing and abrupt quenching*: "Kinetically trapped point defects".
+ *Irradiation by high energy particles*: An issue in materials for nuclear
    applications.
+ *Ion implantation*: High-energy ions are implemented in the material. It is
    useful for controlled doping of semiconductors.
+ *Cold working*: Irreversible mechanical deformation at low temperatures.

== Line defects: Dislocations
One dimensional (line) defects.

#figure(
    caption: "Titanium",
    image("./images/line-defects-dislocations.png", height: 20em),
)

=== Edge dislocation (#sym.perp)
#cimage("./images/edge-dislocation.png", height: 20em)

The Burgers vector, $b$, defines the magnitude and direction of the lattice
distortion of a dislocation.

For an *edge dislocation, $b$ is perpendicular to the dislocation.*

=== Screw dislocation (#sym.arrow.cw)
#cimage("./images/screw-dislocation.png")

For a screw dislocation, $b$ is parallel to the dislocation.

=== Mixed dislocations
#cimage("./images/mixed-dislocations.png")
#pagebreak()

== Interfacial defects: Grain boundaries
Gain boundaries in polycrystalline materials:
- It refers to the regions between crystals.
- They are transitions from a lattice of one region to that of another.
- They are slightly disordered.
- There is low density of atomic packing in grain boundaries:
    - High mobility
    - High diffusivity
    - High chemical reactivity

#cimage("./images/interfacial-defects-grain-boundaries.png")
#pagebreak()

== Bulk and volume defects
- Bulk and volume defects are much larger and are in 3D.
    - Examples include pores, cracks, foreign inclusions, and other phases.
- Normally introduced during processing and fabrication steps.

#cimage("./images/bulk-and-volume-defects.png")

== Microscopy techniques and grain boundary examination
Having a look at a "solidification microstructure":
- Grains can be:
    - Equiaxed (roughly the same size in all directions)
    - Columnar (elongated grains)
- Grain refiner is added to make smaller, more uniform, equiaxed grains.

#cimage("./images/microscopy-techniques-and-grain-boundary-examination.png")

=== Microscopic examination for grains
- Crystallites (grains) and grain boundaries. Crystallites vary considerably in
    size, and can be quite large. Examples include:
    - Large single crystal of quartz or diamond or silicon
    - Aluminium light post or garbage can
- They can be quite small (#unit[mm] or less), which means it is necessary to
    observe with a *microscope*.

== Optical microscopy

=== Grains
- Useful up to 2000X magnification.
- *Polishing* removes surface features (e.g. scratches).
- *Etching* changes reflectance, depending on crystal orientation.
- The difference of the reflectance gives different brightness that helps us to
    differentiate individual grains.

#cimage("./images/optical-microscopy-grains.png")
#pagebreak()

=== Grain boundaries
- Grain boundaries are imperfections.
- Grain boundaries are more susceptible to *acid etching* than at grain.
- May be revealed as dark lines due to the change in the crystal orientation
    across boundaries.
- Metallographic scopes often use polarised light to increase contrast.
- Polarised used for transparent samples such as polymers.

#cimage("./images/optical-microscopy-grain-boundaries.png", width: 80%)

== Electron microscopy
- The optical resolution is around
    $10^(-7) #unit[m] = #qty[0.1][μm] = #qty[100][nm]$
- For higher resolutions, there is a need for higher frequency light.
    - X-rays are difficult to focus.
    - Electron beams can be focused using magnetic lenses, and have a wavelength
        of about #qty[3][pm], and a magnification of 1,000,000 times.
    - It is possible to have atomic resolution.

#cimage("./images/electron-microscopy.png")
#pagebreak()

= Engineering stress and strain

== Stress
Stress has units: $#unit[N m^-2] = #unit[Pa], #unit[N mm^-2] = #unit[MPa]$

=== Tensile stress ($sigma$)
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        $ sigma = F_t/A_0 quad (#unit[N m^-2]) $

        Where:
        - $F_t$ is the tension force
        - $A_0$ is original cross-sectional area before loading
    ],
    image("./images/engineering-stress-tensile-stress.png"),
)

=== Shear stress ($tau$)
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        $ tau = F_s/A_0 quad (#unit[N m^-2]) $

        Where:
        - $F_s$ is the shear force
        - $A_0$ is original cross-sectional area before loading
    ],

    image("./images/engineering-stress-shear-stress.png"),
)

#pagebreak()

=== Common states of stress
#cimage("./images/common-states-of-stress.png", height: 20em)
- Simple tension, like a cable:
    #cimage("./images/cable-tensile-stress.png", width: 90%)
    $ sigma = F/A_0 $
- Torsion, which is a form of shear stress, like a drive shaft
    #cimage("./images/drive-shaft-shear-stress.png", width: 85%)
    $ tau = F_s/A_0 $
- Simple compression:
    #cimage("./images/engineering-stress-simple-compression.png")

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        - Biaxial tension:
            #cimage(
                "./images/engineering-stress-bi-axial-tension.png",
            )
    ],
    [
        - Hydrostatic compression:
            #cimage(
                "./images/engineering-stress-hydrostatic-compression.png",
            )
    ],
)

#pagebreak()

== Engineering strain
Strain is always dimensionless.

- Tensile strain:
    #cimage("./images/engineering-strain-tensile-strain.png", height: 20em)
    $ epsilon = delta/L_0 $
- Shear strain:
    #cimage("./images/engineering-strain-shear-strain.png", height: 20em)
    $ gamma = frac(Delta x, y) = tan theta $

=== Poisson's ratio ($nu$)
#cimage("./images/poissons-ratio.png")

$ nu = - epsilon_x/epsilon_z $

- The Poisson's ratio characterises the contraction *perpendicular* to the
    *extension* caused by a tensile stress.
- The Poisson's ratio is always positive, hence the negative sign in front of
    the strain terms.

== Tensile test: Stress-strain ($sigma-epsilon$) curve
The tensile test is the most fundamental mechanical test of a material.

#cimage("./images/stress-strain-curve.png", height: 15em)

Where:
- $sigma = "Load"/"Area"$ is the stress
- $epsilon = "Displacement"/"Original length"$ is the strain

=== Properties from the $sigma-epsilon$ curve
#cimage("./images/stress-strain-curve-important-properties.png")

$ E = frac(partial sigma, partial epsilon_"el") $
$ "%EL" = frac(L_f - L_0, L_0) times 100 % $
$ "%RA" = frac(A_0 - A_f, A_0) times 100 % $

Properties that can be measured via a tensile test:
+ Young's modulus ($E$, modulus of elasticity, slope of the linear region)
+ Yield strength ($sigma_y$ at 0.2% plastic strain)
+ Tensile strength or ultimate tensile strength (UTS) (at $M$).
+ Ductility (*%EL*)
+ Toughness
+ Resilience

=== Elastic deformation
#cimage("./images/elastic-deformation.png")
#cimage("./images/atomistic-origins-of-elasticity.png")
#pagebreak()

=== Elastic strain energy or resilience ($U_r$)
- Strain energy is the ability of a material to store energy through
    deformation.
- Most energy is stored in the elastic region.
    #cimage("./images/elastic-strain-energy.png")
- Linear-elastic region:
    $ "Hooke's law": sigma = E epsilon $
    Where $E$ is the modulus of elasticity, or Young's modulus.
- Elastic strain energy:
    $ U_r = integral_0^(epsilon_y) sigma thin dif epsilon $
- For a linear elastic material:
    $
        U_r = 1/2 sigma_y epsilon_y
        = frac(E epsilon^2, 2) = frac(sigma_y^2, 2 E)
    $

=== Plastic deformation

==== Yield strength ($sigma_y$)
Plastic (or permanent) deformation is given by the yield strength ($sigma_y$)
which is the stress at which *noticeable* plastic deformation has occurred
($epsilon_p = 0.002 = 0.2%$).

#cimage("./images/plastic-deformation-graph.png")

Note that for a #qty[2][cm] sample:
$
    epsilon_p = 0.002 = frac(Delta L, L_0)
    => therefore Delta L = #qty[0.004][cm] = #qty[40][μm]
$

==== Slip of planes
#cimage("./images/plastic-deformation-slip.png")

=== Ductile vs brittle materials on a $sigma-epsilon$ curve
#cimage("./images/ductile-vs-brittle-materials.png")

- #text(rgb("#4472c4"))[
        Brittle fracture: A significant portion is *elastic energy (dominant)*
    ]
- #text(rgb("#009900"))[
        Ductile fracture: Elastic energy + *plastic energy (dominant)*
    ]

=== Summary: Material properties from tensile test
#cimage("./images/mechanical-properties-from-tensile-test.png")
#pagebreak()

== True stress and strain
The "engineering" stress-strain curve has a maximum and then decreases greatly.

#cimage("./images/true-stress-and-strain.png")

This is due to the cross-sectional area decreasing rapidly within the neck
region, so it appears that the metal is weakening despite it actually
strengthening.

=== True stress ($sigma_T$)
$ sigma_T = F/A_i $
$ sigma_T = sigma (1 + epsilon) $

Where:
- $F$ is the force
- $A_i$ is the initial surface area
- $epsilon$ is the strain

=== True strain ($epsilon_T$)
$ epsilon_T = ln (l_i/l_o) $
$ epsilon_T = ln (1 + epsilon) $

Where:
- $l_i$ is the initial length
- $l_o$ is the final length
- $epsilon$ is the strain

=== Corrected true stress-strain curve
#cimage("./images/corrected-true-stress-strain-curve.png")

The corrected true stress-strain curve considers the complex stress state within
the neck region.

#pagebreak()

== Work hardening or strain hardening
Work hardening is an increase in $sigma_y$ due to plastic deformation.

#cimage("./images/work-hardening-graph.png")

The equation of the curve fitted to the plastic part of the stress-strain
response:
$ sigma_T = K epsilon_T^n $

Where:
- $sigma_T = F/A$ is the true stress
- $epsilon_T = ln(l, l_o)$ is the true strain
- $n$ is the work hardening exponent, which is 0.15 for some steels and 0.5 for
    copper.

= Hardness
- Hardness is the resistance offered by a material to permanently indent its
    surface.
- A large hardness means:
    - Resistance to plastic deformation or cracking.
    - Better wear properties.
- A hardness test is a quality control tool that is in use for more than a
    century.
    #cimage("./images/hardness-test.png")

== Hardness tests
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        === Brinell hardness

        #cimage("./images/brinell-hardness.png")

        Brinell hardness ($H_B$) is the ratio of the load, $P$, to the *surface
        area* of the indentation.
    ],
    [
        === Vickers hardness

        #cimage("./images/vickers-hardness.png")

        Vickers hardness ($H_V$) is the ratio of the load, $P$, to the *surface
        area* of the indentation.
    ],
)

#cimage("./images/types-of-hardness-tests.png")

=== Advantages
+ Simple and inexpensive, as no special specimens need to be prepared, and
    testing apparatus is relatively inexpensive.
+ Test is non-destructive, and there is only a small indentation, so the
    material is not excessively deformed.
+ Other mechanical properties can be estimated from hardness data.

= Dislocation
- If *dislocations* can't *move*, *plastic deformation* does not occur.
- In metals, plastic deformation occurs via *slipping*.
- Slipping refers to an edge dislocation (extra half-plane of atoms) sliding
    over an adjacent half-plane of atoms.

#cimage("./images/dislocations-metal-slip.png")

== Motion
- A dislocation moves along a *slip plane* in a *slip direction* perpendicular
    to the dislocation line.
- The slip direction is the same as the *Burgers vector* direction.

#figure(
    caption: [Edge dislocation],
    image("./images/dislocations-edge-dislocation-direction.png"),
)

#figure(
    caption: [Screw dislocation],
    image("./images/dislocations-screw-dislocation-direction.png"),
)

#figure(
    caption: [Dislocation motion],
    image("./images/dislocations-motion.png", width: 85%),
)

- Dislocation motion requires the successive bumping of a half plane of atoms
    (from left to right in the image shown above).
- Bonds across the slipping planes are broken and remade in succession.

#pagebreak()

== Lattice strain
- Dislocations are defects.
- They increase the energy of the system.
- The excess energy associated with a dislocation is proportional to $b^2$.

#cimage("./images/dislocations-lattice-strain.png", height: 15em)

=== Repulsion
Dislocations of the same sign *repel* each other.

#cimage("./images/dislocations-lattice-strain-repulsion.png", height: 15em)

=== Attraction
Dislocations of the opposite sign attract each other and cancel out.

#cimage("./images/dislocations-lattice-strain-attraction-equation.png")
#pagebreak()

== Burgers vectors and linear atomic density
- The energy required to move a dislocation along a crystallographic direction
    is related to the magnitude of the Burgers vector, *$b$*.
- To *minimise* energy, dislocations will move along crystallographic directions
    that result in a *minimum value* of *$b$*
- *$b$* assumes the minimum value along crystal directions with maximum linear
    density.
- You can compute the magnitude of the Burgers vector for any crystal system.

#cimage("./images/dislocations-linear-density.png")

== Dislocation motion on slip systems
- Slip plane is the plane on which the easiest slippage occurs.
    - It usually has the *highest planar densities* and large inter-planar
        spacing.
- Slip directions are the directions of slipping movement.
    - These directions usually have the *highest linear densities*.

#cimage("./images/dislocations-fcc-slip-systems.png")

FCC Slip occurs on $cmat(1, 1, 1)$ planes (closed-packed) in $amat(1, 1, 0)$
directions (closed-packed). Hence, there are a total of 12 slip systems in FCC.

=== Slip systems in FCC metals
#cimage("./images/dislocations-fcc-slip-systems.png")

=== Slip systems in body-centred cubic (BCC) metals
- Closed packed planes: *$cmat(1, 1, 0)$*
- Closed packed directions: *$amat(1, 1, 1)$*

#cimage("./images/dislocations-bcc-slip-systems.png")
#pagebreak()

=== Slip systems in different crystal structures
#table(
    columns: 6,
    align: center + horizon,
    table.header(
        [*Crystal structure*],
        [*Slip plane*],
        [*Slip direction*],
        [*Number of slip systems*],
        [*Unit-cell geometry*],
        [*Examples*],
    ),

    [BCC],
    $cmat(1, 1, 0)$,
    $amat(macron(1), 1, 1)$,
    $6 times 2 = 12$,
    image("./images/dislocations-different-slip-systems-bcc.png"),
    [#sym.alpha\-Fe, Mo, W],

    [FCC],
    $cmat(1, 1, 1)$,
    $amat(1, macron(1), 0)$,
    $4 times 3 = 12$,
    image("./images/dislocations-different-slip-systems-fcc.png"),
    [Al, Cu, #sym.gamma\-Fe, Ni],
)

== Stress and dislocation motion
- Dislocations move such that atoms are displaced one at the time.
- Dislocations only move in certain slip systems.

#cimage("./images/dislocations-slipping-conditions.png", width: 65%)

- Resolved shear stress $tau_R$ is the resulting shear stress from the applied
    tensile stresses.

#cimage("./images/dislocations-stress-and-dislocation-motion.png", width: 65%)

$ tau_R = sigma m = sigma cos lambda cos phi.alt $

- $m = cos lambda cos phi.alt$ is the Schmid factor.
- The crystal will yield (permanently deform) when $tau_R$ reaches a critical
    value.
- $tau_"crss"$ is the critical-resolved shear stress.
- Note that the maximum value $tau_R$ may assume is $sigma/2$ for
    $lambda = phi.alt = 45 degree$.

#pagebreak()

=== Example: Deformation of a single crystal
+ Will the single crystal yield?
+ If not, what stress is needed?

$ tau_"crss" = #qty[20.7][MPa] $

$ tau_R = sigma cos lambda cos phi.alt $
$ sigma = #qty[45][MPa] $
$
    tau_R & = (#qty[45][MPa]) (cos 35 degree) (cos 60 degree) \
          & = (#qty[45][MPa]) (0.41) \
          & = #qty[18.4][MPa] < tau_"crss" = #qty[20.7][MPa]
$

Hence, the applied stress of #qty[45][MPa] is insufficient to cause the yield of
the crystal.

What is the yield stress of the crystal?

$
    tau_"crss" =
    #qty[20.7][MPa] = sigma_y cos lambda cos phi.alt = sigma_y (0.41)
$

$
    therefore sigma_y
    = frac(tau_"crss", cos lambda cos phi.alt) = frac(#qty[20.7][MPa], 0.41)
    = #qty[50.5][MPa]
$

So, for deformation to occur, the applied stress must be greater than or equal
to the yield stress.

$ sigma >= sigma_y #qty[50.5][MPa] $

== Dislocation motion in various materials

=== Metals
- Many slip systems.
- Closed-pack directions for slip.

#cimage("./images/dislocations-motion-metals.png")
#pagebreak()

=== Covalently bonded materials
Limited slip systems:
- Direction (angular) bonding.
- Complex dislocation structure.

#cimage("./images/dislocations-motion-covalent.png")

=== Ionic ceramics
- Need to avoid nearest neighbours of the same sign (- and +).

#cimage("./images/dislocations-motion-ionic.png")

==== Example
#cimage("./images/dislocations-motion-ionic-example.png")

- Figure A: Atoms are held by ionic bonds, i.e. each ion is surrounded by
    oppositely charged ions.
- Figure B: Any attempt by the ions to slip past one another in response to the
    applied force is faced with *strong repulsive Coulombic forces*. This makes
    *slipping very difficult* and the material responds by breaking. This is a
    *brittle failure*.

==== Deformation of ceramic materials
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        - At room temperature (or sub-ambient temperatures) most ceramics
            fracture before the onset of plastic deformation.
        - Most *crystalline ceramics*, which are predominantly *ionic bonded*,
            have very *few slip systems* along which dislocations may move.
    ],
    image("./images/deformation-of-ceramic-materials-graph.png"),
)

#cimage("./images/deformation-of-ceramic-materials-fracture-surfaces.png")

#pagebreak()

= Strengthening methods
- Dislocation mobility causes metal to yield, hence, to increase a metal's
    strength, we need to *increase its intrinsic resistance to dislocation
    motion*.
- Note that completely stopping the dislocations from moving will *make the
    material brittle* like in ceramics.
- In general, *ductility suffers when strength* increases.

== Grain boundary strengthening
At temperatures less than $0.5 T_m$, where $T_m$ is the melting temperature,
grain boundaries act as a barrier to dislocation motion.

#cimage("./images/strengthening-methods-grain-boundary-strengthening.png")

- In polycrystals, dislocation motion is hindered by grain boundaries.
- Slip planes and directions change from one grain to another.
- *Crossing grain boundaries* requires the application of *higher stress*.

#cimage(
    "./images/strengthening-methods-crossing-grain-boundaries.png",
    width: 80%,
)

#pagebreak()

=== Reduction of grain size
- Reduction of grain size increases strength.
- Grain boundaries are barriers to slipping.
- Smaller grain size means more barriers to slipping.
- This results in a higher stress required to keep dislocations moving, and
    hence higher strength.
- Thus, *small-grained* metals are stronger.
- The Hall-Petch relation:
    $ sigma_y = sigma_0 + k D^(-0.5) $

    Where:
    - $sigma_y$ is the yield stress
    - $sigma_0$ is a constant
    - $k$ is a constant
    - $D$ is the diameter

#cimage("./images/strengthening-methods-hall-petch-relation.png")
#pagebreak()

== Solid solution strengthening
- The elastic interaction between the strain fields of dislocations and solute
    atoms is used in solid solution strengthening.
- The impurity atoms distort the lattice and generate lattice strains.
- These strains can act as barriers to dislocation motion.

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        *Smaller substitutional impurity*

        #figure(
            caption: [
                Impurity generates local stress at $A$ and $B$ which opposes
                dislocation motion to the right.
            ],
            image("./images/strengthening-methods-smaller-impurity.png"),
        )
    ],
    [
        *Larger substitutional impurity*

        #figure(
            caption: [
                Impurity generates local stress at $C$ and $D$ which opposes
                dislocation motion to the right.
            ],
            image("./images/strengthening-methods-larger-impurity.png"),
        )
    ],
)

- *Small* impurities tend to concentrate at regions of *compressive* strains.
- *Large* impurities tend to concentrate at regions of *tensile* strains.
- Partial cancellation of dislocation compressive or tensile strains reduces
    dislocation mobility.
- Impurities reduce dislocation motion, hence alloys are stronger than pure
    metals.

#cimage("./images/strengthening-methods-impurity-effect.png")
#pagebreak()

=== Solid solution strengthening in copper
The yield strength increases when the Nickel concentration increases.

#cimage("./images/strengthening-methods-copper-strengthening.png")

== Strain or work hardening
#cimage("./images/strengthening-methods-work-hardening.png")

=== Effect of cold work
As cold work is increased:
- Yield strength (*$sigma_y$*) increases
- Tensile strength (*$T S$*) increases
- Ductility (*%EL* or *%AR*) decreases

#cimage("./images/strengthening-methods-effect-of-cold-work.png")
#pagebreak()

=== Dislocation multiplication during cold working
- Dislocations multiply (by several orders of magnitude), and entangle with one
    another during *cold work*.
- Dislocation motion become more difficult.

#cimage("./images/strengthening-methods-dislocation-multiplication.png")

== Industrial importance of plastic deformation
- Deformation at room temperature (for most metals).
- Common forming operations reduce the cross-sectional area:
    - Forging
        #image("./images/strengthening-methods-forging.png")
        #v(10em)
    - Rolling
        #image("./images/strengthening-methods-rolling.png", width: 70%)
    - Drawing
        #image("./images/strengthening-methods-drawing.png", width: 80%)
    - Extrusion
        #image("./images/strengthening-methods-extrusion.png", width: 90%)

$ % C W = frac(A_o - A_d, A_o) times 100 $

Where $% C W$ is the percent cold work, measuring the amount of deformation a
metal has undergone during cold working processes.

- Cold working makes the metal hard and brittle, which makes it impossible to
    induce large deformations.
- Intermittent annealing, which is heating the cold worked metal piece to high
    temperatures and holding it for a predetermined period of time, is necessary
    to restore ductility.
- 3 stages during annealing of cold worked metals:
    + Recovery
    + Recrystallisation
    + Grain growth

== Annealing
Effect of annealing after cold working:
- After an hour of annealing at the annealing temperature ($T_"anneal"$), the
    tensile strength ($T S$) decreases and the ductility (%EL) increases.
- The effects of cold work are nullified.
- Three annealing stages:
    + Recovery
    + Recrystallisation
    + Grain growth

#cimage("./images/strengthening-methods-annealing-graph.png")

=== Recovery during annealing
Reduction of dislocation density by annihilation:
- Atoms diffuse towards vacancies to fill them.
- Climbing occurs:
    + The dislocation is blocked and can't move to the right.
    + The atoms leave by vacancy diffusion, allowing the dislocations to
        "climb".
    + The dislocations that have climbed can now move on a new slip plane.
    + Opposite dislocations meet and annihilate.

=== Effect of high temperatures
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        At higher temperatures, atomic diffusion is easier.

        #cimage("./images/strengthening-methods-easier-atomic-diffusion.png")
    ],
    [
        At higher temperatures, there is a larger vacancy concentration.

        #cimage(
            "./images/strengthening-methods-larger-vacancy-concentration.png",
        )
    ],
)

#pagebreak()

== Recrystallisation
- During recrystallisation, new grains are formed that:
    - Have low dislocation densities
    - Are small
    - Consume and replace parent cold-worked grains
    #cimage("./images/strengthening-methods-recrystallisation.png", width: 80%)
- All cold-worked grains are eventually consumed or replaced.
    #cimage(
        "./images/strengthening-methods-recrystallisation-replacement.png",
        width: 80%,
    )

- At longer times, average grain size increases.
    - Small grains shrink and ultimately disappear.
    - Large grains continue to grow.

    #cimage("./images/strengthening-methods-grain-growth.png", width: 80%)

- Empirical relation:
    $ d^n - d_o^n = k t $

    Where:
    - $d$ is the grain diameter at time $t$
    - $n$ is the exponent, typically 2
    - $k$ is the coefficient dependent on material and the temperature
    - $t$ is the elapsed time

=== Recrystallisation temperature ($T_R$)
Recrystallisation temperature is the temperature at which recrystallisation just
reaches completion in #qty[1][h].
$ 0.3 T_m < T_R < 0.6 T_m $

For a specific metal or alloy, $T_R$ depends on:
- %CW, $T_R$ decreases with increasing $% C W$
- Purity of the metal, $T_R$ decreases with increasing purity

==== Cold working vs hot working
- *Hot working* is deformation *above $T_R$*.
- *Cold working* is deformation *below $T_R$*.

== Summary
- Reducing the dislocation mobility enhances the strength, which can be achieved
    by:
    + Reducing the grain size or refining the microstructure, as per the
        Hall-Petch relation:
        $ sigma_y = sigma_0 + k D^(-0.5) $
    + Alloying can give rise to solid solution strengthening.
    + Cold working, but it reduces ductility.
- Recovery, recrystallisation and grain growth are the 3 sequential mechanisms
    that take place when a cold worked metal is annealed at high temperatures.
- Hot working is the process of deforming a metal above its recrystallisation
    temperature.

#pagebreak()

= Equilibrium phase diagrams
- Equilibrium phase diagrams are computed when the system is at thermodynamic
    equilibrium (Gibbs free energy at its minimum).
- This means that at a given temperature and composition, the characteristics of
    the system, or alloy, do not change with time.
- However, a change in temperature or composition yields an increase in free
    energy, potentially resulting in a spontaneous change to another state,
    which is represented by other phases or phase proportions by which the free
    energy is minimised.

#cimage("./images/equilibrium-phase-diagram.png")

== Unary phase diagram for water
Two variables, *temperature and pressure*.

#cimage("./images/water-phase-diagram.png")

== Solid solutions
Materials may contain atoms of different elements, like impurities, which also
constitute point defects.
- *Minority* component: *Solute*
- *Majority* component: *Solvent*

#cimage("./images/solid-solutions.png", width: 80%)
#pagebreak()

== Hume-Rothery rules
Conditions for the formation of a complete solid solution:
+ *Atomic size factor*: The difference in atomic radii between atoms is *less
    than $plus.minus 15%$*.
+ *Crystal structure*: Crystal structures formed by both atoms must be of the
    *same type*.
+ *Electronegativity*: Electronegativity of both component atoms must be
    *similar*.
+ *Valency*: Valences of both elements should be similar.

Note that more than 2 elements may form a solid solution. Similarly, ions may
also form a solid solution.

=== Application: Cu-Ni
- Size difference: Roughly 2.5%
- Crystal structures of both: FCC
- Valence: +2 in both
- Electronegativities: Similar

Hence Cu and Ni are completely soluble.

#cimage("./images/hume-rothery-cu-ni.png")

=== Application: Cu-Fe
- Size difference: Roughly 3%
- Valence: +2 in both
- Electronegativities: Similar
- However, the crystal structures are different, FCC and BCC.

Hence, Cu and Fe are not soluble.

#cimage("./images/hume-rothery-cu-fe.png")

== Isomorphous binary phase diagram
#cimage("./images/isomorphous-binary-phase-diagram.png")

- *Binary phase diagram* refers to a diagram for a system that has *only 2
    components*.
- *Isomorphous* refers to the complete solubility of one component in another.
    The #sym.alpha phase field extends from 0 to 100 with respect to the amount
    of the other metal.
- *Isomorphous binary phase diagram*:
    - Two components that are completely soluble in each other in both liquid
        and solid states.
    - Simplest possible phase diagram.
- The phase diagram indicates phases as a function of $T, C$, and $P$.
    - For binary systems, only *$T$ and $C$*, as $P$ is set to 1 almost all the
        time.

=== Determination of the phases present
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Given *$T$ and the composition ($C_0$)*, we can determine which phases
        are present.

        For example:
        - At $A$ (1100#degreeC, 60 wt% Ni): Single #sym.alpha phase.
        - At $B$ (1250#degreeC, 35 wt% Ni): Two-phase $L + alpha$.
    ],
    image("./images/determination-of-phases-present.png"),
)

=== Determination of phase compositions
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Given $T$ and $C_0$, we can determine the *composition of each phase*.

        For example:

        Consider $C_0 = 35 "wt% Ni"$:
        - At $T_A = 1320#degreeC$:
            - Only liquid (L) present
            - $C_L = C_0 = 35 "wt% Ni"$
        - At $T_D = 1190#degreeC$:
            - Only solid (#sym.alpha) present
            - $C_alpha = C_0 = 35 "wt% Ni"$
        - At $T_B = 1250#degreeC$:
            - Both #sym.alpha and L present
            - $C_L = C_"liquidus" = 32 "wt% Ni"$
            - $C_alpha = C_"solidus" = 43 "wt% Ni"$
    ],
    image("./images/determination-of-phase-compositions.png"),
)

=== Determination of phase weight fractions
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Given $T$ and $C_0$, we can determine the *weight fraction of each
        phase*.

        For example:

        Consider $C_0 = 35 "wt% Ni"$:
        - At $T_A = 1320#degreeC$:
            - Only liquid (L) present
            - $W_L = 1.00, quad W_alpha = 0$
        - At $T_D = 1190#degreeC$:
            - Only solid (#sym.alpha) present
            - $W_L = 0, quad W_alpha = 1.00$
        - At $T_B = 1250#degreeC$:
            - Both #sym.alpha and L present

            $ W_L = frac(S, R + S) = frac(43 - 35, 43 - 32) = 0.73 $
            $ W_alpha = frac(R, R + S) = 0.27 $
    ],
    image("./images/determination-of-phase-weight-fractions.png"),
)

#pagebreak()

=== The lever rule
The tie line connects the phases in equilibrium with each other. It is also
called an *isotherm*.

#cimage("./images/phase-diagrams-lever-rule.png")

$ M_alpha times S = M_L times R $
$
    W_L = frac(M_L, M_L + M_alpha) = frac(S, R + S)
    = frac(C_alpha - C_0, C_alpha - C_L)
$
$
    W_alpha = frac(R, R + S) = frac(C_0 - C_L, C_alpha - C_L)
$

== Solidification during cooling
Cooling of a Cu-Ni alloy. Consider the microstructural changes that accompany
the cooling of a $C_0 = 35 "wt% Ni alloy"$.

#cimage("./images/solidification-during-cooling.png", height: 25em)

== Cored vs equilibrium phases
- $C_alpha$ changes as the element solidifies.
- Cu-Ni case:
    - First #sym.alpha to solidify has $C_alpha = 46 "wt% Ni"$
    - First #sym.alpha to solidify has $C_alpha = 35 "wt% Ni"$
- Fast rate of cooling: Cored structure.
- Slow rate of cooling: Equilibrium structure.

#cimage("./images/cored-vs-equilibrium-phases.png")

== Limits of the Hume-Rothery rules
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        Above the solubility limit, which is when Hume-Rothery rules are not
        satisfied, a new #sym.beta\-phase is formed.
        - $alpha$ and $beta$ have different composition, as they are both
            solutions.
        - They may also have different crystal structures.
        - Multiple phases can coexist in a system if:
            + The component of the system are immiscible, like oil and water.
            + The solubility limit of the solute has been reached.
    ],
    image("./images/hume-rothery-limits.png"),
)

#pagebreak()

== Binary-eutectic systems
- Binary means having 2 components.
- Eutectic means having a special composition with a minimum melting temperature
    ($T$).

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        For example, the Cu-Ag system:
        - Three single-phase regions (*L, #sym.alpha, #sym.beta*)
        - Limited solubility:
            - #sym.alpha: Mostly Cu
            - #sym.beta: Mostly Ag
        - $T_E$: No liquid below $T_E$.
        - $C_E$: Composition at temperature $T_E$
        - Eutectic reaction:
            $ L (C_E) harpoons.rtlb alpha (C_(alpha E)) + beta (C_(beta E)) $
            $
                L (71.9 "wt% Ag")
                stretch(harpoons.rtlb)_"heating"^"cooling"
                alpha (8.0 "wt% Ag") + beta (91.2 "wt% Ag")
            $
    ],
    image("./images/binary-eutectic-system-cu-ag.png"),
)

=== Example 1: Pb-Sn Eutectic system
For a 40 wt% Sn and 60 wt% Pb allow at 150#degreeC, determine the phases
present.

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        The phase composition is $alpha + beta$.

        The relative amount of each phase is:
        $ C_alpha = 11 "wt% Sn" $
        $ C_beta = 99 "wt% Sn" $

        Applying the lever rule:
        $
            W_alpha & = frac(S, R + S) = frac(C_beta - C_0, C_beta - C_alpha) \
                    & = frac(99 - 40, 99 - 11) = 59/88 = 0.67
        $

        $
            W_beta & = frac(R, R + S) = frac(C_0 - C_alpha, C_beta - C_alpha) \
                   & = frac(40 - 40, 99 - 11) = 29/88 = 0.33
        $
    ],
    image("./images/binary-eutectic-system-pb-sn-example-1.png"),
)

=== Example 2: Pb-Sn Eutectic system
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        The phase composition is $alpha + L$.

        The relative amount of each phase is:
        $ C_alpha = 17 "wt% Sn" $
        $ C_L = 46 "wt% Sn" $

        Applying the lever rule:
        $
            W_alpha & = frac(C_L - C_0, C_L - C_alpha)
                      = frac(46 - 40, 46 - 17) \
                    & = 6/29 = 0.21
        $

        $
            W_L & = frac(C_0 - C_alpha, C_L - C_alpha) \
                & = 23/29 = 0.79
        $
    ],
    image("./images/binary-eutectic-system-pb-sn-example-2.png"),
)

=== Microstructural developments in eutectic systems

==== Example 1
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        - Consider alloys with $C_0 < 2$ wt% Sn.
        - Result: At room temperature, it reaches polycrystalline state with
            grains in #sym.alpha\-phase with composition $C_0$.
    ],
    image("./images/microstructural-developments-in-eutectic-systems-1.png"),
)

==== Example 2
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        - Consider alloys with 2 wt% Sn $< C_0 <$ 18.3 wt% Sn.
        - Result: *Dual-phase alloys* are formed.
        - At temperatures in $alpha + beta$ range, polycrystalline structures
            with #sym.alpha grains and small #sym.beta\-phase particles
            (*precipitates*) are formed.
    ],
    image("./images/microstructural-developments-in-eutectic-systems-2.png"),
)

==== Example 3
- Consider alloys with $C_0 = C_E$.
- Result: *Eutectic alloys* with eutectic microstructure (lamellar structure)
    are formed. Alternating layers (lamellae) of #sym.alpha and #sym.beta phases
    can be observed.

#cimage("./images/microstructural-developments-in-eutectic-systems-3.png")
#cimage("./images/lamellar-eutectic-structure.png", height: 15em)

==== Example 4
- Consider alloys with 18.3 wt% Sn $< C_0 <$ 61.9 wt% Sn.
- Result: *Near-eutectic alloys* form, consisting #sym.alpha\-phase particles
    and #sym.alpha eutectic micro-constituent.

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        - Just above $T_E$:
            $ C_alpha = 18.3 "wt% Sn" $
            $ C_L = 61.9 "wt% Sn" $
            $ W_alpha = frac(S, R + S) = 0.50 $
            $ W_L = 1 - W_alpha = 0.50 $
        - Just below $T_E$:
            $ C_alpha = 18.3 "wt% Sn" $
            $ C_L = 97.8 "wt% Sn" $
            $ W_alpha = frac(Q, R + Q) = 0.73 $
            $ W_beta = 1 - W_alpha = 0.27 $
    ],
    image("./images/microstructural-developments-in-eutectic-systems-4.png"),
)

=== Hypoeutectic and hypereutectic
#cimage("./images/hypoeutectic-and-hypereutectic.png")
#pagebreak()

=== Intermetallic compounds
An intermetallic compound appears as a line (not an area) on the phase diagram
because of its fixed stoichiometry, which means the composition of a compound is
a fixed value.

#cimage("./images/intermetallic-compounds.png")

Treat the diagrams below as two separate phase diagrams that are joined
together.
#cimage("./images/intermetallic-compounds-separate-diagrams.png")
#pagebreak()

=== Phase transformations
- Eutectic:
    $ "Liquid" stretch(harpoons.rtlb)_"heat"^"cool" "solid 1" + "solid 2" $
- Eutectoid:
    $ "Solid 1" stretch(harpoons.rtlb)_"heat"^"cool" "solid 2" + "solid 3" $

    Solid state phase transformation.

- Peritectic:
    $ "Liquid" + "solid 1" stretch(harpoons.rtlb)_"heat"^"cool" "solid 2" $

==== Eutectoid and peritectic
#cimage("./images/eutectoid-and-peritectic.png", width: 85%)

== Phase diagrams are processing maps
- Phase diagrams guide the choice of processing conditions, like thermal
    treatments, to control the compositions, size and arrangement of phases that
    can be obtained in a certain system.
- Through *processing* (temperature and time), we can control the
    *microstructure* of the alloy (size, distribution, and proportion of grains
    and phases), which in turn determines the alloy's *properties* (strength,
    ductility, etc.)

== Summary
- Given the temperature and composition of the system, *phase diagrams* are
    useful tools to determine:
    - Number and types of phases present
    - *Composition* of each phase
    - Weight fraction of each phase
- The microstructure of an alloy depends on its:
    - Composition
    - Temperature

#pagebreak()

= Iron-carbon (Fe-C) phase diagrams
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        2 important points:
        - Eutectic ($A$):
            $ L -> gamma + "Fe"_3 C $
        - Eutectoid ($B$):
            $ gamma -> alpha + "Fe"_3 C $

        #cimage("./images/fe-c-phase-diagram-grains.png")

        Result: Pearlite, which are alternating layers of #sym.alpha and
        Fe#sub[3]C phases.
    ],
    image("./images/fe-c-phase-diagram.png"),
)

== Pearlite in Japanese Katana swords
#cimage("./images/pearlite-in-katanas.png")

#text(rgb("#0000FF"))[*Pearlite*]:
- The combination of cementite and ferrite makes pearlite a *tough* phase.
- Ferrite is soft and ductile, while cementite is hard and brittle.
- For this reason, Pearlite is ideal for the blade body.

#text(red)[*Martensite*]:
- Martensite originates from the rapid cooling (quenching) of austenite.
- As such, martensite is a non-equilibrium phase and thus does not show up in
    the Fe-C phase diagram.
- Martensite is the strongest and hardest phase that is available in the Fe-C
    system.
- Because of its strength, Martensite is ideal for the blade cutting edge.

== Differential quenching
#cimage("./images/differential-quenching.png")

== Variation of mechanical properties with carbon concentration
#cimage("./images/variation-of-mechanical-properties-with-c-concentration.png")

== Hypoeutectoid steel
#cimage("./images/hypoeutectic-steel.png", height: 29em)

== Hypereutectoid steel
#cimage("./images/hypereutectic-steel.png", height: 29em)

== Classification of metal alloys
#cimage("./images/classification-of-metal-alloys.png")
#pagebreak()

== Steels
#pad(x: -4em, table(
    columns: (7em,) + (auto,) * 8,
    align: center + horizon,
    table.header(
        [],
        table.cell(colspan: 6)[*Low Alloy*],
        table.cell(colspan: 2)[*High Alloy*],

        [],
        table.cell(colspan: 2)[Low carbon],
        table.cell(colspan: 2)[Medium carbon],
        table.cell(colspan: 2)[High carbon],
        table.cell(colspan: 2)[],

        [],
        table.cell(colspan: 2)[< 0.25 wt% C],
        table.cell(colspan: 2)[0.25 - 0.6 wt% C],
        table.cell(colspan: 2)[0.6 - 1.4 wt% C],
        table.cell(colspan: 2)[],
    ),

    [*Name*],
    [Plain],
    [HSLA],
    [Plain],
    [Heat treatable],
    [Plain],
    table.cell(colspan: 2)[Tool],
    [Stainless],

    [*Additions*],
    [None],
    [Cr, V, Ni, Mo],
    [None],
    [Cr, Ni, Mo],
    [None],
    table.cell(colspan: 2)[Cr, V, Mo, W],
    [Cr, Ni, Mo],

    [*Example*],
    [1010],
    [4310],
    [1040],
    [4340],
    [1095],
    table.cell(colspan: 2)[4190],
    [304, 409],

    [*Hardenability*],
    [0],
    [+],
    [+],
    [++],
    [++],
    table.cell(colspan: 2)[+++],
    [Varies],

    [*Tensile strength ($T S$)*],
    [-],
    [0],
    [+],
    [++],
    [+],
    table.cell(colspan: 2)[++],
    [Varies],

    [*Ductility ($%E L$)*],
    [+],
    [+],
    [0],
    [-],
    [-],
    table.cell(colspan: 2)[--],
    [++],

    [*Uses*],
    [Auto structure sheet],
    [Bridges, towers, pressure vessels],
    [Crankshafts, bolts, hammers, hammers, blades],
    [Pistons, gears, wear applications],
    [Wear applications],
    table.cell(colspan: 2)[Drills, saws, dies],
    [
        High temperature applications, turbines, furnaces \ \
        *Very corrosion resistant*
    ],
))

== Ferrous alloys
Iron based alloys
- Steels
- Cast irons

Nomenclature for steels (AISI/SAE):
- 10xx: Plain carbon steels
- 11xx: Plain carbon steels (Resulfurised for machinability)
- 15xx: Mn (1.00% - 1.65%)
- 40xx: Mo (0.20% ~ 0.30%)
- 43xx: Ni (1.65% - 2.00%), Cr (0.40% - 0.90%), Mo (0.20% - 0.30%)
- 44xx: Mo (0.5%)

Where xx is wt% C #sym.times 100. For example, 1060 steel is plain carbon steel
with 0.60 wt% C.

Stainless steel have more than 11% Cr.

#pagebreak()

=== Cast irons
- Ferrous alloys with more than 2.1 wt% C
    - Most commonly, 3 – 4.5 wt% C
- Low melting point, which means they are relatively easy to cast.
- Generally brittle.
- Cementite decomposes to ferrite + graphite
    $ "Fe"_3 C -> 3 "Fe" space (alpha) + C ("graphite") $

    This is generally a slow process.

=== Fe-C true equilibrium diagram
Graphite formation is promoted by:
- Si > 1 wt%
- Slow cooling

#cimage("./images/fe-c-true-equilibrium-diagram.png")

=== Limitations
+ Relatively high densities.
+ Relatively low electrical conductivities.
+ Generally poor corrosion resistance.

#pagebreak()

== Other important nonferrous alloys

=== Copper (Cu) alloys
- Brass:
    - Zn is a substitutional impurity.
    - Used in costume jewellery and coins.
    - Is corrosion resistant.
- Bronze:
    - Sn, Al, Si, and Ni are substitutional impurities.
    - Used in bushings and landing gears.
- Cu-Be:
    - A precipitate hardened for strength.

=== Aluminium (Al) alloys
- Low density ($rho$) of #qty[2.7][g cm^3]
- Cu, Mg, Si, Mn, and Zn are added.
- Either a solid solution or precipitate strengthened.
- Used in structural aircraft parts and packaging.

=== Magnesium (Mg) alloys
- Very low density ($rho$) of #qty[1.7][g cm^-3]
- Ignites easily.
- Used in aircraft and missiles.

=== Titanium (Ti) alloys
- Relatively low density ($rho$) of #qty[4.5][g cm^-3], steel has a density of
    #qty[7.9][g cm^-3].
- Reactive at high temperatures.
- Space applications.

=== Refractory metals
- High melting points.
- Examples include:
    - Niobium (Nb)
    - Molybdenum (Mo)
    - Tungsten (W)
    - Tantalum (Ta)

=== Noble metals
- Silver (Ag), Gold (Au), Platinum (Pt).
- Oxidation and corrosion resistant.

#pagebreak()

= Manufacturing
Fastening #sym.arrow.long It is an *assembly process*, not a manufacturing
process.

#cimage("./images/fastening.png", height: 10em)

#grid(
    columns: 2,
    column-gutter: 0.5em,
    align: horizon,
    math.cases(
        reverse: true,
        [Polishing],
        [Coating],
        [Glazing],
        [Etching],
    ),
    [
        For macroscopic objects (bigger than #unit[mm] scale), these are
        *surface finishing processes*. They are not manufacturing processes, and
        are called post-processing.

        However, for micro and nanoscopic objects which are smaller than
        #qty[1][mm], these may be considered manufacturing processes. They are
        called *micromanufacturing*. This is because polishing induces changes
        at the microscopic scale.
    ],
)

#cimage("./images/surface-finishing-processes.png")
#pagebreak()

Cutting #sym.arrow.long This is a *subtractive process*.

#cimage("./images/subtractive-processes.png", height: 25em)

#math.cases(
    reverse: true,
    [Gluing],
    [Soldering],
    [3D printing],
) These are *additive processes*.

#cimage("./images/additive-processes.png")
#pagebreak()

#math.cases(
    reverse: true,
    [Bending],
    [Casting],
    [Extrusion],
    [Blowing],
) These are *formative processes*.

#cimage("./images/formative-processes.png", height: 25em)
#pagebreak()

== Purposes of manufacturing
- Manufacturing is about *shaping*.
    #cimage("./images/manufacturing-shaping.png", height: 25em)

- Manufacturing adds *value*.
    - Value refers to the economic enhancement a company gives its product or
        services before offering them to customers.
    #cimage("./images/manufacturing-value-add.png")

== Types of manufacturing
There are *3 major* types of manufacturing processes:
+ Additive
+ Subtractive
+ Formative

#cimage("./images/types-of-manufacturing.png")

=== Choosing a type of manufacturing
Considerations:
- The cost of the processes and the value of the product.
- The expected yield.
- The environmental impact.
- The design of the product.
- The material to use.
- The size desired.
- The accuracy and precision desired.
- Etc.

#pagebreak()

== Minimum waste processes
- It is desirable to reduce *waste* produced during manufacturing.
- Minimum waste processes are called:
    - Net shape processes, which have little or no waste of the starting
        material and no machining required. The final shape is readily obtained.
    - Near net shape processes, which require minimal machining or
        post-processing. The final shape is almost obtained.

#cimage("./images/minimum-waste-processes-example.png")
#pagebreak()

== Types of materials
- The properties of the materials used affect the manufacturing processes.
- Most engineering materials are classified under these 3 basic categories:
    - Metals
    - Polymers
    - Ceramics (not covered)
- Composites of the above materials are also commonly found.
- Since they differ in chemistry and physical properties, the processes can be a
    bit different.

=== Example
#cimage("./images/manufacturing-material-differences.png")

The principle is the same, but the apparatus and processing parameters are
different:
- Metals melt at high temperatures (Al metls at $660 degree "C"$) whereas
    polymers melt at lower temperatures (PE metls at about $110 degree "C"$).
- The viscosity is also very different.
    - Metals are very liquid (~1 #qty[1][mPa s]) whereas polymers are very
        viscous (in #unit[MPa s])

== Trends in manufacturing
Some recent trends in manufacturing are:
- Micro and nano fabrication.
- Robotic-assisted fabrication.
- Green manufacturing.

=== Micro and nano fabrication
- Micro and nano fabrication produce parts of microscopic ($10^(-6) #unit[m]$)
    and nanoscopic ($10^(-9) #unit[m]$) scale.
- Due to the difference in the material's scale, the materials' properties are
    very different, and therefore the processes are also very different.
- An example of the influence of material scale on the properties is how micro
    and nanopowders tend to agglomerate whereas millimetric powders to not.
- Also, micro and nano processes become very sensitive to particles in the air
    and are conducted in controlled, cleaned environment (cleanroom, in vacuum,
    etc.)

==== Example
#figure(
    image("./images/micro-and-nano-fabrication-example-1.png", height: 25em),
    caption: [
        Microelectronics processing in a clean room. This is a picture of a
        clean room where the air is filtered. The person is handling a silicon
        wafer that will then be processed using photolithography, to produce
        integrated circuits or other electrical devices.
    ],
)

#figure(
    image("./images/micro-and-nano-fabrication-example-2.png", height: 25em),
    caption: [
        Focus ion beam milling. This is a picture of a pattern made in vacuum
        using focus ion beam (FIB). Instead of cutting with a saw, the material
        is cut with tiny "flying" ions. These kinds of patterns are called
        photonic patterns and can be made on glass fibers to give them new
        properties.
    ],
)

=== Robotic-assisted fabrication
- Robotic-assisted fabrication is are needed to satisfy the huge demand.
- The word "manufacturing" comes from "manu factum" in Latin which means "made
    by hand".
- "Manu" is the hand. (In French, it is "main"). And "factum" means to make. (In
    French, it is "faire"). In English, we have "factory" which is the place
    where goods and objects are made.
- With the advances in technology, the economic pressure, and the consumer
    demand, automation is required in the fabrication process.
- Industry 4.0 is transforming the way goods are manufactured by having
    processes automated, but also connected in the digital world.
- 3D printing is a key enabler of Industry 4.0.

#cimage("./images/industry-4.0.png")

==== 3D printing
- 3D printing allows the layer-by-layer automated fabrications of parts with
    complex shapes and low material waste (near net shape).
- There are many types of 3D printing like extrusion-based, laser-based and vat.
    The field is still under development.
- 3D printing is an additive manufacturing process, but additive manufacturing
    is *not always* 3D printing.
- Another example of additive manufacturing is welding.

#pagebreak()

=== Green manufacturing
- Green manufacturing, also called sustainable manufacturing is a new approach
    to manufacturing that is urgently needed to address the current climate
    crisis.
- More sustainable manufacturing considers the pollution induced during
    fabrication and tries to reduce it.
- It can be pollution due to waste, non-sustainable materials, too high energy
    and water use, or is not socially acceptable.
- There are many different approaches to these aims.

#cimage("./images/7-green-wastes.png")

==== Example
#figure(
    image("./images/green-manufacturing-in-singapore.png"),
    caption: [
        In Singapore, robotic assisted manufacturing is one direction to have
        more sustainable manufacturing.
    ],
)

#pagebreak()

== Precision and accuracy
- It is important to know the precision and accuracy of a process in producing
    parts.
- Precision and accuracy can determine the cost of the piece, its uses, and for
    what kind of parts can a specific process be used, etc.

=== Precision
- Precision refers to repeatability.
- An example is when baking cookies, each cookie is a little bit different even
    though they all have the same shape and size, and has the process has low
    precision.

=== Accuracy
- Accuracy refers to how close something is to the true value.
- An example is when making pancakes of the size of a pan, they are the right
    shape, but are always smaller than desired, hence the process has low
    accuracy.

=== Precision and accuracy in measurement
The instruments measure precise and accurate dimensions.

#cimage("./images/precision-and-accuracy-in-measurement.png")

=== Precision and accuracy in manufacturing
The dimensions of the manufactured part are precise and are accurate with
respect to the intended design.

==== Precision
- Precision of machine tools is their degree of repeatability for performing an
    action the same way each time, without generating *random error*.
- It is also known as *quality*.

#figure(
    image("./images/precision-in-manufacturing.png", height: 8em),
    caption: [
        High precision \
        (the pieces are interchangeable)
    ],
)

==== Accuracy
- The accuracy of machine tools i their degree of conformance to a known
    standard or value, without generating *systematic error*.
- For example, when we say a CNC machine is highly accurate, this means that if
    it is programmed to cut a piece of metal to #qty[40][mm] long, the machine
    actually does that. The more accurate it is, the closer it gets to exactly
    #qty[40.00][mm].

#cimage("./images/accuracy-in-manufacturing.png")

== Dimensions and tolerance
- To measure the precision and accuracy, we define dimensions and tolerance.
- We call the *nominal or basic size* the dimension that is desired by the
    designer for a specific part.
- For example, we want a bar of diameter #qty[2.500][mm].
- We therefore need to know if we can make this exact dimension of
    #qty[2.500][mm].

=== Tolerance
Tolerance is the allowable deviation from the value that we can tolerate for a
part.


For the part below, the tolerance is:
$ +0.005 - (- 0.005) = 0.01 $

#cimage("./images/tolerance-1.png", height: 10em)

#cimage("./images/tolerance-2.png", width: 80%)

==== Importance of tolerance
- Knowing the tolerance is important because there are always imperfections
    occurring during the processing of a part.
- Tolerances are used to define the limits of the allowable variation.
- Setting tolerance can have implications for the process. For example, a very
    low tolerance means the process will likely be more expensive.

#cimage("./images/typical-tolerance-limits.png")
#pagebreak()

== Conventional measuring instruments and gages
- Digital callipers are used to measure lengths and diameter.
    #cimage("./images/digital-callipers.png")

- Bevel protractors and sine bars are used to measure angles.
    #cimage("./images/bevel-protractors-and-sine-bars.png", width: 80%)
    $ sin A = H/L $

- There are also measuring instruments called fixed gages which have a fixed
    dimension. They are called go/no-go gages.
- They are called like this because one gage limit allows the part to be
    inserted while the other limit does not:
    - Go limit: Used to check the dimension at its maximum material condition.
    - No-go limit: Used to inspect the minimum material condition of the
        dimension in question.
    #cimage("./images/go-no-go-gages.png")

== Surface finishing and measurement
In addition to the dimensions, the surface finish of an object is important.
- For aesthetic reasons.
- Surface finish affects safety.
- Friction and wear depend on surface characteristics, like brakes for example.
- Surfaces affect mechanical and physical properties.
- Assembly of parts is affected by their surfaces.
- Smooth surfaces make better electrical contacts.
- Etc.

Some important parameters that define the surface finish are:
- Surface texture
- Roughness
- Waviness

=== Surface texture
Surface texture is the repetitive or random deviations from the nominal surface
of an object.

#cimage("./images/surface-texture.png")

=== Roughness and waviness
- Roughness is defined by small, finely-spaced deviations from the nominal
    surface.
- Waviness are deviations of much larger spacings than the roughness.
- Roughness is superimposed on waviness.
    #cimage("./images/surface-profile-equation.png")

- Roughness is the lack of precision, which refers to small variations around a
    nominal value.
- Waviness is the lack of accuracy, which refers to large variation of the
    value.

==== Measuring surface roughness
Surface roughness is measured using a stylus instrument.

#cimage("./images/measuring-surface-roughness-using-a-stylus.png")

The stylus head traverses horizontally across the surface, while the stylus
moves vertically, following the surface profile.

The surface roughness $R_a$ is the arithmetic average based on the absolute
values measured:

#cimage("./images/surface-roughness-measurement.png")

$
    R_a = sum_(i = 1)^(n) frac(|y_i|, n)
    = frac(y_a + y_b + dots.c + y_k + y_l + dots.c, n)
$

Where:
- $y_i$ is the absolute values of the vertical deviations identified by
    subscript $i$
- $n$ is the number of deviations included

#pagebreak()

= Engineering polymers and polymer forming

== Fundamentals of polymers

=== What is a polymer
- Polymer comes from two Greek words, "poly" and "meros", "poly" meaning many or
    several, and "meros" meaning units.
- A polymer is a *large* molecule, with high molecular weight, constructed from
    many smaller structural *repetitive units* (monomers), *covalently* bonded
    together (cross-links along the single polymer chain).
    #figure(
        image("./images/polyethylene.png"),
        caption: [
            '$n$' is the number of repetitive units. Typically, $n$ ranges from
            10,000 to 100,000.
        ],
    )
- A polymer is formed through a chemical reaction called *polymerisation*.
    - Monomers are activated and react with each other to form chains.
    - The reaction may be difficult to control, and molecules bind to their
        closest neighbours.
- Polymers have a *large molecular weight*, and are typically polydisperse.
    Polydisperse means that there is a range of molecular weight distribution,
    and that not all polymeric chains have the same length.
    #cimage("./images/polydisperse.png")

#pagebreak()

=== Is "plastics" the same as "polymers"?
- In everyday language, plastics and polymers are used interchangeably.
- Plastics refer to *plastic formulation*, which are *polymers with additives*.
- These additives can be colouring dyes, plasticisers to make the material more
    elastic, reinforcing particles, etc.
    #cimage("./images/plastic-formulation.png")

=== Thermoplastics
#cimage("./images/thermoplastics.png", height: 10em)
- Thermoplastics are polymers that *soften* and *melt* with temperature.
    $ "Solid" stretch(harpoons.rtlb)_"Cooling"^"Heating" "Liquid (melt)" $
- They *can be recycled* into a new part.
- Examples include PE, PP, PLA, and PET.
- When thermoplastics are heated, each polymer chain gains energy, and can move
    or slide next to each other. This is also known as *reptation*.
    #cimage("./images/thermoplastics-reptation.png", height: 15em)
- Thermoplastic polymers are the most produced and used polymers.
    #cimage("./images/thermoplastics-graph.png")
- Thermoplastic polymers soften and melt at elevated temperatures and harden
    during cooling.
- PPT, PET, PVC, LDPE, and HDPE are examples of thermoplastics polymers.
    #cimage("./images/thermoplastics-examples.png")

#pagebreak()

=== Thermosets
#cimage("./images/thermosets.png", height: 10em)
- Thermosets are polymers that *harden* with temperature.
    $
        "Liquid"
        stretch(harpoons.rtlb)_(#text(red)[Irreversible])^"Heating" "Solid"
    $
- They cannot be recycled into a new part.
- Examples include epoxy and silicone.
- The polymer chains are cross-linked together and cannot move with higher
    temperatures, but they are flexible between the cross-links.
    #cimage("./images/thermosets-cross-link.png", height: 10em)
- Thermosets are obtained by mixing a cross-linker and the resin component.
- Thermosets that are highly cross-linked are called resins, while elastomers
    are thermosets that have low cross-linking density.
    #grid(
        columns: 2,
        column-gutter: 3em,
        row-gutter: 1em,

        grid.header([*Resins*], [*Elastomers*]),

        image("./images/thermosets-resins.png"),
        image("./images/thermosets-elastomers.png"),

        [
            - Strain at rupture is roughly 9%.
            - Elastic modulus is roughly #qty[3][GPa]
        ],
        [
            - Strain at rupture is > 400%
            - Elastic modulus is roughly #qty[40][MPa]
        ],
    )

=== Glass transition temperature ($T_g$)
- Below the glass transition temperature, the polymer is a *brittle* glass.
- Above the glass transition temperature, the polymer is *rubber*, elastic and
    stretchy.
- There is *no phase change (solid material)*.
- Above the glass transition temperature, polymer chains have *more motion*
    (thermal motion), and can move (*reptation*).

==== Consequences of the glass transition temperature
Both thermoplastics and thermosets:
- Polymers that can easily deform have a low glass transition temperature.
- Bigger molecular sizes, like polymers with a larger molecular weight or longer
    molecules, make deformation more difficult because of entanglement and thus
    tend to increase the glass transition temperature.

Thermoplastics only:
- Above the glass transition temperature, they form a *polymer melt*.
- Polymer melts have 2 important properties, viscosity and viscoelasticity.

Thermosets only:
- Above the glass transition temperature, they are just a bit softer.

#pagebreak()

== Properties of polymer melts

=== Viscosity
- Viscosity is a property that determines fluid flow.
- It can be defined as the resistance to flow.
- It is a measure of the internal friction in the fluid. The more viscous the
    fluid is, the greater the resistance to flow.
- High viscosity means low fluidity.

#cimage("./images/viscosity.png")

$ F_"viscous" = eta A frac(Delta v_x, Delta y) $

- The units of viscosity $eta$ is #unit[N s m^-2] or #unit[Pa s].
- The CGS unit is dyne #unit[sec cm^-2], which is called #unit[Poise].
- The viscosity of water at 20#degreeC is #qty[0.01][Poise].
- The viscosity of blood at body temperature is about #qty[0.03][Poise].
- The unit #unit[Pa s] is called a Poisuille and is equal to #qty[10][Poise].

#cimage("./images/viscosity-water-vs-honey.png", width: 80%)

==== Polymer melts
- Due to the high molecular weight of the polymeric chains, polymer melts have
    high viscosity, which is very different from liquid metals.
- Most polymer shaping processes involve the flow of polymer through small
    channels or die openings.
- Flow rates are often large, leading to high shear rates and shear stresses, so
    significant pressures are required to accomplish the processes.

==== Shear rate
- The viscosity of a polymer melt decreases with shear rate, and hence becomes
    more fluid at higher shear rate.
- This is called *shear-thinning* or *pseudoplastic fluid* behaviour.

==== Temperature
Viscosity decreases with increasing temperature.
#cimage("./images/viscosity-decrease-with-temperature.png")

==== Other aspects influencing viscosity
- The shear history affects the viscosity of a polymer melt.
- The viscosity of polymer melts tends to decrease if the polymer has been
    shared previously.
- This is due to the disentanglement of the poly chains during pre-shearing.

#cimage("./images/viscosity-shear-history.png")

=== Viscoelasticity
- Fluids like polymer melts are viscoelastic, which means they need a little bit
    of time to react when stress is applied to them.
- Toothpaste is typically a liquid that is viscoelastic and is shear-thinning.

#cimage("./images/viscoelasticity.png")

== Overview of polymer forming processes
- Almost unlimited variety of part geometries.
- Plastic moulding is a net shape process, so no further shaping or processing
    is needed.
- Less energy is required than for metals due to much lower processing
    temperatures.
- The handling of products is simplified during production because of lower
    temperatures.
- Painting or plating is usually not required.
- The processes are applied when the polymer is in soft, liquid form:
    - For thermoplastics, it is above the glass transition temperature, when it
        is a polymer melt.
    - For thermosets, it is before the cross-linking happens.
- Examples of polymer forming processes:
    - Casting
    - Extrusion
    - Injection moulding
    - Compression moulding
    - Transfer moulding
    - Blow moulding
    - Thermoforming

#pagebreak()

== Casting
The process:
- Pour the liquid polymer into a mould, using gravity to fill the cavity, where
    the polymer hardens.
- Both thermoplastics and thermosets can be cast when they are in liquid state,
    which is before cross-linking happens in thermosets, or at high temperature
    for thermoplastics.
- Simple moulds are used.
- Suitable for low quantities.
- Can be used for encapsulation of electronics.

== Extrusion
- Extrusion is a continuous process for making profile shapes (rods, fibres,
    tubes, etc.), films and sheets or parison (the preform for blow moulding).
- There are many types of extruders, and the single screw extruder is the most
    common one.

#cimage("./images/extrusion-extruder-types.png")

=== Single-screw extruder
#cimage("./images/extrusion-single-screw-extruder.png")

Shear heating is the main mechanism for melting the polymer.

#pagebreak()

=== Process
#cimage("./images/extrusion-process.png")
- Polymer pellets are fed into the screw.
- Movement along the screw conveys the pellets along the heated barrel.
- Frictions and external heaters facilitate the melting of the pellets.
- The molten melt is then passed through a die to produce the extrudate of the
    desired shape.
- In the *feed zone*, the screw depth is constant. The function is to preheat
    the pellets and to convey them to the next zone. It is important that
    melting does not occur there.
- In the *compression zone*, the screw depth gradually decreases to compact the
    pellets. Compression is needed to squeeze trapped air pockets back into the
    feed zone, improving the heat transfer.
- In the *metering zone*, the screw depth is constant, but less than that of the
    feed zone. The melt is homogenized here to ensure the melt is supplied at a
    constant rate.

#cimage("./images/extrusion-zones.png")
#pagebreak()

=== Filter plates
- The filter plate filters the melt into tubes of 120 to #qty[150][#sym.mu\m].
- It is supported by a breaker plate that helps to straighten the spiralling
    melt flow emerging from the crew.
- Filter and breaker plates also create a back pressure, mixing the melt better.

#cimage("./images/extrusion-filter-plate.png")
#pagebreak()

=== Die swell defect
- The polymer chains at the wall undergo partial stretching during flow. At the
    exit, there is no more shearing, leading to elastic strain recovery. This
    causes the polymer chains to curl up and the increase in the cross-section
    of the extrudate.
- The flow profile of the polymer melt under shear is parabolic, as the flow is
    faster at the centre than at the wall. At the exit, due to the elastic
    strain recovery of the polymer chain, the flow profile changes to a plug
    flow.

#grid(
    columns: 2,
    column-gutter: 3em,
    align: center + horizon,
    image("./images/extrusion-die-swell-1.png"),
    image("./images/extrusion-die-swell-2.png"),
)

- At a fixed shear rate, increasing the die length decreases die swell.
- Die swell from a slit is generally larger than from a capillary.
- It is important to design the correct exit shape to obtain the desired
    product.

#cimage("./images/extrusion-die-swell-die-shape.png", width: 70%)

=== Shark skin and melt fracture defects
These are distortions of the extrudate which can take different aspects. They
are triggered due to the high shear stresses at the wall.

#grid(
    columns: 2,
    column-gutter: 3em,
    align: center + horizon,
    image("./images/extrusion-shark-skin-1.png"),
    image("./images/extrusion-shark-skin-2.png"),
)

== Injection moulding
- In injection moulding, the polymer is heated to a highly plastic state and
    forced to flow under high pressure into a mould cavity where it solidifies
    and the moulding is then removed from the cavity.
- Produces discrete components that are almost always to net shape.
- Typical cycle time is about 10 to 30 seconds, but cycles of one minute or more
    are not uncommon.
- The mould may contain multiple cavities, so multiple parts can be produced in
    each cycle.
- Complex and intricate shapes are possible.
- Shape limitations:
    - Capability to fabricate a mould whose cavity is the same geometry as the
        part.
    - Shape must allow for part removal from the mould.
- Part size ranges from #qty[5][g], like a LEGO, to #qty[25][kg], like
    automobile bumpers.
- Injection moulding is economical only for large quantities due to the *high
    cost of the mould*.

=== Components
#cimage("./images/injection-moulding-components.png", width: 80%)

=== Cycle
#cimage("./images/injection-moulding-cycle.png", height: 25em)
#pagebreak()

=== Process
#[
    #let image-height = 13em
    + The mould is first closed.
        #cimage(
            "./images/injection-moulding-process-1.png",
            height: image-height,
        )
    + The polymer melt is then injected into the cavity.
        #cimage(
            "./images/injection-moulding-process-2.png",
            height: image-height,
        )
    + The screw is retracted.
        #cimage(
            "./images/injection-moulding-process-3.png",
            height: image-height,
        )
    + The mould opens, and the part is ejected.
        #cimage(
            "./images/injection-moulding-process-4.png",
            height: image-height,
        )
]

=== Design
#cimage("./images/injection-moulding-design.png")
- The runners distribute the polymer melt from the sprue to the cavities.
- They should be wide enough to ensure the correct amount of melt fills the
    cavities.
- Cooling takes place along the runner walls.
- Important factors to consider are:
    - Shape and dimensions
    - Flow in secondary runners
    - The cold-well extensions

==== Shape and dimensions
Round shapes are the best, but are difficult to machine.
#cimage("./images/injection-moulding-runner-shapes.png")
#pagebreak()

==== Flow in secondary runners
The runners on the right are preferred as they minimise shear on the polymer
melt.
#cimage("./images/injection-moulding-flow-types.png")

==== Cold-well extensions
The cold-well extensions go beyond the runner to prevent the melt from cooling
at the gate and blocking the flow.
#cimage("./images/injection-moulding-cold-well-extensions.png")
#pagebreak()

=== Shrinkage
- The cavity in the mould has the geometry of the part, but is usually *slightly
    oversized* to allow for shrinkage that happens when the part cools down.
- Polymers have high thermal expansion coefficients.
- Typical values of shrinkage:
    #table(
        columns: 2,
        table.header([*Polymer*], [*Shrinkage (#unit[mm mm^-1])*]),

        [Nylon 6,6], [0.020],
        [Polyethylene], [0.025],
        [Polystyrene], [0.004],
        [PVC], [0.005],
    )
- The dimensions of the mould cavity must be larger than the specified part
    dimensions:
    $ D_c = D_p + D_p S + D_p S^2 = D_p (1 + S + S^2) $

    Where:
    - $D_c$ is the dimension of the cavity
    - $D_p$ is the moulded part dimension (nominal size)
    - $S$ is the shrinkage value.

    Example:
    $ "Nominal length:" D_p = #qty[50.0][mm] $
    $ "Shrinkage value:" S = 0.025 $
    $ D_c = 50.0 + 50.0 times 0.025 + 50.0 times (0.025)^2 = #qty[51.28][mm] $

==== Factors affecting shrinkage
- The injection pressure, as higher pressure forces more material into the
    cavity and reduces the shrinkage.
- Compaction time, as longer compaction times also forces more material into the
    cavity and reduces the shrinkage.
- Moulding temperature, as higher temperatures lower the polymer melt viscosity
    and leads to more packing in the cavity and hence lower shrinkage.
- Thicker parts have higher shrinkage.

#pagebreak()

=== Mould types

==== Two-plate mould
+ The mould is closed. The mould has two cavities to produce two cup-shaped
    parts with each injection shot.
    #cimage("./images/injection-moulding-two-plate-mould-1.png", height: 20em)
+ It opens and liberates the 2 cups attached to the sprue.
    #cimage("./images/injection-moulding-two-plate-mould-2.png", width: 80%)
+ The ejector pins built into the moving half of the mould usually pushes the
    part out of the cavity.
    #cimage("./images/injection-moulding-two-plate-mould-3.png", height: 15em)

- The mould also contains a cooling system which consists of pumps circulating
    cool water to remove heat from the plastic.
- Air vents are also in the mould to remove air from the cavity as the polymer
    melt comes in.

==== Three-plate mould
- This mould separates the part from the sprue and the runner when the mould
    opens.
- Advantages over the two-plate mould:
    - As the mould opens, the runner and the parts disconnect and drop into two
        containers under the mould.
    - It allows automatic operation of the moulding machine.

#cimage("./images/injection-moulding-three-plate-mould.png", width: 80%)

==== Hot-runner mould
- This mould eliminates solidification of the sprue and runner by locating
    heaters around the corresponding runner channels.
- While the plastic in the mould cavity solidifies, the material in the sprue
    and the runner channels remains molten, ready to be injected into the cavity
    in the next cycle.
- The advantage of this type of mould is that it saves material that would
    otherwise be scrap.

#pagebreak()

=== Defects in injection moulding
- *Short shot*, resulting in incomplete mould filling.
- *Flash*, which happens when too much material is injected and leaks from the
    cavity.
- *Sink marks and voids*, which are usually due to moulded sections that are too
    thick and have insufficient material to compensate for the shrinkage.
- *Weld line*, which occurs when the polymer flows around a core or other convex
    section and meet.

#figure(
    image("./images/injection-moulding-weld-line-example.png"),
    caption: [Example of a weld line],
)

#figure(
    image("./images/injection-moulding-weld-line-formation.png"),
    caption: [The formation of a weld line.],
)

#pagebreak()

=== Characteristic features of injection moulded products
All injection moulded parts have small dots where the material was injected.
#cimage("./images/injection-moulding-dot.png", height: 15em)

Sometimes, it is possible to see where the 2 parts of the moulds were.
#cimage("./images/injection-moulding-line.png", height: 15em)

It is also sometimes possible to see where the ejection pins were.
#cimage("./images/injection-moulding-ejection-pin-marks.png")

== Compression moulding
Compression moulding is used to make parts like electrical plugs, sockets, and
housings, as well as pot handles, dinnerware plates, etc.

=== Steps
- (1): The polymer granules are loaded.
- (2) and (3): The granules are compressed and melted.
- (4): The part is cooled, and the mould opens.

#cimage("./images/compression-moulding-steps.png")

=== Moulds
- Compression moulding moulds are simpler than injection moulding moulds. There
    is no sprue or runner system.
- The process is generally limited to simple part geometries.
- The mould must be heated to melt the granules, usually by electrical
    resistance, steam, or hot oil circulation.

== Transfer moulding
- Transfer moulding is a modified form of compression moulding where the polymer
    enters the mould cavity as a fluid and not granules.
- This process is for *thermosets*.
    + The charge is loaded into a chamber that is close to the heated mould
        cavity.
    + Pressure is then applied to force the polymer to flow into the heated
        mould where it will cure (chemically cross-link).
- Two variants:
    - *Pot transfer moulding*, which is when the charge is injected from a pot
        through a vertical sprue channel into the cavity.
    - *Plunger transfer moulding*, which is when the plunger injects the charge
        from a headed well, through the channels, and into the cavity.

#pagebreak()

=== Pot transfer moulding process
+ The charge is loaded into the pot.
+ The liquid thermoset is pressed into the mould cavity and cured.
+ The part is ejected.

#cimage("./images/pot-transfer-moulding-process.png")

=== Plunger transfer moulding process
+ The charge is loaded into the pot.
+ The liquid thermoset is the heated well is pressed laterally into the mould
    cavity and cured.
+ The part is ejected.

#cimage("./images/plunger-transfer-moulding-process.png")

=== Versus compression moulding
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        - In both processes, scrap is produced each cycle as leftover material,
            which is also called the cull.
        - The thermoset scrap cannot be recovered.
        - Transfer moulding is capable of moulding more intricate part shapes
            than compression moulding as the polymer enters the cavity as a
            fluid, but not as intricate as injection moulding.
        - Transfer moulding is very good for moulding with inserts, in which a
            metal or ceramic insert is placed into a cavity prior to injection,
            and the plastic bonds to the insert during the moulding, like for an
            integrated circuit, shown on the right.
    ],
    image("./images/transfer-moulding-integrated-circuit.png", height: 12em),
)

=== Moulding with inserts
#cimage("./images/transfer-moulding-with-inserts.png")

== Blow moulding
- Blow moulding is used to produce one-piece hollow parts with thin walls.
- Some examples include plastic bottles and hollow containers.
- This manufacturing method is *only for thermoplastics*, and PE is the most
    common.

=== Process
- In blow moulding, air pressure is used to inflate soft plastic into a mould
    cavity.
- This is done in 2 steps:
    + Fabrication of a starting tube, called a parison.
    + Inflation of the tube to the desired final shape.

- The parison can be accomplished by extrusion or injection moulding.
#cimage("./images/blow-moulding-parison.png", height: 20em)
#pagebreak()

==== Extrusion blow moulding
#[
    #set enum(numbering: "(1)")
    + Extrusion of the parison
    + The parison is pinched at the top and sealed at the bottom around a metal
        blow pin as the two halves of the mould come together.
    + The tube is inflated so that it takes the shape of the mould cavity.
    + The mould is opened to remove the solidified part.
]
#cimage("./images/blow-moulding-extrusion.png")

==== Injection blow moulding
#cimage("./images/blow-moulding-injection.png")
#[
    #set enum(numbering: "(1)")
    + The parison is injection moulded around a blowing rod.
    + The injection mould is opened and the parison is transferred to a blow
        mould.
    + The soft polymer is inflated to conform to the blow mould.
    + The blow mould is opened, and the blown product is removed.
]

#pagebreak()

==== Stretch blow moulding
- Stretch blow moulding is a variation of injection blow moulding in which the
    blowing rod stretches the soft parison for a more favourable stressing of
    the polymer compared to conventional blow moulding.
- The resulting structure is more rigid, more transparent, and more impact
    resistant.
- The most widely used material is polyethylene terephthalate (PET), which has
    very low permeability and is strengthened by stretch blow moulding.
- Process:
    #[
        #set enum(numbering: "(1)")
        + Injection moulding of the parison.
        + Stretching
        + Blowing
    ]
#cimage("./images/blow-moulding-stretch.png")

=== Characteristics of blow moulded products
#cimage("./images/blow-moulding-characteristics.png")

== Thermoforming
- A flat thermoplastic sheet or film is heated and deformed into a desired shape
    using a mould.
- Heating is usually accomplished by radiant electric heaters located on one or
    both sides of the starting plastic sheet or film.
- It is widely used in packaging of products and to fabricate large items such
    as bathtubs, contoured skylights, and internal door liners for
    refrigerators.
#cimage("./images/thermoforming.png")
#pagebreak()

=== Vacuum thermoforming
#[
    #let image-height = 12.8em
    + A flat plastic sheet is softened by heating.
        #cimage("./images/thermoforming-vacuum-1.png", height: image-height)
    + The softened sheet is placed over a concave mould cavity.
        #cimage("./images/thermoforming-vacuum-2.png", height: image-height)
    + A vacuum draws the sheet into the cavity.
        #cimage("./images/thermoforming-vacuum-3.png", height: image-height)
    + Plastic hardens on contact with the cold mould surface, and the part is
        removed and subsequently trimmed from the web.
        #cimage("./images/thermoforming-vacuum-4.png", height: image-height)
]

=== Pressure thermoforming
- A higher pressure (3 to #qty[4][atm]) can be used.
- Vacuum thermoforming is limited to #qty[1][atm].

#cimage("./images/thermoforming-pressure.png")

=== Mechanical thermoforming
This method allows better dimensional control, and can add surface detail on
both sides, but it is more costly.
#cimage("./images/thermoforming-mechanical.png")
#pagebreak()

= Metal casting
- Casting is a process where a molten metal flows by gravity, or another force,
    in a mould cavity and solidifies there.
- There are 3 steps to casting:
    + Melt the metal
    + Pour the metal into a mould
    + Let it cool
- Note that the word "casting" also refers to the part that has been made by
    casting.
- Metal casting is a net shape or near net shape process and can produce complex
    3D shapes with little to no post-processing needed.

== Advantages and disadvantages
#table(
    columns: 2,
    align: horizon,

    table.header([*Advantages*], [*Disadvantages*]),

    [Complex parts], [Limitations on mechanical properties],

    [External and internal shapes], [Poor dimensional accuracy],

    [Can be net shape or near net shape], [Poor surface finish],

    [Small and large shapes], [Safety (hot metals)],

    [Small and large number of parts], [Environmental pollution],
)

== Types of cast parts
Metal casting can make a large range of parts:
#cimage("./images/metal-casting-part-range.png")

=== Large parts
The parts made by metal casting can be very large, such as engine blocks and
heads for automotive vehicles, wood burning stoves, machine frames, railway
wheels, pipes, church bells, big statues, pump housings, etc.

#figure(
    image("./images/metal-casting-large-part.png"),
    caption: [
        This part required 600 tonnes of liquid steel to be poured and weighed
        325 tonnes (#qty[325000][kg]). Since the density of steel is about
        #qty[8000][kg m^-3], it requires #qty[75000][m^3] of liquid steel.
    ],
)

The casting of large parts is usually done in a foundry.
#cimage("./images/metal-casting-foundry.png")

Electric arc or induction furnaces are used to melt the metal.
#cimage("./images/metal-casting-furnaces.png", width: 75%)

Safety equipment is obviously required.
#cimage("./images/metal-casting-safety-equipment.png", width: 75%)

Automated robotic arms are also implemented.
#cimage("./images/metal-casting-robotic-arms.png", width: 75%)

=== Small parts
The cast parts can also be very small, and may include delicate features, such
as dental crowns, jewellery, frying pans, phone casings, etc.
#cimage("./images/metal-casting-small-part.png")

For small parts, the equipment needed can be placed on top of a bench.
#cimage("./images/metal-casting-bench-top.png")
#pagebreak()

== Casting mould
- The mould contains the cavity whose geometry will determine the part shape.
- The mould can be made of a variety of materials, including sand, plaster,
    ceramic and metal.
- Note that the actual size and shape of the cavity must be slightly enlarged to
    allow for shrinkage of the metal during solidification and cooling.
- There are 2 types of mould:
    #[
        #set enum(numbering: "(a)")
        + Open mould
        + Closed mould for more complex geometry and gating system leading to
            the cavity.
    ]

    #cimage("./images/metal-casting-mould-types.png", width: 80%)

=== Terminology

==== Cope
The cope is the upper half of the mould.

==== Drag
The drag is the bottom half of the mould.

==== Flask
The flask is the box that contains the mould.

==== Parting line
The parting line is the line that separates the 2 halves of the mould.

#pagebreak()

=== Making the mould
#[
    #let image-height = 14em
    - Sand casting is one of the most popular types of casting.
    - In sand casting, the mould is formed by packing sand around the pattern.
    - The sane is moist and contains a bind to help maintain its shape.
    - After removing the pattern, the cavity is obtained.
    - A core can be added if a section of the desired part is hollow.
        #cimage("./images/metal-casting-core.png", height: image-height)
    - In the mould, the parts that connect the cavity to the outside are called
        the gating system.
    - They are the channels through which molten metal flows into the cavity.
    - They include the downsprue and the pouring cup.
        #cimage(
            "./images/metal-casting-gating-system.png",
            height: image-height,
        )
    - Since the metal will shrink during cooling, we need to make sure there is
        enough metal entering the cavity to avoid having defects.
    - For this, a part called is riser is used, which functions like a
        reservoir.
    - In the riser, the metal is liquid, so the riser must be designed such that
        the metal in the riser will solidify after the main casting has
        solidified.
        #cimage("./images/metal-casting-riser.png", height: image-height)
]

== Fluid flow
- Molten metal has very low viscosity, like water.
- At the same time, the hot liquid metal will cool down and solidify.
- Hence, it is fundamental to understand the physics of the fluid flow in the
    mould and its simultaneous solidification to achieve good castings.
- Metals like mercury or gallium are liquid at room temperature, and flow like
    water.
    #cimage("./images/metal-casting-mercury-and-gallium.png")
- In the mould the metal flows from the pouring cup into the gating system
    (downsprue and runner), reaches the reservoir (the riser), then fills up the
    cavity.
    #cimage("./images/metal-casting-flow-direction.png")
- There are 2 basic principles of fluid flow that apply here:
    - The law of mass continuity
    - The Bernoulli's theorem

#pagebreak()

=== Law of mass continuity
The law of mass continuity states that there is a *conservation of the
volumetric flow rate*:
$ Q = A times v = "constant" $

Where:
- $Q$ is the volumetric flow rate
- $A$ is the cross-section area of the liquid
- $v$ is the velocity of the flow

#figure(
    image("./images/metal-casting-mass-continuity.png"),
    caption: $ Q = A_1 times v_1 = A_2 times v_2 $,
)

=== Bernoulli's theorem
Bernoulli's theorem states that for incompressible fluids, like liquid metals:
$
    frac(p_1, rho g) + frac(v_1^2, 2g) + h_1
    = frac(p_2, rho g) + frac(v_2^2, 2 g) + h_2 + f
$

Where:
- $rho$ is the density
- $g$ is the gravitational acceleration, #qty[9.81][m s^-2]
- $h$ is the height of the fluid
- $p$ is the pressure of the fluid
- $v$ is the velocity of the fluid flow
- $f$ is the friction

#pagebreak()

==== In metal casting
Assuming $f = 0$:

#cimage("./images/metal-casting-bernoulli.png")

If the pressure is *constant*, then $p_1 = p_2$. Hence:
$
    frac(p_1, rho g) + frac(v_1^2, 2g) + h_1
    = frac(p_2, rho g) + frac(v_2^2, 2 g) + h_2 + f
$
$
    cancel(frac(p_1, rho g)) + cancel(frac(v_1^2, 2g)) + h_1
    = cancel(frac(p_2, rho g)) + frac(v_2^2, 2 g) + h_2 + cancel(f)
$
$ h_1 - h_2 = h = frac(v_2^2, 2 g) $
$ v_2 = sqrt(2 g h) $

=== Laminar and turbulent flow
- Knowing the velocity of the fluid flow allows tuning of the mould design to
    avoid turbulence, which might create defects.
- Turbulence is the formation of big "waves" or vortices in the flow stream.
- A laminar flow is usually desired to ensure the liquid fills the entire
    cavity.

#cimage("./images/metal-casting-laminar-and-turbulent-flow.png")
#pagebreak()

==== Reynolds number
To determine if the flow is laminar or turbulent, fluid mechanics provides a
number called the Reynolds number.
$ "Re" = frac(rho v d, eta) $

Where:
- Re is the Reynolds number
- $rho$ is the density
- $v$ is the velocity of the fluid flow
- $d$ is a characteristic length scale, typically the diameter of the channel
    where the fluid is flowing
- $eta$ is the viscosity

If Re < 2,000, the flow is laminar.

If Re > 20,000, the flow is turbulent.

#cimage("./images/metal-casting-laminar-and-turbulent-flow-example.png")
#pagebreak()

== Solidification
- After filling the cavity, the hot liquid metal will cool down and solidify.
- It is important to note that the solidification of pure metals and the
    solidification of metallic alloys are *different*.

=== Pure metals
The solidification happens at a *single* temperature.
#cimage("./images/solidification-pure-metal-graph.png", width: 70%)

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        - The characteristic grain structure after casting a pure metal shows
            randomly oriented grains near the wall of the mould, and large
            columnar grains oriented toward the centre of the casting.
        - The skin forms because of the cooling action from the mould.
        - How fast the metal solidifies depends on the heat transfer between the
            mould and the metal.
    ],
    image("./images/solidification-pure-metal-grain-structure-1.png"),
)

#cimage("./images/solidification-pure-metal-grain-structure-2.png", width: 80%)

=== Metallic alloy
The solidification happens over a *range* of temperatures.
#cimage("./images/solidification-metallic-alloy-graph.png")

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        - The characteristic grain structure after casting an alloy shows
            randomly oriented grains near the wall of the mould, large columnar
            grains oriented toward the centre of the casting, and *segregation*
            of alloying components at the centre of the casting.
    ],
    image("./images/solidification-metallic-alloy-grain-structure-1.png"),
)

#cimage("./images/solidification-metallic-alloy-grain-structure-2.png")

=== Fluidity
In metal casting, liquid metal is poured into a mould. The capability of molten
metal to fill the mould cavity is called *fluidity*. It is controlled by:
+ The characteristics of the molten metal:
    - The *viscosity*: When the viscosity increases, the fluidity decreases.
    - The *surface tension*: When the surface tension increases, the fluidity
        decreases.
    - The *solidification pattern*: When the metal has a short freezing range,
        the fluidity is high.
    - The presence of inclusions in the metal which have an adverse effect.
+ The casting parameters:
    - Mould design.
    - Mould materials and surface properties.
    - Rate of pouring.
    - Heat transfer, etc.

==== Spiral mould
- To determine the fluidity of a metal for metal casting, a *spiral mould* is
    used.
- The fluidity index is the length of solidified metal in the spiral passage.
- The greater the length of the solidified metal, the greater is the fluidity.

#cimage("./images/solidification-spiral-mould.png", height: 15em)
#figure(
    image("./images/solidification-spiral-mould-examples.png", height: 22em),
    caption: [
        A356 alloy has a higher fluidity than AlSi#sub[3].5MgO.5CuO#sub[4]
        alloy.
    ],
)

#pagebreak()

=== Solidification time
- Most commercial castings are made of alloys instead of pure metals.
- Alloys are generally easier to cast, and the properties of the products are
    better.
- The determination of the solidification time is critical for successful
    casting.
- The total solidification time (TST), is the time required for the casting to
    solidify after pouring.
- The total solidification time depends on the size and shape of the casting and
    is calculated using Chvorinov's rule:
    $ "Chvorinov's rule:" T_"ST" = C_m (V/A)^n $

    Where:
    - $T_"ST"$ is the total solidification time
    - $V$ is the volume of the casting
    - $A$ is the surface area of the casting
    - $n$ is an exponent with a typical value of 2
    - $C_m$ is the mould constant

- The mould constant depends on the mould material, thermal properties of the
    casting metal, and the pouring temperature relative to the melting point.
- The mould constant can be determined by experiment, using the same mould
    material, casting metal, and pouring temperature.
- Chvorinov's mould constant takes into account the metal properties till
    solidification only.

==== Chvorinov's rule
- Chvorinov's rule tells us:
    - How much hot metal is needed to fill the mould.
    - How long it will take for the metal to solidify.
- Castings with a higher volume to surface ratio (high $V/A$) have a longer
    total solidification time.
- These have implications when designing a riser so that the main casting
    solidifies first and hence minimises shrinkage.
- The total solidification time for the riser should be higher than that of the
    main cast.

$ "Chvorinov's rule:" T_"ST" = C_m (V/A)^n $

Where:
- $T_"ST"$ is the total solidification time
- $V$ is the volume of the casting
- $A$ is the surface area of the casting
- $n$ is an exponent with a typical value of 2
- $C_m$ is the mould constant

#pagebreak()

==== Example
Three metal pieces of the *same volume*, but of different shapes are cast, a
sphere, a cube and a cylinder of height that is equal to its diameter.

Which piece will solidify the fastest and which the slowest?

#table(
    columns: 3,
    stroke: none,

    image("./images/solidification-sphere.png"),
    image("./images/solidification-cube.png"),
    image("./images/solidification-cylinder.png"),

    $ V = 4/3 pi R^3 $, $ V = L^3 $, $ V = 2 W times pi W^2 = 2 pi W^3 $,

    table.cell(colspan: 3)[We assume $V = 1$, therefore:],

    $ R = root(3, frac(3, 4 pi)) = 0.62 $,
    $ L = 1 $,
    $ W = root(3, frac(1, 2 pi)) = 0.54 $,

    table.cell(colspan: 3)[The surface areas are:],

    $ A_1 = 4 pi R^2 = 4.83 $,
    $ A_2 = 6 $,
    $ A_3 = 2 pi W^2 + 2 pi W times 2 W = 5.49 $,
)

- Chvorinov's rule tells us that a larger $V/A$ leads to longer total
    solidification time.
- Therefore, for a constant volume, a smaller surface area leads to longer total
    solidification time.
- Since the sphere has the smallest surface area, the shape leading to the
    longest total solidification time is the sphere.
- Since the cube has the largest surface area, the shape leading to the smallest
    total solidification time is the cube.

#pagebreak()

==== Numerical example
We want to cast a cube of aluminium of width #qty[1][cm]. Given the casting
mould constant is #qty[90][s cm^-2], determine the total solidification time.

$ V = #qty[1][cm^3] $
$ A = A #unit[cm^3] $

Using Chvorinov's:
$ T_"ST" = C_m (V/A)^n $
$ T_"ST" = 90 (1/6)^2 = #qty[2.5][s] $

We want to design a riser for that cube. The riser should be a cylinder of
#qty[0.5][cm] radius. What is the height $L$ of the riser so that its total
solidification time is twice that of the casting?

$ (T_"ST")_"riser" = #qty[5][s] $
$ V_"riser" = L times pi R^2 = 0.25 pi L $
$ A_"riser" = 2 pi T^2 + 2 pi R times L = 1.57 + pi L $

$
    V/A = frac(0.25 pi L, 1.57 + pi L)
    = sqrt(frac((T_"ST")_"riser", C_m) = 0.24)
$

Therefore:
$ 0.25 pi L - 0.24 pi L = 0.24 times 1.57 $
$ L = #qty[12][cm] $

== Shrinkage
Chvorinov's contains information until solidification. It is important to know
how much the part will shrink to compensate for it and have high accuracy.
- Liquid contraction: Hot liquid #sym.arrow cold liquid
- Solidification shrinkage: Solidification at $T_m$ (Liquid + solid)
- Solid contraction: Hot solid #sym.arrow cold solid

#pagebreak()

=== Process
Shrinkage occurs due to thermal contraction when the metal cools.
#{
    set enum(numbering: "(a)")
    table(
        columns: 2,
        stroke: none,
        align: horizon,

        enum(
            [The hot molten metal is poured.],
            [The level of metal is reduced due to shrinkage.],
        ),
        image("./images/metal-casting-shrinkage-steps-1-2.png"),

        enum(
            start: 3,

            [The height gets further reduced, and a cavity starts to form.],
            [
                The heights and diameter of the casting get further reduced
                while the cavity expands.
            ],
        ),
        image("./images/metal-casting-shrinkage-steps-3-4.png"),
    )
}

=== Compensation for shrinkage
- The materials at the outside periphery of the casting cavity solidifies and
    shrink first.
- If no additional molten metal can come into the casting cavity to fill in the
    gaps caused by the shrinkage, then a vacuum or cavity is formed.
- To compensate the shrinkage, a shrinkage allowance is added in the mould
    design.
- Pattern makers account for the solidification shrinkage and the thermal
    contraction by making the mould cavity *oversized*.
- The amount by which the mould is made larger relative to the final casting
    size is called the *pattern shrinkage allowance*.
- The table below shows the solidification shrinkage (or contraction) for
    various cast metals.
    #table(
        columns: 4,

        table.header(
            [*Metal or alloy*],
            [*Volumetric solidification contraction (%)*],
            [*Metal or alloy (%)*],
            [*Volumetric solidification contraction (%)*],
        ),

        [Aluminium], [6.6], [70% Cu - 30% Zn], [4.5],
        [Al - 4.5% Cu], [6.3], [90% Cu - 10% Al], [4],
        [Al - 12% Si], [3.8], [Gray iron], [Expansion to 2.5],
        [Carbon steel], [2.5 - 3], [Magnesium], [4.2],
        [1% carbon steel], [4], [White iron], [4 - 5.5],
        [Copper], [4.9], [Zinc], [6.5],
    )

    For gray iron, there is no shrinkage, while *aluminium* and *zinc* have a
    high percentage of shrinkage.

#pagebreak()

=== Example
Mould makers design a pattern for die casting of zinc. Given that for zinc, the
linear shrinkage value due to solid thermal contraction is 2.8%, what should be
the length of the pattern in #unit[cm] if the nominal length of the part is
#qty[20][cm]?

$ "Part length" = "Pattern length" space (L) times (1 - 2.8%) $

#grid(
    columns: 3,
    column-gutter: 3em,
    align: horizon,

    [Right after solidification],
    image("./images/shrinkage-right-after-solidification.png"),
    $ #qty[20][cm] = L times (1 - 0.028) $,

    [Right after solidification],
    image("./images/shrinkage-after-cooling.png"),
    $ L = frac(#qty[20][cm], 1 - 0.028) = #qty[20.5761][cm] $,
)

=== Reason for shrinkage
- The solidification shrinkage occurs in nearly all metals because the solid
    phase has a higher density than the liquid phase.
- Thus, solidification causes a reduction in volume per unit weight of metal.
- An *exception* is cast iron with high carbon content.
- In this iron, graphitisation, which is the formation of graphite flakes,
    occurs during the final stages of freezing that causes expansion.
- The expansion counteracts volumetric decrease associated with the liquid-solid
    transformation.

#cimage("./images/shrinkage-graphitisation.png")

#cimage("./images/shrinkage-graphitisation-process.png", height: 20em)

=== Minimising shrinkage
- The regions of the casting that are the most distant from the supply of the
    molten metal in the riser will freeze first.
- Then, the solidification progresses from these distant regions towards the
    riser.
- Thanks to the riser, there is a continuous supply of molten metal.
- This is known as *directional solidification*.
- To achieve directional solidification:
    + Use Chvorinov's rule to design the casting, the orientation of the mould
        and the riser system.
    + Place the sections with lower $V/A$ ratios away from the riser. These
        sections will solidify first.
    + Identify internal or external heat sinks that cause rapid freezing in
        certain regions of the casting.
- The riser is a waste product that is separated from the casting and re-melted
    for further use.
- To minimise waste, the volume of metal in the riser is minimised.
- Even though the geometry of the riser is to maximum $V/A$, it is possible to
    reduce the riser volume.

== Common defects and design considerations
- Metallic projections
- Cavities
- Discontinuities
- Defective surface
- Incomplete casting
- Incorrect dimensions or shape
- Inclusions

#cimage("./images/metal-casting-common-defects.png")
#pagebreak()

=== Hot tears
- Hot tears occur because the casting cannot shrink freely during cooling, due
    to constraints in various portions of the mould and cores.
- Hot tears may be avoided by carefully controlling the cooling in critical
    sections using exothermic (heat-producing) compounds (like exothermic
    padding).

#cimage("./images/metal-casting-hot-tears-1.png")
#cimage("./images/metal-casting-hot-tears-2.png")

=== External chills
Difference with and without external chills to cool down thick sections in a
casting:
#cimage("./images/metal-casting-external-chills.png")

=== Internal chills
#cimage("./images/metal-casting-internal-chills.png", height: 15em)

- Internal chills may be placed inside thick liquid regions to control the
    solidification rate and prevent tearing.
- They may also be left inside the casting after it has solidified.

=== Short shot or misrun
#cimage("./images/metal-casting-short-shot.png")

=== Inclusion
#cimage("./images/metal-casting-inclusion.png")

=== Shrinkage porosity
#cimage("./images/metal-casting-shrinkage-porosity.png")

=== General product design considerations
- Geometric simplicity to improve castability.
- Avoid sharp corners and angles.
- Generous fillets should be designed on inside corners and sharp edges should
    be blended.

=== Casting design modifications
- Sharp corners are to be avoided to reduce stress concentration and the
    formation of cracks.
    #cimage("./images/metal-casting-sharp-corners.png", height: 15em)
- Add a draft angle to facilitate the removal of the part from the mould.
    #cimage("./images/metal-casting-draft-angle.png", height: 15em)
- Avoid hot spots and use small cores to prevent cavities.
    #cimage("./images/metal-casting-small-cores.png")
- It is important to maintain a uniform cross-section in the casting.
    #cimage("./images/metal-casting-uniform-cross-section.png")

=== Dimensional tolerances and surface finish
- Poor dimensional accuracies and finish for sand casting.
- Good dimensional accuracies and surface finish for die casting and investment
    casting.

#cimage("./images/metal-casting-surface-finish.png")

=== Machining allowances
- Almost all sand castings must be machined to achieve the required dimensions
    and part features.
- An additional material, called machining allowance, must be left on the
    casting for those surfaces where machining is necessary.

=== Additional steps after solidification (post-processing)
- Trimming
- Removing the core
- Surface cleaning
- Inspection
- Repair, if required
- Heat treatment

#pagebreak()

== Metal casting processes
There are 2 categories of casting processes:
- *Expendable mould processes*, which use an expendable mould which must be
    destroyed to remove the casting.
    - The mould is made of sand or plaster.
    - It allows more intricate geometries.
- *Permanent mould processes*, which use a permanent mould which can be used to
    produce many castings.
    - The mould is made of metal or a ceramic refractory material.
    - The shapes of the parts are limited by the need to open the mould at the
        end.
    - They are economical for mass production

#cimage("./images/metal-casting-categories.png", width: 80%)

=== Sand casting (expendable mould)
- Most widely used casting process.
- Nearly all alloys can be sand casted.
- Size ranges from small to very large.
- Production quantities range from one to millions.

#cimage("./images/metal-casting-sand-casting.png")

=== Investment casting (expendable mould)
- Also known as lost wax process.
- A pattern made of wax is coated with a refractory material to make a mould.
- The wax is then melted away.
- "Investment" comes from one of the definitions of invest, which is to cover
    completely.
- It is a precision casting process.

#cimage("./images/metal-casting-investment-casting-1.png", width: 80%)
#cimage("./images/metal-casting-investment-casting-2.png")

==== Steps
#{
    set enum(numbering: "(1)")
    let image-height = 15em
    align(center, table(
        columns: 2,
        stroke: none,
        align: (left, center),

        enum(
            start: 1,
            [Make the wax pattern.],
            [
                Several patterns are attached to a *sprue* to form a pattern
                tree.
            ],
        ),
        image(
            "./images/metal-casting-investment-casting-steps-1-2.png",
            height: 15em,
        ),

        enum(
            start: 3,
            [
                The pattern tree is coated with a thin layer of refractory
                material.
            ],
            [
                It is then covered with a thicker layer of refractory material
                to make it rigid.
            ],
        ),
        image(
            "./images/metal-casting-investment-casting-steps-3-4.png",
            height: 15em,
        ),

        enum(
            start: 5,
            [
                The mould is held in an inverted position and heated to melt the
                wax and permit it to drip out of the cavity.
            ],
        ),
        image(
            "./images/metal-casting-investment-casting-step-5.png",
            height: 25em,
        ),

        enum(
            start: 6,
            [
                The mould is preheated to a high temperature, which ensures that
                all contaminants are eliminated. It also permits liquid metal to
                flow easily into the detailed cavity. The molten metal is poured
                and solidifies in the cavity.
            ],
        ),
        image(
            "./images/metal-casting-investment-casting-step-6.png",
            height: 20em,
        ),

        enum(
            start: 7,
            [
                The mould is then broken away from the finished casting. Parts
                are separated from the sprue.
            ],
        ),
        image(
            "./images/metal-casting-investment-casting-step-7.png",
            height: 15em,
        ),
    ))
}

==== Advantages
- Can cast complex and intricate parts.
- High accuracy and good surface finish.
- Wax can usually be reused.
- Additional machining is not normally required as it is a *net shape process*.

==== Disadvantages
- Many processing steps.
- Relatively expensive.

=== Overview of permanent mould casting processes
- In permanent mould casting, the mould is reused many times.
- The processes include:
    - Basic permanent mould casting
    - Die casting
    - Centrifugal casting
- It uses a metal mould constructed of 2 sections designed for easy and precise
    opening and closing.
- Moulds used for casting lower melting point alloys are commonly made of steel
    or cast iron.
- Moulds used for casting steel must be made of refractory material, due to very
    high pouring temperatures.

#pagebreak()

==== Steps
#[
    #set enum(numbering: "(1)")
    + The mould is preheated and coated
        #cimage("./images/metal-casting-permanent-mould-step-1.png", width: 90%)
    + Cores, if used, are inserted and the mould is closed.
        #cimage(
            "./images/metal-casting-permanent-mould-step-2.png",
            height: 18em,
        )
    + The molten metal is poured into the mould.
        #cimage(
            "./images/metal-casting-permanent-mould-step-3.png",
            height: 20em,
        )
]

==== Advantages
- Good dimensional control and surface finish.
- Finer grain structure, so stronger castings are produced.

==== Disadvantages
- Generally limited to metals of lower melting points.
- Simple part geometries compared to sand casting.
- High cost of mould.

==== Applications
- Permanent mould casting is best suited to mass and automatic production.
- Typical parts include automotive pistons, pump bodies, certain castings for
    aircraft and missiles.
- Metals that are commonly cast include aluminium, magnesium copper-based
    alloys, and cast iron.

=== Die casting (permanent mould)
- Die casting is a permanent mould casting process where molten metal is
    injected into the mould cavity under high pressure.
- The pressure is maintained during the solidification, then the mould is
    opened, and the part is removed.
- Moulds in this casting operation are called dies.
- The use of high pressure is to force the metal into the die cavity, and it is
    what distinguishes this process from other permanent mould processes.
- The die casting machines are designed to hold and accurately close two mould
    halves and keep them closed while liquid metal is forced into the cavity.
- There are two main types:
    + Cold-chamber machine
    + Hot-chamber machine

==== Cold-chamber machine
- The molten metal is poured into the unheated chamber and the piston injects
    the metal into the die cavity.
- Casting metals include Al, brass, and Mg alloys.
- It is not as efficient as a hot-chamber machine.

#cimage("./images/metal-casting-cold-chamber-machine.png")

==== Hot chamber machine
- The metal is melted in a container, and the piston injects liquid metal into
    the die.
- High production rates.
- Applications limited to low melting point metals, like Zn, Sn, Pb, and Mg.

#cimage("./images/metal-casting-hot-chamber-machine.png")

==== Advantages
- Economical for large production quantities.
- Good dimensional accuracy and surface finish.
- Thin sections are possible.
- Rapid cooling provides small grown size and good strength to casting.

==== Disadvantages
- Generally limited to metals with low melting points.
- Part geometry must allow removal from the die cavity.

#pagebreak()

= Metal forming
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,

    grid.header(
        [*Bulk deformation processes*], [*Sheet metalworking processes*]
    ),

    enum(
        numbering: "(a)",
        [Rolling],
        [Forging],
        [Extrusion],
        [Wire and bar drawing],
    ),

    enum(
        start: 5,
        numbering: "(a)",
        [Shearing (blank or punch)],
        [Bending],
        [Drawing],
        [Others, like stretching],
    ),

    image("./images/bulk-deformation-process-examples.png"),
    image("./images/sheet-metalworking-process-examples.png"),

    figure(
        image("./images/bulk-deformation-workpieces.png"),
        caption: [Bulk deformation workpieces],
    ),

    figure(
        image("./images/sheet-metalworking-workpieces.png"),
        caption: [Sheet metalworking workpieces],
    ),
)

#pagebreak()

== Bulk deformation processes
- Material starts in bulk form.
- Operations seek to induce shape changes on the workpieces by plastic
    deformation under force application.
- Work is done by stressing metal sufficiently to cause plastic flow into
    desired shape.
- Cross-section of workpiece changes without volume change.

#cimage("./images/bulk-deformation-processes.png", height: 15em)

== Sheet metalworking processes
- *Initial form*: The thickness of sheet metal ranges from 0.4 to #qty[6][mm].
    If the thickness is greater than #qty[6][mm], it is considered a plate, not
    a sheet.
- *Rolling* is used to produce thin sheets. Operations that are usually
    performed as cold working, as the operating temperature is below 30% of the
    melting point of the metal in #unit[Kelvin].
- *Precision cutting* of the sheet ensures accurate dimensions and smooth edges.
    Cut metal sheet undergoes *bending and forming* processes to achieve the
    desired design and shape, which may have complex and intricate features.
- Low-carbon steel (0.06 to 0.15% carbon), is most commonly used.

#cimage("./images/sheet-metalworking-processes.png")

== Advantages of metal forming
#table(
    columns: 2,

    table.header(
        table.cell(align: center)[*Bulk deformation*],
        table.cell(align: center)[*Sheet metalworking*],
    ),

    [
        - Produces common shapes inexpensively.
        - Can achieve significant change in the shape of the workpiece with good
            mechanical properties.
        - Produces little to no waste by-products.
        - Achieves final product geometry with little or no post machining.
    ],
    [
        - High strength.
        - Good dimensional accuracy.
        - Good surface finish.
        - Relatively low cost.
        - Economical mass production for large quantities.
    ],
)

== Bulk deformation vs sheet metalworking
#table(
    columns: 3,

    table.header(
        align(center)[*Characteristics*],
        align(center)[*Bulk deformation*],
        align(center)[*Sheet metalworking*],
    ),

    [Process nature],
    [Significant deformation and shape change to the workpiece.],
    [
        Forming and cutting operations where applied forces modify sheet
        geometry.
    ],

    [Starting workpiece],
    [Low surface area to volume ratio.],
    [High surface area to volume ratio.],

    [Initial work shapes], [Billet, rod slab.], [Sheet.],
)

== Types of metal forming
- Bulk deformation
    - Hot or cold rolling
- Sheet metalworking
    - Blanking and punching
    - Bending
    - Drawing

=== Hot or cold rolling processes
- *Rolling* is a process in which the thickness of a workpiece is reduced by
    compressive forces exerted by 2 opposing rolls.
- Hot rolling or working (850#degreeC - 1200#degreeC for steel) is generally
    required when massive deformation of large workpieces is involved.
    - The end products are generally free of residual stress and tend to have
        isotropic properties.
    - Its limitations include difficulty in achieving close tolerances and a
        surface that exhibits oxide scale.
- Cold rolling or working (60#degreeC - 180#degreeC) is appropriate when the
    shape change is less severe, and there is a need to improve mechanical
    properties and achieve a good finish on the part.
    - Strength is increased through strain hardening.

#cimage("./images/hot-or-cold-rolling-processes.png")

== Shearing operation
- The shearing machine uses a hydraulic or mechanical system that moves the
    upper blade down with high force to cut the material against the stationary
    lower blade.
- This high force causes the material to fracture along a desired line.
- In manufacturing, this typically involves an upper blade (punch) moving
    against a stationary lower blade (die) to cut sheet metal into smaller
    pieces without creating chips or using hit.

=== Types of shearing operations
- Punching and blanking
- Shaving
- Fine blanking
- Parting, notching, perforating, etc.

==== Punching and blanking operation
Before forming a sheet-metal part, a blank of suitable dimensions is cut from a
larger sheet metal by shearing, usually using a punch and die.

#cimage("./images/punching-and-blanking.png")

==== Shaving
- Extra material from the rough sheared edge is removed to obtain a straight
    edge with good surface finish.
- *Requires very small clearance between the punch and the die*.

#cimage("./images/shaving.png", height: 25em)

==== Fine blanking
Produces parts with very smooth, square edges and good dimensional tolerance.
#cimage("./images/fine-blanking.png")

==== Comparison of blanked parts
Fine blanking:
- Very smooth and square edges.
- Good dimensional tolerance.

#cimage("./images/conventional-vs-fine-blanking.png", height: 12.5em)

==== Other shearing operations
#cimage("./images/other-shearing-operations.png", height: 20em)
#pagebreak()

== Punching and blanking: Shearing operation
- Shearing action
- Punch and die type set
- Clearance and sizing

=== Shearing action
- Sheet metal is cut by applying shear stresses between two sharp cutting edges.
- The figure below shows a flat punch and die set.

#cimage("./images/flat-punch-and-die.png", height: 15em)

=== Bevel punch and die
- *Reduces cutting force*.
- Especially suitable for thick sheet metal.

#cimage("./images/bevel-punch-and-die.png")

=== Shearing
- Cracks form on both top and bottom edges.
- Cracks eventually meet and separate the sheet metal into two pieces.
- The cut edges are not smooth and not perpendicular to the top surface.

#cimage("./images/sheared-edge-features.png", height: 15em)

=== Clearance ($c$)
The recommended clearance is calculated by:
$ c = alpha t $

Where:
- $c$ is the clearance
- $alpha$ is the allowance
- $t$ is the sheet thickness

The allowance ($alpha$) is determined according to the type of metal.
#table(
    columns: 2,

    table.header(
        table.cell(align: center)[*Metal group*],
        table.cell(align: center)[*Allowance ($alpha$)*],
    ),

    [1100S and 5052S aluminium alloys, all tempers], [0.045],

    [
        2024ST and 6061ST aluminium alloys, brass, soft cold-rolled steel, soft
        stainless steel
    ],
    [0.060],

    [Cold-rolled steel, half hard; stainless steel, half hard and full hard],
    [0.075],
)

#pagebreak()

==== Effect of clearance
*As clearance increases*:
- The sheet is pulled into the clearance zone rather than sheared, resulting in
    rougher edges.
- Burr height increases.
- Punch force decreases and die wear is reduced.

#cimage("./images/effect-of-clearance-increase.png")

When the metal *hardness increases*, the *clearance required increases*.

#table(
    columns: 2,

    table.header([*Insufficient clearance*], [*Excessive clearance*]),

    image("./images/clearance-too-small.png"),
    image("./images/clearance-too-big.png"),

    [
        When the clearance is too small, the end product will have:
        + Fracture lines passing each other.
        + A double burnishing and larger cutting force is experienced.
    ],

    [
        When the clearance is too big, the end product will have:
        + The metal becoming pinched between the cutting edges.
        + Excessive or oversized burrs.
    ],
)

=== Punching vs blanking
#cimage("./images/punching-vs-blanking.png")

=== Punch and die sizes
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,

    [
        - For a round *blank* of diameter $D_b$:
            - Blanking punch diameter is $D_b - 2c$, where $c$ is the clearance
            - Blanking die diameter is $D_b$

        - For a round *hole* of diameter $D_h$:
            - Blanking punch diameter is $D_h$
            - Blanking die diameter is $D_h + 2c$, where $c$ is the clearance
    ],
    image("./images/punch-and-die-sizes.png", height: 15em),
)

=== Angular clearance
- Angular clearance allows the slug or blank to drop through the die.
- It is typically $0.25 degree$ to $1.5 degree$ on each side.

#cimage("./images/angular-clearance.png", height: 12em)

=== Maximum punching or blanking force ($F$)
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $ F = S times "Area of cut edge" $
        $ F = S T L = 0.7 (U T S) T L $

        Where:
        - $S$ is the shear strength (#unit[MPa])
        - $T$ is the sheet metal thickness (#unit[mm])
        - $L$ is the total length sheared, or the perimeter (#unit[mm])
        - $U T S$ is the ultimate tensile strength
    ],
    image("./images/maximum-punching-or-blanking-force.png"),
)

=== Summary
- Both blanking and punching operations use a punch and set.
- In blanking:
    - The cut part, known as the blank, is the desired part.
    - Die set size is equal to the part size.
- In punching:
    - Remaining sheet is the desired part.
    - Punch set size is equal to the part size.
- Die size is always greater than the punch size.
- The size difference between the die and the punch is 2 times the clearance
    allowance.

#pagebreak()

== Bending
#cimage("./images/bending.png")

=== Operation
- The outer fibre is stretched (tensile stress).
- The inner fibre is compressed (compressive stress).
- The length at the neutral axis does not change.

#cimage("./images/bending-operation.png")

Where:
- $T$ is the sheet metal thickness
- $A'$ is the included angle
- $alpha$ is the bend angle
- $A' + alpha = 180 degree$

=== Bend allowance ($L_b$)
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        $ L_b = alpha (R + k T) $

        Where:
        - $alpha$ is the bend angle (#unit[rad])
        - $R$ is the bend radius
        - $k$ is a constant
        - $T$ is the sheet metal thickness

        $k$ lies between 0.33 and 0.5.

        Recommended values for $k$:
        $
            k = cases(
                0.33 "when" R < 2 T,
                0.5 "when" R >= 2 T,
            )
        $
    ],
    image("./images/bend-allowance.png"),
)

=== Minimum bend radius (MBR)
- Engineering strain ($epsilon$) during bending is:
    $ epsilon = frac(1, (frac(2 R, T)) + 1) $
- As the $R/T$ ratio decreases, tensile strain ($epsilon$) at the outer fibre
    increases.
- The material will eventually crack.
- The bend radius $R$ at which a crack appears is called the *minimum bend
    radius*.

#cimage("./images/minimum-bend-radius.png", width: 60%)

- The minimum bend radius is usually expressed as $2T, 3T, 4T$, etc.
- A minimum bend radius of $2T$ means that if the bend radius is smaller than
    $2T$, the outer fibre will crack.

#align(center, table(
    columns: 3,
    align: center + horizon,

    table.header(
        table.cell(rowspan: 2)[*Material*],
        table.cell(colspan: 2)[*Condition*],

        [*Soft*],
        [*Hard*],
    ),

    [Aluminium alloys], $0$, $6T$,
    [Beryllium copper], $0$, $4T$,
    [Brass, low-leaded], $0$, $2T$,
    [Magnesium], $5T$, $13T$,
    [Low-carbon, low-alloy steel], $0.5T$, $4T$,
    [Austenitic stainless steel], $0.5T$, $6T$,
))

=== Anisotropy in sheet metal
- Anisotropy refers to sheet metal exhibiting different behaviour in different
    directions.
- It is acquired during the processing of sheet metal.

#cimage("./images/sheet-metal-anisotropy.png")

There are 2 types of anisotropy:
+ Preferred grain orientation
+ Mechanical fibering (alignment of impurities, inclusions and voids)

==== Preferred grain orientation
Plastic deformation of a polycrystalline metal with idealised (equiaxed) grains
under compression, like during rolling.

#cimage("./images/sheet-metal-anisotropy-preferred-grain-orientation.png")

The grain boundaries are aligned along the horizontal direction, which is the
preferred grain orientation.

#pagebreak()

==== Mechanical fibering
Mechanical fibering results from the alignment of impurities, inclusions and
voids in the metal during deformation, like during rolling.

#cimage("./images/sheet-metal-anisotropy-mechanical-fibering.png")

=== Bending direction
Bending should be perpendicular to the rolling direction.
#cimage("./images/bending-direction.png")
#pagebreak()

=== Spring back
#cimage("./images/spring-back-graph.png")

- After the load is removed, *elastic recovery* occurs, which is called spring
    back.
- The bend angle decreases and the bend radius increases.

#cimage("./images/spring-back-diagram.png")

$ R_i/R_f = 4 (frac(R_i Y, E T))^3 - 3 (frac(R_i Y, E T)) + 1 $

Where:
- $R_i$ is the initial bend radius
- $R_f$ is the final bend radius
- $Y$ is the yield stress
- $E$ is the elastic modulus
- $T$ is the sheet metal thickness

==== Compensation for spring back
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        *Overbending*

        Requires a bend angle of $90 degree$ or more.
    ],
    image("./images/spring-back-compensation-overbending.png", height: 10em),

    [
        *Bottoming*

        High compressive pressure causes plastic deformation and reduces
        thickness at the bend area.
    ],
    image("./images/spring-back-compensation-bottoming.png", height: 10em),
)

*Stretch bending*

Sheet metal is stretched beyond its yield stress and is bent over the punch.
#cimage("./images/spring-back-compensation-stretch-bending.png", height: 15em)

- Changing the product design can reduce spring back.
- For example, incorporating darts or ribs into the design will increase the
    stiffness and reduce spring back.

#cimage("./images/spring-back-compensation-design.png", height: 15em)

=== Common bending operations

==== V-die bending operation
- Simple and inexpensive dies.
- For low production quantity.
- Included angle ranges from acute to obtuse.
- Shape bent is simple.

#cimage("./images/bending-v-die.png", width: 90%)

==== Wipe bending operation
- Complicated and costly dies.
- For high production quantity.
- Included angle $< 90 degree$, requires complicated dies.
- Bending is more precise.

#cimage("./images/bending-wipe.png")

==== Bending force computation
$ P = frac(k (T S) L T^2, W) $

Where:
- $k$ is 1.33 for a V-die, and 0.33 for wiping die.
- $T S$ is the tensile strength.
- $L$ is the bend length.
- $T$ is the thickness of the workpiece
- $W$ is the die opening or width of the V-die

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,

    grid.header([*V-die bending ($k = 1.33$)*], [*Wiping die ($k = 0.33$)*]),

    image("./images/bending-v-die-force.png", height: 20em),
    image("./images/bending-wipe-force.png", height: 20em),
))

=== Example
A part is to be bent into shape shown below. The material has a tensile strength
of #qty[400][MPa]. It is bent into a $90 degree$ angle using a V-die. The length
of the starting blank is #qty[100][mm] and the width is #qty[38][mm]. Find the
bending force, $P$, given that:
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        $ P = frac(1.33 (U T S) L T^2, W) $

        $ U T S = #qty[400][MPa], quad L = #qty[38][mm] $
        $ T = #qty[4][mm], quad W = #qty[32][mm] $

        $ P = frac(1.33 (400) times 38 (4)^2, 32) = #qty[10.108][kN] $

        Find the bending force if a wiping die with a die opening of
        #qty[19][mm] is used:
        $
            P = frac(0.33 (U T S) L T^2, W) & = frac(
                                                  0.33 (400) times 38 times 4^2,
                                                  19
                                              ) \
                                            & = #qty[4.224][kN]
        $
    ],
    image("./images/bending-example.png"),
)

=== Summary
- In bending, the material is subjected to tension and compressive forces. The
    neutral axis represents the location within the material where stress and
    strain are zero.
- The bending force constant, $K_(b f)$ for a V-bending is greater than that for
    edge bending.
- Spring back occurs due to the elastic energy that remains in the part, causing
    it to recover towards its original shape. The modulus of elasticity and
    yield strength of the metal contribute towards the amount of spring back.
- The resultant bend radius after spring back is greater than the original bend
    radius.

== Deep drawing
- Drawing is a tensile sheet metal forming process that transform a flat sheet
    blank into a hollow, 3-dimensional shape by stretching it over a die with a
    punch.
- This results in *cup shaped, box-shaped*, or other *complex-curved,
    hollow-shaped* parts. Examples of these products include beverage cans,
    ammunition shells, automobile body panels.
- This process is known as *deep drawing* to distinguish it from wire and bar
    drawing.

#cimage("./images/deep-drawing-products.png")

=== For a cup
#cimage("./images/deep-drawing-cup-1.png", width: 70%)
#figure(
    image("./images/deep-drawing-cup-2.png", width: 70%),
    caption: [
        Drawing of a cup-shaped part:
        #align(left)[
            - (Left) before the punch contacts the workpiece.
            - (Right) near the end of the stroke.
        ]
    ],
)

Where:
- $D_b$ is the blank diameter
- $D_p$ is the punch diameter, or the inner diameter of the drawn part
- $R_d$ is the die radius
- $R_p$ is the punch radius
- $F$ is the drawing force
- $F_h$ is the blank holder force

=== Steps
+ The punch makes initial contact with the work piece (blank).
+ As the punch moves downwards, the metal bends along the die.
+ The material then straightens to form the cup wall, and tensile stress
    develops along the cup wall.
    #cimage("./images/deep-drawing-steps-1-3.png")
+ Friction and compression act on the flange, producing compressive stress.
+ The final cup shape shows the effects of wall thinning.
    #cimage("./images/deep-drawing-steps-4-5.png")

=== Drawing considerations
- Blank volume and cup volume.
- Clearance between punch and die.
- Drawing feasibility.

=== Blank size (starting blank)
- Disc blank volume:
    $ V = pi frac(D_b^2, 4) t $
- *Initial blank volume #sym.gt.eq final volume of the cup*

#cimage("./images/deep-drawing-blank-size.png", width: 70%)

=== Clearance in drawing ($c$)
- The sides of the punch and die are separated by a *clearance* ($c$), given by
    $c = 1.1 t$, where $t$ is the sheet thickness.
- The clearance is about 10% greater than the sheet thickness.

#cimage("./images/deep-drawing-all-forces.png", height: 15em)

=== Drawing feasibility
Can a round cup be drawn in a single drawing operation without tearing and
wrinkling?

#cimage("./images/deep-drawing-tearing-and-wrinkling.png", width: 80%)

These criteria are used to assess drawability:
- Drawing ratio
- Reduction
- Thickness-to-diameter ratio

#cimage("./images/deep-drawing-cup-1.png", width: 80%)

==== Drawing ratio ($D R$)
- Most easily defined for a cylindrical shape, like a cup:
    $ D R = D_b/D_p $

    Where:
    - $D_b$ is the blank diameter
    - $D_p$ is the punch diameter
- $D R$ indicates the severity of a given drawing operation.
    - The upper limit is $D R <= 2.0$.
    - If $D R > 2.0$, the operation is not feasible.

==== Reduction ($r$)
- Defined for a cylindrical shape:
    $ r = frac(D_b - D_p, D_b) $

    Where:
    - $D_b$ is the blank diameter
    - $D_p$ is the punch diameter
- The value of $r$ should be less than 0.50, i.e. $r < 0.50$.

==== Thickness to diameter ratio
- Defined as:
    $ t/D_b $

    Where:
    - $t$ is the thickness of the starting blank
    - $D_b$ is the blank diameter
- The *ratio* must be greater than *1%*, i.e. *$t/D_b > 1%$*
- As the ratio decreases, the tendency for *wrinkling* increases.

==== Summary of drawing tests
- Conditions for drawability:
    $ D R <= 2.0 $
    $ r < 0.50 $
    $ t/D_b > 1% $
- If the limits on $D R$, $r$ and $t/D_b$ are not satisfied, the operation is
    not feasible in a single step, and *redrawing* is required.
- A blank can be drawn in 2 or more steps, with *annealing* between the steps.

#pagebreak()

=== Redrawing and reverse drawing
If the shape change is too severe to be produced in a single drawing step,
*redrawing* or *reverse drawing* can be used.

#table(
    columns: 2,
    stroke: none,

    table.vline(x: 1),

    table.header([*Redrawing*], [*Reverse drawing*]),

    image("./images/deep-drawing-redrawing.png"),
    image("./images/deep-drawing-reverse-drawing.png"),

    [
        - Drawn cup faced upwards on die.
    ],
    [
        - Drawn cup is placed upside down in the die.
        - *Requires lower force than redrawing*.
    ],
)

=== Drawing force
Calculation of the drawing force is required to determine the tonnage of the
press:

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,

    [
        $ F = pi D_p t (T S) (D_b/D_p - 0.7) $

        Where:
        - $F$ is the maximum drawing force (#unit[N])
        - $D_p$ is the punch diameter (#unit[mm])
        - $D_b$ is the starting blank diameter (#unit[mm])
        - $t$ is the original sheet thickness (#unit[mm])
        - $T S$ is the tensile strength (#unit[MPa])
        - $0.7$ is the correction factor to account for friction
    ],
    image("./images/deep-drawing-force.png", height: 35em),
)

#pagebreak()

=== Blank holder force or holding force
$ "Holding pressure" approx 0.015 times "Yield strength" $
$
    "Holding force" approx "Holding pressure"
    times "Starting area of the blank held by the blank holder"
$

$ therefore F_h = 0.015 Y pi {D_b^2 - (D_p + 2.2 t + 2 R_d)^2} $

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,

    align(left)[
        Where:
        - $F_h$ is the blank holder force (#unit[mm])
        - $D_p$ is the punch diameter (#unit[mm])
        - $D_b$ is the starting blank diameter (#unit[mm])
        - $t$ is the original sheet thickness (#unit[mm])
        - $Y$ is the yield strength of the sheet metal (#unit[MPa])
        - $R_d$ is the die corner radius (#unit[mm])
    ],
    image("./images/deep-drawing-all-forces.png", height: 12em),
))

=== Major stresses at the flange and wall
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        *Compressive hoop stress*

        May cause wrinkling.
    ],
    image("./images/deep-drawing-compressive-hoop-stress.png", height: 20em),

    [
        *Longitudinal tensile stress*

        The blank being pulled into the cavity, may cause tearing.
    ],
    image(
        "./images/deep-drawing-longitudinal-tensile-stress.png",
        height: 20em,
    ),
)

=== Compression in flange and wrinkles
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        *Compression*

        - Perimeter decreases but the volume is constant.
        - As the initial sheet thickness ($t$) decreases, wrinkles increases.
        - To remedy, increase the thickness of the sheet.
    ],
    image("./images/deep-drawing-compressive-hoop-stress.png"),

    [*Blank holder* used to prevent or reduce wrinkles on the flange.],
    image("./images/deep-drawing-blank-holder.png"),
)

#pagebreak()

=== Effect of the blank holder force on the wall
#grid(
    columns: 2,
    column-gutter: 2em,
    inset: 0.5em,

    grid.vline(x: 1),

    [
        If $F_h$ is too high, it prevents the metal from flowing into the die
        cavity, which may cause tearing due to the stretching of the metal.
    ],
    [If $F_h$ is too low, it causes wrinkles],

    image("./images/deep-drawing-blank-holder-force-too-high.png"),
    image("./images/deep-drawing-blank-holder-force-too-low.png"),
)

=== Defects in drawing operations
Common defects in drawn parts include:
#[
    #set enum(numbering: "(a)")
    + Wrinkling can occur in the flange.
    + Wrinkling can occur in the wall due to compression.
    + Tearing due to high tensile stresses that cause thinning and failure.
    + Earing due to anisotropy.
    + Surface scratches due to poor lubrication, or the punch or die not being
        smooth.
]

#cimage("./images/deep-drawing-defects.png")
#pagebreak()

==== Cause of earing
Earing occurs due to the *anisotropy* of the starting sheet.

#cimage("./images/deep-drawing-earing.png")

=== Pointers for successful drawing
- Successful drawing of parts requires:
    - Adequate material volume, taking into account defective profiling.
    - Satisfaction of process operational requirements.
- To assess the process feasibility, the following operational parameters must
    be met:
    - Process drawing ratio < 2
    - Reduction ratio < 50%
    - Thickness to diameter ratio > 1%
- As a rule of thumb, the holding force is about $1/3$ of the drawing force.

== Rolling
#cimage("./images/rolling-chart.png", width: 80%)

The roll pulls the material into the roll gap via the net frictional force
acting on the material.

#cimage("./images/rolling-forces.png")

#[
    #set enum(numbering: "(a)")
    + Illustration of the flat rolling process.
    + Frictional forces on the strip.
]

=== Types of rolling
- *Hot rolling*:
    - Carried out *above* the *recrystallisation temperature* of the metal.
    - Converts cast structure into wrought structure.
- *Cold rolling*:
    - Carried out *below* the *recrystallisation temperature*.
    - Produces a better surface finish by avoiding scale formation.
    - Better dimensional tolerance.
    - Better mechanical properties due to strain hardening.

=== Hot rolling of metals
- The changes in grain structure of cast metals during hot rolling are shown
    below.
- *Cast* structures (or continuous casting) are converted into *wrought*
    structures by hot working.

#cimage("./images/rolling-hot.png")
#pagebreak()

=== 2, 3 and 4-high rolls
#cimage("./images/rolling-mill-arrangements.png")

#[
    #set enum(numbering: "(a)")
    + 2-high
    + 3-high
    + 4-high
    + Cluster mill
]

- *2 or 3-high mills* are used for hot rolling in initial break down passes
    (primary roughing) of cast ingots.
- In *3-high* (reversing mill), the direction of the material is reversed after
    each pass.
- *4-high mills* have small diameter rolls to reduce rolling forces and minimise
    spreading. These small rolls have to be supported by other rolls to prevent
    deflection. It is suited for cold rolling of thin, high-strength sheet
    metal.

=== Planetary rolls
- The Planetary Mill was developed in 1954 and gave T. Sendzimir, Inc. its 29th
    patent.
- The term "planetary" refers to the arrangement of rolls around the periphery
    of each backing roll, where a plurality of working rolls act as satellites.
- The Planetary Mill is capable of achieving up to *97%* reduction of hot or
    warm slabs in a single pass.

#cimage("./images/rolling-planetary.png", width: 70%)

=== Seamless pipes and tubing
*Rotary tube piercing*
- Rotary tube piercing is a hot-working process for making long, thick-walled
    seamless pipes.
- A round bar subjected to radial compressive forces develops tensile stresses
    at its centre.
- Under cyclic forces, a cavity forms at the centre.
- An internal mandrel then expands the hold at the cavity, defining the bore of
    the tube.

#figure(
    image("./images/rolling-seamless-pipes-and-tubing.png"),
    caption: [
        Cavity formation in a solid round bar and its utilisation in rotary tube
        piercing process.
    ],
)

= Metal machining
- Metal machining is a *subtractive manufacturing* process in which excess
    material is removed from a starting workpiece so that what remains is the
    desired final geometrical size and shape.
- The family tree for material removal processes is classified into 3 main
    categories: conventional machining, abrasive processes and non-traditional
    machining.
- In conventional machining and abrasive processes, harder tools and abrasive
    materials are used to remove materials from the workpiece to create the
    desired shape.
- In non-traditional machining, other forms of energy are utilised to remove
    unwanted material. They are ideal to process tough or brittle materials with
    complex geometries.

#pagebreak()

== Metal removal processes
#table(
    columns: 2,
    stroke: none,

    table.header([*Conventional machining*], [*Abrasive processes*]),

    enum(
        numbering: "(a)",
        [Turning],
        [Drilling],
        [Peripheral milling],
        [Face milling],
    ),

    enum(
        start: 5,
        numbering: "(a)",
        [Grinding],
        [Honing],
        [Lapping],
        [Polishing],
    ),

    image("./images/conventional-machining.png"),
    image("./images/abrasive-processes.png"),
)

#grid(
    columns: 2,
    column-gutter: 2em,

    [
        *Non-traditional machining*:
        - *USM*: Ultrasonic machining
        - *EDM*: Electrical discharge machining
        - *ECM*: Electro chemical machining
        - *LBM*: Laser beam machining
    ],
    image("./images/non-traditional-machining.png"),
)

#pagebreak()

=== Comparison
#table(
    columns: 3,

    table.header(
        [*Aspect*],
        [*Conventional machining or abrasive processes*],
        [*Non-traditional machining*],
    ),

    [Material removal method],
    [Mechanical cutting or abrasion.],
    [
        Various methods, such as chemical, thermal, electrical, or mechanical.
        They do not rely solely on mechanical forces.
    ],

    [Tool],
    [Cutting tools are typically made of high-speed steel or carbide.],
    [
        No specific tool. Tools can vary widely depending on the process, such
        as electrodes, abrasive particles, chemicals.
    ],

    [Heat generation],
    [
        Significant heat generation which can lead to thermal damage in some
        cases.
    ],
    [
        Heat generation is typically minimal, reducing the risk of thermal
        damage to the workpiece.
    ],

    [Cutting speed],
    [Generally lower cutting speed.],
    [
        Cutting speeds can vary widely depending on the specific non-traditional
        process, but some can be much faster than traditional methods.
    ],

    [Material suitability],
    [
        Most suitable for conventional engineering materials like metals,
        plastics, and ceramics.
    ],
    [
        Cutting speeds can vary widely depending on the specific non-traditional
        process, but some can be much faster than traditional methods.
    ],

    [Precision and accuracy],
    [
        Good precision and accuracy, suitable for high-precision applications.
    ],
    [
        Can achieve high precision and accuracy. It is often used in
        microfabrication and precision machining.
    ],

    [Surface finish],
    [
        Good surface finish, but may require secondary finishing operations.
    ],
    [
        Can achieve excellent surface finish directly, without additional
        processes.
    ],

    [Tool wear],
    [
        Tool wear is common and requires periodic replacement or sharpening.
    ],
    [
        Minimal tool wear, reducing the need for frequent tool changes.
    ],

    [Setup and tooling costs],
    [
        Lower setup and tooling costs in general
    ],
    [
        Higher setup and tooling costs due to specialised equipment and
        processes.
    ],
)

== Metal removal products
#grid(
    columns: 3,
    column-gutter: 2em,
    row-gutter: 1em,

    grid.header(
        [Conventional machining workpieces],
        [Conventional machining workpieces],
        [Non-traditional machining workpieces],
    ),

    image("./images/conventional-machining-workpieces.png"),
    image("./images/abrasive-processed-workpieces.png"),
    image("./images/non-traditional-machining-workpieces.png"),
)

== Machining merits and limitations
- *Merits*: Versatile, as machining can be applied to almost any material with
    precision and accuracy. It is suitable for producing complex and detailed
    parts.
- *Limitations*: Prone to human error, comparatively less efficient, generates
    waste materials, and takes a longer time to shape a given part.

== Cutting theory
#table(
    columns: 2,

    table.header([*Orthogonal cutting*], [*Oblique cutting*]),

    image("./images/orthogonal-cutting.png"),
    image("./images/oblique-cutting.png"),
)

#pagebreak()

=== Orthogonal cutting model
- A cutting tool moves along the work piece with cutting velocity $V$ at a depth
    $t_o$, which is the undeformed chip thickness.
- The chip is formed due to plastic deformation, where material shearing occurs
    along the shear plane. The resulting chip thickness is $t_c$.

#cimage("./images/orthogonal-cutting-model.png", height: 25em)

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        *Key parameters*:
        - $V$ is the cutting velocity
        - $alpha$ is the rake angle, and the figure on the right shows a
            positive rake angle.
        - $phi.alt$ is the shear angle
        - $t_o$ is the undeformed chip thickness
        - $t_c$ is the chip thickness
        - $w$ is the width of the cut
    ],

    image("./images/orthogonal-cutting-model-key-parameters.png"),
)

== Mechanics of chip formation (shearing)
- The chip is produced by shearing. Chip formation can be visualised as a stack
    of cards (elements) sliding against each other.
- The thickness of a shear element $d$ is very small, about 10#super[-2] to
    10#super[-3] #unit[mm].

#cimage("./images/chip-formation.png")

=== 3D orthogonal cutting on ABAQUS
#cimage("./images/3d-orthogonal-cutting-on-abaqus.png")

=== Cutting process in chip formation
#cimage("./images/chip-formation-cutting-process.png")
#pagebreak()

== Cutting forces (Merchant's circle and shear angle)

=== Cutting forces on orthogonal cutting model
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        Forces acting on the tool:
        - Cutting force, $F_c$
        - Thrust force, $F_t$, which is perpendicular to $F_c$

        The resultant force is:
        $ R = sqrt(F_c^2 + F_t^2) $
    ],

    image("./images/orthogonal-cutting-model-forces.png"),
)

=== Forces on tool rake face (tool-chip interface)
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        $R$ can be resolved into two components on the tool-chip interface:
        - Friction force, $F$
        - Normal force, $N$, which is perpendicular to $F$
    ],

    image("./images/orthogonal-cutting-model-forces.png"),
)

=== Forces on the shear plane
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        $R$ is balanced by an equal and opposite force along the shear plane and
        is resolved into:
        - Shear force, $F_s$
        - Normal force to the shear force, $F_n$

        The resultant force, $R$, has the same magnitude and is collinear in all
        3 cases.
    ],

    image("./images/orthogonal-cutting-model-forces.png"),
)

=== Drawing the force circle diagram
#{
    grid(
        columns: 2,
        column-gutter: 2em,
        align: center + horizon,

        image("./images/force-circle-diagram-1.png", width: 27em),
        image("./images/force-circle-diagram-2.png", width: 13em),
    )
}

Where $beta$ is the friction angle.
$ F = R sin beta $
$ N = R cos beta $
$ mu = F/N = tan beta $
$ mu approx 0.5 "to" 2 $

=== Shear stress ($tau$)
$
    "Shear stress:" tau
    = frac("Shear force," F_s, "Area of the shear plane," A_s)
$
$ A_s = frac(w t_o, sin phi.alt) $

#cimage("./images/orthogonal-cutting-model-shear-stress.png", width: 80%)

=== Merchant's equation
#grid(
    columns: 2,
    column-gutter: 2em,
    [

        Merchant's equation assumes that $phi.alt$ adjusts itself to minimise
        cutting force.

        $ phi.alt = 45 degree + alpha/2 - beta/2 $

        Where:
        - $alpha$ is the rake angle
        - $beta$ is the frication angle

        Note that Merchant's equation can *only be used* if it is *given in the
        question*.
    ],
    image("./images/orthogonal-cutting-model-velocities.png"),
)

== Power and energy relationships in machining

=== Power
$ "Power" = "Force" times "Velocity" $
$ "Power (cutting)" = F_c V $

This power is dissipated in 2 main areas:
- Shear plane: to shear the material
- Tool-chip interface: to overcome friction

Relationships:
$ "Power (cutting)" = F_c V $
$ "Power (shearing)" = F_s V_s $
$ "Power (friction)" = F V_c $
$ F_c V = F_s V_s + F V_c $

Where:
- $F$ is the frictional force
- $F_s$ is the shearing force
- $F_c$ is the cutting force
- $V$ is the *cutting* velocity
- $V_s$ is the shearing velocity
- $V_c$ is the velocity of the *chip*

#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,

    image("./images/orthogonal-cutting-model-forces.png"),
    image("./images/orthogonal-cutting-model-velocities.png"),
)

#pagebreak()

=== Material removal rate (MRR)
$
    & "MRR (volume of material removed per second)" \
    & = "Area of the cross-section of cut"
      times "Velocity perpendicular to area" \
    & = w times t_o V #unit[mm^3 s^-1]
$

#cimage("./images/orthogonal-cutting-model-material-removal-rate.png")

=== Energy for removing a unit volume of material
$
    "Specific energy" & = frac("Power", "MRR") #unit[W s mm^-3] \
                      & = frac("Force" times "Velocity", "MRR")
$

Where $"MRR" = w times t_o times V$ for the orthogonal cutting model.

#table(
    columns: 2,

    table.header([], [*Specific energy* (#unit[W s mm^-3])]),

    [Shearing], $ U_s = frac(F_s V_s, "MRR") $,
    [Friction], $ U_f = frac(F V_c, "MRR") $,

    [Total specific energy (specific energy for cutting)],
    $ U_t = frac(F_c V, "MRR") $,

    table.cell(
        colspan: 2,
        $ U_t = U_s + U_f $,
    ),
)

For the cutting model, $"MRR" = w times t_o times V$.

#pagebreak()

== Tool wear and tool life
The cutting tool is subjected to:
- High localised stresses
- High temperatures
- Sliding of the chip along the rake face
- Sliding of the tool along the freshly cut surface

#table(
    stroke: none,
    columns: 2,

    table.header([*Wear on cutting model*], [*Wear on turning tool*]),

    image("./images/tool-wear-on-cutting-model.png"),
    image("./images/tool-wear-on-turning-tool.png"),
)

=== Principal types of tool wear
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        *Crater wear*
        #cimage("./images/tool-wear-crater-1.png")

        *Flank wear*
        #cimage("./images/tool-wear-flank.png")
    ],
    [
        *Other types of tool wear*, like nose radius wear and notch wear:

        #cimage("./images/tool-wear-on-turning-tool.png")
    ],
)

#pagebreak()

==== Crater wear
- Crater wear occurs on the rake face of the tool (tool-chip interface).
- Main causes:
    - High temperatures at the tool-chip interface.
    - Chemical affinity between the tool and workpiece material, leading to
        diffusion.
- Using coated cutting tools, like TiC and TiN coated tools, slows down
    diffusion, thereby reducing crater wear.

#cimage("./images/tool-wear-crater-2.png")

==== Flank wear
- Flank wear occurs on the flank face of the tool.
- Main causes:
    - Rubbing of the tool along the machined surface.
    - High temperatures affecting the properties of the tool material.

#grid(
    columns: 2,
    column-gutter: 2em,

    image("./images/tool-wear-on-cutting-model.png"),
    image("./images/tool-wear-on-turning-tool.png"),
)

==== When to resharpen or replace cutting tool
- Tool wear, such as setting a maximum flank wear land width,
    $"VB" = #qty[0.4][mm]$.
- Workpiece surface finish deteriorates.
- Cutting forces increase significantly.
- Temperature increases significantly.

#pagebreak()

=== Taylor's tool life equation
$ V T^n = C $
$ T = frac(C^(1/n), V^(1/n)) = (C/V)^(1/n) $

Where:
- $V$ is the cutting speed (#unit[m min^-1])
- $T$ is the tool life (#unit[min])
- $n$ is the exponent, usually less than 1, i.e. $n < 1$
- $C$ is a constant

Note that each combination of workpiece and tool material, as well as the
cutting condition, has its own $n$ and $C$ values.

=== Extended Taylor's tool life equation
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        $ V T^n d^x f^y = C $

        Where:
        - $V$ is the cutting speed, which is the most significant variable
            (#unit[m min^-1])
        - $T$ is the tool life (#unit[min])
        - $d$ is the depth of cut (#unit[mm])
        - $f$ is the feed rate (#unit[mm rev^-1])
        - $x$ and $y$ are exponents determined experimentally
        - $C$ is a constant

        Example:
        $ V T^0.33 d^0.15 f^0.6 = 50 $
    ],
    image("./images/extended-taylors-tool-life-equation.png"),
)

=== Temperature in cutting
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        Energy dissipated in cutting is converted into heat, raising the
        temperature in the cutting zone.

        Two main sources of heat generation:
        - Shear zone (shear plane) due to shearing
        - Tool-chip interface due to friction

        As $V$ increases, the time for heat dissipation decreases and
        temperature rises.
    ],
    image("./images/orthogonal-cutting-model-simple.png"),
)

#pagebreak()

=== Typical temperature distribution in cutting zone
- Severe temperature gradients occur within the tool and chip.
- The maximum temperature is located about halfway up the tool-chip interface.

#cimage(
    "./images/cutting-zone-typical-temperature-distribution.png",
    height: 25em,
)

=== Adverse effects of temperature rise
#table(
    columns: 3,

    table.header([*Machine tool*], [*Workpiece*], [*Cutting tool*]),

    [
        Elevated and uneven temperatures cause distortion of machine components,
        making it difficult to control dimensions.
    ],
    [
        - Uneven dimensional changes in machined workpiece, making it difficult
            to control the dimensional accuracy and tolerance.
        - Thermal damage to machined surface, possibly causing parts to fail
            before their expected lifespan.
    ],
    [
        - Decrease in strength.
        - Decrease in hardness.
        - Decrease in wear resistance.
    ],
)

== Cutting fluids
- Cutting fluids have 2 primary functions:
    - *Lubrication*: Reduces friction between the tool-chip and the
        tool-workpiece.
    - *Coolant*: Reduces the effects of heat in machining.
- Types of cutting fluids include oils, emulsions, synthetic and semi-synthetic
    solutions.

=== Proper methods of applying cutting fluids
#grid(
    columns: 2,
    column-gutter: 5em,

    [
        #v(1em)

        Application methods:
        - Flood cooling
        - Mist or jet
        - Through-tool delivery
    ],
    image("./images/proper-methods-of-applying-cutting-fluids.png"),
)

== Cutting tool characteristics and materials
*Characteristics*:
- Hot hardness
- Toughness
- Thermal shock resistance
- Wear resistance
- Chemical stability and inertness

*Materials*:
- Carbon and medium alloy steels
- High-speed steels (HSS)
- Cast-cobalt alloys
- Carbides, like WC and TiC
- Carbide-coated tools
- Ceramics
- Cubic boron nitride (CBN)
- Diamond

#pagebreak()

=== Hot hardness
- Hot hardness refers to the ability of a material to resist indentation and
    deformation at high temperatures.
- Hardness of a tool at cutting temperatures must be maintained.
- The tool does not undergo plastic deformation and is able to retain its shape
    and sharpness.

#cimage("./images/hot-hardness.png", height: 25em)

=== Toughness and impact strength (mechanical shock)
- Toughness and impact strength refers to the amount of energy absorption during
    deformation.
- To prevent chipping or fracturing of the tool due to:
    - Impact forces (especially for interrupted cutting operations)
    - Vibration and chattering during machining

=== Thermal shock resistance
Thermal shock resistance refers to the material's ability to withstand rapid
temperature cycles encountered in interrupted cutting.

=== Hot, hardness and wear resistance vs toughness and impact strength
#cimage("./images/hot-hardness-and-wear-resistance-vs-toughness.png")

== Chips
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        *Chips have significant influence on*:
        - The surface finish of the workpiece.
        - The cutting operations, like the tool life, vibration and chatter.

        *4 main types of chips*:
        - Continuous
        - Discontinuous
        - Built-up edge
        - Serrated and segmented
    ],
    image("./images/chips.png"),
)

=== Continuous chips
- Continuous chips are usually formed with ductile materials at high cutting
    speed.
- Generally results in a *good surface finish*.
- Tends to entangle around the toolholder, work-holding device and workpiece, so
    the operation has to stop to clear chips.

==== Remedy
- Change the machining parameters, like the cutting speed and the feed.
- Use a chip breaking to decrease the curl radius of the chip, so that it bends
    and breaks.

#pagebreak()

=== Discontinuous chips
Discontinuous chips typically occur under the following conditions:
- Brittle materials that are unable to withstand high shear strains.
- The material contains hard inclusions or impurities.
- The *cutting forces vary* during cutting.

#cimage("./images/chips-discontinuous.png")

=== Built-up edge (BUE)
- A built-up edge consists of layers of workpiece material that is deposited
    gradually on the tool.
- When the built-up edge increases, the workpiece becomes unstable and breaks up
    eventually.
- Part of the built-up edge material is carried away by the chip, and the rest
    is deposited randomly on the work piece surface, giving a poorer surface
    finish.
- Built-up edge chips changes the geometry of the cutting edge and makes it
    dull, like the tool tip profile.
- This gives a *poorer surface finish*, as the surface becomes rougher.

#cimage("./images/chips-built-up-edge.png")
#pagebreak()

=== Serrated or segmented chips
- Serrated or segmented chips are *semi-continuous chips* with large zones of
    low shear strain and small zones of high shear strain, which results in a
    sawtooth-like appearance.
- They are found in metals with low thermal conductivity and strength that
    decreases sharply with temperature, like titanium.

#cimage("./images/chips-serrated.png")

== Surface finish
The surface roughness parameters are $R_alpha$ and $R_t$.

#cimage("./images/surface-finish.png")

$ R_a = frac(a + b + c + d + dots. c, "Number of readings") $

$R_t$ is the distance between the *highest peak* and the *lowest valley*.

Factors affecting surface finish:
- Chip types
- Feed marks left by cutting operations
- Vibration

=== Measurement of surface finish
#cimage("./images/surface-finish-measurement.png")

=== Feed marks left by cutting operations
Arithmetic mean value:
$ R_alpha = frac(f^2, 32 R) $

Peak-to-valley value:
$ R_t = frac(f^2, 8 R) $

Where:
- $f$ is the feed rate (#unit[mm rev^-1])
- $R$ is the tool nose radius (#unit[mm])

As $R_alpha$ or $R_t$ increases, the surface finish becomes worse.

#cimage("./images/feed-marks-left-by-cutting.png")
#pagebreak()

=== Vibration
- If a tool vibrates during cutting, it will give a poor surface finish.
- There are two basic types of vibration in machining:
    - Forced vibration
    - Self-excited vibration, which is commonly called chatter
- Forced vibration is caused by periodic forces present in the machine tool,
    such as gear drives, motors, and pumps.
- Chatter (self-excited vibration) is caused by the interaction between the
    cutting process and the structure of the machine tool.
- It typically begins with a disturbance in the cutting zone, like the types of
    chips produced and the variations in frictional conditions at the tool-chip
    interface.
- Excessive chatter can cause chipping and premature failure of brittle cutting
    tools, like ceramics and diamond.

#cimage("./images/chatter-marks.png")
#pagebreak()

== Turning for round shapes
#grid(
    columns: 2,
    column-gutter: 2em,

    grid.cell(rowspan: 2)[
        $ "Depth of cut," d = frac(D_o - D_f, 2) $

        - $N$ is the rotational speed (#unit[rev min^-1])
        - $V$ is the cutting speed (#unit[m min^-1])
        - $f$ is the feed rate, which is the distance travelled by the cutting
            tool when the workpiece rotates one revolution (#unit[mm rev^-1])
    ],

    image("./images/turning-1.png"),
    image("./images/turning-2.png"),
)

=== Turning vs orthogonal cutting model
#table(
    columns: 2,
    align: center + horizon,

    table.header([*Turning*], [*Orthogonal cutting models*]),

    image("./images/turning-2.png"),
    image("./images/orthogonal-cutting-model.png"),

    [Cutting speed, $V$], [Cutting speed, $V$],

    [Feed, $f$], [Undeformed chip thickness, $t_o$],

    [Depth of cut, $d$], [Width of cut, $w$],

    [Material removal rate, $"MRR" = d F V$ (#unit[mm^3 s^-1])],
    [Material removal rate, $"MRR" = w t_o V$ (#unit[mm^3 s^-1])],
)

#pagebreak()

=== Cutting speed and rotational speed
As the workpiece rotates one revolution, a point on the workpiece diameter ($D$)
will move a distance of $pi D #unit[m]$.
- In $N$ revolutions, the point will move $pi D N #unit[m]$.
- In $N$ #unit[rev min^-1], the point will move $pi D N #unit[m min^-1]$.

$ therefore V = pi D N #unit[m min^-1] $

Where $N$ is the rotational speed of the workpiece (#unit[rev min^-1]).

Using $V = pi D_"avg" N$:
$ D_"avg" = frac(D_o + D_f, 2) $

=== Material removal rate (MRR)
#grid(
    columns: 2,
    column-gutter: 2em,

    [
        $"MRR" = d F V #unit[mm^3 s^-1]$

        Where:
        - $d$ is the depth of cut, given by $frac(D_o - D_f, 2)$ (#unit[mm])
        - $f$ is the feed rate (#unit[mm rev^-1])

        $ V = pi D_"avg" N $
        $ D_"avg" = frac(D_o + D_f, 2) $

        Where $N$ is the rotational speed of the workpiece.
    ],
    image("./images/turning-1.png"),
)

=== Cutting or machining time
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - In one revolution, the tool moves a distance of $f$ #unit[mm].
        - In $N$ #unit[rev min^-1], the tool moves a distance of $f N #unit[mm
                min^-1]$.

        $ therefore "linear speed of the tool" = f N #unit[mm min^-1] $

        The cutting time is:
        $ t = frac(l, f N) $

        Where:
        - $l$ is the length of the cut (#unit[mm])
        - $f$ is the feed rate (#unit[mm rev^-1])
        - $N$ is the rotational speed of the workpiece (#unit[rev min^-1])
    ],
    image("./images/turning-2.png"),
)

#pagebreak()

=== Roughing and finishing cuts
The usual procedure is:
- One or more roughing cuts at high $f$ and $d$, resulting in a high material
    removal rate as $"MRR" = d f V$.
- A finish cut at lower $f$ and $d$ to obtain a good surface finish.

$ R_alpha = frac(f^2, 32 R) $
$ R_t = frac(f^2, 8 R) $

== Drilling
Drilling is a major and common hole making process.

#cimage("./images/drilling.png")

=== Velocity (feed rate) of a drill
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        The velocity of the drill is given by:
        $ "Velocity of the drill" = f N #unit[mm min^-1] $

        Where:
        - $D$ is the drill diameter (#unit[mm])
        - $N$ is the rotational speed of the drill (#unit[rev min^-1] or
            #unit[rpm])
        - $f$ is the feed rate (#unit[mm rev^-1])
    ],
    image("./images/drilling-diagram.png"),
)

=== Material removal rate (MRR)
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        The velocity of the drill perpendicular to the drilled hole is:
        $ "Velocity of the drill" = f N #unit[mm min^-1] $

        $ "MRR" = (frac(pi D^2, 4)) times "Velocity" $
        $ "MRR" = frac(pi D^2, 4) f N #unit[mm^3 s^-1] $
    ],
    image("./images/drilling-diagram.png"),
)

=== Drill time
$ t = frac(l, f N) $

Where:
- $l$ is length travelled by the drill (#unit[mm])
- $f$ is the feed rate (#unit[mm rev^-1])
- $N$ is the rotational speed of the drill (#unit[rev min^-1] or #unit[rpm])

=== Torque and power
$
    "Power" & = #text[Torque on the drill (in #unit[Nm])]
              times #text[Rotational speed of drill (in #unit[rad s^-1])] \
            & = U_t times "MRR"
$

Spindle drill velocity, which is how fast the drill spins:
$ V = pi D N space (#unit[m min^-1]) $

This should not be confused with the other drill velocity or feed rate, which
describes how quickly it travels down into the workpiece.

#pagebreak()

== Milling
- Milling is a common subtractive process used to shape materials by removing
    chips with a rotating multi-tooth cutter while travelling along the
    horizontal or vertical axis.
- There are 3 main types of milling:
    #table(
        columns: 3,
        stroke: none,

        table.header([*Slab milling*], [*Face milling*], [*End milling*]),

        image("./images/milling-slab.png"),
        image("./images/milling-face.png"),
        image("./images/milling-end.png"),
    )

=== Conventional milling (up milling)
- Conventional milling is a more common method of milling.
- The maximum chip thickness ($t_c$) occurs at the end of a cut.
- The workpiece surface characteristics, like scale or contamination, would not
    affect tool life.

#grid(
    columns: 2,
    column-gutter: 2em,

    image("./images/milling-conventional.png"),
    image("./images/milling-conventional-surfaces.png"),
)

==== Limitations
- Effects of backlash.
- Poorer surface finish due to chip recutting and smearing.
- Tool may chatter and lift workpiece upwards, and hence proper clamping is
    needed.

#pagebreak()

=== Climb milling (down milling)
- Cutting starts at the surface of the workpiece.
- Maximum chip thickness occurs at the start of the cut, which is not good.
- The downward component of the cutting force holds the workpiece in place,
    which is good.
- Not suitable for workpieces with surface scale, like hot forged parts and
    casting, as the scale is hard and abrasive, which can cause excessive cutter
    wear and damage.
- High impact forces require a rigid set-up, and backlash must be eliminated.

#grid(
    columns: 2,
    column-gutter: 2em,

    image("./images/milling-climb.png"),
    image("./images/milling-climb-surfaces.png"),
)

#pagebreak()

= Metal joining (assembly processes)
- Metal joining is a process that involves bringing together two or more
    separate parts to form an entity.
- The term "joining" is generally referred to forming a permanent joint between
    two parts, whereas assembly refers to a mechanical fastening of two parts
    together.
- Metal joining processes would include welding, brazing, soldering and adhesive
    bonding.

#cimage("./images/metal-joining-processes.png")

*Welded products*

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    image("./images/naval-ship.jpg", height: 10em),
    image("./images/light-tank.jpg"),
))

*Brazed, soldered and adhesive joint products*

#cimage("./images/brazing-soldering-adhesive-joint-products.png")

== Welding
- Welding is a joining process in which 2 or more parts are coalesced at their
    contacting surfaces.
- This is done by the application of *heat* or *pressure*.
- Many welding processes are accomplished by heat alone, with no pressure
    applied.
- Others are done using a combination of heat and pressure.
- In some welding processes, a *filler* material is added to facilitate
    coalescence.
- Shielding is introduced to prevent oxidation and contamination.
- Atomic bonding is the essence of welding.
- 50 different types of welding processes have been catalogued by the American
    Welding Society (AWS).
- Welding processes can be divided into 2 major categories:
    - *Fusion* welding
    - *Solid state* welding

=== Fusion welding
- Fusion welding is a joining process that *melts* the base metals.
- In many fusion welding operations, a *filler* metal is added to the molten
    pool to facilitate the process and provide bulk and added strength to the
    welded joint.
- A fusion welding operation in which no filler metal is added is called an
    autogenous weld.

==== Oxyfuel gas welding (OFW)
The melting of the metal is accomplished by an oxyfuel gas such as acetylene.
#grid(
    columns: 2,
    column-gutter: 2em,

    image("./images/oxyfuel-gas-welding.png"),
    image("./images/oxyfuel-gas-welding-diagram.png"),
)

#pagebreak()

==== Arc welding (AW)
The melting of the metal is accomplished by an electric arc.
#cimage("./images/arc-welding.png")

==== Laser welding
Laser is used as the heat source for melting the metal.
#cimage("./images/laser-welding.png")

=== Solid state welding (SSW)
- Solid state welding is are joining processes in which coalescence results from
    the application of pressure alone, or a combination of heat and pressure.
- If heat is used, the temperature is *below* the melting point of metals being
    welding, so there is *no melting*.
- *No filler metal* is added in solid state welding.

==== Forge welding
#cimage("./images/forge-welding.png")

==== Ultrasonic wire bending
#cimage("./images/ultrasonic-wire-bending.png")
#pagebreak()

== Physics of welding
- In fusion welding, a heat source has to be provided.
- It is desirable to melt metal with minimum energy but at high power density.

=== Power density
Power density is the power directed at the entering surface divided by the
focused or target surface area:
$ P D = P/A $

Where:
- $P D$ is the power density (#unit[W mm^-2])
- $P$ is the power entering the surface (#unit[W])
- $A$ is the surface area over which then energy is entering (#unit[mm^2])

==== Approximate power densities for welding processes
#table(
    columns: 2,

    table.header([*Welding process*], [*#unit[W mm^-2]*]),

    [Oxyfuel], [10],
    [Arc], [50],
    [Resistance], [1,000],
    [Laser beam], [9,000],
    [Electron beam], [10,000],
)

==== Example 1
A laser of fixed power is focused to different diameters. Which diameter would
give the greatest power density?

+ #qty[10][mm]
+ #qty[5][mm]
+ #qty[2][mm]
+ #qty[1][mm]
+ #qty[0.5][mm] #sym.checkmark
+ Power density is the same

#pagebreak()

==== Example 2
#let outer-circle-radius = 6mm
#let inner-circle-radius = 2.5mm

#grid(
    columns: 2,
    column-gutter: 5em,
    align: horizon,

    [
        There are two concentric circles of power distribution:
        - Inner circle (#sym.diameter #qty[5][mm]): 70% of power
        - Outer circle (#sym.diameter #qty[12][mm]): 90% of power
        - Power of heat source, $P = #qty[3][kW]$
    ],
    {
        set circle(fill: gray, stroke: black)
        circle(radius: outer-circle-radius)[
            #set align(center + horizon)
            #circle(radius: inner-circle-radius)
        ]
    },
)


#{
    let stroke-colour = black
    set circle(stroke: stroke-colour, fill: gray)

    grid(
        columns: 2,
        column-gutter: 2em,
        row-gutter: 1em,
        align: horizon,

        [
            *Inner circle* (#sym.diameter#sub[1] = #qty[5][mm]):
            $ A_1 = #qty[19.63][mm^2] $
            $
                P D_1 = P_1/A_1 & = frac(0.7 times 3000, 19.63) \
                                & = #qty[107][W mm^-2]
            $
        ],
        circle(radius: outer-circle-radius)[
            #set align(center + horizon)
            #circle(radius: inner-circle-radius, fill: red)
        ],

        [
            *Outer circle* (#sym.diameter#sub[2] = #qty[12][mm]):
            $ "Total area," A = #qty[113.11][mm^2] $
            $
                P D = P/A & = frac(0.9 times 3000, 113.11) \
                          & = #qty[22.87][W mm^-2]
            $
        ],
        circle(radius: outer-circle-radius),

        [
            *Annulus* (#sym.diameter#sub[2] = #qty[12][mm]):
            $ A_2 = 113.11 - 19.63 = #qty[93.48][mm^2] $
            $
                P D_2 = P_2/A_2 & = frac((0.9 -0.7) times 3000, 93.48) \
                                & = 600/93.48 = #qty[6.42][W mm^-2]
            $
        ],
        circle(radius: outer-circle-radius, fill: red)[
            #set align(center + horizon)
            #circle(radius: inner-circle-radius)
        ],
    )
}

=== Unit energy for melting ($U_m$)
- The unit energy for melting is the quantity of heat required to melt a unit
    volume of metal.
- It is the sum of:
    - The heat required to raise the temperature of a solid metal to melting
        point, which depends on volumetric specific heat.
    - The heat required to transform metal from a solid to a liquid phase at
        melting point, which depends on the heat of fusion.

$ U_m = k T_m^2 $

Where:
- $T_m$ is the melting temperature of the material
- $k = 3.33 times 10^(-6)$ for $T_m$ in Kelvin (#unit[K])

=== Heat transfer
- There are 2 heat transfer mechanisms in welding.
- Not all of the input energy is used to melt the weld metal.
- The *heat transfer efficiency ($f_1$)*, is the actual heat received by the
    workpiece divided by the total heat generated at the source.
- The *melting efficiency ($f_2$)*, is the proportion of heat received at the
    work surface used for melting, the rest is conducted into the work metal.

==== Heat available for welding ($H_w$)
$ H_w = f_1 f_2 H $

Where:
- $H_w$ is the net heat available for welding
- $f_1$ is the heat transfer efficiency
- $f_2$ is the melting efficiency
- $H$ is the total heat generated by the welding process

==== Heat transfer efficiency ($f_1$)
- The heat transfer efficiency proportion of heat received at the work surface
    relative to the total heat generated at the source.
- It depends on the welding process, and the capacity to convert the power
    source (e.g., electrical energy) into usable heat at the work surface:
    - Oxyfuel gas welding processes are relatively inefficient.
    - Arc welding processes are relatively efficient.

==== Melting efficiency ($f_2$)
- The melting efficiency proportion of heat received at the work surface used
    for melting, and the rest is conducted into the work metal.
- It depends on the welding process, but it is also influenced by the thermal
    properties of the metal, joint configuration, and the work thickness.
- Metals with high thermal conductivity, such as Al and Cu, present a problem in
    welding due to:
    + A rapid dissipation of heat away from the heat contact area.
    + An unstable temperature of the molten weld pool.

=== Energy balance equation
$ H_w = U_m V = f_1 f_2 H $

Where:
- $H_w$ is the net heat energy delivered to the operation (#unit[J])
- $U_w$ is the unit energy required to melt the metal (#unit[J mm^-3])
- $V$ is the volume of metal melted (#unit[mm^3])

If the time factor (rate) is considered:
$ H_w = U_m V quad => quad H R_w = U_m (W V R) $
$ H_w = f_1 f_2 H quad => quad H R_w = f_1 f_2 H R = U_m A_w v $

Where:
- $W V R$ is the welding volume rate (#unit[mm^3 min^-1])
- $H R_w$ is the rate of heat energy delivered
- $A_w$ is the weld area
- $v$ is the welding speed

$
    v = frac(
        overbrace((f_1 f_2), "Overall efficiency") quad
        overbrace(H R, "Heat source"),
        underbrace(U_m, "Welding material") quad
        underbrace(A_w, "Welding geometry")
    )
$

== Arc welding (AW)
- Arc welding is a fusion welding process in which joining of metals is achieved
    by heat from the electric arc between an electrode and the workpiece.
- The electric energy from the arc produces temperatures of roughly
    5,500#degreeC, hot enough to melt *any* metal.

#figure(
    image("./images/arc-welding-setup.png", width: 90%),
    caption: [
        Basic configuration and the electrical circuit of an arc welding
        process.
    ],
)

=== Example
Gas tungsten arc welding:
$ "Current:" #qty[300][A] $
$ "Voltage:" #qty[20][V] $
$ f_1 = 0.7 $
$ f_2 = 0.5 $
$ U_m = #qty[10][J mm^-3] $

Calculate:
#[
    #set enum(numbering: "(a)")
    + Power in the operation
    + Rate of heat generation at the weld
    + Volume rate of the metal welded
]

==== a)
$ P = H R = #qty[300][A] times #qty[20][V] = #qty[6][kW] $

==== b)
$ f_1 = 0.7, wide f_2 = 0.5 $

Hence:
$ H R_2 = f_1 f_2 P = 0.7 times 0.5 times 6000 = #qty[2.1][kJ s^-1] $

==== c)
Volume rate of metal welded:
$ W V R = 2100/10 = #qty[210][mm^3 s^-1] $

=== Arc shielding
At high temperatures in arc welding, metals are chemical reactive to oxygen,
nitrogen and hydrogen in air.
- The mechanical properties of joints can be seriously degraded by these
    reactions.
- To prevent this, the arc must be *shielded* from surrounding air in nearly all
    arc welding processes.

Arc shielding is accomplished by:
- Shielding gases such as argon, helium, and CO#sub[2]
- Flux

=== Role of flux in welding
- Flux is a substance that prevents formation of oxides and other contaminants
    in welding, or dissolves them and allows removal.
- It provides protective atmosphere for welding.
- It also stabilises the arc and reduces spattering.

#cimage("./images/arc-welding.png")

==== Application methods
- Pouring granular flux onto welding area.
- Stick electrode coated with flux material that melts during welding to cover
    the weld.
- Use tubular electrodes in which the flux is contained in the core and released
    as the electrode is consumed.

=== Submerged-arc welding
#cimage("./images/submerged-arc-welding.png")

=== Shielded metal-arc welding (manual arc welding)
#cimage("./images/shielded-metal-arc-welding.png")
#pagebreak()

=== Basic types of arc welding electrodes
- *Consumable*, which is expended during the welding process.
- *Non-consumable*, which is not expended during the welding process. Filler
    metal may be added separately.

==== Consumable electrodes
- Types:
    - Welding rods, which are also called sticks, are roughly #qty[30][cm] long
        and roughly #qty[8][mm] in diameter, and must be changed often.
    - The weld wire can be continuously fed from spools with long lengths of
        wire, avoiding frequent interruptions.
- In both rod and wire forms, the electrode is consumed by the arc and added to
    the weld joint as *filler metal*.

==== Non-consumable electrodes
- Non-consumable electrodes are made of tungsten which resists melting due to
    its extremely high melting point.
- It is gradually depleted during welding due to vaporisation.
- Filler metal may be supplied by a separate wire fed into the weld pool.

=== Arc stud welding (consumable electrode)
#cimage("./images/dawn-arc-stud-welding.jpg")
#pagebreak()

=== Gas tungsten arc welding (GTAW)
- Uses non-consumable tungsten electrodes and an *inert gas* for arc
    *shielding*.
- It is also called Tungsten Inert Gas (TIG) welding.
- The melting point of tungsten is 3,410#degreeC.
- It is used with or without a filler metal.
    - When a filler metal is used, it is added to the weld pool from a separate
        rod or wire.
- Aluminium and stainless steel are most commonly welded using this technique.

#cimage("./images/gas-tungsten-arc-welding.png")
#pagebreak()

== Electrical resistance welding (RW)
- Electrical resistance welding or resistance welding is a group of *fusion
    welding* processes that use a combination of heat and pressure to accomplish
    coalescence.
- Heat is generated by electrical resistance to current flow at the junction to
    be welded.
- The principal resistance welding process is resistance spot welding (RSW).

=== Resistance spot welding (RSW)
#figure(
    image("./images/resistance-spot-welding.png", width: 80%),
    caption: [
        Cross-section of spot weld, showing weld nugget and indentation of
        electrode on sheet surfaces.
    ],
)

== Solid state welding processes
Solid state welding processes are techniques that join materials without
melting.

=== Roll bonding
#cimage("./images/roll-bonding.png", width: 80%)

=== Friction welding (FRW)
- Friction welding is a solid state welding process in which coalescence is
    achieved by frictional heat combined with pressure.
- When properly carried out, no melting occurs at faying surfaces.
- No filler metal, flux or shielding gases are normally used.
- The process yields a narrow heat affected zone (HAZ).
- It can be used to join dissimilar metals.
- It is a widely used commercial process, amenable to automation and mass
    production.
- It does not produce defects associated with melting.

#grid(
    columns: 2,
    column-gutter: 1em,

    [
        #set enum(numbering: "(a)")
        + Rotating part, no contact
        + Parts brought into contact to generate heat from friction.
    ],
    image("./images/friction-welding-1.png"),

    [
        #set enum(numbering: "(a)", start: 3)
        + Rotation stopped and axial pressure is applied.
        + The weld is created.
    ],
    image("./images/friction-welding-2.png"),
)

#pagebreak()

=== Explosive welding (EXW)
- Explosive welding is commonly used to bond 2 dissimilar metals, in particular
    to clad one metal on top of a base metal over large areas.

#cimage("./images/explosive-welding-1.png", width: 85%)
#cimage("./images/explosive-welding-2.png", width: 90%)
#figure(
    image("./images/explosive-welding-3.png"),
    caption: [Cross-sections of explosion welded joints.],
)

== Weld quality
Weld quality includes joint features and defects like incomplete fusion, poor
weld profile, cracking and distortion.

=== Typical fusion welded joint
#figure(
    image("./images/typical-fusion-welded-joint.png"),
    caption: [Principal zones in a joint.],
)

#pagebreak()

=== Heat affected zone
- The metal has experienced temperatures below melting point, but high enough to
    cause microstructural changes in the solid metal.
- The chemical composition remains the same as the base metal, but the region
    has been heat treated so that its properties and microstructures have been
    altered.
- The effect on mechanical properties in the heat affected zone is usually
    negative, and it is here that welding failures often occur.

#{
    set image(height: 15em)
    figure(
        image("./images/incomplete-fusion-1.png"),
        caption: [
            Low-quality weld beads, which is the result of incomplete fusion.
        ],
    )

    figure(
        image("./images/incomplete-fusion-2.png"),
        caption: [
            Incomplete fusion from oxide or dross at the centre of a joint,
            especially in aluminium.
        ],
    )

    figure(
        image("./images/incomplete-fusion-3.png"),
        caption: [Incomplete fusion in a groove weld.],
    )
}


=== Poor weld profile
Poor weld profiles include:
- Underfills
- Undercuts
- Excessive overlap

==== Underfill
#cimage("./images/poor-weld-profile-underfill.png")

==== Undercut
#cimage("./images/poor-weld-profile-undercut.png")

==== Good weld
#cimage("./images/poor-weld-profile-good-weld.png")
#pagebreak()

=== Cracks in welded joints
Cracks are caused by thermal stresses that develop during solidification and
contraction of the weld bead and surrounding structure.

#{
    set image(width: 80%)
    cimage("./images/cracks-in-welded-joints-1.png")
    figure(
        image("./images/cracks-in-welded-joints-2.png"),
        caption: [Cracks in butt and T joints.],
    )
}


=== Causes of crack in a weld bead
- Thermal stresses due to temperature gradients.
- Variation in composition
- Embrittlement of grain boundaries (segregation)
- Hydrogen embrittlement
- Inability to contract, causing tensile stresses.

=== Distortion after welding
Distortion is caused by differential thermal expansion and contraction of
different parts of a welded assembly.

#cimage("./images/distortion-after-welding.png")

== Brazing
- A filler metal of low melting point, but *higher than 450#degreeC*, is used in
    brazing.
- The filler metal melts, but the *base metal does not melt*.
- Brazing is different from fusion welding or solid state welding.
- Brazing is suited for metals that need to be joined but have poor weldability
    or dissimilar metals, or ceramics that need to be joined.

#cimage("./images/brazing.png")
#pagebreak()

=== Design of brazed joints
The designs shown below all aim to maximise the contact area.

#cimage("./images/brazing-design-of-joints.png")

#[
    #set enum(numbering: "(a)")
    + Lap joint
    + Lap joint adaptation for cylindrical parts
    + Lap joint adaptation for sandwiched parts
    + Use of a sleeve to convert a butt joint into a lap joint
]

== Soldering
- Soldering is the same as brazing, except that the melting point of the filler
    metal is lower than 450#degreeC.
- The filler metal is called *solder*.
- It is most closely associated with electrical and electronics assembly (wire
    soldering).

#pagebreak()

== Adhesive bonding
- An adhesive ("glue") is used as filler material to bond 2 or more
    closely-spaced parts together.
- It is used in a wide range of bonding and sealing applications for joining
    similar and dissimilar materials such as metals, plastics, ceramics, wood,
    paper and cardboard.

=== Poor joint designs
Poor designs generally have small contact areas between the members to be
joined.

#cimage("./images/adhesive-bonding-poor-joint-designs.png")

=== Good joint designs
Good designs require large contact areas between members to be joined.

#cimage("./images/adhesive-bonding-good-joint-designs.png")
#pagebreak()

== Summary
The metal joining processes are:
- Fusion *welding*, which is melting of the base metal to join two members. A
    filler material is optional.
- Solid state *welding*, which does not have any melting or filler material.
- Brazing and soldering, which do not melt the base metal, and only melts the
    filler material.
- Adhesive bonding ("glue")

=== Comparison between welding, brazing and soldering
#table(
    columns: 4,

    table.header([*Characteristic*], [*Welding*], [*Brazing*], [*Soldering*]),

    [Process involving heat],
    [
        Uses high heat to melt the parts together before allowing them to cool,
        causing fusion.
    ],
    [
        Involves capillary action to distribute molten filler on heating of the
        metal to be bonded without melting the base metal at above 450#degreeC.
    ],
    [
        Involves capillary action to distribute molten filler on heating of the
        metal to be bonded without melting the base metal at below 450#degreeC.
    ],

    [Joint strength and load bearing ability],
    [Higher than the base metal. It is the strongest, and can bear load.],
    [Stronger than soldering but weaker than welding. Can bear some load.],
    [Weakest of the 3, and not meant for load bearing.],

    [Workpiece temperature and properties],
    [
        Heat the workpiece till its melting point. The mechanical properties may
        change.
    ],
    [
        Heat the workpiece below its melting point, and hence no change in
        mechanical properties.
    ],
    [
        Heat the workpiece below its melting point, and hence no change in
        mechanical properties.
    ],

    [Joint material],
    [Only similar metals],
    [Dissimilar metals],
    [Only similar metals],

    [Surface finish], [Moderate], [Good], [Poor],
)
