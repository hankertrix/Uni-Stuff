#import "@preview/fancy-units:0.1.1": qty, unit

#set page(numbering: "1")
#set heading(numbering: "1.1")
#set text(font: "New Computer Modern", size: 12pt)

#{
    set document(
        title: "MA3071 P3.15 Product Disassembly Report",
        author: ("Yau Kai Zher", "Venus Wong", "Nicholas Wee"),
    )
    align(center, text(2.5em)[*#context document.title*])
    align(center, text(2em)[ME18 Group B])
    align(center, text(2em)[#context document.author.join(", ")])
    outline()
    pagebreak()
}

#show link: set text(blue)
#set par(leading: 1em, spacing: 2em)
#show heading: set block(below: 1em)

= Abstract
This project aims to disassemble and evaluate the Electrolux Z1220 vacuum
cleaner for adherence to both Design for Manufacturing (DFM) and Design for
Assembly (DFA) guidelines.

A literature review is conducted to obtain the 8 DFM and 8 DFA guidelines, which
are mainly obtained from @boothroyd2010product. The complementary and
contradictory DFM and DFA guidelines are also elaborated upon to show how these
guidelines fit together.

The vacuum cleaner is then evaluated based on the guidelines obtained, and
specific parts, like the wheel holder, are selected for analysis in greater
detail for their adherence to DFM and DFA guidelines.

The shortcomings of the vacuum cleaner parts are then discussed, along with
other concerns, such as durability and repairability. Possible improvements are
provided to improve the vacuum cleaner to be more adherent to DFA and DFM
guidelines, as well as to address the other concerns brought up in the
discussion.

Ultimately, the project is successful in meeting its main objective of
disassembling and evaluating the vacuum cleaner for adherence to both DFM and
DFA guidelines. Expectedly, the vacuum cleaner adheres to most of the
guidelines, with a few exceptions.

#pagebreak()

= Scope and objectives
This project focuses on evaluating the Electrolux Z1220 vacuum cleaner for
adherence to both Design for Manufacturing (DFM) and Design for Assembly (DFA)
principles and providing suggestions for improvements in areas where it falls
short.

#figure(
    image("./images/vacuum-cleaner.png", height: 30em),
    caption: [The disassembled Electrolux Z1220 vacuum cleaner.],
) <vacuum-cleaner>

The objectives of this project are:
+ Understand the key principles of Design for Manufacture (DFM) and Design for
    Assembly (DFA).
+ Analyse the vacuum cleaner's compliance with DFMA guidelines.
+ Identify contradictions and trade-offs between DFM and DFA.
+ Propose potential design improvements for cost, reliability, and ease of
    assembly.

#pagebreak()

= Literature review

== Design for Manufacturing (DFM) and Design for Assembly (DFA) principles
The DFM and DFA principles are [@guns2025 @thakare2025 @boothroyd2010product]:
#figure(
    table(
        align: left,
        columns: 2,
        table.header([*DFM*], [*DFA*]),
        [Use fewer parts], [Minimise part count],
        [Use standard part designs], [Standardise and use common parts],
        [Simplify geometry], [Design for part symmetry],
        [Modularise design], [Design parts with self-aligning features],

        [Match process to material chosen],
        [Design parts with self-fastening features],

        [Design for easy fabrication], [Mistake-proofing (poka-yoke)],

        [Design for realistic tolerances],
        [Minimise re-orientation during assembly],

        [Minimise secondary operations], [Ensure accessibility and visibility],
    ),
)

=== Injection moulding design guidelines @boothroyd2010product
<injection-moulding-guidelines>
+ Design the main wall of uniform thickness with adequate tapers or draft for
    easy release from the mould.
+ Choose the material and the main wall thickness for minimum cost.
+ Design the thickness of all projections from the main wall with a preferred
    value of half of the main wall thickness and not exceeding two-thirds of the
    main wall thickness.
+ Align projections in the direction of moulding or at right angles to the
    moulding direction lying on the parting plane.
+ Avoid depressions on the inner surfaces of the part.
+ Design external screw threads to lie in the moulding plane.

#pagebreak()

== Complementary principles

=== Minimise part count
Reducing the number of parts reduces the cost for manufacturing while speeding
up assembly. For example, an integrated water bottle cap hinge reduces the
number of separate parts.

=== Standardise part designs
Making use of common parts like standard screws or fasteners reduces the
manufacturing cost due to part availability, and reduces the need for special
tools during assembly.

=== Modularise design
In DFM, modular parts can be reused in other products, removing the need to
design and manufacture new parts. In DFA, modular parts are made to be easily
joined and can be assembled quickly, as they are common parts used in multiple
products. An example is IKEA's flat-packed furniture modules
(@ikea-furniture-flat-pack).

#figure(
    image("./images/ikea-furniture-flat-pack.jpg"),
    caption: [IKEA flat-packed furniture. @ikea2025],
) <ikea-furniture-flat-pack>

== Conflicting principles

=== Design parts with self-fastening features
Designing parts with self-fastening features like snap-fits greatly speeds up
assembly time, but makes part geometries more complex, going against the
principle of simplifying geometry in DFM. These features increase manufacturing
time and costs.

= Application
Overall, the vacuum cleaner generally adheres to most DFM and DFA guidelines.
However, there are a few parts of interest that do not adhere to DFM guidelines
that have been selected for analysis in greater detail.

== Wheel holder
#figure(
    image("./images/wheel-holder.png"),
    caption: [Engineering drawing of the wheel holder.],
)

#figure(
    image("./images/wheel-holder-outer-finish.jpg"),
    caption: [Outer finish of the wheel holder.],
) <wheel-holder-outer-finish>

#pagebreak()

=== Adherence to DFM principles
The part has adhered to most of the design principles for DFM, as it is easily
fabricated using a single core and cavity mould. However, the geometry of the
inside is quite complex and can be further simplified.

The thickness of the walls surrounding the two rectangular holes, which are not
as thick as the main wall (the #qty[2][mm] circular outer wall), but are also
insufficiently thin to adhere to the guideline of keeping projections from the
main wall between half and two-thirds of the thickness of the main wall
(@injection-moulding-guidelines). It is difficult to tell whether this is due to
bad tolerances in the mould, but it seems intended, as it is very clearly
thicker than the three #qty[1][mm] ribs around the through hole in the middle,
but it is thinner than the main wall.

Hence, these overly thick walls may result in cooling issues at the junction
between the main wall and these walls due to the junction being thicker. Such
cooling issues include sink marks, which form due to uneven cooling of plastic
and plastic shrinking when cooled. These marks are not present in the part, but
may be present in another part of the same run. Hence, these walls should be
thinner to lower the chances of defects.

Furthermore, there is a stepped transition between the main wall and the bottom
section that sticks out, which does not adhere to the design principle of having
uniform wall thicknesses. Hence, it results in a greater risk of defects due to
voids and sinks. The step transitions should be filleted or chamfered, so that
there is a smooth transition between the main wall and the bottom section,
keeping the wall thickness as uniform as possible to reduce the chances of
defects.

Moreover, the outer finish of the part may not be needed
(@wheel-holder-outer-finish), as it increases costs by 5%. However, it may be
worth having due to the faster assembly time, thanks to workers having an easier
time grabbing the part, but this will need to be empirically tested and
verified.

#pagebreak()

=== Adherence to DFA principles
Similarly, the part has adhered to most DFA principles, with it being very
symmetric and having self-fastening features, like the indent at the bottom of
the through hole for a snap fit. The installation of the part relies only on the
vertical orientation being correct, where it is extremely asymmetric, making it
clear which orientation it should be installed in. The part is also already at
the theoretical minimum number of parts, so it has a perfect DFA index.

Nonetheless, one area of improvement would be to include self-aligning features,
as proper alignment is needed before the snap fit can be passed through the
centre hole. While the top hole #qty[5][mm] larger than the bottom hole and
contains a countersink in the area where the transition between the two holes
is, as it can still be challenging to fit the part into the snap-fit, as the
part is fitted from the bottom.

Thus, having a top surface that is concave towards the centre hole would make it
simple to assemble, as placing the snap fit anywhere on the top surface of the
part will guide it into the centre hole.

However, this improvement may not be worth it, as it greatly compromises DFM
principles. Adding a top surface to the existing part would increase the mould
cost as it is far more complicated to make such a mould and would likely require
moving cores. Alternatively, filling the entire part would be much worse, as it
will result in far greater material costs and far longer cooling times. The risk
of defects greatly increases too due to how thick the part is, greatly
increasing the chances of sink marks and voids due to uneven plastic cooling.

Therefore, the part seems to be fully optimised for DFA, and it is highly
unlikely that there is anything to further improve.

== Crevice tool
#figure(
    image("./images/crevice-tool.jpg"),
    caption: [Engineering drawing of the crevice tool.],
)

=== Adherence to DFM principles
The crevice tool generally adheres to the DFM principles, as it is manufactured
using a single injection-moulded component with a simple and straightforward
core-cavity design. The cylindrical shape, along with the uniform wall thickness
provides symmetry, increasing suitability for fabrication and reducing the risk
of cooling defects such as warping. The engravings and snap-fit features are
integrated directly into the mould, which reduces secondary operations, keeping
production time and cost low.

The only point of contention is that the transition between the cylinder and the
flat-faced area could create a slightly uneven wall thickness, increasing the
risk of localised voids. To avoid this, smooth fillets could be added to help
achieve more even cooling. Overall, the part is well-designed for large-scale
production and requires minimal post-processing.

#pagebreak()

=== Adherence to DFA principles
From an assembly viewpoint, the part also adheres to DFA principles. Its
cylindrical design with uniform geometry makes orientation simple and naturally
guides the crevice tool into its connecting part, simplifying insertion. The
quick-connect and snap-fit features allow for tool-less assembly which
significantly reduces assembly time compared to other fasteners like screws. It
can only be assembled in one orientation due to the symmetry, which minimises
assembly error.

A possible improvement could be enhancing the self-aligning features to make
initial engagement smoother, particularly if tolerances between parts are tight.
Introducing this feature might compromise the manufacturability as the mould
complexity could increase, increasing the production cost. Although the part is
optimised for both DFM and DFA, the multitude of snap-fit mechanisms could make
it difficult to repair or service. Repeated disassembly could also reduce
long-term durability due to fatigue. This highlights the common trade-off
between DFA and repairability, designs that allow quick assembly are often not
made for service after sale.

#pagebreak()

= Discussion

== Possible improvements

=== Plastic threads
Plastic threads in injection-moulded parts significantly increase manufacturing
costs because they require threading cores in the mould. During the moulding
process, these cores must physically unscrew from the part before ejection,
which can add around 10 seconds per piece compared to non-threaded parts.

In high-volume production, this extra cycle time is a massive cost driver.
Moreover, plastic threads are prone to wear, stripping, and cracking under
repeated use, especially when exposed to torque or shock loads.

Making use of metal threaded inserts, which are press-fitted or heat-staked into
the plastic body, eliminates the need for threading cores, improves strength,
and provide durability and reliability compared to plastic threads. However,
they also introduce tighter tolerance requirements and increase assembly costs
due to press-fitting equipment and labour, and require the surrounding plastic
design to be reinforced to avoid cracking under stress.

Despite the higher cost, metal inserts are preferred in applications where long
service life, durability, and high torque resistance are critical.

=== Plastic wheels
The current plastic wheels are unreliable and noisy, hence, making use of
rubber-coated wheels would decrease noise, improve durability and allow for
smoother movement.

#pagebreak()

== Durability
Snap-fit joints are widely used in the vacuum cleaner as they eliminate the need
for fasteners, reduce part count, and allow for quick assembly. However, every
time the snap-fit is flexed during assembly or disassembly, the plastic material
experiences cyclic loading, which causes fatigue failure over long periods of
time, leading to cracks or joint breakage.

The problem is exacerbated if the snap-fit is made from brittle plastics or the
fit requires excessive bending. Once broken, the product becomes difficult or
even impossible to reassemble, reducing serviceability and overall lifespan.

To mitigate this, designers can use tougher materials such as nylon instead of
brittle ABS, make the structure more rigid using thicker roots and rounded
fillets to reduce stress concentration. They can also limit the design to
one-time assembly if repeated access is not required.

= Conclusion
The 4 objectives have been met as our team now understands the principles of DFM
and DFA. The vacuum cleaner complies with most DFA and DFM guidelines, except
for the wheel holder, which has uneven wall thickness. Most DFA and DFM
guidelines are complementary, except that the DFA principle of designing parts
with self-fastening features conflicts with the DFM principle of simplifying
geometry. The vacuum cleaner could also be more durable and repairable with the
addition of metal thread inserts and rubber-coated wheels, as well as having
snap-fit joints made out of less brittle materials.

#pagebreak()

= References
#bibliography(
    "references.bib",
    title: none,
    style: "institute-of-electrical-and-electronics-engineers",
)
