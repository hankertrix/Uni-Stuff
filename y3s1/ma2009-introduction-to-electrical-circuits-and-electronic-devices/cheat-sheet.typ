#import "@preview/fancy-units:0.1.1": qty, unit

#set page(numbering: "1")
#set heading(numbering: "1.1")
#{
    set document(
        title: "MA2009 Introduction to Electrical Circuits "
            + "and Electronic Devices Cheat Sheet",
        author: "Hankertrix",
    )
    align(center, text(3em)[*#context document.title*])
    align(center, text(2em)[#context document.author.first()])
    outline()
    pagebreak()
}

// Function definitions
#let cimage(..args) = align(center, image(..args))

#show link: set text(blue)

= Definitions

== Series
There is *only one* common node between the connecting devices.

== Parallel
*Both terminals*, or ends of the devices are *each connected to a common node*.
Essentially, the ends of the devices are *connected together*.

== Virtual short circuit
For a virtual short circuit, the device is removed and replaced with a wire.

= Equations

== Voltage ($V$)
$ V = i R $

== Potential difference ($Delta V$)
$ Delta V = V_"start" - V_"end" $

== Current ($i$)
$ i = V/R $

== Resistance ($R$)
$ R = V/i $

=== Resistance in series
$ R_"series" = R_1 + R_2 + dots.c + R_n $

=== Resistance in parallel
$ 1/R_"parallel" = 1/R_1 + 1/R_2 + dots.c + 1/R_n $

== Potential divider
$ V_"out" = R/(R_"Total") V_"in" $

== Power ($P$)
$ P = V i = V^2/R = i^2 R $

== Maximum power transfer ($P_"max"$)
$ P_"max" = 1/4 P = 1/4 V i = 1/4 V^2/R = 1/4 i^2 R $

== Capacitance ($C$)
$ C = Q/V $

== Inductance ($L$)
$ V = L frac(dif i, dif t) $

== Angular frequency ($omega$)
$ omega = 2 pi f $

Where:
- $f$ is the frequency

== Impedance ($Z$)
<impedance>

=== Resistor ($Z_R$)
$ Z_R = R $

=== Inductor ($Z_L$)
$ Z_L = j omega L $

=== Capacitor ($Z_C$)
$ Z_C = 1/(j omega C) = - j/(omega C) $

=== Impedances in series
$ Z_"series" = Z_1 + Z_2 + dots.c + Z_n $

=== Impedances in parallel
$ 1/Z_"parallel" = 1/Z_1 + 1/Z_2 + dots.c + 1/Z_n $

== Frequency response ($H$)
Frequency response is also known as the transfer function, and is a complex
function.

$ H = V_"out"/V_"in" $

== Resonant frequency ($f_r$)
Resonant frequency occurs when the imaginary part of the frequency response,
$H$, is 0, i.e.
$ "Im"(H) = 0 $

== Gain or attenuation ($|H|$)
$ "Gain" = |H| $

#pagebreak()

== Cutoff frequency ($f_c$)
Throughout the whole process, do not substitute any values until the end.
+ Start by using the equation below, and solve for $omega$.
    $ |H| = H_0/sqrt(2) $
+ Manipulate the equation such that the *numerators* of both sides of the
    equation are the *same*.
+ Solve for the magnitude of the denominator of the left side of the equation
    being equal to $sqrt(2)$ to obtain $omega$.
+ Then, use $f_c = omega/(2 pi)$ to find the cut-off frequency.

== Decibels (#unit[dB])
$ #unit[dB] = 20 lg x $

Where:
- $x$ is the value to convert to decibels

=== Gain in decibels
$ "Gain in" #unit[dB] = 20 lg |H| $

== Independent node voltages
$ N_v = N_n - N_s - 1 $

Where:
- $N_v$ is the number of independent node voltages
- $N_n$ is the *total* number of nodes, including trivial nodes, which are nodes
    that have no branches
- $N_s$ is the number of *voltage* sources

== Independent mesh currents
$ N_v = N_m - N_s - 1 $

Where:
- $N_v$ is the number of independent mesh currents
- $N_m$ is the *total* number of meshes
- $N_s$ is the number of *current* sources

= Kirchhoff's Current Law (KCL)
Kirchhoff's Current Law (KCL) states that the sum of currents entering a node is
equal to the sum of currents exiting the node.

$ sum i_"enter" = sum i_"exit" $

= Kirchhoff's Voltage Law (KVL)
Kirchhoff's Voltage Law (KVL) states that the sum of voltages around a closed
loop is equal to 0.

$ sum_(i = 1)^n V_i = 0 $

#pagebreak()

= Node voltage method
Steps:
+ Identify the nodes of unknown voltages.
+ Write KCL equations for each node. Use Ohm's law to represent the current for
    resistors, i.e. $i = V/R$.
+ Solve the system of linear equations from step 2.

Tips:
- Ground is #qty[0][V].
- If no ground is assigned, put the ground at the node with many branches.
- Use Kirchhoff's current law on supernodes containing ungrounded voltage
    sources. The voltage difference of its terminals is another equation.
- If the direction of the current is unknown, just assuming that the current is
    flowing *out of the node*.

== Supernodes
- Supernodes are nodes that encompass or include a voltage source.
- They look like a "bubble" surrounding the voltage source and its two terminals
    which are its two individual nodes.
- A single KCL equation is to be written for the supernode showing currents
    entering and leaving the "bubble" at the terminals.
- Use supernodes when encountering an *ungrounded voltage source*, like a
    voltage source between two resistors for example.
- The potential difference of the voltage source's two terminals gives another
    equation.

= Mesh current method
Steps:
+ Assign all mesh currents as clockwise, labelling each with $i_a, i_b, i_c$,
    etc.
+ Write a KVL equation for each mesh current and express the voltage in terms of
    current and resistance, i.e. $V = i R$.
+ Solve the system of equations from step 2.

Tips:
- A voltage *gain*, i.e. going from lower to higher potential, like going
    through a voltage source, is *positive*.
- A voltage *drop*, i.e. going from higher to lower potential, like going
    through a resistor, is *negative*.
- The net current in the common branch between two meshes is the difference
    between the currents in the two meshes. For example, assuming $i_a$ is in
    the clockwise direction:
    $ i_"net" = i_a - i_b $
- Write a KVL equation for *supermeshes containing current sources*.
    Essentially, you *skip* over the branch with the current source and use the
    bigger loop instead. The current source dictates the branch current that it
    is on, giving another equation.
- If a negative current is obtained from solving the system of equations, that
    means the current flow in the mesh is in the opposite direction of the
    assumed direction, which would be anti-clockwise, following the convention
    of clockwise currents being positive.

#pagebreak()

= Thevenin and Norton equivalent circuits
Steps:
+ Remove the load from the circuit.
+ Leave the circuit *open* and find the *open-circuit* or Thevenin voltage
    ($V_"Th"$).
+ Join the open-circuit with a normal wire and find the *short-circuit* or
    Norton current ($i_N$).
+ Obtain the equivalent resistance from the *open-circuit voltage* and the
    *short-circuit* current with:
    $ R_"Th" = R_N = V_"Th"/i_N $.
+ Redraw the circuit as a Thevenin circuit or a Norton circuit based on what you
    need.

#figure(
    image("./images/thevenin-equivalent-circuit.png", height: 8em),
    caption: [Thevenin equivalent circuit.],
)

#figure(
    image("./images/norton-equivalent-circuit.png", height: 8em),
    caption: [Norton equivalent circuit.],
)

== Resistance
The equivalent or total resistance of the circuit is:
$ R_"Th" = V_"Th"/i_N $

== Maximum power transfer
$ P_"max" = V_"Th"^2/(4 R_"Th") $

#pagebreak()

= Capacitors
Capacitance ($C$):
$ C = Q/V $

Current ($i$):
$ i = C frac(dif V, dif t) $

Voltage ($V$):
$ V = 1/C integral_0^T i thin dif t $

Energy stored ($E_c$):
$ E_C = 1/2 C V^2 $

Impedance ($Z$):
$ Z_C = 1/(j omega C) = - j/(omega C) $

At *DC steady state*, think about *pulling the plates apart*, so a capacitor at
DC steady state is an *open circuit*.

= Inductors
Voltage ($V$):
$ V = L frac(dif i, dif t) $

Current ($i$):
$ i = 1/L integral_0^T V thin dif t $

Energy stored ($E_L$):
$ E_L = 1/2 L i^2 $

Impedance ($Z$):
$ Z_L = j omega L $

At *DC steady state*, think about *pulling the wires apart*, so an inductor at
DC steady state is a *short circuit*, or a *straight wire*.

#pagebreak()

= Root Mean Square (RMS) values
$ f_"RMS" = sqrt(frac(integral_0^T (f(t))^2 thin dif t, T)) $

For sine waves:
$ f_"RMS" = f_"peak"/sqrt(2) $

For square waves:
$ f_"RMS" = f_"peak" $

For triangle or sawtooth waves:
$ f_"RMS" = f_"peak"/sqrt(3) $

= Phasors
$ f(t) = A cos (omega t + phi.alt) $
$ f(t) = A sin (omega t + phi.alt) = A cos (omega t + phi.alt - 90 degree) $
$ "Phasor" = A angle phi.alt $

Where:
- $A$ is the amplitude
- $omega$ is the angular frequency, where $omega = 2 pi f$, and $f$ stands for
    frequency
- $phi.alt$ is the phase offset

== Drawing a phasor
- Just treat the phasor as a vector, but label the $x$-axis as the real axis
    (Re) and the $y$ axis as the imaginary axis (Im).
    - The diagram is called the Argand diagram.
    - The plane is sometimes called the Gauss plane.
- *Anti-clockwise is positive*, while *clockwise is negative*.

= Alternating current (AC) analysis
Steps:
+ Convert everything to a complex number or a phasor using the #link(
        <impedance>,
    )[impedance formulas].
+ Use familiar formulas to solve.
+ Change the complex number back to normal.

Tips:
- For requirements involving *DC voltages*, pull out all the *constant terms*,
    which are the terms *without* #math.sin or #math.cos.
- For requirements involving *AC voltages*, pull out all the *varying terms*,
    which are the terms *with* #math.sin or #math.cos.

#pagebreak()

= Filters

== Low-pass filters
Low-pass filters are filters that allow *low frequencies* to *pass through*.

#cimage("./images/low-pass-filter.webp", height: 25em)

== High-pass filters
High-pass filters are filters that allow *high frequencies* to *pass through*.

#cimage("./images/high-pass-filter.webp", height: 25em)

== Band-pass filters
Band-pass filters are filters that allow only a range of frequencies to pass
through.

#cimage("./images/band-pass-filter.webp", height: 25em)

== Pass band
*Pass* band is the range of frequency that is allowed to *pass through*.

== Stop band
*Stop* band is the range of frequency that is *blocked*.

== Steps
<filter-steps>
+ Use the potential divider equation to obtain $V_"out"/V_"in"$ to get $H$.
+ Look at how $H$ changes at low and high frequencies:
    - For low frequencies, look at how $H$ changes when $omega -> 0$.
    - For high frequencies, look at how $H$ changes when $omega -> oo$.
    - If the value of $H$ is *0*, that means the range of frequency is
        *blocked*.
    - If the value of $H$ is *non-zero*, that means the range of frequency is
        *allowed to pass*. This value is called the maximum gain, or $H_0$.
    - Hence, whichever range of frequency results in $H$ being *non-zero* is the
        type of filter.
    - For *band-pass filters*, the value at $H$ at *both high and low*
        frequencies is *0*. To find the maximum gain $H_0$, it occurs at
        *resonant frequency*, where the *imaginary part of $H$ is 0*, i.e.
        $ H_0 = H "where" "Im"(H) = 0 $

#pagebreak()

== Bode plot
Things to obtain before plotting the graph:
+ Shape of the graph, whether the filter is a low-pass or high-pass filter.
+ Maximum gain or $H_0$, which is obtained from the value of $H$ in the
    *pass-band*.
+ The cut-off frequency, $f_c$ or $omega_c$.

Plotting the graph:
- The cut-off frequency will be at $H_0 - #qty[3][dB]$, or #qty[3][dB] lower
    than the maximum gain $H_0$.
- The gradient of the slanted line is always #qty[20][dB dec^-1], or
    #qty[20][dB] per decade.
    - If the line is slanting up, then it is #qty[20][dB dec^-1].
    - If the line is slanting down, then it is #qty[-20][dB dec^-1].

= Operational amplifiers (Op-amp)
- The voltage at the positive terminal of the op-amp is equal to that of the
    negative terminal.
    $ V^+ = V^- $
- The current at the both the positive and negative terminal of the op-amp is 0.
    $ i^+ = i^- = 0 $
- Use KCL at the nodes at the terminals of the op-amp when needed.

== Op-amps in series
For composite op-amps, or op-amps in series, the overall gain is the product of
the gains of each stage, i.e.
$
    V_"out"/V_"in" = V_"out"/V_n times V_n/V_(n - 1) times
    dots.c times V_2/V_1 times V_1/V_"in"
$

The order doesn't matter, as multiplication is commutative, but the order above
is from the last stage to the first stage.

== Role of op-amps
- Op-amps can either be a filter or an amplifier.
- If you see *$omega$* in the gain ($H$) of the amplifier, it is a *filter*.
    - Use the #link(<filter-steps>)[same steps for filters] to figure out the
        kind of filter the op-amp is.
- Otherwise, it is an amplifier.
    - If there is a *negative (-)* sign on the gain ($H$), the op-amp is an
        *inverting* amplifier.
    - If there is *positive (+)* value on the gain ($H$), the op-amp is a
        *non-inverting* amplifier.
- When given a specific input function, if there are *different frequencies
    (different coefficients of $t$)*, make sure to obtain the *cut-off
    frequencies* for the filters and *remove* the frequencies that are blocked
    by the filters.

= Plotting graphs
- Use the defining equations for the component, like a resistor, capacitor,
    inductor, etc.
- Split the graphs into segments and use the defining equations to obtain the
    values and the shape of the graph.
