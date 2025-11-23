#import "@preview/fancy-units:0.1.1": qty, unit

#set page(numbering: "1")
#set heading(numbering: "1.1")

= Sample calculations

$ R = #qty[10][mm] $
$ k = #qty[16.3][W m^-1 K^-1] $
$ c = #qty[460][J kg^-1] $
$ rho = #qty[8500][kg m^-3] $
$ alpha = 0.45 times 10^(-5) #unit[m^2 s^-1] $

== High speed

When $t = #qty[36][s]$:
$ T_oo = T_1 = 84.39 $
$ T_c = T_3 = 82.38 $
$ T_i = T_(3 @ t = #qty[0][s]) = 30.36 $
$
    theta & = frac(T_c - T_oo, T_i - T_oo) \
          & = frac(82.38 - 84.39, 30.36 - 84.39) \
          & = 67/1801 \
          & approx 0.037 "(same as computed value)"
$

$
    F_o & = frac(alpha t, R^2) \
        & = frac((0.45 times 10^(-5)) (36), (0.01)^2) \
        & = 1.62 "(same as computed value)"
$

From the chart, $1/"Bi" = 0.61$:
$
    h & = frac("Bi" k, R) \
      & = frac((1/0.61) (16.3), 0.01) \
      & = 163000/61 \
      & approx 2672.13 "(same as computed value)"
$

#pagebreak()

== Low speed

When $t = #qty[36][s]$:
$ T_oo = T_1 = 83.21 $
$ T_c = T_3 = 80.52 $
$ T_i = T_(3 @ t = #qty[0][s]) = 33.23 $
$
    theta & = frac(T_c - T_oo, T_i - T_oo) \
          & = frac(80.52 - 83.21, 33.23 - 83.21) \
          & = 269/4998 \
          & approx 0.054 "(same as computed value)"
$

$
    F_o & = frac(alpha t, R^2) \
        & = frac((0.45 times 10^(-5)) (36), (0.01)^2) \
        & = 1.62 "(same as computed value)"
$

From the chart, $1/"Bi" = 0.79$:
$
    h & = frac("Bi" k, R) \
      & = frac((1/0.79) (16.3), 0.01) \
      & = 163000/79 \
      & approx 2063.29 "(same as computed value)"
$

#pagebreak()

= Discussion
The following four points is required to discuss:
#enum(
    numbering: "a)",
    [$T_1$, $T_2$, and $T_3$ versus time at different pump rates;],
    [
        The non-dimensional temperature difference, $theta$ versus time at
        different pump rates;
    ],
    [The effect of pump rates on the heat convection coefficient ($h$);],
    [The heat convection coefficient ($h$) versus time.],
)

== $T_1$, $T_2$, and $T_3$ versus time at different pump rates
Overall, when the pump speed is high, all the temperatures $T_1, T_2$, and $T_3$
are generally higher than when the pump speed is low.

For the graph of $T_1$ against time, the temperatures are relatively constant
for both low-speed and high-speed pump rates due to the water bath maintaining
the temperature, which was kept constant for both setups.

For the graph of $T_2$ against time, for both the low-speed and high-speed pump
rates, the temperature increased at a decreasing rate until it reached a
constant value.

For the graph of $T_3$ against time, both the low-speed and high-speed pump
produced a graph that increased at a decreasing rate, but the initial rate of
increase is much higher than that of the graph of $T_2$ against time. This is
due to the larger temperature difference initially, which results in a much
greater rate of heat transfer.

#heading(
    [
        The non-dimensional temperature difference, $theta$ versus time at
        different pump rates
    ],
    level: 2,
)
The non-dimensional temperature difference, $theta$ versus time decreased at a
decreasing rate until it reached a constant value after $t = #qty[64][s]$. The
high-speed pump had a higher rate of decrease than the low-speed pump. This
suggests that the rate of heat transfer is higher for the high-speed pump than
it is for the low-speed pump. This is due to higher flow velocity, increasing
the turbulence of the water, which increases the Reynolds number, resulting in a
higher rate of heat transfer by convection.

== The effect of pump rates on the heat convection coefficient ($h$)
The heat convection coefficient was higher for the high-speed pump rate compared
to the low-speed pump rate, up until about #qty[55][s]. This can be attributed
to a higher rate of heat transfer by convection as the flow rate of water in the
cylinder is higher, and hence more turbulent.

== The heat convection coefficient ($h$) versus time
The heat convective coefficient for both the low-speed and high-speed pumps
decreases at a decreasing rate until it reaches a constant value. In theory, the
heat convective current should be constant since the pump rate, which affects
the flow rate, is kept constant throughout the experiment. This decrease in the
heat convection coefficient is due to the Biot number not being known, and hence
needs to be derived from the Heisler charts using the Fourier number and the
temperature difference to obtain the inverse of the Biot number. Since the
temperature difference decreases over time, it is expected that the Biot number
obtained from this method will also decrease with time, which explains the
decreasing $h$ values. If Biot number is calculated using the $theta$ and
Fourier number values for the entire duration of the experiment, then the $h$
values would remain constant as expected.
