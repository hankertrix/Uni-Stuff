#set page(numbering: "1")
#set heading(numbering: "1.1")
#show link: text.with(blue)
#{
    set document(
        title: "MA2005 Engineering Graphics Notes",
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

= Definitions

== Engineering drawing
Engineering drawing is made up of *graphics language* and *word language*.

== Graphics language
Graphics language describes a shape.

== Word language
Word language describes the size, location, and specification of the object.

== Standards
- Standards are a set of rules that govern how technical drawings are
    represented.
- Drawing standards are used so that drawings *convey the same meaning to
    everyone* who reads them.

== Engineering drawing standards
- International Standards Organisation (ISO)
- American National Standard Institute (ANSI) in USA
- Japanese Industrial Standard (JIS) in Japan
- British Standard (BS) in UK
- GuoBao (GB), China's National Standard
- Deutsches Institut fur Normung (DIS) in Germany

=== Drawing sheet
- Trimmed paper of size A0 - A4
- Standard sheet sizes (ISO), ratio of $1 : sqrt(2)$
    - A4: #qty[210][mm] #sym.times #qty[297][mm]
    - A3: #qty[297][mm] #sym.times #qty[420][mm]
    - A2: #qty[420][mm] #sym.times #qty[594][mm]
    - A1: #qty[594][mm] #sym.times #qty[841][mm]
    - A0: #qty[841][mm] #sym.times #qty[1189][mm]

== Scale
Scale is the ratio of the *linear dimension* (length or size) of an element of
an object shown in the drawing to the real linear dimension of the same element
of the object.

== Drawing scales
- Designation of a scale consists of the word *"SCALE"* followed by the
    indication of its *ratio*, as follows:
    - "SCALE 1:1" for full size
    - "SCALE X:1" for *enlargement* scales ($X > 1$)
    - "SCALE 1:X" for *reduction* scales ($X > 1$)
- *Dimension* numbers shown in the drawing correspond to *"true size"* of the
    object, and they are *independent* of the scale used in creating that
    drawing.

#pagebreak()

== Layout of drawing
#image("./images/layout-of-drawing-1.png")

#image("./images/layout-of-drawing-2.png")

== Basic line types
#image("./images/basic-line-types.png")

- Visible lines (2B #sym.plus.minus #qty[5][mm])
    - Represent features that can be seen in the current view.
- Hidden lines (2H #sym.plus.minus #qty[3][mm])
    - Represent features that cannot be seen in the current view.
- Centreline (2H #sym.plus.minus #qty[3][mm])
    - Represent centres of circles, axis of hole, and axis of symmetrical parts.
- Dimension and extension lines (2H #sym.plus.minus #qty[3][mm])
    - Indicate the sizes and location of features on a drawing.

== Types of lines
#image("./images/types-of-lines-1.png")

#image("./images/types-of-lines-2.png")

Thin chain, short double dashes lines are also called phantom lines.

== Precedence of lines
+ Visible line
+ Hidden line
+ Centreline

== Hidden line
#image("./images/hidden-lines.png")

- Hidden lines are thin short dashes (3 ~ 5 #unit[mm]) with a small gap
    (#qty[1][mm]).
- Hidden lines should join a visible line, except when it extends from a visible
    line.
- The intersection between hidden lines should form an L, T, V or Y corner.

#image("./images/hidden-line-intersections.png")
#pagebreak()

== Centrelines
#image("./images/centreline-uses.png")
- Centrelines (symbol: ℄) are used to indicate symmetrical axes of objects or
    features, bolt circles (pitch circle diameter), and paths of motion.
- Centreline should always *start* and *end* with *long dash*.
- Centrelines should *not* extend between views.
- Centrelines should *extend 3 to 4 #unit[mm]* outside the outline.

    #image("./images/centreline-practices-1.png")

#pagebreak()

- For a small hole, a centreline is presented as a thin continuous line.
- Leave a gap when centreline forms a continuation with a visible or a hidden
    line.

    #image("./images/centreline-practices-2.png")

== Line of sight (LOS)
- Line of sight is an imaginary ray of light between an observer's eye and the
    object.
- There are two types, parallel, and converge (perspective).

#image("./images/line-of-sight.png")
#pagebreak()

== Plane of projection
The plane of projection is an imaginary flat plane where the image is created.

#image("./images/plane-of-projection.png")

== Working drawing
Working drawing is a set of drawings used during the making of a product.

== Detail drawing
Detail drawing is a *multiview representation* of a *single* part with
*dimensions and notes*.

== Assembly drawing
Assembly drawing is a drawing of *various parts* of a machine or structure
assembled in their relative working positions.

== Tolerances
Tolerances are permissible variations in *size, form and location* of individual
features of a part.

== Feature
A feature is a specifi point, line or surface, like the axis of a hole, the edge
of a part, or a single flat or curved surface.

== Axis
An axis is a *theoretical* straight line about which a part or circular feature
revolves.

#cimage("./images/axis-of-shaft.png", width: 90%)

== Circular tolerance zone (CTZ)
Circular tolerance zone (CTZ) is when the resulting tolerance zone is
cylindrical, such as when the straightness of the axis of a cylindrical feature
is specified, a diameter symbol precedes the tolerance value in the feature
control frame (FCF).

#cimage("./images/circular-tolerance-zone.png")
#pagebreak()

== Virtual condition (VC)
Virtual condition is the boundary generated by the combined geometric tolerance
and the size of the part at maximum material condition (MMC).

#cimage("./images/virtual-condition.png")

#pagebreak()

= Orthographic projection

== Types of projection

=== Orthographic projection (2D)
#image("./images/orthographic-projection.png")

=== Axonometric projection (3D)
#image("./images/axonometric-projection.png")

=== Oblique projection (3D)
#image("./images/oblique-projection.png")

=== Perspective projection (3D)
#image("./images/perspective-projection.png")

== Graphical projection
#image("./images/graphical-projection.png")

== Orthographic projection of an object
- The orthographic projection of an object is a 2D representation of an object.
- It represents the different sides of the object.

#image("./images/orthographic-projection-of-an-object-1.png")

#image("./images/orthographic-projection-of-an-object-2.png")

== Orthographic projection systems
- First angle projection is used by the ISO standard and European countries.
- Third angle projection is used by the USA and Canada.
- *Never* combine first and third angle projections in the same drawing.

#image("./images/orthographic-projection-systems.png")
#pagebreak()

== First angle projection
- The plane is *behind* the object.
- Opaque planes.

#image("./images/first-angle-projection.png")

=== Unfolded planes
#image("./images/first-angle-projection-unfolded-planes.png")

=== Position of views
#image("./images/first-angle-projection-views.png")

=== ISO projection symbol
#image("./images/first-angle-projection-symbol.png")
#pagebreak()

== Third angle projection
- The plane is *in front* of the object.
- Transparent planes.

#image("./images/third-angle-projection.png")

=== Unfolded planes
#image("./images/third-angle-projection-unfolded-planes.png", width: 80%)

=== Position of views
#image("./images/third-angle-projection-views.png")

=== ISO projection symbol
#image("./images/third-angle-projection-symbol.png")
#pagebreak()

== Procedure to select a view
- Orient the object to the best position relative to a glass box.
    + The object should be placed in its natural position.
    + The orthographic views should represent the true size and true shape of
        the object.
    #image("./images/selecting-a-view.png")
- Select the front view.
- Select the adjacent views.

#pagebreak()

=== Selecting the front view
+ The longest dimension of an object should be presented as a width.
    #image("./images/select-front-view-longest-dimension.png", height: 15em)
+ The adjacent views project from the selected front view should appear in a
    natural position.
    #image("./images/select-front-view-natural-position.png", height: 15em)
+ The view has the fewest number of hidden lines.
    #image("./images/select-front-view-hidden-lines.png")

#pagebreak()

=== Selecting an adjacent view
+ Choose the view that has the fewest number of hidden lines.
    #image("./images/select-adjacent-views-hidden-lines.png", height: 18em)
+ Choose the minimum number of views that can represent the major features of
    the object.
    #image("./images/select-adjacent-views-minimum-number.png", height: 18em)
+ Choose the views that are suitable for a drawing sheet and leave sufficient
    space for dimensioning.
    #image("./images/select-adjacent-views-drawing-sheet.png", height: 18em)

== Number of views

=== Objects that only require 1 view
- Flat or thin part having a uniform thickness, such as a gasket, sheet metal,
    etc.
- Cylindrical shaped part.

#image("./images/1-view-objects.png")

=== Objects that only require 2 views
- Identical adjacent view exists.
- The 3rd view has no significant contours of the object and hence provides no
    additional information.

#image("./images/2-view-objects.png")

== Steps for drawing orthographic views
+ *First or third angle projection*.
+ *Select* the necessary views.
+ *Layout* the selected views on a drawing sheet.
+ *Complete* views. Ensure that the views are in projection. The views should be
    mutually perpendicular to each other.
+ Complete the dimensions and notes (not required for tutorial).

= Orthographic projection visualisation techniques
- 2 points #sym.arrow Line
- 3 or more lines #sym.arrow Surface
- Surface #sym.arrow Normal, Inclined, Oblique

== Interpreting lines
A straight, visible or hidden line in an orthographic view has three possible
meanings:
- An edge between two surfaces (line CD).
- The edge view of a surface (CDFE).
- The limiting element of a curved surface (AB).

Since no shading is used on orthographic views, you must examine all views to
determine a line's meaning.

#image("./images/interpreting-lines.png")

=== Pay attention to the edges
#image("./images/interpreting-lines-edges.png")

== Views of plane surfaces
- A plane surface that is *perpendicular to a plane of projection* appears on
    the edge as a *straight line*.
- A plane surface that is *parallel to the plane of projection* appears *true
    size*.
- A plane surface that is *angled to the plane of projection* appears
    *foreshortened*.

#image("./images/views-of-plane-surfaces.png")
#pagebreak()

== Normal surface
- A normal surface is *parallel to a plane of projection*.
- Always draw normal surfaces first.

#image("./images/normal-surfaces.png")

== Inclined surfaces
An inclined surface is perpendicular to *one plane of projection but inclined to
adjacent planes*.

#image("./images/inclined-surfaces.png")
#pagebreak()

== Oblique surfaces
An oblique surface is *inclined to all principal planes of projection* and does
not appear true size in any standard view.

#image("./images/oblique-surfaces.png")

== Projection of a normal line
#image("./images/projection-of-a-normal-line.png")

== Projection of a normal surface
#image("./images/projection-of-a-normal-surface.png")

== Projection of a normal plane
2 lines #sym.arrow surface.

#image("./images/projection-of-a-normal-plane.png")

== Projection of an object
#image("./images/projection-of-an-object.png")

== Projection of a curved surface
#image("./images/projection-of-a-curved-surface.png")

== Projection of an inclined line
#image("./images/projection-of-an-inclined-line.png")
#pagebreak()

== Projection of an inclined surface
#image("./images/projection-of-an-inclined-surface-1.png")

Same shape (the same number of sides) on 2 views and an edge on another view.
#image("./images/projection-of-an-inclined-surface-2.png", height: 20em)
#pagebreak()

== Projection of an oblique line
All the lines are *not* true length.
#image("./images/projection-of-an-oblique-line.png")

== Projection of an oblique surface
Same number of sides on all three views.
#image("./images/projection-of-an-oblique-surface.png")
#pagebreak()

== Projection of an oblique plane
- Notice that $A B$ is parallel to $C D$ and $C B$ is parallel to $A D$ on the
    3D model.
- They remain parallel in the orthographic view.
#image("./images/projection-of-an-oblique-plane.png")

== Parallel edges
When edges are parallel to one another on an object, they will *appear as
parallel lines in every view* unless they align one behind the other.

Lines 1 and 2, and 3 and 4 are parallel.
#image("./images/parallel-edges.png")
#pagebreak()

== Analysis by primitives
Identify the primitive shapes.
#image("./images/analysis-by-primitives.png")
#pagebreak()

== Visualising by removal of material
#image("./images/visualising-by-removal-of-material-1.png")
#image("./images/visualising-by-removal-of-material-2.png")
#pagebreak()

== Boolean operations
The three sets of models at the left produce the results show at the right when
the 2 solids are:

#enum(
    numbering: "a)",
    [Unioned / Add],
    [Subtracted],
    [Intersected / Common],
)

#image("./images/boolean-operations.png")
#pagebreak()

== Projection of an object having curved surfaces and planes
A curved surface can either be *tangent or intersect* with an adjacent plane or
curved surface.
- In the case of *intersection*, an *edge* exists and becomes a line in the
    multiview drawing.
- In the case of *a tangent*, there is *no edge* and line in the multiview
    drawing.

#image("./images/projection-curved-surface-and-plane.png")
#pagebreak()

=== Examples
#image("./images/projection-curved-surface-and-plane-example-1.png")
#image("./images/projection-curved-surface-and-plane-example-1.png")
#pagebreak()

= Isometric drawing

== Axonometric projection
Axonometric projection is a projection that results in a view that can see all
faces of an object at once.
#image("./images/axonometric-projection-comparison.png")

- Notice that all the edges are foreshortened due to the projection.
- When all the edges foreshorten equally, the axonometric projection is known as
    an isometric projection.

#pagebreak()

=== Types of axonometric drawing
+ #text(red)[Iso]metric

    #image("./images/isometric-axis.png", height: 5em)
    All angles are equal. The angle between each axis line is $120 degree$, and
    the axes nearest to the horizontal are
    $30 degree$
    away from the horizontal.
+ #text(red)[Di]metric

    #image("./images/dimetric-axis.png", height: 5em)
    #text(red)[Two] angles are equal.
+ #text(red)[Tri]metric

    #image("./images/trimetric-axis.png", height: 5em)
    #text(red)[None] of the angles are equal.

== Isometric projection of a cube
#image("./images/isometric-projection-of-a-cube.png")
#pagebreak()

== Isometric drawing vs isometric projection
- Isometric drawing is drawn on an isometric axes using *full scale*.
- In contrast, an isometric projection is a true projection of an object, and
    hence its edges are foreshortened.

#image("./images/isometric-drawing-vs-isometric-projection.png")
#pagebreak()

== Position of isometric axes
Isometric axes can be arbitrarily positioned to create different views of a
single object.
- Regular isometric
    #image("./images/regular-isometric-position.png", height: 10em)
    The view point is looking down on the top of the object.
- Reverse axis isometric
    #image("./images/reverse-isometric-position.png", height: 10em)
    The view point is looking up on the bottom of the object.

- Long axis isometric
    #image("./images/long-axis-isometric-position.png", height: 10em)
    The view point is looking from the right or left of the object.

#pagebreak()

== Orientation
For a suitable orientation, always pick the orientation that shows the largest
number of faces of the object.

=== Orientation based on the lowest corner
#image("./images/orientation-based-on-lowest-corner.png")
- If the lowest corner is on the front face, draw normal "Y" isometric axis.
- If the lowest corner is on the back face, draw normal or inverted "Y"
    depending on the part shape.

#pagebreak()

=== Orientation based on the highest corner
#image("./images/orientation-based-on-highest-corner.png")
- The front view needs to be adjacent to the top and the left side.
- The right side view needs to be adjacent to the top and the back side.
- For the image on the left, it is wrong because the point A is on the right of
    the front view, instead of being on the left of the front view.

=== Orientation based on the direction of viewing
#image("./images/orientation-based-on-direction-of-viewing.png")

#pagebreak()

== Distances in isometric drawing
- True-length distances are shown along isometric lines.
- Isometric lines are lines that are parallel to any of the isometric axes.
- Draw isometric lines first, then connect the end points of isometric lines to
    non-isometric lines.
#image("./images/distance-in-isometric-drawing.png", height: 10em)

=== Example
#image("./images/distance-in-isometric-drawing-example.png")

- The front view is adjacent to the right side and bottom view.
- The top view is adjacent to the front view and the right side view.
- Point A is at the lowest corner.

== Methods to draw isometric views

=== Draw surfaces on isometric planes first
#image("./images/drawing-surfaces-on-isometric-plane-first.png")

=== Build isometric blocks for each feature
#image("./images/build-isometric-blocks-for-each-feature.png")

=== Project views on isometric plane to inclined surface
#image("./images/project-views-on-isometric-plane-to-inclined-surface.png")

== Drawing isometric ellipse for circle

=== Coordinate method
#image("./images/drawing-isometric-ellipse-for-circle-coordinate-method.png")

#pagebreak()

=== 4-centre method
#image("./images/drawing-isometric-ellipse-for-circle-4-centre-method.png")
+ Draw a square surrounding the circle on the isometric plane.
+ For the major arcs, which are the arcs with a larger radius, pick the opposite
    corner and draw two lines to the start and the end of the arc, then draw the
    arc using a compass.
+ For the minor arcs, which are the arcs with a smaller radius, pick the
    intersection of the drawn radius lines in the previous step as the centre,
    then draw the arc using a compass.

=== Drawing isometric arc or ellipse for the back surface
Project the *centres* of the already drawn arc or ellipse for the front surface
on to the back surface and draw the arc or ellipse using them.
#image("./images/draw-isometric-arc-and-ellipse-for-back-surface.png")

#pagebreak()

= Isometric sketching

== Why sketch?
- Freehand sketches are a helpful way to organise your thoughts and record
    ideas.
- They provide a quick, low-cost way to explore various solutions to design
    problems so that the best choices can be made.
- The following are important skills to keep in mind for sketches and drawings:
    + Accuracy No drawing is useful unless it shows the information correctly.

    + Speed

        Time is money in industry. Work smarter and learn to use techniques to
        speed up your sketching while still producing neat and accurate results.

    + Legibility

        A drawing is a means of communicating with others, so it must be clear
        and legible. Give attention to details.

    + Neatness

        If a drawing is to be accurate and legible, it must also be clean.

#pagebreak()

== Sketching straight lines
+ Hold the pencil naturally.
+ Spot the beginning and end points.
+ Swing the pencil back and forth between the points, barely touching the paper
    until the direction is clearly established.
+ Draw the line firmly with a free and easy wrist and arm motion.

#image("./images/horizontal-and-vertical-lines.png", height: 10em)
#stack(
    dir: ltr,
    spacing: 2em,
    image("./images/sketching-nearly-vertical-inclined-line.png", height: 10em),
    image(
        "./images/sketching-nearly-horizontal-inclined-line.png",
        height: 10em,
    ),
)

If your straight line looks like the line below, you may be gripping your pencil
too tightly or trying too hard to imitate mechanical lines.
#image("./images/sketching-straight-line-too-tight.png")

Slight wiggles are okay as long as the line continues on a straight path.
#image("./images/sketching-straight-line-slight-wiggles.png")

Occasional very slight gaps are find and make it easier to draw straight.
#image("./images/sketching-straight-line-slight-gaps.png")

#pagebreak()

== Sketching small circle

=== Enclosing square method
+ Lightly sketch the square and mark the mid-points.
+ Draw light diagonals and mark the estimated radius.
+ Draw the circle through the eight points.

=== Centreline method
+ Lightly draw a centreline.
+ Add light radial lines and mark the estimated radius.
+ Sketch the full circle.

== Sketching arc

=== Starting with a square
#image("./images/sketching-arc-square.png")

=== Starting with a centreline
#image("./images/sketching-arc-centreline.png")
#pagebreak()

== Sketching orthographic views
To create a well-proportioned sketch, use multiple steps to create lightly
sketched boxes that are then used as guides for the final sketch.
#image("./images/sketching-orthographic-views.png")
#pagebreak()

== Rules for isometric sketching

=== Vertical lines
Vertical lines must be accurately vertical to define object shape (which is
(a)).
#image("./images/isometric-sketching-rules-vertical-lines.png", height: 10em)
- (b) The top appears bigger.
- (c) The bottom appears bigger.

=== Isometric axes
To obtain a natural appearance, isometric axes must be either approximately
$30 degree$ (which is (a)), or flattened, which is less than $30 degree$ (which
is (b)).

#image("./images/isometric-sketching-rules-isometric-axes.png", height: 10em)
- (c) There is distortion inherent in step axes ($gt 30 degree$).

=== Receding edges
The receding edges must either be parallel ((a)) or convergent ((b)).
#image("./images/isometric-sketching-rules-receding-edges.png", height: 10em)
- (c) The receding edges are divergent or separating.

=== Division for symmetry
#image("./images/division-for-symmetry.png")

== Sketch from an actual object
+ Place the object in the position which its shape and features are clearly
    seen.
+ Define an isometric axis.
+ Sketch the enclosing box.
+ Estimate the size and relationship of each detail.
+ Darken all visible lines.

In isometric sketch or drawing, hidden lines are *omitted* unless they are
absolutely necessary to completely describe the object.

== Sketching isometric ellipses
+ Locate the centre of an ellipse using two isometric lines.
+ Sketch an isometric square.
+ Sketch diagonal lines.
+ Mark the point on the diagonal line far from the centre of an ellipse for a
    distance $3/4$ of the half-length of the line.
+ Draw the arcs through both the marked points and the tangent points.
#image("./images/sketching-isometric-ellipses.png", height: 15em)

== Steps in making an isometric sketch

=== Example 1
#image("./images/steps-to-make-isometric-sketch-example-1.png")

=== Example 2
#image("./images/steps-to-make-isometric-sketch-example-2.png")

#pagebreak()

= Holes and threads

== Hole making processes
#cimage("./images/hole-making-processes.png")

== Hole types
#cimage("./images/hole-types.png")

== Basic fasteners
#cimage("./images/basic-fasteners.png")

== Hole callouts
#cimage("./images/hole-callouts.png")
#pagebreak()

== Blind-drilled hole
A blind-drilled hole is a hole which does not pass through the component
completely.

#cimage("./images/blind-drilled-hole.png")
#cimage("./images/blind-drilled-hole-dimensioned.png")

Note that if the hole depth is *not specified*, it indicates a *through hole*.

#pagebreak()

== Counterbore hole
A counterbore hole is used to accommodate the head of a screw.

#cimage("./images/counterbore-hole.png")
#cimage("./images/counterbore-hole-dimensioned.png")

#pagebreak()

== Countersunk hole
A countersunk hole has a section which is conical to receive countersunk screw
heads.

#cimage("./images/countersunk-hole.png")
#cimage("./images/countersunk-hole-dimensioned.png")

#pagebreak()

== Types of threads
#cimage("./images/types-of-threads.png")

- For a single start thread, lead = pitch.
- For a double start thread, lead = 2 pitch.
- For multi-start threads, increase the lead without increasing the pitch.

== Drawing external thread
#cimage("./images/external-thread-drawing.png")

== Drawing threaded hole
#cimage("./images/threaded-hole-drawing.png")

== Thread profiles
V-threads, which are for adjustment and fastening.
#cimage("./images/thread-profile-v-thread.png")

Square, acme and buttress threads, which are for power transmission.
#cimage("./images/thread-profile-power-transmission.png")

== Specification of ISO metric screw threads
$ "M" 20 times 1.5 - 6"g" $

Where:
- "M" refers to ISO metric thread.
- "20" refers to the diameter (#sym.diameter) of the thread.
- "1.5" refers to the pitch of the thread.
- "6g" refers to the tolerance grade of the thread.

#cimage("./images/types-of-pitch.png")

In thread drawing, the following relationship between the minor and major
diameter is used:
$ bold("Minor") "diameter" = bold("Major") "diameter" - "Pitch" $

#pagebreak()

== Metric thread tables
#cimage("./images/metric-course-thread-table.png")
#cimage("./images/metric-fine-thread-table.png")

#pagebreak()

== Blind threaded hole
#cimage("./images/blinded-threaded-hole.png")
#cimage("./images/blind-threaded-hole-sectional-view.png")

Note that the hatching line is drawn to the minor diameter (*thick* line) of the
thread.

#pagebreak()

== Screw threads assembly
The below images show the drawing conventions for a stud, which is a screw that
is threaded at both ends.
#cimage("./images/screw-thread-assembly.png")
#cimage("./images/screw-thread-assembly-sectional-view.png")

== Fasteners in assembly
#cimage("./images/fasteners-in-assembly.png")

#pagebreak()

= Sectional view

== Why use sectional views?
- Clarify details
- Show internal features clearly
- Reduce the number of hidden detail lines required
- Aid dimensioning
- Show cross-section shape
- Clarify an assembly, especially on the relative position and function

#cimage("./images/sectional-view.png")
#cimage(
    "./images/sectional-view-assembly-drawing-of-camshaft-pump.png",
    height: 25em,
)

#pagebreak()

== Full sectioning
- *All* visible lines or features *behind* the cutting plane must be shown.
- Outline should *not* cut across the hatching lines or holes.

#cimage("./images/full-sectioning.png")
#cimage("./images/sectional-view-presentation.png")

#pagebreak()

== Drawing uniform hatching lines at 45#sym.degree
Hatch line ISO standards:
- Thin continuous line (use 2H, darker than construction line).
- Uniformly spaced.
- 45#sym.degree or 135#sym.degree
- Ends on outline.

#cimage("./images/drawing-uniform-hatching-lines.png")

== Sectioning areas
#cimage("./images/sectioning-areas.png")

== Hatching lines
#cimage("./images/hatching-lines.png")

The spacing of the hatching lines depends on the size of the area to be hatched.

#cimage("./images/hatching-lines-other-angles.png")

Hatching lines at 45#sym.degree and 135#sym.degree are avoided when they are
perpendicular or parallel to outlines or axes of parts.

#pagebreak()

=== Assembly drawing
For *different* parts, use *different* angles and spacing.

#cimage("./images/hatching-lines-assembly-drawing.png")

== Sectioning thin parts
#grid(
    columns: 2,
    column-gutter: 3em,
    [
        Thin materials, like sheet metals or a gasket, can be shown entirely
        black.
        #cimage("./images/sectioning-thin-parts-entirely-black.png")
    ],
    [
        For thin parts that are adjacent to each other, a gap of ~1-2 #unit[mm]
        is required for clarity.
        #cimage("./images/sectioning-thin-parts-gap.png")
    ],
)

== Hidden details behind the cutting plane
#cimage("./images/sectional-view-hidden-details-behind-cutting-plane.png")

== Sectioning rules
#grid(
    columns: 2,
    align: horizon,
    [
        - Hatched area is always *completely bounded* by outline.
        - Section lines should be *thin, uniformly spaced at 45#sym.degree or
            135#sym.degree to the outline*, unless the outlines or axes of the
            part is at 45#sym.degree or 135#sym.degree.
        - For the *same part*, hatching lines must be the *same angle and
            spacing*.
        - For *different parts*, hatching lines will be drawn at a *different
            angle and spacing* depending on size.
        - All *visible edges behind the cutting plane* should be *shown*, except
            for removed or revolved sections.
        - *Hidden features should be omitted* in all areas of a section view,
            except for broken out sections.
    ],
    image("./images/sectioning-rules.png", height: 25em),
)

== Sectioning example
#cimage("./images/sectional-view-drawing-example-step-1.png")
#cimage("./images/sectional-view-drawing-example-step-2.png")
#cimage("./images/sectional-view-drawing-example-step-3.png")
#cimage("./images/sectional-view-drawing-example-step-4.png")

=== Alternate solution
#cimage("./images/sectional-view-drawing-example-alternate.png")

== Exceptions in sectioning
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - *Do not* section parts that have no interior details when the cutting
            plane passes *longitudinally* through them.
        - Easily *recognised* by the outside view.
        - Examples include shafts, hexagonal bolts, nuts, screws, washers, keys,
            pins, bearing convention, gear teeth, etc.
    ],
    image("./images/sectioning-exceptions.png"),
)

#cimage("./images/sectioning-exceptions-wrong-vs-right.png")
#pagebreak()

== Sectioning ribs
When the cutting plane passes through a rib longitudinally, it is *not*
sectioned.
#cimage("./images/sectioning-rib-longitudinal.png")

When the cutting plane passes through the rib transversely, it is *sectioned*.
#cimage("./images/sectioning-rib-transverse.png")

== Sectioning examples

=== Rib
#cimage("./images/sectioning-example-rib.png")
#pagebreak()

=== Web: Flatwise cut
#cimage("./images/sectioning-example-web-flat-cut.png")

=== Web: Crosswise cut
#cimage("./images/sectioning-example-web-cross-cut.png")

=== Spoke
#cimage("./images/sectioning-example-spoke.png", height: 30em)

The spokes are not sectioned as sectioning them will give the impression of the
spokes going all the way round, as shown below.
#cimage("./images/sectioning-example-spoke-sectioned-spoke.png", height: 15em)

=== Lug
#cimage("./images/sectioning-example-lug.png")

== Conventional representation of rib
#cimage("./images/sectioning-rib-conventional-representation.png")

== Conventional representation of spoke
#cimage("./images/sectioning-spoke-conventional-representation.png")

== Full sectional view
- The cutting plane passes fully through the object.
- Used widely to avoid dimensioning to hidden lines.
- Used to show internal details clearly.

#cimage("./images/sectioning-full-section.png", height: 50%)

== Offset section
- Offset sections are used to show internal details that lie *along two or more
    parallel planes*.
- Cutting planes are offset accordingly to reveal these internal details.
- *Do not* show the edge views of the cutting plane.

#cimage("./images/sectioning-offset-section.png")

=== Examples
#cimage("./images/sectioning-offset-section-example-1.png", height: 15em)
#cimage("./images/sectioning-offset-section-example-2.png", height: 15em)

== Half section
- A half section is made by passing the cutting plane *halfway* through an
    object and removing a quarter of it.
- A *centreline* is used to separate the sectioned half from the unsectioned
    half of the view.
- *Hidden lines* are omitted in the unsectioned half of the view.
- Cutting plane is at 90#sym.degree.
- Show all visible edges behind the cutting plane.
#cimage("./images/sectioning-half-section.png")

=== Examples
#cimage("./images/sectioning-half-section-example-1.png", height: 18em)
#cimage("./images/sectioning-half-section-example-2.png", height: 18em)

== Aligned section
- Aligned sections are used to show internal details that lie at an angle to the
    principal cutting plane.
- Cutting plane is bent or turned at a suitable angle to reveal these internal
    details.
- The rib is not hatched.
- The axis is shown as a *centreline*.

#cimage("./images/sectioning-aligned-section.png")
#pagebreak()

=== Examples
#cimage("./images/sectioning-aligned-section-example-1.png")
#cimage("./images/sectioning-aligned-section-example-2.png", height: 50%)
#pagebreak()

== Revolved section
<revolved-section>
- A revolved section shows the cross-sectional features of a part.
- No need for additional orthographic views.
- This section is especially helpful when a cross-section varies.

#cimage("./images/sectioning-revolved-section-1.png", height: 40%)
#cimage("./images/sectioning-revolved-section-2.png", height: 40%)

=== Placement
+ Superimposed onto orthographic view.
+ Break from orthographic view.
#cimage("./images/sectioning-revolved-section-placement.png")

=== Example
#cimage("./images/sectioning-revolved-section-use.png")
#pagebreak()

== Removed section
- Removed section is similar to #link(<revolved-section>)[revolved section]
    except it is drawn outside the main outline of the part.
- Used where space is not enough for revolved section.
- Removed section will be placed alongside the cutting plane.
- Can be anywhere but must be labelled properly.
- Outline of the removed section is drawn with *thick continuous line*.

#cimage("./images/sectioning-removed-section-1.png", height: 40%)
#cimage("./images/sectioning-removed-section-2.png")

=== Examples
#cimage("./images/sectioning-removed-section-examples.png")

=== Difference between full section and removed section
A full section shows the features behind the cutting plane.
#cimage("./images/sectioning-removed-section-full-section.png")

A removed section only shows the features at the cutting plane only.
#cimage("./images/sectioning-removed-section-removed-section.png")

== Broken out section (local section)
- Broken out sections are used to show a single internal detail while preserving
    the outside details.
- A break line is used to separate the sectioned portion from the unsectioned
    portion of the view.
- The break line is a thin continuous line (2H) and is drawn freehand.
- There is no cutting plane line.

#cimage("./images/sectioning-broken-out-section.png")

=== Examples
#cimage("./images/sectioning-broken-out-section-examples.png")

#pagebreak()

= True length of lines

== Two straight lines on 2 views and one inclined line
- Line AB is parallel to the vertical plane, so its projection on that plane is
    *true length*.
- #sym.theta is the true inclination of line AB to the horizontal plane.

#cimage("./images/true-length-of-line.png")

== Point view of line
- Line AB is parallel to the horizontal and vertical planes, so its projection
    on those planes are true length.
- When the line of sight is parallel to the true length of a line, it will
    appear as a point.

#cimage("./images/true-length-of-line-point-view.png")
#pagebreak()

== No true lengths (all lines are inclined)
Line AB is not parallel to any plane of projection, so no projected view is true
length.

#cimage("./images/true-length-of-line-no-true-lengths.png")

== Methods of finding true lengths
<methods-of-finding-true-lengths>
Three methods of finding true lengths:
- By revolution
- Triangulation
- Auxiliary views

#cimage("./images/methods-of-finding-true-lengths.png")
#pagebreak()

=== True length by revolution
The plan view is rotated until it is parallel to the XY line. Then its
projection on the vertical plane is the true length.

#cimage("./images/true-length-by-revolution-step-1.png")
#cimage("./images/true-length-by-revolution-step-2.png")
#pagebreak()

Alternate position:
#cimage("./images/true-length-by-revolution-alternate.png")
#pagebreak()

=== True length by triangulation
Given:
- 3 sides of a triangle, the true shape can be determined.
- 2 sides and an angle, the true shape, and hence the true length, can also be
    determined.

#cimage("./images/true-length-by-triangulation-step-1.png")

- In triangle ABO, the base OB is the plan view $a^2 b^2$ of the line, and OA is
    the difference in height between the ends of the line in the elevation, and
    AB is the true length of the line.
- #sym.theta is the true inclination of the line AB to the horizontal plane.

#cimage("./images/true-length-by-triangulation-step-2.png")
#pagebreak()

=== True length by auxiliary view
When projecting, always take the *lengths* from the view *before* the current
view that you are using for the projection.

#cimage("./images/true-length-by-auxiliary-view-step-1.png")
#cimage("./images/true-length-by-auxiliary-view-step-2.png")

- Reference line $X'Y'$ must be parallel to a principal view of the line.
- #sym.theta is the true inclination of the line AB to the horizontal plane.

#pagebreak()

== Identifying true lengths in orthographic views
+ Both views with *horizontal* lines means *both* lines are *true length*.
+ One view with *inclined* line and one view with a *horizontal* line means the
    *inclined* line is the *true length*.
+ One view with a *vertical* line and one view with a *point* means the
    *vertical* line is *true length*.
+ Both views with *vertical* lines means both lines are *not true length*.
+ Both views with *inclined* lines means both lines are *not true length*.

#cimage("./images/true-length-identifying-in-orthographic-view.png")
#pagebreak()

= True shape
<true-shape>
Steps:
+ Obtain a *true length line*, by any of the methods in
    @methods-of-finding-true-lengths.
+ If such a line doesn't exist, draw a horizontal line on any view and project
    it onto the other view to obtain a true length line.
+ Convert the true length line into a *point*, by projecting using a plane
    perpendicular to the true length line.
+ The view with the true length line being converted to a point is called the
    *edge view*. Project from it and take the lengths from the view *before* it.

== Converting a true length line to an edge view
#cimage("./images/true-shape-converting-line-to-edge.png")
#pagebreak()

== Example 1
#cimage("./images/true-shape-example-1-step-1.png")
#cimage("./images/true-shape-example-1-step-2.png")
#pagebreak()

To draw the auxiliary front view:
+ Project from the plan view.
+ Transfer vertical distance from the front view.
#cimage("./images/true-shape-example-1-step-3.png")

== Example 2
#cimage("./images/true-shape-example-2-step-1.png")
#cimage("./images/true-shape-example-2-step-2.png")

To draw the auxiliary front view:
+ Project from the plan view.
+ Transfer vertical distance from the front view.
#cimage("./images/true-shape-example-2-step-3.png")

== Example 3 (Oblique surface)
#cimage("./images/true-shape-example-3-step-1.png")
#cimage("./images/true-shape-example-3-step-2.png")
#cimage("./images/true-shape-example-3-step-3.png")
#cimage("./images/true-shape-example-3-step-4.png")
#cimage("./images/true-shape-example-3-step-5.png")
#pagebreak()

= Piercing point
Same steps as the steps in @true-shape, with these additional pointers:
- Project not just the shape, but also the line.
- Figure out which section of the line is in front of the shape and which
    section is behind by seeing if the piercing point comes before the points on
    the shape.
- Project the line onto the other views by drawing the lines on the other view
    *first*, then project the line back onto the previous view to see if it
    encounters the shape or the line first. If it encounters the shape first,
    the line is behind the shape, otherwise, the line is in front of the shape.

== Example
All drawings in this example are in *third angle projection*.
#cimage("./images/piercing-point-example-step-1.png", height: 49%)
#cimage("./images/piercing-point-example-step-2.png", height: 49%)
#cimage("./images/piercing-point-example-step-3.png", height: 49%)
#cimage("./images/piercing-point-example-step-4.png", height: 49%)
#cimage("./images/piercing-point-example-step-5.png", height: 49%)

= Angle between 2 planes
Same steps as the steps in @true-shape.

== Obtaining the edge view of the true length line
#cimage("./images/true-angle-obtaining-edge-view-step-1.png")
#cimage("./images/true-angle-obtaining-edge-view-step-2.png")
#cimage("./images/true-angle-obtaining-edge-view-step-3.png")
#cimage("./images/true-angle-obtaining-edge-view-step-4.png")

== Example 1
#cimage("./images/true-angle-example-1-step-1.png")
#cimage("./images/true-angle-example-1-step-2.png")
#cimage("./images/true-angle-example-1-step-3.png")
#cimage("./images/true-angle-example-1-step-4.png")
#cimage("./images/true-angle-example-1-step-5.png")
#cimage("./images/true-angle-example-1-step-6.png")
#pagebreak()

== Example 2
All the drawings in this example are in third angle projection.
#cimage("./images/true-angle-example-2-step-1.png", height: 45%)
#cimage("./images/true-angle-example-2-step-2.png", height: 45%)
#cimage("./images/true-angle-example-2-step-3.png", height: 49%)
#cimage("./images/true-angle-example-2-step-4.png", height: 49%)
#cimage("./images/true-angle-example-2-step-5.png", height: 49%)
#cimage("./images/true-angle-example-2-step-6.png", height: 49%)

== Dihedral angle
The dihedral angle is the angle formed by two intersecting planes. A view in
which each of the given planes appears in edge view shows the true size of the
dihedral angle.
#cimage("./images/true-angle-dihedral-angle.png")
#cimage("./images/true-angle-finding-dihedral-angle.png")
#pagebreak()

= Skew and intersecting lines

== Intersecting lines
When two lines intersect, the point of intersection will align in all views.
#cimage("./images/intersecting-lines.png", height: 40%)

== Skew lines
Skew lines do not intersect. Their apparent point of intersection will not align
in all views.
#cimage("./images/skew-lines.png", height: 40%)

== Checking for visibility of skew lines
#cimage("./images/visibility-of-skew-lines.png")
#pagebreak()

= Shortest distance between two lines
Same steps as the steps in @true-shape, with these additional pointers:
- One of the lines has to be converted to a point to find the shortest distance,
    like in @true-shape.
- The shortest distance would be the perpendicular distance from the point view
    of one line to the other line.

== Example
All the drawings in this example are in third angle projection.
#cimage("./images/shortest-distance-example-step-1.png", height: 40%)
#cimage("./images/shortest-distance-example-step-2.png", height: 40%)
#cimage("./images/shortest-distance-example-step-3.png", height: 49%)
#cimage("./images/shortest-distance-example-step-4.png", height: 49%)
#cimage("./images/shortest-distance-example-step-5.png", height: 49%)
#cimage("./images/shortest-distance-example-step-6.png", height: 49%)

#pagebreak()

= Auxiliary projection of solid
#grid(
    columns: 2,
    column-gutter: 2em,
    [
        - Sometimes, view of an object by orthographic projection are either
            *insufficient* to describe the object with inclined face, or is
            *difficult* to draw or dimension.
        - An auxiliary view which is projected from a *normal* elevation or
            plane is called the *first auxiliary elevation or plan*.
        - Other auxiliary views may be projected from *first auxiliary*
            elevation or plane, which is called the *second auxiliary elevation
            or plan*.
        - *True shape of a surface* can be projected onto a plane which is
            *parallel to the surface*.
    ],
    image("./images/auxiliary-views-reasons.png"),
)

== Dimensioning views that show true shape
#cimage("./images/auxiliary-views-dimensioning-true-shape-views.png")

== Using partial views
#cimage("./images/auxiliary-views-partial-views.png")

== Purpose of auxiliary view
An auxiliary view is an orthographic view projected onto a plane other than the
principal planes.

It is used to find:
- The true shape of an inclined or oblique surface.
- The true length.
- The true angle.
- The shortest distance.

Remember that:
- The viewing plane must be parallel to the surface to get the true size and
    shape.
- The projectors must be perpendicular to the plane.

#cimage("./images/auxiliary-views-auxiliary-plane.png")

== Auxiliary projection of solid
The figure below shows a block in *third angle* projection.
+ Draw an auxiliary plan to show the true shape of the inclined surface.
+ Draw an auxiliary front view as seen in the direction of arrow A.
Hidden lines are required.

#cimage("./images/auxiliary-views-auxiliary-projection-of-solid-question.png")

Plan where to place your reference line:
#cimage("./images/auxiliary-views-auxiliary-projection-of-solid-step-1.png")
#cimage("./images/auxiliary-views-auxiliary-projection-of-solid-step-2.png")

== Steps
+ Position reference line.
    - Parallel to inclined surface.
    - Perpendicular to line of sight.
+ Project from front view.
    - Projection lines must be perpendicular to the reference line.
+ Transfer vertical distance from the plan or side view.

For first angle projection, the view should be behind the arrowhead, and for
third angle projection, the view should be in front of the arrowhead.

== Reference plane or datum
Instead of using one of the planes of projection, you can use a reference plane
or line parallel to the plane of projection that touches or cuts through the
object. Lengths *perpendicular* to the folding line are measured relative to the
reference plane.

#cimage("./images/auxiliary-views-reference-plane.png")
#pagebreak()

== Example 1
The figure below shows a block with an *oblique* surface in third angle
projection.
+ Draw the *first auxiliary view* of the block to show the *true angle* of
    inclination of the oblique surface to the horizontal plane.
+ Draw the *secondary auxiliary view* of the block to show the *true shape* of
    the oblique surface.
Show all *hidden details*.

#cimage("./images/auxiliary-views-example-1-question.png", width: 80%)
#cimage("./images/auxiliary-views-example-1-step-1.png")
#cimage("./images/auxiliary-views-example-1-step-2.png")
#cimage("./images/auxiliary-views-example-1-step-3.png")
#cimage("./images/auxiliary-views-example-1-step-4.png")
#cimage("./images/auxiliary-views-example-1-step-5.png")
#pagebreak()

== Example 2

=== First angle projection
The figure below show the front view and plane of a block in first angle
projection.

Draw an auxiliary front view along the arrow Q. All construction lines, outlines
and hidden lines are to be shown clearly.

#cimage(
    "./images/auxiliary-views-example-2-question-1st-angle.png",
    height: 25em,
)
#cimage("./images/auxiliary-views-example-2-answer-1st-angle.png")

=== Third angle projection
The figure below show the front view and plane of a block in third angle
projection.

Draw an auxiliary front view along the arrow Q. All construction lines, outlines
and hidden lines are to be shown clearly.

#cimage(
    "./images/auxiliary-views-example-2-question-3rd-angle.png",
    height: 25em,
)
#cimage("./images/auxiliary-views-example-2-answer-3rd-angle.png")
#pagebreak()

=== Comparison between 1st and 3rd angle projection
The views are the same in first and third angle projection, only the relative
positions are changed.

#cimage("./images/auxiliary-views-example-2-comparison.png")

== Example 3

=== First angle projection
#cimage("./images/auxiliary-views-example-3-1st-angle.png")

=== Third angle projection
#cimage("./images/auxiliary-views-example-3-3rd-angle.png")

=== Comparison between 1st and 3rd angle projection
The views are the same in first and third angle projection, only the relative
positions are changed.

#cimage("./images/auxiliary-views-example-3-comparison.png")
#pagebreak()

== Example 4

=== First angle projection
- The original plan S is not used when projecting the second auxiliary
    elevation.
- Heights in both elevations are equal.
- Widths across both plans are equal

#cimage("./images/auxiliary-views-example-4-1st-angle.png", width: 90%)

=== Third angle projection
- The original plan S is not used when projecting the second auxiliary
    elevation.
- Heights in both elevations are equal.
- Widths across both plans are equal

#cimage("./images/auxiliary-views-example-4-3rd-angle.png", width: 90%)

=== Comparison between 1st and 3rd angle projection
The views are the same in first and third angle projection, only the relative
positions are changed.

#cimage("./images/auxiliary-views-example-4-comparison.png")

#pagebreak()

= Dimensioning
Dimensioning is the process of defining the *size, form and location* of
geometric features and components on an engineering drawing to facilitate
*manufacturing and inspection*.

The *information* has to be:
- Clear
- Complete
- Facilitate the manufacturing method and measurement method

*Basic* information:
- Sizes and locations of features
- Material
- Number required

*Higher level* information:
- Tolerances, like size and geometric tolerances
- Surface roughness
- Manufacturing or assembly process description

Drawings with dimensions and notes serve as manufacturing or construction
documents and legal contracts.

#cimage("./images/dimensioning-adapter-drawing.png")
#pagebreak()

== Types of dimensions
- Size dimensions, which define *size* (height, widths, thickness, diameters,
    etc.) and shapes (#sym.phi.alt, R, #sym.square, SD, SR)
- Location dimensions, which *locate* the features with respect to each other or
    to a reference surface or centreline (axis).

In the image below, "S" refers to a size dimension and "L" refers to a location
dimension.

#cimage("./images/dimensioning-types-of-dimensions.png")
#pagebreak()

== Functional and non-functional dimensions
+ Functional (F)
    - Based on the function of the component.
    - Shows the method of locating.
+ Non-functional (NF)
    - Does not directly affect the function.
    - Used for production and inspection.
+ Auxiliary (AUX)
    - For information only (not for production or inspection)
    - Tolerances do not apply.
    - Enclosed in parentheses.
+ Datum (reference surface, axis)
    - A reference line on the drawing from which the component is dimensioned.

#cimage(
    "./images/dimensioning-functional-and-non-functional-dimensions.png",
    height: 40em,
)

=== Example
#cimage(
    "./images/dimensioning-functional-and-non-functional-dimensions-example"
        + ".png",
)

#pagebreak()

== Functional dimensioning
- Function first, which dimensions are critical to how the part functions?
- Finished surface to finished surface.
- Finished surface to the centre of radial features.
- Centre to centre.
- Fill in the rest according to good dimensioning practices, without
    over-dimensioning.
- Holes need to be located relative to:
    + Finished surface
    + Axis of machined hole

#cimage("./images/dimensioning-functional-dimensioning.png")

=== Example
#grid(
    columns: 3,
    align: center,
    column-gutter: 2em,
    [
        #image("./images/dimensioning-functional-dimensioning-example-1.png")

        Holes are referenced from a work datum. This is *used in machining*.
    ],
    [
        #image("./images/dimensioning-functional-dimensioning-example-2.png")

        Distance between the two holes is important. This is the *function of
        the product*.
    ],
    [
        #image("./images/dimensioning-functional-dimensioning-example-3.png")

        *Overall length is not so important*.
    ],
)

#pagebreak()

== Dimensioning elements
+ Extension or projection lines
    - Indicate the location on the objects' features that are being dimensioned.
    - Short extension beyond the dimension lines and a small gap from the
        features point or line. (Note that the ISO standard has no gap.)
+ Dimension lines terminate with arrowheads.
    - Indicate the direction and extent of a dimension.
    - Placed outside the part wherever possible and spaced adequately away from
        the outlines. (1.5 to 2 times text height)
    - Longer lines are placed outside the shorter ones to avoid crossing the
        projection lines.
+ Dimensions should be placed near the middle, slightly above the dimension
    lines. They may also be placed to the right or left to avoid congestion.
+ Dimension is placed such that it is read from the bottom and the right-hand
    side of the drawing sheet.
+ Leader lines are used for notes, dimensions and balloons, and terminates in an
    arrowhead or dot.
+ Notes
    - Local
    - General note

#cimage("./images/dimensioning-elements.png")
#pagebreak()

=== Aligned (ISO) vs Unilateral (ANSI)
#grid(
    columns: 2,
    [
        #image("./images/dimensioning-aligned.png")

        Aligned (ISO R129)

        Used in this course.

        Dimension values are placed above the dimension lines and are read from
        the bottom and right-hand side of the paper.
    ],
    [
        #image("./images/dimensioning-unilateral.png")

        Unilateral (ANSI)

        Dimension values are placed in between the dimension lines and are read
        from the bottom.
    ],
)

== Dimensioning practices
- Always leave a *visible gap* of about #qty[1][mm] from a view or centreline
    before drawing the extension line.
- Extend the lines *beyond* the last dimension line by about #qty[2][mm].
#cimage("./images/dimensioning-practice-1.png")
#pagebreak()

- Dimension lines should be *appropriately spaced apart* from each other and the
    view.
#cimage("./images/dimensioning-practice-2.png")

- The height of numbers should be from #qty[2.5][mm] to #qty[3][mm].
#cimage("./images/dimensioning-practice-3.png")
#pagebreak()

- When there is *not enough space* for the number or the arrows, put it
    *outside* either of the extension lines.
#cimage("./images/dimensioning-practice-4.png")

- Units used are *not stated directly* except for angles.
#cimage("./images/dimensioning-practice-5.png")

- Extension lines and leader lines *should not cross* dimension lines.
- Place longer dimensions outside shorter ones.
#cimage("./images/dimensioning-practice-6.png")
#pagebreak()

- Extension lines *should be* drawn from the nearest points to be dimensioned.
#cimage("./images/dimensioning-practice-7.png")

- *Do not* break the extension lines as they cross any line types.
- The extension line is always a *continuous* line.
#cimage("./images/dimensioning-practice-8.png")
#pagebreak()

- *Do not* use outline, centreline and hidden lines as dimension lines.
#cimage("./images/dimensioning-practice-9.png")

- *Avoid* dimensioning from hidden lines.
#cimage("./images/dimensioning-practice-10.png")
#pagebreak()

- Place dimensions *outside* the view, unless placing them inside improves the
    clarity.
#cimage("./images/dimensioning-practice-11.png")

- Apply the dimension to the view that clearly represents the *contour or shape
    of a feature*.
#cimage("./images/dimensioning-practice-12.png")
#pagebreak()

- Dimension lines should be *lined up* and grouped together as much as possible.
#cimage("./images/dimensioning-practice-13.png")

- *Avoid* repeating a dimension (redundant dimension).
#cimage("./images/dimensioning-practice-14.png")
#pagebreak()

- Place the notes *near to the feature* to which they apply, and they should be
    placed *outside* the view.
- Notes are always read *horizontally*.
#cimage("./images/dimensioning-practice-15.png")

=== General dimensioning rules
- Dimension features in the view where they can be seen as *true size and
    shape*.
- Dimension on the view that shows the *contour* of the features.
- Ensure that all dimensions are accounted for. *Do not over or under
    dimension*.
- If you want to include dimensions for reference, place them in parentheses
    *(XX)*.
- Circular features should be located by dimensioning to the *centrelines*.
- Use *diameter* dimensions for circles (> 180#sym.degree).
- Use *radial* dimensions for circles (< 180#sym.degree).
- *Concentric circles* should be dimensioned in a *longitudinal view*.
- Dimension holes in circular view and do not use radii.
- Place dimensions away from the profile lines.
- Allow space between individual dimensions.
- A gap must exist between the profile lines and the extension lines.
- Dimension outside view.
- Larger dimensions outside smaller ones.
- Dimensions should be uniformly spaced.
- Group associated dimensions.
- Leader lines should not be drawn at horizontal or vertical angles.
- The size and style of leader line, text, and arrows should be consistent
    throughout the drawing.
- When extension lines or centrelines cross visible object lines, gaps should
    not be left in the lines.
- Display only the number of decimal places required for manufacturing
    precision.
- Avoid dimensioning to hidden lines where possible.
- Use a centreline to indicate symmetry.
- Assume 90#sym.degree unless specified.
- Each dimension must have a tolerance.
- Clarity.

=== Omit redundant dimensions
#cimage("./images/dimensioning-redundant-dimensions-1.png")
#cimage("./images/dimensioning-redundant-dimensions-2.png")

=== Poor dimensioning vs good dimensioning
#cimage("./images/dimensioning-poor-vs-good-example-1.png")
#cimage("./images/dimensioning-poor-vs-good-example-2.png")
#pagebreak()

=== Dimensioning radii
- R precedes the dimension value.
- One terminator at the intersection of the dimension line and the arc.
- If the centre falls outside the available space, the dimension line of the
    radius should be either broken or interrupted perpendicular according to
    whether or not it is necessary to locate the centre.

#cimage("./images/dimensioning-radii.png")

=== Dimensioning diameters
#cimage("./images/dimensioning-diameters.png")

=== Dimensioning spheres
#cimage("./images/dimensioning-spheres.png")

=== Dimensioning arc lengths, chords, and angles
#cimage("./images/dimensioning-arcs.png")

=== Dimensioning chamfers
#cimage("./images/dimensioning-chamfers.png")

=== Dimensioning squares and flats
#cimage("./images/dimensioning-squares-and-flats.png")

=== Dimensioning undercuts
#cimage("./images/dimensioning-undercuts.png")

=== Dimensioning keyways
#cimage("./images/dimensioning-keyways.png")

=== Dimensioning tapers and slopes
#cimage("./images/dimensioning-tapers-and-slopes.png")

For the image at the bottom, the angle is obtained by:
$
    "Taper" & = (D - d)/L \
            & = (42 - 30)/60 \
            & = 12/60 = 1/5 = 1:5
$

$
    tan alpha/2 & = frac(D - d, 2L) \
                & = frac(42 - 30, 2 times 60) \
                & = 0.1
$

$ alpha/2 = 5 degree 42' 38'' $

=== Dimensioning equally spaced, repeated features
#cimage("./images/dimensioning-repeated-features-1.png")
#cimage("./images/dimensioning-repeated-features-2.png")
#cimage("./images/dimensioning-repeated-features-3.png")

=== Dimensioning symmetrical parts
#cimage("./images/dimensioning-symmetrical-parts.png")

=== Dimensioning to intersection
#cimage("./images/dimensioning-to-intersection.png")

Intersecting construction and projection lines should extend slightly beyond
their point of intersection.

=== Dimensioning concentric circles
#cimage("./images/dimensioning-concentric-circles.png")

== Arrangement of dimensions

=== Chain dimension
#cimage("./images/dimensioning-chain.png")

=== Parallel dimension
#cimage("./images/dimensioning-parallel-1.png")
#cimage("./images/dimensioning-parallel-2.png", height: 35em)

=== Combined dimension
#cimage("./images/dimensioning-combined.png")

== Dimensioning according to manufacturing method
#cimage("./images/dimensioning-according-to-manufacturing-method-1.png")
#cimage("./images/dimensioning-according-to-manufacturing-method-2.png")

== Dimensioning key seat
A key seat is dimensioned according to the standard sizes of a key or to
facilitate a manufacturing process.
#cimage("./images/dimensioning-keyseat.png")

=== Example: Detailing keyway
#cimage("./images/dimensioning-detailing-keyway-1.png")
#cimage("./images/dimensioning-detailing-keyway-2.png")

== Example: How to dimension a part?
- What are the most critical dimensions for the function of the assembly?
- How do we dimension to minimise variation in critical relationships?

#cimage("./images/dimensioning-example-question.png")

The arm must support the shaft at the correct distance above.

=== Step 1: Machined features or surfaces
#cimage("./images/dimensioning-example-step-1.png")

=== Step 2: Location dimensions
#cimage("./images/dimensioning-example-step-2.png")

=== Step 3: Finished size dimensions
#cimage("./images/dimensioning-example-step-3.png")

=== Step 4: Other size dimensions
#cimage("./images/dimensioning-example-step-4.png")

=== Step 5: Annotation and general notes
#cimage("./images/dimensioning-example-step-5.png")
#pagebreak()

= Working drawing
Working drawing is a set of drawings used during the making of a product. It
includes detail drawing and assembly drawing.
- Detail drawing is a *multiview representation* of a single part with
    dimensions and notes.
- Assembly drawing is a drawing of *various parts* of a machine or structure
    assembled in their relative working positions.

== Assembly and detail drawing example
#cimage("./images/working-drawing-assembly-and-detail-drawings.png")

== Isometric views
#cimage("./images/working-drawing-isometric-views.png")

== Purpose of working drawings
- Detail drawing conveys the information and instructions for manufacturing the
    part.
- Assembly drawing conveys:
    + The completed shape of the product.
    + Overall dimensions.
    + The relative position of each part.
    + The functional relationship among various components.

== Detail drawing
Drawings with dimensions and notes serve as manufacturing or construction
documents and legal contracts.

#pagebreak()

=== Generating detailed drawings
+ Create part model and define custom properties.
+ Generate drawings for documentation.

#cimage("./images/working-drawing-detail-drawing-example.png")

=== Interpreting detail drawing
#cimage("./images/working-drawing-interpreting-detail-drawing.png")
#pagebreak()

=== Information in detail drawing
+ General information, which is stored in the title block.
+ Part information
    + Shape description, which are the object views.
    + Size description, which are the object views.
    + Specifications, which are in the notes in the drawing.

==== General information
- Name of the company
- Title of the drawing, which is usually the part's name
- Drawing sheet number
- Name of the drafter and checker
- Relevant dates of action, like when it is drawn, checked and approved, etc.
- Revision table.
- Unit
- Scale
- Method of projection

==== Part information
- Shape
    - Orthographic drawing
    - Pictorial drawing
- Size
    - Dimensions and tolerances
- Specifications
    - Part number, name, number required
    - Type of material used
    - General notes
    - Heat treatment
    - Surface finish
    - General tolerances

=== Recommended practice for detail drawing
- Draw one part on one sheet of paper.
- If the above is not possible:
    - Apply *enough spacing* between parts.
    - Draw all parts using the *same scale*.
    - Otherwise, the scale should be clearly noted under each part's drawing.
- Standard parts such as *bolt, nut pin, and bearing* do not require detail
    drawings.

== Assembly drawing
#cimage("./images/working-drawing-assembly-drawing-example.png")

=== Types of assembly drawing
+ Exploded assembly drawings

    The parts are separately displayed, but they are aligned according to their
    assembly positions and sequences.

+ General assembly drawings.

    All parts are drawn in their working position.

+ Detail assembly drawings

    All parts are drawn in their working position with completed dimensions.

#pagebreak()

==== Exploded assembly
Pictorial representation:
#cimage("./images/working-drawing-exploded-assembly-pictorial.png")

Orthographic representation:
#cimage("./images/working-drawing-exploded-assembly-orthographic.png")

==== General assembly
#grid(
    columns: 2,
    align: center,
    [
        #image("./images/working-drawing-general-assembly-1.png", height: 30em)

        Only dimensions that relate to the machine's operation are given.
    ],
    [
        #image("./images/working-drawing-general-assembly-2.png")

        Only dimensions that relate to the machine's operation are given in
        tabulated form (not shown above).
    ],
)

#cimage("./images/working-drawing-general-assembly-3.png")

==== Detailed assembly
#cimage("./images/working-drawing-detailed-assembly.png")

=== Required information in general assembly drawing
+ *All parts are drawn in their operating position*.
+ *Part list, or bill of materials (BOM)*:
    + Item number
    + Descriptive name
    + Material (MATL)
    + Quantity required per unit of machine (QTY)
+ *Leader lines* with *balloons* around *part numbers*.
+ *Machining* and *assembly operations* and *critical dimensions* related to the
    operation of the machine.

#pagebreak()

=== Leader line practices
+ Keep leader lines *short*.
- For radial features, *align the leader line with its centre*.
- Draw *at an angle* to the horizontal or vertical.
- Terminate with an *arrow head on the outline*.
- Terminate with a *dot within the outline* of the part.
- Keep balloons *in line*.

#cimage("./images/working-drawing-leader-line-practices.png")

=== Part list (BOM)
The part list is placed in the bottom right corner, which is preferred, or in
the top left or right corner.

=== Steps to create assembly drawing
+ *Analyse* geometry and dimensions of all parts to understand the assembly
    steps and overall shape of device or machine.
+ Select an appropriate view.
+ *Choose major parts*, like the parts that have several parts assembled on, and
    place it at the default assembly origin if using CAD.
+ Draw a view of the *major parts* according to a selected viewing direction.
+ Add detailed view of the remaining parts at their working positions.
+ Apply *sectioning techniques* where relative positions between adjacent parts
    require clarification.
+ Add *balloons, notes* and *dimensions*, if any.

=== General assembly drawing practices
- The *number of views* can be one, two, three or more as needed, but it should
    be a *minimum*.
- A good *viewing direction* is one that represents all, or most of the parts
    assembled in their working position.
- *Do not* draw section lines on the sectional view of standard parts.

=== Assembly sectioning practices
+ Adjacent parts are hatched to a different spacing and angle.
+ Standard parts, such as bolts, screws, washers and nuts are shown using
    outside view if cut along its axis.
+ For shafts, pins and handles, they are normally also not hatched if cut along
    its axis. Use local sections to illustrate internal details.
+ Do not hatch ribs or webs if cut along the thin side.

#cimage(
    "./images/working-drawing-assembly-sectioning-practices.png",
    width: 90%,
)

*Hidden lines* are usually *omitted* unless they are absolutely necessary to
illustrate some important feature that the reader might otherwise miss.

#cimage(
    "./images/working-drawing-assembly-section-omit-hidden-line.png",
    width: 90%,
)
#pagebreak()

==== Examples
#cimage("./images/working-drawing-assembly-section-example-1.png", height: 31%)
#cimage("./images/working-drawing-assembly-section-example-2.png", height: 31%)
#cimage("./images/working-drawing-assembly-section-example-3.png", height: 31%)

=== Common mistakes
#cimage("./images/working-drawing-assembly-section-common-mistakes.png")

=== Summary of key steps
+ Angle of projection, either first or third angle.
+ Types of views, like sectional views, sectioning conventions, what are the
    parts to skip sectioning if cut along axis.
+ Plan layout (project assembled views)
+ Ensure correct assembly.
    + Name
    + Quantity
    + Check hole and shaft mating dimensions
    + Orientation of given parts
    + Special requirement
+ Name section and show cutting plane
+ Provide a bill of materials (BOM) or parts list
    + Leader terminates with dot (inside outline) or arrow (on outline)
    + Keep leader short and balloons inline
    + For BOM in bottom right corner, item number starts from the bottom and
        goes up.
    + For BOM in the top right corner, item number starts from the top and goes
        down.

== Interpreting assembly drawing

=== Example 1

#cimage("./images/working-drawing-assembly-example-1.png", height: 60%)

==== Assembly steps
+ Install the bearing to the shaft.
+ Install the bearing-shaft unit to the housing.
+ Install the cover plate.
+ Tighten the screw.


==== Functions of the main parts
+ Bearing:
    - Support the rotating shaft.
+ Cover:
    - Control axial movement.
    - Prevent the bearing unit from rotation.

==== Design concept
*Avoid* direct contact between the rotating shaft and the housing, as well as
the cover plate by using a bearing and clearance holes.

=== Example 2

#cimage("./images/working-drawing-assembly-example-2.png", height: 65%)

==== Assembly steps
+ Wrap a packing to the shaft.
+ Install studs to the casing.
+ Install the gland ring where its holes align with the stud.
+ Place the washer and tighten the nut.

==== Functions of the main parts
+ Packing:
    - Prevents the leakage of a fluid inside the casing.
+ Gland:
    - Press the packing to make it radial, then make it expand and press the
        shaft's surface.

==== Design concept
Avoid direct contact between the rotating shaft and the casing, as well as the
gland ring's hole.

#pagebreak()

=== Example 3

#cimage("./images/working-drawing-assembly-example-3.png")

==== Assembly steps
+ Place the keys on the key seats.
+ Insert the parts until their surfaces lean against the shoulder.
+ Insert the collar and then pin and clip the retaining ring onto the groove.

==== Functions of the main parts
+ Key:
    - Prevents the rotational movement of parts.
+ Pin and retaining ring:
    - Prevents axial movement of parts on the shaft.

==== Design concept
Retaining ring can resist lower axial force than the collar and pin unit.

#pagebreak()

=== Example 4

#cimage("./images/working-drawing-assembly-example-4.png")

==== Assembly steps
+ Insert the part on the tapered end of the shaft.
+ Insert the washer (non-standard).
+ Tighten the nut.

==== Functions of the main parts
+ Washer:
    - Improve the distribution of the tightening force on the part.

==== Design concept
Length of the tapered portion and the depth of the tapered hole have to be
determined to ensure proper function.

=== Example 5

#cimage("./images/working-drawing-assembly-example-5.png")

==== Assembly steps
+ Insert the spring into the casing.
+ Tighten the rod to the spring loader.
+ Close the cap and tighten.

==== Functions of the main parts
+ Spring plunger:
    - Transmit a force from the rod to the spring.

==== Design concept
The spring plunger has a spherical surface that contacts the cap. Therefore, the
rod can align itself to the original position.

#pagebreak()

= Limits and fits
- Exact dimensions and shapes could not be attained in manufacturing.
- Parts are made within specified limits, i.e. tolerances, for
    interchangeability.
- In general, greater accuracy costs more money.

== Terminology
#align(center)[#table(
    columns: 3,
    align: center,
    table.header(
        table.cell(text(white)[*Terminology*], fill: blue),
        table.cell(text(white)[*Example*], fill: blue),
        table.cell(text(white)[*Explanation*], fill: blue),
    ),

    [*Basic size*], [48.00], [Theoretical size, like the diameter of a shaft.],

    [*Basic size with tolerance added*],
    [48.00 #sym.plus.minus 0.02],
    [Half of the total tolerance.],

    [*Limits of size*],
    [48.02 (upper limit) #linebreak() 47.98 (lower limit)],
    [Largest and smallest sizes permitted. Both are design size.],

    [*Tolerance*],
    [0.04],
    [Difference between limits of size (always positive)],

    [*Actual size*],
    [Any size between 48.02 and 47.98 (inclusive)],
    [Measured diameter (size) of a shaft],

    [*Unilateral tolerance*],
    grid(
        columns: 2,
        column-gutter: 1em,
        align: horizon,
        grid(
            columns: 2,
            row-gutter: 0.5em,
            [], [+0.04],
            [48.00], [-0.00],
        ),
        [#text(orange)[(1)]],
    ),
    [],

    table.cell(rowspan: 2)[*Bilateral tolerance*],
    grid(
        columns: 2,
        column-gutter: 0.5em,
        align: horizon,
        [48.00 #sym.plus.minus 0.02], text(blue)[(2)],
    ),
    [Equal bilateral],
    grid(
        columns: 2,
        column-gutter: 1em,
        align: horizon,
        grid(
            columns: 2,
            row-gutter: 0.5em,
            [], [+0.03],
            [48.00], [-0.01],
        ),
        [(3)],
    ),
    [Unequal bilateral],

    [*Maximum material size*],
    grid(
        columns: 2,
        row-gutter: 0.5em,
        column-gutter: 0.5em,
        align: horizon,
        [48.04], text(orange)[(Example 1)],
        [48.02], text(blue)[(Example 2)],
        [48.04], [(Example 3)],
    ),
    [Part containing the maximum amount of material. Note the maximum limit of
        the size for the shaft and the minimum limit of the size for the hole.],
)]

#pagebreak()

== Maximum material condition (MMC)
The maximum material condition is when a feature of a part contains the maximum
amount of material for its size limit. It is the maximum limit of size for
external features, and the minimum limit of size for internal features.

#cimage("./images/limits-mmc.png")

== Least material condition (LMC)
The least material condition is when a feature of a part contains the least
amount of material for its size limit. It is the minimum limit of size for
external features, and the maximum limit of size for internal features.

#cimage("./images/limits-lmc.png")

== Ways to express tolerances
#cimage("./images/limits-ways-to-express-tolerances.png")

== Limit dimensioning
#cimage("./images/limits-limit-dimensioning.png")

== Bilateral dimensioning
#cimage("./images/limits-bilateral-dimensioning.png")

== Unilateral dimensioning
#cimage("./images/limits-unilateral-dimensioning.png")

== Decimal places in dimensioning
Both limits of size are expressed to the same number of decimal places. This is
applicable to both metric and inch drawings.
#cimage("./images/limits-same-decimal-place.png")

=== Inch drawings
The dimension is given to the *same* number of decimal places as its tolerance.
#cimage("./images/limits-inch-tolerances.png")
#pagebreak()

=== Metric drawings
The dimension *need not* be shown to the same number of decimal places as its
tolerance.
#cimage("./images/limits-metric-tolerances.png")

== Tolerance accumulation

=== Chain dimensioning (greatest tolerance accumulation)
#cimage("./images/limits-tolerance-chain-dimensioning.png")

=== Datum dimensioning (less tolerance accumulation)
#cimage("./images/limits-tolerance-datum-dimensioning.png")

=== Direct dimensioning (least tolerance accumulation)
#cimage("./images/limits-tolerance-direct-dimensioning.png")
#pagebreak()

== Fits
The fit between two mating parts is the relationship between them with respect
to the amount of clearance or interference present when they are assembled.

=== Clearance fit
A fit between mating parts having limits of size so that a clearance is always
present when assembled.
#cimage("./images/limits-clearance-fit.png")

- A clearance fit is intended for easy and accurate assembly of parts. The parts
    can be assembled by hand or machine as the hole is always larger than the
    shaft.
- Includes running fit, sliding fit, and locational clearance fit.

Examples: link pin, rod bolt, bearings, rotary shaft, sliding piston, etc.

#cimage("./images/limits-clearance-fit-example.png", width: 80%)

=== Interference fit
A fit between mating parts having limits of size so that an interference always
results when assembled.
#cimage("./images/limits-interference-fit.png")

- An interference fit is intended for parts requiring rigidity and alignment.
- May result in permanent assemblies. The parts can only be assembled by a
    machine such as an arbour press.
- Includes press fits, drive fits, force fits and locational interference fit.

Examples: dowel pins, bearing mounting, crank pin, etc.

#cimage("./images/limits-interference-fit-example.png", width: 80%)
#pagebreak()

=== Transition fit
A fit between mating parts having limits of size so that they either partially
or wholly overlap, such that there is either a clearance or an interference may
result when assembled.
#cimage("./images/limits-transition-fit.png")

- A transition fit is a compromise between clearance and interference fits for
    applications where the accuracy of the location is important, but either a
    small amount of clearance or interference is permissible.
- Parts can be assembled by hand with a light push or hammer blows.

Examples: Shaft keys, ball race, etc.

#pagebreak()

== Tolerance block diagram

=== Definitions
#align(center)[#table(
    columns: 3,
    align: center,
    table.header(
        table.cell(text(white)[*Terminology*], fill: blue),
        table.cell(text(white)[*Example*], fill: blue),
        table.cell(text(white)[*Explanation*], fill: blue),
    ),

    [*Basic size*], [48.00], [Theoretical size, like the diameter of a shaft.],

    [*Limits of size*],
    grid(
        align: center,
        row-gutter: 0.5em,
        [47.98],
        [47.94],
        [48.02],
        [48.06],
    ),
    grid(
        align: center,
        row-gutter: 0.5em,
        [Max size (shaft)],
        [Min size (shaft)],
        [Min size (hole)],
        [Max size (hole)],
    ),

    [*Upper deviation*],
    grid(
        align: center,
        row-gutter: 0.5em,
        [-0.02 (shaft)],
        [-0.06 (hole)],
    ),
    [The algebraic difference between the max limit of size and basic size, e.g.
        $48.98 - 48.00 = -0.02 "(shaft)"$, $48.06 - 48.00 = 0.06 "(hole)"$],

    [*Lower deviation*],
    grid(
        align: center,
        row-gutter: 0.5em,
        [-0.06 (shaft)],
        [0.02 (hole)],
    ),
    [The algebraic difference between the max limit of size and basic size, e.g.
        $48.94 - 48.00 = -0.06 "(shaft)"$, $48.02 - 48.00 = 0.02 "(hole)"$],

    [*Fundamental deviation*],
    grid(
        align: center,
        row-gutter: 0.5em,
        [-0.06 (shaft)],
        [0.02 (hole)],
    ),
    [Deviation closest to the basic size.],
)]

#cimage("./images/limits-tolerance-block-diagram-definition.png")

=== Block diagram
#cimage("./images/limits-tolerance-block-diagram.png")

=== Minimum and maximum difference
Maximum difference in size is given by:
$ "LMC (hole)" - "LMC (shaft)" $

Minimum difference in size is given by:
$ "MMC (hole)" - "MMC (shaft)" $

#align(center)[#table(
    columns: 3,
    align: center,
    table.header(
        table.cell(text(white)[*Type*], fill: blue),
        table.cell(text(white)[*Minimum*], fill: blue),
        table.cell(text(white)[*Maximum*], fill: blue),
    ),

    [*Clearance fit*], [Positive or 0], [Positive],
    [*Interference fit*], [Negative], [0 or negative],
    [*Transition fit*], [Negative], [Positive],
)]

#cimage("./images/limits-min-and-max-difference.png")

#pagebreak()

==== Minimum and maximum clearance
Maximum clearance (positive) is given by:
$ "LMC (hole)" - "LMC (shaft)" $

Minimum clearance (positive) is given by:
$ "MMC (hole)" - "MMC (shaft)" $

==== Minimum and maximum interference
Maximum interference (negative) is given by:
$ "MMC (hole)" - "MMC (shaft)" $

Minimum interference (negative) is given by:
$ "LMC (hole)" - "LMC (shaft)" $

== Description of fits
- *Running and sliding fits* represents a special type of *clearance fit*. It is
    intended to provide a similar running performance, with suitable lubrication
    allowance, through the range of sizes.
- *Locational fits*, which are intended to determine only the location of mating
    parts. They are divided into locational clearance fit, locational transition
    fit and locational interference fit.
- *Drive and force fits*, which represent a special type of interference fit,
    normally characterised by maintenance of constant bore pressures.

#pagebreak()

== Standard inch fits
- First complete standard resulting from discussion between America, Britain and
    Canada.
- They are designed for design purposes in specifications and design sketches by
    means of symbols. These symbols are not intended to be shown directly on
    drawings.

#cimage("./images/limits-standard-inch-fit.png", height: 30em)

== Fit symbols and grades
#align(center)[#table(
    columns: 6,
    align: center,
    table.header(
        table.cell(text(white)[*Type*], fill: blue),
        table.cell(text(white)[*Clearance fit*], fill: blue),
        table.cell(text(white)[*Transition fit*], fill: blue, colspan: 2),
        table.cell(text(white)[*Interference fit*], fill: blue, colspan: 2),
    ),

    [*Letter symbols*],
    grid(
        align: center,
        row-gutter: 0.5em,
        [*RC*],
        [Running and sliding fit],
    ),
    grid(
        align: center,
        row-gutter: 0.5em,
        [*LC*],
        [Locational clearance fit],
    ),
    grid(
        align: center,
        row-gutter: 0.5em,
        [*LT*],
        [Locational transition fit],
    ),
    grid(
        align: center,
        row-gutter: 0.5em,
        [*LN*],
        [Locational interference fit],
    ),
    grid(
        align: center,
        row-gutter: 0.5em,
        [*FN*],
        [Force or shrink fit],
    ),
)]

== Fit symbols and grades (not important)
#cimage("./images/limits-fit-symbols-and-grades.png")

=== Running and sliding fit
- RC1, precision sliding fit, intended for accurate location of parts that must
    be assembled without perceptible play. For example, for high precision work
    such as gauges.
- RC2, sliding fit, intended for accurate location but with greater maximum
    clearance than class RC1. It can move or turn easily but not move or turn
    freely.
- RC3, precision running fit, which is the closest fit that can be expected to
    run freely. It is intended for precision oil-lubricated bearings at slow
    speeds and light journal pressures.
- RC4, close running fit, intended chiefly as a running fit for grease or
    oil-lubricated bearings on accurate machinery with moderate surface speeds
    and journal pressures, where accurate location and minimum play are desired.
- RC5 and RC6, medium running fit, intended for higher running speeds or when
    temperature variations are likely.
- RC7, free running fit, intended for use where accuracy is not essential or
    when large temperature variations are likely.
- RC8 and RC9, loose running fit, intended for use where accuracy is not
    essential or when large temperature variations are likely.

=== Locational clearance fits
- LC1 to LC4, which have a minimum zero clearance in theory, but in practice the
    probability is that the fit will always have a clearance.
- LC5 and LC6, which have a small minimum clearance. Intended for close location
    fits for non-running parts.
- LC7 to LC11, which have progressively larger clearances and tolerances. Useful
    for various loose clearances for the assembly of bolts and similar parts.

#pagebreak()

=== Locational transition fits
- LT1 and LT2, where fits have a slight clearance, giving a light push fit.
    Assembly is normally by pressure or light hammer blows.
- LT3 and LT4, where fits with virtually no clearance and are used where some
    interference can be tolerated. These are sometimes referred to as an "easy
    keyring" fit and are used for shaft keys and ball race fits. Assembly is
    normally by pressure or hammer blows.
- LT5 and LT6, where fits have a slight interference. Appreciably sizeable
    assembly force my be required. Useful for heavy keyring and ball race fits
    subject to heavy duty and vibration.

=== Locational interference fits
- LN1 and LN2, which are light press fits with very small minimum interference.
    Typically used in dowel pins. Parts can normally be dismantled and
    reassembled. Not suitable for elastic materials or light alloys.
- LN3, which are suitable for heavy press fit in steel or brass, or a light
    press fit for elastic materials and light alloys.
- LN4 to LN6, where fits are primarily intended as press fits for soft
    materials. LN4 can sometimes be used for permanent assembly of steel parts.

=== Force or shrink fits
- FN1, light drive fit, which requires light assembly pressure and produces more
    or less permanent assemblies. Suitable for thin sections or long fits or in
    case-iron external members.
- FN2, medium drive fit, which is suitable for ordinary steel parts, or as
    shrink fit on light sections.
- FN3, heavy duty drive fit, which is suitable for heavier steel parts, or as
    shrink fit on medium sections.
- FN4 and FN5, force fits, which are suitable for parts that can be highly
    stressed, or shrink fits where heavy pressing forces required are
    impractical.

#pagebreak()

= Fit systems

== Inch fit systems

=== Basic hole system
A basic hole system is the smallest hole assigned to the basic diameter from
which the tolerance and allowance are applied. It is recommended and more
popular than the basic shaft system because of the ease of control of the hole
size. Accurate holes can be easily made via reaming.

#cimage("./images/fit-systems-inch-basic-hole.png")

==== Rules
- The basic size will be the design size for the hole and the tolerance will be
    positive (+).
- The design size for the shaft will either be:
    + $"The basic size" - "the minimum clearance"$, or
    + $"The basic size" + "the maximum interference"$ and the tolerance will be
        negative (-).
- The basic size for a shaft is the upper limit of the shaft.
- The basic size for a hole is the lower limit of the hole.

==== Example 1
#cimage("./images/fit-systems-inch-hole-example-1.png")

==== Example 2
#cimage("./images/fit-systems-inch-hole-example-2.png")

=== Basic shaft system
A basic shaft system is the largest diameter of the shaft that is assigned to
the basic diameter from which all tolerances are applied.

#cimage("./images/fit-systems-inch-basic-shaft.png")

==== Rules
- The basic size will be the design size for the shaft and the tolerance will be
    negative (-).
- The design size for the hole will either be:
    + $"The basic size" + "the minimum clearance"$, or
    + $"The basic size" - "the maximum interference"$ and the tolerance will be
        positive (+).

==== Example 1
#cimage("./images/fit-systems-inch-shaft-example-1.png")

==== Example 2
#cimage("./images/fit-systems-inch-shaft-example-2.png")

=== Combined
#cimage("./images/fit-systems-inch-basic-shaft-and-hole.png")

== International tolerance (IT) grades
#cimage("./images/fit-systems-international-tolerance-grades.png")
#cimage(
    "./images/fit-systems-international-tolerance-grades-table-overview.png",
)
#cimage("./images/fit-systems-international-tolerance-grades-table-zoomed.png")

== Metric fit systems

=== Symbol
#cimage("./images/fit-systems-metric-fit-symbol.png")

*Hole basis*:
- "H" grade holes refers to a 0 lower limit (MMC of hole)

*Shaft basis*:
- "h" grade shafts refers to a 0 upper limit (MMC of hole)

=== Preferred tolerance grades for holes
#cimage("./images/fit-systems-holes-preferred-tolerance-grades.png")

- First choice tolerance zones encircled (ANSI B4 2 preferred).
- Second choice tolerance zones framed (ISO 1829 selected).
- Third choice tolerance zones are left open.

=== Hole basis fits
#cimage("./images/fit-systems-hole-basis-fits-chart.png")
#cimage("./images/fit-systems-hole-basis-fits-table.png")

=== Preferred hole basis fits
#cimage("./images/fit-systems-preferred-hole-basis-fits.png")

==== Example 1
#cimage("./images/fit-systems-hole-basis-fits-example-1.png")

==== Example 2
#cimage("./images/fit-systems-hole-basis-fits-example-2.png")

=== Preferred tolerance grades for shafts
#cimage("./images/fit-systems-shaft-preferred-tolerance-grades.png")

- First choice tolerance zones encircled (ANSI B4 2 preferred).
- Second choice tolerance zones framed (ISO 1829 selected).
- Third choice tolerance zones are left open.

=== Shaft basis fits
#cimage("./images/fit-systems-shaft-basis-fits.png")

=== Preferred shaft basis fits
#cimage("./images/fit-systems-preferred-shaft-basis-fits.png")

==== Example 1
#cimage("./images/fit-systems-shaft-basis-fits-example-1.png")

==== Example 2
#cimage("./images/fit-systems-shaft-basis-fits-example-2.png")

#pagebreak()

= Surface texture

== Reasons to texture surfaces
- Aesthetic reasons
- Surfaces affect safety
- Friction and wear depend on surface characteristics
- Surfaces affect mechanical and physical properties
- Assembly of parts is affected by their surfaces
- Smooth surfaces make better electrical contacts
- *Main reasons* to control surface finishes:
    + To reduce friction
    + To reduce wear

#pagebreak()

== Terminology
#cimage("./images/surface-texture-terminology-diagram.png")

#table(
    columns: 2,
    [*Roughness*],
    [
        Consists of the finer irregularities which results from the production
        process, like traverse feed marks.
    ],

    [*Roughness-height*],
    [
        Height of the irregularities with respect to a reference line.
    ],

    [*Roughness-width*],
    [
        The distance parallel to the normal surface between successive peaks or
        ridges which constitute the predominate pattern of the roughness.
    ],

    [*Roughness width cutoff*],
    [
        Greatest spacing of respective surface irregularities to be included in
        the measurement of the average roughness height. It should always be
        greater than the roughness width.
    ],

    [*Lay*],
    [
        Direction of the predominant surface pattern, determined by the
        production method used.
    ],

    [*Waviness*],
    [
        Usually the most widely spaced of the surface texture components, and is
        normally wider than the roughness width cutoff. Waviness may be the
        result of work piece or tool deflection during machining, vibration,
        chatter or tool runout.
    ],

    [*Flaws*],
    [
        Irregularities that occur at one place or at relatively infrequent or
        widely varying intervals in a surface. Flaws include defects such as
        cracks, blow holes, scratches, etc.
    ],

    [*Roughness-height value*],
    [
        The arithmetic average (AA) derivation expressed in micron
        (#unit[#sym.mu m] or micro-inches (#unit[#sym.mu in]). It is called
        Centre Line Average (CLA) or $R_a$. It is expressed in #unit[#sym.mu] or
        #unit[#sym.mu in])
    ],
)

#pagebreak()

== Surface roughness value ($R_a$)
It is the average of vertical deviations from the nominal surface over a
specified surface length.

#cimage("./images/surface-roughness-value-deviations.png")

Specifically, it is the arithmetic average (AA) based on the absolute values of
deviations, and is referred to as _average roughness_.

#cimage("./images/surface-roughness-value-graph.png", width: 90%)

$ R_a = integral_0^(L_m) |y|/L_m thin dif x $

Where:
- $R_a$ is the average roughness
- $y$ is the vertical deviation from the nominal surface (absolute value)
- $L_m$ is the specified distance over which the surface deviations are measured

An approximated version of the equation above would be:
$ R_a = sum_(i = 1) |y_i|/n $

Where:
- $R_a$ is the average roughness
- $y_i$ is the vertical deviations (absolute value) identified by subscript $i$
- $n$ is the number of deviations included in $L_m$

== Surfaces with the same $R_a$ value
#cimage("./images/surface-roughness-surfaces-with-same-r-values.png")

== Cutoff (sampling) length
- A problem with the $R_a$ computation is that waviness may get included.
- To deal with this problem, a parameter called the cutoff length is used as a
    filter to separate waviness from roughness deviations.
- Cutoff length is a sampling distance along the surface.
- A sampling distance shorter than the waviness eliminates waviness deviations
    and only includes roughness deviations.

#cimage("./images/surface-roughness-cutoff-length.png", width: 90%)

== Symbols used
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,

    image("./images/surface-roughness-basic-symbol.png"),
    image("./images/surface-roughness-basic-symbol-with-extension.png"),

    [Used when the surface may be produced by any method.],
    [Used when any surface characteristics are specified.],
)

For plated or coated surfaces, you must indicate whether the roughness value
applies before, after, or both before and after plating or coating.

== Surface roughness example
#cimage("./images/surface-roughness-example-max-roughness.png")
#cimage("./images/surface-roughness-example-min-and-max-roughness.png")
#cimage("./images/surface-roughness-example-general-note.png")

=== Permissibility
#cimage("./images/surface-roughness-example-optional.png")
#cimage("./images/surface-roughness-example-obligatory.png")
#cimage("./images/surface-roughness-example-not-permitted.png")

== Roughness-height ratings
#cimage("./images/surface-roughness-ratings.png")

== Roughness ranges

=== Typical applications
#cimage("./images/surface-roughness-range-typical-applications-1.png")
#cimage("./images/surface-roughness-range-typical-applications-2.png")

=== Common production processes
#cimage(
    "./images/surface-roughness-range-common-production-processes-1.png",
    width: 90%,
)
#cimage(
    "./images/surface-roughness-range-common-production-processes-2.png",
    width: 90%,
)
#cimage(
    "./images/surface-roughness-range-common-production-processes-3.png",
    width: 90%,
)

== Machining allowance
#cimage("./images/surface-roughness-machining-allowance.png")

=== Example
#cimage("./images/surface-roughness-machining-allowance-example.png")

== Lay symbols
#cimage("./images/surface-roughness-lay-symbols-1.png")
#cimage("./images/surface-roughness-lay-symbols-2.png")

== Standard cutoff (sampling) length
#table(
    columns: 2,
    table.header([*Millimetres*], [*Inches*]),
    [0.08], [0.003],
    [0.25], [0.010],
    [0.8 (default)], [0.030 (default)],
    [3.54], [0.100],
    [8], [0.300],
    [25.4], [1.000],
)

#pagebreak()

== Surface roughness specification
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,

    grid.cell(
        align: center,
        image("./images/surface-roughness-specifications-one-rating.png"),
    ),
    [
        The specification of only one rating indicates the maximum value and any
        value that is lower is acceptable. Specify in micrometres (or
        microinches).
    ],

    grid.cell(
        align: center,
        image("./images/surface-roughness-specifications-min-and-max.png"),
    ),
    [
        The specification of maximum and minimum roughness average values
        indicates the permissible range of roughness. Specify in micrometres (or
        microinches).
    ],

    grid.cell(
        align: center,
        image("./images/surface-roughness-specifications-machining.png"),
    ),
    [
        Material removal by machining is required to produce the surface. The
        basic amount of stock provided for material mremoval is specified at the
        left of the short leg of he symbol. Specify in millimetres (or inches).
    ],

    grid.cell(
        align: center,
        image("./images/surface-roughness-specifications-not-permitted.png"),
    ),
    [Removal of material is prohibited.],
)

=== Examples
#cimage("./images/surface-roughness-specifications-examples.png")

= Geometric Dimensioning and Tolerancing (GD & T)

== Geometric tolerance
Each drawing must convey three essential types of information:
+ Material to be used (separate materials data sheet)
+ Size or dimensions of the part (dimensions and tolerances)
+ Shape or geometric characteristics (GD & T)

Limits of size do not give specific control over many other variations of *form,
orientation* and *position* (to some extent).

Geometric tolerances are added to ensure parts are not only within their limits
of size but are also within specified limits of geometric form, orientation and
positions.

== Point-to-point dimensions
#cimage("./images/point-to-point-dimensions-1.png")
#cimage("./images/point-to-point-dimensions-2.png")
#cimage("./images/point-to-point-dimensions-3.png")
#cimage("./images/point-to-point-dimensions-4.png")
#pagebreak()

== Tools for measurement
#grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    image("./images/vernier-calipers.png"), [*Vernier calipers*],
    image("./images/micrometer.png", height: 10em), [*Micrometer screw gauge*],
    image("./images/height-gauge.png"), [*Height gauge*],
)

#pagebreak()

== Assumed datum surfaces
#cimage("./images/assumed-datum-surfaces.png")

== Dimensions referenced to a datum
#cimage("./images/dimensions-referenced-to-a-datum.png")

== Characteristics of geometric tolerance
- A geometric tolerance is the maximum permissible variation of *form, profile,
    orientation, location* and *runout* from that indicated or specified in the
    drawing.
- Measurement usually has to take place a specific points. A line or surface is
    evaluated dimensionally by making a series of measurements at various points
    along its length.
- Geometric tolerances are mainly concerned with points and lines. Surfaces are
    considered to be composed of a series of line elements running in two or
    more directions.
- Points have position but no size. (Position control only.)
- Lines and surfaces have to be controlled for form, orientation and location.

== Permissible form variations
#cimage("./images/permissible-form-variations-1.png")
#cimage("./images/permissible-form-variations-2.png")

=== Examples
Examples of deviation of form when perfect form at the maximum material
condition is required.

#cimage("./images/permissible-form-variations-example-1.png")
#cimage("./images/permissible-form-variations-example-2.png")

== Use of ring and plug gauges
#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,
    image("./images/ring-gauge.png"), image("./images/plug-gauge.png"),
    [Ring gauge], [Plug gauge],
)

#cimage("./images/use-of-ring-gauge.png")
#cimage("./images/use-of-ring-gauge-and-plug-gauge.png")

== Feature control frame (FCF)
#cimage("./images/feature-control-frame.png")

*Preferred location of the feature control frame*:
#cimage("./images/preferred-location-of-fcf.png")

*Control of surface or surface elements*:
#cimage("./images/control-of-surface-or-surface-elements.png")
#pagebreak()

*Control of features of size (FoS)*:
#cimage("./images/control-of-features-of-size.png")

#cimage("./images/use-of-feature-control-frame.png")

#grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,
    align: center + horizon,

    [Internal feature (Hole)], image("./images/feature-control-frame-hole.png"),

    [External feature (Shaft)],
    image("./images/feature-control-frame-shaft.png"),
)

== Three-plane system
#cimage("./images/three-plane-system.png")

== Datum symbol and identification
#cimage("./images/datum-symbol-and-identification.png")
#cimage(
    "./images/datum-symbol-and-identification-for-flat-surfaces-or-lines.png",
)
#cimage("./images/datum-symbol-and-identification-for-feature-of-size.png")

== Datum symbol in feature control frames
#cimage("./images/datum-symbol-in-fcf.png")

= Form and profile tolerances
Form tolerances
- Straightness tolerance, flatness tolerance, circularity (roundness) tolerance
    and cylindricity tolerance.

Profile tolerances
- Line profile and surface profile.

== Straightness
#cimage("./images/straightness-tolerance-1.png")
#pagebreak()

*Evaluating an uneven surface*:
#cimage("./images/straightness-tolerance-2.png")

=== Curved surfaces
#cimage("./images/straightness-of-curved-surfaces.png")

=== Cylindrical surfaces
#cimage("./images/straightness-of-cylindrical-surfaces.png")

=== Conical surfaces
#cimage("./images/straightness-of-conical-surfaces.png")

=== Multiple straightness tolerances
#cimage("./images/multiple-straightness-tolerances.png")

=== Straightness of feature of size (FoS)
Features of size are features that do have diameter or thickness where two
parallel lines or flat surfaces are considered to form a single feature.
Examples include holes, shafts, slots, tabs, rectangular or flat parts.

==== Square and rectangular faces
#cimage("./images/straightness-of-square-and-rectangular-parts.png")

==== Regular polygons
#cimage("./images/straightness-of-regular-polygons.png")

==== Cylinders
#cimage("./images/straightness-of-cylinder.png")

Note:
$
    "Virtual condition" & = 0.339 + 0.003 = 0.342 \
                        & = "MMC (shaft)" + "Geometric tolerance"
$

#pagebreak()

=== Examples

==== Regardless of feature size (RFS)
The tolerance *remains the same* regardless of the size of the feature.
#cimage("./images/regardless-of-feature-size-example.png")

==== Maximum material condition (MMC)
The tolerance is *minimum* at maximum material condition, and *increases* as the
size gets *smaller*.
#cimage("./images/maximum-material-condition-example-1.png")
#cimage("./images/maximum-material-condition-example-2.png")

==== Straightness with maximum value
The tolerance is *minimum* at the maximum material condition, and *increases* as
the size gets *smaller* until it reaches a *maximum value*, after which it
*remains constant*.
#cimage("./images/straightness-with-maximum-value-example.png")

== Material condition modifier (#text(weight: "regular")[Ⓜ] and Ⓛ)
- Ⓜ applies only to a feature of size and is not applicable to a single surface.
    It controls the boundary of the feature, like a cylindrical surface or two
    parallel surfaces of a flat feature.
- Ⓜ permits the feature surface or surfaces to cross the maximum material
    boundary by the amount of form tolerance, i.e.
    $
        "Virtual condition (VC)"
        = "Maximum material condition (MMC)" + "Tolerance"
    $
- Use "*Max*" to limit the variation over the full range.
- You may specify Ⓜ in *straightness, orientation* and *position* tolerance.
- Specifying Ⓛ is *limited* to *positional* tolerance applications.

== Flatness
#cimage("./images/flatness-tolerance.png")

=== Flatness per unit area
#cimage("./images/flatness-per-unit-area.png")

== Circularity (roundness)
#cimage("./images/circularity-tolerance.png")

=== Circularity of non-cylindrical parts
#cimage("./images/circularity-of-non-cylindrical-parts.png")

== Cylindricity
#cimage("./images/cylindricity-tolerance.png")

== Line profile tolerance
#cimage("./images/line-profile-tolerance.png")

=== Dimensioning
#cimage("./images/line-profile-tolerance-dimensioning.png")

=== Extent of controlled profile
#cimage("./images/extent-of-controlled-profile.png")
#pagebreak()

== Surface profile tolerance
Same rules as line profile tolerances, except that in most cases, the surface
profile tolerance requires references to datums to provide proper orientation of
the profile.
#cimage("./images/surface-profile-tolerance-1.png", height: 25em)
#cimage("./images/surface-profile-tolerance-2.png")

=== Control of form, orientation and position of profile
#cimage("./images/control-of-form-orientation-and-position-of-profile.png")

= Orientation, location and runout tolerances
Orientation tolerances
- Angularity, perpendicularity and parallelism

Location tolerances
- Position, concentricity and symmetry

Runout tolerances
- Circular runout and total runout

== Orientation tolerances for flat surfaces
- Angularity, parallelism and perpendicularity are orientation tolerances
    applicable to *related* features.
- When an orientation tolerance is specified, there is no need to specify a form
    tolerance for the same feature unless a smaller tolerance is necessary.
#cimage("./images/orientation-tolerances-for-flat-surfaces-1.png")
#cimage("./images/orientation-tolerances-for-flat-surfaces-2.png")
#cimage("./images/orientation-tolerances-for-flat-surfaces-3.png")

== Orientation tolerances for features of size (FoS)
#cimage("./images/orientation-tolerances-for-features-of-size.png")

=== Angularity tolerance for features of size (FoS)
#cimage("./images/angularity-tolerance-for-fos.png")

=== Parallelism tolerance for features of size (FoS)
#cimage("./images/parallelism-tolerance-for-fos.png")

=== Perpendicularity tolerance for features of size (FoS)

==== Type 1
#cimage("./images/perpendicularity-tolerance-for-fos-type-1-1.png")
#cimage("./images/perpendicularity-tolerance-for-fos-type-1-2.png")

==== Type 2
#cimage("./images/perpendicularity-tolerance-for-fos-type-2.png")

=== Control in two directions
#cimage("./images/control-in-two-directions.png")

== Maximum material condition (MMC)
Orientation tolerances may be applied on a maximum material condition basis as
shown below.
#cimage("./images/orientation-tolerances-mmc.png")

=== Perpendicularity examples
#cimage("./images/perpendicularity-example-mmc-1.png")
#pagebreak()

==== Without maximum value
#cimage("./images/perpendicularity-example-mmc-no-max.png")

==== With maximum value:
#cimage("./images/perpendicularity-example-mmc-with-max.png")

==== External cylindrical feature without MMC
#cimage("./images/perpendicularity-example-mmc-external-cylinder-no-m.png")

==== External cylindrical feature with MMC
#cimage("./images/perpendicularity-example-mmc-external-cylinder-with-m.png")

== Position tolerancing methods
#cimage("./images/position-tolerancing-methods.png")
#pagebreak()

=== Coordinate tolerancing
Coordinate tolerancing refers to tolerances applied directly to the coordinate
dimensions or tolerances specified in a general tolerance note.

#cimage("./images/coordinate-tolerancing-equal.png")
#cimage("./images/coordinate-tolerancing-unequal.png")
#cimage("./images/coordinate-tolerancing-polar.png")

==== Advantages and disadvantages
*Advantages*:
- It is simple and easily understood.
- It permits direct measurements using standard instruments.

*Disadvantages*:
- It results in a square or rectangular tolerance zone.
- It may result in an undesirable accumulation of tolerances.
- It is more difficult to assess clearances between mating features and
    components.
- It does not correspond well to the use of "go" gauges, especially in dealing
    with a group of holes.

=== Geometric (positional) tolerancing
Geometric tolerancing refers to a tolerance zone within which the centre line of
the hold or shaft is permitted to vary from its true position. It can be
modified further with regardless of size (RFS), maximum material condition (MMC)
and least material condition (LMC). Its tolerance is given by:

$ "True position" = frac("Maximum value" + "Minimum value", 2) $

$
    "Positional tolerance" =
    sqrt(("Horizontal tolerance band")^2 + ("Vertical tolerance band")^2)
$

#cimage("./images/geometric-tolerancing.png")

==== Maximum material condition (MMC)
#cimage("./images/position-tolerancing-mmc-1.png")
#cimage("./images/position-tolerancing-mmc-2.png")
$ "Hole at maximum material condition" = 0.502 $
$ "Theoretical boundary (gauge size)" = 0.502 - 0.008 = 0.494 $

#cimage("./images/position-tolerancing-mmc-3.png", width: 90%)
#pagebreak()

#cimage("./images/position-tolerancing-mmc-4.png")
$ "Dist-b" = 15.75 - 0.75 = 15 $
$ "Dist-h" = 9.75 + 0.125 = 9.875 $
$ "Wall thickness" = 15 - 9.875 = 5.125 $

#align(center)[
    *Smallest hole, largest boss at the extreme position (both MMC)*.
]

#cimage("./images/position-tolerancing-mmc-5.png")
$ "Dist-b" = 15.75 - 1.5 = 13.5 $
$ "Dist-h" = 10 + 0.375 = 10.375 $
$ "Wall thickness" = 13.5 - 10.375 = 3.125 $

#align(center)[
    *Largest hole, smallest boss at the extreme position (both LMC)*.
]

Basically, with this marking, when the feature moves away from MMC, towards LMC,
there is bonus tolerance. The reason is because the there is more space when the
hole becomes bigger, or the shaft becomes smaller, so more tolerance is allowed.

#pagebreak()

==== Least material condition (LMC)
#cimage("./images/position-tolerancing-lmc-1.png")
$ "Dist-b" = 15 - 0.75 = 14.25 $
$ "Dist-h" = 10 + 0.125 = 10.125 $
$ "Wall thickness" = 14.125 - 10.125 = 4.125 $

#align(center)[
    *Largest hole, smallest boss at the extreme position (both LMC)*.
]

#cimage("./images/position-tolerancing-lmc-2.png")
$ "Dist-b" = 15.75 - 1.5 = 14.25 $
$ "Dist-h" = 9.75 + 0.375 = 10.125 $
$ "Wall thickness" = 14.25 - 10.125 = 4.125 $

#align(center)[
    *Smallest hole, largest boss at the extreme position (both MMC)*.
]

Basically, with this marking, when the feature moves away from LMC, towards MMC,
there is bonus tolerance. The reason is because the there is greater wall
thickness when the hole becomes smaller, or the shaft becomes bigger, so more
tolerance is allowed.

==== Regardless of feature size (RFS)
#cimage("./images/position-tolerancing-rfs-1.png")
$ "Dist-b" = 15.75 - 0.75 = 15 $
$ "Dist-h" = 9.75 + 0.125 = 9.875 $
$ "Wall thickness" = 15 - 9.875 = 5.125 $

#align(center)[
    *Smallest hole, largest boss at the extreme position (both MMC)*.
]

#cimage("./images/position-tolerancing-rfs-2.png")
$ "Dist-b" = 15 - 0.75 = 14.25 $
$ "Dist-h" = 10 + 0.125 = 10.125 $
$ "Wall thickness" = 14.125 - 10.125 = 4.125 $

#align(center)[
    *Largest hole, smallest boss at the extreme position (both LMC)*.
]

With this marking, there is *no* bonus tolerance. Only the stated tolerance is
allowed, regardless of the size of the shaft or hole.

#pagebreak()

=== Method to obtain the length with positional tolerances
+ Add up all the true lengths that are required.
+ Add the positional tolerances, as well as any bonus tolerances coming from the
    MMC or LMC condition, denoted as $Delta$.
+ The minimum length would be:
    $ "Minimum length" = "Total length" - 1/2 Delta $
+ The maximum length would be:
    $ "Maximum length" = "Total length" + 1/2 Delta $

=== Applications
*Regardless of feature size (RFS)*:
- For accurate alignment of axes.
- Inspection is more complicated and is usually done by dedicated machines such
    as CMM or flexible "live" gauges.

*Maximum material condition (MMC)*:
- For ease of assembly.
- Inspection can be facilitated by fixed "go" gauges.

*Least material condition (LMC)*:
- It is usually used when there is a need to maintain a minimum thickness (stock
    size) or distance.

#pagebreak()

=== Difference between RFS, MMC and LMC

==== Same tolerance
#cimage("./images/difference-between-rfs-mmc-and-lmc-same-tolerance.png")

==== Different tolerance
#cimage("./images/difference-between-rfs-mmc-and-lmc-different-tolerance.png")

== Concentricity
#cimage("./images/concentricity-tolerance.png")

== Symmetry
#cimage("./images/symmetry-tolerance.png")

== Runout
#cimage("./images/runout-tolerance.png")

== Circular runout
#cimage("./images/circular-runout-tolerance.png")

== Total runout
#cimage("./images/total-runout-tolerance.png")

#pagebreak()

= Symbols used with dimensions
#table(
    columns: 2,
    $diameter$, [Diameter of a circle or cylinder],
    $R$, [Radius of a part of a circle or cylinder],
    $ballot$, [Width across flats of a square section],
    $S diameter$, [Diameter of a spherical surface],
    $S R$, [Radius of a spherical surface],
    [⌒], [Arc length],
    $T =$, [Thickness],
    $A F$, [Distance from one flat surface to another],
    $A C$, [Distance from one point to another opposite corner in a hexagon],
    $(A C space 11.5)$, [Reference dimension (in parentheses)],
    [⌴], [Counterbore or Spotface],
    [⌵], [Countersink],
    [↧], [Depth or Deep],
    [4x], [Number of times],
    underline[104], [Dimension is not to scale (underlined)],
    [⌲], [Conical taper],
    [⌳], [Slope],
)

#pagebreak()

= Symbols used with geometric tolerances
#table(
    columns: 4,
    align: center + horizon,
    table.header(
        [*Feature*], [*Type of Tolerance*], [*Characteristic*], [*Symbol*]
    ),

    table.cell(rowspan: 4)[Individual features],
    table.cell(rowspan: 4)[Form],

    [Straightness],
    image("./images/straightness-symbol.png", height: 1.9em),

    [Flatness],
    image("./images/flatness-symbol.png", height: 1.9em),

    [Circularity (roundness)],
    image("./images/circularity-symbol.png", height: 1.9em),

    [Cylindricity],
    image("./images/cylindricity-symbol.png", height: 1.9em),

    table.cell(rowspan: 10)[Related features],
    table.cell(rowspan: 2)[Profile],

    [Profile of a line],
    image("./images/line-profile-symbol.png", height: 1.9em),

    [Profile of a surface],
    image("./images/surface-profile-symbol.png", height: 1.9em),

    table.cell(rowspan: 3)[Orientation],

    [Angularity],
    image("./images/angularity-symbol.png", height: 1.9em),

    [Perpendicularity],
    image("./images/perpendicularity-symbol.png", height: 1.9em),

    [Parallelism],
    image("./images/parallelism-symbol.png", height: 1.9em),

    table.cell(rowspan: 3)[Location],

    [Position],
    image("./images/position-symbol.png", height: 1.9em),

    [Concentricity],
    image("./images/concentricity-symbol.png", height: 1.9em),

    [Symmetry],
    image("./images/symmetry-symbol.png", height: 1.9em),

    table.cell(rowspan: 2)[Runout],

    [Circular runout],
    image("./images/circular-runout-symbol.png", height: 1.9em),

    [Total runout],
    image("./images/total-runout-symbol.png", height: 1.9em),

    table.cell(rowspan: 7, colspan: 2)[Supplementary symbols],

    [Maximum material condition (MMC)],
    image("./images/maximum-material-condition-symbol.png", height: 1.9em),

    [Least material condition (LMC)],
    image("./images/least-material-condition-symbol.png", height: 1.9em),

    [Regardless of feature size],
    image("./images/regardless-of-feature-size-symbol.png", height: 1.9em),

    [Projected tolerance zone (not covered)],
    image("./images/projected-tolerance-zone-symbol.png", height: 1.9em),

    [Basic dimension],
    image("./images/basic-dimension-symbol.png", height: 1.9em),

    [Datum feature],
    image("./images/datum-feature-symbol.png", height: 1.9em),

    [Datum target (not covered)],
    image("./images/datum-target-symbol.png", height: 1.9em),
)

#pagebreak()

= ISO standards
- For the *visible outline*, use *thick* continuous lines.
- *Hidden* outlines are drawn using *thin short dashes*.
- *Thin* continuous lines are used for *dimensions*, *leader*, *projection* and
    *hatching* lines.
- *Thin chain lines* are used for *centrelines* and pitch lines.
- *Thin chain, thick ended lines* are used for the cutting plane of *sectional
    views*.
- *Thin chain with short double dashes* are called *phantom lines*, and are used
    for *alternate views*.

== Line thickness
- Thick lines (2B, #sym.approx #qty[5][mm])
- Thin lines (2H, #sym.approx #qty[3][mm])

Construction lines should be lighter than everything else.

== Centrelines
- Centrelines should always start and end with a *long dash*.
- Centrelines should *not* extend between views.
- Centrelines should *extend 3 to 4 #unit[mm] outside* the outline.
- For a *small hole*, a centreline is presented as a *thin continuous line*.
- *Leave a gap* when the centreline forms a continuation with a *visible* or
    *hidden* line.

== External threads
- Outer circle *thick*, inner $3/4$ circle *thin*.
- *Inner* line for minor diameter is *thin*.
- *Outer* line for major diameter is *thick*.
- 45#sym.degree *chamfer* at end of thread.
- Draw centreline.

== Threaded hole
- Outer $3/4$ circle *thin*, inner circle *thin*.
- Inner line for minor diameter is *thick*.
- Outer line for major diameter is *thin*.
- Draw centreline.

=== Sectional view
- Hatch must reach the *thick* minor diameter inner line.
- Hatch passes through the *thin* major diameter line.
- End of thread must be a *thick* line.
- Must have *triangle* at the *end* of the hole if *blind*.

#pagebreak()

== Sectional views
- All visible lines or features *behind* the cutting plane must be shown.
- Outline should *not* cut across the hatching lines or holes.
- Use *thin* chain line with *thick ends* for cutting plane.
- Use *thin* continuous lines (2H, #sym.approx #qty[3][mm] darker than
    construction line) *equally spaced* at 45#sym.degree or 135#sym.degree for
    hatching lines.
- Hatching lines should *end* on the *outline*.
- Avoid 45#sym.degree and 135#sym.degree hatching lines when they are
    perpendicular or parallel to outlines or axes of parts. Use 30#sym.degree or
    60#sym.degree hatching lines instead.
- Use *different* angles and spacing for *different* parts, and always use the
    *same* angle and spacing for the *same* part.
- *Hidden* features should be *omitted*.
- *Do not* section standard parts, or parts that have no interior details they
    are cut *longitudinally*, like shafts, hexagonal bolts, nuts, screws,
    threaded fasteners, washers, keys, pins, bearing convention, gear teeth,
    etc. Show the *outside view* of these parts instead.
- *Do not* section *ribs* or *webs* if they are cut along the *thin side*. It is
    sectioned otherwise.

=== Offset section
- *Do not* show the edge views of the cutting plane.

=== Half section
- Use a *centreline* to separate the sectioned half from the unsectioned half.
- *Omit* the hidden line is the unsectioned half of the view (outside view).
- Cutting plane is at *90#sym.degree*.
- Show all visible edges behind the cutting plane.

=== Aligned section
- *Cutting plane* is at an *angle*.
- The axis is shown as a *centreline*.

=== Revolved section
- Either superimposed onto orthographic view or broken from orthographic view.
- Thin lines are used for the section.

=== Removed section
- Placed *alongside the cutting plane*, or *anywhere* else, but it must be
    labelled properly.
- *Outline* of the removed section is drawn with *thick continuous lines*.

=== Broken out section (local section)
- A thin continuous line is used for the *break line*.
- The break line is drawn freehand.

#pagebreak()

== Dimensions
- Always dimension from a *finished surface*.
- Dimensions should be placed so that it can be read from the *bottom* and the
    *right-hand* side of the drawing.
- Always leave a *visible gap* of about #qty[1][mm] from a view or centreline
    before drawing the extension line.
- Extend the lines *beyond* the last dimension line by about #qty[2][mm].
- Dimension lines should be at least *2 times* the text height away from the
    *outline*.
- Dimension lines should be at least *1 times* the text height away from *other
    dimension lines*.
- Height of numbers is about *#qty[2.5][mm] to #qty[3][mm]*.
- Place the numbers about #qty[1][mm] *above* and *at the middle* of a dimension
    line.
- Place the arrows outside the extension lines if there is *not enough space*
    for the number or the arrows.
- Units used are *not stated directly* except for *angles*.
- Extension and leader lines *should not cross* dimension lines, hence longer
    dimension lines are placed outside short ones.
- Extension lines should be drawn from the *nearest points* to be dimensioned.
- *Do not break* extension lines. They are always a continuous line.
- *Do not* use outlines, centrelines and hidden lines as dimension lines.
- *Avoid* dimensioning from *hidden* lines.
- Place dimensions *outside* the view, unless placing them inside improves the
    clarity.
- Apply the dimension to the view that clearly represents the *contour or shape
    of a feature*.
- Dimension lines should be *lined up* and grouped together as much as possible.
- *Avoid repeating* a dimension (redundant dimension).
- Place *notes* near to the *feature* which they apply, and should be placed
    *outside* the view.
- Notes are always read *horizontally*.
- Dimension features in the view where they are *true size and shape*.
- Dimension on the view that shows the *contour* of the features.
- Ensure *all dimensions* are accounted for.
- *Reference* dimensions are in *parentheses* (XX).
- Circular features should be located by dimensioning to the *centrelines*.
- Use *diameter* dimensions for circles (*> 180#sym.degree*).
- Use *radial* dimensions for arcs (*< 180#sym.degree*).
- *Concentric circles* should be dimensioned in a *longitudinal* view.
- Dimension *holes* in *circular view*, and *do not use radii*.
- Dimensions should be *uniformly spaced*.
- *Leader lines should not* be drawn at *horizontal or vertical angles*.
- Display only the number of *decimal places required* for manufacturing
    precision.
- Use a *centreline* to indicate symmetry.
- *Assume 90#sym.degree* unless specified.
- Each dimension must have a *tolerance*.
- *Clarity*.

#pagebreak()

== Leader lines
- Keep leader lines *short*.
- For radial features, *align the leader line with its centre*.
- Draw *at an angle* to the horizontal or vertical.
- Terminate with an *arrow head on the outline*.
- Terminate with a *dot within the outline* of the part.
- Keep balloons *in lines*.
