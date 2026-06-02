#let heading-numbering = "1.1"
#set page(numbering: "1")
#set heading(numbering: heading-numbering)
#set ref(form: "page")
#show ref: text.with(blue)
#{
    set document(
        title: "MA3001 Machine Element Design Notes",
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
#let labelled_equation(content, label) = math.equation(
    block: true,
    numbering: _ => ("(", str(label), ")").join(""),
    content,
)

// The height for PDF pages
#let PDF-PAGE-HEIGHT = 90%

// Function to attach a full PDF document
//
// The page heading map is a dictionary with the keys
// being the page number, and the value being the heading
#let attach-pdf(
    path,
    start-page: 1,
    end-page: 1,
    page-heading-map: (:),
    pages-to-skip: (),
    heading-level: 3,
    page-height: PDF-PAGE-HEIGHT,
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

        // Add the image with the caption
        content.push(figure(
            image(path, height: page-height, page: page),
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

#show link: it => {
    let destination = it.dest
    let content = it.body
    [#content (#ref(destination))]
}

= Definitions

== Machine
- A machine is a combination of mechanisms and other components that transforms,
    transmits or uses energy, load or motion for a specific purpose.
- A machine, however simple, consists of several individual machine elements or
    components as it is often known, properly designed and arranged to work
    together as a whole.
- Thus, if a machine is completely dismantled, it will be a collection of simple
    parts such as nuts, bolts, springs, gears, shafts, which are the building
    blocks of all machinery.

== Machine elements
A machine element is a single unit designed to perform a specific function and
is *capable of combining with other elements* to form a pair. For example:
- Bolts and nuts
- Keys and shafts.

#cimage("./images/machine-elements.png")
#pagebreak()

=== Standardised machine elements
- Many machine elements are thoroughly standardised. Examples include belts,
    chains, bearings, screws, nuts and bolts.
- Suitable dimensions for common structural and mechanical parts have been
    established via extensive testing and practical experience.
- Standardisation promotes uniformity of practice and hence economies through
    the use of stock parts for *first installations* or *subsequent
    replacements*.

#cimage("./images/standardised-machine-elements.png")

=== Customised machine elements
Not all machine elements in use are standardised.
- Shafts are usually custom-designed and manufactured.
- Keys can be custom-designed and manufactured too.

#cimage("./images/customised-machine-elements.png")
#pagebreak()

== Mechanical drive
A mechanical drive, which is sometimes known as a power transmission, serves the
following functions:
- It receives power from some kind of rotating source, such as an *electric
    motor*, an *internal combustion engine*, a *hydraulic or pneumatic motor*, a
    *steam or water turbine*, or eve *hand rotation provided by the operator*.
- The drive typically causes some change in the speed of rotation of the shafts
    that make up the drive so that the output shaft operates more *slowly or
    quickly* than the input shaft.

Speed reducers are more common than speed increasers.

= Equations

== Power
$ P = T omega $

Where:
- $P$ is the power
- $T$ is the torque
- $omega$ is the angular velocity

= Interfaces between machine elements

#cimage("./images/interfaces-between-machine-elements.png")

== Interface between bearings, shafts and housings

#cimage("./images/interfaces-between-bearings-shafts-and-housings.png")

#enum(
    numbering: "a.",
    [
        Interface between the bearing and shaft:
        - Bearing (inner ring) is fitted on the shaft with interference fit.
        - Bearing is located by the shaft shoulder and prevented from moving
            axially.
    ],
    [
        Interface between bearing and housing:
        - Bearing (outer ring) fitted to housing with interference fit.
        - Retaining ring in the housing keeps the bearing from moving axially.
    ],
)

= Design of power transmission
#cimage("./images/power-transmission-design.png")

In the design of a power transmission, you would typically know:
- The nature of the driven machine.
- The level of power to be transmitted.
- The desired output speed of the transmission.
- The rotational speed of the drive motor or other prime mover.

Designing a proper *power transmission* usually involves the following steps:
+ Selecting a suitable type of machine element form consideration of its
    function.
+ Estimating the size of the machine element that is likely to be satisfactory.
+ Evaluating the machine element's performance against the requirements.
+ Modifying the design and the dimensions until the performance is near to
    whichever factors are considered most important.

- The first two steps require some creative decisions, and for many, represent
    the most difficult part of the design.
- The last two steps in the process can be handled fairly easily by someone who
    is trained in analytical methods and understands the fundamental principles
    of the subject.
- The last step is commonly known as *design iteration*.
- It is generally not possible to achieve a successful result on the first trial
    without making several iterations through this design process.

#pagebreak()

= Belts, chains and gears in general
- The most common machine drives are based on gears, belts, or chains, or a
    combination of these where mechanical power is generally transmitted between
    two shafts by means of these elements.
- Each of these types of mechanical drives has specific features that often
    dictate its selection in a particular situation.
- In many cases, the overlapping of characteristics makes two or more of the
    drives competitive, and the final choice will be based on considerations
    like cost, maintenance, reliability, availability of replacement parts and
    appearance.

== Considerations in design
- How to choose the type of power transmission element to use? Gears, belt
    drives, chain drives, or other types? Some power transmission systems use
    two or more types in series to optimise the performance of each.
- How to select the type and size of belts or chains or gears?
- What speed ratio should be used?
- What is the centre distance between shafts?
- How should rotating elements be arranged, and how should the elements be
    mounted on shafts?

The figure below shows a typical industrial application where belts, gear drives
and chains are each used to their *best advantage*.

#cimage(
    "./images/belts-chains-and-gears-design-considerations.png",
    height: 20em,
)
- Belt drives:
    - High rotational speeds and low torque.
    - Output shaft is correspondingly further from the input shaft.
    - Consider the gear type or chain drive it eh belt speed is less than
        #qty[5][m s^-1].
- Gear drives:
    - Very large ratios of speed reduction and compactness.
    - Output shaft is generally at low speed and high torque.
- Chain drives:
    - Desirable at low-speed, high torque conditions as chains are typically
        metal and are able to withstand high forces.

#pagebreak()

= Belt drive design

== Basic layout of belt drives
- Basic belt drive layout is the parallel shaft arrangement.
- For speed reduction, the small pulley on the high speed shaft is called the
    driving pulley, and the larger pulley on the slower speed shaft is called
    the driven pulley.
- During installation, the belt is placed in a rather high initial tension.
- During transmission, one side is the tight side and the opposite side is the
    slack side.
- Friction is very important in belt drives.

#cimage("./images/belt-drive-basic-layout.png")
#pagebreak()

== Types of belt drives
There are 4 main belt types, namely, flat, round, V, and timing.
#cimage("./images/types-of-belt-drives.png")

- Flat and round belts may be used when there are long centre distances between
    the pulleys in a belt drive.
- V and timing belts are employed for shorter centre distances.
- Excluding timing belts, there is some slip and creep between the belt and
    pulleys, which is usually made of cast iron or formed steel.
- Flat belt drives produce very little noise and absorb more torsional vibration
    from the system than either V-belt or other drives.
- Flat belt drive has an efficiency of around 98%, which is nearly the same as
    for a gear drive.
- V-belt drive can transmit more power than a flat belt drive, however, its
    efficiency varies between 70% and 96%.

== Timing belts
- A timing belt is made of rubberised fabric and steel wire and evenly spaced
    teeth on the inside circumference.
- It is also known as the toothed or synchronous belt, a timing belt does not
    stretch or slip and hence transmit power at a constant angular velocity
    ratio.
- This permits timing belts to be employed for many applications requiring
    precise speed ratio, such as an engine camshaft from the crankshaft in valve
    timing, and robotic applications.

#pagebreak()

== V-belts
Applications of V-belts:
#cimage("./images/power-consumption-of-various-machines.png")

=== Construction
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        - V-belts are usually made with synthetic or steel tensile cords moulded
            and encased in an outer jacket.
        - Cords provide great tensile strength and permit flexing of the belt.
        - Lower rubberised area is capable of withstanding compression.
        - Outer fabric jacket protects the belt from damage from moisture, heat
            and dust.
        - V-shape causes the belt to wedge tightly into the groove, increasing
            friction and allowing high torques to be transmitted before
            slipping.
        - A multiple drive has more than 2 belts on a single sheave.
        - As many as 12 or more V-belts can be used on a single sheave to
            satisfy high power transmission requirements.
    ],
    image("./images/v-belt-construction.png"),
)

=== Standards and sizes
- Different standards
    - Classical profiles (RMA): A, B, C, D, E, F, G and H.
    - 3 narrower profiles replace classical ones: 3V, 5V, and 8V.
- V-belts are only made in certain lengths and have no joints.

#grid(
    columns: 2,
    column-gutter: 5em,
    align: center + horizon,
    table(
        columns: 3,
        table.header([Section], [Width (#unit[mm])], [Height (#unit[mm])]),
        [*SPZ*], [9.7], [8],
        [*SPA*], [12.7], [10],
        [*SPB*], [16.3], [13],
        [*SPC*], [22], [18],
    ),
    image("./images/v-belt-cross-section.png"),
)

=== Belt sheaves with prebored holes
- Sheaves or pulleys are generally made of cast iron, as cast materials have
    good friction and wear characteristics.
- Commercial sheaves are available in standard pitch diameters with either:
    - Stock bore diameters, keyways, tap-holes, i.e. pre-manufactured.
    - Bore diameters custom-machines upon request up to a recommended maximum
        without weakening the hub or pulley. Keyways and tap-holes can also be
        custom-machined.
#cimage("./images/v-belt-sheaves-with-prebored-holes.png")
#pagebreak()

=== Belt sheaves with removable hubs
- For sheaves with removable or detachable hubs, also known as split tapered
    bushing, the hub or bushing comes with standard bore sizes and keyways.
#cimage("./images/v-belt-sheaves-with-removable-hubs.png")

=== Sheave groove
- The groove angle of a sheave is slightly smaller than the 40#sym.degree
    included angle of the V-belt cross-section.
- The sheave groove angle usually varies from 32#sym.degree to 38#sym.degree,
    depending on the belt section size, the sheave diameter and the belt angle
    of contact.
- This slightly smaller sheave groove angle forces the belt to wedge into the
    groove, resulting in increased friction.

#cimage("./images/sheave-groove.png")

== Speed and direction of rotation
The direction of rotation for the *driver* sprocket is the *same* direction as
the input torque, but for the *driven* sprocket, the output or resisting torque
is *opposite* to the direction of rotation.

=== Speed ratio (SR)
$
    "Speed ratio (SR)" =
    frac("Input speed (or driver)", "Output speed (or driven)")
$

$ "SR" = eta_1/eta_2 = omega_1/omega_2 = R_2/R_1 = D_2/D_1 $

Where:
- $eta$ is the frequency of the motor in #unit[rpm]
- $omega$ is the angular velocity of the motor
- $R$ is the radius of the pulley
- $D$ is the diameter of the pulley

The *driver* can be the *smaller pulley for speed step-down* or the *bigger
pulley for speed step-up*.

=== Belt speed ($v_b$)
#cimage("./images/belt-drive-speed-and-direction-of-rotation.png")

$
    v_b & = R_1 omega_1 = R_2 omega_2 \
        & = R_1 eta_1 R_2 eta_2
$

Where:
- $R$ is the radius of the pulley
- $omega$ is the angular velocity of the motor
- $eta$ is the frequency of the motor in #unit[rpm]

#pagebreak()

=== Belt drive angle ($alpha$)
$alpha$ is the angle between the drive centre line and a straight section of the
belt:

$ alpha = arcsin (frac(D_2 - D_1, 2C)) $

#cimage("./images/belt-drive-angle.png", height: 15em)

== Belt pitch length ($L$)
$ L = 2 "arcs" + 2 "straight tangent over pitch circles" $
$ L = 2C + 1.57 (D_2 + D_1) + frac((D_2 - D_1)^2, 4C) quad (#unit[m]) $

#cimage("./images/belt-pitch-length.png", height: 15em)

#pagebreak()

== Centre distance ($C$)
$ C = frac(B + sqrt(B^2 - 32(D_2 - D_1)^2), 16) quad (#unit[m]) $

Where $B = 4L - 6.28 (D_2 + D_1)$.

#cimage("./images/belt-drive-centre-distance-and-angle.png", height: 15em)

== Angle of contact or wrap ($theta_1$)
The angle of contact is always on the small pulley.

$ theta_1 = 180 degree - 2 arcsin (frac(D_2 - D_1, 2C)) $

#cimage("./images/belt-drive-centre-distance-and-angle.png", height: 15em)

- When the drive or speed ratio is *1.0*, or when there is no speed change,
    $theta_1 = 180 degree$.
- Belts are rated with an angle of 180#sym.degree, which is when the driving and
    driven pulleys are of the same size.
- $theta_1 > 120 degree$ to prevent slippage due to decreased frictional
    contact.

#pagebreak()

== Length of span between sheaves ($L_s$)
#cimage("./images/belt-drive-length-of-span-between-sheaves.png", height: 15em)
- This length determines the tendency of the belt to vibrate or whip.
- Proper belt tension can be checked by measuring the force required to deflect
    the belt at the mid-span by a given amount. Most catalogues will describe
    this method.

Belt initial tensioning method:
- Belt cross-section, like SPB.
- Span length, $L_s$.
- Look up the catalogue for force $P$ and the corresponding deflection $delta$
    to apply initial tension on the belt.

#cimage("./images/belt-drive-belt-initial-tensioning-method.png")
#pagebreak()

== Guidelines for the design of belt drives
+ Belt speed, $v_b$ (#unit[m s^-1])
    - For cast iron sheaves, *belt speed should not exceed #qty[33][m s^-1]*,
        because for higher belt speeds, special dynamically balanced sheaves are
        required.
    - If the speed is less than #qty[5][m s^-1], consider gear, chain drives or
        other drives.
+ Maximum speed ratio of 3.0 to avoid slippage.
    $ eta_1/eta_2 = omega_1/omega_2 = D_2/D_1 = 3.0 $

    Note that if a higher speed ratio is required, a multi-stage reduction drive
    should be used.
+ Angle of contact on smaller pulley
    - $theta_1$ should not be less than 120#sym.degree to avoid slippage.
        $ theta_1 = 180 degree - 2 arcsin (frac(D_2 - D_1, 2C)) $
+ Centre distance
    - If an approximate centre distance is not known, use recommended centre
        distance $D_2 < C < 3(D_2 + D_1)$.
    - Why $D_2 < C < 3(D_2 + D_1)$?
        - If $C < D_2$, then $theta_1$ may be less than 120#sym.degree, risking
            risk of belt slippage.
        - If $C > 3(D_2 + D_1)$, the span of belt will be very long and result
            in the belt whipping.

== Selection of belts and sheaves
- Select minimum belt cross-section.
- Select standard driving and driven pulley sizes.
- Specify belt pitch length.
- Determine the number of belts required:
    $ "Number of belts" = frac("Design power", "Corrected rated power") $
- Design power (DP) is used to select the minimum belt cross-section.
    $ "DP" = "service factor" times "power required by driven machine" $
- Rated power is the power that can be transmitted by a belt as given in the
    manufacturer's power rating table. It depends on the small pulley's
    #unit[rpm], small pulley diameter, and speed ratio.
- Corrected rated power:
    $ "Corrected rated power" = C_theta C_L times "Rated power" $

#pagebreak()

=== Design power
Design power is used for selecting the minimum belt cross-section.

$ "Design power" = "service factor" times "actual drive power" (#unit[kW]) $

- Select the service factor from *Table A-2*.
- Actual drive power is the actual power requirement of the driven machine.

#cimage("./images/table-a2-service-factors.png")

==== Example
- The driven machine requires #qty[5.0][kW].
- Service factor is 1.3.
- Design power:
    $ "Design power" = 1.3 times 5.0 = #qty[6.5][kW] $
- The design power of #qty[6.5][kW] is used to select the minimum belt
    cross-section.
- Note that the actual power transferred to the driven machine is still
    #qty[5.0][kW].

#pagebreak()

=== Selecting the minimum V-belt cross-section
The *speed of the faster shaft* and the design power determine the minimum
cross-section using the Cross-Section Selection Chart of Table A-3.

#cimage("./images/table-a3-choice-of-cross-section.png")

=== Corrected rated power
The actual configuration of the belt drive can be different from that used by
the manufacturer to test the belt for its rated power. The manufacturer used the
same diameter for the driving and driven pulleys, and a certain belt length.

#cimage("./images/belt-drive-corrected-rated-power.png", height: 20em)

Hence, there is a need to correct the *rated power of the belt* given by the
manufacturer when it used in the actual configuration.
$ "Corrected rated power" = C_theta C_L times "Rated power" $

Rated power is the power that can be transmitted by a belt as given in the
manufacturer's power rating table.

=== Example 1
<belt-drive-example-1>
Design a V-belt drive to transmit #qty[50][kW]. Driver sheave speed is
#qty[950][rpm] and driven sheave speed is 410-430 #unit[rpm]. Power will be
supplied by an AC normal torque motor, and the driven unit is a #qty[50][kW] fan
which will be operated about 12 hours per day. The centre distance is
approximately #qty[1400][mm].

#cimage("./images/belt-drive-example-1.png")

==== Step 1: Determine the design power
The design power is *service factor* #sym.times *drive power* in #unit[kW], both
of which can be found in Table A-2.

For a normal motor torque and a #qty[50][kW] fan, operating for 12 hours a day:
#cimage("./images/belt-drive-example-1-table-a2.png")

- The safety factor is 1.2
- The design power is:
    $ "Design power" = 1.2 times 50 = 60 #unit[kW] $

==== Step 2: Selecting the proper V-belt cross-section
From Table A-3, the design power of #qty[60][kW] and #qty[950][rpm] of the
faster shaft gives the *SPB* belt cross-section.

#cimage("./images/belt-drive-example-1-table-a3.png")

==== Step 3: Select the sheave diameters
+ Select a sheave diameter to start.
    - Since nothing limits the sheave diameter, start with a sheave diameter
        that gives an ideal belt speed, which is $v_b = #qty[20][m s^-1]$ for
        ideal operation, as there is less stress and vibration.
    - Any other speed between #qty[5][m s^-1] and #qty[33][m s^-1] is fine too.

    $ v_b = r_1 omega_1 = frac(D_1 omega_1, 2) $
    $
        D_1 & = frac(2v_b, omega_1) = frac(2v_b, (2 pi eta_1)/60) \
            & = frac(2(20), 2 pi times 950/60) = #qty[0.402][m]
    $

    From Table A-4 for SPB belt, select the closest standard diameter.
    #cimage("./images/belt-drive-example-1-table-a4-sheave-1.png")

    Select $D_1 = #qty[0.400][m]$.

    #v(10em)

+ Check the belt speed:
    $ v_b = r_1 omega_1 = 0.200 times 2 pi times 950/60 = #qty[19.9][m s^-1] $

    Since $#qty[5][m s^-1] < v_b < #qty[33][m s^-1]$, it is fine for the
    standard diameter of $D_1$ to be #qty[0.400][m].

+ Find the other diameter sheave using the speed ratio:
    $ "SR" = eta_1/eta_2 = D_2/D_1 $
    - Driven speed is #qty[410][rpm] to #qty[430][rpm].
    - Use the average or nominal driven speed for $eta_2$.
        $ eta_2 = frac(410 + 430, 2) = #qty[420][rpm] $
    - The speed ratio:
        $ "SR" = eta_1/eta_2 = 950/420 = 2.262 $
    - Hence the other sheave diameter:
        $ D_2 = D_1 (eta_1/eta_2) = 0.400 times 2.262 = #qty[0.905][m] $
    - Find the closest standard diameter from Table A-4:
        #cimage("./images/belt-drive-example-1-table-a4-sheave-2.png")

        Select $D_2 = #qty[0.900][m]$.

+ Check if $eta_2$ is within #qty[410][rpm] - #qty[430][rpm].
    $
        eta_2 & = frac(D_1 eta_1, D_2) \
              & = (0.4 times 950)/0.9 = #qty[422][rpm]
    $

    #qty[422][rpm] is within the speed range, hence it is fine.

    The actual speed ratio is:
    $ "SR" = eta_1/eta_2 = 0.9/0.4 = 2.25 $

    Note that the belt power rating also depends on the speed ratio and goes up
    to 3.0.

==== Step 4: Select the centre distance and belt pitch length
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        + The *tentative centre distance* (TCD) is given as #qty[1.4][m].
        + Find the *tentative belt length* (TBL).
            $
                "TBL" = 2 times "TCD" + 1.57(D_2 + D_1) +
                frac((D_2 - D_1)^2, 4 times "TCD")
            $

            $
                "TBL" & = 2 times 1.4 + 1.57(0.9 + 0.4) +
                        frac((0.9 - 0.4)^2, 4 times 1.4) \
                      & = #qty[4.885][m]
            $

        + From Table A-1, select a standard belt length, $L$, closest to the
            TBL.

            Either $L = #qty[4750][mm]$ or #qty[5000][mm], as the centre
            distance is to be approximately #qty[1400][mm].

            Select $L = #qty[5000][mm]$ for convenience, but #qty[4750][mm] is
            fine too.

        + Calculate the actual centre distance.
            $ C = frac(B + sqrt(B^2 - 32(D_2 - D_1)^2), 16) quad #unit[m] $

            Where $B = 4L - 6.28 (D_2 + D_1)$.

            Hence $C = #qty[1.458][m]$.
    ],
    figure(
        caption: "Table A-1",
        image("./images/belt-drive-example-1-table-a1.png"),
    ),
)

The actual configuration of the belt drive is now developed.

#cimage("./images/belt-drive-example-1-complete-belt-drive.png")

Hence, we can determine the corrected rated power of the belt when it is used in
the actual configuration.

$ "Corrected rated power" = C_theta C_L times "Rated power" $

==== Step 5: Determine the power correction factor ($C_theta$, $C_L$)
+ Find the angle of contact on the smaller sheave:
    $ theta_1 = 180 degree - 2 arcsin (frac(D_2 - D_1, 2 C)) $
    $
        theta_1 = 180 degree - 2 arcsin (frac(0.9 - 0.4, 2(1.458)))
        = 160.2 degree
    $
    - Find the Contact Correction Factor ($C_theta$) from Table A-5 by
        interpolating between the values.

        #cimage("./images/belt-drive-example-1-table-a5.png")

        $ C_theta approx 0.95 $

+ From Table A-6 for the selected belt cross-section SPB:
    #cimage("./images/belt-drive-example-1-table-a6.png")

    $ "Belt Length Correction Factor," C_L = 1.06 $

#pagebreak()

==== Step 6: Determine the rated power (RP)
From Table A-7c, for $D_1 = #qty[400][mm]$, #qty[950][rpm] and the speed ratio
of 2.25.

#cimage("./images/belt-drive-example-1-table-a7c-1.png")

Interpolating between speed ratios of 1.5 and 3.0:

#cimage("./images/belt-drive-example-1-table-a7c-2.png", height: 15em)

$
    "RP" = frac(2.25 - 1.5, 3.0 - 1.5) (23.21 - 23.07) + 23.07
    = #qty[23.14][kW belt^-1]
$

==== Step 7: Determine the corrected rated power (CRP)
$
    "CRP" & = C_theta C_L times "RP" \
          & = 0.95 times 1.06 times 23.14 \
          & = #qty[23.3][kW belt^-1]
$

==== Step 8: Find the number of belts
$
    "Number of belts" = frac("Design power", "Corrected rated power")
    = 60/23.30 = 2.58
$

- Use the always round up the number of belts, which is 3 belts in this case.
- Suggested configuration is 3SPB belts, $L = #qty[5000][mm]$,
    $D_1 = #qty[400][mm]$, $D_2 = #qty[900][mm]$.
- The 3 belts can transmit a maximum total power of $3(23.3) = #qty[69.9][kW]$,
    which is more than the #qty[50][kW] which the fan requires.

=== Summary of steps
+ Select the *minimum belt cross-section* based on the design power, which is
    service factor #sym.times the actual power required by the driven machine
    (#unit[kW]).
+ *Standard driving and driven pulley sizes*.
    - Fine for belt speed between #qty[5][m s^-1] and #qty[33][m s^-1].
    - Below #qty[5][m s^-1], belt tension is too high.
    - Above #qty[33][m s^-1], need to balance pulleys if cast iron sheaves are
        used.
    - Maximum speed ratio is $D_2/D_2 = 3.0$ to avoid slippage.
    - *Check* if the two standard diameters, $D_1$ and $D_2$ combination gives
        the *required speed ratio or driven speed*.
+ *Belt length*, which is dependent on the centre distance.
    - If an approximate centre distance is not known, use the recommended centre
        distance of $D_2 < C < 3(D_2 + D_1)$.
+ *Number of belts* required:
    $ "Number of belts" = frac("Design power", "Corrected rated power") $
    - Design power is used to select the minimum belt cross-section.
    - $"Corrected rated power" = C_theta C_L times "Rated power"$
    - Rated power is the power that can be transmitted by a belt as given in the
        manufacturer's catalogue for:
        - Speed of smaller sheaves (interpolate speed if needed).
        - Smaller standard pulley pitch diameter.
        - Speed ratio $D_2/D_1$ (interpolate if needed). The maximum ratio
            should be 3.0.

== Forces on pulleys (sheaves) and belts
#cimage(
    "./images/belt-drive-torques-on-driver-shaft-and-pulley.png",
    height: 20em,
)

A rule of thumb is that the torque of the *driving* pulley is the *same
direction* as the *rotation* of the pulley.

#pagebreak()

== Forces on the driver pulley and belt tensions
#cimage(
    "./images/belt-drive-forces-on-driver-pulley-and-belt-tensions-1.png",
    height: 15em,
)

- Let $F_1$ be tight tension and $F_2$ be slack tension.
- Torque $(F_1 - F_2) D_1/2$ created by the tensions must be in equilibrium with
    $T_1$, i.e.
    $ sum T = 0, quad (F_1 - F_2) D_1/2 = T_1 $
- Since $T_1$ is clockwise, then the torque by the tensions must be in the
    opposite direction to $T_1$, or anti-clockwise.
- Therefore, $F_1$ must be as shown below:
    #cimage(
        "./images/belt-drive-forces-on-driver-pulley-and-belt-tensions-2.png",
        height: 15em,
    )
- Free body diagram of driving pulley:
    #cimage(
        "./images/belt-drive-forces-on-driver-pulley-and-belt-tensions-3.png",
        height: 15em,
    )

== Forces on the driven pulley
#grid(
    columns: 2,
    image("./images/belt-drive-forces-on-driven-pulley-1.png"),
    image("./images/belt-drive-forces-on-driven-pulley-2.png"),
)
- For equilibrium, the torque $T_2$ at the centre of the pulley must be in the
    anti-clockwise direction, and $T_2$ is:
    $ T_2 = (F_1 - F_2) D_2/2 $
- On the *driven* pulley, the direction of torque is *opposite* to the direction
    of *rotation*.
#cimage("./images/belt-drive-forces-on-driven-pulley-3.png", height: 15em)

Free body diagram of the driven pulley:
#cimage("./images/belt-drive-forces-on-driven-pulley-4.png", height: 15em)

== Free body diagrams of the driving and driven pulleys
#cimage("./images/belt-drive-free-body-diagrams-of-the-pulleys.png")

For equilibrium:
+ $ sum T = 0, quad T_1 = (F_1 - F_2) D_1/2, quad T_2 = (F_1 - F_2) D_2/2 $
+ $sum F_x = 0$, which gives $R_x$ at the centre of the pulley.
+ $sum F_y = 0$, which gives $R_y$ at the centre of the pulley.
+ Resultant $R$ at the centre of the pulley:
    $ sqrt(R_x^2 + R_y^2) $

#pagebreak()

== Rules of thumb
#grid(
    columns: 2,
    column-gutter: 3em,
    row-gutter: 1em,
    align: horizon,
    [
        For the *driver* pulley, driving torque $T_1$ is in the *same* direction
        of *rotation* of the *driver* pulley $eta_1$.
    ],
    image("./images/belt-drive-rules-of-thumb-1.png", height: 10em),

    [
        For the driven pulley, driving torque $T_2$ is in the *opposite*
        direction of rotation of the *driven* pulley $eta_2$.
    ],
    image("./images/belt-drive-rules-of-thumb-2.png", height: 10em),

    [
        The tight side tension, $F_1$, gives the direction of $eta_2$ rotation
        to the *driven* pulley.
    ],
    image("./images/belt-drive-rules-of-thumb-3.png", height: 10em),
)

#pagebreak()

== Power, torque and belt tensions
#cimage("./images/belt-drive-power-torque-belt-tensions.png")
- For no power loss, transmitted power is:
    $ P = T_1 omega_1 = T_2 omega_2 $
- Torque:
    $ T_1 = (F_1 - F_2) D_1/2 $
    $ T_2 = (F_1 - F_2) D_2/2 $

Where:
- $P$ is the power (#unit[W])
- $omega$ is the shaft angular velocity (#unit[rad s^-1]),
    $omega = (2 pi eta)/ 60$, where $eta$ is in #unit[rpm]
- $T_1, T_2$ is the torque on sheave 1 and 2 respectively (#unit[Nm])
- $D_1, D_2$ is the pitch diameter of sheave 1 and 2 respectively (#unit[m])
- $F_1$ is the tension on the tight side (#unit[N])
- $F_2$ is the tension on the slack side (#unit[N])

=== Belt tension relationship
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Allowing for centrifugal force due to the inertia of the belt, the belt
        tension ratio can be obtained from:
        $
            frac(F_1 - F_c, F_2 - F_c) = e^(frac(theta_1 f, sin beta))
            wide F_c = m v_b^2
        $

        Where:
        - $F_c$ is the centrifugal force (#unit[N])
        - $m$ is the belt mass per unit length (#unit[kg m^-1])
        - $v_b$ is the belt velocity (#unit[m s^-1])
        - $f$ is coefficient of friction of the belt on the sheave
        - $theta_1$ is the angle of contact on the smaller sheave (#unit[rad])
        - $beta$ is half of the included angle of the sheave groove (#unit[deg])
        - $f/(sin beta) = f_e$ is the effective coefficient of friction.

        Note that a flat belt is actually a special case of a V-belt with a
        groove angle of 180#sym.degree.
    ],
    image("./images/belt-drive-belt-tension-relationship.png"),
)

Combining the torque and belt tension equation gives:
$
    T= (F_1 - F_2) D_1/2,
    quad frac(F_1 - F_c, F_2 - F_c) = e^(frac(theta_1 f, sin beta))
$

$ therefore F_1 = F_c + 2(frac(gamma, gamma - 1)) T_1/D_1 $

Where $gamma = e^(frac(theta_1 f, sin beta)) = e^(theta_1 f_e)$

#pagebreak()

== Shaft loads
#cimage("./images/belt-drive-shaft-loads.png")

Actual force analysis:
$ sum F_x = 0, quad F_x = (F_1 + F_2) cos alpha $
$ sum F_y = 0, quad F_y = (F_1 + F_2) sin alpha $

=== Assumption of parallel tensions
For typical belt configurations in practice, the angle $alpha$ is small, so that
the tight and slack tensions $F_1$ and $F_2$ may be assumed as parallel.

Parallel force analysis:
$ sum F_x = 0, quad F_x = (F_1 + F_2) $
$ sum F_y = 0, quad F_y = 0 $

#pagebreak()

==== Example

For $alpha = 10 degree$, which is small for a typical belt drive arrangement.

Actual force analysis:
#cimage("./images/belt-drive-parallel-tensions-actual.png", height: 20em)

$ sum F_x = 0, quad F_x = (F_1 + F_2) cos 10 degree = 0.985 (F_1 + F_2) $
$ sum F_y = 0, quad F_y (F_1 + F_2) sin 10 degree = 0.173 (F_1 - F_2) approx 0 $
$ therefore F_"actual" = sqrt((F_1^2 + F_2^2)) approx 0.985 (F_1 + F_2) $

For assumed parallel tensions:
#cimage("./images/belt-drive-parallel-tensions-assumption.png", height: 15em)

$ F_y = 0 $
$ F_"parallel" = F_x = 1.0 (F_1 + F_2) $

Since $F_"parallel" > F_"actual"$, the stress on the shaft will be higher, so
the size will be larger. Hence, the assumption is conservative and is safe to
use.

#pagebreak()

=== Example
Determine the shaft load for the belt drive from #link(
    <belt-drive-example-1>,
)[example 1].

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Steps:
        + Assume tension forces are parallel unless otherwise stated.
        + Determine $F_1$ and $F_2$.
        + Determine shaft load $F_x$ and $F_y$ (same as $F_x$ and $F_y$) at the
            sheave centre but opposite in direction.

            $ "Shaft load" = F_x = F_1 + F_2 $
    ],
    image("./images/belt-drive-driving-sheave-forces.png"),
)



$F_1$ and $F_2$ can be found from the equations below:

For one belt:
$ "Torque," T_1 = (F_1 - F_2) D_1/2 $
$ frac(F_1 - F_c, F_2 - F_c) = e^(frac(theta_1 f, sin beta)) $
$ F_c = m v_b^2 $

$ F_1 = F_c + 2 (frac(gamma, gamma - 1)) T_1/D_1 $

Where $gamma = e^(frac(theta_1 f, sin beta))$.

Previously, $v_b = #qty[19.9][m s^-1]$, and from Table A-1:
#cimage("./images/belt-drive-example-2-table-a1.png")

$ m = #qty[0.194][kg m^-1] $

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        - From Table A-8, SPB for $D_m = D_1 = #qty[400][mm]$ which is greater
            than #qty[190][mm].
        - Hence, the groove is $2 beta = 38 degree$.
        - For $2 beta = 38 degree$, the effective coefficient of friction:
            $ f/(sin beta) = f_e = 0.40 $
    ],
    image("./images/belt-drive-example-2-table-a8.png"),
)

#cimage(
    "./images/belt-drive-example-2-effective-coefficient-of-friction-table.png",
)

Actual transmitted power:
$ P = #qty[50][kW] $
$ eta_1 = #qty[950][rpm] $
$
    T_(("3 belts")) = P/omega_1 & = frac(50 times 10^3, (2 pi eta_1)/60) \
                                & = #qty[502.6][Nm]
$

For one belt:
$ T_1 = 502.6/3 #unit[Nm] $
$ F_c = m v_b^2 $
$ F_c = 0.194 times 19.9^2 = #qty[76.8][N] $
$ theta_1 = frac(pi, 180 degree) times 160.2 degree = #qty[2.796][rad] $
$ gamma = e^(frac(theta_1 f, sin beta)) = e^(2.796 times 0.4) = 3.06 $
$
    F_1 = F_c + 2 (frac(gamma, gamma - 1)) T_1/D_1
    = 76.8 + 2(3.06/(3.06 - 1)) frac(502.6, 3(0.400)) = #qty[1321][N]
$

$
    therefore F_2 = F_1 - 2 (T_1/D_1)
    = 1321 - 2(frac(502.6, 3(0.400))) = #qty[483.4][N]
$

For 3 belts:
$
    therefore "Shaft load" & = 3 (F_1 + F_2) \
                           & = 3 (1321 + 483.4) \
                           & = #qty[5413.2][N]
$

= Chain drives
#cimage("./images/basic-layout-of-a-chain-drive.png")
- One side of the strand is always slack with zero tension and power is
    transmitted solely by the tight side tension, which explains why chain
    drives generate a smaller shaft load than belt drives.
- Chain drives require smaller and less costly bearings and shaft.
- Chain drives are thus more compact, powerful and efficient than belt drives.
- Besides power transmission, chains are also used to
    - Convey materials
    - Raising and lowering loads on a forklift.

== Applications
- Chain drives are used as devices for synchronisation of movements such as
    valve timing in engines.
- A timing belt, which is made of rubber, is susceptible to breakage and should
    be replaced timely to avoid damage to the engine valves and pistons.
- Timing chain does not break easily and would be preferred to prevent such
    damage.

#cimage("./images/chain-drive-applications.png")

== Basic features of a roller chain
- A roller chain is the most widely used type in which the roller on each pin
    provides extremely low friction between the chain and the sprockets.
- Of its diverse applications, the most familiar is the roller chain drive on a
    bicycle.
- Chains are endless, which is a major advantage over V-belts and gears.
- One link is always detachable, so that the chain can be mounted and dismounted
    at will.

#cimage("./images/basic-features-of-a-roller-chain.jpg", height: 25em)

== Even and odd number of links or pitches
- Since each roller link requires a pin link for assembly, a chain normally has
    an even number of links.
    #cimage("./images/even-number-of-pitches.png")
- If an odd number of links is required, it is necessary to use an offset link.
- Offset links wear faster than straight links and should be avoided whenever
    possible.
    #cimage("./images/odd-number-of-pitches-offset-link.png")

#pagebreak()

== Roller chain
- A roller chain is generally made of hardened steel and has sprockets made of
    steel of cast iron.
- Roller chains have a high efficiency of 97% to 99% and can be used for heavy
    loads at speeds up to #qty[20][m s^-1].
- All chains are classified according to the *pitch*.

#cimage("./images/roller-chain-pitch.png")

#pagebreak()

=== Classification
- The dimensions of standard sizes for a single strand chain specified by the
    *American National Standards Institute (ANSI)* is shown in Table 1.

#cimage("./images/roller-chain-classification.png")

== Multi-strand roller chains
- Multi-strand such as double, triple and quadruple-strand roller chains and
    sprockets are also stocked in most standard sizes according to size by the
    American National Standards Institute (ANSI).
- Multi-strand roller chain consists of two or more parallel strands of chain
    assembled on common pins.
- The figure below shows a chain drive with double strands. In some cases, up to
    10-strand chain is available.

#cimage("./images/roller-chain-multi-strand.png")

== Failure modes of roller chains
- Roller chains seldom fail because they lack tensile strength.
- They more often fail because they have been subjected to a great many hours of
    service.
- Actual failure may be due to either the *wear of rollers* on the pins or
    fatigue of the surface of the rollers.
    #cimage("./images/roller-chain-anatomy.png")
- At lower speeds, the power capacity of roller chain systems is determined by
    the *fatigue life* of the link plates.
- At higher speeds, the power capacity is determined by the roller *bushing
    fatigue* life.
- At very high speeds, the lifespan is determined by galling, or when a
    localised cold weld on the bearing surface between a roller and its bushing
    roughens when the weld is broken.

== Chain drive sprockets
- Roller chain drive are driven by sprockets, which are toothed wheels machined
    to fit the chain rollers.
- Proportions of sprockets are standardised and are available in manufacturer's
    catalogues.
- The roller chain and sprocket *must* have the *same ANSI number*.
- Single strand chains only work with single strand sprockets, double strand
    chains only work with double strand sprockets, and so on.
- Sprockets are generally made from cast iron and cast steel.

=== Types of sprockets
#cimage("./images/types-of-sprockets.png")
- Type A has no hub.
- Type B has a hub on one side.
- Type C has a hub on both sides.
- Type D has a detachable hub.

== Chain drive geometry
#cimage("./images/chain-drive-geometry.png")
Pitch diameter of a sprocket:
$ D_1 = frac(p, sin(frac(180 degree, N_1))) #unit[mm] $
$ D_2 = frac(p, sin(frac(180 degree, N_2))) #unit[mm] $

Where $p$ is the pitch in #unit[mm].

== Chain length
#cimage("./images/chain-length.png")
$ "Chain length" = 2 "arcs" + 2 "straight tangents over pitch circles" $
$ L = 2C + frac(N_2 + N_1, 2) + frac((N_2 - N_1)^2, 4 pi^2 C) "in pitches" $

Where:
- $N_1$ is the number of teeth in the driver sprocket.
- $N_2$ is the number of teeth in the driven sprocket.

== Centre distance and angle of contact
#cimage("./images/chain-drive-centre-distance-and-angle-of-contact.png")
- #text(red)[Centre distance, in pitches]
    $
        C = 1/4 {
            L - frac(N_2 + N_1, 2) +
            sqrt([L - frac(N_2 + N_1, 2)]^2 - frac(8(N_2 - N_1)^2, 4 pi^2))
        } "pitches"
    $
- #text(rgb("#0000c7"))[Angle of contact on smaller sheave]
    $ theta_1 = 180 degree - 2 arcsin [frac(D_2 - D_1, 2C)] $

== Speed and direction of rotation
Speed ratio:
$ "SR" = "Input speed"/"Output speed" = eta_2/eta_1 = N_2/N_1 $

The *driver* can be the *smaller* sprocket for speed *step-down* or the *bigger*
sprocket for speed *step-up*.

- Direction of rotation is the same direction.
- Chain velocity:
    $ V = r omega #unit[m s^-1] $

#pagebreak()

== Chain lubrication
- The recommended type shown in the power rating tables in influenced by chain
    speed and the amount of power transmitted.
- Proper lubrication of roller chains is highly important to their design
    performance.
- With proper lubrication and proper alignment, a sprocket and roller chain
    system should be capable of 15,000 hours of service at full load.
- Usually a medium or light mineral oil is used as the lubricant. Heavy oils and
    greases are not recommended because they are too viscous to enter the small
    clearances in the chain parts.
- The 3 basic types of lubrication for chain drives are:
    - Manual or drip lubrication
    - Bath or disc lubrication
    - Oil stream lubrication

=== Type A: Manual or drip lubrication
- For manual lubrication, oil is applied with a brush or spout at least once
    every 8 hours of operation.
- For drip lubrication, oil is fed directly onto the link plate edges. It is
    generally used for low rpm applications.

#cimage("./images/chain-drive-lubrication-type-a.png")
#pagebreak()

=== Type B: Bath of disc lubrication
- For bath lubrication, the lowest portion of the chain pitch line is immersed
    in an oil sump in the chain housing.
- For disc lubrication, the chain operates above the oil level. The disc picks
    up oil from the sump and deposits it onto the chain by means of a collector
    plate and a trough or gutter. This type of lubrication is often found on
    chain drives operating at intermediate speed or lower.

#cimage("./images/chain-drive-lubrication-type-b.png")

=== Type C: Oil stream lubrication
- The lubricant is usually supplied by a circulating pump capable of delivering
    a continuous stream of oil.
- The oil should be directed at the slack strand and applied inside the chain
    loop and evenly across the chain width.

#cimage("./images/chain-drive-lubrication-type-c.png", width: 60%)

== Guidelines for power transmission (greater than #qty[100][rpm])
- For smooth operation, it is considered good practice to use a sprocket with at
    least 17 teeth.
- When space limitations are severe, smaller tooth numbers (fewer than 17), may
    be used by sacrificing the life expectancy of the chain, which is quite
    often encountered in real applications.
    - However, care must be taken to prevent the chain from lifting off and
        jumping out of the sprocket teeth due to chordal acceleration at high
        chain speed.
    - Using an idler sprocket can prevent this.
- The optimum range for centre distance is between 30 and 50 chain pitches.
    However, centre distance greater than 50 pitches are often used but 80
    pitches and over are not recommended.
- The speed ratio should be about 7:1. If a higher speed ratio is required, a
    multi-stage reduction drive should be proposed.
- The calculated chain length should be rounded off to a whole number,
    preferably an even one to avoid specification of a weaker offset link.
- It is recommended that no more than 4 strands be used because of the loads
    placed on the shaft and the corresponding reduction in the load rating of
    additional strands.

== Multi-strand factor for power
- For power transmission, the chain is selected by the power rating provided by
    the manufacturer.
- Power ratings *do not* increase *proportionately*.
- The power ratings of a multi-strand roller chain is obtained by multiplying
    the power rating of a single-strand chain by the multiple strand factors
    which is given in Table 2.
- These factors are not a direct multiple of the number of strands because of
    non-uniform loading among the parallel strands.

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        For power transmission, one strand can transmit #qty[1.0][kW].

        Two strands can only transmit:
        $ 1.7 times 1.0 = #qty[1.7][kW] $

        Three strands can only transmit:
        $ 2.5 times 1.0 = #qty[2.5][kW] $
    ],
    image("./images/chain-drive-table-2.png"),
)

== Design data
- Most roller chain manufacturers provide data tables to aid the engineer in
    choosing the roller chains and determining their power capacity.
- Power ratings are given for *one strand* and are based on:
    - Very smooth driving conditions (service factor of 1)
    - A chain length of 100 pitches
    - Use of recommended lubrication
    - A two-sprocket drive and sprockets aligned in the same plane, mounted on
        parallel horizontal shafts
    - A service life of about 15,000 hours
- These power ratings relate to the speed of the smaller sprocket and drive
    selections made on this basis, whether the drive is speed reducing or speed
    increasing.
- Ratings for intermediate numbers of sprocket teeth or speed (#unit[rpm]) are
    obtained by interpolation.

== Selection of chains and sprockets
- Select the *smallest* roller chain using:
    $
        "Design power per strand" =
        frac(
            "Power to be transmitted" times "Service factor",
            "Multiple strand factor"
        ) quad (#unit[kW])
    $
- To select a chain, the rated power per strand must be *greater than or equal
    to* the design power per strand, i.e.
    $ "Rated power per strand" >= "Design power per strand" $
- Rated power per strand is the power that can be transmitted by a chain, which
    is given in the manufacturer's power rating table for:
    - Small sprocket speed (interpolate speed if necessary)
    - Small sprocket teeth
- Select standard driving and driven sprocket sizes (number of teeth) to satisfy
    speed and size requirements.
    - For tutorials and examinations, The choice of the number of teeth in the
        larger sprocket is not restricted to Table B-4 of appendix B.
- Specify chain pitch length.

#cimage("./images/chain-drive-table-b4-appendix-b.png")
#pagebreak()

== Design for power transmission example
Design a chain drive for an agitator to be driven by an electric motor. The
input speed is #qty[900][rpm], and the desired speed is *#qty[245][rpm] to
#qty[255][rpm]*. The agitator requires #qty[11][kW], and the distance between
the driving and driven shafts is limited to *approximately #qty[760][mm]*. The
pitch diameter of the sprockets should not *exceed #qty[400][mm]*.

#cimage("./images/chain-drive-design-for-power-transmission-example.png")

=== Step 1: Determine the design power
+ $
        "Design power per strand" = frac(
            "Power to be transmitted" times "Service factor",
            "Multiple strand factor"
        ) quad (#unit[kW])
    $
+ From Table B-2, service factor (motor and agitator) is *1.0*.
+ Choosing a single strand, multiple strand factor is *1.0*.
+ $ "Design power per strand" = frac(11.0 times 1.0, 1.0) = #qty[11.0][kW] $

#cimage("./images/chain-drive-table-b2.png")

=== Step 2: Select the chain size
+ Using the RPM of the smaller sprocket, #qty[900][rpm] and the design power of
    #qty[11.0][kW], look for matching power ratings, which are given by the
    manufacturer, in Table B-4, Appendix B, that is equal to or greater than
    #qty[11.0][kW]. Starting from the *smallest available chain* (No. 25 in this
    case), the idea is to select as small a chain as possible.

    #cimage("./images/chain-drive-table-b4-appendix-b-no-40.png")
    $
        "Look for manufacturer's power rating" >=
        ("Design power" = #qty[11.0][kW])
    $

+ A match is found for *No. 40 roller chain* with $N_1 = 40$ teeth, which has a
    rating of #qty[11.2][kW].
    - The pitch for No. 40 from Table B-1 is #qty[12.70][mm].
    - Check that $D_1$ is less than #qty[400][mm].
        $
            D_1 = frac(p, sin frac(180 degree, N_1))
            = frac(12.7, sin frac(180 degree, 40))
            = #qty[161.9][mm]
        $

        $D_1$ is less than the max pitch diameter of #qty[400][mm], so it is
        suitable.

#cimage("./images/chain-drive-table-b1.png")

=== Step 3: Determine the number of teeth $N_2$ for the larger sprocket
+ Driven speed is #qty[245][mm] to #qty[255][rpm], so use the average of nominal
    speed for $eta_2$:
    $ eta_2 = (245 + 255)/2 = #qty[250][rpm] $
+ Speed ratio:
    $ "SR" = eta_1/eta_2 = 900/250 = 3.6 $
+ Number of teeth for the larger sprocket:
    $ N_2 = N_1 (eta_1/eta_2) = 40 times 3.6 = 144 $
+ Check that $D_2 < #qty[400][mm]$.
    $
        D_2 = frac(p, sin frac(180 degree, N_2))
        = frac(12.7, sin frac(180 degree, 144))
        = #qty[582.2][mm]
    $
+ Since $D_2$ exceeds the maximum pitch diameter of #qty[400][mm], the No. 40
    chain is *not* suitable.
+ Go back to step 2 and select a larger chain size until requirements are met.

#pagebreak()

=== Step 4: Repeat steps 2 and 3 to re-select chain
+ Re-select No. 50 chain with $N_1 = 20$, giving a power rating of
    #qty[11.0][kW].
    #cimage("./images/chain-drive-table-b4-appendix-b-no-50.png")
    $
        "Look for manufacturer's power rating" >=
        ("Design power" = #qty[11.0][kW])
    $
+ Check if re-selected chain yields suitable sprocket sizes.
    - From Table B-1, No. 50 chain pitch, $p = #qty[15.875][mm]$.
    - Check $D_1 <= #qty[400][mm]$:
        $ D_1 = frac(15.875, sin frac(180 degree, 80)) = #qty[101.5][mm] $
        Since $D_1 <= #qty[400][mm]$, so it is suitable.
    - $N_2 = 20 (3.6) = 72$. For tutorials and exams, the choice of the number
        of larger sprocket teeth is not restricted to Table B-1 of Appendix B.
    - Check $D_2 <= #qty[400][mm]$:
        $ D_2 = frac(15.875, sin frac(180 degree, 72)) = #qty[363.9][mm] $
        Since $D_2 <= #qty[400][mm]$, so it is suitable.
    - Compute actual output speed to check if it's within the specified range:
        $ eta_2 = 900 (20/72) = #qty[250][rpm] $
        Since $245 <= eta_2 <= 255$, it is suitable.
    - Hence, $N_1 = 20$, $N_2 = 72$.

#pagebreak()

=== Step 5: Centre distance and chain pitch length
+ Given that centre distance is *limited to* approximately #qty[760][mm]:
    $
        "Tentative Centre Distance (TCD)" & = 760/p \
                                          & = 760/15.875 = #qty[47.9][pitches]
    $
+ Calculate the Tentative Chain Length (TCL), in pitches:
    $
        "TCL" = 2 times "TCD" + frac(N_2 + N_1, 2)
        + frac((N_2 - N_1)^2, 4 pi^2 ("TCD"))
    $
    $
        "TCL" = 2(47.9) + frac(72 + 20, 2)
        + frac((72 - 20)^2, 4 pi^2 (47.9))
        = #qty[143.2][pitches]
    $
+ Adjust TCL to the *closest even number of pitches* to obtain the standard
    chain length ($L$):
    $ L = #qty[142][pitches] $

    #qty[142][pitches] is selected to not exceed the centre distance ($c$) of
    #qty[760][mm].

=== Step 6: Calculate the actual centre distance ($C$)
$
    C = 1/4 {
        L - frac(N_2 + N_1, 2)
        + sqrt([L - frac(N_2 + N_1, 2)]^2 - frac(8(N_2 - N_1)^2, 4 pi^2))
    }
$
$
    C & = 1/4 {
            142 - frac(72 + 20, 2)
            + sqrt([142 - frac(72 + 20, 2)]^2 - frac(8(72 - 20)^2, 4 pi^2))
        } & = #qty[47.27][pitches]
$

$ C = 47.27 times 15.875 = #qty[750.4][mm] $

#pagebreak()

=== Step 7: Select an appropriate type of lubrication
The No. 50 rating table shows that *Type B lubrication* is required for this
drive.
#cimage("./images/chain-drive-no-50-table.png")

Suggested chain drive:
- Single strand No. 50 roller chain
- Pitch ($p$) of #qty[15.875][mm]
- $N_1 = 20$
- $N_2 = 72$
- $L = #qty[142][pitches]$
- $C = #qty[750.4][mm]$
- Type B lubrication

#pagebreak()

== Guidelines to design for strength
For static or very slow speed applications (less than #qty[100][rpm]):
- *Strength* is the design criterion for such applications.
- The average tensile strengths and the maximum allowable loads for the various
    chain sizes are also listed in the catalogue.
- These allowable loads can be used for *very slow speed drives* or for
    applications in which the function of the chain is *to apply a tensile
    force* or support a load.

#cimage("./images/chain-drive-design-for-strength.png")

- A sample if a manufacturer's catalogue is given in Appendix B, Table B-1. It
    is recommended that only *10% of the average tensile strength* be used as
    the maximum allowable load if the maximum allowable load is not given.

#cimage("./images/chain-drive-design-for-strength-appendix-b-table-b1.png")
#pagebreak()

=== Allowable tensile strength
- The tensile strength of a multi-strand chain is a direct multiple of the
    number of strands multiplied by the *tensile strength of a single-strand
    chain* of the same pitch.
- For example:
    - A single strand ANSI No. 40 chain has an allowable tensile strength of
        $370 times g = #qty[3630][N]$
    - A double strand ANSI No. 40 chain has an allowable tensile strength of
        $2 times 3630 = #qty[7260][N]$
    - A triple strand ANSI No. 40 chain has an allowable tensile strength of
        $3 times 3630 = #qty[10890][N]$

#cimage("./images/chain-drive-allowable-tensile-strength.png")
#pagebreak()

== Design for strength example
A roller chain is used in a fork lift truck to elevate the forks. If two strands
support the load equally, which size would you specify for a design load of
44,000 #unit[N].

#cimage("./images/chain-drive-design-for-strength-example.png", height: 15em)

This is an example of the selection of roller chains for *very slow speed
applications* (less than #qty[100][rpm]).

In forklift trucks, the load is typically lifted very slowly, hence the
application of the load on the chains is almost static or at very slow speed. So
the selection of the roller chain is based on the strength requirement.

The design load is the maximum operating load that the forklift can lift.

Hence, the maximum operating load on the two strands of roller chain is 44,000
#unit[N].

Therefore, the maximum operating load supported by each strand is:
$ L = 44000/2 = #qty[22000][N] $

The maximum operating load $<=$ the allowable load.

#cimage("./images/chain-drive-design-for-strength-appendix-b-table-b1.png")
#pagebreak()

== Power, torque and chain tension
The equations are similar to that for belt drives, except that $F_2 = 0$.
#cimage("./images/chain-drive-power-torque-chain-tension.png")

Transmitted power:
$ P = T_1 omega_1 = T_2 omega_2 $

Torque:
$ T_1 = (F_1 - F_2) D_1/2 $
$ T_2 = (F_1 - F_2) D_2/2 $

Where:
- $P$ is power (#unit[W])
- $omega$ is the shaft angular velocity (#unit[rad s^-1])
- $T_1, T_2$ is the torque on the sprockets 1 and 2 respectively (#unit[Nm])
- $D_1, D_2$ is the pitch diameters of sprockets 1 and 2 respectively (#unit[m])
- $F_1$ is the tension on the tight side (#unit[N])
- $F_2 = 0$ is the tension on the slack side (#unit[N])

== Torque and direction of rotation
#cimage("./images/chain-drives-torque-and-direction-of-rotation.png")

#grid(
    columns: 2,
    column-gutter: 10em,
    [
        *Driver* sprocket:

        The input torque direction is the *same* as the rotation direction.
    ],
    [
        *Driven sprocket*:

        Output or resisting torque direction is *opposite* to the rotation
        direction.
    ],
)

== Tight tension side
Look at the rotation of the *driven sprocket*. The tight side gives the
direction of rotation toe the driven sheave.
#cimage("./images/chain-drive-tight-tension-side.png")
#pagebreak()

== Shaft load
Shaft load is determined in the same way as belt drives, which means the
*tension is assumed parallel*.

$ F_2 = 0 quad ("Zero tension on the slack side") $

$ F_x = F_1 $
#cimage("./images/chain-drive-shaft-load.png")

== Summary
- Select the *smallest roller chain using*:
    $
        "Design power per strand" = frac(
            "Power to be transmitted" times "Service factor",
            "Multiple strand factor"
        ) quad (#unit[kW])
    $
- To select chain, the rated power $>=$ design power.
- The rated power per strand is the power that can be transmitted by a chain,
    which is given in the manufacturer's catalogue for:
    - Small sprocket speed
    - Small sprocket teeth
- The power ratings in the table are for one strand.
- Standard driving and driven sprocket sizes.
    - For tutorials and exams, the choice of the number of larger sprocket teeth
        is not restricted to Table B-1 of Appendix B.
    - The maximum speed ratio for a single reduction, $N_2/N_1 = 7.0$. If higher
        reduction is required, use multi-stage reduction.
    - Check if the two sprockets, $N_1$ and $N_2$, gives the required speed
        ratio, or is within the driven speed range:
        $ eta_1/eta_2 = N_2/N_1 $

=== Summary of the design steps
- Similar to belt drives, chain selection for drives depends on the rated power
    of the driver, the specified speed ratio, the centre distance, the shaft
    diameters and the service conditions.
- The chain selection process is usually iterative.

==== Step 1: Determine the design power
$
    "Design power per strand" = frac(
        "Power to be transmitted" times "Service factor",
        "Multiple strand factor"
    ) quad (#unit[kW])
$

+ Select the service factor form Table B-2, Appendix B.
    + Determine the classification of the load according to its shock
        characteristics as guided by List 2 of Table B-2.
    + Determine the service factor from List 1 of Table B-2, which is dependent
        upon the characteristics of the input power.
+ Drive power is the actual power requirement of the drive machine.
+ Tentatively select the number of strands.
    - You can start with on strand first and then check later if space
        requirements are met.
    - If necessary iterate until requirements are met.

#cimage("./images/chain-drive-table-b2-appendix-b.png")

==== Step 2: Select the chain size and the number of smaller sprocket teeth
+ Starting with the *smallest* available chain size, i.e. the No. 25 chain in
    Table B-4, with the design power at the required rpm of the smaller
    sprocket, determine the minimum size sprocket, which is the number of teeth,
    $N_1$, needed to provide a power rating (given by the manufacturer) equal or
    greater than the design power. The idea is to *select as small a chain as
    possible*.
+ Use the preferred minimum of 17 teeth if *space is not an issue*.

==== Step 3: Determine the number of teeth $N_2$ for the driven sprocket
+ Speed ratio:
    $ eta_1/eta_2 = N_2/N_1 $
+ Speed ratio should be about 7:1. If a higher speed ratio is required, a
    multi-stage reduction drive should be proposed.
+ Select a standard $N_2$ nearest to the calculated value.

==== Step 4: Calculate the pitch diameters of the sprockets
To get an idea of the size of the sprockets:
$ D_1 = frac(p, sin frac(180 degree, N_1)) #unit[mm] $
$ D_2 = frac(p, sin frac(180 degree, N_2)) #unit[mm] $

==== Step 5: Centre distance and chain pitch length
+ If an approximate centre distance is not known, use the recommended centre
    distance of *30 to 50* pitches and decide on a tentative centre distance
    (TCD) in pitches.

    For example, choosing a smaller centre distance of 33 pitches for
    compactness.
+ Find the tentative chain length (TCL), in pitches:
    $
        "TCL" = 2 "TCD" + frac(N_2 + N_1, 2) +
        frac((N_2 - N_1)^2, 4 pi^2 "TCD") "pitches"
    $
+ Specify an even number of pitches for the chain length, $L$, closest to the
    tentative chain length, that satisfies design requirements.

==== Step 6: Calculate the actual centre distance ($C$)
$
    C = 1/4 {
        L - frac(N_2 + N_1, 2) + sqrt(
            [L - frac(N_2 + N_1, 2)]^2 - frac(8(N_2 - N_1)^2, 4 pi^2)
        )
    } "pitches"
$

==== Step 7: Select an appropriate type of lubrication
Read off the type of lubrication recommended in the power rating table for the
selected chain.

#pagebreak()

= Gears
- Gears are used to transmit *torque*, *rotary motion*, and *power* from one
    shaft to another.
- Compared to various other means of power transmission, like belts and chains,
    gears are the most rugged and durable.
- They have a transmission efficiency as high as 98%.
- However, gears are generally more costly than belts and chains.
- The shapes and sizes of the teeth are standardised.
- Modern gears are made to high precision standards. As a result, they are
    normally purchased from gear manufacturers rather than designed and machined
    at the user's plant.
- However, one cannot arbitrarily order any gear from a manufacturer's catalogue
    for a particular application. One must have a working knowledge of gear
    design, including design limitations, to produce a satisfactory gear drive.

#grid(
    columns: 2,
    column-gutter: 1em,
    image("./images/spur-gear.png"), image("./images/worm-gear.png"),
)

== Considerations in designing a gear drive
- What type of gears to use for parallel and perpendicular shaft arrangements?
- How many speed reductions to use in gear train to achieve the final speed?
- How to compute dimensions of key gear features?
- How to specify the layout of the gear train, including key design decisions?
- What forces would be created and transferred to the shafts carrying the gears
    and to the bearings carrying the shafts?

#figure(
    image("./images/conceptual-design-of-a-gear-reducer.png"),
    caption: [Conceptual design of a gear reducer],
)

== Type of gears
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        The figure on the right shows a photograph of many types of gears.

        Labels indicate the 4 major types of gears:
        - Spur gears
        - Helical gears
        - Bevel gears
        - Worm and worm gear sets
    ],
    image("./images/types-of-gears.png"),
)

=== Description of spur gears
- Spur gears have teeth parallel to the axis of rotation and are used to
    transmit motion from one shaft to another parallel shaft.
- Of all types, the spur gear is the simplest.
- For this reason, has always been used to develop the primary kinematic
    relationship of the tooth form.

#figure(
    image("./images/description-of-spur-gears.png", height: 25em),
    caption: [Spur gears],
)

=== Description of helical gears
- Helical gears have teeth include to the axis of rotation.
- They can be used for the same applications as spur gears.
- They are not as noisy as spur gears, because of the more gradual engagement of
    the teeth during the meshing.
- The inclined tooth also develops thrust loads and bending couples, which are
    not present with spur gearing.
- Herringbone gears are helical gears with self-cancelling trusts.
- Sometimes helical gears are used to transmit motion between non-parallel
    shafts.

#figure(
    image("./images/description-of-helical-gears.png", height: 19em),
    caption: [Helical gears],
)

=== Description of bevel gears
- Bevel gears have teeth formed on conical surfaces and are used mostly for
    transmitting motion between intersecting shafts.
- Spiral bevel gears are cut such that the tooth is no longer straight but forms
    a circular arc.
- Hypoid gears are quite similar to spiral bevel gears except that the shafts
    are offset and non-intersecting.

#figure(
    image("./images/description-of-bevel-gears.png", height: 19em),
    caption: [Straight tooth bevel gears],
)

=== Description of worm gears
- The worm resembles a screw.
- The direction of the worm gear depends on the direction of the worm and
    whether the worm teeth are cut right-handed or left-handed.
- Worm gear sets are also made so that the teeth of one or both wrap partly
    around the other.
- Such sets are called single-enveloping and double-enveloping worm-gear sets.

#figure(
    image("./images/description-of-worm-gears.png", height: 20em),
    caption: [Worm and worm gear],
)

== Spur gear
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        === Pinion
        A pinion is the smaller of the two mating gears. The larger is often
        called the gear.

        === Pitch circle
        The pitch circle is the imaginary circle on which most gear calculations
        are based. When the gears mesh, their pitch circles are tangent to each
        other.

        === Pitch diameter
        Pitch diameter of the pitch circle $D_P$ for the pinion and $D_G$ for
        the gear.
    ],
    image("./images/spur-gear-terminology.png"),
)

=== Circular pitch and module
Circular pitch, $p$, is the distance between the corresponding points on
adjacent teeth, measured along the pitch circle. The circular pitches of meshing
gears must be equal.

The circular pitch is equal to the sum of the tooth thickness and the width of
tooth space.

$ p = frac(pi D, N) #unit[mm] $

Module, $m$ is the index of the tooth size in metric unit. It is the ratio of
the pitch diameter to the number of teeth. *For two gears to mesh, they must
have the same module*.

$ m = D/N #unit[mm] $

#cimage("./images/circular-pitch-and-module.png", width: 70%)

Examples:
- If $m = #qty[1.0][mm], N = 20$, then:
    $ D = m N = 1.0 (20) = #qty[20][mm] $
- If $m = #qty[3.0][mm], N = 20$, then:
    $ D = m N = 3.0 (20) = #qty[60][mm] $

=== Features of a gear tooth
- *Addendum* ($a$) is the radial distance from the pitch circle to the outside
    of the tooth.
- *Dedendum* ($b$) is the radial distance from the pitch circle to the bottom of
    the tooth.
- *Clearance* ($c$) is the radial distance from the top of a tooth to the bottom
    of the mating gear.
    $ c = b - a $

#cimage("./images/features-of-a-gear-tooth.png", width: 70%)

=== Outermost dimension of two meshing gears

#cimage("./images/outermost-dimension-of-two-meshed-gears.png")

==== Centre distance ($C$)
$
    C & = frac(D_G + D_P, 2) \
      & = frac(m N_G + m N_P, 2) \
      & = m (frac(N_G + N_P, 2))
$

==== Outside diameter of a gear ($D_o$)
$ D_o = D + 2a $

==== Tip to tip dimension ($S_T$)
Outermost distance between the tips of meshing gears, which is the furthest
distance between two addendum circles.

For two meshing gears, the outermost distance of 2 gears in mesh is:
$ S_T = (D_G + a) + (D_P + a) $

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        === Base circle
        - The circle from which an involute tooth curve is developed.
        - The base circle is always tangent to the line of action.
        - Diameter of the base circle:
            $ D_b = D cos phi.alt $

            Where $phi.alt$ is the *pressure angle*.

        === Line of action
        The line of action is the line in which the gear force acts upon.
    ],
    image("./images/line-of-action-pressure-angle-and-base-circle.png"),
)

=== Involute tooth profile
- The gear tooth profile geometry must produce an exactly constant angular
    velocity ratio between the driver and the driven gears at every position as
    successive teeth rotate through the mesh.
- If a meshing pair of gear teeth have profiles that satisfy this requirement,
    they are called conjugate profiles.
- The involute profile is a conjugate profiles and is the most widely used tooth
    profile due to its relative ease of manufacture and insensitivity of angular
    velocity ratio to minor variations in centre distance.

#cimage("./images/involute-tooth-profile.png", height: 23em)

=== Standard tooth proportion of spur gears
- A tooth system is a standard that specifies the relationships involving
    addendum, dedendum, working depth, tooth thickness and pressure angle.
- This allows interchangeability of gears of all tooth numbers with the *same
    module and pressure angle*.
- A wide variety of modules is available to cover every tooth size required from
    instrument gears to gears for steel mills.
- Table 1 shows the preferred values ranging from #qty[0.3][mm] to #qty[50][mm].
    #cimage("./images/spur-gear-table-1.png")
- Table 2 shows the tooth proportion for some standard gears.
    #cimage("./images/spur-gear-table-2.png", width: 80%)

=== Properties at a glance
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        - Module:
            $ m = D/N quad (#unit[mm]) $
        - Circular pitch:
            $ p = frac(pi D, N) = pi m $
        - Addendum:
            $ a = 1.0 m $
        - Dedendum:
            $ b = 1.25 m $
        - Centre Distance:
            $ C = frac(D_G + D_P, 2) $
        - Outside diameter of a gear:
            $ D_o = D + 2a $
        - Tip to tip dimension:
            $ S_T = D_G + D_P + 2a $
    ],
    image("./images/spur-gear-summary.png"),
)

=== Rack and pinion
- A rack is a spur gear having an infinitely large pitch diameter and hence an
    infinite number of teeth.
- This results in a straight line for the pitch circle, which is known as the
    pitch line.
- Hence, the surfaces of the rack teeth are flat but must mesh properly with the
    involute surfaces of the mating pinion.

#cimage("./images/rack-and-pinion.png")

==== Applications
When a pinion meshes with a rack, the rotary motion of the pinion is transformed
into linear motion of the rack, or vice versa. Examples of its use are in:
- Drill presses where the rack and pinion is used to raise or lower the work
    table.
- Rack and pinion steering in automobiles where the pinion is attached at the
    bottom of the steering column and meshes with a rack that is free to move
    left and right to turn the wheels.

#cimage("./images/rack-and-pinion-applications.png")
#pagebreak()

=== Internal spur gear
- Internal spur gears are circular rings with teeth cut into the inner surfaces.
- The pinion and internal gear rotate in the same direction.
- Internal spur gears with mating pinions provide far more compact drive systems
    than external spur gears.
- They also provide large contact ratios and can hence transmit more power.

#cimage("./images/internal-spur-gear.png")

=== Contact ratio ($m_p$)
To design teeth that will rotate smoothly through the angle of action of a spur
gear:
+ The contact of at least one or more tooth pair must be uninterrupted.
+ Avoid interference.

- The contact ratio ($m_p$) is defined as the number of pairs of teeth that are
    in contact at any instant.
- It is necessary that continuous action takes place between mating teeth and
    hence desirable to have more than one pair of teeth in contact at all times
    during operation.
- The contact ratio is calculated as the length of contact divided by the base
    pitch:
    $
        m_p = Z/p_b = frac(
            sqrt(R_o^2 - R_b^2) + sqrt(r_o^2 - r_b^2) - C sin phi.alt,
            p cos phi.alt
        )
    $
- Most spur gears are designed with contact ratios between *1.2 and 1.8*.
- Generally, the greater the contact ratio or the considerable overlap of gear
    actions, the smoother and quieter the operation of gears.

#pagebreak()

=== Interference
- Under certain conditions, tooth profiles overlap or cut into each other.
- This situation, termed interference, should be avoided because of excess wear,
    vibration or jamming.
- Generally, it involves contact between involute surfaces of one gear and
    non-involute surfaces of the mating gears. When interference occurs, the
    gears do not operate without modification.
- Removal of the portion of tooth below the base circle and cutting away the
    interfering material results in an undercut tooth.
- Undercutting *weakens the tooth considerably* and causes early tooth failure.

#cimage("./images/spur-gear-interference.png")

- Interference between the tip of a gear tooth and the non-involute root or
    fillet of the mating gear tooth can occur for certain combinations of the
    number of teeth.
- The usually happens when a small pinion drives a very large gear, with the
    worst case being a small pinion driving a rack.
- A rack is a spur gear having an infinitely large pitch diameter and therefore
    an infinite number of teeth.
- Interference can be prevented by using a proper combination of the number of
    teeth for the mating gears.

==== Minimum number of pinion teeth to mesh with rack
Working with $m_p$, the minimum number of full-depth teeth on the pinion that
will *operate with a rack* without interference is given by:
$ "Minimum" N_P >= frac(2, sin^2 phi.alt) $

For a $20 degree$ pressure angle full-depth tooth, the smallest number of pinion
teeth is:
$ "Minimum" N_P >= frac(2, sin^2 20 degree) >= 17.1 $
$ therefore "Minimum" N_P = #qty[18][teeth] $

#pagebreak()

==== Maximum number of gear teeth to mesh with small pinion
The largest gear that operates with a specified full-depth pinion that is
interference-free is:
$ "Maximum" N_G <= frac(N_P^2 sin^2 phi.alt - 4, 4 - 2 N_P sin^2 phi.alt) $

For a 13-tooth spur gear pinion with a $20 degree$ pressure angle, the maximum
number of gear teeth possible without interference is:
$
    "Maximum" N_G <=
    frac(13^2 sin^2 20 degree - 4, 4 - 2 (13) sin^2 20 degree) <= 16.45
$
$ therefore "Maximum" N_G = #qty[16][teeth] $

Hence, a 13-tooth spur gear can only mesh with a gear with 13 to 16 teeth.

==== Ensuring no interference of meshing spur gears
Table 3 gives the combinations of the number of teeth for $20 degree$ full
depth, meshing spur gears to ensure no interference.

#cimage("./images/spur-gear-table-3.png")

It is not sufficient to provide gears of the same module, pressure angle and
width. A pair of gears must also mesh without interference.

#grid(
    columns: 2,
    column-gutter: 2em,
    [
        === Speed ratio
        $ "Speed ratio" = "Input speed"/"Output speed" $
        $ v_t = R_P omega_P = R_G omega_G = R_P eta_P = R_G eta_G $
        $
            "Input speed"/"Output speed" & = eta_P/eta_G \
                                         & = omega_P/omega_G \
                                         & = N_G/N_P
                                           quad because D = m N
        $


        === Direction of rotation
        The pinion and gear rotate in *opposite directions*.
    ],
    image("./images/spur-gear-speed-ratio-and-rotation-direction.png"),
)

#pagebreak()

== Gear trains
- A pair of meshing gears is the simplest form of a gear train known as a simple
    gear train.
- A gear train is a sequence of several meshing gears arranged in such a way
    that the desired output speed, torque, direction of rotation are achieved
    using specified input conditions.
- Various arrangements and sequences of gears may be used to achieve design
    goals.
- It is important to be able to readily determine the magnitude and direction of
    angular velocity of the output gear, given the input velocity for any gear
    train arrangement.
- Gear trains may be classified as simple, compound or epicyclic.

#cimage("./images/gear-train-types.png", width: 98%)

=== Train or overall speed ratio
The double-reduction compound gear train is used to develop the train or overall
speed ratio.
- Gear A and gear D are simple gears, which is a single gear mounted on a shaft.
- Gear B and gear C are compound gears, which are more than one gear mounted the
    same shaft.
- Input is through the shaft carrying gear A.
    + Gear A drives gear B.
    + Gears B and C are mounted on the same *intermediate or counter* shaft and
        hence have the same speed and direction of rotation.
    + Gear C drives gear D, which is connected to the output shaft.
- The direction of rotation can be determined by observation. Gear D rotates
    clockwise as shown.

$ "Train speed ratio" = "Input speed"/"Output speed" $
$ "Train" S R = eta_A/eta_D $

$ (S R)_(A B) = eta_A/eta_B = N_B/N_A $
$ therefore eta_A = N_B/N_A eta_B $

$ (S R)_(C D) = eta_C/eta_D = N_D/N_C $
$ therefore eta_D = N_C/N_D eta_C $

$ therefore "Train" S R = eta_A/eta_D = frac(N_B/N_A eta_B, N_C/N_D eta_C) $

Since $eta_B = eta_C$:
$ "Train" S R = eta_A/eta_D = frac(N_B N_D, N_A N_C) = (S R)_(A B) (S R)_(C D) $

#cimage("./images/gear-train-speed-ratio.png", width: 75%)

The direction of rotation is obtained by observation.

#pagebreak()

==== Simple expression for train speed ratio
The train speed ratio is the product of the speed ratio for each pair of meshing
gears in the gear train. This process can be expanded to any number of stages of
speed reduction in a gear train. Hence, in general:
$ "Train" S R = (S R)_1 (S R)_2 (S R)_3 (S R)_"etc" $

Alternatively, the train speed ratio can be expressed as follows:
$
    "Train" S R & = frac(N_B N_D, N_A N_C) \
                & = frac(
                      "Product of the number of teeth on driven gears",
                      "Product of the number of teeth on driver gears"
                  )
$

==== Effect of idler gears on speed ratio
#cimage("./images/gear-train-idler-effect-on-speed-ratio.png", height: 25em)

$ (S R)_1 = frac(N_B, N_A) $
$ (S R)_2 = frac(N_E, N_C) $
$ (S R)_3 = frac(N_D, N_E) $

$
    "Train" S R & = (S R)_1 (S R)_2 (S R)_3 \
                & = N_B/N_A N_E/N_C N_D/N_E \
                & = N_B/N_A N_D/N_C quad ("same as before")
$

For an idler gear, no power flows out of its shaft.

==== Effect of idler gears on rotation direction
#cimage("./images/gear-train-idler-effect-on-rotation-direction.png")

==== Effect of idler gears
- The idler gear does not affect the train speed ratio, but does cause a
    direction reversal.
- Idler gears can also be used to assist in providing the required centre
    distance between input and output shafts.

#cimage("./images/gear-train-idler.png")
#pagebreak()

== Helical gears
- Helical gear drives share many of the attributes of straight tooth gears when
    used to transmit power or motion between parallel shafts.
- The distinguishing geometrical difference is that spur gear teeth are straight
    and aligned with the axis of rotation (gear) while helical gear teeth are
    angled with respect to the axis of rotation (gear) at an angle #sym.psi,
    called the helix angle.
- The forms of helical gears are very similar to those for spear gears. However,
    we need to account for the effect of the helix angle.

#cimage("./images/helical-gear.png")

=== Handedness of helical gears
- The helix for a given gear can be either left-handed or right-handed.
- The rule for determining whether a helical gear is right or left-handed is the
    same as the one used for determining right and left-handed screws.

==== Right-handed
The teeth appear to lean to the right looking into the gear axis of rotation,
similar to a normal right-handed screw.

#cimage("./images/helical-gear-right-handed.png", width: 90%)
#pagebreak()

==== Left-handed
The teeth appear to lean to the left looking into the gear axis of rotation,
similar to a normal left-handed screw.

#cimage("./images/helical-gear-left-handed.png", height: 20em)

==== Determining the handedness of helical gears
#cimage("./images/helical-gear-determining-handedness.png")

==== Handedness of helical gears on parallel shafts
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        - Helical gears are usually mounted on parallel shafts.
        - For the parallel shaft arrangement shown, the helix angle is the same
            on each gear, but one gear must have a right-handed helix and the
            other a left-handed helix.
    ],
    image("./images/helical-gear-parallel-shafts.png", height: 15em),
)


=== Advantages of helical gears
- The main advantage of helical gears is the *smoother engagement*, as a given
    tooth assumes its load gradually instead of suddenly.
- A larger average number of teeth are engaged and are sharing the applied loads
    compared to a spur gear.
- The lower average load per tooth allows a greater power transmission capacity
    for a given size of gear, or a smaller gear can be designed to carry the
    same power.

=== Disadvantages of helical gears
- The main disadvantage of helical gears is that an axial thrust load is
    produced as a natural result of the inclined arrangement of the teeth.
- The bearings that hold the shaft carrying the helical gear must be capable of
    reacting against the radial load as well as the thrust load.
- Helical gears also cost more than spur gears.

=== Helical gear angles
- Spur gear teeth are produced when the cutter cuts its teeth parallel to its
    rotating axis.
- When the axis of the gear blank is aligned at the helix angle to the cutter,
    helical gear teeth are generated.

#cimage("./images/helical-gear-cutting.png")

==== Angles in the normal plane
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        - The teeth form the helix angle, #sym.psi, with the axis of the gear
            (rotation).
        - The teeth are cut at this angle and the tooth formed is in the normal
            plane.
        - The usual range of values of the helix angle is between $15 degree$
            and $30 degree$.
        - The normal pitch, $p_n$, and the normal pressure angle $phi.alt_n$ are
            measured in the normal plane.
    ],
    image("./images/helical-gear-normal-plane.png"),
)

==== Angles in the transverse plane
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        *Transverse plane* (normal to the axis rotation)
        - The transverse pitch $p_t$ and the transverse pressure angle
            $phi.alt_t$ are measured in the transverse plane or the plane of
            rotation, as with spur gears.
        - Pitch diameter $D$ is defined in this plane.
    ],
    image("./images/helical-gear-transverse-plane.png"),
)

#pagebreak()

==== Module and angles
- Helix angle #sym.psi, normal pressure angle, $phi.alt_n$, transverse pressure
    angle $phi.alt_t$:
    - Need to specify helix angle #sym.psi, and at least one pressure angle,
        typically $phi.alt_n$.
    - The other angle is computed from:
        $ tan phi.alt_t = frac(tan phi.alt_n, cos psi) $
- On the transverse plane (similar to the spur gear):
    $
        "Transverse (circular) pitch," p_t = frac(pi D, N),
        wide "Transverse module," m = D/N
    $
- On the normal plane (the plane of the gear cutter):
    $ "Normal circular pitch," p_n = p_t cos psi $
    $
        "Normal module," pi m_n & = pi m cos psi quad ("note" p = pi m) \
                            m_n & = m cos psi
    $

    Typically, $m_n$ is known:
    $ therefore m = frac(m_n, cos psi) $

=== Geometry
In the normal plane (gear cutting plane):
- Standard addendum, $a_n = 1.00 m_n$
- Standard dedendum, $b_n = 1.00 m_n$

In the transverse plane (perpendicular to the gear, or the rotation axis), the
calculations are similar to the spur gear, but replace $m$ with
$frac(m_n, cos psi)$:
- Pitch diameter:
    $ D = m N = frac(N m_n, cos psi) $
- Addendum:
    $ a = 1.00 m = frac(m_n, cos psi) $
- Dedendum:
    $ b = 1.25 m = 1.25 (frac(m_n, cos psi)) $
- Outside diameter:
    $ D_o = D + 2a = (N + 2) m = (N + 2) frac(m_n, cos psi) $
- Tip to tip dimension while meshing:
    $ S_T = D_G + D_P + 2a = (N_G + N_P + 2) frac(m_n, cos psi) $
- Centre distance:
    $ C = frac(D_G + D_P, 2) = frac((N_G + N_P) m_n, 2 cos psi) $

=== Speed ratio and direction of rotation
- Speed ratio:
    $
        S R = frac("Input speed", "Output speed")
        = eta_P/eta_G = omega_P/omega_G = D_G/D_P = N_G/N_P
    $
- Direction of rotation is obtained by observation, similar to spur gears.
- The pinion and gear rotate in *opposite directions*:
    #cimage("./images/helical-gear-rotation-direction.png")

=== Example
The double-reduction helical gear set is shown below. Gears G2 and G3 have a
normal module of #qty[2.5][mm], and gears G4 and G5 have a normal module of
#qty[4.0][mm]. All gears have a $30 degree$ helix angle and a normal pressure
angle of $20 degree$.

Determine the inside dimensions X and Y of the rectangular housing that would
provide a minimum clearance of #qty[2.0][mm] if the gear set is to be installed
in the housing.

#cimage("./images/helical-gear-example-1.png", height: 20em)

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        ==== Gears 2 and 3 pitch diameters

        $ m_n = 2.5, quad psi = 30 degree $
        $ m = frac(m_n, cos psi) = frac(2.5, cos 30 degree) = 2.8867 $
        $ D_2 = m N_2 = 2.8867 (14) = 40.40 $
        $ D_3 = m N_3 = 2.8867 (54) = 155.88 $
        $ R_3 = D_3/2 = 77.94 $

        ==== Gears 4 and 5 pitch diameters

        $ m_n = 4.0, quad psi = 30 degree $
        $ m = frac(m_n, cos psi) = frac(4.0, cos 30 degree) = 4.6188 $
        $ D_4 = m N_4 = 4.6188 (14) = 73.90 $
        $ D_5 = m N_5 = 4.6188 (36) = 166.28 > D_3 $
        $ R_4 = D_4/2 = 36.95 $
        $ R_5 = D_5/2 = 83.14 $
    ],
    image("./images/helical-gear-example-2.png"),
)

==== Inside dimension $Y$ of housing
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [

        $ a_3 = m = frac(m_n, cos psi) = frac(2.5, cos 30 degree) = 2.8867 $
        $ a_5 = m = frac(m_n, cos psi) = frac(4.0, cos 30 degree) = 4.6188 $

        Minimum clearance from gear tip is #qty[2.0][mm].

        $ D_5 = 166.28 $
        $ R_4 = 36.95 $
        $ R_3 = 77.94 $

        $
            Y & = Y_o + 2.0 + 2.0 \
              & = (a_5 + D_5 + R_4 + R_3 + a_3) + 4.0 \
              & = (4.6188 + 166.28 + 36.95 + 77.94 + 2.8867) + 4.0 \
              & = #qty[292.67][mm]
        $
    ],
    image("./images/helical-gear-example-3.png"),
)

==== Inside dimension $X$ of housing

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        $
            a_2 = a_3 = m = frac(m_n, cos psi) = frac(2.5, cos 30 degree)
            = 2.8867
        $
        $ a_5 = m = frac(m_n, cos psi) = frac(4.0, cos 30 degree) = 4.6188 $

        Minimum clearance from gear tip is #qty[2.0][mm].

        $ R_5 = 83.14 $
        $ R_3 = 77.94 $
        $ D_2 = 40.40 $

        $
            X & = X_o + 2.0 + 2.0 \
              & = (a_5 + R_5 + R_3 + D_2 + a_3) + 4.0 \
              & = (4.6188 + 83.14 + 77.94 + 40.40 + 2.8867) + 4.0 \
              & = #qty[212.98][mm]
        $
    ],
    image("./images/helical-gear-example-3.png"),
)

#pagebreak()

== Spur gear forces
- The figure below shows a single-reduction spur gear pair. It shows a pinion
    mounted on a shaft rotating clockwise at $eta_P$ rpm and driving a gear on
    shaft $b$ at $eta_G$ rpm.
- Description of power flow, which helps to see which part is under torque:
    - Motor supplies power and hence torque through the input motor shaft.
    - Torque:
        $ T = "Power"/"Rotational speed" = P/omega $
    - Coupling transfers power from the input shaft to the shaft carrying
        pillion at the point where the pinion is mounted. Sometimes, the pinion
        can be directly mounted on the motor shaft.
    - Bearings support shaft carrying pinion. To maintain equilibrium, the
        bearing provide reaction forces due to pinion forces, and if any, the
        weight of the shaft and the pinion. They also allow the shaft to rotate
        smoothly.
    - Torque and power are transmitted across the key from the shaft to the
        pinion.
    - The pinion teeth drive gear teeth and thus power and torque are
        transmitted to the gear.
    - Likewise, power flows through the gear, key and coupling to the driven
        machine.

#cimage("./images/spur-gear-forces-power-flow.png")

=== Free body diagram
#cimage("./images/spur-gear-forces-free-body-diagram.png")
$ W_r = W_t tan phi.alt $
$ W_n = "Actual gear force and decomposes into" W_t "and" W_r $

=== Determining the direction of tangential load $W_t$
+ The direction of $W_t$ on the driven gear is to provide the rotation of the
    *driven gear*.
    #cimage("./images/spur-gear-forces-tangential-load-direction-1.png")

+ On the *driving gear*, the direction of $W_t$ is such that it produces a
    torque opposite in direction to the input torque.
    - The input torque is in the same direction as the rotation as it supplies
        motion to the driving gear.
    - For torque equilibrium, i.e. $sum T = 0$, $W_t$ must produce torque in the
        opposite direction to $T_"driver"$.

    #cimage("./images/spur-gear-forces-tangential-load-direction-2.png")

#pagebreak()

=== Forces on the gears
- $W_t$ tangential load acts tangent to the pitch of the gear.
- $W_r$ radial force always acts into the centre of the gear.

#cimage("./images/spur-gear-forces-driven-gear.png", height: 20em)
#cimage("./images/spur-gear-forces-driven-and-driving-gear.png")
#pagebreak()

==== Calculation of gear forces
Calculation of gear forces usually start with the tangential load, $W_t$, since
power and speed are known quantities.

$ T = P/omega $
$ omega = frac(2 pi eta, 60) $
$ W_t = T/R = frac(2T, D) $

For no power loss,
$ P = T_P omega_P = T_G omega_G $
$
    T_G/T_P & = omega_P/omega_G \
            & = N_G/N_P
$

=== Sizing of gears
- In the design of gear drives, selection of gear teeth is based not only on the
    number of gear teeth required for the desired velocity ratios, but also the
    *strength* of the teeth and hence the determination of the size via the
    module of the teeth and the type of material becomes an inevitable task.
- Two modes of failure affect gear teeth:
    - *Fatigue fracture* owing to fluctuating bending stress at the root of the
        tooth. Failure by bending will occur when the significant tooth stress
        equals or exceeds either the yield strength or the bending endurance
        strength.
    - *Fatigue (wear)* of the tooth surface. A surface failure occurs when the
        significant contact stress equal or exceeds the surface endurance
        strength.

=== Important mechanical properties
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Strength:
        - To resist failure or breakage of the gear tooth due to the force
            exerted on the tooth, which causes high tensile and bending stress
            and the root.

        Durability (wear resistance):
        - To resist pitting, which is a fatigue failure that results in a local
            fractures due to repeated application of high contact stresses near
            the pitch line.
    ],
    image("./images/spur-gear-forces-important-mechanical-properties.png"),
)

=== Considerations in the design of gear train
When contemplating the design of a gear train, the following should be taken
into account.

==== Number of gears in the train
- It is often possible to obtain a specified speed ratio with any number of
    pairs of gears. For the case where the speed ratio is accomplished in one
    step, the gear sizes and hence space requirements can be quite large.
- If many steps or speed reductions are used, many shafts and smaller gears are
    needed, which usually means added costs.
- A proper compromise between space requirements, economy, and efficiency of
    operation must be made to arrive at the best overall system.

==== Strength of tooth
- When a large amount of power is transmitted at low speeds, a huge value of
    torque occurs.
- The torque exerts a high load on the gear teeth, necessitating larger size
    teeth. The high torque value also means that at the low speed end of a gear
    train, the teeth need to be larger than at the high speed end.
- The *amount of load* determines the tooth size, which in turn affects the
    pitch diameter and the number of teeth.

== Helical gear forces
- The figures below show a 3-dimensional view of the forces acting against a
    helical gear tooth.
- Similar to spur gears, the point of application of the force is in the pitch
    plane and in the centre of the gear face.
- The actual gear force is normal to the tooth surface and indicated by $W_n$,
    and decomposed into the transmitted load $W_t$, radial force $W_r$, and
    axial force $W_a$.
- The transmitted load $W_t$ and the radial force $W_r$ are the same as the ones
    for spur gears.
- The axial force $W_a$ is present due to the helix.

=== Tangential force
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Transmitted tangential force:
        $ W_t = frac(T, D/2) $

        $ D = m N, quad m = frac(m_n, cos psi) $

        To obtain the direction of the force, use the same method used on spur
        gears.

        #cimage(
            "./images/spur-gear-forces-tangential-load-direction-1.png",
            height: 13.5em,
        )
    ],
    image("./images/helical-gear-forces-tangential.png"),
)

=== Radial force
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        Radial force:
        $ W_r = W_t tan phi.alt_t $
        $ tan phi.alt_t = frac(tan phi.alt_n, cos psi) $

        The force direction is always towards the centre of the gear.
    ],
    image("./images/helical-gear-forces-radial.png"),
)

=== Axial force
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        Axial force (thrust load):
        $ W_a = W_t tan psi $

        The direction of the force is always parallel to the shaft axis.
    ],
    image("./images/helical-gear-forces-axial.png"),
)

==== Determining the direction
- The direction of the thrust load is determined by applying the *right-hand
    thumb rule* for *right-handed driving gear*, or the *left-hand thumb rule*
    for the *left-hand driving gear*.
- The *fingers of the hand* are pointed in the direction of rotation of the
    driving gear, the *thumb* points in the direction of the thrust or axial
    force.
- The driven gear then has a thrust load acting in the direction opposite to
    that of the driving gear.

===== Right-hand thumb rule
#cimage("./images/helical-gear-right-handed.png")

===== Left-hand thumb rule
#cimage("./images/helical-gear-left-handed.png", height: 30em)
#pagebreak()

=== Graphical presentation of gear forces
For convenience, the 3-dimensional load system on a helical gear can be replaced
by a 2D representation for the helical gear.

#cimage("./images/helical-gear-forces-graphical-presentation.png")

=== Example
In the figure, a #qty[0.75][kW] motor runs at #qty[1800][rpm] in the clockwise
direction as shown. Keyed to the motor shaft is an 18T helical pinion having a
normal pressure angle of $20 degree$, a helix angle of $30 degree$, and a normal
module of #qty[2][mm]. The hand of the helix is shown in the figure. Make a
three-dimensional sketch of the motor shaft and pinion and show the forces
acting on the pinion and the bearing reactions at A and B. The thrust should be
taken out at A.

#cimage("./images/helical-gear-forces-example-1.png")
#pagebreak()

==== Gear forces on 18T pinion
$ W_t, W_r, W_a $
$ W_t = T_P (frac(D_P, 2)) $
$ T_P = T_m = frac(P, frac(2 pi eta_P, 60)) $
$ D_P = m N_P $

Since:
$ m = frac(m_n, cos psi) = frac(2.0, cos 30 degree) = 2.31 $
$ therefore D_P = 2.31 (18) = #qty[41.6][mm] $

$ T_P = frac(0.75 (1000), 2 pi 1800/60) = #qty[3.98][Nm] $
$ W_t = frac(3.98, 0.0416/2) = #qty[191][N] $
$ W_r = W_t tan phi.alt_t $

Since:
$
    tan phi.alt_t = frac(tan phi.alt_n, cos psi)
    = frac(tan 20 degree, cos 30 degree) = 0.4202
$
$ therefore W_r = 191 (0.4202) = #qty[80.6][N] $
$ W_a = W_t tan psi = 191 tan 30 degree = #qty[110][N] $

==== Determining $W_a$
#cimage("./images/helical-gear-forces-example-2.png")

==== Determining $W_t$ and $W_r$
#cimage("./images/helical-gear-forces-example-3.png")

Use the *driven* gear to determine the direction of $W_t$.

==== Forces on the motor shaft and pinion
Below is a 3D sketch of the motor shaft and pinion and forces acting on the
pinion and the bearing reactions at $A$ and $B$.

$ "Radial load on bearing" A, R_A = sqrt(R_(A Y)^2 + R_(A Z)^2) $
$ "Radial load on bearing" B, R_B = sqrt(R_(B Y)^2 + R_(B Z)^2) $

#cimage("./images/helical-gear-forces-example-4.png")
#pagebreak()

==== Solving for bearing reaction forces
#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Equilibrium in the $x$-direction:
        $ R_(A x) - W_a = 0 $
        $ therefore R_(A x) = W_a = #qty[110][N] $

        Vertical $x$-$y$ plane equilibrium to determine $R_(B y)$ and $R_(A y)$

        $ sum M "about" A = 0 $
        $ 325 W_r - 250 R_(B y) - 20.8 W_a = 0 $
        $ R_(B y) = #qty[95.6][N] $

        $ sum F_y = 0 $
        $ R_(A y) + R_(B y) - W_r = 0 $
        $ R_(A y) + 95.6 - 80.6 = 0 $
        $ R_(A y) = #qty[-15.0][N] $

    ],
    image("./images/helical-gear-forces-example-5.png"),
)

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Horizontal $x$-$z$ equilibrium to determine $R_(B z)$ and $R_(A z)$:
        $ sum M "about" A = 0 $
        $ 250 R_(B z) + 325 W_t = 0 $
        $ R_(B z) = #qty[248][N] $

        $ sum F_y = 0 $
        $ R_(A z) + R_(B z) + W_t = 0 $
        $ R_(A z) - 248 + 191 = 0 $
        $ R_(A z) = #qty[57][N] $
    ],
    image("./images/helical-gear-forces-example-6.png"),
)

#pagebreak()

=== Countering high axial or thrust loads
- When the thrust loads become high, it may be desirable to use double-helical
    gears.
- A double-helical gear, also known as a herringbone, is equivalent to two
    helical gears of the opposite hand, mounted side by side on the same shaft.
- They develop opposite thrust reactions and thus cancel out the thrust load.

#cimage("./images/helical-gear-forces-herringbone.png")

=== Minimising axial load on the counter shaft
When two or more single helical gears are mounted on the same shaft, the hand of
the gears should be selected to produce the *minimum thrust load* on the
countershaft, as shown in the figure below.

#cimage("./images/helical-gear-forces-minimising-axial-load.png")
#pagebreak()

=== Summary
- Spur and helical gears:
    - Pitch diameter:
        $ D = m N space (#unit[mm]) $
    - Outside diameter:
        $ D_o = D + 2a = m (N + 2) $
    - Centre distance:
        $ C = frac(D_G + D_P, 2) = frac((N_G + N_P) m, 2) $
    - Tip to tip dimension:
        $ D_G + D_P + 2a = m (N_G + N_P + 2) $
    - *Module for helical gears*:
        $ m = frac(m_n, cos psi) $
- Speed ratio:
    $
        S R & = frac("Input speed", "Output speed") \
            & = frac(
                  "Product of the number of teeth on driven gears",
                  "Product of the number of teeth on driver gears"
              ) \
            & = S R_1 S R_2 S R_3 ... S R_n
    $
- Spur gear forces:
    $ W_t = frac(T, D/2), quad W_r = W_t tan phi.alt $
    - The direction of $W_t$ can be derived from the rotation of the *driven*
        gear.
    - $W_r$ always acts towards the centre of the gear.
- Helical gear forces:

    For the parallel shaft arrangement, the helix angle is the same on each
    gear, but one gear must have a right-handed helix, and the other a
    left-handed helix.

    $
        W_t = frac(T, D/2), quad W_r = W_t tan phi.alt_t,
        quad tan phi.alt_t = frac(tan phi.alt_n, cos psi)
    $
    $ W_a = W_t tan psi $
    - The direction of $W_t$ and $W_r$ is the same as in spur gears.
    - Use the right-hand thumb rule for right-handed *driver* gear, and the
        left-hand thumb rule for left-handed *driver* gear to obtain the
        direction of $W_a$.

#pagebreak()

== Bevel gears
- Bevel gears are used to transfer motion between non-parallel shafts, usually
    at $90 degree$ to one another.
- The surface that bevel gear teeth are machined on is a part of a cone.
- The difference between bevel gears are in the specific shape of the teeth and
    in the orientation of the pinion relative to the gear.

#cimage("./images/bevel-gear.png")

=== Straight tooth bevel gears
- Simplest and most economical bevel gear type.
- Teeth are cut straight, parallel to the cone axis, like spur gears.
- Teeth have a taper and would intersect each other at the axis.
- Although bevel gears are usually made for a shaft angle of $90 degree$, they
    may be produced for almost any other angle.
- Straight bevel gears, like spur gears, are well suited for low speed
    applications.
- When greater speed and more power are required, spiral and hypoid gears are
    preferable.

#cimage("./images/bevel-gear-straight-tooth.png")
#pagebreak()

=== Spiral bevel gears
- The teeth are cut at a spiral angle to the cone axis, analogous to helical
    gears.
- They are often used for applications that involve large speed reduction and
    require smooth and quiet operation.

#cimage("./images/bevel-gear-spiral.png")

=== Hypoid gears
- Similar in appearance to the spiral bevel gears except for meshing hypoid
    gears, as the shaft centrelines are offset from each other.
- The hypoid gear was developed for the rear axles for automobiles, and enables
    the drive shaft to pass below the level of the car floor. It provides a
    perfectly smooth drive and produces almost no noise.

#cimage("./images/bevel-gear-hypoid.png")

=== Straight bevel gear geometry
#cimage("./images/bevel-gear-straight-tooth-geometry.png")

- The pitch angles are defined by the pitch cones meeting at the apex. They are
    related to the tooth numbers as follows:
    - For the pinion:
        $ gamma = arctan N_P/ N_G $
    - For the gear:
        $ Gamma = arctan N_G/ N_P $

    $ gamma + Gamma = 90 degree $
- Module:
    $ m = D_P/N_P = D_G/N_G $
- Speed or gear ratio:
    $ S R = N_G/N_P $
- Bevel gears are *non-interchangeable* because tooth form is closely tied to
    the method used for producing the gears, and a different value of addendum
    is used for each gear ratio.
- In practice, the pinion has a long addendum while the gear has a short
    addendum to avoid undercutting.
- Hence, bevel gears are usually made and replaced as matched sets.

== Worms and worm gears
- Worm sets provide the easiest way to obtain large reduction ratios, but can
    have high friction because the worm threads slide sideways along the gear
    teeth.
- When only the worm gear teeth are contoured (throated) to envelope a
    cylindrical worm, the worm set is called *single enveloping*. The contact
    between the threads of the worm and worm gear teeth is along a line.

#cimage("./images/worm-and-worm-gear.png", width: 95%)

- When the worm profile is also throated to envelope the gear, resulting in a
    hourglass-shaped worm. The worm set is called *double-enveloping*.
- This results in area contact rather than line contact, and allows a smaller
    system to transmit a given power at a give reduction ratio.
- However, precise alignment becomes more important.

#cimage("./images/worm-and-worm-gear-double-enveloping.png", width: 95%)

=== General design considerations
- Worms and worm gears can be provided with either *right-handed* or
    *left-handed* threads on the worm and correspondingly designed teeth on the
    worm gear affecting the rotational direction of the worm gear.
- Worms may be manufactured with a single thread or with multiple threads.
- Worms and worm gears are made and replaced as match sets.
- Worm gear sets have the *advantage of very high gear ratios of up to 360:1 in
    a small package* and can carry *very high loads* especially in their single
    or double-enveloping forms.
- One trade-off in any worm set is very high sliding and thrust loads, which
    make the worm set rather inefficient at 40% to 85% efficiency.
    - For small helix angles less than $20 degree$ ($psi < 20 degree$),
        efficiency can be as low as 25%.
    - For helix angles between $20 degree$ and $45 degree$
        ($20 degree <= psi <= 45 degree$), efficiency can be as high as 95%.

=== Materials
- Only a few materials are available for worm sets.
- The worms are highly stressed and are usually made of case-hardened alloy
    steel.
- The worm gear needs to be made from a material soft and compliant enough to
    confirm to the hard worm under the high sliding conditions. It is
    customarily made of one of the bronzes (phosphor, tin or manganese).

=== Number of threads in worms ($N_w$)
- Single thread as in a typical screw or multiple threads.
- $N_w$ is approximately the number of threads. Treat it as if it is the number
    of teeth.
- It is also known as the number of starts, as by looking at the end of a worm,
    one can count the number of threads that start at the end.

#cimage("./images/worm-and-worm-gear-number-of-threads.png")

==== Effect on the rotation of the worm gear
The basic difference between single and double-threaded worms is that for one
revolution, the *double-threaded* worm will turn its mating gear an *angle
twice* that of the single-threaded worm.

#cimage("./images/worm-and-worm-gear-number-of-threads-on-rotation.png")
#pagebreak()

=== Speed ratio
- Pitch line speed ($v_t$):
    - Worm:
        $ v_(t W) = frac(pi D_W eta_W, 60) space (#unit[m s^-1]) $
    - Worm gear:
        $ v_(t G) = frac(pi D_G eta_G, 60) space (#unit[m s^-1]) $

    $ v_(t W) != v_(t G) $

    The velocity vectors are not in the same plane

#cimage("./images/worm-and-worm-gear-speed-ratio.png")

- Speed or gear ratio:
    $ S R = frac("Speed of worm", "Speed of gear") $
    $ S R = eta_W/eta_G = N_G/N_W $

#pagebreak()

=== Direction of rotation
<worm-gear-rotation-direction>
The direction depends on the direction of rotation of the *worm* and whether it
is left or right-handed.

#cimage("./images/worm-and-worm-gear-rotation-direction.png")

=== Back-driving
- A spur, helical or bevel gear set can be driven from either shaft, as a
    setup-up or step-down device.
    #cimage("./images/worm-and-worm-gear-back-driving.png")
- While this may be desirable in many cases, if the load being driven must be
    held in place after the power is shut off, the spur or helical gear set will
    not do as they will back-drive.
- This makes them unsuitable for applications such as a jack to raise a car,
    unless a brake is added to the design to hold the load.

#pagebreak()

==== Self-locking
- A worm set can be designed to be impossible to back-drive.
- This way, the worm set can only be driven from the worm.
- Thanks to the low helix angle of the worm, the worm gear cannot drive the
    worm.
- This is a self-locking feature that is usually desirable.
- The locking action is produced by the friction force between the worm threads
    and the worm gear teeth.
- Worm sets can thus be used without a brake in load-holding applications such
    as jacks and hoists.

#cimage("./images/worm-and-worm-gear-self-locking.png")

=== Applications
#cimage("./images/worm-and-worm-gear-applications.png")

== Complex gear trains
- The concept of gear trains for spur gears can be extended to include a wide
    variety of gear types, higher reduction ratios and different arrangements of
    gears.
- The following example illustrates the computation of train value for a system
    with different gear sets.

The figure shows a gear train containing bevel gears, spur gears and worm sets.
The input is at the bevel pinion, $N_2$ and the output is at the worm gear,
$N_7$.

Determine the train value of the gear train and the direction of rotation of the
worm gear.

=== Direction of rotation
Align the figure for the #link(<worm-gear-rotation-direction>)[worm gear's
    direction of rotation] with the actual layout and note the direction of
rotation of the worm.
#cimage("./images/complex-gear-train-rotation-direction.png")

=== Train speed ratio
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        $ "Train" S R = S R_1 S R_2 S R_3 $
        $ S R_1 = N_3/N_2 = 32/16 $
        $ S R_2 = N_5/N_4 = 40/20 $
        $ S R_3 = N_7/N_6 = 40/2 $
        $
            therefore "Train" S R & = S R_1 S R_2 S R_3 \
                                  & = 80
        $
    ],
    image("./images/complex-gear-train-speed-ratio.png"),
)

#pagebreak()

=== Summary of bevel and worm gears
- Bevel gear:
    $
        S R & = frac("Input speed", "Output speed") \
            & = frac(
                  "Number of teeth in driven gears",
                  "Number of teeth in driving gears"
              )
    $
- Worm and worm gear
    $
        S R & = frac("Speed of worm", "Speed of gear") \
            & = N_G/N_W
    $

    Direction of rotation is shown in the figure below:
    #cimage("./images/worm-and-worm-gear-rotation-direction.png")

#pagebreak()

= Design against failure
- Design for reliability involves many considerations as machine parts
    malfunction in many different modes.
- Failure does not necessarily mean that a part breaks, it just means that it no
    longer functions as intended.
    - A gear may fail when a tooth breaks off, but more commonly a gear fails
        due to excessive wear.
    - Wear, in turn, may be the cause of intolerable noise levels, damaging
        vibration, or the loss of lubricants.
- Experienced designers consider all possibilities by considering:
    - How can this part fail?
    - Which modes of failure are most likely to occur?
    - How can I design against these modes?
- In general, all possible modes of failure must be considered, like stress,
    deformation, wear, corrosion, vibration, environmental damage, loosening of
    fastening devices, etc.
- As a basis of our initial designs, we will only consider it necessary to
    satisfy the criteria of *strength, rigidity and kinematic functioning*.
- However, bear in mind that there are some other considerations such as
    *tribology (friction, wear and lubrication), cost and space requirements*.
- The following steps are necessary considerations in the analysis of a machine
    design problem:
    - A kinematic analysis to establish the necessary motion requirements.
    - A force analysis to establish the magnitude of the acting forces and
        moments.
    - A strength and rigidity analysis to establish the basic dimensions of
        machine members.

#pagebreak()

== Forces
- The analysis of forces and force action is vital to good design.
- Apply well known *equilibrium conditions*:
    $ sum F_v = 0 wide sum F_h = 0 $
    $ sum M = 0 $
    $ sum T = 0 $
- This applies to forces, moments and torques which act on a *body*. The forces
    come from some source external to the body under consideration.
- Forces can frequently be quite difficult to define in distribution and even in
    magnitude.
- Assume that forces are accurately known in magnitude, and they will have a
    uniform distribution over the areas of application:
    - Uniform load per unit length.
    - Point load, if the length $L$ of the distributed load is small compared to
        the length of the member.
- A line, which is usually the axis of the members, is used to represent the
    body, and it forms the modified or idealised structure, which removes all
    complication with body shape and changes in section, and produces a simple
    diagram.

    #cimage("./images/modified-structures.png")
- Most machine member loads are contact forces, which arise from power and
    transmission, which are the primary function of machines.
- Machine parts regularly sustain complex loadings. The static equilibrium
    methods usually allow problems to be reduced to a simple set of basic loads,
    and then convert the basic loads to stress.

#pagebreak()

- Basic loads are the resultant axial, bending and shear loads, like tension,
    compression, buckling, direct shear, torsional shear, bending and friction.

    #cimage("./images/basic-loads.png")
- The loads may either be static or cyclic.
- Static loading is assumed to be applied slowly, without shock, and is held at
    a constant value.
- Static loading can also be assumed when a load is applied slowly and is
    removed slowly and reapplied, if the number of load applications is small,
    i.e., under a few thousand cycles of loading.

#pagebreak()

== Stresses
- Induced stresses corresponding to basic loads:
    #table(
        columns: 2,
        table.header([*Type of loading*], [*Basic induced stresses*]),

        [Tension or compression], $ sigma = F/A $,
        [Bearing pressure], $ sigma = F/A $,
        [Bending], $ sigma = frac(M c, I) = M/Z $,
        [Torsion], $ tau = frac(T r, J) = T/Z_p $,
        [Direct shear], $ tau = F/A $,
    )
- Stresses in machine components, like the shaft in particular, are often a
    combination of *normal stress (axial or bending)* and *shear stress (direct
    or torsional)*, where the shear stress acts on the same cross-section as the
    normal stress.

    #cimage("./images/stresses-on-an-element.png")

    #let stress-formulas = [
        $
            "Maximum principal stress:" sigma_"max" =
            frac(sigma_x + sigma_y, 2) + sqrt(
                (frac(sigma_x^2 - sigma_y^2, 2))^2 + tau_(x y)^2
            )
        $

        $
            "Minimum principal stress:" sigma_"min"
            = frac(sigma_x + sigma_y, 2) - sqrt(
                (frac(sigma_x^2 - sigma_y^2, 2))^2 + tau_(x y)^2
            )
        $

        $
            "Maximum shear stress:" tau_"max"
            = sqrt((frac(sigma_x^2 - sigma_y^2, 2))^2 + tau_(x y)^2)
        $

        $
            "von mises stress:" & sigma' =
            sqrt(sigma_"max"^2 + sigma_"min"^2 - sigma_"max" sigma_"min") \
            & sigma'
            = sqrt(sigma_x^2 + sigma_y^2 - sigma_x sigma_y + 3 tau_(x y)^2)
        $
    ]

    #stress-formulas <stress-formulas>

== Force analysis
- The following steps are necessary consideration in the analysis of a machine
    design problem:
    - A kinematic analysis to establish the necessary motion requirements.
    - A force analysis to establish the magnitude of the acting forces and
        moments.
    - A strength and rigidity analysis to establish the basic dimensions of
        machine members.
- For force analysis, use the equilibrium conditions in force analysis:
    $ sum F_v = sum F_h = sum M = sum T = 0 $
- Create idealised mechanics models from actual systems for analysis.
- Use the equilibrium methods of statics to reduce problem sot a simple set of
    basic loads.
- Use the well-known #link(<stress-formulas>)[stress formulas] above to convert
    the basic loads to stress.
- The basic formulae for stress assume that there are no irregularities in the
    shape of the part undergoing load.
- However, it is impossible to design a machine without allowing discontinuities
    in the contour of the part.
- The following are a few examples where changes in contour are necessary:
    - Shaft with shoulders to accommodate the seating of bearings.
        #cimage("./images/shaft-with-shoulders.png", height: 10em)
    - Key ways and key seats in shafts to secure pulleys, cams, and gears.
        #cimage("./images/key-ways-and-key-seats-in-shafts.png", height: 15em)
    - Grooves in shaft for retaining rings.
        #cimage(
            "./images/grooves-in-shaft-for-retaining-ring.png",
            height: 10em,
        )

#pagebreak()

== Geometric discontinuities and stresses
- Geometric discontinuities will cause the actual maximum stress in the part to
    be higher than what the basic formulae predict.
- A stress concentration factor (SCF) $K$ is defined as the maximum actual
    stress divided by the nominal stress predicted from the basic equations.
    $ K = sigma_"max"/sigma_"nom" quad "or" quad K = tau_"max"/tau_"nom" $
- The value of $K$ depends on the shape of the continuity, the specific
    geometry, and the type of stress.
- Stress concentration factors have been experimentally determined and charts
    for them can be found in reference books, such as _R.L. Mott and Stress
    Concentration Factors by R.E. Peterson_.

#cimage("./images/stress-concentration-factors.png")

- The study of stress concentration is a highly complex subject. The stress
    concentration factor depends not only on the geometry of the part, but also
    depends on whether the material is ductile or brittle.
- Stress concentration is primarily a localised effect, which means the maximum
    stress occurs only in a small region in the vicinity of the stress raiser.
    Hence, for a *ductile* material experiencing a *static load*, the *material
    will yield locally*. Therefore, the effect of the stress concentration is
    minimised.
- However, for a *ductile* material undergoing *fluctuating stresses*, the *full
    value* of the stress concentration factor should be applied when performing
    a stress analysis of a given machine member.
- We should reduce the stress concentration wherever possible without regard to
    the class of material of which the member is made.

#pagebreak()

=== Example
A rectangular bar containing a hole and subjected to a tensile force of
#qty[40][kN]. The bar has the dimensions, $t = #qty[50][mm]$, $w = #qty[35][mm]$
and the hole diameter, d is #qty[12][mm].
+ Find the tensile stress at a no-hole section.
+ Find the average stress at the hole section, assuming no stress concentration.
+ Find the maximum stress at the hole section taking into account the stress
    concentration.

#cimage("./images/stress-concentration-factors-example.png")

=== Part 1
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        At the no-hole section:
        $
            sigma_(a v) = frac(P, t w)
            = frac(40 times 10^3, 50(35)) = #qty[22.85][N mm^-2]
        $
    ],
    image("./images/stress-concentration-factors-example-1.png"),
)

=== Part 2
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        At the hole section:
        $
            sigma_(a v) = frac(P, t (w - d))
            = frac(40 times 10^3, 50(35 - 12)) = #qty[34.28][N mm^-2]
        $
    ],
    image("./images/stress-concentration-factors-example-2.png"),
)

#pagebreak()

=== Part 3
At the hole section with stress concentration factor:

#cimage("./images/stress-concentration-factors-example-3.png")

From the stress concentration factor chart, curve $A$,
$ d/w = 12/35 = 0.34, quad K = 2.35 $
$
    sigma_"max" & = K sigma_"av" \
                & = K frac(P, t (w - d)) \
                & = 2.35 times 34.28 = #qty[81.73][N mm^-2]
$

#pagebreak()

== Mechanical failure
- Any change in size, shape, or material properties of a machine or machine part
    that renders it incapable of performing its intended function must be
    regarded as a mechanical failure.
- *Improper functioning* of a machine or machine part constitutes *failure*.
    #grid(
        columns: 2,
        column-gutter: 2em,
        [
            - A shear pin that does not separate into two or more pieces upon
                the application of a preselected overload is regarded as having
                failed. The *shear pin* is supposed to act like a fuse, and is
                meant to *break* if the system is over stressed.
            - A drive shaft fails if it does separate into two or more pieces
                under expected normal operating loads.
        ],
        image("./images/shear-pin-diagram.png"),
    )

#pagebreak()

=== Failure types

#cimage("./images/failure-due-to-various-types-of-forces.png")

- *Lack of strength (rupture and surface destruction)*

    Strength is the ability to resist loads (forces, bending moments, torques),
    and is expressed in terms of ultimate strength, yield strength, and fatigue
    strength.

- *Lack of rigidity (excess elastic deflection)*

    Rigidity is the ability to resist the change of form. In machinery, it
    ensures accuracy and precision. Lack of rigidity leads to interference
    between parts and premature failure due to wear and fatigue.

- *Lack of stability (buckling or overturning)*

    Stability or steadiness is the ability of a part to resist displacement,
    and, if displaced, the ability to develop forces and moments that tend to
    restore the original condition. As a design criterion, stability relates
    primarily to machine column, structs, or pushrods. These component members
    can all fail in buckling, characterised by excess transverse deflection or
    collapse.

    #cimage("./images/failure-due-to-buckling.png", width: 80%)

- *Wear (removal of vital surface material)*

    Wear is the gradual, unintentional abrading of surfaces in contact as a
    result of relative motion between them.

    #cimage("./images/failure-due-to-wear.png", width: 80%)

#pagebreak()

=== Failure modes
- The selection of appropriate design or failure-prevention criteria is a major
    decision, and is largely influenced by the mode of failure of the machine
    member.
- For safety and economy, machine members are often designed to *fail in one
    mode in preference to another*. For example:
    - Bolts are designed to fail in tension, not in shear.
    - Roller chains are designed to wear out instead of fail in tension, as such
        failure can have catastrophic consequences.

== Allowable stress
- Determine the maximum induced or operating stress for a machine member.
- Select a suitable material based partly upon its mechanical properties so that
    the maximum induced stress in the machine member is less than the allowable
    stress.
- To provide a margin against failure, it is common to determine the *allowable
    stress*, also known as *design stress*, by dividing the material strength by
    a factor of safety, $N$.
- Machine elements are very often made from metals or metal alloys, such as
    steel, aluminium, cast iron, zinc, titanium, or bronze.
- Steel is possibly the most widely used material for machine elements due to
    its high strength, stiffness, durability and relative ease of fabrication.
- For design, the principal consideration is the allowable stress, which is a
    fraction of the material strength.
- The material strength represents either the *static* or *dynamic* properties.
    - Static loading:
        $ "Material strength" = "Yield strength," s_y $
    - Fatigue loading:
        $ "Material strength" = "Endurance strength," S_e $

#pagebreak()

=== Safety factor ($N$)
- Engineers use a safety factor to ensure against uncertain or unknown
    conditions.
- Safety factors are sometimes prescribed by code, but usually they are rooted
    in design experience.
    - Design engineers have established through a product's performance that a
        safety factor is sufficient or insufficient.
    - Future designs are often based on safety factors found adequate in
        previous products for similar applications.
- In deciding a factor of safety, the designer must take into account the
    consequences of failure, such as danger to humans and high costs of repair.
- Factor of safety is an *ignorance factor* that compensates for various
    unknowns, such as:
    - Exact type and magnitude of all loads.
    - Material property variations.
    - Extremes of environmental conditions, such as heat and moisture.
    - Approximate stress analysis formulae.
    - Residual stresses produced during manufacturing.
- Safety factor is always greater than 1, and are usually chosen to have values
    that lie in the range of 1.15 to about 4 or 5, depending on the particular
    details of the application.
- Numerical values of factor of safety vary with the product and the industry.
- The safety factor values below are intended to be used with the yield strength
    $S_y$ of the endurance strength $S_e$.
    + $n = 1.25 "to" 1.5$ for exceptionally reliable materials, used under
        controllable conditions and subjected to loads and stresses that can be
        determined with certainty. Used almost invariable where low weight is a
        particularly important consideration.
    + $n = 1.5 "to" 2$ for well-known materials under reasonably constant
        environmental conditions, subjected to loads and stresses that can be
        determined readily.
    + $n = 2 "to" 2.5$ for average materials operated in ordinary environments
        and subjected to load and stresses that can be determined.
    + $n = 3 "to" 4$ for untried materials and under average conditions of
        environment, load, and stress. It is also for better known materials
        that are used in uncertain environments or subjected to uncertain
        stresses.

== Prediction of failure
- There are methods of predicting failure that have found high level of use.
- The failure prediction method to determine the maximum induced stress
    includes:
    - Yield strength
    - Maximum shear (Tresca criterion)
    - Distortion energy (von Mises criterion)
- Stress concentration can normally be neglected for static stresses on ductile
    materials.
- Applying to the design using the factor of safety, $N$:
    $ "Max induced" sigma < sigma_"allowable", wide sigma_"allowable" = S_y/N $
- Even though machine parts fail in different modes, design against failure
    involves the same principal considerations in design for strength.
- It is a comparison of *induced or operating* conditions with *allowable
    conditions*.
    - Strength: Maximum induced stress #sym.lt.eq allowable or design stress.
    - Rigidity: Maximum operating deflection #sym.lt.eq allowable elastic
        deflection
    - Stability: Maximum load #sym.lt.eq safe load
    - Wear: Maximum wear #sym.lt.eq permissible wear

#pagebreak()

== Rigidity
- Rigidity is the ability to resist deformation.
- Many situations are encountered in practice where excessive deflection of
    machine members prevents the machine from functioning properly.
    - A shaft that had sufficient strength to support gears but lack the
        necessary stiffness. The gears mounted on the shaft were not held in
        alignment, and the failure of the gears was the result. This shaft
        should be considered to have failed as completely as though it had been
        broken.
    - Lack of necessary stiffness may also cause failure of bearings or other
        parts because of excessive vibration of the shaft.
- Rigidity is a design criterion when:
    - A machine member is long relative to its width, depth or diameter.
    - When great stiffness is required, like in machine frames.
- Design for rigidity is based on allowable deflections.
    - The allowable deflections are certain limits that are governed by
        clearance between moving parts, failure of bearings, environment,
        excessive vibration, or improper operation of the machine.
    - Therefore, design calculations are made to determine a size of the member
        such that the deflection limit is not exceeded.
- Separating gear force $W$ causes the shaft, supported on bearings, to deflect.
    #grid(
        columns: 2,
        column-gutter: 3em,
        [
            #cimage("./images/shaft-deflection.png")

            The well-known maximum deflection at the centre is:
            $ sigma_"max" = frac(W L^3, 48 E I) $

            The allowable elastic deflection is $sigma_"allowable"$.

            Then, $sigma_"max" <= sigma_"allowable"$.
        ],
        image("./images/shaft-deflection-gear.png"),
    )

=== Example
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        Gears A and B are in mesh and supported on bearings as shown in the
        figure. Gear forces, developed in transmitting power, act on the shafts
        to cause bending and tend to separate the two gears. The separating
        force between the gears is #qty[1.0][kN]. Gear A pushes downward on gear
        B, and the reaction force of Gear B pushes up on Gear A. Shaft 1 has a
        diameter of #qty[15][mm] and Shaft 2 has a diameter of #qty[25][mm]. For
        good gear performance, the net deflection of one gear relative to the
        other should not exceed #qty[0.13][mm]. Use $E = #qty[207][GPa]$.

        + Calculate the relative deflection between gears A and B.
        + Does the deflection of the gears satisfy the gear performance
            guidelines? How could you improve it?
    ],
    image("./images/rigidity-example-1.png"),
)

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        $ d_A = #qty[15][mm], quad d_B = #qty[25][mm], L = #qty[150][mm] $
        $ E = #qty[207][N mm^-2] $

        $ sigma_"max" = frac(W L^3, 48 E I) wide I = frac(pi d^4, 64) $

        $ sigma_A = 0.136 "upwards" $
        $ sigma_B = 0.0177 "downwards" $

        Relative deflection of gear $A$ to gear $B$:
        $
            sigma_(A B) & = sigma_A - (- sigma_B) \
                        & = 0.136 - (-0.0177) \
                        & = #qty[0.1537][mm]
        $

        Rigidity requirement:
        $ sigma_(A B) <= sigma_"allowance", quad sigma_"allowance" = 0.13 $

        Since the actual $sigma_(A B) > sigma_"allowance"$, it does not satisfy
        good gear performance guidelines.
    ],
    image("./images/rigidity-example-2.png"),
)

== Failure by compression
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        - Short compressive members subjected to centrally applied loads may be
            analysed or designed on the basis of direct compression. Failure is
            by crushing or yielding.
        - If the member has a length greater than 4 to 6 times the least
            dimension perpendicular to its axis:
            - It is classified as a column or strut.
            - Failure may be caused by instability or buckling rather than
                crushing the material.
        - Failure is the collapse of the column at the point of buckling when a
            radical deflection of the axis of the column occurs suddenly.
        - This kind of catastrophic failure must be avoided in structures and
            machine elements.
    ],
    image("./images/short-and-long-columns.png", height: 65%),
)

- Machine columns, unlike those of civil engineering, are not necessarily
    vertical or stationary.
- Machine columns are the familiar links encountered in kinematics as the
    coupler of 4-bar linkages or the connecting rod of slider cranks as shown.
- They are widely used as they will transmit large compressive stress while
    using minimal amounts of space.
- Since they are weaker in compression, the size is based on buckling.

#cimage("./images/4-bar-linkage-and-slider-crank.png")

=== Column instability
#figure(
    image("./images/column-instability.png", height: 25em),
    caption: [
        The figure shows the modes of failure of compression members transiting
        from low to high slenderness ratio ($frac(K L, r)$), i.e. from short to
        long column.
    ],
)

- The Euler formula for the *buckling load*, or the *critical load*, of a long
    column is derived on the assumption that the column bows sideways while the
    stresses are within the elastic limit. This type of failure is the result of
    *elastic instability*.
- If the column is of less slender proportions, the maximum stress may reach the
    yield point before sideways bowing occurs, hence the Euler formula does not
    predict the critical load. This type of failure is the result of *plastic
    instability*. A formula based on test results for columns of this type is
    the J.B Johnson formula.

Euler formula:
$ P_"cr" = frac(pi^2 E I, (K L)^2) $

J.B. Johnson formula:
$ P_"cr" = A s_y [1 - frac(s_y (frac(K L, r))^2, 4 pi^2 E)] $

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    [
        Where:
        - $P_"cr"$ is the critical load causing failure
        - $L$ is the length of the column
        - $E$ is the modulus of elasticity of the material
        - $I$ is the least moment of inertia of area
        - $r$ is the least radius of gyration of the cross-section
        - $A$ is the cross-sectional area
        - $K$ is the end-fixity coefficient
    ],
    figure(
        image("./images/least-moment-of-inertia.png", height: 10em),
        caption: [
            $I_(x x) < I_(y y)$, so $I_(x x)$ is the *least*.
        ],
    ),
)

#pagebreak()

=== End-fixity coefficient ($K$)
#cimage("./images/end-fixity-coefficients.png")

=== Factor of safety ($N$)
- Because failure is predicted to occur at a limiting load, rather than a
    stress, the concept of the factor of safety is applied differently.
- Rather than applying the factor of safety to the yield strength of ultimate
    strength of the material, it is applied to the critical load.
- Applying the factor of safety ($N$) to the design:
    $ "Allowable load," P_"allowable" = P_"cr"/N $
    $ "Applied load," P < P_"allowable" $
- When the minimum weight is important and the conditions of loading and quality
    of material are accurately known, a factor of safety as low as 1.25 may be
    used. In usual applications, a value of 2 to 3, or even 4, may be suitable.

#pagebreak()

=== Example
Determine the allowable load on a steel column having a rectangular
cross-section, #qty[12][mm] by #qty[18][mm], and a length of #qty[280][mm]. It
is proposed to use AISI 1040 hot-rolled steel which has $E = #qty[207][GPa]$ and
$S_y = #qty[290][MPa]$. The lower end of the column is inserted into a
close-fitting socket and is welded securely. The upper end is pinned as shown in
the figure below. You may use a factor of safety of 3 to compute the allowable
load based on the Euler buckling formula.
#cimage("./images/failure-due-to-compression-example-1.png", height: 15em)

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        Euler critical load:
        $ P_"cr" = frac(pi^2 E I, (K L)^2) $

        $ E = #qty[207][GPa] $
        $ L = #qty[280][mm] $

        Moment of inertia of area, $I$, must be computed about the axis that
        gives the least value, which is the $Y$-$Y$ axis. Hence, least $I$:
        $
            I_(Y Y) = frac(b d^3, 12) = frac(18 times 12^3, 12)
            = #qty[2592][mm^4]
        $

        To find $K$, determine the support conditions of the column. The bottom
        of the column is fixed, while the top is pinned.

        From the end-fixity coefficient figure:
        $ "End-fixity coefficient," K = 0.7 $
        $
            P_"cr" & = frac(pi^2 (207 times 10^3) (2592), (0.7 times 280)^2) \
                   & = 137.8 times 10^3 #unit[N]
        $

        $ "Allowable" P = frac(P_"cr", N) = frac(137.8, 3) = #qty[45.9][kN] $
    ],
    image("./images/failure-due-to-compression-example-2.png"),
)

==== Possible modes of failure
Which mode will this column fail under the compressive load?
- Elastic instability (Euler buckling formula)?
- Crushing by yielding?
- Plastic instability (JB Johnson buckling formula)?

Hence, we need to determine the critical load to fail the column, $P_"cr"$. Then
the allowable load is $P_"allowable" = P_"cr"/N$.

*Yield criterion*:
$
    P_"cr" = S_y times "Area"
    = 290 times (12 times 18) = 62.64 times 10^3 #unit[N]
$
$ P_"allowable" = P_"cr"/N = 62.64/3 = #qty[20.9][kN] $

*J.B. Johnson formula*:
$ A = "Cross-sectional area" $
$
    r & = "Least radius of gyration of cross section" \
      & = sqrt(frac(I_(y y), A)) = sqrt(frac(2592, 12 times 18))
        = #qty[3.46][mm]
$

$ P_"cr" = 55.5 times 10^3 #unit[m] $
$ P_"allowable" = P_"cr"/N = 55.5/3 = #qty[18.5][kN] $

- Euler: $P_"allowable" = #qty[45.9][kN]$
- Yield: $P_"allowable" = #qty[20.9][kN]$
- J.B. Johnson: $P_"allowable" = #qty[18.5][kN]$

Hence, the allowable load on the column is #qty[18.5][kN].

#pagebreak()

== Summary

=== Stresses
- $"Allowable stress" = "Material strength"/N$
- The *material strength* represents either the static or dynamic properties.
    For a ductile material like steel:
    - Static loading:
        $ "Material strength" = "Yield strength," S_y $
    - Fatigue loading:
        $ "Material strength" = "Endurance strength or limit" S_n $
    - Use of the factor of safety, $N$, to ensure against uncertain or unknown
        conditions.
- Determine the maximum induced stress in a machine member using the various
    failure prediction methods, such as distortion energy method, and the
    maximum shear stress method.
- Ensure that the maximum induced stress #sym.lt allowable stress.

=== Rigidity
- Rigidity becomes a design criteria when:
    - A machine member is long relative to its width, depth or diameter.
    - When great stiffness is required, like in machine frames.
- Design is based on allowable deflections.

=== Stability
The critical load depends on the slender proportions of columns.
- If the column is long, the failure is predicted by the Euler formula:
    $ P_"cr" = frac(pi^2 E I, (K L)^2) $
- If the column is less slender, it is predicted by the J.B. Johnson formula:
    $ P_"cr" = A s_y [1 - frac(s_y (frac(K L, r))^2, 4 pi^2 E)] $
- If the column is short, it fails by yielding:
    $ P_"cr" = sigma_"yield" A $

#pagebreak()

=== Wear
- Wear is the gradual, unintentional abrading of surfaces in contact as a result
    of relative motion between them.
- Under its influence, useful life will always be reduced.
- Wear can cause imbalance and subsequent vibration of rotating parts.
- There are no satisfactory laws of wear, only rules of thumb. These are:
    + Wear increases with time of running.
    + With hard surfaces, the wear is less than with softer surfaces.
    + Below a certain load, wear is low. Above this load, it rises
        catastrophically to values that may be 1000 to 10,000 times greater.
        This holds true for both clean and lubricated surfaces.
- Design criteria for wear involve consideration of the following:
    - Type of surface material (ductile or brittle).
    - Contact pressure.
    - Type of contact such as sliding or rolling.
    - Size of abrasive particles.
    - Environment (moisture content of atmosphere).
    - Corrosive situations.
    - Velocity.
    - Temperature.
    - Conditions of lubrication.

Methods to combat wear:
+ *Specifying hard surfaces*

    Carburising, carbonitriding and induction hardening are used to combat wear.
    For example, tungsten carbide can be used as inserts.

+ *Replacement*

    The most effective means of limiting the adverse effects of wear is to
    design for easy and inexpensive replacements for vital machine members,
    notably bearings.

+ *Dissimilar materials*

    Perhaps the most basic rule for reducing wear is to specify dissimilar
    materials for parts in sliding contact.

    Steel does not run well with steel, but it is an excellent match for cast
    gray iron, bronze, brass, or plastics.

+ *Compensation*

    Adjustment and take up provision for automatic compensation of wear is
    another effective method of fighting the adverse effect of wear. An example
    is spring-loaded idlers.

+ *Metallising*

    Base metal sprayed with paper thin metal coating that combines hardness with
    microscopic surface porosity, providing an excellent bearing surface that
    retain lubricants and is far more wear resistant.

+ *Lubrication and greases*

#pagebreak()

= Shafts
- A shaft is a rotating machine component that transmits power.
- It is an integral part of any mechanical system in which power is transmitted
    from a prime mover, such as an electric motor or an engine, to other
    rotating parts of the system.
- Examples include: gear-type speed reducers, belt drives, chain drives,
    conveyors, pumps, fans agitators, etc.

== Design considerations
- How are the gears and other components located?
- How is power transmitted from the gears to the shaft?
- What forces and torque are transmitted in the shaft?
- What are the minimum acceptable diameters for the shaft to ensure safe
    operation?
- What would be the final diameter of the shaft after considering dimensional
    specifications, tolerances and matching elements?
- What is the material and the size (diameter) of the shaft?
- Why not a shaft with a constant diameter throughout?
    - The strength and rigidity requirement is different at various points of
        the shaft.

=== Examples
Shaft design is to determine the minimum diameters required at different points.
#cimage("./images/shaft-design-example-1.png", width: 90%)
#cimage("./images/shaft-design-example-2.png")

== Objectives
- *Propose* reasonable geometries and supports for shafts to carry various types
    of power-transmitting elements, such as gears, belts, or chains.
- *Apply* the shaft design procedure to determine diameters of the shaft at key
    points.
    - Design equation for strength is used to resist the combination of
        torsional stress and bending stress (ANSI/ASME B106.1M - 1985).
- *Specify* reasonable final shaft dimensions for each point of the shaft that
    satisfies the strength requirements and the dimensions and installation
    considerations to be compatible with the elements mounted on the shaft.

#cimage("./images/shaft-design-objectives.png")

== Basic shaft design
Basic shaft design equation using the *maximum shear stress theory* without the
correction factors associated with engineering design.
$ D = [frac(32 N, pi) sqrt((frac(M, s_y))^2 (frac(T, s_y))^2)]^(1/3) $
$ D^3 = frac(32 N, pi) sqrt((frac(M, s_y))^2 + (frac(T, s_y))^2) $
$ therefore s_y = frac(32 N, pi D^3) sqrt(M^2 + T^2) $

#pagebreak()

=== Maximum shear stress theory (Tresca yield criteria)
The equation of principle shear stress can be written as:
$ tau_"max" = sqrt((sigma/2)^2 + tau^2) $

As $sigma = frac(32 M, pi D^3)$ and $tau = frac(16 T, pi D^3)$:

We have:
$ tau_"max" = sqrt((frac(16 M, pi D^3))^2 + (frac(16 T, pi D^3))^2) $
$ tau_"max" = frac(16, pi D^3) sqrt(M^2 + T^2) $

According to maximum shear stress theory:
$ s_(y s) = 0.5 s_y $

Where:
- $s_(y s)$ is the yield strength under shear stress
- $s_y$ is the principal yield strength under tensile stress

The permissible value of the maximum shear stress is taken as:
$ t_"max" = frac(s_(y s), N) = 0.5 frac(s_y, N) $

Where $N$ is the safety factor.

$
    D^3 = frac(16, pi tau_"max") sqrt(M^2 + T^2)
    = frac(32 N, pi s_y) sqrt(M^2 + T^2)
$

#pagebreak()

==== Example
The shaft of an overhang crank subjected to a force P of #qty[1][kN], as shown
in the figure below. The shaft is made of carbon steel with the tensile yield
strength is #qty[380][N mm^-2]. The factor of safety is 2. Determine the
diameter of the shaft using the maximum shear stress theory.

#cimage("./images/maximum-shear-stress-theory-example.png", height: 20em)

The stresses are critical at point $A$, which is subjected to combined bending
moment and torque. At point A:
$ M = P times 250 = 1000 times 250 = 250 times 10^3 #unit[Nmm] $
$ T = P times 500 = 1000 times 500 = 500 times 10^3 #unit[Nmm] $
$ tau_"max" = frac(16, pi D^3) sqrt(M^2 + T^2) $
$
    tau_"max" = frac(s_(y s), N) = 0.5 frac(s_y, N)
    = frac(0.5(380), 2) = #qty[95][N mm^-2]
$
$ tau_"max" = frac(16, pi D^3) (sqrt(250000^2 + 500000^2)) = #qty[95][N mm^-2] $
$ D = #qty[31.06][mm] $

=== Bending or torsion versus stress
Distortion energy theory (von Mises criteria):
$
    s_y/N = frac(4(8), pi D^3) sqrt(M^2 + 48/64 T^2)
    = frac(32, pi D^3) sqrt(M^2 + 3/4 T^2)
$

The above leads to the *basic equation* for shaft diameter $D$:
$ D^3 = frac(32 N, pi s_y) sqrt(M^2 + 3/4 T^2) $
$ D = (frac(32 N, pi s_y) sqrt(M^2 + 3/4 T^2))^(1/3) $

==== Example
An assembly of belts has tensile forces applied as shown in Figure I, and the
bearings at locations A and B. The yield strength of the shaft material is
#qty[500][MPa] and the safety factor is 2. THe torques are also given. Determine
the minimum allowable shaft diameter. Also, provide a free-body diagram as well
as moment and torque diagrams.

#cimage("./images/bending-torsion-vs-stress-example-figure-i.png")

Steps:
+ Define axes.
+ Compute belt force components.
+ Find support force components by using the loading diagram.
+ Find the moment along the shaft from the moment diagram.
+ Find the torque along the shaft from the torque diagram.

#cimage("./images/bending-torsion-vs-stress-example-diagrams.png")
#pagebreak()

Given a belt driven shaft system:
+ Identify supports and drivers, which are shafts with two bearings and two belt
    drives.
+ Free-body diagram of forces and torques.
+ Loading force diagrams and moment diagrams in $x z$ and $x y$ planes.
+ Torque diagram.

From the moment diagrams, the maximum moment or resultant moment is at point
$C$:
#cimage("./images/bending-torsion-vs-stress-example-moment-diagrams.png")
$ M_"max" = sqrt((118.75)^2 + (37.5)^2) = #qty[124.5][Nm] $

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        From the torque diagram, the maximum torque is #qty[7.5][Nm]. Point $C$
        experiences the highest moment $M$ and torque $T$.

        Using the basic shaft design equation by using the *maximum shear stress
        theory*, the minimum shaft diameter at point $C$ is:
        $
            D & = (frac(32 N, pi s_y) sqrt(M^2 + T^2))^(1/3) \
              & = (frac(32 (2), pi (500 times 10^6)) sqrt(124.5)^2
                    + (7.5)^2)^(1/3) \
              & = #qty[0.017192][m] = #qty[17.2][mm]
        $

        Using the basic shaft design equation by using the *distortion energy
        theory*, the minimum shaft diameter at point $C$ is:
        $
            D & = (frac(32 N, pi s_y) sqrt(M^2 + 3/4 T^2))^(1/3) \
              & = (frac(32 (2), pi (500 times 10^6)) sqrt(124.5)^2
                    + 3/4 (7.5)^2)^(1/3) \
              & = #qty[0.017190][m] = #qty[17.2][mm]
        $

    ],
    image("./images/bending-torsion-vs-stress-example-torque-diagram.png"),
)

Note that the torque is small, so there is not much difference using the maximum
shear stress theory and the distortion energy theory.


== Practical shaft design
ASME shaft design equation for solid circular shafts to obtain the minimum shaft
diameter:
$ D = {frac(32 N, pi) sqrt((frac(K_(f b) M, s_n'))^2 + 3/4 (T/s_y)^2)}^(1/3) $

The practical shaft design equation considers the stress concentration, keyway,
shaft's treatment, etc.

Note that $K_(f b)$ is associated only to $M$.

=== Power equation for torque ($T$)
$ "Torque" = "Power"/"Speed" $
$ P = T omega = F v $
$ T = P/omega $

Where:
- $T$ is the torque (#unit[Nm])
- $P$ is the power (#unit[W] or #unit[Nm s^-1])
- $omega$ is the angular velocity (#unit[rad s^-1])

=== Obtaining the moment ($M$)

==== Spur gears
$ W_t = frac(T, D/2) wide W_r = W_t tan phi.alt $
#cimage("./images/practical-shaft-design-spur-gear.png")

==== Helical gears
$ W_t = frac(T, D/2) wide W_a = W_t tan psi $
$ W_r = W_t frac(tan phi.alt_n, cos psi) $

==== Chain sprockets
$ F_c = frac(T, D/2) $
$ F_(c x) = F_c cos theta $
$ F_(c y) = F_c sin theta $
#cimage("./images/practical-shaft-design-chain-sprockets.png")

==== Belt sheaves
#cimage("./images/practical-shaft-design-belt-sheaves.png")

==== Moment due to force ($F$):
#cimage("./images/bending-torsion-vs-stress-example-moment-due-to-force.png")
#pagebreak()

=== Stress concentration in shafts ($K_(f b)$)
- Shoulders (shaft diameter changes), key seats, ring grooves, and other
    geometric discontinuities in the shaft create stress concentration.
- The nominal stress is multiplied with a *stress concentration factor*
    ($K_(f b)$) to obtain the maximum stress when sizing the final shaft
    diameters.

==== Shoulder fillets
Sharp fillet:
$ K_(f b) = 2.5 $

#cimage(
    "./images/stress-concentration-in-shafts-sharp-fillet.png",
    height: 20em,
)

Well-rounded fillet:
$ K_(f b) = 1.5 $

#cimage(
    "./images/stress-concentration-in-shafts-well-rounded-fillet.png",
    height: 20em,
)

#pagebreak()

==== Retaining ring grooves
$ K_(f b) = 3.0 $

#cimage("./images/stress-concentration-in-shafts-retaining-ring-groove.png")
#pagebreak()

==== Key seat
Profile key seat:
$ K_(f b) = 2.0 $

#cimage("./images/stress-concentration-in-shafts-profile-keyseat.png")

Sled runner key seat:
$ K_(f b) = 1.6 $

#cimage("./images/stress-concentration-in-shafts-sled-runner-keyseat.png")
#pagebreak()

=== Yield strength ($s_y$)
Refer @appendix-3 and @appendix-4.

#cimage("./images/yield-strength-table-form.png", width: 80%)
#cimage("./images/yield-strength-graphical-form.png", width: 80%)

=== Endurance strength ($s_n$)
<endurance-strength>
- Endurance strength depends on the shaft surface condition.
- The design stress is related to the *endurance strength* $s_n$ of the shaft
    material and also the actual conditions under which the shaft is
    manufactured and operated.
- For a polished shaft:
    $ s_n = 0.5 s_u $

    Where $s_u$ is the tensile strength.

The curves show different treatments of the *shaft surface* (polished, machined,
etc).

Figure 5-8:
#cimage("./images/endurance-strength-1.png", width: 90%)
#cimage("./images/endurance-strength-2.png")

If the ultimate strength is higher than the limit of the figure above, which is
#qty[1500][MPa], use the values for $s_u = #qty[1500][MPa]$.

=== Size factor ($C_s$)
The size factor accounts for the stress gradient within the material.

#cimage("./images/size-factor.png")

$C_s = 1.0$ if $D$ is less than #qty[7.62][mm].

If $D$ is unknown, assume $C_s$ first, then iterate later.

=== Reliability factor ($C_R$)
<reliability-factor>

Table 6-1:
#let table-6-1 = table(
    columns: 2,
    table.header([*Desired reliability*], $C_R$),

    [0.50], [1.00],
    [0.90], [0.90],
    [0.99], [0.81],
    [0.999], [0.75],
)

#table-6-1

=== Modified endurance strength ($s_n'$)
The modified endurance strength $s_n'$ is given by:
$ s_n' = s_n C_s C_R $

#pagebreak()

=== Design factor or safety factor ($N$)
- Under typical industrial conditions, a design factor of $N = 3$ is
    recommended.
- If the application is very smooth, a low value of $N = 2$ may be justified.
- Under conditions of critical shock or impact, $N = 4$ or higher should be
    used.

=== Summary
$ D = [frac(32 N, pi) sqrt((frac(K_(f b) M, s_n'))^2 + 3/4 (T/s_y)^2)]^(1/3) $

To use the above equation:
+ Determine the ultimate tensile strength of the material, $s_u$, from the test
    results, supplier specifications, or published data.
    - The most accurate and reliable data available should be used.
    - When there is doubt about the accuracy of the data, a larger than average
        design factor $N$ should be used.
+ Determine the estimated endurance strength, $s_n$, of the material from #link(
        <endurance-strength>,
    )[Figure 5-8].
    - The data in the figure consider the manner in which the shaft is produced,
        in addition to the relationship between the basic endurance strength and
        the ultimate strength.
    - If the ultimate strength is higher than the limit of #link(
            <endurance-strength>,
        )[Figure 5-8], #qty[1500][MPa], use the values for
        $s_u = #qty[1500][MPa]$.
+ Apply a size factor $C_s$ to account for the stress gradient within the
    material and for the probability of a given section having a damaging
    occlusion that can serve as a place for initiation of a fatigue crack. A
    recommendation is given as follows:
    - For diameter $D <= #qty[7.62][mm]$, $C_s = 1.0$
    - For diameters $#qty[7.62][mm] < D <= #qty[50][mm]$,
        $C_s = (D/7.62)^(-0.11)$
    - For diameters $#qty[50][mm] < D <= #qty[250][mm]$,
        $C_s = 0.859 - 0.000837 D$
+ Apply a reliability factor, $C_R$.
    - Endurance strength data are average values over many tests, thus implying
        a reliability of 0.50 (50%).
    - Assuming that the actual failure data to follow a normal distribution, the
        factors from #link(<reliability-factor>)[Table 6.1] can be used to
        adjust for higher levels of reliability.
+ The modified endurance strength is then given by:
    $ s_n' = s_n C_s C_R $
+ For parts of the shaft that is subjected to only reversed bending, let the
    design stress be:
    $ sigma_d = frac(s_n', N) $

#pagebreak()

=== Example 1
Design the shaft shown in figures below. It is to be machined from AISI 1144 OQT
1000 steel (oil-quenched and tempered $1000 degree "F"$). The shaft is part of
the drive for a large blower system supplying air to a furnace. Gear A receives
#qty[150][kW] from gear P. Gear C delivers the power to gear Q. The shaft
rotates at #qty[600][rpm].

#figure(
    image("./images/practical-shaft-design-example-1-1.png", width: 70%),
    caption: [
        Intermediate shaft for a double-reduction, spur gear-type speed reducer.
    ],
)

#figure(
    image("./images/practical-shaft-design-example-1-2.png"),
    caption: [
        Proposed geometry for the shaft above. Sharp fillets at $r_3$ and $r_5$.
        well-rounded fillets fillets at $r_1, r_2$ and $r_4$. Profile key seats
        at $A$ and $C$.
    ],
)

==== Forces on gear $A$ and $C$
#cimage("./images/practical-shaft-design-example-1-3.png")

==== Defining the $x$, $y$, and $z$ axis
#cimage("./images/practical-shaft-design-example-1-4.png")

$ T_A = W_(t A) r_A $
$ T_C = W_(t C) r_C $

==== Various diagrams
#cimage("./images/practical-shaft-design-example-1-5.png")

==== Torque diagram
#cimage("./images/practical-shaft-design-example-1-6.png")
#pagebreak()

==== Summary of diameters
The calculated minimum required diameters for the various parts of the shaft
are:
$ D_1 = #qty[48][mm] space ("with gear") $
$ D_2 = #qty[86][mm] space ("shaft") $
$ D_3 = #qty[102][mm] space ("with bearing") $
$ D_5 = #qty[106][mm] space ("with bearing") $
$ D_6 = #qty[34][mm] space ("with gear") space #text(red)[[out of syllabus]] $

For $D_4$, look at #link(<table-a2-1>)[Table A2-1] in the appendix and pick a
suitable size that is bigger than both $D_3$ and $D_5$.

=== Example 2
The shaft shown below receives #qty[82][kW] from a water turbine through a chain
sprocket at point C. The gear pair at E delivers #qty[60][kW] to an electrical
generator. The V-belt sheave at A delivers #qty[22][kW] to a bucket lift that
carries grain to an elevated hopper. The shaft rotates at #qty[1700][rpm]. The
sprocket, sheave, and gear are located axially by retaining rings. The sheave
and gear are keyed with sled runner key seats, and there is a profile key seat
the sprocket. Use AISI 1040 cold-drawn steel for the machined shaft. Compute the
minimum acceptable diameters D1 through D7 as defined in the figure below.

#cimage("./images/practical-shaft-design-example-2-1.png")

==== Real life example
#cimage("./images/practical-shaft-design-example-2-2.png")

==== Finding the yield strength $s_y$
#cimage("./images/practical-shaft-design-example-2-3.png")

==== Finding the torque and moments
#cimage("./images/practical-shaft-design-example-2-4.png")

For loading diagrams (resolved by horizontal and vertical forces):
+ Forces due to the power driving systems is obtained through the free-body
    diagram.
+ Find the bearing forces through the principles of force and moment
    equilibrium.

For shear force ($V$) and bending moment diagrams ($M$), obtain the resultant
shear force and moments from the horizontal and vertical planes.

==== Shear force and bending moments
#cimage("./images/practical-shaft-design-example-2-5.png")

==== Torque diagram
#figure(
    image("./images/practical-shaft-design-example-2-6.png"),
    caption: [
        Full torque at $C$ for sprocket force analysis. Higher torque
        (#qty[337][Nm]) for shaft design at $C$.
    ],
)

#cimage("./images/practical-shaft-design-example-2-7.png")
#pagebreak()

==== Final design diameters
#table(
    columns: 4,
    table.header(
        [*Diameter*],
        [*Mating part*],
        [*Minimum diameter*\ (Using the design equation)],
        [*Specified final diameter*],
    ),

    $D_1$,
    [Shaft (point $A$)],
    qty[19.98][mm],
    [Belt sheave inner diameter is bigger than #qty[19.98][mm]],

    $D_2$, [Shaft], qty[49.16][mm], [#qty[50][mm] (basic size)],

    $D_3$,
    [Bearing (point $B$)],
    qty[58.26][mm],
    [Bearing bore diameter bigger than #qty[58.26][mm]],

    $D_4$,
    [Sprocket (point $C$)],
    qty[72.36][mm],
    [Sprocket inner diameter bigger than #qty[72.36][mm]],

    $D_5$,
    [Bearing (point $D$)],
    qty[57.74][mm],
    [Bearing bore diameter bigger than #qty[57.74][mm]],

    $D_6$, [Shaft], qty[48.83][mm], [#qty[50][mm] (basic size)],

    $D_7$,
    [Gear (point $E$)],
    qty[27.88][mm],
    [Gear hub inner diameter bigger than #qty[27.88][mm]],
)

=== Summary
+ Specify a geometry (distance, layout, etc) for the connecting points along the
    shaft.
+ Determine the forces that are exerted on the shaft.
+ Determine the torque, shear force and bending moments.
+ Use the design equation for the minimum shaft diameter $D$.
    $
        D = [
            frac(32 N, pi)
            sqrt((frac(K_(f b) M, s_n'))^2 + 3/4 (T/s_y)^2)
        ]^(1/3)
    $
+ Specify final dimension for each point on the shaft.

#pagebreak()

= Keys

#grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    image("./images/key-typical-arrangement.png"),
    image("./images/shaft-with-key.png"),
)

Keys are mostly used to attached gears to shafts, together with shaft shoulders
and retaining rings. Using screws is also an alternative to using a key.

#cimage("./images/key-gear-hub-and-shaft.png")

- A variety of power-transmitting elements, such as gears, pulleys, and cams,
    are mounted on rotating shafts.
- The portion of the mounted member in contact with the shaft is called the hub.
- The key is a component placed at the interface between a shaft and the hub of
    a power-transmitting element for transmitting torque.
- The main purpose of using a key is to prevent *relative motion* between the
    shaft and the connected machine elements, so the full torque is transferred
    from the shaft to the power-transmitting element.
- The key is also used as a safety system, as the key will shear in the event of
    a drastic increase in loading before the shaft or machine element fails.
    - Since keys are inexpensive and can be quickly replaced, keys are used to
        protect expensive machine components.

== Types of keys

=== Square key
This is the most common type of key, where the height ($H$) is equal to the
width ($W$), i.e. $H = W$.

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/key-square.png"), image("./images/key-square-seat.png"),
)

=== Rectangular key
The rectangular or flat key has a height ($H$) #sym.lt width ($W$).


#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/key-rectangular.png"),
    image("./images/key-rectangular-seat.png"),
)

=== Other key types
#cimage("./images/key-other-types.png")

== Guidelines
- Normally, the key length is specified to be a substantial portion of the hub
    length for good alignment and stable operation.
- Keys should fit tightly so that key rotation is not possible.
- One-half of the key height is the bearing on the side of the shaft key seat,
    and the other half is on the hub key seat.
- Keys are usually made of low-carbon, cold-drawn steel. Higher-carbon steel
    could be used for higher strength.
- It is common to design the key so that it will fail before the key seat or
    other locations in the shaft fail in the event of an overload.
- The key then acts like a shear pin to protect the more expensive elements from
    damage. A key is inexpensive and is relatively easy to replace if the key
    seat is undamaged.
- This is the main reason to use only soft, ductile materials for the key,
    having lower strength than that of the shaft so that a bearing failure will
    selectively affect the key rather than the keyway if the system sees an
    overload beyond its design range.

#link(<table-11-1>)[Table 11-1] below shows the dimensions of rectangular keys
with respect to the shaft diameter.

#cimage("./images/table-11-1.png")

#pagebreak()

== Stress analysis
The purpose of stress analysis is to determine the key length.

#cimage("./images/key-stress-analysis.png")

- They are 2 failure modes for keys:
    - *Shear* across the shaft or hub interface.
    - *Compression failure* due to bearing action between the sides of the key
        and the shaft or hub.

=== Determining the required key length
<determining-the-required-key-length>

==== Shear stress
$ tau = frac(F, A_s) $
$ F(D/2) - T = 0 $
$ A_s = W L $
$ tau = frac(T, D/2 (W L)) = frac(2 T, D W L) $

Maximum *shear* stress theory:
$ tau_d = frac(0.5 s_y, N) $

Where $N$ is the design factor.

The key length for *shear stress* is:
$ L_s = frac(2 T, tau_d D W) $

For *square cross-sections*, the key length is:
$ L_s = frac(4 T N, D W s_y) $

==== Compressive stress
$ sigma = F/A_c $
$ F = frac(T, D/2) $
$ A_c = H/2 L $

The design stress for *compression*:
$ sigma_d = s_y/N $

Where $N$ is the safety factor.

For *square cross-sections*, the key length for *compression*:
$ L_c = frac(4 T N, D H s_y) = frac(4T, sigma_d D H) $

Ensure that the key material is the weakest out of all components

== Design procedure
+ Complete the design of the shaft into which the key will be installed, and
    specify the actual diameter $D$ at the location of the key seat.
+ Select the key size ($W$ and $H$) from #link(<table-11-1>)[Table 11-1].
+ Specify a suitable design factor, $N$. In typical industrial applications,
    $N = 3$ is adequate to accommodate accidental overloads and shock.
+ Determine the yield strength of the materials for the key, the shaft and the
    hub.
+ Use the equations in @determining-the-required-key-length to compute the
    minimum required length of the key based on the stresses experienced by the
    key.
    - Take the largest length value as the length of the key.
    - Ensure that the computed length is shorter than the hub length.
    - Otherwise, a higher-strength material must be selected and the design
        process repeated.
+ Specify the final key length to be equal to or longer than the computed
    minimum length. A convenient standard size should be used by using the basic
    sizes shown in #link(<table-a2-1>)[Table A2-1].

#pagebreak()

== Example
A portion of a shaft where a gear is to be mounted is to be #qty[50][mm]. The
gear transmits #qty[335][Nm] of torque. The shaft is to be made of AISI 1040
cold-drawn steel. The gear is made from AISI 8650 OQT 1000 steel. The width of
the hub of the gear mounted at this location is #qty[45][mm]. Design the key.

From #link(<table-11-1>)[Table 11-1], the standard key dimension for a
#qty[50][mm] diameter shaft would be #qty[14][mm^2].

Material selection is a design decision, so let's choose AISI 1020 CD steel with
$s_y = #qty[352][MPa]$.

A check of the yield strengths of the 3 materials in the key, the shaft, and the
hub indicates that the key is the weakest material. Computing the minimum
required length of the key:
$
    L = frac(4 T N, D W s_y) = frac(
        4 (335) (3),
        50 times 10^(-3) times 14 times 10^(-3) times 352 times 10^6
    ) = #qty[0.01627][m] = #qty[16.27][mm]
$

#cimage("./images/key-example-diagram.png", height: 29em)

=== Discussion
- The length is well below the width of the hub of the gear.
- Notice that the design of the shaft includes retaining rings on both sides of
    the gear.
- It is desirable to keep the key seat well clear of the ring grooves.
- Also, the key should extend over all or a substantial part of the length of
    the hub.
- Hence, let's specify the length of the key to be #qty[40][mm]

In summary, the key has the following characteristics:
- Material: AISI 1020 CD steel
- Width: #qty[14][mm]
- Height: #qty[14][mm]
- Length: #qty[40][mm]

== Summary
- Square and rectangular keys are used to transmit torque from the shaft to the
    gear.
- Specify the width and height from the data suggested.
- Calculate the *minimum key length* by analysing the *shear* and *compressive*
    forces.
- Factors affecting the specified final length.

= Couplings
Couplings are used to connect two shafts at their ends, like the shaft of a
driving machine and the shaft of a driven machine, together for the purpose of
power transmission.

#figure(
    image("./images/couplings-two-types.png"),
    caption: [Two types of couplings],
)

== Coupling designs
- The coupling between machine elements must be properly designed, installed and
    maintained.
- A coupling should be designed to withstand the torque required for the
    application while accommodating for misalignment between the shafts.
- Because machine components move due to temperature, dynamic bending and
    bearing wear over time, some misalignment must always be accounted for.
- A coupling design should be able to handle *radial, angular, and axial*
    misalignments.
- The amount of misalignment is a function of many factors.

#cimage("./images/couplings-misalignment-types.png")

#pagebreak()

=== Rigid couplings
#cimage("./images/couplings-rigid.png")
- Rigid couplings are designed to draw two shafts together tightly so that no
    relative motion can occur between them.
- Rigid couplings are mainly used in areas where the two shafts are coaxial to
    each other, i.e. the shafts are *aligned*.
- The coupling is made of two flanged end pieces.
- The flanges are connected firmly by means of fitted bolts which are tightened
    according to the torque to be transmitted.
- There is no relative motion between the shafts, and the shafts are precisely
    aligned.
- Bolts carry the torque in shear stress.

#cimage("./images/couplings-rigid-diagram.png")

$
    tau_d = tau = F/A_s = frac(F, N (frac(pi d^2, 4)))
    = frac(2T, D_(b c) N (frac(pi d^2, 4))) = frac(8T, pi D_(b c) N d^2)
$
$ d = sqrt(frac(8T, pi D_(b c) N (tau_d))) $

Where:
- $N$ is the number of bolts
- $tau$ is the allowable shear stress in bolts

=== Flexible couplings
- Transmit torque smoothly.
- Permits some axial, radial and angular misalignment.

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    figure(
        image("./images/couplings-flexible-chain.png", height: 15em),
        caption: [
            Chain coupling. Torque is transmitted through a double roller chain.
            Clearances between the chain and the sprocket teeth on the two
            coupling halves accommodate misalignment. (Emerson Power
            Transmission Corporation, Ithaca, NY)
        ],
    ),
    figure(
        image("./images/couplings-flexible-ever-flex.png", height: 15em),
        caption: [
            Ever-Flex coupling. The features of this coupling are that it (1)
            generally minimises torsional vibration; (2) cushions shock loads;
            (3) compensates for parallel misalignment up to $1/32 #unit[in]$;
            (4) accommodates angular misalignment of $plus.minus 3 degree$; and
            (5) provides adequate end float, $plus.minus 1/32 #unit[in]$.
            (Emerson Power Transmission Corporation, Ithaca, NY)
        ],
    ),
)

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    figure(
        image("./images/couplings-flexible-grid-flex.png"),
        caption: [
            Grid-Flex coupling. Torque is transmitted through a flexible spring
            steel grid. Flexing of the grid permits misalignment and makes it
            torsionally resilient to resist shock loads. (Emerson Power
            Transmission Corporation, Ithaca, NY)
        ],
    ),
    figure(
        image("./images/couplings-flexible-gear.png"),
        caption: [
            Gear coupling. Torque is transmitted between crown-hobbed teeth from
            the coupling half to the sleeve. The crown shape on the gear teeth
            permits misalignment. (Emerson Power Transmission Corporation,
            Ithaca, NY)
        ],
    ),
)

==== PARA-FLEX#sym.trademark.registered
#figure(
    image("./images/couplings-flexible-para-flex.png"),
    caption: [
        PARA-FLEX#sym.trademark.registered coupling. Using an elastomeric
        element permits misalignment and cushions shocks. (Rockwell
        Automation/Dodge, Greenville, SC)
    ],
)

==== Dynaflex#sym.trademark.registered
#figure(
    image("./images/couplings-flexible-dynaflex.png"),
    caption: [
        Dynaflex#sym.trademark.registered coupling. Torque is transmitted
        through elastomeric material that flexes to permit misalignment and to
        attenuate shock loads. (Lord Corporation, Erie, PA)
    ],
)

==== Jaw-type couplings
#figure(
    image("./images/couplings-jaw-type.png"),
    caption: [
        Jaw-Type coupling (Emerson Power Transmission Corporation, Ithaca, NY)
    ],
)

==== General principles
- As shown above, various types of flexible couplings are available
    commercially. Each is designed to transmit a given limiting torque.
- The manufacturer's catalogue lists the design data from which you can choose a
    suitable coupling.
- Since $P = T omega$, for a given size of coupling, the amount of power that
    the coupling can transmit increase if the speed of rotation increase. Note
    that centrifugal effects determine the upper limit of speed.
- The degree of misalignment that can be accommodated by a given coupling should
    be obtained from the manufacturer's catalogue with values varying with the
    size and design of the coupling.
- Small couplings may be limited to parallel misalignments of #qty[0.127][mm],
    although larger couplings may allow #qty[0.762][mm] or more. Typical
    allowable angular misalignment is $plus.minus 3 degree$.

#pagebreak()

= Tolerances
- Due to the accuracy limitation of manufacturing methods, a *part* cannot be
    made precisely to a given dimension to meet its purpose.
- It is usually sufficient that it should be made so as to lie within 2
    permissible limits of size, the difference of which is the *tolerance*.
- The final dimension (including the tolerance), should be specified for a
    component, like a shaft, in addition to the determination of the minimum
    acceptable geometric size.

== Definitions

=== Basic size (nominal size)
The reference size of the hole or the shaft to which the limit of size are
fixed. The basic size is the same for both members of a fit.

=== Limits of size
The maximum and minimum sizes permitted for a feature.

=== Maximum limit of size
The greater of the two limits of size.

=== Minimum limit of size
The smaller of the two limits of size.

=== Hole
A hole designates all internal features of a part, including parts which are not
cylindrical.

=== Shaft
Shafts designate all external features of a part, including parts which are not
cylindrical.

=== Upper deviation
The difference between the maximum limit of size and the corresponding basic
size.

=== Lower deviation
The difference between the minimum limit of size and the corresponding basic
size.

=== Tolerance
The difference between the maximum limit of size and the minimum limit of size.
The ranges are in *#qty[0.001][mm]*.

=== Fit
Fit expresses the relationship between mating parts with respect to the amount
of clearance or interference which exists when they are assembled together. In
other words, it is the relation resulting from the difference between the sizes
of two parts.

==== Clearance fits
Clearance fits allow sliding or rotation. The tolerance zone of the hole is
entirely above that of the shaft.

==== Interference fits
Interference fits assure interference (negative clearance) and are specified for
rigidity and alignment. The tolerance zone of the hole is entirely below that of
the shaft.

==== Transition fits
Transition fits are where the assembly may have either clearance or
interference, are specified for accurate location. The tolerance zones of the
hole and the shaft overlaps.

==== Zones of fits
#cimage("./images/fit-zones.png")
#pagebreak()

==== Table
#figure(
    pad(x: -2em, table(
        columns: (auto, 6em, auto, 5em, 6em, auto),
        align: left,

        table.header(
            [*Class*],
            [Description],
            [Characteristics],
            [*ISO code*],
            [Assembly],
            [Application],
        ),

        table.cell(rowspan: 5)[Clearance],

        [Loose running fit],
        [For wide commercial tolerances],
        [H11/c11],
        [Noticeable clearance],
        [IC engine exhaust valve in guide],

        [Free running fit],
        [
            Good for large temperature variations, high running speeds or heavy
            journal pressures
        ],
        [H9/d9],
        [Noticeable clearance],
        [
            Multiple bearing shafts, hydraulic piston in cylinder, removable
            levers, bearings for rollers
        ],

        [Close running fit],
        [
            For running on accurate machines and accurate location at moderate
            speeds and journal pressures
        ],
        [H8/f7],
        [Clearance],
        [
            Machine tool main bearings, crankshaft and connecting rod bearings,
            shaft sleeves, clutch sleeves, guide blocks
        ],

        [Sliding fit],
        [
            When parts are not intended to run freely, but must move and turn
            and locate accurately
        ],
        [H7/g6],
        [Push fit without noticeable clearance],
        [
            Push-on gear wheels and clutches, connecting rod bearings, indicator
            pistons
        ],

        [Location clearance fit],
        [
            Provides snug fit for location of stationary parts, but can be
            freely assembled
        ],
        [H7/h6],
        [Hand pressure with lubrication],
        [
            Gears, tailstock sleeves, adjusting rings, loose bushes for piston
            bolts and pipelines
        ],

        table.cell(rowspan: 2)[Transition],

        [Location transition fit],
        [
            For accurate location (compromise between clearance and interference
            fit)
        ],
        [H7/k6],
        [Easily tapped with hammer],
        [
            Pulleys, clutches, gears, flywheels, fixed hand wheels and permanent
            levers
        ],

        [Location transition fit],
        [For more accurate location],
        [H7/n6],
        [Needs pressure],
        [
            Motor shaft armatures, toothed collars on wheels
        ],

        table.cell(rowspan: 2)[Interference],

        [Locational interference fit],
        [For parts requiring rigidity],
        [H7/p6],
        [Needs pressure],
        [Split journal bearings],

        [Medium drive fit],
        [For ordinary steel parts of shrink fits on light sections],
        [H7/s6],
        [Needs pressure or temperature difference],
        [
            Clutch hubs, bearing bushes in blocks, wheels, connecting rods.
            Bronze collars on grey cast iron hubs.
        ],
    )),
    caption: [Example of tolerance bands and typical applications],
)

#pagebreak()

== Fits
- When parts are assembled together, engineers have to decide how they will
    *fit* together and the economics associated with it.
- How will they fit together?
    - Clearance fit
    - Transition fit
    - Interference fit
- Economics of the fit is usually the most important, with the main
    considerations being inter-changeability and cost savings.
- Standards used:
    - ISO R286 (Europe and international)
    - ANSI B4.1 (United States)
    - BS4500 (England)

=== Example
<fit-example>
#cimage("./images/fit-example.png")

- A basic size is specified to the part and each of the two limits is defined by
    its deviation from this basic size.
- The first figure above is usually replaced by a schematic diagram similar to
    the second figure above for simplicity.

#pagebreak()

=== Interference fits
- Interference fits are those in which the insider member is larger than the
    outside member, requiring the application of force during assembly. There is
    a deformation of the parts after assembly, and pressure exists at the mating
    surface.
- Force fits are used where forces or torques are transmitted through the joint.
- For shrink fit methods, a member is heated to expand it while the other
    remains cool. Assembly is done with little to no force. After cooling, the
    same interference exists as for the force fits.

==== Stresses
- When force fits are used to secure mechanical parts, the interference creates
    a pressure acting at the mating surface.
- The pressure causes stresses in each part and actual fracture may occur.
- The aim of the stress analysis is to determine the magnitude of the pressure
    due to a given interference fit that would be developed at the mating
    surfaces.

=== Systems of fits
Two of the most commonly used methods of applying the ISO system are the
hole-basis system and the shaft basis system.

#cimage("./images/tolerances-system-of-fits.png")
#cimage("./images/tolerances-system-of-fits-hole-and-shaft-basis.png")

==== Hole basis system of fit
- Associating various shafts with a single *hole* that is *fixed*.
- For the ISO standard, the lower deviation of the hole is zero.
- This system is preferred and more commonly used.
- Clearances and interferences are obtained by associating various shafts with a
    single hole.
- It is easier to manufacture shafts to the tolerance values and measure those
    values.

#cimage("./images/tolerances-hole-basis-system-of-fit.png")
#cimage("./images/tolerances-iso-hole-basis-fits.png")
#pagebreak()

==== Shaft basis system of fit
- Associating holes with a single *shaft* that is *fixed*.
- For the ISO standard, the upper deviation of the shaft is zero.
- This system is less commonly used.
- It is preferable when a shaft may have to accommodate a variety of
    accessories, such as couplings, bearings, collars, gears, etc. Having a
    constant shaft diameter with varying bores of accessories to obtain
    different types of fits.

#cimage("./images/tolerances-shaft-basis-system-of-fit.png")

==== Examples
#cimage("./images/tolerances-system-of-fits-example.png")
#pagebreak()

== Unilateral tolerance
The upper and lower deviations are all positive or all negative.
#cimage("./images/tolerances-unilateral.png")

== Bilateral tolerance
The tolerance is split above and below the basic size.
#cimage("./images/tolerances-bilateral.png")
#pagebreak()

== Standard tolerances
- The magnitude or height of the *tolerance zone* is a variation range in part
    size and is the same for both the internal dimensions (holes) and the
    external dimensions (shafts).
- The tolerance zones are specified in International Tolerance (IT) grade
    numbers.
- Note that the smaller grade numbers specify a smaller tolerance zone.

=== Grades of tolerances
- There are 18 grades of tolerances, IT01, IT0, IT1 to IT16. IT is the ISO
    series of tolerances.
- IT01 and IT0 are very fine grades.
- IT16 is the most coarse grade reflecting the precision of the process.
- The degree of error increases with:
    - The precision of the process (IT grade).
    - The size of the component.

#table(
    columns: 5,

    table.header(
        table.cell(rowspan: 2, colspan: 2)[Class of Work and Process],
        table.cell(colspan: 3)[Nominal size (#unit[mm])],
        [Over 3 to 6],
        [Over 50 to 80],
        [Over 120],
    ),

    [IT1], [Slip blocks, reference gauges.], [1.0], [2], [3.5],
    [IT2], [High quality gauges, plug gauges.], [1.5], [3], [5],
    [IT3], [Good quality gauges, gap gauges.], [2.5], [5], [8],

    [IT4],
    [Gauges, fit of extreme precision produced by lapping.],
    [4],
    [8],
    [12],

    [IT5], [Ball bearings, machine lapping, fine grinding.], [5], [13], [18],
    [IT6], [Grinding, fine honing.], [8], [19], [25],
    [IT7], [High quality turning, broaching, honing.], [12], [30], [40],
    [IT8], [Centre lathe work, capstan and automatic.], [18], [46], [63],

    [IT9],
    [Worn capstan or automatic, horizontal and vertical boring.],
    [30],
    [74],
    [100],

    [IT10],
    [Milling, slotting, planing, metal rolling or extrusion.],
    [48],
    [120],
    [160],

    [IT11],
    [Drilling, rough turning, boring, precision tube drawing.],
    [75],
    [190],
    [250],

    [IT12], [Light press work, tube drawing.], [120], [300], [400],
    [IT13], [Press work - tube rolling.], [180], [460], [630],
    [IT14], [Die casting or moulding, rubber moulding.], [300], [750], [1000],
    [IT15], [Stamping.], [480], [1200], [1600],
    [IT16], [Sand casting, flame cutting.], [750], [1900], [2500],
)

=== Fundamental deviations
#cimage("./images/tolerances-fundamental-deviations.png")

=== Deviations and tolerances
#cimage("./images/tolerances-deviations-and-tolerances.png")

== Symbols
- To satisfy the requirements of parts and *fits*, the ISO system (ISO standard
    R286) provides, for any given basic size, a whole range of tolerances
    together with a whole range of *deviations* defining the position of these
    *tolerances*.
- The *tolerance* value is a function of the basic size, and is designated by a
    *number symbol* or the *grade*.
- The *deviation* is the *position* of the tolerance zone with respect to the
    zero line. It is indicated by a *letter symbol*. A capital letter for holes,
    and a small letter for shafts.

=== Designation
- A hole tolerance with *deviation* 'H' and *tolerance* grade IT8 is designated
    'H8'.
- A shaft tolerance with *deviation* 'f' and *tolerance* grade IT7 is designated
    'f7'.
- The tolerance size is defined by its basic value followed by a symbol composed
    of a letter and a number. For example, *50 H8* (hole), *50 f7* (shaft), etc.
- A *fit* is indicated by the basic size common to both components, followed by
    the symbol corresponding to each component, the *hole being quoted first*.
- For example, a specification for a shaft and hole combination with a basic
    size of #qty[50][mm] that is to provide a close running fit is defined on a
    drawing as *50 H8* (hole) *50 f7* (shaft), *50 H8/f7*, or *50 H8-f7*.
- By using this code, no tolerance values need to be given on the drawing.

== Transition fit example
#cimage("./images/tolerances-transition-fit-example.png", width: 90%)

== Interference fit example
#cimage("./images/tolerances-interference-fit-example.png", width: 90%)

= Bearings
- A bearing is a part of a machine that allows one part to rotate or move in
    contact with another part with as little friction as possible.
- Bearings (sliding or rolling) are used to support a load while permitting
    relative motion (translation or rotation) between two machine elements.
- *Rolling contact bearings* refer to variety of bearings that use balls or
    rollers between the stationary and the moving elements.
- Bearings usually support a rotating shaft, resisting pure radial and axial
    (thrust) loads.
- Most bearings are used in applications involving rotation, but some are used
    in linear motion application.

== Types of bearings
Types of rolling contact bearings:
- Deep-groove ball bearing
- Angular contact ball bearing
- Cylindrical roller bearing
- Taper roller bearing
- Spherical roller bearing
- Needle bearing
- Thrust bearing

#cimage("./images/types-of-bearings.png")
#pagebreak()

=== Rolling contact bearing
The main components of a typical *rolling contact bearing* are the *inner race,
outer race*, and *rolling elements (balls or rollers)*.
- Usually the *outer race* is *stationary* and is held by the housing of the
    machine. The inner race is *pressed on the rotating shaft* and thus rotates
    with it. The balls roll between the outer and inner races.
- The load path is from the shaft, to the inner race, to the balls, to the outer
    race, and finally to the housing.
- The presence of the balls or rollers allows a smooth, low friction rotation of
    the shaft.
- The coefficient of friction for a rolling contact bearing is about 0.001 to
    0.002.

#figure(
    image("./images/rolling-contact-bearing.png", height: 20em),
    caption: [
        Single-row, deep-groove ball bearing (NSK Corporation, Ann Arbor, MI)
    ],
)

==== Deep groove bearing
#cimage("./images/rolling-contact-bearing-deep-groove.png")

=== Angular contact bearing
#figure(
    image("./images/angular-contact-bearings.png", height: 20em),
    caption: [
        Angular contact ball bearing (NSK Corporation, Ann Arbor, MI)
    ],
)

- To enhance the thrust capabilities of ball bearings, the axis of the balls can
    be placed in an off-radial position. These bearings are called *angular
    contact* or *radial and thrust* load bearings.
- As single-row bearings, they will support both radial and uni-directional
    thrust loads.
- A double-row configuration is required if thrust loads will occur in both
    directions.

#cimage("./images/types-of-ball-bearings.png")
#pagebreak()

=== Roller bearings
- Roller bearings are preferred when large loads are present. Their load
    capacity for a given space greatly exceeds that of *ball* bearings as the
    basic rolling contact is along a line (a small circular area), not a point.

#cimage("./images/cylindrical-roller-bearings.png")

==== Taper roller bearings
- Taper roller bearings accept pure radial loads, pure thrust loads, and a
    combination of the two.
- When the taper angle is $45 degree$, the thrust and radial capacities are
    equal. A *steeper angle* provides *more thrust* than radial capacity, and
    vice versa.

#pagebreak()

==== Thrust roller bearings
- Thrust roller bearings can carry thrust loads but cannot withstand any radial
    loads.
- More thrust bearings (ball or roller) support only axial loads acting in one
    direction.
- Shaft speeds must be load, otherwise the centrifugal force on the bearing
    becomes unacceptable.
- It is preferable to use angular contact bearings instead.

#cimage("./images/thrust-bearings.png")

== Mounting of bearings
#grid(
    columns: 2,
    column-gutter: 3em,
    grid.cell(inset: (y: 0.5em))[
        - Mounted bearings provide a means to attach the bearing unit directly
            to the frame of the machine with bolts rather than inserting it into
            a machined recess in a housing, which is required in unmounted
            bearings.
        - The pillow block is the most common configuration for a mounted
            bearing.
        - The flange and take-up units are to be mounted on the frame of
            machines.
    ],
    image("./images/mounting-of-bearings.png", height: 20em),
)

== Bearing load

=== Magnitude of load
- The *magnitude of load* is a factor to determine the *size* of the bearing to
    be used.
- Generally, roller bearings can carry heavier loads than ball bearings because
    of the shape and size of the roller area over which the load is spread.

=== Direction of load
- *Radial loads* act towards the centre of the bearing along a radius, and are
    created by spur gears, V-belt and chain drives.
- *Thrust loads* act parallel the axis of the shaft, and are created by helical
    gears, bevel gears, worm and worm gears.

#cimage("./images/bearings-direction-of-load.png", width: 80%)

=== Example
#cimage("./images/bearings-load-example.png")

== Selection of bearings
- After selecting the bearing type, the bearing size can be calculated.
- A bearing is *selected* based on its quoted value of static load carrying
    capacity or dynamic load carrying capacity.
- If the bearing is stationary for long periods or rotates slowly and is subject
    to shock loads, then the bearing selection procedure is based on the *static
    load carry capacity*.
- For more continuous operation, the bearing is selected on the *dynamic load
    carrying capacity*.
- The selection of a rolling contact bearing from a manufacturer's catalogue
    involves considerations of the *geometry and load capacity* of the bearing.
- The size of a bearing is selected on the basis of its *load-carrying capacity*
    in relation to the loads to be carried and the requirements regarding *life*
    and *reliability*.

=== Life
For a rolling element, the number of revolutions, or the number of operating
hours at a given speed, which the bearing is capable of enduring before the
first evidence of *fatigue* develops on one of the rings or rolling elements.

=== Reliability
For a group of apparently identical rolling bearings, operating under the same
conditions, the percentage of the group that is expected to attain or exceed a
specified life.

=== Basic rated life (L10)
- For a group of apparently identical rolling bearings, operating under the same
    conditions, the life associated with *90%* reliability.
- It also represents the life that 90% of the bearings would achieve
    successfully at a rated load.
- Note that different manufacturers may use other bases for the rated life, for
    example, 90 million cycles and average life (L50).

=== Basic or standard load rating
The constant stationary load that a rolling bearing can endure for a basic rated
life of *1 million revolutions*.

#cimage("./images/bearings-basic-load-rating-table-14-3.png", width: 95%)
#cimage("./images/bearings-basic-load-rating-table-14b.png", width: 95%)

=== Basic static load rating ($C_0$)
The basic static load is used when the bearings are to rotate at very slow
speeds, or are to be stationary under load.

=== Basic dynamic load rating ($C$)
The basic dynamic load is used when the bearings are to rotate under load.

=== Life and load relationship
Bearings have a finite life and will eventually fail due to fatigue because of
the high contact stresses over a small area.

$ L_2/L_1 = (P_1/P_2)^k $

Where:
- $k$ is the loading factor, which is *3* for a *ball* bearing, and *$10/3$* for
    a *roller* bearing
- $L_1$ and $L_2$ are the life of the bearing
- $P_1$ and $P_2$ are the loads on the bearing

#pagebreak()

==== Life equation
$ L_d = L_2 = L_1 = (frac(P_1, P_2))^k $
#labelled_equation($ L_d = 10^6 (frac(C, P_d))^k #unit[revolutions] $, "14-2")
#labelled_equation($ C = P_d (frac(L_d, 10^6))^(1/k) $, "14-3")

$ C_"catalogue" > C_"calculated" $

Where:
- $L_d$ or $L_2$ is the design life ($L_(10)$) at a load of $P_2$
- $P_2$ is the design load ($P_d$)
- $L_1$ is the $L_(10)$ life at load $P_1$, which is by default 1 million
    revolutions and 90% reliability
- $P_1$ or $C$ is the basic dynamic load rating from the catalogue data

#cimage("./images/bearings-life-equation-table-14-3.png")

$ L_(10) = L_(10, h) n times 60 $

Where:
- $L_(10)$ is in #unit[rev]
- $L_(10, h)$ is in #unit[h]
- $n$ is in #unit[rpm]

#let table-14-4 = figure(
    table(
        columns: 2,
        align: left,

        table.header(
            [_Type of application_], [_Life $L_(10, h)$ ($10^3 #unit[hrs]$)_]
        ),

        [*Instruments and apparatus for infrequent use*], [Up to 0.5],
        pad(x: 1em)[Domestic appliances], [1 to 2],
        pad(x: 1em)[Aircraft engines], [1 to 4],
        pad(x: 1em)[Automotive], [1.5 to 5],
        pad(x: 1em)[Agricultural equipment], [3 to 6],
        pad(x: 1em)[Elevators, industrial fans, multi-purpose gearing],
        [8 to 15],

        pad(x: 1em)[
            Electrical motors, industrial blowers, general industrial machine
        ],
        [20 to 30],

        pad(x: 1em)[Pumps and compressors], [40 to 60],

        [*Machines used intermittently*], [],
        pad(x: 1em)[Service interruption is of minor importance], [4 to 8],
        pad(x: 1em)[Reliability is of great importance], [8 to 14],

        [*Machines used in an 8-hour service working day*], [],
        pad(x: 1em)[Not always fully utilised], [14 to 20],
        pad(x: 1em)[Fully utilised], [20 to 30],

        [*Machines for continuous 24-hour service*], [50 to 60],
        pad(x: 1em)[Reliability is of extreme importance], [100 to 200],
    ),
    caption: [Recommended bearing life (in hours) for various requirements],
)

#pagebreak()

See @table-14-4 for the *recommended design life* for bearings for various
applications, in hours of operations ($L_(10, h)$).

#table-14-4

==== Example 1
A catalogue lists the basic dynamic load rating $C$ for a ball bearing to be
#qty[42.3][kN] for a rated life of 1 million #unit[rev]. What would be the
expected $L_(10)$ life of the bearing, if it were subjected to a load of
#qty[21][kN]?

Given:
$ P_1 = C = #qty[42.3][kN] "(basic dynamic load rating)" $
$ P_2 = P_d = #qty[21][kN], quad L_1 = 10^6 #unit[rev], "and" k = 3 $

The design life can be obtained by using:
$ L_d = 10^6 frac(C, P_d)^k #unit[revolutions] $
$ L_2 = L_d = 10^6 (C/P)^k = 10^6 (42.3/21)^3 = 8.173 times 10^6 #unit[rev] $

Which is the $L_(10)$ life at a load of #qty[21][kN].

#pagebreak()

==== Example 2
<life-and-load-relationships-example-2>
Compute the required basic dynamic load rating, $C$, for a ball bearing to carry
a radial load of #qty[3][kN] from a shaft rotating at #qty[600][rpm] that is
part of *an industrial blower in a manufacturing plant*.

From @table-14-4, let's select a design life of #qty[30000][hr].

Next:
$
    L_(10) = L_(10, h) (#unit[hr]) n (#unit[rpm])
    60 (#unit[min hr^-1]) = 30000 (600) (60) = 1.08 times 10^9 #unit[rev]
$

The required basic dynamic load equation can then be evaluated by using:
$ C = P_d frac(L_d, 10^6)^(1/k) $
$
    C = P_d (frac(L_d, 10^6))^(1/k)
    = 3 (frac(1.08 times 10^9, 10^6))^(1/3) = #qty[30.78][kN]
$

=== Considerations
- Selection of a bearing takes into consideration the load capacity and the
    geometry of the bearing that will ensure that it can be installed
    conveniently in the machine.
- The equivalent dynamic load, $P$, is a design load.
- If the calculated bearing load $R$ fulfils the requirements for the basic
    dynamic load rating $C$, i.e. the load is constant in magnitude and
    direction and acts radially on a bearing, then:

    #labelled_equation($ P = V F_r $, "14-5")

    Where:
    - $P = P_d$, which is the design load
    - $F_r$ is the resultant radial load
    - $V$ is a rotation factor, and *$V = 1.0$* if the *inner race* of the
        bearing rotates, which is usually the case, and *$V = 1.2$* if the
        *outer race* rotates.

==== Example 1
Select a single-row, deep-groove ball bearing to carry #qty[3][kN] of pure
radial load from a shaft that rotates at #qty[600][rpm]. The design life is to
be #qty[30000][hr]. The bearing is to be mounted on a shaft with a minimum
acceptable diameter of #qty[38][mm].

Note that this is a pure radial load and the inner race is to be pressed onto
the shaft and rotate with it. Therefore, the factor $V = 1.0$ and $P = F_r$.

From @life-and-load-relationships-example-2, we found $C = #qty[30.78][kN]$.

We find from #link(<table-14-3>)[Table 14-3] (a sample table), that we could use
a bearing *6208* ($C = #qty[32.5][kN]$, $d = #qty[40][mm]$) or a bearing *6307*
($C = #qty[35.1][kN]$, $d = #qty[35][mm]$) as the quoted $C$ is higher than
#qty[30.78][kN].

Hence, we select bearing *6208* as the bore diameter is slightly bigger than the
minimum shaft diameter of #qty[38][mm].

#pagebreak()

=== Combined radial and thrust loads
The AFBMA recommends the maximum of the values of the two equations below for
rolling bearings:
#labelled_equation($ P = X V F_r + Y F_a $, "14-6")
#labelled_equation($ P = V F_r wide ("if" F_a = 0) $, "14-5")

Where:
- $P = P_d$ is the equivalent radial or dynamic load
- $F_r$ is the applied radial load
- $F_a$ is the applied axial or thrust load
- $V$ is the rotation factor, which is *1.0* for *inner-race* rotation and *1.2*
    for *outer-race* rotation
- $X$ is the radial factor, see #link(<table-14-5>)[Table 14-5] or below
- $Y$ is the thrust factor, see #link(<table-14-5>)[Table 14-5] or below

#let table-14-5 = figure(
    table(
        columns: 6,
        align: center + horizon,
        table.header(
            table.cell(rowspan: 2, colspan: 2)[],

            table.cell(colspan: 2)[No axial load],
            table.cell(colspan: 2)[With axial load],

            table.cell(colspan: 2)[$ frac(F_a, V F_r) <= e $],
            table.cell(colspan: 2)[$ frac(F_a, V F_r) > e $],

            $ F_a/C_0 $,
            $ e $,

            $ X $,
            $ Y $,

            $ X $,
            $ Y $,
        ),

        [0.014], [0.19], [1.0], [0], [0.56], [2.30],
        [0.021], [0.21], [], [], [], [2.15],
        [0.028], [0.22], [], [], [], [1.99],
        [0.042], [0.24], [], [], [], [1.85],
        [0.056], [0.26], [], [], [], [1.71],
        [0.070], [0.27], [1.0], [0], [0.56], [1.63],
        [0.084], [0.28], [], [], [], [1.55],
        [0.110], [0.30], [], [], [], [1.45],
        [0.17], [0.34], [], [], [], [1.31],
        [0.28], [0.38], [], [], [], [1.15],
        [0.42], [0.42], [], [], [], [1.04],
        [0.56], [0.44], [], [], [], [1.00],

        table.cell(colspan: 6, align: left, inset: (y: 0.7em))[
            \*Use 0.014 if $F_a/C_0 < 0.014$.
        ],
    ),
    caption: [Single-row, deep-groove ball bearings],
)

#table-14-5

#pagebreak()

=== Procedure
The procedure of bearing selection for cases of combined radial and thrust
loads, giving the design:
+ *Assume* $Y$ (thrust factor).
+ Compute $P = P_d = V X F_r + Y F_a$
+ Compute the required dynamic load, $C$.
    #labelled_equation($ C = P_d (frac(L_d, 10^6))^(1/k) $, "14-3")
+ Select a bearing having a greater $C$, i.e. $C_"catalogue" > C_"calculated"$.
+ For the selected bearing, given $C_0$, compute $F_a/C_0$.
+ Determine $e$ to compare with $frac(F_a, V F_r)$ from #link(
        <table-14-5>,
    )[Table 14-5] $("after computing" F_a/C_0)$.
+ If $frac(F_a, V F_r) > e$, then determine an *updated* $Y$ from #link(
        <table-14-5>,
    )[Table 14-5].

    If $frac(F_a, V F_r) < e$ or $F_a = 0$, use the equation below for a pure
    radial load.
    #labelled_equation($ P = V F_r $, "14-5")
+ Iteration is performed until the following *2 conditions* are met:
    + With the *updated* $Y$ (found from #link(<table-14-5>)[Table 14-5]),
        repeat steps 1 - 7 with the *updated* $Y$ if the new
        $C_("updated" Y) > C_"assumed Y"$
    + $C_"catalogue" > C_("updated" Y)$

        If $C_"catalogue" < C_("updated" Y)$, select a bigger bearing and repeat
        step 4.

- Once a value for the equivalent dynamic bearing load is obtained, it can be
    used to calculate the dynamic load rating of the bearing. This value is used
    to select the bearing.
- Each bearing in the bearing catalogue has a quoted value for the dynamic load
    rating, so a bearing with a *higher rating* than the one calculated should
    be chosen.

#pagebreak()

=== Example 1
<bearing-selection-example-1>
Select a single-row, deep-groove ball bearing from #link(<table-14-3>)[Table
    14-3] to carry a radial load of #qty[8.2][kN] and a thrust load of
#qty[3][kN]. The shaft is to rotate at #qty[1150][rpm], and a design life of
#qty[15000][hr] is desired. The minimum acceptable diameter for the shaft is
#qty[72][mm].

Assumptions:
- The inner ring rotates and the load and rotation is steady.
- A bearing will be selected based on the given design life.

#table-14-5

==== Step 1
Assume $Y = 1.5$ before using #link(<table-14-5>)[Table 14-5] (other values are
possible, as the real $Y$ would later be obtained from #link(<table-14-5>)[Table
    14-5]) and $X = 0.56$ for deep groove ball bearings (see #link(
    <table-14-5>,
)[Table 14-5]).

==== Step 2
Using equation 14-6:
$
    P_d = V X F_r + Y F_a = 1 times 0.56 times 8.2 + 1.5 times 3
    = #qty[9.092][kN]
$

Note that $P$ is bigger than $F_r$ (8.2) and $F_a$ (3). $P$ incorporates both
$F_r$ and $F_a$.

#pagebreak()

==== Step 3
Using equation 14-3:
$
    C & = P_d (frac(L_d, 10^6))^(1/k) \
      & = 9.092 (frac(15000 times 1150 times 60, 10^6))^(1/3) \
      & = #qty[91.97][kN]
$

==== Step 4
From #link(<table-14-3>)[Table 14-3], we could use either bearing number *6218*,
or *6317, 6316, 6315, 6314, 6313*.

#cimage("./images/bearings-example-1-table-14-3-1.png", width: 95%)
#cimage("./images/bearings-example-1-table-14-3-2.png", width: 95%)

==== Step 5
For bearing 6315, $C_0 = #qty[76.5][kN]$
$ F_a/C_0 = 3/76.5 = 0.039 $

==== Step 6
From #link(<table-14-5>)[Table 14-5], $e = 0.236$ by interpolation.

==== Step 7
Given $F_a/F_r = 3/8.2 = 0.366$ and $F_a/F_r > e$. We next find $Y = 1.88$ using
#link(<table-14-5>)[Table 14-5] via interpolation.

==== Step 2' (again with updated $Y$)
Re-compute equation 14-6:
$
    P_d = V X F_r + Y F_a = 1 times 0.56 times 8.2 + 1.88 times 3
    = #qty[10.232][kN]
$

==== Step 3' (again with updated $Y$)
Re-compute equation 14-3:
$
    C & = P_d (frac(L_d, 10^6))^(1/k) \
      & = 10.232 (frac(15000 times 1150 times 60, 10^6))^(1/3) \
      & = #qty[103.50][kN]
$

==== Step 4' (again with updated $Y$)
Bearing 6315 is satisfactory at this load, as it has a $C$ value of
$C = #qty[114][kN]$. The bearing selection is done.

A new bearing will be selected if the calculated $C$ is higher than
#qty[114][kN], and the process repeats.

You may want to try other values for the initial $Y$, like $Y = 1.2, 1.8, ...$,
but not $Y = 0$.

#pagebreak()

=== Example 2
Repeat @bearing-selection-example-1 with the same variables, except that the
radial load is #qty[10][kN] and the thrust load is #qty[3.75][kN].

==== Step 1
Assume $Y = 1.5$.

==== Step 2
Compute equation 14-6:
$
    P_d = V X F_r + Y F_a = 1 times 0.56 times 10 + 1.5 times 3.75
    = #qty[11.225][kN]
$

==== Step 3
Compute equation 14-3:
$
    C & = P_d (frac(L_d, 10^6))^(1/k) \
      & = 11.225 (frac(15000 times 1150 times 60, 10^6))^(1/3) \
      & = #qty[113.554][kN]
$

==== Step 4
From #link(<table-14-3>)[Table 14-3], we could use bearing number *6315*
($d = #qty[75][mm], C = #qty[114][kN], C_0 = #qty[76.5][kN]$), as the basic
dynamic load rating of the bearing is higher than the required $C$.

==== Step 5
For bearing 6315, $C_0 = #qty[76.5][kN]$
$ F_a/C_0 = 3.75/76.5 = 0.049 $

==== Step 6
From #link(<table-14-5>)[Table 14-5], $e = 0.25$ by interpolation.

==== Step 7
Given $F_a/F_r = 3.75/10 = 0.375$ and $F_a/F_r > e$. We find $Y = 1.78$ using
#link(<table-14-5>)[Table 14-5] via interpolation.

==== Step 2' (again with updated $Y$)
Re-compute equation 14-6:
$
    P_d = V X F_r + Y F_a = 1 times 0.56 times 10 + 1.78 times 3.75
    = #qty[12.275][kN]
$

==== Step 3' (again with updated $Y$)
Re-compute equation 14-3:
$
    C & = P_d (frac(L_d, 10^6))^(1/k) \
      & = 12.275 (frac(15000 times 1150 times 60, 10^6))^(1/3) \
      & = #qty[124.165][kN]
$

==== Step 4' (again with updated $Y$)
Bearing 6315 is not possible at this load, as it has a value of
$C = #qty[114][kN]$, less than the required #qty[124.165][kN]. We then select
the next bigger bearing, *6317*
($d = #qty[85][mm], C = #qty[133][kN], C_0 = #qty[96.5][kN]$), as the basic
dynamic load rating of the bearing is higher than the required $C$.

==== Step 5' (again with updated $Y$)
For bearing 6317, $C_0 = #qty[96.5][kN]$
$ F_a/C_0 = 3.75/96.5 = 0.03886 $

==== Step 6' (again with updated $Y$)
From #link(<table-14-5>)[Table 14-5], $e = 0.2355$ by interpolation.

==== Step 7' (again with updated $Y$)
Given $F_a/F_r = 3.75/10 = 0.375$ and $F_a/F_r > e$, we find $Y = 1.88$ using
#link(<table-14-5>)[Table 14-5] via interpolation.

==== Step 2$''$ (yet again with updated $Y$)
Re-compute equation 14-6:
$
    P_d = V X F_r + Y F_a = 1 times 0.56 times 10 + 1.88 times 3.75
    = #qty[12.65][kN]
$

==== Step 3$''$ (yet again with updated $Y$)
Re-compute equation 14-3:
$
    C & = P_d (frac(L_d, 10^6))^(1/k) \
      & = 12.65 (frac(15000 times 1150 times 60, 10^6))^(1/3) \
      & = #qty[127.96][kN]
$

==== Step 4$''$ (yet again with updated $Y$)
Bearing 6317 is satisfactory at this load, as it has a $C$ value of
$C = #qty[133][kN]$, which is larger than the required #qty[127.96][kN]. The
bearing selection is now done.

Note that the shaft diameter should be increased to match that of the selected
bearing, #qty[85][mm].

== Practical considerations
- *Lubrication*: To provide a low-frication film which protects from corrosion,
    dissipates heat, and dispel contaminants and moisture.
- *Installation*: It is desirable to heat up to expand the bearing and avoid
    applying heavy axial forces through the rolling elements during
    installation.
- *Preloading*: Internal clearance must be taken up, usually in the axial
    direction with springs.
- *Bearing stiffness*: The ratio of load and deflection. The higher the value,
    the better.
- *Varying loads*: If the load varies considerably, a mean load must be used.
- *Sealing*: Sealing must be provided for dirty or moist environments.
- *Limiting speeds*: In general, larger bearings have lower limiting speeds.
- *Standards and tolerances*: These are important to bearings as they are
    precision machine elements.

= Fasteners
Fasteners connect or join 2 or more components.

== Bolt
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        A bolt is a threaded fastener designed to pass through holes in the
        mating members and to be secured by tightening a nut from the other end.
    ],
    image("./images/fasteners-bolt.png"),
)

=== Materials and strength
- Most fasteners are made from steel, whose strength for bolts and screws is
    used to determine its grade.
- 3 strength ratings are available in tables, tensile strength, yield strength
    and proof strength.
- The proof strength, which roughly refers to the elastic limit of the part, is
    the stress at which the bolt or screw would undergo permanent deformation.
- The proof load is the product of the proof stress times the tensile stress
    area of the bolt or screw, i.e.
    $ P_"proof" = sigma_"proof" A_"tensile" $

#cimage("./images/fasteners-bolt-grades.png")

#let table-18-1 = {
    set math.frac(style: "skewed")
    figure(
        table(
            columns: 6,

            table.header(
                [*SAE grade*],
                [*Material*],
                [*Size range (#unit[in])*],
                [*Minimum tensile strength (#unit[ksi])*],
                [*Minimum yield strength (#unit[ksi])*],
                [*Minimum proof strength (#unit[ksi])*],
            ),

            [1], [Low or medium carbon], [$1/4$ - $1 1/2$], [60], [36], [33],
            [2], [Low or medium carbon], [$1/4$ - $3/4$], [74], [57], [55],

            table.cell(colspan: 2)[],
            table.cell(inset: (y: 0.6em))[$7/4$ - $1 1/2$],
            [60],
            [36],
            [33],

            [4],
            [Medium carbon, cold drawn],
            [$1/4$ - $1 1/2$],
            [115],
            [100],
            [65],

            [5], [Medium carbon, Q&T], [$1/4$ - 1], [120], [92], [85],

            table.cell(colspan: 2)[],
            table.cell(inset: (y: 0.6em))[$1 1/8$ - $1 1/2$],
            [105],
            [81],
            [74],

            [5.2], [Low-carbon martensite, Q&T], [$1/4$ - 1], [120], [92], [85],
            [7],
            [Medium-carbon alloy, Q&T],
            [$1/4$ - $1 1/2$],
            [133],
            [115],
            [105],

            [8],
            [Medium-carbon alloy, Q&T],
            [$1/4$ - $1 1/2$],
            [150],
            [130],
            [120],

            [8.2],
            [Low-carbon martensite, Q&T],
            [$1/4$ - 1],
            [150],
            [130],
            [120],
        ),
        caption: [SAE grade specification for steel bolts],
    )
}

#table-18-1

#let table-18-2 = {
    set math.frac(style: "skewed")
    figure(
        table(
            columns: 8,

            table.header(
                [*ASTM class*],
                [*Material*],
                [*Size range (#unit[in])*],
                [*Minimum tensile strength (#unit[ksi])*],
                [*Minimum yield strength (#unit[ksi])*],
                [*Minimum proof strength (#unit[ksi])*],
                [*Allowable tensile stress (#unit[ksi])*],
                [*Allowable shear stress (#unit[ksi])*],
            ),

            [A307],
            [Low carbon],
            [$1/4$ - $1 1/2$],
            [60],
            [36],
            [33],
            [20],
            [10],

            table.cell(rowspan: 2)[A325, type 1],
            table.cell(rowspan: 2)[Medium carbon, Q&T],
            [$1/2$ - 1],
            [120],
            [92],
            [85],
            [44],
            [17.5],

            [$1 1/8$ - $1 1/2$],
            [105],
            [81],
            [74],
            table.cell(colspan: 2, rowspan: 5)[],

            table.cell(rowspan: 2)[A325, type 2],
            table.cell(rowspan: 2)[Low-carbon martensite, Q&T],
            [$1/2$ - 1],
            [120],
            [92],
            [85],

            [$1 1/8$ - $1 1/2$],
            [105],
            [81],
            [74],

            table.cell(rowspan: 2)[A325, type 3],
            table.cell(rowspan: 2)[Weathering steel, Q&T],
            [$1/2$ - 1],
            [120],
            [92],
            [85],

            [$1 1/8$ - $1 1/2$],
            [105],
            [81],
            [74],

            [A354, grade BC],
            [Alloy steel, Q&T],
            [$1/4$ - $2 1/2$],
            [125],
            [109],
            [105],
            [46],
            [18.5],

            [A354, grade BD],
            [Alloy steel, Q&T],
            [$1/4$ - 4],
            [150],
            [130],
            [120],
            table.cell(colspan: 2)[],

            table.cell(rowspan: 3)[A449],
            table.cell(rowspan: 3)[Medium carbon, Q&T],
            [$1/4$ - 1],
            [120],
            [92],
            [85],
            [44],
            [17.5],

            [$1 1/8$ - $1 1/2$],
            [105],
            [81],
            [74],
            table.cell(colspan: 2, rowspan: 2)[],

            [$1 3/4$ - 3],
            [90],
            [58],
            [55],

            [A490, type 1],
            [Alloy steel, Q&T],
            [$1/2$ - $1 1/2$],
            [150],
            [130],
            [120],
            [54],
            [22],
        ),
        caption: [ASTM class specifications for steel bolts],
    )
}

#table-18-2

#let table-18-3 = figure(
    table(
        columns: 6,

        table.header(
            [*Property class\**],
            [*Material*],
            [*Size range (#unit[in])*],
            [*Minimum tensile strength, $s_y$ (#unit[MPa])*],
            [*Minimum yield strength, $s_y$ (#unit[MPa])*],
            [*Minimum proof strength, $s_p$ (#unit[MPa])*],
        ),

        [4.6], [Low or medium carbon], [M5 - M36], [400], [240], [225],
        [4.8], [Low or medium carbon], [M1.6 - M16], [420], [340], [310],
        [5.8], [Low or medium carbon], [M15 - M24], [520], [420], [380],
        [8.8], [Medium carbon, Q&T], [M16 - M36], [830], [660], [600],
        [9.8], [Medium carbon, Q&T], [M1.6 - M16], [900], [720], [650],

        [10.9],
        [Low-carbon martensite, Q&T],
        [M5 - M36],
        [1040],
        [940],
        [830],

        [12.9], [Alloy, Q&T], [M1.6 - M36], [1220], [1100], [970],

        table.cell(colspan: 6, align: left)[
            \*Number to the left of the decimal point designates approximate
            minimum tensile strength, $s_u$, in hundreds of megapascals.
            Approximate yield strength, $s_y$, in each case, is obtained by
            multiplying $s_u$ times the decimal fraction to the right of (and
            including) the decimal point [e.g. for class 4.6,
            $s_u = #qty[400][MPa]$ and $s_y = 0.6 (400) = #qty[240][MPa]$].
        ],
    ),
    caption: [Metric grade specification (property class) of steels for bolts],
)

#table-18-3

#pagebreak()

=== Bolt failure
#align(center, grid(
    columns: 2,
    column-gutter: 3em,

    figure(
        image("./images/bolt-failure-bracket-deformation.png", height: 15em),
        caption: [Bracket deformation],
    ),

    figure(
        image("./images/bolt-failure-bolt-deformation.png", height: 15em),
        caption: [Bolt deformation],
    ),
))

Other types of bolt failure can include weak wall or plate.

#figure(
    image("./images/bolt-failure-shear.png", height: 18em),
    caption: [Shear failure],
)

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    figure(
        image("./images/bolt-failure-types.png", height: 21em),
        caption: [Failure modes of threaded fasteners],
    ),
    figure(
        image("./images/bolt-failure-tensile.png", height: 21em),
        caption: [Tensile failure],
    ),
))

=== Allowable stresses for bolts
#let table-20-1 = figure(
    table(
        columns: 3,
        align: (left, center, center),

        table.header(
            [*ASTM grade*],
            [*Allowable shear stress*],
            [*Allowable tensile stress*],
        ),

        [A307], qty[69][MPa], qty[138][MPa],
        [A325 and A449], qty[121][MPa], qty[303][MPa],
        [A490], qty[152][MPa], qty[372][MPa],
    ),
    caption: [Allowable stresses for bolts],
)

#table-20-1

Required diameter $D$:
$ "Bolt area," A = frac(pi D^2, 4) $
$ A_t = A_"tensile" = F_e/sigma_a $
$ A_s = A_"shear" = Q_e/tau_a $

=== Bolted connections
#figure(
    image("./images/bolted-connections.png"),
    caption: [A frame containing a loaded bolted joint],
)

- How are the joints to be designed?
- What are the forces, both magnitude and direction, that are carried by the
    fasteners?
- Our aim is to find the *size* ($D$) of bolts for an *allowable stress*.

=== Bolted joints
- The joining of machine parts with bolted joints includes *eccentrically*
    loaded joint, which refer to joints that must resist a combination of direct
    *tensile or shear* stress, and a *bending* moment on a bolt pattern.
- When more than one bolt is used, it is a common practice to make each bolt the
    same size.
- It reduces inventory as well as the possibility of installing the wrong size
    bolt at a given location of the fastener.
- The basic analysis and design of eccentrically loaded joints is to determine
    the forces that act on each bolt because of the applied loads.
- The loads are then combined to determine which bolt carries the maximum load.
    The bolt is then sized.

=== Concentric loading
#cimage("./images/concentric-loading-1.png", height: 14em)
#cimage("./images/concentric-loading-2.png", height: 14em)

Concentric loading is when the resultant force passes through the centre of the
bolt area, as shown above.
- Direct tension of each bolt:
    $ sigma = frac(P, n A) $

    In the first image above, normal to the contact surface, $n = 6$.

- Direct shear of each bolt:
    $ tau = frac(P, m A) $

    In the second image above, lying in the plane of the contact surface,
    $m = 5$.

=== Eccentric loading: Case 1
#cimage("./images/eccentric-loading-case-1.png", height: 15em)


#grid(
    columns: (1fr, 18em),
    column-gutter: 2em,
    [
        - Loading parallel to the bolt axis:
            $ sigma = frac(P, n A) $
        - Direct ($d$) tension of each bolt:
            $ P_"td" = P/n, wide n = 4 $
        - Secondary tension at bolt $i$ due to moment ($m$):
            $ P_"tmi" = frac((P L) L_i, (2 L_1^2 + 2L_2^2)) $

            Derivation:
            + For a proportional load:
                $ P_1/L_1 = P_2/L_2 $
            + Moment equilibrium about point $O$:
                $ P L = 2 (P_1 L_1 + P_2 L_2) $
            + Substituting the first equation into the second:
                $
                    P L & = 2 (P_1 L_1 + P_2 L_2) \
                        & = 2 (frac(P_2 L_1, L_2)) L_1 + P_2 L_2 \
                        & = 2 P_2 [(L_1/L_2) L_1 + L_2] \
                        & = 2 P_2 frac(L_1^2 + L_2^2, L_2)
                $

            + Solving for $P_2$:
                $ P_2 = frac((P L) L_2, 2 L^2 + 2 L_2^2) $
    ],
    [
        #image("./images/eccentric-loading-case-1-secondary-forces.png")

        #v(4em)

        Secondary forces due to $M$ (proportional and balancing forces):
        - The force magnitude proportional to the distance from the centroid of
            a rigid link (pivot or origin $O$):
            $ P_1/L_1 = P_2/L_2 = P_3/L_3 $
        - Moment balancing equation about $O$:
            $ P L = P_1 L_1 + P_2 L_2 + P_3 L_3 $
    ],
)

=== Eccentric loading: Case 2
#cimage("./images/eccentric-loading-case-2.png")

==== Centroid
The location of the centroid of a bolted joint group can be defined with respect
to any convenient $x$-$y$ coordinate origin by:
$
    macron(x) = frac(
        A_1 x_1 + A_2 x_2 + A_3 x_3 + dots.c + A_n x_n,
        A_1 + A_2 + A_3 + dots.c + A_n
    ) = sum_(i = 1)^n frac(A_i x_i, A_i)
$

$
    macron(y) = frac(
        A_1 y_1 + A_2 y_2 + A_3 y_3 + dots.c + A_n y_n,
        A_1 + A_2 + A_3 + dots.c + A_n
    ) = sum_(i = 1)^n frac(A_i y_i, A_i)
$

Where $x_i$ and $y_i$ are the coordinates of each fastener using a
pre-determined coordinate system, and $A_i$ is the cross-sectional area of each
respective fastener.

#pagebreak()

==== Forces
#align(center, grid(
    columns: 2,
    column-gutter: 3em,
    row-gutter: 1em,
    align: center + horizon,

    [Force analysis],
    image("./images/eccentric-loading-case-2-force-analysis.png", width: 15em),

    [Primary or direct shear],
    image("./images/eccentric-loading-case-2-direct-shear.png", width: 15em),

    [Secondary or indirect shear due to moment],
    image("./images/eccentric-loading-case-2-indirect-shear.png", width: 15em),
))

==== Free body diagram: Overall forces
#cimage("./images/eccentric-loading-case-2-free-body-diagram-1.png")

==== Free body diagram: Direct shear load
#cimage("./images/eccentric-loading-case-2-free-body-diagram-2.png")

$ "Direct shear load on the bolt," F_"sdi" = P/4 $

The direction of the forces are shown on the free body diagram above.

#pagebreak()

==== Free body diagram: Secondary forces on bolts
#cimage("./images/eccentric-loading-case-2-free-body-diagram-3.png", width: 70%)

On the bolt group:
$ M = P e $
$ "Secondary forces on bolt" i, F_"smi" = frac(M/4, r_i) $

The direction of the forces are shown on the free body diagram above.

The *secondary force* of bolt 4 is due to the moment in the group of 4 bolts (or
fasteners) obtained by taking the moment about $C$, which is the centroid of the
bolt group:
$ F_4 = frac((P e) r_4, r_1^2 + r_2^2 + r_3^2 + r_4^2) $

General expression for bolt $i$:
$
    F_i = frac((P e) r_i, sum_(i = 1)^n r_i^2) wide "or" wide
    F_i = frac(M r_i, sum_(i = 1)^n r_i^2)
$

For bolt 4:
#cimage("./images/eccentric-loading-case-2-free-body-diagram-4.png", width: 70%)

$ M = P e wide F_"sd4" = P/4 wide F_"sm4" = frac(M/4, r) $

==== Resultant force on bolt $i$
#cimage("./images/eccentric-loading-case-2-resultant-forces.png")

- Find the resultant force of $F_"sd"$ and $F_"sm"$ on bolt $i$
- Nose to tail arrows are the resultant forces

=== Eccentric loading: Case 3
#cimage("./images/eccentric-loading-case-3.png", width: 65%)

For loading perpendicular to the bolt axis:
- Direct shear of each bolt:
    $ P_"sd" = P/n, wide n = 4 $
- Secondary tension at bolt $i$ due to moment:
    $ P_"tmi" = frac((P e) L_i, 2 L_1^2 + 2 L_2^2) $
    $ L_3 = L_2 quad "and" quad L_4 = L_1 $
- Note:
    $ tau = P_"sd"/A quad "and" quad sigma = P_"tm"/A $
- The maximum $P_"tm"$ is on bolts 2 and 3.

==== Combined tension ($F$) and shear ($Q$)
Equivalent *tensile* load:
$ F_e = 1/2 (F + sqrt(F^2 + 4 Q^2)) $

Equivalent *shear* load:
$ Q_e = 1/2 sqrt(F^2 + 4 Q^2) $

Resultant tensile or shear load at the respective joint:
$ F = P_"tm" wide Q = P_"sd" $

Required bolt area (tensile):
$ A_t = F_e/sigma_e "(tensile)" $

Required bolt area (shear):
$ A_s = Q_e/tau_e "(shear)" $

Taking the larger area and hence the larger $D$, given:
$ A = pi (D/2)^2 = pi (d_c/2)^2 $

Note that the allowable tensile and shear stresses are:
$ sigma_e = s_y/N $
$ tau_e = frac(0.5 s_y, N) $

Equivalent tensile stress (maximum principal stress theory):
$
    sigma_e = sigma/2 + sqrt((sigma/2)^2 + tau^2)
    = 1/2 (sigma + sqrt(sigma^2 + 4 tau^2))
$

Equivalent shear stress (maximum shear stress theory):
$
    tau_e = sqrt((sigma/2)^2 + tau^2) = 1/2 sqrt(sigma^2 + 4 tau^2)
$

#pagebreak()

=== Example
Find the bracket in the figure below, assuming the total force is #qty[15568][N]
and the distance $a$ is #qty[304.8][mm]. Design the bolted joint, including the
location and number of bolts, the material, and the diameter.

#grid(
    columns: 2,
    column-gutter: 3em,
    image("./images/fasteners-example-1.png"),
    image("./images/fasteners-example-2.png", height: 23em),
)

Direct shear:
$ F_s = P/n = 15568/4 = #qty[3892][N] $

Secondary shear:
$ F_1 = frac(M r, 4 r^2) = frac(4745 times 63.5, 4 (63.5)^2) #qty[18682][N] $

$ F_(1 x) = F_1 sin theta = F_1 sin 36.9 degree = #qty[11209][N] $
$ F_(1 y) = F_1 cos theta = F_1 cos 36.9 degree = #qty[14945][N] $
$ F_(y) = F_(1 y) + F_z = 14945 + 3892 = #qty[18837][N] $

$ R_1 = sqrt(11209^2 + 18837^2) = #qty[21920][N] $

Specify ASTM A325 (see #link(<table-20-1>)[Table 20-1]) for the bolt material:
$ A_s = R_1/tau_a = 21920/121 = #qty[181.16][mm^2] $
$ d_r = sqrt(frac(4 A_s, pi)) = #qty[15.19][mm] $

For conservative design, determine the bolt diameter using:
$ d = d_r/0.8 $

=== Summary for resultant load analysis
#table(
    columns: 5,
    align: center,

    table.header(
        [*Eccentric case*],
        [*Direct (primary) load*],
        [*Indirect (secondary) load*],
        [*Loading axes (direct or indirect)*],
        [*Resultant load*],
    ),

    [1],
    [Tension, $P_"td"$],
    [Tension, $P_"tm"$],
    table.cell(align: left)[
        - *Same* direction
        - *Same* line with respect to the bolt configuration
    ],
    [
        $ P_"td" + P_"tm" $

        Algebraic sum
    ],

    [2],
    [Shear, $P_"sd"$],
    [Shear, $P_"sm"$],
    table.cell(align: left)[
        - *Different* directions
        - *Same* plane with respect to the bolt configuration
    ],
    [
        $ P_"sd" plus.o P_"sm" $

        Vector sum
    ],

    [3],
    [Shear, $P_"sd"$],
    [Tension, $P_"tm"$],
    table.cell(align: left)[
        - *Different* directions
        - *Different* planes with respect to the bolt configuration
    ],
    [
        Equivalent tension, $F_e$

        Equivalent shear, $Q_e$
    ],
)

== Screw
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        A screw is a threaded fastener designed to be inserted through a hole in
        one member, and into a threaded hole in the other mating member.
    ],
    image("./images/fasteners-screw.png", height: 10em),
)

#pagebreak()

=== Power screws
- *Power screws* and *ball screws* are designed to convert rotary motion to
    linear motion and to exert the necessary force to move a machine element
    along a desired path.
- The screws provide a means for obtaining large mechanical advantage in such
    applications as screw jacks, clamps, etc.

#cimage("./images/fasteners-power-screws.png")

- *Power screws* operate on the principle of the screw thread (external) and its
    mating nut (internal thread).

    If the screw is supported in bearings and rotated while the nut is
    restrained from rotating, the nut will translate along the screw.
- A *ball screw* is similar in function to a power screw, except the different
    configuration.

    The *nut* contains balls that make rolling contact, giving low friction and
    high efficiencies, if compared with power screws.

==== Lead screws
#cimage("./images/fasteners-lead-screws.png", height: 15em)
- Basically a screw and a nut.
- It has a lot of friction, and hence it has a low efficiency of 30%.

==== Ball screws
#grid(
    columns: 2,
    column-gutter: 3em,
    image("./images/fasteners-ball-screws-1.png"),
    image("./images/fasteners-ball-screws-2.png"),
    grid.cell(rowspan: 2, image("./images/fasteners-ball-screws-3.png")),
)
- Same concept except bearing ball in contact with threads.
- It has less friction, and hence it has a higher efficiency of 90%+.

#pagebreak()

=== Threaded fasteners
- Threaded fasteners have the same fundamental principle as the screw.
- Their function is to hold one component of a structure or machine in position
    relative to the frame or some other component.
- Threaded fasteners include through bolts, stud bolts, cap screws, set screws,
    etc.

=== Thread system
- UNC and UNF, USA systems (inch sizes)
- ISO, metric sizes, e.g. M6
- All have the different major (external) diameters, pitch, and tensile stress
    areas.
- Allowable shear and tensile stresses for bolts made from ASTM grade steel.

#cimage("./images/fasteners-thread-system.png", width: 90%)

==== Example
M16 #sym.times 2 means:
- #qty[16][mm] major (external or crest) diameter
- #qty[2][mm] pitch (distance between threads)
- For fine thread series, M16 #sym.times 1.5

#cimage("./images/fasteners-thread-system-m16-x-2.png")

==== Thread designations
- Tables show pertinent dimensions for threads in the American Standard and SI
    metric styles.
- The designer must know the basic major diameter $D$, the pitch of the threads
    $p$, and the area $A$ available to resist tensile loads.

Tensile stress area of an external thread (screw, fastener):
- American standard (@table-18-4):
    $ A_t = (pi/4) (D - 0.9743 p)^2 space #unit[in^2] $
- SI metric (@table-18-5):
    $ A_t = (pi/4) (D - 0.9382 p)^2 space #unit[mm^2] $

==== Diameters of the metric thread
- Metric thread specification is given in #link(<table-18-5>)[Table 18-5]. An
    example of a metric thread specification would be:
    #align(center)[M10 #sym.times 1.5]

    The above defines #qty[10][mm] diameter threads with pitch of #qty[1.5][mm].
- The design of the bolt includes the determination of an appropriate size of
    the bolt, which is given by the basic *major* (or nominal) diameter $d$ and
    pitch $p$.
- In design calculations, the *minor* (or root or core) diameter $d_r$ is often
    used.
- As the code of threads is defined by $d$, it is necessary to convert the minor
    diameter $d_r$ into the major diameter $d$, if $d_r$ is not available in the
    table.
- The following relationship given by the ISO metric screw threads can be used:
    $ d_r = d - 1.22687p $
- Another approximation for the relation can also be used:
    $ d_r = 0.8d wide "or" wide d = d_r/0.8 $

== Washer
A washer is used under either the bolt head or the nut, or both, to distribute
the clamping load over an area to provide a bearing surface for relative
rotation.

#align(center, grid(
    columns: 2,
    column-gutter: 3em,
    image("./images/fasteners-washer-1.png", height: 18em),
    image("./images/fasteners-washer-2.png", height: 18em),
))

== Summary
- Bolted joints are used to join machine parts.
- For concentric and eccentric loadings:
    - Tensile or shear forces
        $
            P = P_"resultant" = P_"td" + P_"tm"
            quad "or" quad P_"sd" plus.o P_"sm"
        $
    - For combined tension ($F$) and shear ($Q$):
        $
            F_e = 1/2 (F + sqrt(F^2 + 4 Q^2)) quad "or" quad
            Q_e = 1/2 sqrt(F^2 + 4 Q^2)
        $
    - Required diameter $D$
        $ "Bolt area," A = frac(pi D^2, 4) $
        $ A_t = A_"tensile" = F_e/sigma_a $
        $ A_s = A_"shear" = Q_e/tau_a $

#pagebreak()

= Machine frames and parts
- The design of machine frames and structures is often the solutions on how the
    components of the machine should be accommodated.
- The designer is often restricted in where supports can be placed to not
    interfere with the operation of the machine or to provide access for
    assembly.
- Technical requirements must be met for the structure.
- Some of the more important design parameters include:
    - Strength
    - Stiffness
    - Appearance
    - Cost to manufacture
    - Corrosion resistance
    - Weight
    - Size
    - Noise reduction
    - Vibration limitation
    - Life time
- As there are many possibilities for the design details of frames and
    structures, one should concentrate on the general guidelines.
- The implementation of the guidelines would depend on the specific application.
- Factors to consider in a frame design include:
    - Forces exerted by the components of the machine through mounting points,
        such as bearings, pivots, brackets, and attachment points with other
        machine elements.
    - Manner of support of the frame.
    - Precision of the system, which is the allowable deflection of its
        components.
    - The environment in which the unit will operate.
    - The quantity of production and the facilities available.
    - Availability of analytical tools, like computerised stress analysis, past
        experience with similar products, and experimental stress analysis.
    - Relationship to other machines, walls, etc.

== Deflections
- Only intimate knowledge of the application of a machine member or frame can
    give a value for an acceptable deflection.
- However, there are some guidelines that are available to give you a place to
    start.

=== Deflection due to bending
- General machine part:

    #qty[0.0005][mm] to #qty[0.003][mm] per #unit[mm] of beam length.

- Moderate precision:

    #qty[0.00001][mm] to #qty[0.0005][mm] per #unit[mm] of beam length.

- High precision:

    #qty[0.000001][mm] to #qty[0.00001][mm] per #unit[mm] of beam length.

#pagebreak()

=== Deflection (rotation) due to torsion
- General machine part:

    $0.001 degree$ to $0.01 degree$ per #qty[25.4][mm] of beam length.

- Moderate precision:

    $0.00002 degree$ to $0.0004 degree$ per #qty[25.4][mm] of beam length.

- High precision:

    $0.000001 degree$ to $0.00002 degree$ per #qty[25.4][mm] of beam length.

=== Design to resist bending
The basic deflection formula for beam deflection due to bending:
#labelled_equation($ Delta = frac(P L^3, K E I) $, "20-1")

Where:
- $P$ is the load
- $L$ is the length between supports
- $E$ is the modulus of elasticity of the material in the beam
- $I$ is the moment of inertia of the cross-section of the beam
- $K$ is a factor depending on the manner of loading and support

#grid(
    columns: 4 * (1fr,),
    column-gutter: 3em,

    [Cantilever], [Simply supported], [Supported cantilever], [Fixed-end],

    image("./images/deflection-cantilever.png"),
    image("./images/deflection-simply-supported.png"),
    image("./images/deflection-supported-cantilever.png"),
    image("./images/deflection-fixed-end.png"),

    $
        M = P a \
        y = frac(P L^3, 24 E I)
    $,
    [
        Basic case

        $
            M_1 = frac(P a, 2) \
            y_1 = frac(P L^3, 48 E I)
        $
    ],
    $
        M = frac(3 P a, 8) \
        y = frac(P L^3, 107 E I)
    $,
    $
        M = frac(P a, 4) \
        y = frac(P L^3, 192 E I)
    $,
)

When designing to resist bending:
+ Keep the length of the beam as short as possible, and place loads close to the
    supports.
+ Maximise the moment of inertia of the cross-section in the direction of
    bending. In general, you can do so by placing as much of the material as far
    away from the neutral axis of bending as possible, as in a wide-flange beam
    or a hollow rectangular section.
+ Use a material with a high modulus of elasticity.
+ Use fixed ends for the beam where possible.

#pagebreak()

=== Design to resist torsion
Torsion can be created in a machine frame member in a variety of ways, such as:
- A support surface may be uneven.
- A machine or motor may transmit a reaction torque to the frame.
- A load acting to the side of the beam axis, or any place away from the
    flexural centre of the beam, would produce twisting.

In general, the torsional deflection of a member can be computed from:
$ theta = frac(T L, G R) $

Where:
- $T$ is the applied torque or twisting moment
- $L$ is the length over which torque acts
- $G$ is the shear modulus of elasticity of the material
- $R$ is the torsional rigidity constant

The designer should carefully choose the shape of the member to obtain a rigid
structure. The following suggestions are made:
- Use closed sections wherever possible. Examples are solid bars with a large
    cross-section, hollow pipe and tubing, closed rectangular or square tubing,
    and special closed shapes that approximate a tube.
- Conversely, avoid open sections made from thin materials. The figure below
    shows some examples.
    #cimage("./images/deflection-torsion-shapes.png", width: 90%)
- For wide frames, brackets, tables, bases, and so on, use diagonal braces
    placed at $45 degree$ to the sides of the frame.
    #cimage("./images/deflection-diagonal-braces.png")
- Use rigid connections, such as by welding members together.

== Design of simple machine parts
+ The dimensions of simple machine parts are determined on the basis of pure
    tensile stress, pure compressive stress, direct shear stress, bending stress
    or torsional stress.
    - The analysis is simple but approximate because the number of factors such
        as the principle stresses, stress concentration, and the reversal of
        stresses are neglected.
    - Therefore, a higher factory of safety of up to 5 is taken to account for
        these factors.
+ It is incorrect to assume allowable stress as data for design. The allowable
    stress is to be obtained from published values of ultimate tensile strength
    and yield strength for a given material.
+ According to the maximum shear stress theory, the yield strength in shear is
    50% of the yield strength in tension. Therefore:
    $ S_"sy" = 0.5 S_"yt" $

    The permissible shear stress ($tau$) is given by:
    $ tau = frac(S_"sy", (f s)) $

    The above value of allowable shear stress is used in the determination of
    the dimensions of the component.

#pagebreak()

=== Example 1
The forces exerted by the levers of the pump on a rocking shaft are shown in
Figure (a) below. The rocking shaft does not transmit torque. It is made of
plain carbon steel 30C8 ($S_"yt" = #qty[400][N mm^-2]$) and the factor of safety
is 5. Calculate the diameter of the shaft.

#grid(
    columns: 2,
    column-gutter: 3em,
    [
        The forces acting on the rocking shaft are shown in Figure (b). Taking
        the moment of forces about bearing $A$:

        $ 20 times 200 + 30 times 800 = R_D times 1050 $
        $ therefore R_d = #qty[26.67][kN] $

        Considering the equilibrium of vertical forces:
        $ R_A + R_D = 20 + 30 $
        $ R_A + 26.67 = 20 + 30 $
        $ R_A = #qty[23.33][kN] $

        The bending moment diagram is shown in Figure (c).
    ],
    image("./images/design-of-simple-machine-parts-example-1.png"),
)

The maximum bending moment at $C$ is $6667.5 times 10^3 #unit[N mm]$.

As:
$ sigma_b = frac(M_b y, I) $
$ I = frac(pi d^4, 64) quad "and" y = d/2 $

We can obtain:
#labelled_equation($ sigma_b = frac(32 M_b, pi d^3) $, "a")

The permissible tensile stress is given by:
$ sigma_t = frac(S_"yt", (f s)) = 400/5 = #qty[80][N mm^-2] $

Substituting the above value into Equation (a), we have:
$
    d^3 = frac(32 M_b, pi sigma_b)
    = frac(32 (6667.5 times 10^3), pi (80))
$
$ d = 94.69 approx #qty[95][mm] $

#pagebreak()

=== Example 2
A shaft transmits #qty[20][kW] of power and rotates at #qty[500][rpm]. The
material of the shaft is 50C4 ($S_"yt" = #qty[460][N mm^-2]$) and the factor of
safety is 2.
#[
    #set enum(numbering: "a)")
    + Determine the diameter of the shaft on the basis on its shear strength.
    + Determine the diameter of the shaft on the basis of its torsional
        rigidity, if the permissible angle of twist is $3 degree$ per meter
        length and the modulus of rigidity of the shaft material is
        #qty[79300][N mm^-2].
]

$
    M_t = frac(60 times 10^6 ("Power"), 2 pi n)
    = frac(60 times 10^6 (20), 2 pi (500))
    = #qty[381971.86][N mm]
$
$ S_"sy" = 0.5 S_"yt" = 0.5 (460) = #qty[230][N mm^-2] $
$ tau = frac(S_"yt", (f s)) = 230/2 = #qty[115][N mm^-2] $

Since:
$ tau = frac(M_t r, J) quad "and" J = frac(pi d^4, 32) $

By rearranging the terms, we can obtain:
$ d^3 = frac(16 M_t, pi tau) $

Substituting numerical values into the above equation:
$ d^3 = frac(16 (381971.86), pi (115)) $
$ d = #qty[25.67][mm] $

For question (b):
$ theta = frac(584 M_t l, G d^4) $
$ 3 = frac(584 (5819/1.86) (1000), 79300 d^4) $
$ d = #qty[31.12][mm] $

#pagebreak()

=== Example 3
A hollow shaft is required to transmit #qty[500][kW] of power at #qty[120][rpm].
The maximum torque is 25% than the mean torque. The shaft is made of plain
carbon steel 45C8 ($S_"yt" = #qty[380][N mm^-2]$) and the factor of safety is
3.5. The shaft should not twist more than $1.5 degree$ in a length of
#qty[3][m]. The internal diameter of the shaft ie $3/8$ times of the external
diameter. THe modulus of rigidity of the shaft material is #qty[80][kN mm^-2].
Determine the external diameter of the shaft on the basis of its shear strength
and on the basis of the permissible angle of twist.

$
    M_6 = frac(60 times 10^6 ("Power"), 2 pi n)
    = frac(60 times 10^6 (500), 2 pi (120))
    = 39788.74 times 10^3 #unit[N mm]
$

The maximum torque is 25% greater than the mean torque. Therefore:
$ M_t = 1.25 (39788.74 times 10^3) = 49735.92 times 10^3 #unit[N mm] $

Also,
$ S_"sy" = 0.5 S_"yt" = 0.5 (380) = #qty[190][N mm^-2] $
$ tau = frac(S_"yt", (f s)) = 190/3.5 = #qty[54.29][N mm^-2] $

As:
$
    J = frac(pi d_o^4 - d_i^4, 32)
    = pi/32 [(8/3 d_i)^4 - d_i^4] = 4.8663 d_i^5 #unit[mm^4]
$
$ tau = frac(M_t r, J) $

Substituting values:
$ 54.29 = frac(49735.92 times 10^3 (1/2 times frac(8 d_i, 3)), 4.8663 d_i^4) $
$ d_i = #qty[63.08][mm] $
$ d_o = frac(8 d_i, 3) = frac(8 (63.08), 3) = #qty[168.22][mm] $

Based on the angle of twist:
$ theta = frac(M_t l, J G) $
$
    frac(1.5 times pi, 1.80)
    = frac(49735.62 times 10^3 (3000), (4.8663 d_i^4) (80000))
$
$ d_i = #qty[61.86][mm] $
$ d_o = frac(8 d_i, 3) = frac(8 (61.86), 3) = #qty[164.95][mm] $

#pagebreak()

= Quick reference

== Belt drives

=== Power
$ P = T omega $

Where:
- $P$ is the power
- $T$ is the torque
- $omega$ is the angular velocity

=== Speed ratio (SR)
$
    "Speed ratio (SR)" =
    frac("Driver speed", "Driven speed")
$

$ "SR" = eta_1/eta_2 = omega_1/omega_2 = R_2/R_1 = D_2/D_1 $

Where:
- $eta$ is the frequency of the motor in #unit[rpm]
- $omega$ is the angular velocity of the motor
- $R$ is the radius of the pulley
- $D$ is the diameter of the pulley

=== Belt speed ($v_b$)
$
    v_b & = R_1 omega_1 = R_2 omega_2 \
        & = R_1 eta_1 R_2 eta_2
$

Where:
- $R$ is the radius of the pulley
- $omega$ is the angular velocity of the motor
- $eta$ is the frequency of the motor in #unit[rpm]

=== Belt drive angle ($alpha$)
$alpha$ is the angle between the belt drive centre line and a straight section
of the belt:

$ alpha = arcsin (frac(D_2 - D_1, 2C)) $

Where:
- $D_1$ is the diameter of the smaller pulley
- $D_2$ is the diameter of the bigger pulley

=== Belt pitch length ($L$)
The length of the belt in pitches:
$ L = 2C + 1.57 (D_2 + D_1) + frac((D_2 - D_1)^2, 4 C) $

=== Centre distance ($C$)
$
    C = frac(B + sqrt(B^2 - 32(D_2 - D_1)^2), 16) #h(5em)
    B = 4 L - 6.28 (D_2 + D_1)
$

=== Angle of contact or wrap ($theta_1$)
$ theta_1 = 180 degree - 2 arcsin (frac(D_2 - D_1, 2C)) $

=== Design procedure
Constraints:
- Belt speed should be between #qty[5][m s^-1] and #qty[33][m s^-1].
- Maximum speed ratio of 3.0 to avoid slippage.
- $theta_1 > 120 degree$ to avoid slippage.
- Recommended centre distance:
    $ D_2 < C < 3 (D_2 + D_1) $

Steps:
+ Determine the service factor from @table-a-2-and-a-3, then multiply it with
    the drive power to obtain the design power.
+ Look at @table-a-2-and-a-3 and use the speed of the *faster shaft* and the
    design power to get a suitable belt cross-section.
+ Select the closest sheave diameter from Appendix A Table A-4.
    - If no belt speed is given, use $v_b = r_1 omega_1 = #qty[20][m s^-1]$.
    - Must check if the pulley speed is within range.
+ Select the centre distance and belt pitch length.
    - Use the tentative centre distance (TCD) to find the tentative belt length
        (TBL):
        $
            "TBL" = 2 times "TCD" + 1.57 (D_2 + D_1)
            + frac((D_2 - D_1)^2, 4 times "TCD")
        $
    - Select a standard belt length from @table-a-1 closest to the TBL.
    - Calculate the actual centre distance.
        $
            C = frac(B + sqrt(B^2 - 32(D_2 - D_1)^2), 16) #h(5em)
            B = 4 L - 6.28 (D_2 + D_1)
        $
+ Find the angle of contact $theta_1$:
    $ theta_1 = 180 degree - 2 arcsin (frac(D_2 - D_1, 2C)) $

    Find the contact correction factor ($C_theta$) from @table-a-4-a-5-and-a-6
    by interpolating between the values.
+ Find the $C_L$ from @table-a-4-a-5-and-a-6 using the belt length.
+ Determine the rated power (RP) from @table-a-7c.
+ Determine the corrected rated power (CRP):
    $ "CRP" = C_theta C_L times "RP" $
+ Find the number of belts:
    $ "Number of belts" = frac("Design power", "Corrected rated power") $
    - Always round up the number of belts.

=== Rules of thumb
- The driving torque $T_1$ is in the *same* direction of rotation as the
    *driver* pulley.
- The driving torque $T_2$ is in the *opposite* direction of rotation of the
    *driven* pulley.
- The tight side tension, $F_1$, gives the direction of the *driven* pulley.

=== Power, torque and belt tensions
#cimage("./images/belt-drive-power-torque-belt-tensions.png")
- For no power loss, transmitted power is:
    $ P = T_1 omega_1 = T_2 omega_2 $
- Torque:
    $ T_1 = (F_1 - F_2) D_1/2 $
    $ T_2 = (F_1 - F_2) D_2/2 $

Where:
- $P$ is the power (#unit[W])
- $omega$ is the shaft angular velocity (#unit[rad s^-1]),
    $omega = (2 pi eta)/ 60$, where $eta$ is in #unit[rpm]
- $T_1, T_2$ is the torque on sheave 1 and 2 respectively (#unit[Nm])
- $D_1, D_2$ is the pitch diameter of sheave 1 and 2 respectively (#unit[m])
- $F_1$ is the tension on the tight side (#unit[N])
- $F_2$ is the tension on the slack side (#unit[N])

=== Parallel tension assumption
Assume $F_2$ and $F_1$ are horizontal.

== Chain drives

=== Pitch diameter of a sprocket
$ D = frac(p, sin (frac(180 degree, N_1))) $

Where:
- $D$ is the pitch diameter
- $p$ is the pitch
- $N$ is the number of teeth

=== Centre distance ($C$)
$
    C = 1/4 {L - frac(N_2 + N_1, 2) + sqrt(
            [L - frac(N_2 + N_1, 2)]^2
            - frac(8 (N_2 - N_1)^2, 4 pi^2)
        )} #unit[pitches]
$

=== Angle of contact ($theta_1$)
$ theta_1 = 180 degree - 2 arcsin [frac(D_2 - D_1, 2 C)] $

=== Speed ratio (SR)
$ "SR" = frac("Input speed", "Output speed") = eta_2/eta_1 = N_2/N_1 $

=== Multiple strand factors
<multiple-strand-factors>
#align(center, table(
    columns: 2,

    table.header([*Number of strands*], [*Multiple strand factor*]),

    [1], [1.0],
    [2], [1.7],
    [3], [2.5],
    [4], [3.3],
    [5], [3.9],
    [6], [4.6],
))

#pagebreak()

=== Design for power procedure
Constraints:
- At least 17 teeth should be used for smooth operation.
- The centre distance should be between 30 and 50 pitches.
- The maximum speed ratio should be about 7:1.
- The calculated chain length should be rounded off to a whole number,
    preferably an even one to avoid having a weaker offset link.
- Don't use more than 4 strands due to high shaft load and low load rating of
    additional strands.

Steps:
+ Obtain the service factor from @table-b-2-and-b-3, and the multiple strand
    factor from @multiple-strand-factors, then calculate the design power per
    strand:
    $
        "Design power per strand" = frac(
            "Power to be transmitted" times "Service factor",
            "Multiple strand factor"
        )
    $
+ Start from the *smallest available chain* on @table-b-4 that is *greater* than
    the design power.
+ Check that the pitch diameter meets the constraints. Obtain the pitch from
    @table-b-1.
+ Obtain the number of teeth ($N_2$) for the larger sprocket by using the
    average of the given speeds and the speed ratio.
    $ N_2 = N_1 (eta_1/eta_2) $
+ Check that the pitch diameter meets the constraints. Obtain the pitch from
    @table-b-1. Otherwise, go back to step 2 and repeat.
+ Calculate the chain pitch length:
    $
        "Tentative centre distance (TCD) in pitches"
        = frac("TCD", p) #unit[pitches]
    $

    Tentative chain length (TCL) in pitches:
    $
        "TCL" = 2 times "TCD" + frac(N_2 + N_1, 2)
        + frac((N_2 - N_1)^2, 4 pi^2 ("TCD"))
    $

    Adjust TCL to the *closest even number* to obtain the standard chain length
    ($L$).
+ Calculate the actual centre distance ($C$):
    $
        C = 1/4 {L - frac(N_2 + N_1, 2) + sqrt(
                [L - frac(N_2 + N_1, 2)]^2
                - frac(8 (N_2 - N_1)^2, 4 pi^2)
            )} #unit[pitches]
    $
+ Select an appropriate type of lubrication from @table-b-4.

=== Design for strength procedure
+ Calculate the maximum load for each chain:
    $ "Maximum load" = F/n $

    Where:
    - $F$ is the load on the chains
    - $n$ is the number of chains
+ Look at @table-b-1 for the maximum allowable load in #unit[kg] (multiply by
    $g$ to get it in #unit[N]), or use 10% of the average tensile strength, if
    not given, and choose a suitable chain.

#pagebreak()

=== Rules of thumb
- The driving torque $T_1$ is in the *same* direction of rotation as the
    *driver* sprocket.
- The driving torque $T_2$ is in the *opposite* direction of rotation of the
    *driven* sprocket.
- The tight side tension, $F_1$, gives the direction of the *driven* sprocket.

=== Power, torque and chain tension
The equations are similar to that for belt drives, except that $F_2 = 0$.
#cimage("./images/chain-drive-power-torque-chain-tension.png")

Transmitted power:
$ P = T_1 omega_1 = T_2 omega_2 $

Torque:
$ T_1 = (F_1 - F_2) D_1/2 $
$ T_2 = (F_1 - F_2) D_2/2 $

Where:
- $P$ is power (#unit[W])
- $omega$ is the shaft angular velocity (#unit[rad s^-1])
- $T_1, T_2$ is the torque on the sprockets 1 and 2 respectively (#unit[Nm])
- $D_1, D_2$ is the pitch diameters of sprockets 1 and 2 respectively (#unit[m])
- $F_1$ is the tension on the tight side (#unit[N])
- $F_2 = 0$ is the tension on the slack side (#unit[N])

#pagebreak()

== Gear drives

=== Properties
Module:
$ m = D/N $

Circular pitch:
$ p = frac(pi D, N) = pi m $

Addendum:
$ a = m $

Dedendum:
$ a = 1.25m $

Centre distance:
$ C = frac(D_G + D_P, 2) = m (frac(N_G + N_P, 2)) $

Outer diameter:
$ D_o = D + 2m $

Tip to tip dimension
$ S_T = D_G + D_P + 2m $

Velocity of rack:
$ v_G = frac(D_P, 2) omega_P $

Where:
- $G$ refers to the gear
- $P$ refers to the pinion, or smaller gear

=== Speed ratio (SR)
$
    "Speed ratio" = "Input speed"/"Output speed" = eta_P/eta_G
    = omega_P/omega_G = N_G/N_P
$

$
    "Train speed ratio" = frac(
        #text[Product of the number of teeth on *driven* gears],
        #text[Product of the number of teeth on *driver* gears]
    )
$

=== Direction of rotation
- For *external* spur gears, the pinion and spur gears rotate in the *opposite*
    direction.
- For *internal* spur gears, the pinion and spur gears rotate in the *same*
    direction.

#pagebreak()

=== Minimum number of pinion teeth to mesh with rack
$ "Minimum" N_P >= frac(2, sin^2 phi.alt) $

Where $phi.alt$ is the pressure angle.

=== Maximum number of gear teeth to mesh with small pinion
$ "Maximum" N_G <= frac(N_P^2 sin^2 phi.alt - 4, 4 - 2 N_P sin^2 phi.alt) $

Where $phi.alt$ is the pressure angle.

=== Ensuring no interference
For a *$20 degree$*, full-depth pinion meshing with a gear:

#table(
    columns: 2,

    table.header([*Number of pinion teeth*], [*Maximum number of gear teeth*]),

    [18], [Infinite (rack)],
    [17], [1309],
    [16], [101],
    [15], [45],
    [14], [26],
    [13], [16],
)

For a pinion meshing with a rack:
#table(
    columns: 2,

    table.header([*Tooth form*], [*Minimum number of teeth*]),

    [$14.5 degree$, involute, full-depth], [32],
    [$20 degree$, involute, full-depth], [18],
    [$25 degree$, involute, full-depth], [12],
)

#pagebreak()

=== Helical gears
- Look at the gear through its hole, and if the teeth leaning to the left, it is
    left-handed. Otherwise, it is right-handed.
- For two meshing helical gears, one must be right-handed, and the other must be
    left-handed.

==== Properties
$ tan phi.alt_t = frac(tan phi.alt_n, cos psi) $

Module:
$ m = frac(m_n, cos psi) $

Pitch diameter
$ D = m N = frac(N m_n, cos psi) $

Addendum:
$ a = m = frac(m_n, cos psi) $

Dedendum:
$ b = 1.25m = 1.25 (frac(m_n, cos psi)) $

Outside diameter:
$ D_o = D + 2 a = (N + 2) m = (N + 2) frac(m_n, cos psi) $

Where:
- $phi.alt_t$ is the transverse pressure angle
- $phi.alt_n$ is the normal pressure angle
- $psi$ is the helix angle
- $m_n$ is the normal module, which is usually given

#pagebreak()

=== Forces
Tangential load ($W_t$):
- The tangential load ($W_t$) on the *driven* gear is in the *same* direction as
    the rotation of the *driven* gear.
- The tangential load ($W_t$) on the *driving* gear is in the *opposite*
    direction as the rotation of the *driving* gear.

$ W_t = T/frac(D, 2) = frac(2 P/omega, D) = frac(2 P, frac(2 pi eta, 60) D) $

Torque ($T$):
- The torque ($T$) on the *driven* gear is in the *opposite* direction as the
    rotation of the *driven* gear.
- The tangential load ($W_t$) on the *driving* gear is in the *same* direction
    as the rotation of the *driving* gear.

Radial load ($W_r$):
- The radial load ($W_r$) is always directed towards the centre of the gear.

$ W_r = W_t tan phi.alt_t $
$ tan phi.alt_t = frac(tan phi.alt_n, cos psi) $

==== Axial load ($W_a$)
$ W_a = W_t tan psi $

- Only *helical, bevel and worm gears* have an axial load.
- The direction of the force is always parallel to the shaft axis.
- The direction of the thrust load is determined by applying the *right-hand
    thumb rule* for *right-handed driving gear*, or the *left-hand thumb rule*
    for *left-handed driving gear*.
    - The *fingers of the hand* are pointed in the direction of rotation of the
        driving gear, and the *thumb* points in the direction of the thrust or
        axial force.
    - The driven gear then has thrust load acting in the direction opposite to
        that of the driving gear.

#pagebreak()

=== Worm gears
Speed ratio:
$ S R = frac("Speed of worm", "Speed of gear") = N_G/N_W $

Where:
- $N_G$ is the number of teeth on the gear
- $N_W$ is the number of threads on the worm gear

Direction of rotation:
#cimage("./images/worm-and-worm-gear-rotation-direction.png")

Pitch line speed:
#align(center, table(
    columns: 2,

    table.header([*Worm ($W$)*], [*Worm gear ($G$)*]),
    $ v_(t W) = frac(pi D_W eta_W, 60) $, $ v_(t G) = frac(pi D_G eta_G, 60) $,
))

$ v_(t W) != v_(t G) $

#cimage("./images/worm-and-worm-gear-speed-ratio.png")

== Shafts

=== Shaft design equation
$ D = {frac(32 N, pi) sqrt((frac(K_(f b) M, s_n'))^2 + 3/4 (T/s_y)^2)}^(1/3) $

Where:
- $D$ is the shaft diameter
- $N$ is the safety or design factor, usually $N = 3$
- $K_(f b)$ is the stress concentration
- $M$ is the bending moment on the shaft
- $s_n'$ modified endurance strength
- $s_y$ is the yield strength
- $T$ is the torque on the shaft

=== Stress concentration ($K_(f b)$)
#table(
    columns: 2,

    table.header([*Interface*], [*$K_(f b)$*]),

    [Sharp shoulder fillet], [2.5],
    [Well-rounded shoulder fillet], [1.5],
    [Retaining ring], [3.0],
    [Profile key seat], [2.0],
    [Sled runner key seat], [1.6],
    [Press fit], [1.0],
)

=== Yield strength ($s_y$)
Refer to @appendix-3 and @appendix-4.

=== Endurance strength ($s_u$)
For a polished shaft:
$ s_n = 0.5 s_u $

Where $s_u$ is the tensile or ultimate strength.

Refer to @figure-5-8 for other surface treatments.

=== Size factor ($C_s$)
#cimage("./images/size-factor.png", width: 95%)

$C_s = 1$ if $D < #qty[7.62][mm]$

If $D$ is unknown, assume $C_s$ first, then iterate later.

=== Reliability factor ($C_R$)
#table-6-1

=== Modified endurance strength ($s_n'$)
$ s_n' = s_n C_s C_R $

#pagebreak()

=== Design procedure
$ D = {frac(32 N, pi) sqrt((frac(K_(f b) M, s_n'))^2 + 3/4 (T/s_y)^2)}^(1/3) $
+ Draw out the loading, torque, shear force, and bending moment diagrams.
    - The torque diagram is similar to that of the shear force diagram, but for
        torque.
    - To determine the direction of the torque, look down the shaft axis, then
        the fingers on the right hand follow the direction of rotation.
        - If the thumb points *in front*, the torque is *negative*.
        - If the thumb points *behind*, the torque is *positive*.
    - The bending moment diagram is the *area under the shear force diagram*.
    - Find the bending moment at each point of the shaft by adding up both axes
        using Pythagoras theorem.
+ Determine the ultimate tensile strength ($s_u$) of the material.
+ Determine the estimated endurance strength ($s_n$) of the material from
    @figure-5-8.
    - If the ultimate strength is higher than the limit of @figure-5-8, use the
        values for $s_u = #qty[1500][MPa]$.
+ Apply a size factor ($C_s$):
    - For diameter $D <= #qty[7.62][mm]$, $C_s = 1.0$
    - For diameter $#qty[7.62][mm] < D <= #qty[50][mm]$,
        $C_s = (D/7.62)^(-0.11)$
    - For diameter $#qty[50][mm] < D <= #qty[250][mm]$,
        $C_s = 0.859 - 0.000837 D$
+ Apply a reliability factor $C_R$.
    #table-6-1
+ The modified endurance strength is given by:
    $ s_n' = s_n C_s C_R $
+ For parts of the shaft that is subjected to only reversed bending, let the
    design stress be:
    $ sigma_d = frac(s_n', N) $

#pagebreak()

== Key

=== Shear stress
$ tau = F/A_s $
$ tau_d = frac(0.5 s_y, N) $
$ L_s = frac(2 T, tau_d D W) $

For square cross-sections:
$ L_s = frac(4 T N, D W s_y) $

Where:
- $tau_d$ is the design shear stress
- $L_s$ is the key length

=== Compressive stress
$ sigma = F/A_c $
$ sigma_d = s_y/N $
$ L_c = frac(4 T, sigma_d D H) $

For square cross-sections:
$ L_c = frac(4 T N, D W s_y) $

=== Design procedure
+ Figure out the actual diameter of the key seat, which is the diameter of the
    shaft at that point.
+ Select the key size from @table-11-1.
+ Specify a suitable design factor ($N$), usually 3.
+ Use equations above to compute the minimum required length of the key.
    - Take the largest key length.
    - Ensure the key length is shorter than the hub length.
+ Specify the final key length. Use @table-a2-1 as a guide for the basic sizes.

#pagebreak()

== Bearings

=== Basic static load rating ($C_0$)
The basic static load is used when the bearings are to rotate at very slow
speeds or are stationary under load. Rarely used.

=== Basic dynamic load rating ($C$)
The basic dynamic load is used when the bearings are rotating under load.

=== Life equation
$ L_d = L_2 = L_1 = (P_1/P_2)^k $
$ L_d = 10^6 (C^k/P_d) #unit[rev] $
$ C = P_d (L_d/10^6)^(1/k) $
$ C_"catalogue" > C_"calculated" $
$ L_(10) = L_(10, h) n times 60 $

Where:
- $L_d$ or $L_2$ is the design life ($L_(10)$) at a load of $P_2$
- $P_1$ or $C$ is the basic dynamic load rating from the catalogue data
- $P_2$ is the design load ($P_d$)
- $L_1$ is the $L_(10)$ life at load $P_1$, which is by default 1 million
    revolutions and 90% reliability
- $L_10$ is the bearing life (#unit[rev])
- $L_(10, h)$ is the bearing life (#unit[h])
- $n$ is the rotation speed of the bearing (#unit[rpm])
- $k$ is the loading factor, which is *3* for *ball* bearings and *$10/3$* for
    *roller* bearings

=== Combined radial and thrust loads
$ P = X V F_r + Y F_a $
$ P = V F_r wide ("if" F_a = 0) $

Where:
- $P = P_d$ is the equivalent radial or dynamic load
- $F_r$ is the applied radial load
- $F_a$ is the applied axial or thrust load
- $V$ is the rotation factor, which is *1.0* for *inner-race* rotation and *1.2*
    for *outer-race* rotation
- $X$ is the radial factor, see @table-14-5 or the next page
- $Y$ is the thrust factor, see @table-14-5 or the next page

==== Table 14-5
#table-14-5

=== Design procedure
+ Assume $Y$ to be 1.5
+ Compute $P = P_d = V X F_r + Y F_a$
+ Compute the required dynamic load:
    $ C = P_d (frac(L_d, 10^6))^(1/k) $
+ Select a bearing having a greater $C$, $C_"catalogue" > C"calculated"$.
+ For the selected bearing, compute $F_a/C_0$ from the given $C_0$.
+ Determine $e$ to compare with $frac(F_a, V F_r)$ from @table-14-5
    $("after computing" F_a/C_0)$.
+ If $frac(F_a, V F_r) > e$, then determine an *updated* $Y$ from @table-14-5.

    If $frac(F_a, V F_r) < e$ or $F_a = 0$, use the equation below for a pure
    radial load.
    $ P = V F_r $
+ Iteration is performed until the following *2 conditions* are met:
    + With the *updated* $Y$ (found at @table-14-5), repeat steps 1 - 7 with the
        *updated* $Y$ if the new
        $C_("updated" Y) > C_"assumed Y"$
    + $C_"catalogue" > C_("updated" Y)$

        If $C_"catalogue" < C_("updated" Y)$, select a bigger bearing and repeat
        step 4.

Select the bearing with a dynamic load rating ($C$) *larger* than the obtained
$C$.

== Fasteners

=== Material properties
- #link(<table-18-1>)[SAE specification]
- #link(<table-18-2>)[ASTM specification]
- #link(<table-18-3>)[Metric specification]
- #link(<table-20-1>)[Allowable stresses]

=== Concentric loading
#cimage("./images/concentric-loading-1.png")
Concentric loading is when the resultant force passes through the centre of the
bolt area.
- Direct tension of each bolt:
    $ sigma = frac(P, n A) $

    Where:
    - $sigma$ is the tensile stress
    - $P$ is the load
    - $n$ is the number of bolts normal to the contact surface
    - $A$ is the area of all the bolts

- Direct shear of each bolt:
    $ tau = frac(P, m A) $

    Where:
    - $sigma$ is the shear stress
    - $P$ is the load
    - $m$ is the number of bolts normal to the contact surface
    - $A$ is the area of all the bolts

=== Eccentric loading: Case 1
#cimage("./images/eccentric-loading-case-1.png")

- Loading parallel to the bolt axis:
    $ sigma = frac(P, n A) $
- Direct tension of each bolt:
    $ P_"td" = P/n $
- Secondary tension at bolt $i$ due to moment:
    $ P_"tmi" = frac((P L) L_i, n_r L_1^2 + n_r L_2^2 + dots.c + n_r L_n^2) $

    Where:
    - $P$ is the load
    - $L$ is the distance of the load from the pivot point $O$
    - $L_i$ is the distance of bolt $i$ to the pivot point $O$
    - $n_r$ is the number of bolts in a row at bolt $i$

=== Eccentric loading: Case 2
#cimage("./images/eccentric-loading-case-2.png")

==== Centroid
$
    macron(x) = frac(
        A_1 x_1 + A_2 x_2 + A_3 x_3 + dots.c + A_n x_n,
        A_1 + A_2 + A_3 + dots.c + A_n
    ) = sum_(i = 1)^n frac(A_i x_i, A_i)
$

$
    macron(y) = frac(
        A_1 y_1 + A_2 y_2 + A_3 y_3 + dots.c + A_n y_n,
        A_1 + A_2 + A_3 + dots.c + A_n
    ) = sum_(i = 1)^n frac(A_i y_i, A_i)
$

Where $x_i$ and $y_i$ are the coordinates of each fastener using a
pre-determined coordinate system, and $A_i$ is the cross-sectional area of each
respective fastener.

==== Direct shear load
$ F_"sd" = P/n $

==== Secondary forces on bolts
#cimage("./images/eccentric-loading-case-2-free-body-diagram-4.png")

$ M = P e $

Secondary force on bolt $i$:
$
    F_i = frac(M r_i, sum_(i = 1)^n r_i^2)
    = frac((P e) r_i, sum_(i = 1)^n r_i^2)
$

For bolt 4:
$
    F_4 = frac((P e) r^4, r_1^2 + r_2^2 + r_3^2 + r_4^2)
    = frac(M r^4, 4 r^4^2) = frac(M, 4 r^4)
$

From the direction of the forces, get the bolt that has the *largest* force and
calculate its resultant force.

=== Eccentric loading: Case 3
#cimage("./images/eccentric-loading-case-3.png")

For loading perpendicular to the bolt axis:
- Direct shear of each bolt:
    $ P_"sd" = P/n $
- Secondary tension at bolt $i$ due to moment:
    $ P_"tmi" = frac((P L) L_i, n_r L_1^2 + n_r L_2^2 + dots.c + n_r L_n^2) $

    Where:
    - $P$ is the load
    - $L$ is the distance of the load from the pivot point $O$
    - $L_i$ is the distance of bolt $i$ to the pivot point $O$
    - $n_r$ is the number of bolts in a row at bolt $i$
- Note:
    $ tau = frac(P_"sd", A) quad "and" quad sigma = frac(P_"tm", A) $
- The maximum $P_"tm"$ is on bolts 2 and 3 in this case.

#pagebreak()

==== Combined tension ($F$) and shear ($Q$)
Equivalent tensile load:
$ F_e = 1/2 (F + sqrt(F^2 + 4 Q^2)) $

Equivalent shear load:
$ Q_e = 1/2 sqrt(F^2 + 4 Q^2) $

Resultant tensile or shear load at the respective joint:
$ F = P_"tm" wide Q = P_"sd" $

Required bolt area (tensile):
$ A_t = F_e/sigma_e $

Required bolt area (shear):
$ A_t = Q_e/tau_e $

Taking the larger area and hence the larger diameter:
$ A = frac(pi D^2, 4) $

The allowable tensile and shear stresses are:
$ sigma_e = s_y/N wide tau_e = frac(0.5 s_y, N) $

Equivalent tensile stress:
$ sigma_e = 1/2 (sigma + sqrt(sigma^2 + 4 tau^2)) $

Equivalent shear stress:
$ tau_e = 1/2 sqrt(sigma^2 + 4 tau^2) $

=== Tensile stress area
$ A_t = (pi/4) (D - 0.9382p)^2 space #unit[mm^2] $

=== Minor diameter ($d_r$)
Note that the minor diameter is used for *all* calculations.
$ d_r = d - 1.22687p $
$ d_r approx 0.8 d quad "or" quad d = d_r/0.8 $

= Appendix

== Figure 5-8
<figure-5-8>
#figure(
    image("./images/figure-5-8.png"),
    caption: [
        Endurance limit modified for surface condition versus tensile strength
        for wrought steel.
    ],
)

== Table 6-1
<table-6-1>
#align(center, figure(table-6-1, caption: [Reliability factors]))

== Table 11-1
<table-11-1>
#cimage("./images/table-11-1.png")

== Table 14-3
<table-14-3>
#cimage("./images/table-14-3-1.png")
#cimage("./images/table-14-3-2.png")
#cimage("./images/table-14-3-3.png")

== Table 14-4
<table-14-4>
#table-14-4

== Table 14-5
<table-14-5>
#table-14-5

== Table 18-1
<table-18-1>
#table-18-1

== Table 18-2
<table-18-2>
#table-18-2

== Table 18-3
<table-18-3>
#table-18-3

== Table 18-4 (Table 19-4)
<table-18-4>
#cimage("./images/table-18-4.png")

== Table 18-5 (Table 19-5)
<table-18-5>
#cimage("./images/table-18-5.png")

== Table 20-1
<table-20-1>
#table-20-1

== Table A2-1
<table-a2-1>
#cimage("./images/table-a2-1.png", height: 97%)

== Appendix 3
<appendix-3>
#cimage("./images/appendix-3-1.png")
#cimage("./images/appendix-3-2.png")

== Appendix 4
<appendix-4>
#cimage("./images/appendix-4-1.png")
#cimage("./images/appendix-4-2.png")

== Appendix A: Belt drive design data
<appendix-a>
#attach-pdf(
    "./pdfs/appendix-a.pdf",
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

== Appendix B: Chain drive design data
<appendix-b>
#attach-pdf(
    "./pdfs/appendix-b.pdf",
    start-page: 2,
    end-page: 6,
    page-heading-map: (
        "2": "Table B-1",
        "3": "Table B-2 and B-3",
        "4": "Table B-4",
    ),
)
