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
        margin: 1mm,
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

= Partial differential equations (PDE)
A function $f$ is a solution of the PDE when we replace $phi.alt$ with $f$ and
the left-hand side equals the right-hand side.

== Laplace's equation
$frac(partial^2 phi.alt, partial x^2)
+ frac(partial^2 phi.alt, partial y^2)
+ frac(partial^2 phi.alt, partial z^2) = 0$

== Linear partial differential equations
All terms contain a $phi.alt$ or a partial derivative of $phi.alt$, like
$c phi.alt$ or $c("partial derivative of" phi.alt)$.

=== Non-linear PDE examples
$underline(p) frac(partial^2 p, partial x^2)
+ frac(partial^2 p, partial x partial y) + 3p = 0$

$frac(partial^2 phi.alt, partial x^2) + frac(partial^2 phi.alt, partial y^2)
= underline(sin phi.alt)$

=== Homogeneous linear PDE
Homogeneous linear PDEs are equal to zero ($= 0$).

=== Solving initial boundary value problems

==== Step 1: Method of separation
+ Let $u(x, t) = X(x) T(t)$ and get $frac(partial^2 u, partial x^2)$ and
    $frac(partial^2 u, partial t^2)$.
+ Substitute the equations from the previous step into the PDE.
+ Divide both sides by $X(x) T(t)$.
+ Separate $X(x)$ and $T(t)$ to the left-hand side and right-hand side
    respectively.
+ Obtain ordinary differential equations (ODE) $"LHS" = gamma$ and
    $"RHS" = gamma$.

==== Step 2: Solve ordinary differential equations
Cases for the partial differential equation:
- Case 1: $gamma = 0$
- Case 2: $gamma > 0$, let
    $gamma = p^2, X(x) = e^(lambda t), T(t) = e^(lambda t)$
- Case 3: $gamma < 0$, let
    $gamma = p^2, X(x) = e^(lambda t), T(t) = e^(lambda t)$

Cases for the ordinary differential equations solutions:
- Case 1: $lambda = a, b$ \
    $y = A e^(a x) + B e^(b x)$
- Case 2: $lambda = a$ only \
    $y = (A x + B) e^(a x)$
- Case 3: $lambda = alpha plus.minus beta i$ \
    $y = e^(alpha x) (A cos beta x + B sin beta x)$

Substitute the boundary conditions to find the solutions.

==== Step 3: Form the series solutions
+ Sum up all the solutions in step 2 to form a series solution.
+ Ensure the boundary conditions are still satisfied.

Example:
$
    phi.alt(x, y)
    = sum_(n = 1)^oo sin (n pi x) (A_n e^(n pi y) + B_n e^(n pi y))
$

==== Step 4: Tackle initial conditions
- Use the initial conditions from the question.
- The Fourier series may be used to find unknowns.

== Fourier series problem 1
$ a_0 + sum_(n = 1) a_n cos (frac(n pi x, L)) = f(x) "for" 0 < x < L $

Where:
- $a_0 = 1/L integral_0^L f(x) thin dif x$
- $a_n = 2/L integral_0^L f(x) cos (frac(n pi x, L)) thin dif x
    "for" n = 1, 2, 3, dots$

== Fourier series problem 2
$ sum_(n = 1)^oo b_n sin (frac(n pi x, L)) = f(x) "for" 0 < x < L $

Where:
- $b_n = 2/L integral_0^L f(x) sin(frac(n pi x, L)) thin dif x$

= Finite element method
+ Draw out the finite element model using the elements required.
+ Write out the element stiffness matrices.
+ Assemble the element stiffness matrices by adding them together.
+ Apply the boundary conditions and get the system of equations and solve.

== Boundary conditions
+ Zero boundary condition, $Q_n = 0$, cancel *both the row and column*
    associated with the boundary condition.
+ Non-zero boundary condition, $Q_n != 0$, cancel *only the row* associated with
    the boundary condition, but *skip* the $Q_n$ value in the *displacement
    vector*.

== Spring element
#image("./images/generalised-symbols-spring-element.png")
$k bmat(1, -1; -1, 1) cvec(Q_1, Q_2) = cvec(F_1, F_2)$

== Bar element (axial loading only)
$(E A)/L bmat(1, -1; -1, 1) cvec(Q_1, Q_2) = cvec(F_1, F_2)$

== Heat conduction element
#image("./images/heat-conduction-element-cheat-sheet.png")
$(k_T A)/L bmat(1, -1; -1, 1) cvec(T_1, T_2) = cvec(q_1^((e)), q_2^((e)))$

== Pipe element
#image("./images/pipe-element.png")

$frac(pi D^4, 128 mu L) bmat(1, -1; -1, 1) cvec(P_1, P_2)
= cvec(q_1^((e)), q_2^((e)))$

== Beam element (bending moments only)
#image("./images/generalised-symbols-beam-element-general.png")

$frac(E I, L^3) bmat(
    12, 6L, -12, 6L;
    6L, 4L^2, -6L, 2L^2;
    -12, -6L, 12, -6L;
    6L, 2L^2, -6L, 4L^2;
) cvec(Q_1, Q_2, Q_3, Q_4) = cvec(F_1, F_2, F_3, F_4)$

=== Uniformly distributed load
#grid(
    row-gutter: 1em,
    image("./images/uniformly-distributed-load.png"),
)

For an upward distributed load:
${bold(f)_q^e} = cvec(
    frac(q L, 2),
    frac(q L^2, 12),
    frac(q L, 2),
    - frac(q L^2, 12),
)$

== Truss element (axial loading only)
#image("./images/generalised-symbols-truss-element.png")

$(E A)/L bmat(
    l^2, l m, -l^2, -l m;
    l m, m^2, -l m, -m^2;
    -l^2, -l m, l^2, l m;
    -l m, -m^2, l m, m^2;
) cvec(Q_1, Q_2, Q_3, Q_4) = cvec(F_1, F_2, F_3, F_4)$

- $l = cos theta, m = sin theta$, $theta$ is measured from the $x$-axis at the
    reference node, node 1 in this case, anti-clockwise.

#colbreak()

== General expressions

=== Potential energy
$U = 1/2 k (u_n - u_(n - 1))^2$

Where:
- $k$ is the stiffness constant before the matrix in the previous section.
- $u_n, u_(n - 1)$ is the displacement.

=== Work done
$W = F u_n, "where" u_n "is the displacement"$

=== Total potential energy
$Pi = U - W$

$Pi =
overbrace(1/2 integral_V {bold(epsilon)}^T {bold(sigma)} thin dif, "U") V
- overbrace(
    integral_V {bold(u)}^T {bold(b)} thin dif V
    - integral_S {bold(u)}^T {bold(bar(macron(t)))} thin dif S, "W"
)$

Where:
- ${bold(u)} = cvec(u, v)$ is the displacement vector
- ${bold(b)} = cvec(b_x, b_y)$ is the body force vector
- ${bold(macron(t))} = cvec(macron(t)_x, macron(t)_y)$ is the surface force
    vector.
- ${bold(sigma)} = cvec(sigma_x, sigma_y, tau_(x y))$ is the stress vector
- ${bold(epsilon)} = cvec(epsilon_x, epsilon_y, gamma_(x y))$ is the strain
    vector.

=== Principle of minimum potential energy
$frac(partial Pi, partial u_n) = 0, n = 1, 2, 3, dots,
"where" u_n "is the displacement"$

=== Element displacement interpolation
- Element displacement interpolation is to write the *displacement at any point*
    in the element in terms of *nodal displacements of the element*.
- Use $u = a_1 + a_2 x$ and solve for $a_1$ and $a_2$ at all nodes.
- Substitute the results back into $u = a_1 + a_2 x$ and rearrange to be in the
    form $u = N_1 u_1 + N_2 u_2 + dots N_n u_n$, where $N_n$ is the shape
    function that is in terms of $x$.
- The result can be represented as $u = [bold(N)]{bold(u)^((e))}$, where
    $[bold(N)]$ is the shape function matrix and ${bold(u)^((e))}$ is the vector
    nodal displacements $u_1, u_2, dots, u_n$.

$u = N_1 u_1 + N_2 u_2 + dots N_n u_n$

$v = N_1 v_1 + N_2 v_2 + dots N_n v_n$

$cvec(u, v) & = bmat(
    N_1, 0, N_2, 0, N_3, 0, dots.c, N_n, 0;
    0, N_1, 0, N_2, 0, N_3, dots.c, 0, N_n;
)
cvec(u_1, v_1, u_2, v_2, u_3, v_3, dots.v, u_n, v_n) \
{bold(u)} & = [bold(N)]{bold(u)^((e))}$

$[bold(N)] = bmat(
    N_1, 0, N_2, 0, N_3, 0, dots.c, N_n, 0;
    0, N_1, 0, N_2, 0, N_3, dots.c, 0, N_n;
)$

=== Element strain
$epsilon = frac(dif u, dif x) = frac(dif, dif x) ([bold(N)]{bold(u)^((e))})$

$cvec(
    epsilon_x,
    epsilon_y,
    gamma_(x y)
) & = cvec(
    frac(partial u, partial x),
    frac(partial v, partial y),
    frac(partial u, partial y) + frac(partial v, partial x)
)
= bmat(
    partial/(partial x), 0;
    0, partial/(partial y);
    partial/(partial y), partial/(partial x)
) cvec(u, v) \
& = bmat(
    partial/(partial x), 0;
    0, partial/(partial y);
    partial/(partial y), partial/(partial x)
) bmat(
    N_1, 0, N_2, 0, N_3, 0, dots.c, N_n, 0;
    0, N_1, 0, N_2, 0, N_3, dots.c, 0, N_n;
)
cvec(u_1, v_1, u_2, v_2, u_3, v_3, dots.v, u_n, v_n) \
& = bmat(
    frac(
        partial N_1,
        partial x
    ), 0, frac(
        partial N_2,
        partial x
    ), 0, frac(
        partial N_3,
        partial x
    ), 0, dots.c, frac(
        partial N_n,
        partial x
    ), 0;
     //
    0, frac(
        partial N_1,
        partial x
    ), 0, frac(
        partial N_2,
        partial x
    ), 0, frac(
        partial N_3,
        partial x
    ), dots.c, 0, frac(
        partial N_n,
        partial x
    );
     //
    frac(partial N_1, partial y), frac(
        partial N_1, partial x
    ), frac(partial N_2, partial y), frac(
        partial N_2, partial x
    ), frac(partial N_3, partial y), frac(
        partial N_3, partial x
    ), dots.c, frac(partial N_n, partial y), frac(
        partial N_n,
        partial x
    );
)
cvec(u_1, v_1, u_2, v_2, u_3, v_3, dots.v, u_n, v_n)$

$epsilon = [bold(B)]{bold(u)^((e))}$

=== Stress-strain expression
For plane stress problems ($x y$-plane):

$[bold(D)] = E/(1 - nu^2) bmat(
    1, nu, 0;
    nu, 1, 0;
    0, 0, frac(1 - nu, 2);
)$
#v(1pt)

For plane strain problems ($x y$-plane):

$[bold(D)] = E/((1 + nu) (1 - 2 nu)) bmat(
    1 - nu, nu, 0;
    nu, 1 - nu, 0;
    0, 0, frac(1 - 2 nu, 2);
)$

Where:
- $E$ is Young's modulus
- $nu$ is Poisson's ratio

#colbreak()

=== Potential energy expression
$Pi &= 1/2 {bold(u)^e}^T
(integral_V [bold(B)]^T [bold(D)] [bold(B)] thin dif V) {bold(u)^e} \
&- {bold(u)^e}^T (integral_V [bold(N)]^T {bold(b)} thin dif V^e) \
&- {bold(u)^e}^T (integral_S [bold(N)]^T {bold(macron(t))} thin dif S)$

Where:
- $[bold(K)^e] = integral_V [bold(B)]^T [bold(D)] [bold(B)] thin dif V$ is the
    element stiffness matrix
- $[bold(f)_b^e] = integral_V [bold(N)]^T [bold(b)] thin dif V$ is the element
    load vector due to body force
- $[bold(f)_macron(t)^e] = integral_S [bold(N)]^T [bold(macron(t))] thin dif S$
    is the element load vector due to surface force.

=== 1D element stiffness matrix
$[bold(K)^((e))] = k integral_0^L [bold(B)]^T [bold(B)] thin dif x$

Where:
- $k$ is the stiffness constant.
- $[bold(B)]$ is the element strain.

=== 1D element force vector
${bold(f)^((e))} = integral_0^L [bold(N)]^T T thin dif x$

Where:
- $[bold(N)]^T$ is the transpose of the shape function matrix.
- $T$ is the element force.

== Bilinear rectangular element
#image("./images/bilinear-rectangular-element.png")

=== Shape functions
#grid(
    columns: 2,
    column-gutter: 1em,
    row-gutter: 0.5em,
    $N_1 = frac((a - x) (b - y), 4 a b)$, $N_2 = frac((a + x) (b - y), 4 a b)$,
    $N_3 = frac((a + x) (b + y), 4 a b)$, $N_4 = frac((a - x) (b + y), 4 a b)$,
)

=== Shape function matrix
$[bold(N)] = bmat(
    N_1, 0, N_2, 0, N_3, 0, N_4, 0;
    0, N_1, 0, N_2, 0, N_3, 0, N_4;
)$
#v(1pt)

=== Element strain matrix

$[bold(B)] = bmat(
    frac(
        partial N_1,
        partial x
    ), 0, frac(
        partial N_2,
        partial x
    ), 0, frac(
        partial N_3,
        partial x
    ), 0, frac(
        partial N_4,
        partial x
    ), 0;
     //
    0, frac(
        partial N_1,
        partial x
    ), 0, frac(
        partial N_2,
        partial x
    ), 0, frac(
        partial N_3,
        partial x
    ), 0, frac(
        partial N_4,
        partial x
    );
     //
    frac(partial N_1, partial y), frac(
        partial N_1, partial x
    ), frac(partial N_2, partial y), frac(
        partial N_2, partial x
    ), frac(partial N_3, partial y), frac(
        partial N_3, partial x
    ), frac(partial N_4, partial y), frac(
        partial N_4,
        partial x
    );
)$

After evaluation:

$[bold(B)] = (1/(4 a b)) bmat(
    -(b - y), 0, (b - y), 0, (b + y), 0, -(b + y), 0;
    0, -(a - x), 0, -(a + x), 0, (a + x), 0, (a - x);
     //
    -(a - x), -(b - y), -(a + x), (b - y), (a + x), (b + y), (a - x), -(
        b + y
    );
)$
#v(1pt)

=== Element strain expression
$cvec(
    epsilon_x,
    epsilon_y,
    gamma_(x y)
)
= bmat(
    frac(
        partial N_1,
        partial x
    ), 0, frac(
        partial N_2,
        partial x
    ), 0, frac(
        partial N_3,
        partial x
    ), 0, frac(
        partial N_4,
        partial x
    ), 0;
     //
    0, frac(
        partial N_1,
        partial x
    ), 0, frac(
        partial N_2,
        partial x
    ), 0, frac(
        partial N_3,
        partial x
    ), 0, frac(
        partial N_4,
        partial x
    );
     //
    frac(partial N_1, partial y), frac(
        partial N_1, partial x
    ), frac(partial N_2, partial y), frac(
        partial N_2, partial x
    ), frac(partial N_3, partial y), frac(
        partial N_3, partial x
    ), frac(partial N_4, partial y), frac(
        partial N_4,
        partial x
    );
)
cvec(u_1, v_1, u_2, v_2, u_3, v_3, u_4, v_4)$

=== Element load vector due to body force
$
    {bold(f)_b^e} = integral_(A^e) bmat(
        N_1, 0;
        0, N_1;
        N_2, 0;
        0, N_2;
        N_3, 0;
        0, N_3;
        N_4, 0;
        0, N_4;
    ) cvec(b_x, b_y) t thin dif x thin dif y
    = cvec(
        t integral_(A^e) N_1 b_x thin dif x thin dif y,
        t integral_(A^e) N_1 b_y thin dif x thin dif y,
        t integral_(A^e) N_2 b_x thin dif x thin dif y,
        t integral_(A^e) N_2 b_y thin dif x thin dif y,
        t integral_(A^e) N_3 b_x thin dif x thin dif y,
        t integral_(A^e) N_3 b_y thin dif x thin dif y,
        t integral_(A^e) N_4 b_x thin dif x thin dif y,
        t integral_(A^e) N_4 b_y thin dif x thin dif y,
    ) \
    = cvec(
        t b_x integral_(A^e) N_1 thin dif x thin dif y,
        t b_y integral_(A^e) N_1 thin dif x thin dif y,
        t b_x integral_(A^e) N_2 thin dif x thin dif y,
        t b_y integral_(A^e) N_2 thin dif x thin dif y,
        t b_x integral_(A^e) N_3 thin dif x thin dif y,
        t b_y integral_(A^e) N_3 thin dif x thin dif y,
        t b_x integral_(A^e) N_4 thin dif x thin dif y,
        t b_y integral_(A^e) N_4 thin dif x thin dif y,
    )
    = cvec(
        t b_x a b = f_(1x),
        t b_y a b = f_(1y),
        t b_x a b = f_(2x),
        t b_y a b = f_(2y),
        t b_x a b = f_(3y),
        t b_y a b = f_(3y),
        t b_x a b = f_(4y),
        t b_y a b = f_(4y),
    )
$

Where:
- $t$ is thickness
- $b_x$ and $b_y$ are the body forces, usually $b_x = 0, b_y = - rho g$
- $a b = integral_(A_e) N_i thin dif x dif y$


=== Element load vector due to surface force
Force is applied on the side 2-3, so $x = a$. The shape functions become:
$
    N_1 = frac((a - x) (b - y), 4 a b) = 0,
    quad N_2 = frac((a + x) (b - y), 4 a b) = frac((b - y), 2b)
$

$
    N_4 = frac((a - x) (b + y), 4 a b) = 0,
    quad N_3 = frac((a + x) (b + y), 4 a b) = frac((b + y), 2b)
$

$
    {bold(f)_macron(t)^e} = integral_(-b)^b bmat(
        redcancel(N_1) mathred(= 0), 0;
        0, redcancel(N_1) mathred(= 0);
        N_2, 0;
        0, N_2;
        N_3, 0;
        0, N_3;
        redcancel(N_4) mathred(= 0), 0;
        0, redcancel(N_4) mathred(= 0);
    ) cvec(macron(t)_x, macron(t)_y) t thin dif y
    = cvec(
        0,
        0,
        t integral_(-b)^b N_2 macron(t)_x thin dif y,
        t integral_(-b)^b N_2 macron(t)_y thin dif y,
        t integral_(-b)^b N_3 macron(t)_x thin dif y,
        t integral_(-b)^b N_3 macron(t)_y thin dif y,
        0,
        0,
    ) \
    = cvec(
        0,
        0,
        t macron(t)_x integral_(-b)^b frac((b - y), 2b) thin dif y,
        t macron(t)_y integral_(-b)^b frac((b - y), 2b) thin dif y,
        t macron(t)_x integral_(-b)^b frac((b + y), 2b) thin dif y,
        t macron(t)_y integral_(-b)^b frac((b + y), 2b) thin dif y,
        0,
        0,
    )
    = cvec(
        0 = f_(1x),
        0 = f_(1y),
        t b macron(t)_x = f_(2x),
        t b macron(t)_y = f_(2y),
        t b macron(t)_x = f_(3x),
        t b macron(t)_y = f_(3y),
        0 = f_(4x),
        0 = f_(4y),
    )
$

== Practical finite element analysis

=== 2D elements
- Triangular and quadrilateral elements are used for in plane stress and strain.
- Triangular and quadrilateral *plate* elements are out-of-plane loading, like
    placing food on a plate.
- Triangular and quadrilateral shell elements are used for modelling structures
    that are hollow inside.

=== Tips
- Always remember to apply boundary conditions.
- Use the minimum number of necessary boundary conditions.
    - For 2D the rigid body motions are:
        + Translation along $x$-direction
        + Translation along $y$-direction
        + Rotation in $x y$-plane.
- Use finer meshes for accurate results.
- All *corners* and *curves* need mesh refinement for accurate results.
- *Mesh convergence* is needed for *reliable* results. The *difference* between
    each mesh study should *decrease* when the number of elements increases for
    convergence.
- Avoid severely distorted element shapes and keep *aspect ratios* close to *1*.
- Exploit *symmetry* of geometry whenever possible.

#colbreak()

= Computational fluid dynamics

// Function to generate the W-w-P-e-E line
#let west_east_line(
    labels,
    spacing: 5em,
    label_distance: true,
) = align(
    center,
    block(
        above: 2em,
        below: 2em,
        {
            //

            // Draw the line
            line(length: labels.slice(0, -1).map(_ => spacing).sum())

            // Enumerate over all the labels
            for (index, label) in labels.map(item => str(item)).enumerate() {
                //

                // Get if the label is the final label
                let is_last_label = index == labels.len() - 1

                // The x offset
                let x_offset = if is_last_label { 0.25em } else {
                    label.len() * 0.5em
                }

                // Get the position
                let position = index * spacing - (x_offset)

                // Place the tick mark and the label below
                place(
                    grid(
                        align: center,
                        row-gutter: 0.25em,
                        line(start: (0pt, 5pt), end: (0pt, -5pt)),
                        text(label),
                    ),
                    dx: position,
                )

                // If it's the last label, break out of the loop
                if is_last_label { break }

                // If labelling distance is wanted
                if label_distance {
                    //

                    // Place the distances above
                    place(
                        text($frac(delta x, 2)$),
                        dx: position + spacing / 2,
                        dy: -1.5em,
                    )
                }
            }
        },
    ),
)

#let internal_node_line = west_east_line.with(("W", "w", "P", "e", "E"))
#let start_boundary_line = west_east_line.with(("w", "P", "e", "E"))
#let end_boundary_line = west_east_line.with(("W", "w", "P", "e"))

== Finite difference method
The finite difference method takes the gradient by using the basic gradient
formula:
$frac(dif phi.alt, dif x) = frac(phi.alt_2 - phi.alt_1, x_2 - x_1)$

== Central differencing scheme
#internal_node_line()
The central differencing scheme takes the point to the immediate right and
immediate left of the current point to evaluate the gradient.

#align(center, grid(
    columns: 3,
    column-gutter: 2em,
    align: center + horizon,
    $evaluated(frac(dif phi.alt, dif x))_P
    = frac(phi.alt_e - phi.alt_w, delta x),$,
    $evaluated(frac(dif phi.alt, dif x))_w
    = frac(phi.alt_P - phi.alt_W, delta x),$,
    $evaluated(frac(dif phi.alt, dif x))_e
    = frac(phi.alt_E - phi.alt_P, delta x)$,
))

#v(1pt)

== Forward differencing scheme
#start_boundary_line()
#align(
    center,
    $frac(dif phi.alt, dif x) = frac(phi.alt_P - phi.alt_w, frac(delta x, 2))
    = frac(2 phi.alt_P - 2 phi.alt_w, delta x)$,
)

== Backward differencing scheme
#end_boundary_line()
#align(
    center,
    $frac(dif phi.alt, dif x) = frac(phi.alt_e - phi.alt_P, frac(delta x, 2))
    = frac(2 phi.alt_e - 2 phi.alt_P, delta x)$,
)

== Finite volume method
#internal_node_line()

$dif/(dif x) (k frac(dif T, dif x)) + q = 0$

$integral_w^e dif/(dif x) (k frac(dif T, dif x)) thin dif x
+ integral_w^e q thin dif x = integral_w^e 0 thin dif x$

$(k frac(dif T, dif x))_e - (k frac(dif T, dif x))_w + q_e - q_w = 0$

$(k frac(dif T, dif x))_e - (k frac(dif T, dif x))_w + delta x = 0$

== Upwind scheme
The upwind scheme is used when there is high fluid velocity ($u$) to get the
values of $phi.alt_e$ and $phi.alt_w$.

#let long_arrow(
    length,
    direction: right,
    colour: red,
    arrow_label: none,
) = block({
    let stroke = 0.5pt + colour
    grid(
        align: center,
        row-gutter: 0.3em,
        text(arrow_label, colour),
        line(length: length, stroke: stroke),
    )
    let y_offset = 0em
    let x_offset = 0em
    if direction == right {
        place(
            line(
                start: (length, 0pt),
                end: (length - 0.5em, 0.25em),
                stroke: stroke,
            ),
            dy: y_offset,
            dx: x_offset,
        )
        place(
            line(
                start: (length, 0pt),
                end: (length - 0.5em, -0.25em),
                stroke: stroke,
            ),
            dy: y_offset,
            dx: x_offset,
        )
    } else if direction == left {
        place(
            line(
                start: (0pt, 0pt),
                end: (0.5em, 0.25em),
                stroke: stroke,
            ),
            dy: y_offset,
            dx: x_offset,
        )
        place(
            line(
                start: (0pt, 0pt),
                end: (0.5em, -0.25em),
                stroke: stroke,
            ),
            dy: y_offset,
            dx: x_offset,
        )
    }
})

=== Fluid flowing to the right
#align(center, grid(
    columns: 2,
    column-gutter: -3em,
    align: (right + top, horizon),
    long_arrow(3em, arrow_label: $u$), block(internal_node_line(), inset: 2em),
))

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    $phi.alt_w = phi.alt_W$, $phi.alt_e = phi.alt_P$,
))
#v(1pt)

=== Fluid flowing to the left
#align(center, grid(
    columns: 2,
    column-gutter: -3em,
    align: (horizon, left + top),
    block(internal_node_line(), inset: 2em),
    long_arrow(3em, arrow_label: $u$, direction: left),
))

#align(center, grid(
    columns: 2,
    column-gutter: 2em,
    align: center + horizon,
    $phi.alt_w = phi.alt_P$, $phi.alt_e = phi.alt_E$,
))
#v(1pt)

=== Peclet number
$"Pe" = frac(delta x rho u, mu) < 2$ for central differencing scheme to apply

== Transient response
$"Future T:" T(Delta t) = T^((1)),
quad "Past T:" T(0) = T^((0))$

The formulas below are only used when the equation cannot be directly integrated
to remove the derivative.

- Implicit scheme for time: \
    $integral_0^(Delta t) f(t) thin dif t = f(Delta t) Delta t$

- Explicit scheme for time: \
    $integral_0^(Delta t) f(t) thin dif t = f(0) Delta t$

    Stability criterion: \
    $Delta t < rho frac((delta x)^2, 2 Gamma)$

- Estimation of space: \
    $integral_a^b f(x) thin dif x = f(frac(a + b, 2)) (b - a)$

== Iterative techniques
$bmat(2, 1, 1; -1, 3, -1; 1, -1, 2) cvec(x_1, x_2, x_3) = cvec(7, 2, 5)$

Equation form: \
$2x_1 + x_2 + x_3 = 7$ \
$-x_1 + 3x_2 - x_3 = 2$ \
$x_1 - x_2 + 2x_3 = 5$ \

Always rearrange the first equation to place $x_1$ on the left-hand side, the
second equation to get $x_2$ on the left-hand side, and so on: \
$x_1 = (7 - x_2 - x^3)/2$ \
$x_2 = (2 + x_1 + x^3)/3$ \
$x_3 = (5 - x_1 + x^2)/2$ \
#v(1pt)

=== Scarborough criterion
- For every row in the matrix, look at the diagonal value in the matrix and take
    the absolute value. This term is denoted as $lr(|a_P|)$.
- Then, sum up the absolute values of the values beside that diagonal value.
    This term is denoted as $sum lr(|a_(n b)|)$.
- The Scarborough criterion is: \
    $frac(sum lr(|a_(n b)|), lr(|a_P|)) <= 1$ for every row in the matrix, and
    $< 1$ for at least one row in the matrix

#colbreak()

=== Jacobi method
+ Guess values on the right-hand side, like setting everything to 0 for example.
+ New values can be calculated on the left-hand side.
+ Substitute the new values into the right-hand side and evaluate the left-hand
    side again.
+ Repeat the process until there is no more change in the solution.

=== Gauss-Seidel method
This method is similar to the Jacobi method, but instead of solving all the
simultaneous equations at the same time to get the value of each unknown, solve
each equation individually, then use the new value when solving the next
equation for the next unknown.

==== Example
#align(center, grid(
    columns: 2,
    column-gutter: 3em,
    align: left,
    $x_1 = (7 - x_2 - x^3)/2$,
    $x_1^((1)) = (7 - x_2^((0)) - x_3^((0)))/2 = (7 - 0 - 0)/2 = 7/2$,

    $x_2 = (2 + x_1 + x^3)/3$,
    $x_2^((1)) = (2 + x_1^((1)) + x_3^((0)))/3 = (2 + 3.5 + 0)/3 = 11/6$,

    $x_3 = (5 - x_1 + x^2)/2$,
    $x_3^((1)) = (5 - x_1^((1)) + x_2^((1)))/2 = (5 - 3.5 + 1.8333)/2 = 5/3$,
))

Where:
- $x^((0))$ denotes the start value, or iteration 0
- $x^((1))$ denotes iteration 1
- $x^((n))$ denotes iteration $n$

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
$frac(d, d x) (arcsin x) = 1 / sqrt(1 - x^2)$ \
$frac(d, d x) (arccos x) = - 1 / sqrt(1 - x^2)$ \
$frac(d, d x) (arctan x) = frac(1, 1 + x^2)$ \
$frac(d, d x) (csc x) = - csc x cot x$ \
$frac(d, d x) (sec x) = sec x tan x$

== Integrals
$integral 1/x = ln lr(|x|)$

$integral sin x thin d x = - cos x$

$integral cos x thin d x = sin x$

$integral frac(1, x^2 + a^2) thin d x = 1 / a arctan (x / a)$

$integral 1 / sqrt(a^2 - x^2) thin d x = arcsin (x / a)$

$integral frac(1, x^2 - a^2) thin d x
= frac(1, 2 a) ln lr(|frac(x - a, x + a)|)$

$integral frac(1, a^2 - x^2) thin d x
= frac(1, 2 a) ln lr(|frac(a + x, a - x)|)$

$integral 1 / sqrt(x^2 - a^2) thin d x = ln lr(|sqrt(x^2 - a^2) + x|)$

$integral tan x thin d x = ln |sec x|$

$integral cot x thin d x = ln |sin x|$

$integral csc x thin d x = - ln |csc x + cot x|$

$integral sec x thin d x = - ln |sec x + tan x|$

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
