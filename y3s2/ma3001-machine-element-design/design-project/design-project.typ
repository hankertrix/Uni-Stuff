#let heading-numbering = "1.1"
#set page(numbering: "1")
#set heading(numbering: heading-numbering)
#show link: text.with(blue)
#{
    set document(
        title: "Sugar Cane Project",
        author: ("Member 1", "Member 2", "Member 3"),
    )

    align(center)[


        #image("./images/ntu-logo.png", width: 70%)

        *SCHOOL OF MECHANICAL AND AEROSPACE ENGINEERING*

        *#underline([Machine Element Design (MA3001)])*

        *AY2025/2026 Semester 2*

        #v(2em)

        *#underline(context document.title)*

        Project Report
    ]

    [
        *Tutorial Group: MA3*

        *Name of Tutor: Dr Sim Siang Kok*
    ]

    pagebreak()

    [= Project contributions]

    context align(center, table(
        columns: 3,
        align: left,
        table.header(..document.author.map(item => text(weight: "bold", item))),

        [
            - Motor selection
            - Belt selection
            - Designing
            - Solidworks
            - CAD design
        ],
        [
            - Motor selection
            - Belt selection
            - Designing
            - Shaft calculation
            - Drawing diagrams
        ],
        [
            - Motor selection
            - Belt selection
            - Designing
            - Shaft calculation
            - Drawing diagrams
            - Gear selection
            - Bearing design and calculation
            - Shaft key design and calculation
            - Report writing
            - Checking calculations
        ],
    ))

    pagebreak()
    outline(title: [Table of Contents])
    pagebreak()
}

// Imports
#import "@preview/fancy-units:0.1.1": qty, unit
#import "@preview/cetz:0.5.0"
#import "@preview/inknertia:0.1.0": newtonian

// The height for PDF pages
#let PDF-PAGE-HEIGHT = 85%

// Function definitions
#let appendix(body) = {
    set heading(supplement: [Appendix])
    body
}

// Function to attach a full PDF document
//
// The page heading map is a dictionary with the keys
// being the page number, and the value being the heading
#let attach-pdf(
    path,
    reference: none,
    start-page: 1,
    end-page: 1,
    page-heading-map: (:),
    pages-to-skip: (),
    heading-level: 3,
) = {
    //

    // Initialise the content array
    let content = ()

    // Iterate over the pages
    for page in range(start-page, end-page + 1) {
        //

        // If the list of pages to skip contains the page, skip it
        if pages-to-skip.contains(page) {
            continue
        }

        // Get the page heading
        let page-heading = page-heading-map.at(str(page), default: none)

        // If the page heading exists, add the heading
        if page-heading != none {
            content.push(heading(
                page-heading,
                level: heading-level,
                supplement: [Generated],
            ))
        }

        // Initialise the caption
        let caption = none

        // If there is a reference, add it
        if reference != none {
            caption = [From #reference]
        }

        // Add the image with the caption
        content.push(figure(
            image(path, height: PDF-PAGE-HEIGHT, page: page),
            caption: caption,
        ))
    }

    // Display the content
    content.join("")
}

// Get the labels to be recognised in the document using invisible figures
#show heading.where(supplement: [Generated]): it => {
    //

    // Create the label
    let heading-label = lower(
        it
            .body
            .text
            .replace(
                regex("[!$%^&*()_+|~=`{}\\[\\]:\";'<>?,./]"),
                "",
            )
            .replace(" ", "-"),
    )

    // Return the heading with the label
    return [
        #it
        #v(-1em)
        #figure(
            kind: "heading",
            numbering: (..numbers) => numbering(
                heading-numbering,
                ..(counter(heading).get()),
            ),
            supplement: [Appendix],
        )[]
        #label(heading-label)
    ]
}

= List of appendices
#outline(target: heading.where(supplement: [Appendix]), title: [])

= Objectives
Design specifications:
#figure(
    table(
        columns: 2,
        table.header([*Design parameter*], [*Design specification*]),

        [Type of motor],
        [AC #qty[230][V], #qty[50][Hz], Single phase electric motor],

        [Rated power], [At least 180% of juicing power],
        [Motor input speed], [#qty[1350][rpm] - #qty[1550][rpm]],
        [Sugar cane crushing force], qty[3300][N],
        [Desired roller speed], [#qty[44][rpm] (#sym.plus.minus 5%)],
        [Roller diameter], qty[130][mm],

        [Maximum machine frame size],
        [#qty[650][mm] #sym.times #qty[650][mm] #sym.times #qty[1400][mm]],
    ),
    caption: [Design specifications.],
)

#pagebreak()

= Motor selection

== Determining the friction coefficient ($mu$)
Based on @adam2004multi, the friction coefficient ($mu$) for flat surfaces is
given by:

$
    mu = 7.55 times 10^(-1) - 6.97 times 10^(-2) log_e (sigma_n)
    - 2.00 times 10^(-3) S_r + 2.40 times 10^(-4) log_e (sigma_n) S_r
$

Simplifying the equation:
$ mu = 0.755 - 0.0697 ln (sigma_n) - 0.002 S_r + 0.00024 ln (sigma_n) S_r $

Where:
- $mu$ is the friction coefficient
- $sigma_n$ is the normal pressure across the interface (#unit[kPa])
- $S_r$ is the relative rubbing speed between the surfaces (#unit[mm s^-1])

From @parks2021saccharum, the diameter of sugarcane ranges from #qty[20][mm] to
#qty[45][mm]. Taking the average diameter of sugarcane:

$ "Average sugarcane diameter" = (20 + 45)/2 = #qty[32.5][mm] $

Estimating the average contact area ($A_c$) between the sugarcane and the
rollers to be twice the width of the sugar cane multiplied by 5% of the roller
diameter for an estimated contact of 5%:

$
    A_c = 32.5 times 10^(-3) times 2 times 0.05 times 130 times 10^(-3)
    = 4.225 times 10^(-4) space #unit[m^2]
$

Hence, the normal pressure ($sigma_n$) across the interface would be:
$
    sigma_n = frac(3300, 4.225 times 10^(-4))
    = 7.810650888 times 10^6 #unit[Pa] approx 7810 #unit[kPa]
$

The relative rubbing speed ($S_r$) is:
$ S_r = frac(2 pi, 60) times 44 (130/2) = 286/3 pi #unit[mm s^-1] $

Hence, the friction coefficient ($mu$) is:
$
    mu & = 0.755 - 0.0697 ln (7810) - 0.002 (286/3 pi)
         + 0.00024 ln (7810) (286/3 pi) \
       & = 0.1755394625
$

Taking a nice number for easier calculations, we take $mu$ to be 0.175.

#pagebreak()

== Determining the juicing power
Tangential force ($F_t$):
$ F_t = F_c times mu = 3300 times 0.175 = #qty[577.5][N] $

Torque at roller ($T_r$):
$
    T_r = 1/2 T & = F_t times "Roller radius" \
                & = 577.5 times 0.130/2 = #qty[37.5375][Nm]
$

Total torque ($T$):
$ T = 2 times 37.5375 = #qty[75.075][Nm] $

Juicing power ($P$):
$
    P = T omega & = 75.075 (44 times frac(2pi, 60)) \
                & = #qty[345.9207671][W] approx #qty[0.346][kW]
$

== Selecting a motor
Rated power of the motor:
$
    R P_"motor" = 1.8 times 345.9207671
    = #qty[622.6573808][W] approx #qty[0.623][kW]
$

Selecting a motor from @motor-catalogue with motor speeds rated from
#qty[1350][rpm] to #qty[1550][rpm], and a power greater than #qty[0.623][kW]:

#figure(
    pad(x: -3em, table(
        columns: 12,
        table.header(
            [*Model*],
            [*Width (#unit[mm])*],
            [*Height (#unit[mm])*],
            [*Depth (#unit[mm])*],
            [*Shaft Dia (#unit[mm])*],
            [*Power (#unit[kW])*],
            [*Speed (#unit[rpm])*],
            [*Eff. (%)*],
            [*Power Factor ($cos phi$)*],
            [*Rated Torque (#unit[Nm])*],
            [*Noise (#unit[dBA])*],
            [*Weight (#unit[kg])*],
        ),

        [TCC 802-4],
        [163],
        [226],
        [290],
        [19],
        [0.75],
        [1410],
        [69],
        [0.9],
        [5.08],
        [71],
        [10.9],
    )),
    caption: [Characteristics of the selected motor from @motor-catalogue.],
)

#pagebreak()

= Proposed layout
#figure(
    image("./images/proposed-layout.png", height: 95%),
    caption: [The proposed layout of the pulleys, gears and shafts.],
)

#pagebreak()

= Belt drive selection

== Obtaining the service factor
From @table-a-1, assuming the motor is operated between 10 and 16 hours a day
with a light duty conveyor belt, the service factor is chosen as 1.1.

Hence, the design power is:
$
    "Design power" & = "Service factor" times "Juicing power" \
                   & = 1.1 times 0.346 = #qty[0.38051][kW]
$

== Selecting the V-belt cross-section
A V-belt is used this project due to the requirement of having a short centre
distance and the machine operating at high speeds with low torque.

Due to the vertical orientation of the belt drive, it is more effective to use a
V-belt for power transmission due to the increased friction from the wedge
action.

Hence, from @table-a-2-and-a-3, with a design power of #qty[0.38051][kW] and a
speed of #qty[1410][rpm] for the faster shaft:

The *SPZ* V-belt cross-section is selected.

#pagebreak()

== Selecting the driver sheave diameter ($D_"driver"$)
Assuming ideal operation where the belt speed is between #qty[5][m s^-1] and
#qty[33][m s^-1], we assume a belt speed of #qty[10][m s^-1] and a speed ratio
of 3.

Thus, the angular velocity of the driver is:
$ omega_"driver" = 1410 times frac(2 pi, 60) = 47 pi #unit[rad s^-1] $

Obtaining the diameter of the driving sheave:
$
    D_"driver" = frac(2 v_b, omega_"driver") = frac(2 (10), 47 pi)
    = 0.1354510154 #unit[m] approx #qty[135][mm]
$

From @table-a-4-a-5-and-a-6, we select $D_"driver"$ to be #qty[140][mm].

Checking the belt speed:
$
    v_b = frac(D_"driver" omega_"driver", 2) = frac(140 times 10^(-3) (47pi), 2)
    = 329/100 pi approx #qty[10.34][m s^-1]
$

Since $#qty[5][m s^-1] < v_b < #qty[33][m s^-1]$, it is fine for $D_"driver"$ to
be #qty[140][mm].

== Selecting the driven sheave diameter ($D_"driven"$)
Using the speed ratio of 3:
$ S R = frac(eta_"driver", eta_"driven") = frac(D_"driven", D_"driver") $
$ D_"driven" = S R times D_"driver" = 3 times 140 = #qty[420][mm] $

From @table-a-4-a-5-and-a-6, we select $D_"driven"$ to be #qty[400][mm].

$ "Actual" S R = frac(D_"driven", D_"driver") = 400/140 = 20/7 approx 2.86 $

The actual speed ratio of 2.86 is acceptable as it is less than 3.

$
    eta_"driven" = frac(D_"driver", D_"driven") times eta_"driver"
    = 140/400 times 1410 = #qty[493.5][rpm]
$

#pagebreak()

== Selecting the belt length ($L$)
The recommended centre distance is:
$ D_"driven" < C < 3 (D_"driven" + D_"driver") $
$ #qty[400][mm] < C < 3 (#qty[400][mm] + #qty[140][mm]) $
$ #qty[400][mm] < C < #qty[1620][mm] $

To fit the height constraint of #qty[1400][mm]:
$ #qty[400][mm] < C < #qty[1400][mm] $

Assuming the tentative centre distance (TCD) to be #qty[600][mm], the tentative
belt length (TBL) is:
$
    T B L & = 2 times T C D + 1.57 (D_"driven" + D_"driver")
            + frac((D_"driven" - D_"driver"), 4 times T C D) \
          & = 2 (0.6) + 1.57 (0.400 + 0.140)
            + frac((0.400 - 0.140)^2, 4 (0.6)) \
          & = #qty[2.07596666][m] approx #qty[2076][mm]
$

From @table-a-4-a-5-and-a-6, we select the closest standard belt length of
#qty[2000][mm].

Calculating the actual centre distance:

$ C = frac(B + sqrt(B^2 - 32 (D_"driven" - D_"driver")^2), 16) $

Where $B = 4L - 6.28 (D_"driven" + D_"driver")$.

$ B = 4 (2) - 6.28 (0.400 + 0.140) = #qty[4.6088][m] $

$
    C & = frac(4.6088 + sqrt(4.6088^2 - 32 (0.400 - 0.140)^2), 16) \
      & = #qty[0.561038649][m] approx #qty[561][mm]
$

Since $#qty[400][mm] < C < #qty[1400][mm]$, it is within the required centre
distance.

#pagebreak()

== Determining the power correction factor ($C_theta$, $C_L$)
Angle of contact for the smaller sheave ($theta_1$)
$
    theta_1 = 180 degree - 2 arcsin (frac(0.400 - 0.140, 2 times 0.561))
    = 153.2041007 degree approx 153.2 degree
$

From @table-a-4-a-5-and-a-6, by interpolating:
$ frac(153.2 - 151, 157 - 151) = frac(C_theta - 0.93, 0.94 - 0.93) $
$
    C_theta = frac(153.2 - 151, 157 - 151) (0.94 - 0.93) + 0.93
    = 0.933dot(6) approx 0.934
$

From @table-a-4-a-5-and-a-6,
$ C_L = 1.04 $

From @table-a-7a, by double interpolation:
#table(
    columns: 4,
    align: center + horizon,
    table.header(
        table.cell(rowspan: 2)[*Speed ratio*],
        table.cell(colspan: 3)[*RPM of smaller sheave*],
        [1200], [1410], [1600],
    ),

    [1.50], [3.74], [4.286], [4.78],
    $ 20/7 $, [3.767], [*4.323*], [4.825],
    [3.00], [3.77], [4.3265], [4.83],
)

Hence, the rated power per belt is #qty[4.323][kW belt^-1].

Corrected rated power (CRP):
$
    C R P & = C_theta C_L times "Rated power" \
          & = 0.934 times 1.04 times 4.323 = #qty[4.173147581][kW]
            approx #qty[4.173][kW]
$

Number of belts:
$
    "Number of belts" = frac("Design power", C R P)
    = frac(0.38051, 4.173) = 0.09118125741 approx 1
$

Thus, the required number of belts is 1.

== Summary
#figure(
    table(
        columns: 2,
        table.header([*V-belt cross-section*], [*Number of belts*]),

        [SPZ], [1],
    ),
    caption: [
        Characteristics of the selected belt drive from @belt-drive-design-data.
    ],
)

#pagebreak()

= Taper-lock pulley and bush selection
Based on the calculated dimensions of the belt drive, we have selected the
following pulleys from the #link(<fenner-catalogue>)[Fenner catalogue]:

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/fenner-pulley-type-1.png"),
    image("./images/fenner-pulley-type-4.png"),
))

#align(center)[All dimensions below are in #unit[mm].]

#figure(
    pad(x: -2em, table(
        columns: 13,
        align: center,
        table.header(
            [*Product code*],
            [*Pitch diameter (P)*],
            [*No. of grooves*],
            [*Bush number*],
            [*Max. bore*],
            [*Pulley type*],
            [*F*],
            [*J*],
            [*K*],
            [*L*],
            [*M*],
            [*N*],
            [*Outside diameter (O)*],
        ),

        [001Z0140],
        [140],
        [1],
        [1610],
        [42],
        [1],
        [16],
        [-],
        [-],
        [25],
        [9.0],
        [92],
        [145.5],

        [001Z0400],
        [400],
        [1],
        [2012],
        [50],
        [4],
        [16],
        [371],
        [8.0],
        [32.0],
        [8.0],
        [112],
        [405.5],
    )),
    caption: [Dimensions of the selected taper-lock pulleys from @fenner-spz.],
)

#figure(
    table(
        columns: 7,
        table.header(
            table.cell(rowspan: 2)[*Bush number*],
            table.cell(rowspan: 2)[*Bore diameter*],
            table.cell(colspan: 2)[*Keyway*],
            table.cell(rowspan: 2)[*Shallow keyway depth*],
            table.cell(rowspan: 2)[*Nominal diameter at large end of taper*],
            table.cell(rowspan: 2)[*Approximate mass of bush (#unit[kg])*],

            [*Width*],
            [*Depth*],
        ),

        [1610], [19], [6], [2.8], [-], [57.0], [0.3],
        [2012], [20], [6], [2.8], [-], [70.0], [0.7],
    ),
    caption: [Dimensions of the selected taper-lock bushes from
        @fenner-bushes.],
)

#pagebreak()

= Belt drive force analysis

== Diagram
#align(center, cetz.canvas({
    import cetz.draw: *
    import newtonian: *

    let cross((x, y), length: 0.2) = {
        line((x, y - length), (x, y + length))
        line((x - length, y), (x + length, y))
    }

    let driver = (0, 0)
    let driver-radius = 1
    let hole-radius = 0.2
    let distance = 6
    let driven = (distance, 0)
    let driven-radius = 2
    let shaft-radius = 0.5
    let shaft-distance = 1.5

    // Tangent angle
    let alpha = 20deg

    // Driver shaft
    group({
        let shaft = (-(shaft-distance + driver-radius), 0)

        set-origin(driver)

        circle((0, 0), radius: driver-radius)
        circle((0, 0), radius: hole-radius)
        curved-arrow(
            (0, 0),
            radius: driver-radius + 0.2,
            start-angle: 225deg,
            end-angle: 135deg,
        )
        content(
            (0, 0),
            (135deg, driver-radius + 0.5),
            anchor: "south",
            $T_"driver", \ eta_"driver", \ omega_"driver"$,
        )

        circle(shaft, radius: shaft-radius)
        cross(shaft)
        curved-arrow(shaft, radius: 0.7, start-angle: -45deg, end-angle: 45deg)
        content((shaft.at(0), 0.6), anchor: "south", $T_"driver"$)
        content((shaft.at(0), shaft.at(1) - shaft-radius - 0.3), "Driver shaft")

        let tangent-top = (
            calc.cos(90deg + alpha) * driver-radius,
            calc.sin(90deg + alpha) * driver-radius,
        )

        let tangent-bottom = (
            (
                calc.cos(-90deg - alpha) * driver-radius,
                calc.sin(-90deg - alpha) * driver-radius,
            )
        )

        line(
            tangent-top,
            (tangent-top.at(0) + 1.5, tangent-top.at(1) + 0.5),
            name: "driver-f2",
            mark: (end: "straight"),
        )
        content("driver-f2.end", anchor: "south-west", $F_2$)

        line(
            tangent-bottom,
            (tangent-bottom.at(0) + 1.5, tangent-bottom.at(1) - 0.5),
            name: "driver-f1",
            mark: (end: "straight"),
        )
        content("driver-f1.end", anchor: "north-west", $F_1$)

        // Belt velocity
        line(
            (tangent-bottom.at(0) + 1.5, tangent-bottom.at(1) - 0.25),
            (tangent-bottom.at(0) + 1, tangent-bottom.at(1) - 0.05),
            name: "belt-velocity",
            mark: (end: "straight"),
        )
        content("belt-velocity.mid", anchor: "south-west", $v_b$)

        rotate(-45deg)
        line(
            (0, -driver-radius),
            (0, driver-radius),
            mark: (start: "straight", end: "straight"),
        )
        content((-0.15, 0.5), anchor: "east", $D_"driver"$)
        rotate(45deg)
    })

    // Driven shaft
    group({
        let shaft = ((shaft-distance + driven-radius), 0)

        set-origin(driven)
        circle((0, 0), radius: driven-radius)
        circle((0, 0), radius: hole-radius)
        curved-arrow(
            (0, 0),
            radius: driven-radius + 0.2,
            start-angle: -45deg,
            end-angle: 45deg,
        )
        content(
            (1.6, 1.7),
            anchor: "south",
            $T_"driven", \ eta_"driven", \ omega_"driven"$,
        )

        circle(shaft, radius: shaft-radius)
        cross(shaft)
        curved-arrow(shaft, radius: 0.7, start-angle: 225deg, end-angle: 135deg)
        content((shaft.at(0), 0.6), anchor: "south", $T_"driven"$)
        content((shaft.at(0), shaft.at(1) - shaft-radius - 0.3), "Driven shaft")

        let tangent-top = (
            calc.cos(90deg + alpha) * driven-radius,
            calc.sin(90deg + alpha) * driven-radius,
        )
        let tangent-bottom = (
            calc.cos(-90deg - alpha) * driven-radius,
            calc.sin(-90deg - alpha) * driven-radius,
        )

        line(
            tangent-top,
            (tangent-top.at(0) - 1.5, tangent-top.at(1) - 0.5),
            mark: (end: "straight"),
            name: "driven-f2",
        )
        content("driven-f2.end", anchor: "south-east", $F_2$)

        line(
            tangent-bottom,
            (tangent-bottom.at(0) - 1.5, tangent-bottom.at(1) + 0.5),
            mark: (end: "straight"),
            name: "driven-f1",
        )
        content("driven-f1.end", anchor: "north-east", $F_1$)

        rotate(45deg)
        line(
            (0, -driven-radius),
            (0, driven-radius),
            mark: (start: "straight", end: "straight"),
        )
        content((0.1, 1), anchor: "west", $D_"driven"$)
    })

    line(
        (driver.at(0) - driver-radius, driver.at(1)),
        (driven.at(0) + driven-radius, driven.at(1)),
        stroke: (dash: "dashed"),
    )
}))

== Calculations
From @table-a-1, the mass of the SPZ belt is:
$ m = #qty[0.070][kg] $

The belt speed is:
$ v_b = #qty[10.34][m s^-1] $

Hence, the centrifugal force is:
$ F_c = m v^2 = 0.070 times 10.34^2 = 7.47807095 approx #qty[7.478][N] $

The taper-lock pulley diameter of #qty[140][mm] is greater than #qty[80][mm],
hence:
$ "Half the included angle of the sheave groove," beta = 38/2 = 19 degree $
$ "Effective friction coefficient," f_e = 0.40 $
$ frac(f, sin beta) = f_e $

$
    "Angle of contact," theta_1 = frac(pi, 180 degree) times 153.2 degree
    = 383/450 pi approx #qty[2.674][rad]
$
$
    "Belt tension ratio," gamma = e^(theta_1 f_e) = e^(2.674 times 0.40)
    = 2.914032223 approx 2.914
$

Assuming that there is no power loss and the belt force is parallel, with the
input speed of the pulley of #qty[1400][rpm] and the pulley diameter
$D_"driver"$ of #qty[140][mm]:
$
    "Torque of the driver sheave," T_"driver" = P/omega_"driver"
    & = frac(346, frac(2 pi, 60) times 1410) \
    &= 2.342765957 approx #qty[2.343][Nm]
$

#pagebreak()

Utilising the tension equation,
$
    "Force on the tight side," F_1
    &= F_c + 2 (frac(gamma, gamma - 1)) (T_"driver"/D_"driver") \
    &= 7.478 + 2 (frac(2.914, 2.914 - 1)) (2.343/0.140) \
    &= 58.43718425 approx #qty[58.437][N]
$

$
    "Force on the slack side," F_2 &= F_1 - 2 (T_"driver"/D_"driver") \
    &= 58.437 - 2 (2.343/0.140) = 24.96909915 approx #qty[24.9691][N]
$

$
    "Shaft load," F_"total" = F_1 + F_2
    = 58.437 + 24.9691 = #qty[83.4062834][N] "(Vertically downwards)"
$

#pagebreak()

= Gear selection
Due to the limitations imposed by the dimensions of the machine frame, we have
chosen to use spur gears as we are placing the shafts in parallel arrangement.
Spur gears are simple to design, compact, and easy to obtain.

We assume that there is no power loss and the power transmitted is the juicing
power of #qty[0.346][kW].

== Determining the total speed ratio
Total gear speed ratio:
$ S R_T = frac(493.5, 44) = 11.21590909 approx 11.22 $

Since the total gear speed ratio is greater than the recommended gear speed
ratio of 7, a 2-stage gear reduction is required to achieve the desired gear
reduction.

Assuming that each stage reduces the speed by the same amount:
$ S R_"avg" = sqrt(11.22) = 3.349016138 approx 3.35 $

== Determining the design power
The gears will be selected from the #link(<misumi-gear-overview>)[Misumi
    catalogue], which suggests a safety factor of 1.2.

Hence, the equation for the design power is:
$ P_"design" = "Juicing power" dot 1.2 $
$ P_"design" = 0.346 dot 1.2 = 0.4151049205 approx #qty[0.415][kW] $

== Determining the minimum number of teeth for no interference
For no interference with a rack, the minimum number of teeth ($N_p$) is:
$
    m_p = frac(Z, p_b) = frac(
        sqrt(R_o^2 - R_b^2) + sqrt(r_o^2 - r_b^2) -
        C sin phi.alt, p cos phi.alt
    )
$

Since the pressure angle of the gears in @misumi-catalogue are all $20 degree$,

$ "Minimum" N_p >= frac(2, sin^2 20 degree) >= 17.1 $

Hence, the minimum number of teeth for no interference is 18.

#pagebreak()

== Gears 1 and 2
$
    T_1 = P_"design"/omega = frac(0.415 times 10^3, 493.5 (frac(2pi, 60)))
    = 8.032340426 approx #qty[8.0323][Nm]
$

Looking at @misumi-catalogue and searching for the smallest gear that can
withstand #qty[8.0323][Nm] of torque, has at least 18 teeth, and has a keyway
bore diameter of at least #qty[20][mm], we select from
@misumi-module-25-shaft-bore-configurable-type a gear with a module of
#qty[2.5][mm] and $N_1 = 18$.

Using the previously calculated estimated speed ratio of 3.35:
$ S R_(12) = N_2/N_1 $
$ N_2 = 3.35 times 18 = 60.3 $

Looking at @misumi-module-25-shaft-bore-configurable-type,
$ "Select" N_2 = 60 $

Getting the actual speed ratio:
$ "Actual" S R_(12) = 60/18 = 10/3 approx 3.33 $

Rotational speed of gear 2:
$ eta_2 = frac(eta_1, S R_(1 2)) = 493.5/3.33 = #qty[148.05][rpm] $

Torque on gear 2:
$
    T_2 = P_"design"/omega = frac(0.415 times 10^3, 148.05 (frac(2pi, 60)))
    = 26.77446809 approx #qty[26.774][Nm]
$

The critical torque ($T_(c, 2)$) on gear 2 is #qty[369.44][Nm] from
@misumi-module-25-shaft-bore-configurable-type, and since $T_2 < T_(c, 2)$, the
gear chosen for gear 2 is suitable.

#pagebreak()

== Gears 3 and 4
Since gear 2 and 3 sit on the same shaft, so gear 2 and 3 have the same
rotational speed.

Rotational speed and torque of gear 3:
$ eta_3 = eta_2 = #qty[148.05][rpm] $
$ T_3 = T_2 = #qty[26.774][Nm] $

Looking at @misumi-catalogue and searching for the smallest gear that can
withstand #qty[26.774][Nm] of torque, has at least 18 teeth, and has a keyway
bore diameter of at least #qty[25][mm], we select from
@misumi-module-30-shaft-bore-configurable-type a gear with a module of
#qty[3.0][mm] and $N_3 = 18$.

$
    S R_(34) = frac(S R_T, S R_(12)) = frac(11.22, 10/3)
    = 3.364772727 approx 3.365
$
$ N_4 = 3.365 times 18 = 60.56590909 approx 60.566 $

Looking at @misumi-module-30-shaft-bore-configurable-type,
$ "Select" N_4 = 60 $

Getting the actual speed ratio:
$ S R_(3 4) = 60/18 = 10/3 approx 3.33 $

Rotational speed of gear 4:
$ eta_4 = frac(eta_3, S R_(3 4)) = frac(148.05, 10/3) = #qty[44.415][rpm] $

Since the calculated speed of #qty[44.415][rpm] is within the range
$41.8 <= eta_4 <= 46.2$, the gear chosen for gear 4 is suitable.

Torque on gear 4:
$
    T_4 = P_"design"/omega = frac(0.415 times 10^3, 44.415 (frac(2pi, 60)))
    = 89.24822695 approx #qty[89.25][Nm]
$

The critical torque ($T_(c, 4)$) on gear 4 is #qty[638.4][Nm] from
@misumi-module-30-shaft-bore-configurable-type, and since $T_4 < T_(c, 4)$, the
gear chosen for gear 4 is suitable.

#pagebreak()

== Gears 5 and 6
From @parks2021saccharum, the diameter of sugarcane ranges from #qty[20][mm] to
#qty[45][mm]. Taking the average diameter of sugarcane:

$ "Average sugarcane diameter" = (20 + 45)/2 = #qty[32.5][mm] $

With the given roller diameter of #qty[130][mm], the centre distance between
gears 5 and 6 is:
$ C_(5 6) = 130 + 32.5/2 = #qty[146.25][mm] $

Using a nicer number for calculations, we round $C_(5 6)$ to 2 significant
figures:
$ C_(5 6) = #qty[150][mm] $

Assuming that the torque is evenly distributed between the 2 rollers, the torque
on gear 5 and 6 would be:
$
    T = 1/2 P_"design"/omega = 1/2 frac(
        0.415 times 10^3,
        44.415 (frac(2pi, 60))
    ) = 44.62411348 approx #qty[44.624][Nm]
$

Using the largest module available in @misumi-catalogue, $m = #qty[3.0][mm]$:
$ C = m (2N)/2 = m N $
$ 150 = 3.0 times N $
$ N = 50 $
$ therefore N_5 = N_6 = 50 $

The critical torque ($T_c$) on gears 5 and 6 is #qty[511.77][Nm] from
@misumi-module-30-shaft-bore-configurable-type, and since $T < T_c$, the gears
chosen for gears 5 and 6 is suitable.

== Summary
#figure(
    table(
        columns: 6,
        table.header(
            [*Gear*],
            [*Module (#unit[mm])*],
            [*Number of teeth*],
            [*Pitch diameter (#unit[mm])*],
            [*Outer diameter (#unit[mm])*],
            [*Bore diameter (#unit[mm])*],
        ),

        [1], [2.5], [18], [45], [50], [20],
        [2], [2.5], [60], [150], [155], [25],
        [3], [3.0], [18], [54], [60], [25],
        [4], [3.0], [60], [180], [186], [50],
        [5], [3.0], [50], [150], [156], [50],
        [6], [3.0], [50], [150], [156], [30],
    ),
    caption: [Dimensions of the chosen gears from @misumi-catalogue.],
)

#pagebreak()

= Gear force analysis
$ "Juicing power" = #qty[0.346][kW] $

== Gear 1
$ D_p = #qty[36][mm] $
$ eta_1 = #qty[493.5][rpm] $
$
    T_1 = frac(0.346 times 10^3, 493.5 times frac(2pi, 60))
    = 6.693617021 approx #qty[6.69][Nm]
$
$
    W_t = frac(T_1, 1/2 D_p) = frac(6.69, 1/2 times 45 times 10^(-3))
    = 297.4940898 approx #qty[297.49][N]
$
$
    W_r = W_t tan theta = 297.49 tan 20 degree
    = 108.2789936 approx #qty[108.28][N]
$

== Gear 2
$ D_p = #qty[120][mm] $
$ eta_2 = #qty[148.05][rpm] $
$
    T_2 = frac(0.346 times 10^3, 148.05 times frac(2pi, 60))
    = 22.31205674 approx #qty[22.31][Nm]
$
$
    W_t = frac(T_2, 1/2 D_p) = frac(22.31, 1/2 times 150 times 10^(-3))
    = 297.4940898 approx #qty[297.49][N]
$
$
    W_r = W_t tan theta = 297.49 tan 20 degree
    = 108.2789936 approx #qty[108.28][N]
$

== Gear 3
$ D_p = #qty[45][mm] $
$ eta_3 = #qty[148.05][rpm] $
$
    T_3 = frac(0.346 times 10^3, 148.05 times frac(2pi, 60))
    = 22.31205674 approx #qty[22.31][Nm]
$
$
    W_t = frac(T_3, 1/2 D_p) = frac(22.31, 1/2 times 54 times 10^(-3))
    = 826.3724718 approx #qty[826.37][N]
$
$
    W_r = W_t tan theta = 826.37 tan 20 degree
    = 300.7749821 approx #qty[300.77][N]
$

#pagebreak()

== Gear 4
$ D_p = #qty[150][mm] $
$ eta_4 = #qty[44.415][rpm] $
$
    T_4 = frac(0.346 times 10^3, 44.415 times frac(2pi, 60))
    = 74.37352246 approx #qty[74.37][Nm]
$
$
    W_t = frac(T_4, 1/2 D_p) = frac(74.37, 1/2 times 150 times 10^(-3))
    = 826.3724718 approx #qty[826.37][N]
$
$
    W_r = W_t tan theta = 991.65 tan 20 degree
    = 300.7749821 approx #qty[300.77][N]
$

== Gear 5
$ D_p = #qty[150][mm] $
$ eta_5 = #qty[44.415][rpm] $
$
    T_5 = frac(0.346 times 10^3, 44.415 times frac(2pi, 60))
    = 74.37352246 approx #qty[74.37][Nm]
$
$
    W_t = frac(T_5, 1/2 D_p) = frac(74.37, 1/2 times 150 times 10^(-3))
    = 991.6469661 approx #qty[991.65][N]
$
$
    W_r = W_t tan theta = 991.65 tan 20 degree
    = 360.9299786 approx #qty[360.93][N]
$

== Gear 6
$ D_p = #qty[150][mm] $
$ eta_6 = #qty[44.415][rpm] $
$
    T_6 = frac(0.346 times 10^3, 44.415 times frac(2pi, 60))
    = 74.37352246 approx #qty[74.37][Nm]
$
$
    W_t = frac(T_6, 1/2 D_p) = frac(74.37, 1/2 times 150 times 10^(-3))
    = 991.6469661 approx #qty[991.65][N]
$
$
    W_r = W_t tan theta = 991.65 tan 20 degree
    = 360.9299786 approx #qty[360.93][N]
$

== Summary
#figure(
    table(
        columns: 6,

        table.header(
            [*Gear*],
            [*Pitch diameter (#unit[mm])*],
            [*Rotational speed (#unit[rpm])*],
            [*Torque (#unit[Nm])*],
            [*Tangential force (#unit[N])*],
            [*Radial force (#unit[N])*],
        ),

        [1], [27], [493.5], [6.69], [297.49], [108.28],
        [2], [90], [148.05], [22.31], [297.49], [108.28],
        [3], [36], [148.05], [22.31], [826.37], [300.77],
        [4], [120], [44.415], [74.37], [826.37], [300.77],
        [5], [150], [44.415], [74.37], [991.65], [360.93],
        [6], [150], [44.415], [74.37], [991.65], [360.93],
    ),
    caption: [Summary of the forces on the gears.],
)

#pagebreak()

= Shafts
For the shafts, we selected 304 stainless steel for its mechanical strength,
corrosion resistance and food safety. The mechanical properties are taken from
@azo2024, with the data shown in @mechanical-properties-of-304-stainless.

#align(center, table(
    columns: 2,
    align: left,

    [Yield strength ($S_y$)], [#qty[205][MPa]],
    [Tensile strength ($S_u$)], [#qty[515][MPa]],
    [Endurance limit ($S_n$)], $0.5 S_u = 0.5 times 515 = #qty[257.5][MPa]$,
    [Size correction factor ($C_s$)], [0.78 for a diameter of #qty[70][mm]],
    [Reliability factor ($C_r$)], [0.81 for 99% desired reliability],

    [Modified endurance strength ($S_n'$)],
    $S_n C_s C_r = 257.5 (0.78) (0.81) = #qty[162.7][MPa]$,

    [Design factor ($N$)], [3],
))

// The default length scale
#let default-length-scale = 0.02

// Function to draw a force diagram
#let force-diagram(
    labels: (),
    length-scale: default-length-scale,
    force-scale-multiplier: 1,
    mark-size: 0.1,
    padding: 0.1,
    force-graph: false,
    hold-force-value: false,
    show-distance: false,
    show-all-forces: false,
) = {
    //

    // Create a cetz canvas
    cetz.canvas({
        import cetz.draw: *

        // Initialise the absolute x position
        let absolute-x = 0

        // Initialise the previous y position
        let previous-y = 0

        // Initialise the previous force
        let previous-force = 0

        // Initialise the previous moment
        let previous-moment = 0

        // Get the maximum force
        let max-force = labels
            .map(item => if item.at("force", default: none) == none { 0 } else {
                calc.abs(item.force.value)
            })
            .reduce((acc, force) => calc.max(acc, force))

        // Get the force scale
        let force-scale = (
            calc.pow(10, -calc.floor(calc.log(max-force)))
                * force-scale-multiplier
        )

        // Iterate over the labels
        for item in labels {
            //

            // Get the relative x as a number
            let relative-x = calc.round(
                if item.at("x", default: none) == none { 0 } else { item.x }
                    * length-scale,
            )

            // Get the previous x
            let previous-x = absolute-x

            // Increase the absolute x coordinate
            absolute-x += relative-x

            // Draw the mark for the label
            line(
                (absolute-x, mark-size),
                (absolute-x, -mark-size),
            )

            // Draw a line to the label
            line(
                (previous-x, 0),
                (absolute-x, 0),
            )

            // Place the relative x coordinate above the line if wanted
            if show-distance and relative-x != 0 {
                content(
                    ((previous-x + absolute-x) / 2, 0),
                    anchor: "south",
                    padding: padding,
                    str(item.x),
                )
            }

            // Get the force
            let force = item.at("force", default: none)

            // Get whether the force is negative
            let force-is-negative = if force == none { false } else {
                force.value < 0
            }

            // Get the force anchor
            let force-anchor = if force-is-negative { "north" } else { "south" }

            // If it is not a force graph
            if not force-graph {
                //

                // If there is a label, write the label below the mark
                if item.at("label", default: none) != none {
                    content(
                        (
                            absolute-x,
                            if force-is-negative { 1 } else { -1 } * mark-size,
                        ),
                        anchor: if force-is-negative { "south" } else {
                            "north"
                        },
                        padding: padding,
                        item.label,
                    )
                }

                // Get whether to show the force
                let show-force = if force == none { false } else {
                    (
                        item.force.at("visible", default: false)
                            or show-all-forces
                            or force-graph
                    )
                }

                // If showing the forces isn't wanted, continue the loop
                if not show-force { continue }

                // Otherwise, get the force y coordinate
                let force-y = item.force.value * force-scale

                // If the force anchor exists
                if (
                    force.at("anchor", default: none) != none
                        and force.anchor.at("fbd", default: none) != none
                ) {
                    force-anchor = force.anchor.fbd
                }

                // Draw the force line
                line(
                    (absolute-x, 0),
                    (absolute-x, force-y),
                    mark: (end: "straight"),
                )

                // Label the force
                content(
                    (absolute-x, force-y),
                    anchor: force-anchor,
                    padding: padding,
                    qty[#item.force.value][N],
                )

                // Continue the loop
                continue
            }

            // Otherwise, it is a force graph, so skip if there is no force
            if force == none { continue }

            // Get the force value
            let force-y = item.force.value * force-scale

            // Initialise the force value
            let force-value = item.force.value

            // Update the force anchor if given
            let force-anchor-obj = if (
                item.force.at("anchor", default: none) != none
            ) {
                item.force.anchor
            } else { none }

            // Get the force unit
            let force-unit = "N"

            // Get if the item is the last one
            let is-last-item = item == labels.last()

            // If the force value is to be held,
            // like in a shear force diagram
            if hold-force-value {
                //

                // Draw a horizontal line from the previous force value
                line(
                    (previous-x, previous-y),
                    (absolute-x, previous-y),
                )

                // Draw a vertical line to
                // the previous force value + the current one
                line(
                    (absolute-x, previous-y),
                    (
                        absolute-x,
                        if is-last-item { 0 } else { previous-y + force-y },
                    ),
                )

                // Update the previous y position
                previous-y += force-y

                // Update the force-y value
                force-y = previous-y

                // Update the previous force
                previous-force += decimal(str(force-value))

                // Update the force value
                force-value = calc.round(previous-force * 100) / 100

                // Update the force anchor if it's given
                if (
                    force-anchor-obj != none
                        and force-anchor-obj.at("shear", default: none) != none
                ) {
                    force-anchor = force-anchor-obj.shear
                }
            } else {
                //

                // Change the force unit to Nm
                force-unit = "Nm"

                // Get the additional moment
                let additional-moment = (
                    decimal(previous-force)
                        * decimal(str(item.at("x", default: 0)))
                        * calc.pow(decimal(10), -3)
                )

                // Get the current moment
                let current-moment = (
                    decimal(previous-moment) + additional-moment
                )

                // Update the force y value
                force-y = if is-last-item { 0 } else {
                    float(current-moment) * force-scale
                }

                // Draw a straight line from the previous force value
                line(
                    (previous-x, float(previous-moment) * force-scale),
                    (absolute-x, force-y),
                )

                // Update the previous moment
                previous-moment = current-moment

                // Update the previous force
                previous-force += decimal(str(force-value))

                // Update the force value
                force-value = if is-last-item { 0 } else {
                    calc.round(current-moment * 100) / 100
                }

                // Update the force anchor
                force-anchor = if current-moment < 0 { "north" } else {
                    "south"
                }

                // Update the force anchor if it's given
                if (
                    force-anchor-obj != none
                        and force-anchor-obj.at("bend", default: none) != none
                ) {
                    force-anchor = force-anchor-obj.bend
                }
            }

            // Draw the label for the force
            content(
                (absolute-x, float(force-y)),
                anchor: force-anchor,
                padding: padding,
                qty[#force-value][#force-unit],
            )
        }
    })
}

// Function to draw all the force diagrams
#let draw-force-diagrams(
    labels,
    force-multiplier: 1,
    bending-multiplier: 20,
    length-scale: default-length-scale,
) = {
    //

    // Make the list of options for each diagram
    let options-list = (
        (
            show-distance: true,
            force-scale-multiplier: force-multiplier,
            length-scale: length-scale,
        ),
        (
            show-all-forces: true,
            force-scale-multiplier: force-multiplier,
            length-scale: length-scale,
        ),
        (
            force-graph: true,
            hold-force-value: true,
            force-scale-multiplier: force-multiplier,
            length-scale: length-scale,
        ),
    )

    // Draw the force diagrams with the options and labels
    for options in options-list {
        force-diagram(
            ..options,
            labels: labels,
        )
    }

    // Draw the bending moment diagram
    force-diagram(
        force-graph: true,
        force-scale-multiplier: bending-multiplier * force-multiplier,
        labels: labels,
        length-scale: length-scale,
    )
}

#{
    set grid(columns: 2, column-gutter: 2em, row-gutter: 1em, align: left)

    [== Shaft 1]
    align(center, grid(
        [*Belt*],
        [*Gear 1*],

        grid.cell(align: center, cetz.canvas({
            import cetz.draw: *
            import newtonian: *

            circle((0, 0), radius: 1)
            vector((1, 0), (1, -1), label: $F_1$)
            vector((-1, 0), (-1, -1), label: $F_2$)
            curved-arrow(
                (0, 0),
                start-angle: 0deg,
                end-angle: 45deg,
                radius: 1.3,
                label: $T_"belt"$,
            )
            curved-arrow(
                (0, 0),
                radius: 0.6,
                start-angle: 90deg,
                end-angle: 0deg,
                label: $eta$,
            )
        })),
        grid.cell(align: center, cetz.canvas({
            import cetz.draw: *
            import newtonian: *

            circle((0, 0), radius: 1)
            vector((0, 1), (0, 0.5), label: $W_r$)
            vector((0, 1), (-1.3, 1))
            content((-1.3, 1), anchor: "east", $W_t$)

            curved-arrow(
                (0, 0),
                start-angle: 45deg,
                end-angle: 0deg,
                radius: 1.2,
                label: $T_(G 1)$,
            )
            curved-arrow(
                (0, 0),
                radius: 0.6,
                start-angle: 0deg,
                end-angle: -90deg,
                label: $eta$,
            )

            content((2, 1.5), "Driving")
        })),

        [
            $
                T_"belt" = P/omega & = frac(
                                         0.346 times 10^3,
                                         493.05 (frac(2pi, 60))
                                     ) \
                                   & = 6.693617021 approx #qty[6.69][Nm]
            $

            From belt drive calculations:
            $ F_1 = #qty[58.437][N] $
            $ F_2 = #qty[24.9691][N] $
            $
                F_z = - F_1 - F_2 & = - 58.437 - 24.9691 \
                                  & = #qty[83.41][N] "(downwards)"
            $
        ],
        [
            $ T_(G 1) = #qty[6.69][Nm] $
            $ W_r = #qty[108.28][N] $
            $ W_t = #qty[297.49][N] $
            $ F_y = #qty[-297.49][N] $
            $ F_z = #qty[-108.28][N] $
        ],
    ))

    align(
        center,
        grid(
            grid.cell(colspan: 2, align: center)[
                *#underline[Reaction forces at bearings 1 and 2]*
            ],

            [*$y$-direction*], [*$z$-direction*],

            [
                $ sum M_(B 1) = 0 $
                $ 297.49 times 71 = F_(B 2 y) times 35 $
                $ F_(B 2 y) = #qty[603.42][N] "(upwards)" $

                $ sum F_y = 0 $
                $ F_(B 1 y) + 603.42 - 297.49 = 0 $
                $ F_(B 1 y) = #qty[305.93][N] "(downwards)" $
            ],

            [
                $ sum M_(B 1) = 0 $
                $ (83.41 times 105) + F_(B 2 z) times 35 = 108.28 times 71 $
                $ F_(B 2 z) = #qty[30.56][N] "(downwards)" $

                $ sum F_z = 0 $
                $ -83.41 + F_(B 1 z) - 30.56 - 108.28 = 0 $
                $ F_(B 1 z) = #qty[222.25][N] "(upwards)" $
            ],
        ),
    )

    pagebreak()

    [*Force diagrams*]

    align(center, grid(
        align: center,
        draw-force-diagrams(
            force-multiplier: 0.6,
            (
                (label: $B$),
                (
                    x: 105,
                    label: $B_1$,
                    force: (value: -305.93, anchor: (bend: "south")),
                ),
                (x: 35, label: $B_2$, force: (value: 603.42)),
                (
                    x: 36,
                    force: (
                        value: -297.49,
                        visible: true,
                        anchor: (bend: "south"),
                    ),
                ),
            ),
        ),
        draw-force-diagrams(
            force-multiplier: 1.5,
            (
                (
                    label: $B$,
                    force: (
                        value: -83.41,
                        visible: true,
                        anchor: (bend: "south"),
                    ),
                ),
                (
                    x: 105,
                    label: $B_1$,
                    force: (value: 222.25, anchor: (shear: "east")),
                ),
                (
                    x: 35,
                    label: $B_2$,
                    force: (value: -30.56, anchor: (bend: "north-west")),
                ),
                (
                    x: 36,
                    force: (
                        value: -108.28,
                        visible: true,
                        anchor: (bend: "south"),
                    ),
                ),
            ),
        ),

        grid.cell(colspan: 2)[
            $ M_B = 0 $
            $ M_(B 1) = sqrt(8.76^2 + 0^2) = #qty[8.76][Nm] $
            $ M_(B 2) = sqrt(10.71^2 + 6.04^2) = #qty[12.30][Nm] $
            $ M_G = 0 $
        ],
    ))

    pagebreak()

    [== Shaft 2]
    align(center, grid(

        [*Gear 2*],
        [*Gear 3*],

        grid.cell(align: center, cetz.canvas({
            import cetz.draw: *
            import newtonian: *

            circle((0, 0), radius: 1)
            vector((0, -1), (0, -0.5))
            content((0, -0.5), anchor: "south", $W_r$)
            vector((0, -1), (1.3, -1))
            content((1.3, -1), anchor: "west", $W_t$)

            curved-arrow(
                (0, 0),
                start-angle: 90deg,
                end-angle: 0deg,
                radius: 1.2,
                label: $T_(G 2)$,
            )
            curved-arrow(
                (0, 0),
                radius: 0.5,
                start-angle: -45deg,
                end-angle: 45deg,
                label: $eta$,
            )

            content((2, 1.5), "Driven")
        })),
        grid.cell(align: center, cetz.canvas({
            import cetz.draw: *
            import newtonian: *

            circle((0, 0), radius: 1)
            vector((0, 1), (0, 0.5), label: $W_r$)
            vector((0, 1), (1.3, 1))
            content((1.3, 1), anchor: "west", $W_t$)

            curved-arrow(
                (0, 0),
                start-angle: -90deg,
                end-angle: 0deg,
                radius: 1.3,
                label: $T_(G 3)$,
            )
            curved-arrow(
                (0, 0),
                radius: 0.6,
                start-angle: -90deg,
                end-angle: -0deg,
                label: $eta$,
            )

            content((2, 1.5), "Driving")
        })),

        [
            $ W_r = #qty[108.28][N] $
            $ W_t = #qty[297.49][N] $
            $ F_y = #qty[297.49][N] $
            $ F_z = #qty[108.28][N] $
        ],
        [
            $ W_r = #qty[300.77][N] $
            $ W_t = #qty[826.37][N] $
            $ F_y = #qty[826.37][N] $
            $ F_z = #qty[-300.77][N] $
        ],

        grid.cell(colspan: 2, align: center)[
            *#underline[Reaction forces at bearings 3 and 4]*
        ],

        [*$y$-direction*], [*$z$-direction*],

        [
            $ sum M_(B 3) = 0 $
            $ 826.37 times 36 = 297.49 times 71 + F_(B 4 y) times 35 $
            $ F_(B 4 y) = #qty[246.50][N] "(upwards)" $

            $ F_y = 0 $
            $ 826.37 - F_(B 3 y) + 246.50 + 297.49 = 0 $
            $ F_(B 3 y) = #qty[1370.36][N] "(downwards)" $
        ],
        [
            $ sum M_(B 3) = 0 $
            $ (300.77 times 36) + (108.28 times 71) = F_(B 4 z) times 35 $
            $ F_(B 4 z) = #qty[529.02][N] "(downwards)" $

            $ sum F_z = 0 $
            $ -300.77 + F_(B 3 z) - 529.02 + 108.28 = 0 $
            $ F_(B 3 z) = #qty[721.51][N] "(upwards)" $
        ],
    ))

    pagebreak()

    [*Force diagrams*]

    align(center, grid(
        align: center,
        draw-force-diagrams(
            force-multiplier: 2,
            (
                (
                    label: $G_3$,
                    force: (
                        value: 826.37,
                        visible: true,
                        anchor: (bend: "north"),
                    ),
                ),
                (x: 36, label: $B_3$, force: (value: -1370.36)),
                (
                    x: 35,
                    label: $B_4$,
                    force: (value: 246.50, anchor: (bend: "south-west")),
                ),
                (
                    x: 36,
                    label: $G_4$,
                    force: (
                        value: 297.49,
                        visible: true,
                        anchor: (fbd: "west", bend: "north"),
                    ),
                ),
            ),
        ),
        draw-force-diagrams(
            force-multiplier: 0.4,
            (
                (label: $G_3$, force: (value: -300.77, visible: true)),
                (x: 36, label: $B_3$, force: (value: 721.51)),
                (x: 35, label: $B_4$, force: (value: -529.02)),
                (
                    x: 36,
                    label: $G_4$,
                    force: (
                        value: 108.28,
                        visible: true,
                        anchor: (bend: "north"),
                    ),
                ),
            ),
        ),

        grid.cell(colspan: 2)[
            $ M_(G 3) = 0 $
            $ M_(B 3) = sqrt(29.75^2 + 10.83^2) = #qty[31.66][Nm] $
            $ M_(B 4) = sqrt(10.71^2 + 3.90^2) = #qty[11.40][Nm] $
            $ M_(G 4) = 0 $
        ],
    ))

    pagebreak()

    [== Shaft 3]
    align(center, grid(

        [*Gear 4*],
        [*Gear 5*],

        grid.cell(align: center, cetz.canvas({
            import cetz.draw: *
            import newtonian: *

            circle((0, 0), radius: 1)
            vector((0, -1), (0, -0.5))
            content((0, -0.5), anchor: "south", $W_r$)
            vector((0, -1), (-1.3, -1))
            content((-1.3, -1), anchor: "north-east", $W_t$)

            curved-arrow(
                (0, 0),
                start-angle: 180deg,
                end-angle: 225deg,
                radius: 1.2,
                label: $T_(G 4)$,
            )
            curved-arrow(
                (0, 0),
                radius: 0.5,
                start-angle: 45deg,
                end-angle: -45deg,
                label: $eta$,
            )

            content((2, 1.5), "Driven")
        })),
        grid.cell(align: center, cetz.canvas({
            import cetz.draw: *
            import newtonian: *

            circle((0, 0), radius: 1)
            vector((0, -1), (0, -0.5))
            content((0, -0.5), anchor: "south", $W_r$)
            vector((0, -1), (1.3, -1))
            content((1.3, -1), anchor: "west", $W_t$)

            curved-arrow(
                (0, 0),
                start-angle: 45deg,
                end-angle: 0deg,
                radius: 1.3,
                label: $T_(G 5)$,
            )
            curved-arrow(
                (0, 0),
                radius: 0.6,
                start-angle: 45deg,
                end-angle: -45deg,
                label: $eta$,
            )

            content((2, 1.5), "Driving")
        })),

        [
            $ W_r = #qty[300.77][N] $
            $ W_t = #qty[826.37][N] $
            $ F_y = #qty[-826.37][N] $
            $ F_z = #qty[300.77][N] $
        ],
        [
            $ W_r = #qty[360.93][N] $
            $ W_t = #qty[991.65][N] $
            $ F_y = #qty[991.65][N] $
            $ F_z = #qty[360.93][N] $
        ],

        grid.cell(colspan: 2, align: center)[
            *#underline[Reaction forces at bearings 5 and 6]*
        ],

        [*$y$-direction*], [*$z$-direction*],

        [
            $ sum M_(B 6) = 0 $
            $
                (826.37 times 469) + F_(B 5 y) times 265 \
                = (577.5 times 132.5) + 991.65 times 305.5
            $
            $ F_(B 5 y) = #qty[30.56][N] "(upwards)" $

            $ F_y = 0 $
            $ -826.37 + 991.65 + 30.56 + 577.5 - F_(B 6 y) = 0 $
            $ F_(B 6 y) = #qty[773.34][N] "(downwards)" $
        ],
        [
            $ sum M_(B 5) = 0 $
            $
                (300.77 times 204) + (360.93 times 40.5) +
                (F_(B 6 z) times 265) \
                = 3300 times 132.5
            $
            $ F_(B 6 z) = #qty[1363.30][N] "(downwards)" $

            $ sum F_z = 0 $
            $ 300.77 + 360.93 + 3300 - 1363.30 - F_(B 5 z) = 0 $
            $ F_(B 5 z) = #qty[2598.40][N] "(downwards)" $
        ],
    ))

    pagebreak()

    [*Force diagrams*]

    align(center, grid(
        align: center,
        column-gutter: 5em,
        draw-force-diagrams(
            force-multiplier: 0.2,
            bending-multiplier: 5,
            length-scale: 0.013,
            (
                (label: $G_4$, force: (value: -826.37, visible: true)),
                (
                    x: 163.5,
                    label: $G_5$,
                    force: (
                        value: 991.65,
                        visible: true,
                        anchor: (shear: "south-east"),
                    ),
                ),
                (
                    x: 40.5,
                    label: $B_5$,
                    force: (value: 30.56, anchor: (bend: "north-west")),
                ),
                (
                    x: 132.5,
                    label: $R$,
                    force: (
                        value: 577.5,
                        visible: true,
                        anchor: (bend: "north-west"),
                    ),
                ),
                (
                    x: 132.5,
                    label: $B_6$,
                    force: (value: -773.34, anchor: (bend: "south")),
                ),
            ),
        ),
        draw-force-diagrams(
            force-multiplier: 0.8,
            bending-multiplier: 15,
            length-scale: 0.013,
            (
                (
                    label: $G_4$,
                    force: (
                        value: 300.77,
                        visible: true,
                        anchor: (bend: "north"),
                    ),
                ),
                (
                    x: 163.5,
                    label: $G_5$,
                    force: (
                        value: 360.93,
                        visible: true,
                        anchor: (bend: "south-east"),
                    ),
                ),
                (x: 40.5, label: $B_5$, force: (value: -2598.40)),
                (x: 132.5, label: $R$, force: (value: 3300, visible: true)),
                (
                    x: 132.5,
                    label: $B_6$,
                    force: (value: -1363.30, anchor: (bend: "south")),
                ),
            ),
        ),

        grid.cell(colspan: 2)[
            $ M_(G 4) = 0 $
            $ M_(G 5) = sqrt(135.11^2 + 49.18^2) = #qty[143.78][Nm] $
            $ M_(B 5) = sqrt(128.42^2 + 75.97^2) = #qty[149.21][Nm] $
            $ M_R = sqrt(102.47^2 + 180.64^2) = #qty[207.68][Nm] $
            $ M_(B 6) = 0 $
        ],
    ))

    [== Shaft 4]
    align(center, grid(

        [*Gear 6*],
        [*Roller*],

        grid.cell(align: center, cetz.canvas({
            import cetz.draw: *
            import newtonian: *

            circle((0, 0), radius: 1)
            vector((0, 1), (0, 0.5), label: $W_r$)
            vector((0, 1), (-1.3, 1))
            content((-1.3, 1), anchor: "east", $W_t$)

            curved-arrow(
                (0, 0),
                start-angle: 225deg,
                end-angle: 180deg,
                radius: 1.2,
                label: $T_(G 6)$,
            )
            curved-arrow(
                (0, 0),
                radius: 0.5,
                start-angle: -45deg,
                end-angle: 45deg,
                label: $eta$,
            )

            content((2, 1.5), "Driven")
        })),
        grid.cell(align: center, cetz.canvas({
            import cetz.draw: *
            import newtonian: *

            circle((0, 0), radius: 1)
            vector((0, 1), (0, 0.5), label: $F_c$)
            vector((-1.3, 1), (0, 1))
            content((-1.3, 1), anchor: "east", $F_t$)

            curved-arrow(
                (0, 0),
                start-angle: 0deg,
                end-angle: 45deg,
                radius: 1.2,
                label: $T_R$,
            )
            curved-arrow(
                (0, 0),
                radius: 0.5,
                start-angle: -90deg,
                end-angle: 0deg,
                label: $eta$,
            )
        })),

        [
            $ W_r = #qty[360.93][N] $
            $ W_t = #qty[991.65][N] $
            $ F_y = #qty[-991.65][N] $
            $ F_z = #qty[-360.93][N] $
        ],
        [
            $ F_t = #qty[577.5][N] $
            $ F_c = #qty[3300][N] "(crushing force)" $
            $ F_y = #qty[577.5][N] $
            $ F_z = #qty[-3300][N] $
        ],

        grid.cell(colspan: 2, align: center)[
            *#underline[Reaction forces at bearings 7 and 8]*
        ],

        [*$y$-direction*], [*$z$-direction*],

        [
            $ sum M_(B 7) = 0 $
            $ (991.65 times 40.5) + (577.5 times 132.5) = F_(B 8 y) times 265 $
            $ F_(B 8 y) = #qty[440.30][N] "(downwards)" $

            $ F_y = 0 $
            $ -991.65 + F_(B 7 y) + 577.5 - 440.30 = 0 $
            $ F_(B 7 y) = #qty[854.45][N] "(upwards)" $
        ],
        [
            $ sum M_(B 8) = 0 $
            $ (360.93 times 305.5) + (3300 times 132.5) = F_(B 7 z) times 265 $
            $ F_(B 7 z) = #qty[2066.09][N] "(upwards)" $

            $ sum F_z = 0 $
            $ -360.93 + 2066.09 - 3300 + F_(B 8 z) = 0 $
            $ F_(B 8 z) = #qty[1594.84][N] "(upwards)" $
        ],
    ))

    pagebreak()

    [*Force diagrams*]

    align(center, pad(x: -2em, grid(
        align: center,
        column-gutter: 5em,
        draw-force-diagrams(
            force-multiplier: 0.2,
            (
                (label: $G_6$, force: (value: -991.65, visible: true)),
                (
                    x: 40.5,
                    label: $B_7$,
                    force: (
                        value: 854.45,
                        anchor: (shear: "north-west", bend: "north-east"),
                    ),
                ),
                (x: 132.5, label: $R$, force: (value: 577.5, visible: true)),
                (
                    x: 132.5,
                    label: $B_8$,
                    force: (value: -440.30, anchor: (bend: "south")),
                ),
            ),
        ),
        draw-force-diagrams(
            bending-multiplier: 10,
            (
                (
                    label: $G_6$,
                    force: (
                        value: -360.93,
                        visible: true,
                        anchor: (fbd: "north-east"),
                    ),
                ),
                (x: 40.5, label: $B_7$, force: (value: 2066.09)),
                (x: 132.5, label: $R$, force: (value: -3300, visible: true)),
                (x: 132.5, label: $B_8$, force: (value: 1594.84)),
            ),
        ),

        grid.cell(colspan: 2)[
            $ M_(G 6) = 0 $
            $ M_(B 7) = sqrt(40.16^2 + 14.62^2) = #qty[42.74][Nm] $
            $ M_R = sqrt(58.34^2 + 211.32^2) = #qty[219.23][Nm] $
            $ M_(B 8) = 0 $
        ],
    )))
}

== Summary
Sample calculation for bearing 1 of shaft 1:
$
    D & = {frac(32 N, pi) sqrt(
                (frac(K_(f b) M, S_n'))^2
                + 3/4 (T/S_y)^2
            )}^(1/3) \
      & = {frac(32 times 3, pi) sqrt(
                (frac(1 times 8.76, 162.7 times 10^6))^2
                + 3/4 (frac(6.69, 205 times 10^6))^2
            )}^(1/3) \
      & = #qty[0.0122933045267915][m] = #qty[12.29][mm]
$

#[
    #set table(
        columns: (10em, 8em) + (auto,) * 5,
        align: center + horizon,
    )
    #let table-headers = table.header(
        [*Location*],
        [*Component or feature*],
        [*$K_(f b)$*],
        [*$M$ (#unit[Nm])*],
        [*$T$ (#unit[Nm])*],
        [*Minimum diameter (#unit[mm])*],
        [*Selected diameter (#unit[mm])*],
    )

    === Shaft 1
    #table(
        table-headers,

        [*Left of belt*],
        [Retaining ring],
        [3],
        [0.00],
        [0.00],
        [0.00],
        [20],

        [*Belt*],
        [Sheave, press-fit],
        [1],
        [0.00],
        [6.69],
        [9.52],
        [20],

        [*Bearing 1*],
        [Bearing, press-fit],
        [1],
        [8.76],
        [6.69],
        [12.29],
        [20],

        [*Bearing 2*],
        [Bearing, press-fit],
        [1],
        [12.30],
        [6.69],
        [13.51],
        [20],

        [*Gear 1*],
        [Gear, profile key],
        [2],
        [0.00],
        [6.69],
        [9.52],
        [20],

        [*Right of gear 1*],
        [Retaining ring],
        [3],
        [0.00],
        [0.00],
        [0.00],
        [20],
    )

    === Shaft 2
    #table(
        table-headers,

        [*Left of gear 3*],
        [Retaining ring],
        [3],
        [0.00],
        [0.00],
        [0.00],
        [25],

        [*Gear 3*],
        [Gear, profile key],
        [2],
        [0.00],
        [22.31],
        [14.23],
        [25],

        [*Bearing 3*],
        [Bearing, press-fit],
        [1],
        [18.76],
        [22.31],
        [19.74],
        [25],

        [*Bearing 4*],
        [Bearing, press-fit],
        [1],
        [11.40],
        [22.31],
        [15.31],
        [25],

        [*Gear 2*],
        [Gear, profile key],
        [2],
        [0.00],
        [22.31],
        [14.23],
        [25],

        [*Right of gear 2*],
        [Retaining ring],
        [3],
        [0.00],
        [0.00],
        [0.00],
        [25],
    )

    #pagebreak()

    === Shaft 3
    #table(
        table-headers,

        [*Left of gear 4*],
        [Retaining ring],
        [3],
        [0.00],
        [0.00],
        [0.00],
        [50],

        [*Gear 4*],
        [Gear, profile key],
        [2],
        [0.00],
        [74.27],
        [21.24],
        [50],

        [*Gear 5*],
        [Gear, profile key],
        [2],
        [143.78],
        [74.27],
        [38.00],
        [50],

        [*Bearing 5*],
        [Bearing, press-fit],
        [1],
        [149.21],
        [74.27],
        [30.94],
        [50],

        [*Right of bearing 5*],
        [Well-rounded],
        [1.5],
        [149.21],
        [74.27],
        [35.07],
        [70],

        [*Left of roller*],
        [Well-rounded],
        [1.5],
        [207.68],
        [74.27],
        [38.99],
        [70],

        [*Roller*],
        [Roller, press-fit],
        [1],
        [207.68],
        [74.27],
        [34.25],
        [120],

        [*Right of roller*],
        [Well-rounded],
        [1.5],
        [207.68],
        [74.27],
        [38.99],
        [70],

        [*Left of bearing 6*],
        [Well-rounded],
        [1.5],
        [0.00],
        [74.27],
        [21.24],
        [70],

        [*Bearing 6*],
        [Bearing, press-fit],
        [1],
        [0.00],
        [74.27],
        [21.24],
        [25],

        [*Right of bearing 6*],
        [Retaining ring],
        [3],
        [0.00],
        [0.00],
        [0.00],
        [25],
    )

    === Shaft 4
    #table(
        table-headers,

        [*Left of gear 6*],
        [Retaining ring],
        [3],
        [0.00],
        [0.00],
        [0.00],
        [30],

        [*Gear 6*],
        [Gear, profile key],
        [2],
        [0.00],
        [74.27],
        [21.24],
        [30],

        [*Bearing 7*],
        [Bearing, press-fit],
        [1],
        [42.74],
        [74.27],
        [23.21],
        [30],

        [*Right of bearing 7*],
        [Well-rounded],
        [1.5],
        [42.74],
        [74.27],
        [24.87],
        [30],

        [*Left of roller*],
        [Well-rounded],
        [1.5],
        [219.23],
        [74.27],
        [39.69],
        [70],

        [*Roller*],
        [Roller, press-fit],
        [1],
        [219.23],
        [74.27],
        [34.84],
        [120],

        [*Right of roller*],
        [Well-rounded],
        [1.5],
        [219.23],
        [74.27],
        [39.69],
        [70],

        [*Left of bearing 8*],
        [Well-rounded],
        [1.5],
        [0.00],
        [74.27],
        [21.24],
        [70],

        [*Bearing 8*],
        [Bearing, press-fit],
        [1],
        [0.00],
        [74.27],
        [21.24],
        [25],

        [*Right of bearing 8*],
        [Retaining ring],
        [3],
        [0.00],
        [0.00],
        [0.00],
        [25],
    )
]

#pagebreak()

= Bearings
Referring to assuming the machine is used in an 8-hour service work day:
$ "Number of hours" = 15 times 10^3 #unit[h] $

#{
    set grid(
        columns: 2,
        column-gutter: 2em,
        row-gutter: 1em,
        align: center + horizon,
    )

    [
        == Shaft 1
        $
            L_D = 15 times 10^3 times 493.05 times 60
            = 443.745 times 10^6 #unit[rev]
        $
    ]

    grid(
        [*Bearing 1*],
        [*Bearing 2*],

        [
            $
                P_d = sqrt(305.93^2 + 222.25^2) & = 378.1378418 \
                                                & approx #qty[378.14][N]
            $
            $
                C & = 378.14 (frac(443.745 times 10^6, 10^6))^(1/3) \
                  & = #qty[2884.217219][N] \
                  & = #qty[2.88][kN]
            $
        ],

        [
            $
                P_d = sqrt(603.42^2 + 30.56^2) & = 604.1933548 \
                                               & approx #qty[604.19][N]
            $
            $
                C & = 604.19 (frac(443.745 times 10^6, 10^6))^(1/3) \
                  & = #qty[4608.438207][N] \
                  & = #qty[4.61][kN]
            $
        ],

        [*Select bearing 6304, $diameter 20$*],
        [*Select bearing 6304, $diameter 20$*],
    )

    [
        == Shaft 2

        $
            L_D = 15 times 10^3 times 148.05 times 60
            = 133.245 times 10^6 #unit[rev]
        $
    ]

    grid(
        [*Bearing 3*],
        [*Bearing 4*],

        [
            $
                P_d = sqrt(1370.36^2 + 721.51^2) & = 1548.697262 \
                                                 & approx #qty[1548.70][N]
            $
            $
                C & = 1548.70 (frac(133.245 times 10^6, 10^6))^(1/3) \
                  & = #qty[7910.127874][N] \
                  & = #qty[7.91][kN]
            $
        ],

        [
            $
                P_d = sqrt(246.50^2 + 529.02^2) & = 538.6303714 \
                                                & approx #qty[583.63][N]
            $
            $
                C & = 583.63 (frac(133.245 times 10^6, 10^6))^(1/3) \
                  & = #qty[2980.95114][N] \
                  & = #qty[2.98][kN]
            $
        ],

        [*Select bearing 6205, $diameter 25$*],
        [*Select bearing 6205, $diameter 25$*],
    )

    [
        == Shaft 3

        $
            L_D = 15 times 10^3 times 44.415 times 60
            = 39.9735 times 10^6 #unit[rev]
        $
    ]

    grid(
        [*Bearing 5*],
        [*Bearing 6*],

        [
            $
                P_d = sqrt(30.56^2 + 2598.40^2) & = 2598.579703 \
                                                & approx #qty[2598.58][N]
            $
            $
                C & = 2598.58 (frac(39.9735 times 10^6, 10^6))^(1/3) \
                  & = #qty[8885.054593][N] \
                  & = #qty[8.89][kN]
            $
        ],

        [
            $
                P_d = sqrt(773.34^2 + 1363.30^2) & = 1567.367744 \
                                                 & approx #qty[1567.37][N]
            $
            $
                C & = 1567.37 (frac(39.9735 times 10^6, 10^6))^(1/3) \
                  & = #qty[5359.138285][N] \
                  & = #qty[5.36][kN]
            $
        ],

        [*Select bearing 6010, $diameter 50$*],
        [*Select bearing 6005, $diameter 25$*],
    )

    [
        == Shaft 4

        $
            L_D = 15 times 10^3 times 44.415 times 60
            = 39.9735 times 10^6 #unit[rev]
        $
    ]

    grid(
        [*Bearing 7*],
        [*Bearing 8*],

        [
            $
                P_d = sqrt(854.45^2 + 2066.09^2) & = 2235.802471 \
                                                 & approx #qty[2235.80][N]
            $
            $
                C & = 2235.80 (frac(39.9735 times 10^6, 10^6))^(1/3) \
                  & = #qty[7644.647956][N] \
                  & = #qty[7.64][kN]
            $
        ],

        [
            $
                P_d = sqrt(440.30^2 + 1594.84^2) & = 1654.502558 \
                                                 & approx #qty[1654.50][N]
            $
            $
                C & = 1654.50 (frac(39.9735 times 10^6, 10^6))^(1/3) \
                  & = #qty[5657.069335][N] \
                  & = #qty[5.66][kN]
            $
        ],

        [*Select bearing 6206, $diameter 30$*],
        [*Select bearing 6005, $diameter 25$*],
    )
}

== Summary
#figure(
    table(
        columns: 3,

        table.header(
            [*Bearing number*],
            [*Selected model number*],
            [*Diameter (#unit[mm])*],
        ),

        [1], [6304], [20],
        [2], [6304], [20],
        [3], [6205], [25],
        [4], [6205], [25],
        [5], [6010], [50],
        [6], [6005], [25],
        [7], [6206], [30],
        [8], [6005], [25],
    ),
    caption: [Summary of the selected bearings.],
)

#pagebreak()

= Shaft key
The shaft key is selected from @shaft-key-catalogue. Using stainless steel 304L
with a yield strength ($S_y$) of #qty[170][MPa].

$ "Minimum key length due to compression" space (L_c) = frac(4 T N, D H S_y) $
$ "Minimum key length due to shear" space (L_s) = frac(4 T N, D W S_y) $
$ N = 3 $

== Shaft 1
$ D = #qty[20][mm], quad T = #qty[6.69][Nm] $

From @shaft-key-catalogue:
$ W = H = 6 $
$
    L_c = L_s = frac(4 T N, D H S_y)
    &= frac(
        4 times 6.69 times 3,
        20 times 10^(-3) times 6 times 10^(-3) times 170 times 10^6
    ) \
    &= #qty[3.935294118][mm] approx #qty[3.94][mm]
$

$ L_"min" = L_c = L_s = #qty[3.94][mm] $

== Shaft 2
$ D = #qty[25][mm], quad T = #qty[22.31][Nm] $

From @shaft-key-catalogue:
$ W = 8, quad H = 7 $

#grid(
    columns: 2,
    column-gutter: 5em,
    $
        L_c = frac(4 T N, D H S_y) & = frac(
                                         4 times 22.31 times 3,
                                         25 times 10^(-3) times
                                         7 times 10^(-3) times 170 times 10^6
                                     ) \
                                   & = #qty[8.998991597][mm]
                                     approx #qty[9.00][mm]
    $,
    $
        L_s = frac(4 T N, D W S_y) & = frac(
                                         4 times 22.31 times 3,
                                         25 times 10^(-3) times
                                         8 times 10^(-3) times 170 times 10^6
                                     ) \
                                   & = #qty[7.874117647][mm]
                                     approx #qty[7.87][mm]
    $,
)

$ L_"min" = #qty[9.00][mm] $

== Shaft 3
$ D = #qty[50][mm], quad T = #qty[74.27][Nm] $

From @shaft-key-catalogue:
$ W = 14, quad H = 9 $

#grid(
    columns: 2,
    column-gutter: 2em,
    $
        L_c & = frac(4 T N, D H S_y) \
            & = frac(
                  4 times 74.27 times 3,
                  50 times 10^(-3) times 9 times 10^(-3) times 170 times 10^6
              ) \
            & = #qty[11.65019608][mm] approx #qty[11.65][mm]
    $,
    $
        L_s & = frac(4 T N, D W S_y) \
            & = frac(
                  4 times 74.27 times 3,
                  50 times 10^(-3) times 14 times 10^(-3) times 170 times 10^6
              ) \
            & = #qty[7.489411765][mm] approx #qty[7.49][mm]
    $,
)

$ L_"min" = #qty[11.65][mm] $

== Shaft 4
$ D = #qty[30][mm], quad T = #qty[74.27][Nm] $

From @shaft-key-catalogue:
$ W = 8, quad H = 7 $

#grid(
    columns: 2,
    column-gutter: 2em,
    $
        L_c & = frac(4 T N, D H S_y) \
            & = frac(
                  4 times 74.27 times 3,
                  30 times 10^(-3) times 7 times 10^(-3) times 170 times 10^6
              ) \
            & = #qty[24.96470588][mm] approx #qty[24.96][mm]
    $,
    $
        L_s & = frac(4 T N, D W S_y) \
            & = frac(
                  4 times 74.27 times 3,
                  30 times 10^(-3) times 8 times 10^(-3) times 170 times 10^6
              ) \
            & = #qty[21.84411765][mm] approx #qty[21.84][mm]
    $,
)

$ L_"min" = #qty[21.84][mm] $

== Summary
When selecting the length of the key, we decided to follow the existing
dimensions of the machine elements. As both the belt pulley and the gears
already include a keyway of fixed length, which is the length of the machine
element, the key was designed to match this length to ensure a good fit.

All the machine elements have length exceeding the minimum required key length
($L_"min"$). Thus, the keys are suitable and also provide a larger contact area,
leading to improved load distribution and hence a stronger shaft connection. The
resulting mechanism is therefore more robust and reliable, which is of
importance in high torque like sugar cane crushing.

#table(
    columns: 6,

    table.header(
        [*Shaft number*],
        [*Machine element*],
        [*$L_"min"$ (#unit[mm])*],
        [*Selected length (#unit[mm])*],
        [*Groove width (#unit[mm])*],
        [*Key height (#unit[mm])*],
    ),

    [1], [Belt pulley], [3.94], [32], [6], [6],
    [1], [Gear 1], [3.94], [36], [6], [6],
    [2], [Gear 2], [9.00], [36], [8], [7],
    [2], [Gear 3], [9.00], [43], [8], [7],
    [3], [Gear 4], [11.65], [43], [14], [9],
    [3], [Gear 5], [11.65], [43], [14], [9],
    [4], [Gear 6], [21.84], [43], [8], [7],
)

#pagebreak()

#show: appendix

= Appendix

== Motor catalogue
<motor-catalogue>
#figure(
    image(
        "./pdfs/etec-single-phase-motors-electrical-data.pdf",
        height: PDF-PAGE-HEIGHT,
    ),
    caption: [From @electrotech.],
)

== Belt drive design data
<belt-drive-design-data>
#attach-pdf(
    "../pdfs/appendix-a.pdf",
    start-page: 2,
    end-page: 9,
    page-heading-map: (
        "2": "Table A-1",
        "3": "Table A-2 and A-3",
        "4": "Table A-4, A-5, and A-6",
        "5": "Table A-7a",
        "6": "Table A-7b",
        "7": "Table A-7c",
        "8": "Table A-7d",
        "9": "Table A-8",
    ),
)

== Fenner taper-lock pulley catalogue
<fenner-catalogue>

=== SPZ pulleys
<fenner-spz>
#attach-pdf(
    "./pdfs/fenner-catalogue.pdf",
    reference: ref(<fenner>),
    start-page: 2,
    end-page: 4,
)

=== Bushes
<fenner-bushes>
#figure(
    image("./pdfs/fenner-catalogue.pdf", page: 23, height: PDF-PAGE-HEIGHT),
    caption: [From @fenner.],
)

== Misumi catalogue
<misumi-catalogue>
#attach-pdf(
    "./pdfs/misumi-gears.pdf",
    start-page: 2,
    end-page: 15,
    reference: ref(<misumi>),
    pages-to-skip: (3, 4) + range(10, 17, step: 2),
    page-heading-map: ("2": "Misumi gear overview")
        + (
            "5": "0.5",
            "6": "0.8",
            "7": "1.0",
            "9": "1.5",
            "11": "2.0",
            "13": "2.5",
            "15": "3.0",
        )
            .pairs()
            .map(item => {
                let (page-num, gear-mod) = item
                return (
                    page-num,
                    "Misumi Module "
                        + gear-mod
                        + ", Shaft Bore Configurable Type",
                )
            })
            .to-dict(),
)

== Mechanical properties of 304 stainless steel
<mechanical-properties-of-304-stainless>
#figure(
    image("./images/mechanical-properties-of-304-stainless.png"),
    caption: [From @azo2024.],
)

== Bearing catalogue
<bearing-catalogue>

#for i in range(1, 4) {
    figure(
        image("../images/table-14-3-" + str(i) + ".png"),
        caption: [From @mott2018machine.],
    )
}

== Shaft key catalogue
<shaft-key-catalogue>
#figure(
    image("../images/table-11-1.png"),
    caption: [From @mott2018machine.],
)

#pagebreak()

== Drawings
#figure(image("./images/full-assembly-isometric-view-1.jpg"))
#figure(image("./images/full-assembly-isometric-view-2.jpg"))
#figure(image("./pdfs/full-assembly-1.pdf"))
#figure(image("./pdfs/full-assembly-2.pdf"))
#figure(image("./images/full-assembly-drawing-1.jpg"))
#figure(image("./images/full-assembly-drawing-2.jpg"))

#for i in range(1, 5) {
    figure(image("./pdfs/shaft-" + str(i) + "-drawing.pdf"))
}

#pagebreak()

#bibliography("references.bib")
