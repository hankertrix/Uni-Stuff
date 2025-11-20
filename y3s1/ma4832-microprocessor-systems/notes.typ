#set page(numbering: "1")
#set heading(numbering: "1.1")
#{
    set document(
        title: "MA4823 Microprocessor Systems Notes",
        author: "Hankertrix",
    )
    align(center, text(3em)[*#context document.title*])
    align(center, text(2em)[#context document.author.first()])
    outline()
    pagebreak()
}

// Imports
#import "@preview/titleize:0.1.1": titlecase
#import "@preview/fancy-units:0.1.1": qty, unit

// Function definitions
#let mathred(content) = text(fill: red, $#content$)
#let cimage(..image_args) = align(center, image(..image_args))

#show link: it => if repr(it.body).contains("page") { it } else {
    let destination = it.dest
    let content = it.body
    [#content (#ref(destination))]
}
#show ref: it => {
    if it.element == none { return it }
    let label = it.target
    let element = it.element
    link(label, text(blue)[page #element.location().page()])
}

= Abbreviations

== MCU
MCU stands for microcontroller.

== ARM
ARM stands for Advanced RISC Machines.

== RISC
RISC stands for Reduced Instruction Set Computer.

== ISA
ISA stands for Instruction Set Architecture which is innate to all processors.

== SVC
SVC stands for supervisor call instruction.

== FIQ
FIQ stands for fast interrupt request.

== DMA
DMA stands for direct memory access.

== SPSR
SPSR stands for the saved program status register.

== CPSR
CPSR stands for the current program status register.

== SP
SP stands for the stack pointer.

== LR
LR stands for the link register.

== MMU
MMU stands for memory management unit.

== MPU
MPU stands for memory protection unit.

== AMBA
AMBA stands for advanced microcontroller bus architecture.

== SoC
SoC stands for system-on-a-chip.

== APB
APB stands for advanced peripheral bus.

== AHB
AHB stands for advanced high-performance bus.

== JTAG
JTAG stands for Joint Test Action Group.

== RAM
RAM stands for random access memory.

== CPU
CPU stands for central processing unit.

== FET
FET stands for field effect transistor.

== SRAM
SRAM stands for static RAM, or Static Random Access Memory.

== DRAM
DRAM stands for dynamic RAM, or Dynamic Random Access Memory.

== SLC
SLC stands for single level cell.

== ALU
ALU stands for arithmetic logic unit.

== APSR
APSR stands for application program status register.

== EPSR
EPSR stands for execution program status register.

== IPSR
IPSR stands for interrupt program status register.

== I/O
I/O stands for input and output.

== NVIC
NVIC stands for nested vectored interrupt controller.

== SysTick
SysTick stands for system tick timer.

== Opcode
Opcode stands for operation code.

== MSB
MSB stands for most significant bit.

== LSB
LSB stands for least significant bit.

== VFP
VFP stands for vector floating point.

== FPU
FPU stands for floating point unit.

== MPU
MPU stands for multicore processing unit.

== GiB
GiB stands for gibibyte.

== IDE
IDE stands for integrated development environment.

== I/O or IO
I/O or IO stands for input/output.

== GPIO
GPIO stands for general purpose input/output.

== ADC
ADC stands for analogue to digital converter.

== PWM
PWM stands for pulse width modulation.

== UART
UART stands for universal asynchronous receiver/transmitter.

== DTE
DTE stands for data terminal equipment.

== DCE
DCE stands for data communication equipment.

== TX or Tx
TX or Tx stands for transmitting.

== RX or Rx
RX or Rx stands for receiving.

== GND
GND stands for ground.

== BRD
BRD stands for baud-rate divider.

== TTL
TTL stands for transistor-transistor logic.

== RTOS
RTOS stands for real time operating system.

== CCP
CCP stands for capture, compare and PWM.

== IRQ
IRQ stands for interrupt request.

== ISR
ISR stands for interrupt service routine.

#pagebreak()

= Definitions

== Microprocessor system
A microprocessor system is a system which is built on top of logic devices that
can:

- Undertake arithmetic operations
- Undertake logic operations
- Interface with external devices

== Word
A word is a 2 byte (16-bit) value.

== Using I/O modules
- Configure control registers
- Clear or monitor status registers
- Read or write data registers
- Instructions:
    - `MOV <address of destination>, <source of value>`

        Move instruction, which copies the value from the source to the
        destination.

    - `LDR <address of destination>, <source of value>`

        Load register instruction, which loads a value from a memory address
        into a register.

    - `STR <address of destination>, <source of value>`

        Store instruction, which stores a value from a register to a memory
        address.

== Bits and bytes
- 8 bits are called a byte.
- 16 bits of 2 bytes are called a half-word.
- 32 bits or 4 bytes are called a word.
- 64 bits or 8 bytes are called a double-word.

== Fast interrupt request (FIQ)
An fast interrupt request (FIQ) is a higher priority interrupt request, that is
prioritised by disabling interrupt request (IRQ) and other fast interrupt
request handlers during request servicing. Therefore, no other interrupts can
occur during the processing of the active FIQ interrupt.

== Direct memory access (DMA)
Direct memory access (DMA) is a feature of microprocessor systems that allows
certain hardware subsystems to access main system memory such as RAM (Random
Access Memory) independently of the central processing unit (CPU).

== Truth table
A truth table maps the all the possible inputs to the outputs. Below is truth
table of an inverter.

#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Input], [Output]),
    [1], [0],
    [0], [1],
)]

== Rising edge
- A rising edge is when the input transitions from 0 to 1.
- A transistor, if not notated, is usually sensitive to the rising edge as shown
    below.

#cimage("./images/rising-edge-trigger.png")

== Falling edge
- A falling edge is when the input transitions form 1 to 0.
- A transistor sensitive to the falling edge is notated using a small circle at
    the input of the transistor, as shown below.

#cimage("./images/falling-edge-trigger.png")
#pagebreak()

== Bus
- A bus is essentially a *data highway* that transfers data between components
    inside a computer or between computers.
- It encompasses both hardware, like wires, optical fibre, and software,
    including communication protocols.

=== Address bus
- An address bus is a bus that is used to specify a physical address.
- When a processor or DMA-enabled device needs to read or write to a memory
    location, it specifies that memory location on the address bus.
- The width of the address bus determines the amount of memory a system can
    address.
- For example, a system with a 32-bit address bus can address 2#super[32] memory
    locations.
- If each memory location holds one byte, the addressable memory space is about
    4 GB.

=== Data bus
- A data bus is a bus that transfers data between different components inside a
    computer or between computers.
- The amount of bytes a memory unit can read or write is dependent on the number
    of lines of the data bus, rather than the address bus.

== Endianness of memory
- *Endianness* is the ordering or sequencing of bytes of a word of digital data
    in computer memory storage or during transmission.
- Words may be represented in *big-endian* or *little-endian* manner.
- *Big-endian* systems store the *most-significant* byte of a word at the
    *smallest* memory address and the *least-significant* byte at the *largest*.
- *Little-endian* systems store the *least-significant* byte of a word at the
    *smallest* memory address and the *most-significant* byte at the *largest*.

#cimage("./images/endianness-of-memory.png")

== Base address
The base address is a common reference for a series of related addresses.

== Address offset
The address of set is an individual offset from a common reference address.

== Address indexing
Address indexing refers to the operation of adding an offset to a base address.
$ "Address indexing" = "Base address" + "Offset" = "[Base address, offset]" $

== Configuration register
A configuration register is a register with programmable switches.

== Maskable data register
A maskable data register is a data register that has a pin selection mask.

=== Example
- `GPIO_PORTF_DIR_R EQU 0x40025 400` is the GPIO direction (input or output).
- `GPIO_PORTF_AFSEL_R EQU 0x40025 420` is the GPIO alternate function select.
- `GPIO_PORTF_PUR_R EQU 0x40025 510` is the GPIO pull up select (whether to
    enable the pull-up resistors or not).
- `GPIO_PORTF_DEN_R EQU 0x40025 51C` is the GPIO digital enable.
- `GPIO_PORTF_AMSEL_R EQU 0x40025 528` is the GPIO analogue mode select.
- `GPIO_PORTF_PCTL_R EQU 0x40025 52C` is the GPIO port control.
- `PF1 EQU 0x40025 008` is the GPIO "port" address.
- `PF2 EQU 0x40025 010` is the GPIO "port" address.
- `PF3 EQU 0x40025 020` is the GPIO "port" address.
- `PF4 EQU 0x40025 040` is the GPIO "port" address.
- `PFA EQU 0x40025 038` is the address of 3 ports, `PF1 - PF3`.
- `SYSCTL_RCGCGPIO_R EQU 0x400FE608` is the run mode clock gating control.

=== Why have maskable data registers?
+ Security in control, to avoid situations where the intention is to turn on one
    motor, but several other motors have been turned on instead.
+ Security in communication, to stop others from interpreting the intercepted
    data in a communication. This is possible because intercepted data is not
    filtered by any specific mask, and received data is filtered by a specific
    mask.

#pagebreak()

= Basics of brains

== Characteristics of the human brain
- Able to memorise past, present and future.
- Able to capture input data.
- Able to undertake operations with numbers or symbols.
- Able to produce output data.
- Able to control mental operations.
- Able to control physical actions.
- Able to communicate.
- Able to learn human languages.
- Able to learn machine languages.
- Able to learn new knowledge and new skills.

== Blueprint of a machine brain
#cimage("./images/machine-brain-blueprint.png")

== Characteristics of a machine brain
- Able to memorise data (to use) and instructions (to do)
- Able to capture input data.
- Able to undertake arithmetics operations with numbers.
- Able to undertake logic operations with numbers and symbols.
- Able to produce output data.
- Able to control mental operations.
- Able to control physical actions.
- Able to communicate.
- Able to learn human languages in the future.
- Able to learn machine languages in the future.
- Able to learn new knowledge and new skills in the future.

== Van Neumann architecture
#cimage("./images/van-neumann-architecture.png")

== Harvard architecture
#cimage("./images/harvard-architecture.png")
#pagebreak()

= ARM: Advanced RISC Machines
- ARM Ltd was founded in 1990
- ARM Ltd is headquartered in Cambridge, UK

== ARM Family
- Cortex-M Series: For microcontroller applications
- Cortex-R Series: For real-time applications
- Cortex-A Series: For advanced applications

#cimage("./images/arm-family.png")

== ARM Cortex uses the RISC architecture
- ARM uses the RISC architecture.
    - ISA stands for Instruction Set Architecture which is innate.
    - RISC stands for Reduced Instruction Set Computer.
    - Most instructions execute in a single cycle.
    - ARM instruction set is 32-bit.
    - Thumb instruction set is 16 or 32-bit.
- ARM is a 32-bit load-store architecture.
    - 8 bits are called a byte.
    - 16 bits of 2 bytes are called a half-word.
    - 32 bits or 4 bytes are called a word.
    - 64 bits or 8 bytes are called a double-word.
    - The only memory accesses are loads and stores.

=== Architecture of the ARM7TDMI Processor
#cimage("./images/arm7tdmi-processor.png")

== Modes in ARM Cortex
- *Supervisor (SVC)*: Entered on reset and when a Supervisor call instruction
    (SVC) is executed. Privileged and exception mode.
- *FIQ*: Entered when a high priority (fast) interrupt is raised. Priviledge and
    exception mode.
- *IRQ*: Entered when a normal priority interrupt is raised. Privileged and
    exception mode.
- *Abort*: Used to handle memory access violations. Privileged and exception
    mode.
- *Undef*: Used to handle undefined instructions. Privileged and exception mode.
- *System*: Privileged mode using the same registers as User mode.
- *User*: Mode under which most applications and operating system tasks run.
    Unprivileged mode.

== Registers in ARM Cortex
#cimage("./images/arm-registers.png")

Where:

- "SPSR" is the saved program status register
- "CPSR" is the current program status register
- "SP" is the stack pointer
- "LR" is the link register

Note that the system mode uses the user mode register set.

=== Register table
#cimage("./images/arm-register-table.png")
#pagebreak()

=== Current program status register (CPSR, R16)
#cimage("./images/program-status-register.png")

Where GE stands for greater than or equal status flags.

Overview:
#align(center)[#table(
    columns: 3,
    align: left,
    table.header([*Field*], [*Description*], [*Architecture*]),
    [N Z C V], [Condition code flags], [All],
    [J], [Jazelle state flag], [5TEJ and above],
    [GE[3:0]], [SIMD condition flags], [6],
    [E], [Endian load/store], [6],
    [A], [Imprecise abort mask], [6],
    [I], [IRQ interrupt mask], [All],
    [F], [FIQ interrupt mask], [All],
    [T], [Thumb state flag], [4T and above],
    [Mode[4:0]], [Processor mode], [All],
)]

#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([*Flag field*], [*Description*]),
    [*N*], [Negative result from the ALU],
    [*Z*], [Zero result form the ALU],
    [*C*], [ALU operation caused carry],
    [*V*], [ALU operation overflowed],
    [*Q*], [ALU operation saturated],
    [*J*], [Java byte code execution],
)],

#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([*Control bits*], [*Description*]),
    [*I*], [1: Disables IRQ],
    [*F*], [1: Disables FIQ],
    [*T*], [1: Thumb, 0: ARM],
)]

#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([*Mode bits*], [*Description*]),
    [*0b10000*], [User],
    [*0b11111*], [System],
    [*0b10001*], [FIQ],
    [*0b10010*], [IRQ],
    [*0b10011*], [SVC (Supervisor)],
    [*0b10111*], [Abort],
    [*0b11011*], [Undefined],
)]

=== Cortex M4's status register
#cimage("./images/cortex-m4-status-register.png")

Where:

- APSR stands for application program status register
- EPSR stands for execution program status register
- IPSR stands for interrupt program status register

== ARM Cortex as a microcontroller
- ARM supports application profile.
    - Memory Management Unit (MMU).
    - Highest performance at lowest power consumption.
    - Trust zone for a safe and extensible system.
- ARM supports real-time profile
    - Memory Protection Unit (MPU).
    - Low latency and predictability of real-time needs.
    - Tightly coupled memory for fast and deterministic access.
- ARM supports microcontroller profile
    - Lowest gate count entry point.
    - Deterministic and predictable behaviour.
    - Deeply embedded use.

== ARM features
- ARM has two internal buses.
    - The ARM Advanced Microcontroller Bus Architecture (AMBA) is an
        open-standard, on-chip interconnect specification for the connection and
        management of functional blocks in system-on-a-chip (SoC) designs. It
        facilitates development of multiprocessor designs with large numbers of
        controllers and peripherals.
- ARM Cortex supports direct memory access.
- ARM Cortex includes debug port.
    - JTAG (Joint Test Action Group) specifies the use of a dedicated debug port
        implemented a serial communication interface for low-overhead access
        without requiring direct external access to the system address and data
        buses.

== Memory inside TM4C123G
#cimage("./images/memory-in-tm4c123g-1.png")
#cimage("./images/memory-in-tm4c123g-2.png")

== ARM Cortex M's memory space
#cimage("./images/arm-cortex-m-memory-space.png")

- 32-bit addresses support 4 GiB memory space.
- Code, data and I/O share the same memory space.
- Data types are *bytes, half-words*, and *words*.
- Predefined regions have distinct characteristics.
    - Executable
    - Device or strongly-ordered
    - Shareable

=== On-chip memory subspace
#cimage("./images/arm-on-chip-memory-subspace.png", height: 20em)

- On-chip code, data and I/O are located in the first 1.5 GiB of memory space.
- Each is allocated 0.5 GiB.
- May use physically separate buses for each space.

=== Off-chip memory subspace
#cimage("./images/arm-off-chip-memory-subspace.png", height: 20em)

- 1 GiB reserved for each of off-chip data and off-chip devices.
- Off-chip memory bus requires many pins.
- Off-chip memory access time is usually slower and uses more power.

=== Private memory subspace
#cimage("./images/arm-private-memory-subspace.png", height: 20em)

- Private peripheral bus occupies 1 MiB of space.
- Registers that control peripherals that are a mandatory part of the Cortex M
    architecture are mapped here.
    - Nested vectored interrupt controller (NVIC)
    - System tick timer (SysTick)
    - Fault status and control
    - Processor debugging

== Cortex M4 pin diagram
#cimage("./images/cortex-m4-pin-diagram.png")

== Cortex M4 table of pin usage
#cimage("./images/table-of-pin-usage-1.png")
#cimage("./images/table-of-pin-usage-2.png")
#cimage("./images/table-of-pin-usage-3.png")

== Cortex M4's floating point unit's registers
#cimage("./images/cortex-m4-floating-point-unit-registers.png")

= Typical types of application software
#cimage("./images/typical-types-of-application-software.png")

= Binary logic devices
#cimage("./images/logic-gate-symbols.png")

== Binary number systems
#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Binary values], [Implementation]),
    [1 (logic high)], [+5 V (logic high)],
    [0 (logic low)], [0 V (logic low)],
)]

#pagebreak()

== Binary logic operations
#align(center)[#table(
    columns: 6,
    align: (auto, auto),
    [Operation], table.cell(colspan: 5)[Boolean expressions],
    [NOT], [$A'$], [$-A$], [$macron(A)$], [$not A$], [],
    [AND], [$A B$], [$A \* B$], [$A dot.op B$], [$A and B$], [$A inter B$],

    [OR], [$A + B$], [$A or B$], [$A union B$], [], [],
    [NAND], [$(A B)'$], [$overline(A B)$], [], [], [],
    [NOR], [$(A + B)'$], [$overline(A + B)$], [], [], [],
    [XOR], [$A xor B$], [$A @ B$], [], [], [],

    [XNOR],
    [$(A xor B)'$],
    [$overline(A xor B)$],
    [$(A @ B)'$],
    [$overline(A @ B)$],
    [],
)]

== NOT logic gate
#cimage("./images/not-logic-gate-symbol.png")

=== Truth table
#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Input ($A$)], [Output ($macron(A)$)]),
    [1], [0],
    [0], [1],
)]

=== Circuit diagrams
#cimage("./images/not-logic-gate-circuit.png")
#cimage("./images/not-logic-gate-fet-circuit.png")

== AND logic gate
#cimage("./images/and-logic-gate-symbol.png")

=== Truth table
#align(center)[#table(
    columns: 3,
    align: (auto, auto, auto),
    table.header([Input 1 ($X$)], [Input 2 ($Y$)], [Output ($X dot.op Y$)]),
    [0], [0], [0],
    [0], [1], [0],
    [1], [0], [0],
    [1], [1], [1],
)]

=== Circuit diagrams
#cimage("./images/and-logic-gate-circuit.png")
#cimage("./images/and-logic-gate-fet-circuit.png")

== OR logic gate
#cimage("./images/or-logic-gate-symbol.png")

=== Truth table
#align(center)[#table(
    columns: 3,
    align: (auto, auto, auto),
    table.header([Input 1 ($X$)], [Input 2 ($Y$)], [Output ($X + Y$)]),
    [0], [0], [0],
    [0], [1], [1],
    [1], [0], [1],
    [1], [1], [1],
)]

#pagebreak()

=== Circuit diagrams
#cimage("./images/or-logic-gate-circuit.png", height: 30em)
#cimage("./images/or-logic-gate-fet-circuit.png")

== XOR logic gate
#cimage("./images/xor-logic-gate-symbol.png", height: 10em)

=== Truth table
#align(center)[#table(
    columns: 3,
    align: (auto, auto, auto),
    table.header([Input 1 ($X$)], [Input 2 ($Y$)], [Output ($X xor Y$)]),
    [0], [0], [0],
    [0], [1], [1],
    [1], [0], [1],
    [1], [1], [0],
)]

=== Circuit diagrams
#cimage("./images/xor-logic-gate-circuit.png", height: 15em)
#cimage("./images/xor-logic-gate-alternative-circuit.png", height: 15em)

== XNOR logic gate
#cimage("./images/xnor-logic-gate-symbol.png")

=== Truth table
#align(center)[#table(
    columns: 3,
    align: (auto, auto, auto),
    table.header(
        [Input 1 ($X$)], [Input 2 ($Y$)], [Output ($overline(X xor Y)$)]
    ),
    [0], [0], [1],
    [0], [1], [0],
    [1], [0], [0],
    [1], [1], [1],
)]

=== Circuit diagrams
#cimage("./images/xnor-logic-gate-circuit.png")
#pagebreak()

== D flip-flop
- The D flip-flop is a device that is able to store a single bit.
- It is usually used in CPU registers.

#cimage("./images/d-flip-flop-circuit.png", height: 15em)
#cimage("./images/d-flip-flop-simplified-circuit.png", height: 14em)
#cimage("./images/d-flip-flop-alternative-circuit.png", height: 14em)

=== Truth table
#align(center)[#table(
    columns: 5,
    align: (auto, auto, auto, auto, auto),
    table.header([S], [R], [CLK (or Enable)], [$Q (t + 1)$], [Comments]),
    [0], [0], [X], [$Q (t)$], [No change],
    [0], [1], [$arrow.t$], [0], [Reset],
    [0], [1], [$arrow.t$], [1], [Set],
    [1], [1], [$arrow.t$], [?], [Invalid],
)]

The $arrow.t$ shows that the device only responds on the rising edge.

== 8-bit shift register
#cimage("./images/8-bit-shift-register.png")

== Single bit Static RAM (SRAM)
- Static RAM can continue to store memory even when the power is switched off,
    but it is more expensive than dynamic RAM.
- Write operation
    - "Write" line is in logic high.
    - Transistor $T r 1$ is on.
    - $Q = D$
- Read operation
    - "Read" line is in logic high.
    - Transistor $T r 5$
    - $B = 1 - Q$

#cimage("./images/static-ram-circuit.png")
#pagebreak()

== Single bit Dynamic RAM (DRAM)
- Dynamic RAM cannot store memory after it is powered off due to the capacitor
    losing its charge. However, it is cheaper than static RAM due to having
    fewer transistors.
- Write operation
    - "Write" line is in logic high.
    - Transistor $T r 1$ is on.
    - $Q = D$
- Read operation
    - "Read" line is in logic high.
    - Transistor $T r 3$
    - $B = Q$

#cimage("./images/dynamic-ram-circuit.png")

== 1-bit flash cell
#cimage("./images/1-bit-flash-cell.png")

A 1-bit flash cell is made of a single level cell, which has:

- 2 charge states
- 1 bit per floating gate transistor

=== Line of flash cells
#cimage("./images/flash-cell-line.png")

=== Writing
#cimage("./images/flash-cell-write.png")

=== NOR erasing
NOR erasing sets all bits to 1.

#cimage("./images/flash-cell-nor-erasing.png")
#pagebreak()

=== NOR writing
NOR writing sets 0s.

#cimage("./images/flash-cell-nor-writing.png")

=== Reading
- To read from a flash cell, a voltage is applied to the control gate.
- The voltage is in between the voltage of the flash cell when the bit value is
    0, and the voltage of the flash cell when the bit value is 1, i.e.
    $ V_(T 1) > V_(G S) > V_(T 0) $
- If there is no current, the output value is 0.
- If there is a current, the output value is 1.

#cimage("./images/flash-cell-read.png")
#pagebreak()

=== NOR reading
- NOR reading is used to read a single bit from a flash cell line.
- It also uses the same principles as the normal reading, which means the given
    voltage is in between the voltage of the flash cell when the bit value is 0,
    and the voltage of the flash cell when the bit value is 1, i.e.
    $ V_(T 1) > V_(G S) > V_(T 0) $
- Similarly, if there is no current, the output value is 0.
- If there is a current, the output value is 1.

#cimage("./images/flash-cell-nor-reading-one-bit.png")
#pagebreak()

= Number representation

== History of number systems
- Gottfried Wilhelm Leibniz (1646--1716) is the self-proclaimed inventor of the
    binary system and is considered as such by most historians of mathematics
    and mathematicians. However, systems related to binary numbers have appeared
    earlier in multiple cultures including Ancient Egypt, China, and India.
- Modern methods of writing decimals were invented less than 500 years ago.
    However, the use of decimals in various forms can be traced back thousands
    of years. The Babylonians used a number system based on 60 and extend it to
    deal with numbers less than 1. Some use of decimals was also made in ancient
    China, medieval Arabia and in Renaissance Europe.
- Swedish American engineer John Williams Nystrom developed the hexadecimal
    notation system in 1859.
- The eight digits of the octal system are 0, 1, 2, 3, 4, 5, 6, and 7. The octal
    system was first discovered in 1716 by Emanuel Swedenborg, although
    linguists speculate that it was discovered by the Proto-Indo-Europeans, a
    group of Neolithic people ancestors to the Indo-European people of the
    Bronze Age.

== Binary number system

=== Format of binary numbers
- A binary number consists of a series of digits.
- A digit has its value and position in the series.
- One digit on the left is 2 times the digit on the right.
- For example, $1_(M S B) 1 1001 1100 011 1_(L S B)$
- Hence, we can represent binary numbers in the following way:
    $ V = D_(n - 1) D_(n - 2) dots.h.c D_1 D_0 $
- Where:
    $
        D_i in [0, 1], quad i = 0, 1, 2, ... "or" i = - 1, - 2, ...
    $
    $
        V_n = D_(n - 1) 2^(n - 1) + D_(n - 2) 2^(n - 2)
        + dots.h.c + D_1 2^1 D_0 2^0
    $

=== Integer example
#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Binary numbers], [Corresponding decimal values]),
    [$00001111$], [$8 + 4 + 2 + 1 = 15$],
    [$11110000$], [$128 + 64 + 32 + 16 = 240$],
    [$11001100$], [$128 + 64 + 8 + 4 = 204$],
    [$00110011$], [$32 + 16 + 2 + 1 = 51$],
)]

=== Fractional example
#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Binary numbers], [Corresponding decimal values]),
    [$0 . 00001111$], [$0.0313 + 0.0156 + 0.0078 + 0.0039$],
    [$0 . 11110000$], [$0.5 + 0.25 + 0.125 + 0.0625$],
    [$0 . 11001100$], [$0.5 + 0.25 + 0.0313 + 0.0156$],
    [$0 . 00110011$], [$0.125 + 0.0625 + 0.0078 + 0.0039$],
)]

=== Binary addition
- Input:
    $
        V_1 = A_(n - 1) 2^(n - 1) + A_(n - 2) 2^(n - 2) +
        dots.h.c + A_1 2^1 + A_0 + 2^0
    $
    $
        V_2 = B_(n - 1) 2^(n - 1) + B_(n - 2) 2^(n - 2) +
        dots.h.c + B_1 2^1 + B_0 + 2^0
    $
- Output:
    $
        V_3 = C_(n - 1) 2^(n - 1) + C_(n - 2) 2^(n - 2) +
        dots.h.c + C_1 2^1 + C_0 + 2^0
    $
- Rules:
    - $0 + 0 = 0$
    - $0 + 1 = 1$
    - $1 + 0 = 1$
    - $1 + 1 = 0$ with a carry of $1$

    #align(center)[#table(
        columns: 8,
        stroke: none,
        align: (auto, auto, auto, auto, auto, auto, auto, auto),
        [],
        [#text("1", blue)],
        [#text("1", blue)],
        [#text("1", blue)],
        [#text("0", blue)],
        [#text("0", blue)],
        [#text("0", blue)],
        [Carry],

        [], [], [1], [0], [1#sub[2]], [=], [5#sub[10]], [Augend],
        [+], [], [], [1], [1#sub[2]], [=], [3#sub[10]], [Addend],
        table.hline(),

        [],
        [1],
        [#math.attach("0", tl: "1")],
        [#math.attach("0", tl: "1")],
        [#math.attach("0", tl: "1")],
        [=],
        [8#sub[10]],

        [],
    )]

- Example:
    - Augend:
        $ 11110000 $

    - Addend:
        $ 11001100 $

    - Result:

        #align(center)[#table(
            columns: 11,
            stroke: none,
            align: (
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
            ),
            [], [1], [1], [0], [0], [0], [0], [0], [0], [0], [Carry],
            [], [], [1], [1], [1], [1], [0], [0], [0], [0], [Augend],
            [+], [], [1], [1], [0], [0], [1], [1], [0], [0], [Addend],
            table.hline(),

            [], [#text("1", red)], [1], [0], [1], [1], [1], [1], [0], [0], [],
        )]

#pagebreak()

=== Binary subtraction
- Input:
    $
        V_1 = A_(n - 1) 2^(n - 1) + A_(n - 2) 2^(n - 2) +
        dots.h.c + A_1 2^1 + A_0 + 2^0
    $
    $
        V_2 = B_(n - 1) 2^(n - 1) + B_(n - 2) 2^(n - 2) +
        dots.h.c + B_1 2^1 + B_0 + 2^0
    $
- Output:
    $
        V_3 = C_(n - 1) 2^(n - 1) + C_(n - 2) 2^(n - 2) +
        dots.h.c + C_1 2^1 + C_0 + 2^0
    $
- Rules:
    - $0 - 0 = 0$
    - $0 - 1 = 1$ with a borrow of $1$
    - $1 - 0 = 1$
    - $1 - 1 = 0$

    #align(center)[#table(
        columns: 7,
        stroke: none,
        align: (auto, auto, auto, auto, auto, auto, auto),
        [],
        [#text("1", blue)],
        [#text("0", blue)],
        [#text("0", blue)],
        [#text("0", blue)],
        [#text("0", blue)],
        [Borrow],

        [],
        [1],
        [#math.attach("0", tl: "1")],
        [1#sub[2]],
        [=],
        [5#sub[10]],
        [Minuend],

        [-], [], [1], [1#sub[2]], [=], [3#sub[10]], [Subtrahend],
        table.hline(),

        [], [0], [1], [0#sub[2]], [=], [2#sub[10]], [],
    )]

- Example:
    - Minuend:
        $ 11110000 $

    - Subtrahend:
        $ 11001100 $

    - Result:

        #align(center)[#table(
            columns: 11,
            stroke: none,
            align: (
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
            ),
            [], [0], [0], [0], [0], [1], [1], [0], [0], [0], [Borrow],
            [], [], [1], [1], [1], [1], [0], [0], [0], [0], [Minuend],
            [-], [], [1], [1], [0], [0], [1], [1], [0], [0], [Subtrahend],

            table.hline(),
            [], [#text("0", red)], [0], [0], [1], [0], [0], [1], [0], [0], [],
        )]

#pagebreak()

== Decimal number system
- A decimal number consists of a series of digits.
- A digit has its value and its position in the series.
- One digit on the left is 10 times the digit on the right.
- For example, $1234000$.
- Hence, we can represent decimal numbers in the following way:
    $ V = D_(n - 1) D_(n - 2) dots.h.c D_1 D_0 $
- Where:
    $
        D_i in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
        quad i = 0, 1, 2, dots.h "or" i = - 1, - 2, dots.h
    $
    $
        V_n = D_(n - 1) 10^(n - 1) + D_(n - 2) 10^(n - 2) +
        dots.h.c + D_1 10^1 D_0 10^0
    $

=== Integer example
#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Decimal numbers], [Corresponding decimal values]),
    [$00002234$], [$2000 + 200 + 30 + 4$],
    [$67890000$], [$60000000 + 7000000 + 800000 + 90000$],
    [$34008900$], [$30000000 + 400000 + 8000 + 900$],
    [$00890034$], [$800000 + 90000 + 30 + 4$],
)]

=== Fractional example
#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Decimal numbers], [Corresponding decimal values]),
    [$0.00002234$], [$0.00002 + 0.000002 + 0.0000003 + 0.00000004$],
    [$0.67890000$], [$0.6 + 0.07 + 0.008 + 0.0009$],
    [$0.34008900$], [$0.3 + 0.04 + 0.00008 + 0.000009$],
    [$0.00890034$], [$0.008 + 0.009 + 0.0000003 + 0.00000004$],
)]

#pagebreak()

=== Decimal addition
- Input:
    $
        V_1 = A_(n - 1) 10^(n - 1) + A_(n - 2) 10^(n - 2) +
        dots.h.c + A_1 10^1 + A_0 + 10^0
    $
    $
        V_2 = B_(n - 1) 10^(n - 1) + B_(n - 2) 10^(n - 2) +
        dots.h.c + B_1 10^1 + B_0 + 10^0
    $
- Output:
    $
        V_3 = C_(n - 1) 10^(n - 1) + C_(n - 2) 10^(n - 2) +
        dots.h.c + C_1 10^1 + C_0 + 10^0
    $
- Rules:
    - If $A i + B i > 9, C i = A i + B i - 10$, with a carry of $1$.
    - Otherwise, $C i = A i + B i$.

    #align(center)[#table(
        columns: 5,
        stroke: none,
        align: (auto, auto, auto, auto, auto),
        [], [#text("1", blue)], [#text("1", blue)], [#text("0", blue)], [Carry],

        [], [], [9], [5], [Augend],
        [+], [], [1], [6], [Addend],
        table.hline(),

        [], [1], [1], [1], [],
    )]

- Example:
    - Augend:
        $ 67890000 $

    - Addend:
        $ 34008900 $

    - Result:

        #align(center)[#table(
            columns: 11,
            stroke: none,
            align: (
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
            ),
            [], [1], [1], [0], [0], [0], [0], [0], [0], [0], [Carry],
            [], [], [6], [7], [8], [9], [0], [0], [0], [0], [Augend],
            [+], [], [3], [4], [0], [0], [8], [9], [0], [0], [Addend],
            table.hline(),

            [], [#text("1", red)], [0], [1], [8], [9], [8], [9], [0], [0], [],
        )]

#pagebreak()

=== Decimal subtraction
- Input:
    $
        V_1 = A_(n - 1) 10^(n - 1) + A_(n - 2) 10^(n - 2) +
        dots.h.c + A_1 10^1 + A_0 + 10^0
    $
    $
        V_2 = B_(n - 1) 10^(n - 1) + B_(n - 2) 10^(n - 2) +
        dots.h.c + B_1 10^1 + B_0 + 10^0
    $
- Output:
    $
        V_3 = C_(n - 1) 10^(n - 1) + C_(n - 2) 10^(n - 2) +
        dots.h.c + C_1 10^1 + C_0 + 10^0
    $
- Rules:
    - If $A i < B i, C i = 10 + A i - B i - 10$, with a borrow of $1$.
    - Otherwise, $C i = A i - B i$.

    #align(center)[#table(
        columns: 4,
        stroke: none,
        align: (auto, auto, auto, auto),
        [], [#text("1", blue)], [#text("0", blue)], [Borrow],
        [], [9], [#math.attach("5", tl: "1", b: "10")], [Minuend],
        [-], [1], [6#sub[10]], [Subtrahend],
        table.hline(),

        [], [7], [9#sub[10]], [],
    )]

- Example:
    - Minuend:
        $ 67890000 $

    - Subtrahend:
        $ 34008900 $

    - Result:

        #align(center)[#table(
            columns: 11,
            stroke: none,
            align: (
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
            ),
            [], [0], [0], [0], [0], [1], [1], [0], [0], [0], [Borrow],
            [], [], [6], [7], [8], [9], [0], [0], [0], [0], [Minuend],
            [-], [], [3], [4], [0], [0], [8], [9], [0], [0], [Subtrahend],
            table.hline(),

            [0], [0], [3], [3], [8], [8], [1], [1], [0], [0], [],
        )]

#pagebreak()

=== Hexadecimal number system
- A hexadecimal number consists of a series of digits.
- A digit has its value and its position in the series.
- One digit on the left is 16 times the digit on the right.
- For example, $upright("ABCD5678")$.
- Hence, we can represent hexadecimal numbers in the following way:
    $ V = D_(n - 1) D_(n - 2) dots.h.c D_1 D_0 $
- Where:
    $
        D_i in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F],
        quad i = 0, 1, 2, dots.h "or" i = - 1, - 2, dots.h
    $
    $
        V = D_(n - 1) 16^(n - 1) + D_(n - 2) 16^(n - 2) +
        dots.h.c + D_1 16^1 + D_0 16^0
    $

=== Integer example
#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Hexadecimal numbers], [Corresponding decimal values]),
    [$00005688$], [$20480 + 1536 + 128 + 8$],
    [$A B C D 0000$], [$2684400000 + 184549376 + 12582912 + 851968$],
    [$C D 007800$], [$3221200000 + 218103808 + 28672 + 2048$],
    [$007800 C D$], [$7340032 + 524288 + 192 + 13$],
)]

=== Fractional example
#align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Hexadecimal numbers], [Corresponding decimal values]),
    [$0.00005688$],
    [$0.0000047684 + 0.00000035763 + 0.000000029802 + 0.0000000018626$],

    [$0 . A B C D 0000$], [$0.625 + 0.043 + 0.0029 + 0.00019836$],
    [$0 . C D 007800$], [$0.75 + 0.0508 + 0.0000066757 + 0.00000047684$],
    [$0.007800 C D$],
    [$0.0017 + 0.00012207 + 0.000000044703 + 0.0000000030268$],
)]

#pagebreak()

=== Hexadecimal addition
- Input:
    $
        V_1 = A_(n - 1) 16^(n - 1) + A_(n - 2) 16^(n - 2) +
        dots.h.c + A_1 16^1 + A_0 + 16^0
    $
    $
        V_2 = B_(n - 1) 16^(n - 1) + B_(n - 2) 16^(n - 2) +
        dots.h.c + B_1 16^1 + B_0 + 16^0
    $
- Output:
    $
        V_3 = C_(n - 1) 16^(n - 1) + C_(n - 2) 16^(n - 2) +
        dots.h.c + C_1 16^1 + C_0 + 16^0
    $
- Rules:
    - If $A i + B i > F, C i = A i + B i - 16$, with a carry of 1
    - Otherwise, $C i = A i + B i$

    #align(center)[#table(
        columns: 7,
        stroke: none,
        align: (auto, auto, auto, auto, auto, auto, auto),
        [],
        [#text("1", blue)],
        [#text("0", blue)],
        [#text("1", blue)],
        [#text("1", blue)],
        [#text("0", blue)],
        [Carry],

        [], [], [F], [0], [B], [A], [Augend],
        [+], [], [E], [9], [A], [D], [Addend],
        table.hline(),

        [], [1], [D], [A], [6], [7], [Sum],
    )]

- Example:
    - Augend:
        #align(center, text("ABCD0000"))

    - Addend:
        #align(center, text("007800CD"))

    - Result:

        #align(center)[#table(
            columns: 11,
            stroke: none,
            align: (
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
            ),
            [], [0], [0], [1], [1], [0], [0], [0], [0], [0], [Carry],
            [], [], [A], [B], [C], [D], [0], [0], [0], [0], [Augend],
            [+], [], [0], [0], [7], [8], [0], [0], [C], [D], [Addend],
            table.hline(),

            [], [#text("0", red)], [A], [C], [4], [5], [0], [0], [C], [D], [],
        )]

#pagebreak()

=== Hexadecimal subtraction
- Input:
    $
        V_1 = A_(n - 1) 16^(n - 1) + A_(n - 2) 16^(n - 2) +
        dots.h.c + A_1 16^1 + A_0 + 16^0
    $
    $
        V_2 = B_(n - 1) 16^(n - 1) + B_(n - 2) 16^(n - 2) +
        dots.h.c + B_1 16^1 + B_0 + 16^0
    $
- Output:
    $
        V_3 = C_(n - 1) 16^(n - 1) + C_(n - 2) 16^(n - 2) +
        dots.h.c + C_1 16^1 + C_0 + 16^0
    $
- Rules:
    - If $A i < B i, C i = 16 + A i - B i$, with a borrow of 1
    - Otherwise, $C i = A i - B i$

    #align(center)[#table(
        columns: 7,
        stroke: none,
        align: (auto, auto, auto, auto, auto, auto, auto),
        [],
        [#text("0", blue)],
        [#text("0", blue)],
        [#text("1", blue)],
        [#text("1", blue)],
        [#text("1", blue)],
        [Borrow],

        [], [], [D], [E], [A], [9], [Minuend],
        [-], [], [4], [F], [B], [D], [Subtrahend],
        table.hline(),

        [], [0], [8], [E], [E], [C], [],
    )]

- Example:
    - Minuend:
        #align(center, text("67890000"))

    - Subtrahend:
        #align(center, text("34008900"))

    - Result:

        #align(center)[#table(
            columns: 11,
            stroke: none,
            align: (
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
                auto,
            ),
            [], [0], [0], [0], [0], [1], [1], [0], [0], [0], [Borrow],
            [], [], [6], [7], [8], [9], [0], [0], [0], [0], [Minuend],
            [-], [], [3], [4], [0], [0], [8], [9], [0], [0], [Subtrahend],
            table.hline(),

            [], [#text("0", red)], [3], [3], [8], [8], [7], [7], [0], [0], [],
        )]

#pagebreak()

=== Hexadecimal ASCII table
For example, 0x42 refers to the character "B".
#cimage("./images/hex-ascii-table.png")

== Conversion look-up table
#align(center)[#table(
    columns: 3,
    align: (auto, auto, auto),
    table.header([Hex], [Binary], [Decimal]),
    [0], [0000], [0],
    [1], [0001], [1],
    [2], [0010], [2],
    [3], [0011], [3],
    [4], [0100], [4],
    [5], [0101], [5],
    [6], [0110], [6],
    [7], [0111], [7],
    [8], [1000], [8],
    [9], [1001], [9],
    [A], [1001], [10],
    [B], [1011], [11],
    [C], [1100], [12],
    [D], [1101], [13],
    [E], [1110], [14],
    [F], [1111], [15],
)]

#pagebreak()

=== Conversion from binary to hexadecimal
- Rules:
    + 1 digit of hexadecimal corresponds to 4 digits of binary.
    + Group every 4 digits of binary together and replace it with the
        corresponding digit of hexadecimal.
- Example:
    - Binary input:
        $
            underbrace(1111, F) underbrace(1110, E)
            underbrace(1100, C) underbrace(1000, 8)
        $
    - Hexadecimal output:
        - $F = 1111$
        - $E = 1110$
        - $C = 1100$
        - $8 = 1000$
        - Hexadecimal = 0xFEC8

=== Conversion from hexadecimal to binary
- Rules:
    + 1 digit of hexadecimal corresponds to 4 digits of binary.
    + Expand every digit of hexadecimal into a series of 4 digits of binary and
        replace it with corresponding 4 digits of binary.
- Example:
    - Hexadecimal input:
        $
            "0x" quad underbrace(F, 1111) quad underbrace(E, 1110)
            quad underbrace(8, 1000) quad underbrace(9, 1001)
            quad underbrace(A, 1010) quad underbrace(B, 1011)
            quad underbrace(5, 0101) quad underbrace(6, 0110)
        $
    - Binary output:
        - $F = 1111 quad E = 1110 quad 8 = 1000 quad 9 = 1001$
        - $A = 1010 quad B = 1011 quad 5 = 0101 quad 6 = 0110$
        - Binary = 1111 1110 1000 1001 1010 1011 0101 0110

#pagebreak()

=== Conversion from decimal to binary, integer part
- Decimal input:
    $
        V_"decimal" = D_(n - 1) 10^(n - 1) + D_(n - 2) 10^(n - 2) +
        dots.h.c + D_1 10^1 + D_0 10^0
    $
- Binary output:
    $
        V_"binary" = B_(n - 1) 2^(n - 1) + B_(n - 2) 2^(n - 2) +
        dots.h.c + B_1 2^1 + B_0 2^0
    $
- Process:
    - Divide the input by 2. The remainder is the first digit of the binary
        output.
    - Divide the quotient by 2. The remainder is the second digit of the binary
        output.
    - Continue the process until the *quotient becomes zero*.
- Example:
    - Input: 57 in decimal
        + $57 / 2 = 28, "Remainder" = 1 quad ("Binary number will end with 1")$
        + $28 / 2 = 14, "Remainder" = 0$
        + $14 / 2 = 7, "Remainder" = 0$
        + $7 / 2 = 3, "Remainder" = 1$
        + $3 / 2 = 1, "Remainder" = 1$
        + $1 / 2 = 0, "Remainder" = 1 quad ("Binary number will start with 1")$
    - Output: 111001 in binary

=== Conversion from decimal to binary, fractional part
- Process:
    - Multiply the input by 2. The decimal number before the decimal point is
        the first digit of the binary output after the decimal point.
    - Multiply the fractional part from the previous result by 2. The decimal
        number before the decimal point is the second digit of the binary output
        after the decimal point.
    - Continue the process until the quotient becomes *zero* or a *periodic
        number*, which means the number in binary keeps repeating.
    - Read the number starting from the *top*, the first result is the first
        digit after the decimal point.
- Example:
    - Input: 0.375 in decimal
        + $0.375 times 2 = mathred(0).75,
            "Fractional part" = 0.75 "with carry" = 0$
        + $0.75 times 2 = mathred(1).50,
            "Fractional part" = 0.50 "with carry" = 1$
        + $0.50 times 2 = mathred(1).00,
            "Fractional part" = 0.00 "with carry" = 1$
    - Output: 0.011 in binary
- Faster method:
    - Multiply the fractional part by 2 to the power of the number of decimal
        places required, i.e.
        $ "Fractional part" times 2^n $

        Where $n$ is the number of decimal places required.
    - Round the result to the nearest whole number and convert the result to
        binary.
- Example:
    - Input: 0.375 in decimal, which has 3 decimal places, so $n = 3$:
        + $0.375 times 2^3 = 3$
        + $3_10 = 011_2$
    - Output: 0.011 in binary

#pagebreak()

=== Example of converting a decimal number with decimals to binary
Input: 43.167 in decimal.

- For the integer part:
    + $43 / 2 = 21, "Remainder" = 1$
    + $21 / 2 = 10, "Remainder" = 1$
    + $10 / 2 = 5, "Remainder" = 0$
    + $5 / 2 = 2, "Remainder" = 1$
    + $2 / 2 = 1, "Remainder" = 0$
    + $1 / 2 = 0, "Remainder" = 1$
- For the fractional part:
    + $0.167 times 2 = mathred(0).334$
    + $0.334 times 2 = mathred(0).668$
    + $0.668 times 2 = mathred(1).336$
    + $0.336 times 2 = mathred(0).672$
    + $0.672 times 2 = mathred(1).344$

Output: 101011.00101 in binary.

=== Conversion from decimal to hexadecimal, integer part
- Decimal input:
    $
        V_"decimal" = D_(n - 1) 10^(n - 1) + D_(n - 2) 10^(n - 2) +
        dots.h.c + D_1 10^1 + D_0 10^0
    $
- Hexadecimal output:
    $
        V_"hexadecimal" = H_(n - 1) 16^(n - 1) + H_(n - 2) 16^(n - 2) +
        dots.h.c + H_1 16^1 + H_0 16^0
    $
- Process:
    - Divide the input by 16. The remainder is the first digit of the hex
        output.
    - Divide the quotient by 16. The remainder is the second digit of the hex
        output.
    - Continue the process until the quotient becomes zero.
- Example:
    - Input: 35243 in decimal
        + $35243 / 16 = 2202, "Remainder" = 11
            -> "B" quad ("hex number will end with B")$
        + $2202 / 16 = 137, "Remainder" = 10 -> "A"$
        + $137 / 16 = 8, "Remainder" = 9$
        + $8 / 16 = 0, "Remainder" = 8 quad ("hex number will start with 8")$

        Therefore, collecting the remainders, $35243_10 = "89AB"_16$. To check:
        $
            (8 times 16^3) + (9 times 16^2)
            + (10 times 16^1) + (11 times 16^0) = 35243_10
        $
    - Output: 89AB in hexadecimal

#pagebreak()

=== Conversion from decimal to hexadecimal, fractional part
- Process:
    - Multiply the input by 16. The decimal number before the decimal point is
        the first digit of the binary output after the decimal point.
    - Multiply the fractional part from the previous result by 16. The decimal
        number before the decimal point is the second digit of the binary output
        after the decimal point.
    - Continue the process until the quotient becomes zero or a periodic number
    - Read the number starting from the top, the first result is the first digit
        after the decimal point.
- Example 1:
    - Input: 0.375 in decimal
        + $0.375 times 16 = mathred(6).0$
    - Output: 0.6 in hexadecimal
- Example 2:
    - Input: 0.987 in decimal
        + $0.987 times 16 = mathred(15).792 -> "F"$
        + $0.792 times 16 = mathred(12).672 -> "C"$
        + $0.672 times 16 = mathred(10).752 -> "A"$
        + $0.752 times 16 = mathred(12).032 -> "C"$
    - Output: 0.FCAC in hexadecimal

== Representation of integers

=== Binary-coded decimal of integers
- Rules:
    - Each digit of decimal is represented by four digits of binary.
    - $0 = 0000, quad 1 = 0001, quad 2 = 0010, quad 3 = 0011, quad 4 = 0100$
    - $5 = 0101, quad 6 = 0110, quad 7 = 0111, quad 8 = 1000, quad 9 = 1001$
- Examples:
    - Decimal(9879) = Binary(1001 1000 0111 1001)
    - Decimal(12345) = Binary(0001 0010 0011 0100 0101)

=== Signed magnitude format of integers
- Rules:
    - Allocate the most-significant bit (MSB) to represent the signs.
    - Allocate the remaining bits to represent the values.
- Examples:
    - Binary with 4 bits:
        - Max = 0 111 #sym.arrow.r 7
        - Min = 1 111 #sym.arrow.r -7
    - Binary with 8 bits:
        - Max = 0 111 1111 #sym.arrow.r 127
        - Min = 1 111 1111 #sym.arrow.r -127
    - Binary with 16 bits:
        - Max = 0 111 1111 1111 1111 #sym.arrow.r 32767
        - Min = 1 111 1111 1111 1111 #sym.arrow.r -32767
    - Binary with 32 bits:
        - Max = 0 111 1111 1111 1111 1111 1111 1111 1111 #sym.arrow.r
            2,147,483,647
        - Min = 1 111 1111 1111 1111 1111 1111 1111 1111 #sym.arrow.r
            -2,147,483,647

=== Two's complement format of integers
- Rules:

    - For a binary number of $N$ bits, the positive numbers are represented by
        the bits from 0 (LSB) to $N - 2$ and bit $N - 1$ (MSB) is zero.
    - For a binary number of $N$ bits, the negative numbers are represented by
        the two's complements of their positive numbers.
    - A two's complement is equal to bit-wise complement plus 1.

- Examples:

    - 4 bit binary of integer 6 = 0110
    - 4 bit binary of integer -6 = 1001 + 1 = 1010
    - 8 bit binary of integer 102 = 0110 0110
    - 8 bit binary of integer -102 = 1001 1001 + 1 = 1001 1010

- Diagram:

    #cimage("./images/twos-complement-diagram.png", height: 15em)

    - 8 positive numbers
    - 8 negative numbers
    - +8 = 1000
    - -8 = 0111 + 1 = 1000
    - +8 = -8
    - So, we ignore +8

=== Reasons to use two's complement format
Addition:

- Addition not dependent on the signs of operand.
- No need to compare magnitudes to determine sign of result.

Subtraction:

- Subtraction is treated as an addition.
- Add the negative of the subtrahend to the minuend.

Simple implementation:

- Adder unit.
- Negation circuit unit.

The simpler addition and subtraction scheme makes two's complement the most
common choice for integer number systems within digital systems.

== Representation of floating point numbers

=== Binary-coded decimal of floating-point numbers
- Rules:
    - Each digit of decimal is represented by 4 digits of binary.
    - $0 = 0000, quad 1 = 0001, quad 2 = 0010, quad 3 = 0011, quad 4 = 0100$
    - $5 = 0101, quad 6 = 0110, quad 7 = 0111, quad 8 = 1000, quad 9 = 1001$
- Examples:
    - Decimal(9879.34) = Binary(1001 1000 0111 1001).Binary(0011 0100)
    - Decimal(12345.5) = Binary(0001 0010 0011 0100 0101).Binary(0101)

=== Exponent-mantissa format of floating point numbers
Using the 32-bit ANSI/IEEE 754 standard format.

#align(center)[#table(
    columns: 3,
    align: (auto, auto, auto),
    [Sign bit (S)], [Exponent (E)], [Mantissa (M) or Fraction],
    [(1 bit)], [(8 bits)], [(23 bits)],
)]

- Sign bit (S)
    - 0 denotes positive number, 1 denotes negative number.
- Exponent (E)
    - Represents both positive and negative exponents.
    - A bias value of $127_10$ must be added to all exponents, regardless of
        sign.
- Mantissa or Fraction (M)
    - Represents the leading significant bits in the number.
    - It is stored in the normalised form.

#pagebreak()

=== Conversion of decimals to exponent-mantissa format
- Procedure:
    - Convert decimals to binary format.
    - Normalise binary format.
    - Determine exponent.
    - Determine mantissa.
- Example of 2.75 in decimal:
    + $2.75_10 = 10.11_2$
    + In normalised form: $1.011_2 times 2^1$
    + Express in 23-bit mantissa without leading $1_2$:
        $ M = "011 0000 0000 0000 0000 0000" $
    + Express 8-bit exponent (E) with added bias:
        $ E = 1_10 + 127_10 = 128_10 = "1000 0000"_2 $
    + Express sign bit (S):
        $ S = 0 quad ("positive number") $
- Example of -0.0625 in decimal:
    + $- 0.0625_10 = - 0.0001_2$
    + In normalised form: $1.0_2 times 2^(- 4)$
    + Express in 23-bit mantissa without leading $1_2$:
        $ M = "000 0000 0000 0000 0000 0000" $
    + Express 8-bit exponent (E) with added bias:
        $ E = - 4_10 + 127_10 = 123_10 = "0111 1011"_2 $
    + Express sign bit (S):
        $ S = 1 quad ("negative number") $

- Example of -417680 in decimal:
    + $- 417680_10 = - "110 0101 1111 1001 0000"_2$
    + In normalised form: $1.100101111110010000_2 times 2^18$
    + Express in 23-bit mantissa without leading $1_2$:
        $ M = "100 1011 1111 0010 0000 0000" $
    + Express 8-bit exponent (E) with added bias:
        $ E = 18_10 + 127_10 = 145_10 = "1010 0001"_2 $
    + Express sign bit (S):
        $ S = 1 quad ("negative number") $

#pagebreak()

=== Zero and infinity in exponent-mantissa format
- Representing $+ \/ - 0.0$ in 32-bit ANSI/IEEE 754 standard format

    #align(center)[#table(
        columns: 3,
        align: (auto, auto, auto, auto),
        [Sign bit (S)], [Exponent (E)], [Mantissa (M) or Fraction],
        [0/1], [0000 0000], [000 0000 0000 0000 0000],
    )]

- Representing $+ \/ - oo$ in 32-bit ANSI/IEEE 754 standard format

    #align(center)[#table(
        columns: 3,
        align: (auto, auto, auto, auto),
        [Sign bit (S)], [Exponent (E)], [Mantissa (M) or Fraction],
        [0/1], [1111 1111], [000 0000 0000 0000 0000],
    )]

= Nature of programming

== Programming versus writing
Programming (using Arm Keil):
- You have a solution in mind.
- You organise your solution.
- You compose your program.
- You test your program.
- You deploy your program.

Writing (using LaTeX or Microsoft Word):
- You have a story in mind.
- You organise your story.
- You compose your texts.
- You proof-read your texts.
- You publish your texts.

#pagebreak()

== How to organise your solution?
1. Plan arithmetic or logical computations underlying your solution.
2. Allocate memory resources which are indispensable for the implementation of
    the planned computations.

=== Example of ($x = (a + b) - c$)
Allocation of memory for the program:
```asm
        EXPORT  Start
        AREA    progA, CODE, READONLY

var_a   DCD     5    ; a = 5
var_b   DCD     6    ; b = 6
var_c   DCD     7    ; c = 7
var_x   DCD     0    ; Initialise x to 0
```

Planning of actual computation:
```asm
Start   ADR R4, var_a   ; Get the memory address of var_a
        LDR R0, [R4]    ; Get the value of var_a
        ADR R4, var_b   ; Get the memory address of var_b, reusing R4
        LDR R1, [R4]    ; Get the value of var_b
        ADD R3, R0, R1  ; Compute var_a + var_b
        ADR R4, var_c   ; Get the memory address of var_c
        LDR R2, [R4]   ; Get the value of var_c
        SUB R3, R3, R2  ; Complete the computation of x = (a + b) - c
        ADR R4, var_x   ; Get the memory address of var_x
        STR R3, [R4]    ; Store the value of x
stop    B   stop
            END
```

#pagebreak()

== Procedure of planning computations
+ Describe your solution in the form of mathematics or logic.
+ Transform your solution into algorithms which consist of a series of
    arithmetic and logical computations.
+ Draw flowcharts which connect arithmetic and logical computations in terms of
    their inputs and outputs.
+ Describe flow charts with the use of a programming language.

=== Example of transforming a solution into an algorithm
Solution:
$ a x^2 + b x + c = 0 $
$ x = frac(-b + sqrt(b^2 - 4 a c), 2a) $
$ x = frac(-b - sqrt(b^2 - 4 a c), 2a) $

Algorithm:
+ First do:
    $ y = b^2 - 4 a c $
+ Then do:
    $ z = sqrt(y) $
+ Then do:
    $ x_1 = frac(-b + z, 2a) $
    $ x_2 = frac(-b - z, 2a) $

=== Example of flowchart corresponding to algorithm
#cimage("./images/corresponding-flowchart-to-algorithm-example.png")

= Allocation of memory

== Why allocate memory?
- Hardware can support multiple applications running concurrently.
- The ALU is being shared among these applications, which means the application
    has full access to the ALU during the time when the ALU is allocated to it.
- However, memory units are generally not shared.
- Hence, each application must take care of memory allocation explicitly.

== Memory allocation scenarios
+ Allocation of memory for housing a program itself.
+ Allocation of memory for housing constants, parameters and variables of a
    program.

#cimage("./images/memory-allocation-scenarios.png", height: 15em)

- The allocation of memory for the program itself is store in the code section
    of ARM memory.
- The allocation of memory for the variables and constants used by a program is
    stored in the static RAM or SRAM.
- On-chip code, data, and I/O are located in the first 1.5 GiB of memory space.
- Each is allocated 0.5 GiB.
- May use physically separate buses for each space.

#pagebreak()

== Memory allocation example
```asm
                EXPORT      Start
                AREA        progB, CODE, READONLY
        var_a   DCD 1       ; a = 1
        var_b   DCD 15      ; b = 15
        var_z   DCD 0       ; Initialise z to 0

Start                       ; z = (a << 2) | (b & 15)

        ADR R4, var_a       ; Get the memory address of var_a
        LDR R0, [R4]        ; Get the value of var_a
        MOV R0, R0, LSL #2  ; Bitwise shift var_a left by 2: R0 = a << 2
        ADR R4, var_b       ; Get the memory address of var_b
        LDR R1, [R4]        ; Get the value of var_b

        ; Perform bitwise AND on var_b and 152: r_1 = (b & 152)
        AND R1, R1, #15

        ; Perform bitwise OR on R0 and R1: R1 = (a << 2) | (b & 152)
        ORR R1, R0, R1
        ADR R4, var_z       ; Get the memory address of var_z

        ; Store the value of R1 in the memory address of var_z
        STR R1, var_z

stop    B   stop
        END
```

= ARM programming tools

== Overview
- The compiler converts from C files (`.c`) to assembler files (`.s`).
- The assembler converts from assembler files (`.s`) to object files (`.o`).
- The linker converts from object files (`.o`) to executable files (`.exe`).
- The linker can link object files (`.o`) with archive files (`.a`)

#pagebreak()

== Assembler directives for memory destination (GCC and ArmClang)
#align(center)[
    #let value_args = [_value#sub[1]_\[, ..., _value#sub[n]_\]]
    #let expression_args = [{_expr#sub[1]_|_"string#sub[1]"_}[, ...,
        {_expr#sub[n]_|_"string#sub[n]"_}]]
    #table(
        align: left,
        columns: 2,
        table.header([*Mnemonic and syntax*], [*Description*]),

        [*`.bss`* _symbol_, \ _size in bytes_[, _alignment_ [, _bank offset_]]],
        [Reserves _size_ in bytes in the `.bss` (uninitialised data) section.],

        [*`.data`*], [Assembles into the `.data` (initialised data) section.],
        [*`.sect`* "_section name_"],
        [Assmebles into a named (initialised) section],

        [*`.text`*], [Assembles into a `.text` (executable code) section.],

        [_symbol_ *`.usect`* "_section name_", \ _size in bytes_[, _alignment_[,
            _bank offset_]]],
        [Reserves _size_ in bytes in a named (uninitialised) section.],

        [*`.space`*], [Reserves a block of bytes.],

        [*`.cstring`* #expression_args],
        [Initialises one or more text strings.],

        [*`.double`* #value_args],
        [Initialises one or more 64-bit, IEEE double-precision floating-point
            numbers.],

        [*`.field`* _value_[, _size_]],
        [Initialises a field of _size_ bits (1-32) with _value_.],

        [*`.float`* #value_args],
        [Initialises one or more 32-bit, IEEE, single-precision floating-point
            numbers.],

        [*`.half`* #value_args],
        [Initialises one or more 16-bit integers (half-word).],

        [*`.int`* #value_args], [Initialises one or more 32-bit integers.],
        [*`.long`* #value_args], [Initialises one or more 32-bit integers.],

        [*`.short`* #value_args],
        [Initialises one or more 16-bit integers (half-word).],

        [*`.string`* #expression_args], [Initialises one or more text strings.],

        [*`.ubyte`* #value_args],
        [Initialises one or more successive unsigned bytes in the current
            section.],

        [*`.uchar`* #value_args],
        [Initialises one or more successive unsigned bytes in the current
            section, but it is mainly use for ASCII characters.],

        [*`.uhalf`* #value_args],
        [Initialises one or more unsigned 16-bit integers (half-word).],

        [*`.uint`* #value_args],
        [Initialises one or more unsigned 32-bit integers.],

        [*`.ulong`* #value_args],
        [Initialises one or more unsigned 32-bit integers.],

        [*`.ushort`* #value_args],
        [Initialises one or more unsigned 16-bit integers (half-word).],

        [*`.uword`* #value_args],
        [Initialises one or more unsigned 32-bit integers.],

        [*`.word`* #value_args], [Initialises one or more 32-bit integers.],
    )]

The SRAM can only hold data, while the code section can hold both instructions
and data.

#pagebreak()

=== Example 1
In this example, code is assembled into the `.data` and `.text` sections.
#cimage("./images/assembler-directives-example-1.png")

=== Example 2
This example uses the `.int` directive to initialise words.
#cimage("./images/assembler-directives-example-2.png")
#pagebreak()

=== Example 3
- This example shows how the `.long` directive initialises words.
- The symbol `DAT1` points to the first word that is reserved.
#cimage("./images/assembler-directives-example-3.png")

=== Example 4
- In this example, the `.word` directive is used to initialise words.
- The symbol `WORDX` points to the first word that is reserved.
#cimage("./images/assembler-directives-example-4.png")

#heading(level: 2, [Assembler directives for controlling conditional
    computations (GCC and ArmClang)])

#align(center)[#table(
    align: left,
    columns: 2,
    table.header([*Mnemonic and syntax*], [*Description*]),

    [*`.if`* _condition_], [Assembles code block if the _condition_ is true.],

    [*`.else`*],
    [Assembles code block if the `.if` _condition_ is false. When using the
        `.if` construct, the `.else` construct is optional.],

    [*`.elseif`* _condition_],
    [Assembles code block if the `.if` _condition_ is false and the `.elseif`
        _condition_ is true. When using the `.if` construct, the `.elseif`
        construct is optional.],

    [*`.endif`*], [Ends `.if` code block.],

    [*`.loop`* [_count_]],
    [Begins repeatable assembly of a code block. The loop count is determined by
        the _count_.],

    [*`.break`* [_end condition_]],
    [Ends `.loop` assembly if _end condition_ is true. When using the `.loop`
        construct, the `.break` construct is optional.],

    [*`.endloop`*], [Ends `.loop` code block.],
)]

#pagebreak()

=== Example
The example below shows conditional assembly:
#cimage("./images/conditional-assembly-example.png")
#pagebreak()

== Directive for creating reusable block of codes (GCC and ArmClang)
A macro definition is a series of source statements in the following format:
```asm
macro_name  .macro  [parameter_1][, ..., parameter_n]
            model_statements_or_macro_directives
            [.mexit]
            .endm
```

- `macro_name` is the name of the macro. You must place the name in the source
    statement's label field. Only the first 128 characters of a macro name are
    significant. The assembler places the macro name in the internal opcode
    table, replacing any instruction or previous macro definition with the same
    name.
- *`.macro`* is the directive that identifies the source statement as the first
    line of a macro definition. You must place `.macro` in the opcode field.
- `parameter_1, parameter_n` are optional substitution symbols that appear as
    operands for the `.macro` directive.
- `.mexit` is a directive that functions as a `goto .endm`. The `.mexit`
    directive is useful when error testing confirms that macro expansion fails
    and completing the rest of the macro is unnecessary.
- `.endm` is the directive that terminates the macro definition.

=== Example
Macro definition: The following code defines a macro, `add3`, with 4 parameters:
```asm
*       add3
*
*       ADDRP = P1 + P2 + P3

add3    .macro P1, P2, P3, ADDRP
        ADD ADDRP, P1, P2
        ADD ADDRP, ADDRP, P3
        .endm
```

Macro call: The following code calls the `add3` macro with 4 arguments.
```asm
        add3 R1, R2, R3, R0
```

Macro expansion: The following code shows the substitution of the macro
definition for the macro call. The assembler substitutes `R1, R2, R3,` and `R0`
for the `P1, P2, P3,` and `ADDRP` parameters of `add3`.
```asm
        ADD R0, R1, R2
        ADD R0, R0, R3
```

#pagebreak()

= Memory-mapped I/O devices

== Data flow
- Data consists of values, symbols, addresses and instructions.
- Data flows from source memory to destination memory.
- Memory is a space which has:
    - Location
    - Address
    - Label

== Basic unit of input/output data
- A port has 8 pins.
- Hence, the basic unit of input/output data is one byte, or 8-bits.
- However, inside ARM Cortex, the data bus transfers 4-bytes or 32-bits per
    cycle.

== Memory allocation
- Think of memory as a vector, like `memory[address]`.
- To store *variable* values, assign a memory label to a variable value, which
    indicates:
    - A fixed memory address, which is *useful* to users.
    - Multiple instances of a value, which is *needed* by users.
    - Example:
        ```asm
        TravelledDistance   DCD 0
        ```
- To store *fixed* values, assign a memory label to a fixed value, which
    indicates:
    - Multiple memory addresses, which is *not useful* to users.
    - Single instance of value, which is *needed* by users.
    - Example:
        ```asm
        GravityAcceleration EQU 9.8
        ```

#pagebreak()

== Example of internal data input from port F
Address of port F's data is `R4 = 0x40025FFF`.
#cimage("./images/data-input-to-port-f-example.png")

Types of logic switches:
#cimage("./images/types-of-switches.png")

#pagebreak()

Sample code:
```asm
loop            BL  SSR_On  ; Call the function to switch on the LED

waitforpress1
                ; Read the status of the port PF4
                LDR R0, [R4]

                ; Check if the button is pressed
                CMP R0, #0x10

                ; Continue the loop if the button is not pressed
                BEQ waitforpress1

waitforrelease1
                ; Read the status of the port PF4
                LDR R0, [R4]

                ; Check if the button is released
                CMP R0, #0x10

                ; Continue the loop if the button is not released
                BNE waitforrelease1

                ; Call the function to switch off the LED
                BL SSR_Off

; Function to switch on LED
waitforpress2
                ; Read the status of the port PF4
                LDR R0, [R4]

                ; Check if the button is pressed
                CMP R0, #0x01

                ; Continue the loop if the button is not pressed
                BEQ waitforpress2

waitforrelease1
                ; Read the status of the port PF4
                LDR R0, [R4]

                ; Check if the button is released
                CMP R0, #0x01

                ; Continue the loop if the button is not released
                BNE waitforrelease2

                ; Go back to the start to run an infinite loop
                B loop
```

#pagebreak()

== TM4C123G GPIO module
- Each GPIO port is a separate hardware instantiation of the same physical
    block.
- The TM4C123G allows for one interrupt per port.
#cimage("./images/tm4c123gh6pm-gpio-module.png")

#pagebreak()

== TM4C123G ADC module
Note that some pins can receive analogue values.
#cimage("./images/tm4c123gh6pm-adc-module.png")

== TM4C123G PWM module
TM4C123G has two PWM modules, and 4 PWM generators per module.
#cimage("./images/tm4c123gh6pm-pwm-module.png")
#pagebreak()

== Data organisation nomenclature
- Data is organised into 8-bits or one byte, which is the basic unit of data.
- Data organised into 16-bits is called a half-word.
- Data organised into 32-bits is called a word.
- The size of a word depends on the size of the address bus. A 32-bit address
    bus would be able to handle 32-bit data.
- ARM Cortex is a 32-bit microcontroller, so a word is 32-bits.
- A memory unit in hardware is 1-byte, while a memory unit in software is
    4-bytes by default.

#cimage("./images/data-organisation-nomenclature.png", height: 20em)
#cimage("./images/32-bit-integer-memory-layout-little-endian.png", height: 20em)

#pagebreak()

== Address indexing methods
The addressing mode is formed from two parts:
- The base register.
- The offset.

The base register can be any one of the general-purpose registers (`R0` -
`R16`), including the program counter register (`PC`), which allows for
`PC`-relative addressing for position-independent code.

The offset takes one of three formats:
+ Intermediate

    The offset is an unsigned number that can be added to or subtracted from the
    base register. Immediate offset addressing is useful for accessing data
    elements that are a fixed distance from the start of the data object, such
    as structure fields, stack offsets and input/output registers.

    For the word and unsigned byte instructions, the immediate offset is a
    12-bit number. For the half-word and signed byte instructions, it is an
    8-bit number.

+ Register

    The offset is a general-purpose register (not the program counter, `PC`)
    that can be added to or subtracted from the base register. Register offsets
    are useful for accessing arrays or blocks of data.

+ Scaled register

    The offset is a general-purpose register (not the program counter, `PC`)
    shifted by an immediate value, then added to or subtracted from the base
    register. The same shift operations used for data-processing instructions
    can be used (Logical Shift Left, Logical Shift Right, Arithmetic Shift Right
    and Rotate Right), but Logical Shift Left is the most useful as it allows an
    array indexed to be scaled by the size of each array element.

    Scaled register offsets are only available for the word and unsigned byte
    instructions.

Types of address indexing:
- Offset, where the base register and offset are added or subtracted to form the
    memory address.
- Pre-indexed, where the base register and offset are added or subtracted to
    form the memory address. The base register is then updated with this new
    address, to allow automatic indexing through an array or memory block.
- Post-indexed, where the value of the base register alone is used as the memory
    address. The base register and offset are added or subtracted, and this
    value is stored back in the base register to allow automatic indexing
    through an array or memory block.

#pagebreak()

=== Pre-indexing without write-back
Pre-indexing without write-back is to use [base + offset] and *not update* the
base address afterwards.
- Data: `memory[base + offset]`
- Base address register is *not updated*
- Code:
    ```asm
    LDR R0, [R1, #4]    ; C equivalent: R0 = memory[R1 + 4]
    ```

=== Pre-indexing with write-back
Pre-indexing without write-back is to use [base + offset] and *update* the base
address afterwards.
- Data: `memory[base + offset]`
- Base address register: `base + offset`
- Code:
    ```asm
    LDR R0, [R1, #4]!   ; C equivalent: R0 = memory[R1 + 4]; R1 = R1 + 4
    ```

=== Post-indexing
Post-indexing is to use [base] and update the base address *before* using it.
- Data: `memory[base]`
- Base address register: `base + offset`
- Code:
    ```asm
    LDR R0, [R1], #4    ; C equivalent: R1 = R1 + 4; R0 = memory[R1]
    ```

=== Example 1: Pre-indexed address without write-back
```asm
LDR     R11, [R1, R2]   ; Load R11 from the address in R1 + R2
STRB    R10, [R7, -R4]   ; Store byte from R10 to the address in R7 - R4
```

=== Example 2: Pre-indexed address with write-back
```asm
LDR     R11, [R3, R5, LSL #2]   ; Load R11 from the address in R3 + (R5 * 4)
LDR     R1, [R0, #4]!           ; Load R1 from R0 + 4, then R0 = R0 + 4
STRB    R10, [R7, #-1]!         ; Store byte from R7 to R6 - 1, then R6 = R6 - 1
```

#pagebreak()

== ARM Cortex M4 GPIO ports
- ARM Cortex M4 has 6 maskable data registers (ports A to F).
- Note that the last 12 bits in the GPIO ports are not used for the address.
    They are instead used to make input and output data. By default, use you
    choose the offset of `0xFFF`.

#cimage("./images/arm-gpio-ports-data-layout.png")

- Bits 8 to 31 are reserved and are read-only. Software should not rely on the
    value of a reserved bit. To provide compatibility with future products, the
    value of a reserved bit should be preserved across a read-modify-write
    operation.
- Bits 0 to 7 are GPIO data bits and are read-write. The register is virtually
    mapped to 256 locations in the address space. To facilitate the reading and
    writing of data to these registers by independent drivers, the data read
    from and written to the registers are masked by the eight address lines,
    bits 2 to 9. Reads from this register return its current state. Writes to
    this register only affect bits that are not masked by bits 2 to 9 and are
    configured as outputs.

=== Read and write example
#cimage("./images/gpio-port-data-read-and-write-examples.png")

#pagebreak()

=== Example with port F
GPIO Data Port F address: `0x40025000`

#cimage("./images/gpio-data-port-f-example.png")

```asm
PORT_F_PIN_0 EQU 0x40025 004  ; ADR[9:0] = 0 000 0100
PORT_F_PIN_1 EQU 0x40025 008  ; ADR[9:0] = 0 000 1000
PORT_F_PIN_2 EQU 0x40025 010  ; ADR[9:0] = 0 001 0000
PORT_F_PIN_3 EQU 0x40025 020  ; ADR[9:0] = 0 010 0000
```

Masking port F:
#cimage("./images/gpio-data-port-f-example-data-mask.png", height: 10em)

This mask will result in an address of `0x40025038`, which represents port F
pins 1-3, as `0000 0011 1000` in binary is `038` in hexadecimal.

Port F pins:
#cimage("./images/gpio-data-port-f-example-pins.png")

== Encoding of instructions in ARM
#cimage("./images/arm-instruction-encoding.png")

=== `LDR` and `STR` instructions for data I/O
- Load instructions load a single value from memory and write it to a
    general-purpose register.
- Store instructions read a value from a general-purpose register and store it
    to memory.
- Load (input to ALU) and store (output) *words and unsigned bytes*.

#cimage("./images/ldr-and-str-instruction-encoding.png")

Where:
- `I, P, U` and `W` are bits that distinguish between different types of
    `<addressing_mode>`.
- `L` bit distinguishes between a load (`L = 1`) and a store instruction
    (`L = 0`)
- `B` bit distinguishes between an unsigned byte (`B = 1`) and a word (`B = 0`)
    access.
- `Rn` specifies the base register used by `<addressing_mode>`.
- `Rd` specifies the register whose contents are to be loaded or stored.

==== For sizes other than a word
Load (input to ALU) and store (output from ALU) *half-words, double-words, or
unsigned bytes*.

#cimage("./images/ldr-and-str-instruction-encoding-other-sizes.png")

Where:
- `addr_mode` are addressing mode specific bits.
- `I, P, U` and `W` are bits that specify the type of addressing mode.
- `L, S` and `H` are bits that combine to specify signed or unsigned loads or
    stores, as well as double-word, half-word or byte accesses.
- `Rn` specifies the base register used by the addressing mode.
- `Rd` specifies the register whose contents are to be loaded or stored.

#pagebreak()

= Digital input and output (GPIO)

== Digital signals

=== Logic levels
#align(center, table(
    columns: 2,
    align: center,
    table.header([*Logic*], [*Voltage*]),
    [0], [#qty[0][V]],
    [1], [#qty[5][V]],
))

=== Transistor-transistor logic (TTL) levels
#align(center, table(
    columns: 2,

    $V_"OH"$,
    [The minimum *output* voltage level a TTL device will provide for a HIGH
        signal.],

    $V_"IH"$, [The minimum *input* voltage level to be considered a HIGH.],

    $V_"OL"$,
    [The maximum *output* voltage level a device will provide for a LOW
        signal.],

    $V_"IL"$, [The maximum *input* voltage level to still be considered a LOW.],
))

=== Acceptable input digital signals (TTL levels)
#cimage("./images/acceptable-input-digital-signals.png")

#pagebreak()

=== Representation and events of digital signals
Representation:
- Time series of 1s and 0s.
- Time series of square waves.

Events:
- Rising edge
- Falling edge
- Level of logic high
- Level of logic low

#cimage("./images/representation-of-digital-signals.png")

=== Signal lines of digital signals
- These are physical wires which transmit digital signals from one end to
    another end.
- When a microcontroller (MCU) or device sends out a digital signal through a
    signal line to be HIGH or LOW, such an operation is called a digital output.

=== Tri-state logic
- In digital devices a device, which can output 1, 0, or high impedance to
    signal lines, is called a tri-state device.
- Three-state, tri-state, or 3 state logic allows an output or input pin to
    assume a high impedance state.
- This effectively removes the output from the circuit, in addition to the 0 and
    1 logic levels.
    - This is needed if more than 2 devices are sharing the same signal.
    - This allows multiple devices to share the same output lines.

=== Schmitt filters or triggers
- Digital signals can be contaminated by noises due to various reasons.
- The input of digital signals at the receiver must have the ability to filter
    out the noises. One type of device for such purpose is called a Schmitt
    filter or trigger.

=== Principle of Schmitt filters
- If $V_"in" > V_"max"$, then the output logic is HIGH.
- If $V_"in" < V_"min"$, then the output logic is LOW.

#pagebreak()

=== Communication of digital signals
- Asynchronous serial output
- Synchronous serial output

#cimage("./images/communication-of-digital-signals.png")

== Synchronous digital input and output

=== Working principle of synchronous serial input and output
The input unit consists of:
- Shift registers
- Data registers
- Control registers
- Status registers
- Data line, clock line

#cimage("./images/synchronous-serial-input-and-output.png")

- Frame sync signal send start-pulse which tells the clock line to produce eight
    clock pulses.
- Each clock pulse causes one bit to be shifted into the receiver (Device B).
- Frame sync signal sends stop-pulse, and the content of the shift register is
    copied to the data register.

=== SPI and I2C example
#cimage("./images/example-of-spi-and-i2c.png")

=== Example of an I2C bus
#cimage("./images/example-of-an-i2c-bus.png")

Where:
- SDA refers to Serial Data
- SCL refers to Serial Clock

#pagebreak()

=== Working principle of synchronous parallel input and output
The input unit consists of:
- Data registers
- Control registers
- Status registers
- Input port (8 pins, 1 byte)
- Strobe lines

#cimage("./images/synchronous-parallel-input-and-output.png")

If the receiver initiates the communication, it first indicates that the
receiver is ready to input one byte. The transmitter then sends one byte to the
data bus and indicates that one byte is ready to be read. The receiver inputs
one byte from the data bus. (#text(red)[Suitable for reading sensory input]).

If the transmitter initiates the communication, it sends one byte to the data
bus and indicates that one byte is ready to be read. The receiver inputs one
byte from the data bus (#text(red)[Suitable for sending commands to motors]).

=== Receiver initiated parallel input
#cimage("./images/receiver-initiated-parallel-input.png")

- Receiver first initiates that it is ready to get input.
- Transmitter sends a byte to the data bus.
- Transmitter indicates that one byte is ready on the bus.
- Receiver inputs one byte.
- The process repeats.

=== Transmitter initiated parallel input
#cimage("./images/transmitter-initiated-parallel-input.png")

- Transmitter sends a byte to the data bus.
- Transmitter indicates that one byte is ready on the bus.
- Receiver inputs one byte.
- The process repeats.

#pagebreak()

== Asynchronous digital input and output

=== Working principle of asynchronous digital input and output (data line)
The input unit consists of:
- Shift registers
- Latch registers
- Control registers
- Status registers
- Data line

#cimage("./images/asynchronous-digital-input-and-output.png")

- One byte is used for formatted additional bits, such as START bits, STOP bits
    and parity bits.
- Transmitter and receiver are configured to be running at the same clock
    frequency.
- The communication is initiated by the transmitter and is triggered by the
    START bit.
- The START bit wakes up the receiver which will receive the series of bits
    until the last stop bit. The data is then latched into the latch register.

#pagebreak()

=== Working principle of asynchronous digital input and output (data line)
The input units consist of:
- Data registers
- Control registers
- Status registers
- Input port (8 pins, 1 byte)

#cimage("./images/asynchronous-digital-input-and-output-port.png")

The CPU uses the control registers to configure the input port.
- The tri-state register (TRIS), controls the direction of pins in the input and
    output port.
- The CPU reads one byte from the input port.
- The CPU decodes the content.
- The CPU acts according to the content.

#cimage(
    "./images/asynchronous-digital-input-and-output-board-layout.png",
    height: 20em,
)
#pagebreak()

==== Example: Keypad
- The CPU sequentially outputs 1110, 1101, 1101, 0111 to port A.
- The CPU inputs data from port B.
- By default, all keys are not pressed.
- When a key is pressed, the corresponding column line will be in logic low
    (i.e. "0").

#cimage("./images/keypad-example.png")

When port A is 1101, and port B is 1101, the keypad registers 5.

==== Example: LED dot matrix
- CPU outputs `$BF` (`0xBF`) to port A and `$02` (`0x02`) to port B.
- The LED at row 1 and column 6 will light up.

#cimage("./images/led-dot-matrix-example.png")
#pagebreak()

= Analogue input and outputs

== Types of analogue inputs
+ Visual
+ Auditory
+ Motion

== Types of analogue outputs
+ Lights or displays
+ Sounds
+ Motion, motors and sensors

== Working principle of a digital to analogue converter (DAC)
+ Configure the digital to analogue converter.
+ Read a digital number.
+ Convert the digital number into an analogue value.
+ Output the result.

- The digital to analogue converter has data registers, control registers and
    status registers.
- After configuration, the digital to analogue converter reads a digital number
    from the data register.
- The data register is connected to a network of resistors.
- The output voltage from the resistor network is connected to an operational
    amplifier (op-amp).
- The voltage output from the operational amplifier is the analogue output
    value.

#cimage("./images/dac-circuit.png")
#pagebreak()

=== Exercise
A 4-bit DAC converts these digital numbers into analogue voltages. If we use the
circuit shown below, what is the analogue voltage if the digital value is 1011?

#cimage("./images/dac-exercise-circuit.png", height: 20em)

$ V_"out" = - 10k times (5/(10k) + 0/(20k) + 5/(40k) + 5/(80k)) $
$ V_"out" = -5 + 0 + 5/4 + 5/8 $
$ V_"out" = -5 + 1.25 + 0.625 $
$ V_"out" = #qty[-6.875][V] $

== Specification of DACs
- Range of input value: $N$ bits
- Range of output value: $V_"min"$ (#unit[V]) to $V_"max"$ (#unit[V])
- DAC's digital resolution:
    $ "Digital resolution" = "Analogue Range"/"Digital Range" $
- DAC's analogue resolution:
    $ "Digital resolution" = "Digital Range"/"Analogue Range" $

=== Exercise
A microcontroller's DAC takes 12-bit numbers as input and produces an analogue
output which varies from #qty[0.0][V] to #qty[5.0][V]. What is the DAC's digital
and analogue resolution?

$
    "Digital resolution" = frac(5.0 - 0.0, 2^(12))
    = 1.2 times 10^(-3) space #unit[V bits^-1]
$

$
    "Analogue resolution" = frac(2^(12), 5.0 - 0.0)
    = 819 #unit[bits V^-1]
$

== Working principle of an analogue to digital converter (ADC)
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - The analogue to digital converter has data registers, control
            registers and status registers.
        - After configuration, the analogue to digital converter runs a counter
            which incrementally outputs a digital number.
        - The digital number is converted to an analogue voltage by a digital to
            analogue converter.
        - The digital to analogue voltage is compared with the input's analogue
            voltage.
        - When the above two voltages are equal, the analogue to digital
            converter stops the counter.
        - The digital number of the counter is the output of the analogue to
            digital converter.
    ],
    image("./images/adc-circuit.png"),
)

#pagebreak()

=== Example: Speech signals
Pulse-code modulation (PCM) is a method used to digitally represent sampled
analogue signals. It is the standard form of digital audio in computers.

#cimage("./images/adc-example-speech-signals.png", width: 80%)

MEMS microphones produce an electrical signal from the change in capacitance
caused by the movement of a membrane relative to a stationary plate.

#cimage("./images/adc-example-speech-signals-mems-microphone.png")
#pagebreak()

== Specification of ADCs
- Range of input value:
    - High reference voltage ($V_"refh"$) to low reference voltage ($V_"refl"$)
- Range of output value: $N$ bits
- ADC's digital resolution:
    $ "Digital resolution" = "Analogue Range"/"Digital Range" $
- ADC's analogue resolution:
    $ "Digital resolution" = "Digital Range"/"Analogue Range" $

=== Exercise
A rotary potentiometer outputs voltages which are within the interval of [0.0,
3.0] (#unit[V]). We use a 12-bit ADC to convert the analogue values of the
potentiometer into digital numbers. What is the ADC's digital and analogue
resolution?

$
    "Digital resolution" = frac(3.3 - 0.0, 2^(12))
    = 0.8 times 10^(-3) space #unit[V bits^-1]
$

$
    "Analogue resolution" = frac(2^(12), 3.3 - 0.0)
    = 1241 #unit[bits V^-1]
$

#pagebreak()

= Universal asynchronous receiver/transmitter (UART)
- UART is the interface device that implements the transmission of serial data
    between two devices.
- Data terminal equipment (DTE) is the computer.
- Data communication equipment (DCE) is the device, like a modem, printer, etc.
- It is used for serial and parallel conversions for communication between
    microcontrollers (MCU) and serial I/O devices.
- It's purpose is to translate bytes of data into serial forms suitable for
    transmitting (TX) and converting the serial data back to bytes of data, or
    receiving (RX).
- UARTs are commonly included in microcontrollers.
- Data format and transmission speeds are configurable.
- The data format follows the communication standards of EIA, RS232, RS485, etc.
- Communications may be in:
    - Simplex, which is one direction only.
    - Duplex, which is both directions simultaneously.
    - Half duplex, which is RX and TX taking turns, one at a time.
- Has 3 lines, Tx, Rx and ground (GND).

== Basic elements of a parallel/serial interface
- A serial receiver (Rx).
    - It converts a serial format into parallel format, and store it in the
        receiver data register (RxDR) for eventual transmission to the MCU.
- A serial transmitter (Tx).
    - It takes a parallel word from the transmitter data register (TxDR) and
        converts it into a serial format for transmission.
- A bidirectional data bus buffer.
    - It passes data from the microcontroller to the transmitter data register,
        or from the receiver data register to the microcontroller over the
        system data bus.
- External clocks such as the receiver clock (RxCLK) and the transmitter clock
    (TxCLK).

#cimage("./images/uart-parallel-serial-interface.png", height: 25em)

== UART connection to external device
#figure(
    image("./images/uart-serial-channel-connecting-two-devices.png"),
    caption: [
        Serial channel connecting two data terminal equipment (DTE) devices.
    ],
)

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        To improve bandwidth, increase range, and reduce noise, we use the TI
        MAX3232 chip line driver to bring the voltages to transistor-transistor
        logic (TTL) requirements.
    ],
    image("./images/uart-ti-max3232.png", width: 5em),
)

MAX3232 is a #qty[3][V] to #qty[5.5][V] multichannel RS-232 line driver/receiver
with #sym.plus.minus #qty[15][kV] ESD protection.

== Data communication (serial)
- Asynchronous communication
    - Transmitter can send data to the receiver at any time.
    - The time delay between the transmission of two words may be indeterminate.
    - Transmitter's clock need not be synchronised with the receiver's clock.
- Synchronous communication
    - Transmitter sends data to receiver continually.
    - Data words are sent in blocks, and separated by sync characters.
    - Sync characters are used by the receiver to synchronise its clock to that
        of the transmitter.
    - Transmitter sends sync characters continually when there is no data to
        send.

== Asynchronous serial format (data framing)
- A data frame is a complete and nonvisible packet of information, in bits.
- A data frame includes information, which is data or characters, and overhead,
    like start, stop, and error checking bits.
- A data frame is the smallest data packet that can be transmitted and
    understood.

#pagebreak()

=== Standard format
#cimage("./images/uart-asynchronous-serial-format-table.png")

- A START bit at index 0.
- 5 - 8 data bus, and the least significant bit (LSB) is transmitted first.
- Optional parity bit for error detection, which can either be even or odd
    parity.
- Example of an even parity check:
    - Sum of all bits in 1 transmitter data word must be even.
    - There is an error detected at the receiver if the sum is not even.
    - 7 bit data words, like ASCII, and #text(red)[1 parity bit]:
        $
            underbrace(1010 quad 100, "Odd") mathred(1) wide
            underbrace(1000 quad 111, "Even") mathred(0)
        $

        The bits in #text(red)[red] are the parity bits.
- 1 or 2 stop bits.

#cimage("./images/uart-asynchronous-serial-format-overview.png")

#cimage("./images/uart-asynchronous-serial-format-transmission.png")

- The START bit signals to the receiver that a new character is coming.
- The next 5 to 8 bits represent the character.
- If a parity bit is used, it would be placed after all the data bits.
- The next one or two bits always in the mark (logic high, i.e. "1") condition
    and are called the stop bits. They signal to the receiver that the character
    is completed.
- Since the START bit is logic low (0), and the stop bit is logic high (1) there
    are always at least two guaranteed signal changes between characters.

== ASCII format
ASCII stands for American Standard Code for Information Interchange.

#table(
    columns: 11,
    align: center + horizon,
    table.header([], table.cell(colspan: 10)[*MSB*]),

    table.cell(rowspan: 18)[*LSB*],

    [], [HEX], [0], [1], [2], [3], [4], [5], [6], [7],
    [HEX], [BIN], [000], [001], [010], [011], [100], [101], [110], [111],
    [0], [0000], [(NUL)], [(DLE)], [Space], [0], [@], [P], "`", [p],
    [1], [0001], [(SOH)], [(DC1)], [!], [1], [A], [Q], [a], [q],
    [2], [0010], [(STX)], [(DC2)], ["], [2], [B], [R], [b], [r],
    [3], [0011], [(ETX)], [(DC3)], "#", [3], [C], [S], [c], [s],
    [4], [0100], [(EOT)], [(DC4)], "$", [4], [D], [T], [d], [t],
    [5], [0101], [(ENQ)], [(NAK)], [%], [5], [E], [U], [e], [u],
    [6], [0110], [(ACK)], [(SYN)], [&], [6], [F], [V], [f], [v],
    [7], [0111], [(BEL)], [(ETB)], ['], [7], [G], [W], [g], [w],
    [8], [1000], [(BS)], [(CAN)], [(], [8], [H], [X], [h], [x],
    [9], [1001], [(HT)], [(EM)], [)], [9], [I], [Y], [i], [y],
    [A], [1010], [(LF)], [(SUB)], "*", [:], [J], [Z], [j], [z],
    [B], [1011], [(VT)], [(ESC)], [+], [;], [K], [[]], [k], [{],
    [C], [1100], [(FF)], [(FS)], [,], [<], [L], [\\], [l], [|],
    [D], [1101], [(CR)], [(GS)], [-], [=], [M], "]", [m], [}],
    [E], [1110], [(SO)], [(RS)], [.], [>], [N], [^], [n], "~",
    [F], [1111], [(SI)], [(US)], [/], [?], [O], "_", [o], [DEL],
)

#pagebreak()

== Baud rate (data transmission speed)
- Baud rate is the rate of data transmission in serial communication.
    $ "Baud rate" = 1/"Time between transition (Baud)" $
    $
        "Data rate" = "Rate of data transmission"
        (#unit[bits s^-1] "or" #unit[Mb s^-1])
    $
- In most simple serial communication, baud rate is equal to the data rate.
- Common baud rates include:
    - 115200
    - 57600
    - 19200
    - 14400
    - 9600
    - 4800
    - 2400
    - 1200
    - etc.

=== Example
If the baud rate is equal to the data rate of #qty[9600][baud], what is the time
duration of 1 bit?
$ "Data rate" = #qty[9600][bits s^-1] $
$ "Bit time" = 1/9600 = #qty[104.17][#sym.mu s] $

#pagebreak()

== UART data transmission
- To transmit a data word from the MCU to a serial output device:
    + MCU sends the data word to the UART's transmitter data register (TxDR).
    + Control logic in the Tx section takes this data word, frames it with a
        START bit, parity bit, and stop bits, and then places it in the transmit
        shift register.
    + Contents of this shift register are shifted right at a rate determined by
        the transmit data clock, where the clock frequency is the baud rate.

#cimage("./images/uart-shift-register.png")

- To send a data word from a serial input device to the microcontroller:
    + Serial input device transmit a serial data word to the UART's receiver
        section through the RxDATA input.
    + Upon receiving a START bit on the RxDATA line, the Rx section shifts the
        remainder bits of the data word into the receiver shift register.
    + The transmission rate is determined by the receiver data clock.
    + When the complete word is in the register, the data portion (D#sub[7] -
        D#sub[0]) is transferred in parallel to the RxDR.
    + The microcontroller reads the contents of RxDR like other memory
        locations.

#cimage("./images/uart-data-transmission.png")
#pagebreak()

== Syncing receiver section with serial data
#cimage("./images/uart-syncing-receiver-section-with-serial-data.png")

To ensure reliable data transmission, the receiver needs to sample the signal at
a rate that is high enough to capture the changes in hte signal.

The baud rate determines the frequency of the signal changes, so the sampling
rate needs to be a multiple of the baud rate.

Sampling at 16#sym.times the baud rate provides several benefits:
+ *Accurate data recovery*: Sampling at 16#sym.times ensures that the receiver
    can accurately detect the start and stop bits, as well as the data bits.
+ *Noise tolerance*: Sampling at at higher rate helps to reduce the impact of
    noise on the signal, making the transmission more reliable.
+ *Clock recovery* The 16#sym.times sampling rate allows the receiver to recover
    the clock signal from the transmitter, ensuring proper synchronisation.

While other sampling rates are possible, 16#sym.times has become the standard
for UART communication due to its balance between accuracy, noise tolerance, and
clock recovery.

- External clock of UART is 16 times faster than the baud rate, i.e. 1 period of
    $"RxCLK" = T_B/16$
    - For example:
        $ "Baud rate" = 9600 $
        $ "RxCLK" = 16 times 9600 = #qty[153.6][kHz] $
- RxCLK set to divide by 16 (MOD 16) when samples are shifted to the shift
    register. THis makes the frequency of the received data clock be the same as
    the baud rate.

#pagebreak()

=== Syncing procedure
+ After sensing the first negative going transition (falling edge), the receiver
    waits for 8 cycles of RxCLK, then samples to see if the serial input is
    still low, to ensure that it is a START bit.
+ Receiver samples the serial data at every 9th cycle of the 16 RxCLK cycles
    (\~1 bit time)
+ Each sample is shifted into the receiver shift register on the rising edge of
    the receiver's data clock.
+ UART checks if STOP bits are 1s, if not, a *framing error* flag is set.
+ UART checks for parity to be even, if not, a *parity error* flag is set.
+ Data bits are transferred in parallel to the RxDR.
+ Receiver continues to shift data bits into the receiver shift register.
+ This second word will not be transferred into the RxDR until the first word is
    read by the microcontroller.
+ If the third word arrives before the first word is cleared, it will overwrite
    the second word. An *overrun error* flag will be set.
+ This can be avoided with the correct baud rate setting.

#pagebreak()

= Synchronous serial interface (SSI)
- Another common name for synchronous serial interface is serial peripheral
    interface (SPI).
- SSI is widely used as a serial interface between an absolute position sensor
    and a microcontroller.
- SSI uses a clock pulse train from a microcontroller to initiate a gated output
    form the sensor.
- Operates as master or slave.
- Channels can operate as one master to a single or multiple slaves.
- Communication is always in duplex mode.

#cimage("./images/ssi-master-slave.png")

- Tx (Master out, Slave in, MOSI) data line is driven by the master and received
    by the slave.
- Rx (Master in, Slave out, MISO) data line is driven by the slave and received
    by the master.

#figure(
    image("./images/ssi-timing-diagram.png"),
    caption: "SSI timing diagram",
)

- Transmitting devices uses the edge of one clock to change the output and the
    receiving device uses other edge to accept the data.
- Classified as synchronous devices as one hardware clock is shared between the
    devices.

== UART vs SSI
#align(center, table(
    columns: 2,
    table.header([*UART*], [*SSI*]),

    [*Asynchronous* protocol], [*Synchronous* protocol],

    [
        Two devices operate at the same frequency (baud rate) but have *2
        separate* clocks.
    ],
    [
        Two devices operate with the *same clock* with one clock frequency.
    ],

    [Two clocks must have frequency *within 5%* of each other],
    [
        The master creates the clock and the slave *uses the clock to latch* the
        data, either for input or output.
    ],

    [Lines: Tx, Rx and Gnd], [Lines: Tx, Rx, Clk, Fss (optional)],
))

#pagebreak()

= Stepper motors

== Working principle
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - The rotating body is called the rotor.
        - The outer body is called the stator.
        - The rotor is made of a permanent magnet.
        - The stator has a set of electromagnets.
        - When one pair of electromagnets is on, the rotator will make one step
            motion order to align with the stator's magnetic field.
        - By changing the sequence of energising the stator's electromagnet, we
            can get the rotator to make stepwise motions.
    ],
    image("./images/stepper-motor-working-principle-1.png"),
)

#cimage("./images/stepper-motor-working-principle-2.png")
#pagebreak()

== Advantages
- Easy to control as each pulse produces a respective step angle of the motor.
- Mounting space is small.
- Stepper motor will hold their position when stationary, which requires power.
- The stepper motor driver board is cheaper compared to other drivers like PWM
    or servo motor driver boards.

== Disadvantages
- The design of the driver is not an efficient one.
- It requires a lot of wiring for the application.
- Larger stepper motors require heat sinks to dissipate heat from the stepper
    motor when they are stationary.

== Applications
- Printers (2D and 3D)
- Robotic arms
- Autonomous vehicles

== Output control
#cimage("./images/stepper-motor-output-control.png")

Phase 1:
+ 1A: Powered, 1B: Depowered
+ 1A: Depowered, 1B: Powered

Phase 2:
+ 2A: Powered, 2B: Depowered
+ 2A: Depowered, 2B: Powered

=== Example
#figure(
    image(
        "./images/stepper-motor-uln2003-stepper-driver-board.png",
        height: 20em,
    ),
    caption: "ULN2003 stepper motor driver board",
)
- `IN1 - IN4` pins are used to drive the motor. Connect them to a digital output
    pins on the TM4C123G Launchpad (e.g. PC4, PC5, PC6, PC7).
- `GND` is a common ground pin.
- `VDD` pin supplies power for the motor. Connect it to an external #qty[5][V]
    power supply. Do not use the #qty[5][V] power from the TM4C123G Launchpad.
- The motor connector is where the stepper motor plus into. The connector is
    keyed, so it only goes one way.

#figure(
    image("./images/stepper-motor-uln2003-stepper-driver-connection.png"),
    caption: [
        TM4C123G, ULN2003 stepper driver, and stepper motor connection diagram.
    ],
)

#pagebreak()

= Brushed DC motors

== Working principle
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - The stator is made of a permanent magnet.
        - The rotor has a set of rectangular coils.
        - When the rectangular coilis are parallel to the magnetic field,
            current will pass through the coils. Also, the edges perpendicular
            to the magnetic flux will produce magnetic forces, which make the
            coils rotate in one direction.
        - The motion of the rotor will bring another rectangular coil into being
            parallel with the magnetic field. The process repeats.
    ],
    image("./images/dc-motor-working-principle.png"),
)

== L289N H-bridge motor driver
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - There are two terminals with two connections. Hence, the driver can
            support 2 DC motors at a time.
        - `IN1` and `IN2` are the direction control pins for the motor 1, which
            controls the first internal H-bridge within the driver.
        - `IN3` and `IN4` are the direction control pins for the motor 2, which
            controls the second internal H-bridge within the driver.
        - `ENA` and `ENB` controls motor 1 and motor 2 respectively. Keeping
            these pins on logical high will let the DC motors rotate. Pulling
            these pins to a low state will turn of the motors.
        - By removing jumpers, we can apply a PWM signal to each pin instead of
            just an on/off signal.
    ],
    image("./images/dc-motor-l289n-h-bridge-motor-driver.png"),
)

#pagebreak()

=== Output control

==== PWM logic control
- Clockwise (CW) rotation:
    - `IN1` high.
    - `IN2` low.
    - `ENA` supplies PWM pulses.
- Counter-clockwise (CCW) rotation:
    - `IN1` low.
    - `IN2` high.
    - `ENA` supples PWM pulses.

#cimage("./images/dc-motor-l289n-h-bridge-motor-driver-logic-control.png")

==== PWM power control
#cimage("./images/dc-motor-l289n-h-bridge-motor-driver-power-control.png")

- To drive a DC motor using a TM4C123G with a L298N motor driver, three signals
    to the L298N motor driver from the TM4C123G are required.
- Two signals to control the direction (e.g. GPIO PA2 and PA3) to provide active
    high/low to the L298N and one PWM signal (PF2).

= Brushless DC motors
#cimage("./images/brushless-dc-motor-section-view.png", height: 20em)

== Hall effect sensor
When a magnetic flux passes through the sensor, a voltage is produced as output.

#cimage("./images/brushless-dc-motor-hall-effect-sensor.png")

== Working principle
#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        - The rotor is made of a permanent magnet.
        - The stator has a set of electromagnets.
        - The stator's electromagnets are sequentially excited to create a
            rotating magnetic field.
        - The stator's rotating magnetic field will cause the rotator to follow
            the rotation.
        - The hall sensors are employed to provide the position feedback so as
            to synchronise the commutation of excitations.
    ],
    figure(
        image("./images/brushless-dc-motor-working-principle.png"),
        caption: [
            Brushless DC motors have a rotor with a permanent magnet containing
            a north and south poles. The stator comprises multiple
            electromagnets.
        ],
    ),
)

== Sequence
#cimage("./images/brushless-dc-motor-sequence-1.png")
#cimage("./images/brushless-dc-motor-sequence-2.png")
#cimage("./images/brushless-dc-motor-sequence-3.png")

== Advantages
Brushless DC motors are more efficient as its velocity is determined by the
frequency at which the current is supplied, not the voltage.
+ As brushes are absent, the mechanical energy loss due to friction is less,
    which enhances efficiency.
+ Brushless DC motors can operate at high-speeds under any condition.
+ There is no sparking and there is much less noise during operation.
+ More electromagnets could be used on the stator for more precise control.
+ Brushless DC motors accelerate and decelerate easily as they have low rotor
    inertia.
+ They are also high performance motors that provide a large torque per cubic
    inch over a large speed range.
+ Brushless DC motors do not have brushes, which make them more reliable, last
    longer, and require very little maintenance.
+ There are no ionising sparks from the commutator, and electromagnetic
    interference is also reduced.
+ Such motors could be cooled by conduction, and no air flow is required to cool
    the insides of the motor.

== Disadvantages
+ Brushless DC motors cost more than a brushed DC motor.
+ The power of the motor is limited, as too much heat weakens the magnets and
    may damage the insulation of the winding.

#pagebreak()

= TM4C123GH6PM General Purpose Input/Output (GPIO)

== Key features
- Six ports: ports A, B, C, D, E and F.
- Ports A to F are accessed through Advanced Peripheral Bus (APB).
- 43 programmable pins: 7:0 PA - PD, 5:0 PE, 4:0 PF
- Pins configured as digital inputs are Schmitt-triggered.
- Programmable control of GPIO's interrupts.
- Programmable control of GPIO's pad configuration.

== Process of operating GPIO
Control registers are used to:
- Configure input
- Configure internal processes

Status registers are used to:
- Configure output
- Run GPIO

== Pin diagram
#cimage("./images/cortex-m4-pin-diagram-square.png")

== Analogue and digital I/O pads
#cimage("./images/tm4c123gh6pm-io-pads.png", height: 28em)
#cimage("./images/tm4c123gh6pm-io-pads-diagram.png")

== GPIO pins and alternate functions
<gpio-pins>
#align(center, pad(x: -5em, table(
    align: center + horizon,
    columns: 14,
    table.header(
        table.cell(rowspan: 2)[*IO*],
        table.cell(rowspan: 2)[*Pin*],
        table.cell(rowspan: 2)[*Analog \ Function*],
        table.cell(colspan: 11)[*Digital Function (GPIO PCTL PMC #sym.times Bit
        Field Encoding)*],
        [*1*],
        [*2*],
        [*3*],
        [*4*],
        [*5*],
        [*6*],
        [*7*],
        [*8*],
        [*9*],
        [*14*],
        [*15*],
    ),

    [`PA0`],
    [17],
    [-],
    [`U0Rx`],
    [-],
    [-],
    [-],
    [`CAN1Rx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PA1`],
    [18],
    [-],
    [`U0Tx`],
    [-],
    [-],
    [-],
    [`CAN1Tx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PA2`],
    [19],
    [-],
    [-],
    [`SSIOClk`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PA3`],
    [20],
    [-],
    [-],
    [`SSIOFss`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PA4`],
    [21],
    [-],
    [-],
    [`SSIORx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PA5`],
    [22],
    [-],
    [-],
    [`SSIOTx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PA6`],
    [23],
    [-],
    [-],
    [-],
    [`I2C1SCL`],
    [-],
    [`M1PWM2`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PA7`],
    [24],
    [-],
    [-],
    [-],
    [`I2C1SDA`],
    [-],
    [`M1PWM3`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PB0`],
    [45],
    [`USB0ID`],
    [`U1Rx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`T2CCP0`],
    [-],
    [-],
    [-],
    [-],

    [`PB1`],
    [46],
    [`USB0VBUS`],
    [`U1Tx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`T2CCP1`],
    [-],
    [-],
    [-],
    [-],

    [`PB2`],
    [47],
    [-],
    [-],
    [-],
    [`I2C0SCL`],
    [-],
    [-],
    [-],
    [`T3CCP0`],
    [-],
    [-],
    [-],
    [-],

    [`PB3`],
    [48],
    [-],
    [-],
    [-],
    [`I2C0SDA`],
    [-],
    [-],
    [-],
    [`T3CCP1`],
    [-],
    [-],
    [-],
    [-],

    [`PB4`],
    [58],
    [`AIN10`],
    [-],
    [`SSI2Clk`],
    [-],
    [`M0PWM2`],
    [-],
    [-],
    [`T1CCP0`],
    [`CAN0Rx`],
    [-],
    [-],
    [-],

    [`PB5`],
    [57],
    [`AIN11`],
    [-],
    [`SSI2CFss`],
    [-],
    [`M0PWM3`],
    [-],
    [-],
    [`T1CCP1`],
    [`CAN0Tx`],
    [-],
    [-],
    [-],

    [`PB6`],
    [1],
    [-],
    [-],
    [`SSI2Rx`],
    [-],
    [`M0PWM0`],
    [-],
    [-],
    [`T0CCP0`],
    [-],
    [-],
    [-],
    [-],

    [`PB7`],
    [4],
    [-],
    [-],
    [`SSI2Tx`],
    [-],
    [`M0PWM1`],
    [-],
    [-],
    [`T0CCP1`],
    [-],
    [-],
    [-],
    [-],

    [`PC0`],
    [52],
    [-],
    [`TCK SWCLK`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`T4CCP0`],
    [-],
    [-],
    [-],
    [-],

    [`PC1`],
    [51],
    [-],
    [`TMS SWDIO`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`T4CCP1`],
    [-],
    [-],
    [-],
    [-],

    [`PC2`],
    [50],
    [-],
    [`TDI`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`T5CCP0`],
    [-],
    [-],
    [-],
    [-],

    [`PC3`],
    [49],
    [-],
    [`TDO SWO`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`T5CCP1`],
    [-],
    [-],
    [-],
    [-],

    [`PC4`],
    [16],
    [`C1-`],
    [`U4Rx`],
    [`U1Rx`],
    [-],
    [`M0PWM6`],
    [-],
    [`IDX1`],
    [`WT0CCP0`],
    [`U1RTS`],
    [-],
    [-],
    [-],

    [`PC5`],
    [15],
    [`C1+`],
    [`U4Tx`],
    [`U1Tx`],
    [-],
    [`M0PWM7`],
    [-],
    [`PhA1`],
    [`WT0CCP1`],
    [`U1CTS`],
    [-],
    [-],
    [-],

    [`PC6`],
    [14],
    [`C0+`],
    [`U3Rx`],
    [-],
    [-],
    [-],
    [-],
    [`PhB1`],
    [`WT1CCP0`],
    [`USB0EPEN`],
    [-],
    [-],
    [-],

    [`PC7`],
    [13],
    [`C0-`],
    [`U3Tx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`WT1CCP1`],
    [`USB0PFLT`],
    [-],
    [-],
    [-],

    [`PD0`],
    [61],
    [`AIN7`],
    [`SSI3Clk`],
    [`SSI1Clk`],
    [`I2C3SCL`],
    [`M0PWM6`],
    [`M1PWM0`],
    [-],
    [`WT2CCP0`],
    [-],
    [-],
    [-],
    [-],

    [`PD1`],
    [62],
    [`AIN6`],
    [`SSI3Fss`],
    [`SSI1Fss`],
    [`I2C3SDA`],
    [`M0PWM7`],
    [`M1PWM1`],
    [-],
    [`WT2CCP1`],
    [-],
    [-],
    [-],
    [-],

    [`PD2`],
    [63],
    [`AIN5`],
    [`SSI3Rx`],
    [`SSI1Rx`],
    [-],
    [`M0FAULT0`],
    [-],
    [-],
    [`WT3CCP0`],
    [`USB0EPEN`],
    [-],
    [-],
    [-],

    [`PD3`],
    [64],
    [`AIN4`],
    [`SSI3Tx`],
    [`SSI1Tx`],
    [-],
    [-],
    [-],
    [`IDX0`],
    [`WT3CCP1`],
    [`USB0PFLT`],
    [-],
    [-],
    [-],

    [`PD4`],
    [43],
    [`USB0DM`],
    [`U6Rx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`WT4CCP0`],
    [-],
    [-],
    [-],
    [-],

    [`PD5`],
    [44],
    [`USB0DP`],
    [`U6Tx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`WT4CCP1`],
    [-],
    [-],
    [-],
    [-],

    [`PD6`],
    [53],
    [-],
    [`U2Rx`],
    [-],
    [-],
    [`M0FAULT0`],
    [-],
    [`PhA0`],
    [`WT5CCP0`],
    [-],
    [-],
    [-],
    [-],

    [`PD7`],
    [10],
    [-],
    [`U2Tx`],
    [-],
    [-],
    [-],
    [-],
    [`PhB0`],
    [`WT5CCP1`],
    [`NMI`],
    [-],
    [-],
    [-],

    [`PE0`],
    [9],
    [`AIN3`],
    [`U7Rx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PE1`],
    [8],
    [`AIN2`],
    [`U7Tx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PE2`],
    [7],
    [`AIN1`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PE3`],
    [6],
    [`AIN0`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PE4`],
    [59],
    [`AIN9`],
    [`U5Rx`],
    [-],
    [`I2CSCL`],
    [`M0PWM4`],
    [`M1PWM2`],
    [-],
    [-],
    [`CAN0Rx`],
    [-],
    [-],
    [-],

    [`PE5`],
    [60],
    [`AIN8`],
    [`U5Tx`],
    [-],
    [`I2CSDA`],
    [`M0PWM5`],
    [`M1PWM3`],
    [-],
    [-],
    [`CAN0Tx`],
    [-],
    [-],
    [-],

    [`PF0`],
    [28],
    [-],
    [`U1RTS`],
    [`SSI1Rx`],
    [`CAN0Rx`],
    [-],
    [`M1PWM4`],
    [`PhA0`],
    [`T0CCP0`],
    [`NMI`],
    [`C0o`],
    [-],
    [-],

    [`PF1`],
    [29],
    [-],
    [`U1CTS`],
    [`SSI1Tx`],
    [-],
    [-],
    [`M1PWM5`],
    [`PhB0`],
    [`T0CCP1`],
    [-],
    [`C1o`],
    [`TRD1`],
    [-],

    [`PF2`],
    [30],
    [-],
    [-],
    [`SSI1Clk`],
    [-],
    [`M0FAULT0`],
    [`M1PWM6`],
    [-],
    [`T1CCP0`],
    [-],
    [-],
    [`TRD0`],
    [-],

    [`PF3`],
    [31],
    [-],
    [-],
    [`SSI1Fss`],
    [`CAN0Tx`],
    [-],
    [`M1PWM7`],
    [-],
    [`T1CCP1`],
    [-],
    [-],
    [`TRDCLK`],
    [-],

    [`PF4`],
    [5],
    [-],
    [-],
    [-],
    [-],
    [-],
    [`M1FAULT0`],
    [`IDX0`],
    [`T2CCP0`],
    [`USB0EPEN`],
    [-],
    [-],
    [-],
)))

#pagebreak()

== GPIO register map
<gpio-register-map>
#align(center, table(
    columns: 5,
    table.header([*Offset*], [*Name*], [*Type*], [*Reset*], [*Description*]),
    [`0x000`], [GPIODATA], [RW], [`0x0000.0000`], [GPIO Data],
    [`0x400`], [GPIODIR], [RW], [`0x0000.0000`], [GPIO Direction],
    [`0x404`], [GPIOIS], [RW], [`0x0000.0000`], [GPIO Interrupt Sense],
    [`0x408`], [GPIOIBE], [RW], [`0x0000.0000`], [GPIO Interrupt Both Edges],
    [`0x40C`], [GPIOIEV], [RW], [`0x0000.0000`], [GPIO Interrupt Event],
    [`0x410`], [GPIOIM], [RW], [`0x0000.0000`], [GPIO Interrupt Mask],
    [`0x414`], [GPIORIS], [RO], [`0x0000.0000`], [GPIO Raw Interrupt Status],
    [`0x418`], [GPIOMIS], [RO], [`0x0000.0000`], [GPIO Masked Interrupt Status],
    [`0x41C`], [GPIOICR], [W1C], [`0x0000.0000`], [GPIO Interrupt Clear],
    [`0x420`], [GPIOAFSEL], [RW], [-], [GPIO Alternate Function Select],
    [`0x500`], [GPIODR2R], [RW], [`0x0000.00FF`], [GPIO 2-mA Drive Select],
    [`0x504`], [GPIODR4R], [RW], [`0x0000.0000`], [GPIO 4-mA Drive Select],
    [`0x508`], [GPIODR8R], [RW], [`0x0000.0000`], [GPIO 8-mA Drive Select],
    [`0x50C`], [GPIOODR], [RW], [`0x0000.0000`], [GPIO Open Drain Select],
    [`0x510`], [GPIOPUR], [RW], [-], [GPIO Pull-Up Select],
    [`0x514`], [GPIOPDR], [RW], [`0x0000.0000`], [GPIO Pull-Down Select],

    [`0x518`],
    [GPIOSLR],
    [RW],
    [`0x0000.0000`],
    [GPIO Slew Rate Control Select],

    [`0x51C`], [GPIODEN], [RW], [-], [GPIO Digital Enable],
    [`0x520`], [GPIOLOCK], [RW], [`0x0000.0001`], [GPIO Lock],
    [`0x524`], [GPIOCR], [-], [-], [GPIO Commit],
    [`0x528`], [GPIOAMSEL], [RW], [`0x0000.0000`], [GPIO Analogue Mode Select],
    [`0x52C`], [GPIOPCTL], [RW], [-], [GPIO Port Control],
    [`0x530`], [GPIOADCCTL], [RW], [`0x0000.0000`], [GPIO ADC Control],
    [`0x534`], [GPIODMACTL], [RW], [`0x0000.0000`], [GPIO DMA Control],

    [`0xFD0`],
    [GPIOPeriphID4],
    [RO],
    [`0x0000.0000`],
    [GPIO Peripheral Identification 4],

    [`0xFD4`],
    [GPIOPeriphID5],
    [RO],
    [`0x0000.0000`],
    [GPIO Peripheral Identification 5],

    [`0xFD8`],
    [GPIOPeriphID6],
    [RO],
    [`0x0000.0000`],
    [GPIO Peripheral Identification 6],

    [`0xFDC`],
    [GPIOPeriphID7],
    [RO],
    [`0x0000.0000`],
    [GPIO Peripheral Identification 7],

    [`0xFE0`],
    [GPIOPeriphID0],
    [RO],
    [`0x0000.0061`],
    [GPIO Peripheral Identification 0],

    [`0xFE4`],
    [GPIOPeriphID1],
    [RO],
    [`0x0000.0000`],
    [GPIO Peripheral Identification 1],

    [`0xFE8`],
    [GPIOPeriphID2],
    [RO],
    [`0x0000.0018`],
    [GPIO Peripheral Identification 2],

    [`0xFEC`],
    [GPIOPeriphID3],
    [RO],
    [`0x0000.0001`],
    [GPIO Peripheral Identification 3],

    [`0xFF0`],
    [GPIOPCellD0],
    [RO],
    [`0x0000.000D`],
    [GPIO PrimeCell Identification 0],

    [`0xFF4`],
    [GPIOPCellD1],
    [RO],
    [`0x0000.00F0`],
    [GPIO PrimeCell Identification 1],

    [`0xFF8`],
    [GPIOPCellD2],
    [RO],
    [`0x0000.0005`],
    [GPIO PrimeCell Identification 2],

    [`0xFFC`],
    [GPIOPCellD3],
    [RO],
    [`0x0000.00B1`],
    [GPIO PrimeCell Identification 3],
))

#pagebreak()

== Registers

=== General-Purpose Input/Output Run Mode Clock Gating Control (RCGCGPIO)
<rcgcgpio>
- Base: `0x400F.E000`
- Offset: `0x608`
- Type RW, reset `0x0000.0000`

#cimage("./images/rcgcgpio-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:6],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [5],
    [R5],
    [RW],
    [0],
    [
        GPIO Port F Run Mode Clock Gating Control
        #table(
            align: left,
            columns: 2,
            stroke: none,
            table.header("Value", "Description"),
            [0], [GPIO Port F is disabled.],
            [1], [Enable and provide a clock to GPIO Port F in Run mode.],
        )
    ],

    [4],
    [R4],
    [RW],
    [0],
    [
        GPIO Port E Run Mode Clock Gating Control
        #table(
            align: left,
            columns: 2,
            stroke: none,
            table.header("Value", "Description"),
            [0], [GPIO Port E is disabled.],
            [1], [Enable and provide a clock to GPIO Port E in Run mode.],
        )
    ],

    [3],
    [R3],
    [RW],
    [0],
    [
        GPIO Port D Run Mode Clock Gating Control
        #table(
            align: left,
            columns: 2,
            stroke: none,
            table.header("Value", "Description"),
            [0], [GPIO Port D is disabled.],
            [1], [Enable and provide a clock to GPIO Port D in Run mode.],
        )
    ],

    [2],
    [R2],
    [RW],
    [0],
    [
        GPIO Port C Run Mode Clock Gating Control
        #table(
            align: left,
            columns: 2,
            stroke: none,
            table.header("Value", "Description"),
            [0], [GPIO Port C is disabled.],
            [1], [Enable and provide a clock to GPIO Port C in Run mode.],
        )

        #v(10em)
    ],

    [1],
    [R1],
    [RW],
    [0],
    [
        GPIO Port B Run Mode Clock Gating Control
        #table(
            align: left,
            columns: 2,
            stroke: none,
            table.header("Value", "Description"),
            [0], [GPIO Port B is disabled.],
            [1], [Enable and provide a clock to GPIO Port B in Run mode.],
        )
    ],

    [0],
    [R0],
    [RW],
    [0],
    [
        GPIO Port A Run Mode Clock Gating Control
        #table(
            align: left,
            columns: 2,
            stroke: none,
            table.header("Value", "Description"),
            [0], [GPIO Port A is disabled.],
            [1], [Enable and provide a clock to GPIO Port A in Run mode.],
        )
    ],
))

#pagebreak()

=== GPIO Digital Enable (GPIODEN)
<gpioden>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x51C`
- Type RW, reset `-`

#cimage("./images/gpioden-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [DEN],
    [RW],
    [–],
    [
        Digital Enable
        #table(
            align: left,
            columns: 2,
            table.header("Value", "Description"),

            [0],
            [The digital functions for the corresponding pin are disabled.],

            [1], [The digital functions for the corresponding pin are enabled.],

            [`0x0000.0000`],
            [
                The reset value for this register is `0x0000.0000` for GPIO
                ports that are not listed in
                @gpio-pins-with-special-considerations.
            ],
        )
    ],
))

#pagebreak()

=== GPIO Direction (GPIODIR)
<gpiodir>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x400`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpiodir-register.png")

#align(center, table(

    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [DIR],
    [RW],
    [`0x00`],
    [
        GPIO Data Direction
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header("Value", "Description"),
            [0], [Corresponding pin is an input.],
            [1], [Corresponding pin is an output.],
        )
    ],
))

#pagebreak()

=== GPIO Interrupt Sense (GPIOIS)
<gpiois>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x404`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpiois-register.png")

#align(center, table(
    columns: 5,
    align: left,
    [*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*],

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [IS],
    [RW],
    [`0x00`],
    [
        GPIO Interrupt Sense
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header("Value", "Description"),
            [0],
            [The edge on the corresponding pin is detected (edge-sensitive).],

            [1],
            [The level on the corresponding pin is detected (level-sensitive).],
        )
    ],
))

#link(<gpiois>)[GPIOIS] and #link(<gpioiev>)[GPIOIEV] must be used together.

#pagebreak()

=== GPIO Interrupt Event (GPIOIEV)
<gpioiev>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x40C`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpioiev-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [IEV],
    [RW],
    [`0x00`],
    [GPIO Interrupt Event
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header("Value", "Description"),
            [0],
            [
                A falling edge or a Low level on the corresponding pin triggers
                an interrupt.
            ],

            [1],
            [
                A rising edge or a High level on the corresponding pin triggers
                an interrupt.
            ],
        )
    ],
))

#link(<gpiois>)[GPIOIS] and #link(<gpioiev>)[GPIOIEV] must be used together.

#pagebreak()

=== GPIO Interrupt Both Edges (GPIOIBE)
<gpioibe>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x408`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpioibe-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.],

    [7:0],
    [IBE],
    [RW],
    [`0x00`],
    [
        GPIO Interrupt Both Edges
        #table(
            columns: 2,
            align: left,
            stroke: none,
            [Value], [Description],

            [0],
            [
                Interrupt generation is controlled by the #link(
                    <gpioiev>,
                )[*GPIO Interrupt Event (GPIOIEV)*] register.
            ],

            [1], [Both edges on the corresponding pin trigger an interrupt.],
        )
    ],
))

#pagebreak()

=== GPIO Interrupt Mask (GPIOIM)
<gpioim>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x410`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpioim-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [IME],
    [RW],
    [`0x00`],
    [
        GPIO Interrupt Mask Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header("Value", "Description"),

            [0], [The interrupt from the corresponding pin is masked.],
            [1],
            [The interrupt from the corresponding pin is sent to the interrupt
                controller.],
        )
    ],
))

#pagebreak()

=== GPIO 2-mA Drive Select (GPIODR2R)
<gpiodr2r>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x500`
- Type RW, reset `0x0000.00FF`

#cimage("./images/gpiodr2r-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.],

    [7:0],
    [DRV2],
    [RW],
    [`0xFF`],
    [
        Output Pad 2-mA Drive Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header("Value", "Description"),

            [0],
            [
                The drive for the corresponding GPIO pin is controlled by the
                #link(<gpiodr4r>)[*GPIODR4R*] or #link(
                    <gpiodr8r>,
                )[*GPIODR8R*] register.
            ],

            [1], [The corresponding GPIO pin has 2-mA drive.],
        )

        Setting a bit in either the #link(<gpiodr4r>)[*GPIODR4R*] register or
        the #link(<gpiodr8r>)[*GPIODR8R*] register clears the corresponding 2-mA
        enable bit. The change is effective on the second clock cycle after the
        write if accessing GPIO via the APB memory aperture. If using AHB
        access, the change is effective on the next clock cycle.
    ],
))

#pagebreak()

=== GPIO 4-mA Drive Select (GPIODR4R)
<gpiodr4r>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x504`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpiodr4r-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [DRV4],
    [RW],
    [`0x00`],
    [
        Output Pad 4-mA Drive Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The drive for the corresponding GPIO pin is controlled by the
                #link(<gpiodr2r>)[*GPIODR2R*] or #link(
                    <gpiodr8r>,
                )[*GPIODR8R*] register.
            ],

            [1], [The corresponding GPIO pin has 4-mA drive.],
        )

        Setting a bit in either the #link(<gpiodr2r>)[*GPIODR2R*] register or
        the #link(<gpiodr8r>)[*GPIODR8R*] register clears the corresponding 4-mA
        enable bit. The change is effective on the second clock cycle after the
        write if accessing GPIO via the APB memory aperture. If using AHB
        access, the change is effective on the next clock cycle.
    ],
))

#pagebreak()

=== GPIO 8-mA Drive Select (GPIODR8R)
<gpiodr8r>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x508`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpiodr8r-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [DRV8],
    [RW],
    [`0x00`],
    [
        Output Pad 8-mA Drive Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The drive for the corresponding GPIO pin is controlled by the
                #link(<gpiodr2r>)[*GPIODR2R*] or #link(
                    <gpiodr4r>,
                )[*GPIODR4R*] register.
            ],

            [1], [The corresponding GPIO pin has 8-mA drive.],
        )

        Setting a bit in either the #link(<gpiodr2r>)[*GPIODR2R*] register or
        the #link(<gpiodr4r>)[*GPIODR4R*] register clears the corresponding 4-mA
        enable bit. The change is effective on the second clock cycle after the
        write if accessing GPIO via the APB memory aperture. If using AHB
        access, the change is effective on the next clock cycle.
    ],
))

#pagebreak()

=== GPIO Open Drain Select (GPIOODR)
<gpioodr>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x50C`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpioodr-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [ODE],
    [RW],
    [`0x00`],
    [
        Output Pad Open Drain Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The corresponding pin is not configured as open drain.],

            [1], [The corresponding pin is configured as open drain.],
        )
    ],
))

#pagebreak()

=== GPIO Pull-Up Select (GPIOPUR)
<gpiopur>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x510`
- Type RW, reset -

#cimage("./images/gpiopur-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [

        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

    ],

    [7:0],
    [PUE],
    [RW],
    [-],
    [
        Pad Weak Pull-Up Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The corresponding pin's weak pull-up resistor is disabled.],

            [1], [The corresponding pin's weak pull-up resistor is enabled.],
        )

        Setting a bit in the #link(<gpiopdr>)[*GPIOPDR*] register clears the
        corresponding bit in the #link(
            <gpiopur>,
        )[*GPIOPUR*] register. The change is effective on the second clock cycle
        after the write if accessing GPIO via the APB memory aperture. If using
        AHB access, the change is effective on the next clock cycle.

        The reset value for this register is `0x0000.0000` for GPIO ports that
        are not listed in @gpio-pins-with-special-considerations.
    ],
))

#pagebreak()

=== GPIO Pull-Down Select (GPIOPDR)
<gpiopdr>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x514`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpiopdr-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [PDE],
    [RW],
    [`0x00`],
    [
        Pad Weak Pull-Down Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The corresponding pin's weak pull-down resistor is disabled.],

            [1], [The corresponding pin's weak pull-down resistor is enabled.],
        )

        Setting a bit in the #link(<gpiopur>)[*GPIOPUR*] register clears the
        corresponding bit in the #link(
            <gpiopdr>,
        )[*GPIOPDR*] register. The change is effective on the second clock cycle
        after the write if accessing GPIO via the APB memory aperture. If using
        AHB access, the change is effective on the next clock cycle.
    ],
))

#pagebreak()

=== GPIO Pins with special considerations
<gpio-pins-with-special-considerations>
#align(center, pad(x: -2em, table(
    columns: 8,
    align: left,

    table.header(
        [*GPIO Pins*],
        [*Default Reset State*],
        [*GPIOAFSEL*],
        [*GPIODEN*],
        [*GPIOPDR*],
        [*GPIOPUR*],
        [*GPIOPCTL*],
        [*GPIOCR*],
    ),

    // Data Rows
    [PA[1:0]], [UART0], [0], [0], [0], [0], [`0x1`], [1],
    [PA[5:2]], [SSI0], [0], [0], [0], [0], [`0x2`], [1],
    [PB[3:2]], [I#super[21]C0], [0], [0], [0], [0], [`0x3`], [1],
    [PC[3:0]], [JTAG/SWD], [1], [1], [0], [1], [`0x1`], [0],
    [PD[7]], [GPIO#super[a]], [0], [0], [0], [0], [`0x0`], [0],
    [PF[0]], [GPIO#super[a]], [0], [0], [0], [0], [`0x0`], [0],
)))

a. This pin is configured as a GPIO by default but is locked and can only be
reprogrammed by unlocking the pin in the #link(<gpiolock>)[*GPIOLOCK*] register
and uncommitting it by setting the #link(<gpiocr>)[*GPIOCR*] register.

#pagebreak()

=== GPIO Alternate Function Select (GPIOAFSEL)
<gpioafsel>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x420`
- Type RW, reset -

#cimage("./images/gpioafsel-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [AFSEL],
    [RW],
    [-],
    [
        GPIO Alternate Function Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The associated pin functions as a GPIO and is controlled by the
                GPIO registers.
            ],

            [1],
            [
                The associated pin functions as a peripheral signal and is
                controlled by the alternate hardware function.
            ],
        )

        The reset value for this register is `0x0000.0000` for GPIO ports that
        are not listed in @gpio-pins-with-special-considerations.
    ],
))

#pagebreak()

=== GPIO Lock (GPIOLOCK)
<gpiolock>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x520`
- Type RW, reset `0x0000.0001`

#cimage("./images/gpio-lock-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [LOCK],
    [RW],
    [`0x0000.0001`],
    [
        GPIO Lock

        A write of the value `0x4C4F.434B` unlocks the #link(
            <gpiocr>,
        )[*GPIO Commit (GPIOCR)*] register for write access. A write of any
        other value or a write to the #link(<gpiocr>)[*GPIOCR*] register
        reapplies the lock, preventing any register updates.

        A read of this register returns the following values:
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x1`],
            [
                The #link(<gpiocr>)[*GPIOCR*] register is locked and may not be
                modified.
            ],

            [`0x0`],
            [
                The #link(<gpiocr>)[*GPIOCR*] register is unlocked and may be
                modified.
            ],
        )
    ],
))

#pagebreak()

=== GPIO Commit (GPIOCR)
<gpiocr>

The value of the #link(<gpiocr>)[*GPIOCR*] register determines which bits of the
#link(<gpioafsel>)[*GPIOAFSEL*], #link(<gpiopur>)[*GPIOPUR*], #link(
    <gpiopdr>,
)[*GPIOPDR*], and #link(<gpioden>)[*GPIODEN*] registers are committed when a
write to these registers is performed.

- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x524`
- Type -, reset -

#cimage("./images/gpiocr-register.png")
#pagebreak()

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [7:0],
    [CR],
    [-],
    [-],
    [
        GPIO Commit
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The corresponding #link(<gpioafsel>)[*GPIOAFSEL*], #link(
                    <gpiopur>,
                )[*GPIOPUR*], #link(<gpiopur>)[*GPIOPDR*], or #link(
                    <gpiopur>,
                )[*GPIODEN*] bits cannot be written.
            ],

            [1],
            [
                The corresponding #link(<gpiopur>)[*GPIOAFSEL*], #link(
                    <gpiopur>,
                )[*GPIOPUR*], #link(<gpiopur>)[*GPIOPDR*], or #link(
                    <gpiopur>,
                )[*GPIODEN*] bits can be written.
            ],
        )

        *Note*:

        The default register type for the #link(<gpiocr>)[*GPIOCR*] register is
        RO for all GPIO pins with the exception of the `NMI` pin and the four
        JTAG/SWD pins. These six pins are the only GPIOs that are protected by
        the #link(<gpiocr>)[*GPIOCR*] register. Because of this, the register
        type for the corresponding GPIO Ports is RW.

        The default reset value for the #link(<gpiocr>)[*GPIOCR*] register is
        `0x0000.00FF` for all GPIO pins, with the exception of the `NMI` and
        JTAG/SWD pins . To ensure that the JTAG and `NMI` pins are not
        accidentally programmed as GPIO pins, these pins default to
        non-committable. Because of this, the default reset value of #link(
            <gpiocr>,
        )[*GPIOCR*] changes for the corresponding ports.

    ],
))

#pagebreak()

=== GPIO Analog Mode Select (GPIOAMSEL)
<gpioamsel>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x528`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpioamsel-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [GPIOAMSEL],
    [RW],
    [`0x00`],
    [
        GPIO Analog Mode Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The analog function of the pin is disabled, the isolation is
                enabled, and the pin is capable of digital functions as
                specified by the other GPIO configuration registers.
            ],

            [1],
            [
                The analog function of the pin is enabled, the isolation is
                disabled, and the pin is capable of analog functions.
            ],
        )

        *Note:* This register and bits are only valid for GPIO signals that
        share analog function through a unified I/O pad.

        The reset state of this register is 0 for all signals.
    ],
))

#pagebreak()

=== GPIO Data (GPIODATA)
<gpiodata>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x000`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpiodata-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [DATA],
    [RW],
    [`0x00`],
    [
        GPIO Data

        This register is virtually mapped to 256 locations in the address space.
        To facilitate the reading and writing of data to these registers by
        independent drivers, the data read from and written to the registers are
        masked by the eight address lines [9:2]. Reads from this register return
        its current state. Writes to this register only affect bits that are not
        masked by ADDR[9:2] and are configured as outputs.
    ],
))

#cimage("./images/gpiodata-examples.png", width: 99%)

==== GPIO write example
During a write, if the address bit associated with that data bit is set, the
value of the #link(<gpiodata>)[*GPIODATA*] register is altered. If the address
bit is cleared, the data bit is left unchanged.

For example, writing a value of `0xEB` to the address
$#link(<gpiodata>)[*GPIODATA*] + #text[`0x098`]$ has the results shown below,
where `u` indicates that data which are not changed by the write operation. The
example below shows #link(<gpiodata>)[*GPIODATA*] bits 5, 2, and 1 being
written.

#cimage("./images/gpiodata-write-example.png")

==== GPIO read example
During a read, if the address bit associated with the data bit is set, the value
is read. If the address bit associated with the data bit is cleared, the data
bit is read as a zero, regardless of its actual value. For example, reading
address $#link(<gpiodata>)[*GPIODATA*] + #text[`0x0C4`]$ yields the value shown
below. The example below shows how to read #link(<gpiodata>)[*GPIODATA*] bits 5,
4, and 0.

#cimage("./images/gpiodata-read-example.png")
#pagebreak()

=== GPIO Raw Interrupt Status (GPIORIS)
<gpioris>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x414`
- Type RO, reset `0x0000.0000`

#cimage("./images/gpioris-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [RIS],
    [RO],
    [`0x00`],
    [
        GPIO Interrupt Raw Status
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [An interrupt condition has not occurred on the corresponding pin.],

            [1],
            [An interrupt condition has occurred on the corresponding pin.],
        )

        For edge-detect interrupts, this bit is cleared by writing a 1 to the
        corresponding bit in the #link(<gpioicr>)[*GPIOICR*] register.

        For a GPIO level-detect interrupt, the bit is cleared when the level is
        de-asserted.
    ],
))

#pagebreak()

=== GPIO Masked Interrupt Status (GPIOMIS)
<gpiomis>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x418`
- Type RO, reset `0x0000.0000`

#cimage("./images/gpiomis-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [MIS],
    [RO],
    [`0x00`],
    [
        GPIO Masked Interrupt Status
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                An interrupt condition on the corresponding pin is masked or has
                not occurred.
            ],

            [1],
            [
                An interrupt condition on the corresponding pin has triggered an
                interrupt to the interrupt controller.
            ],
        )

        For edge-detect interrupts, this bit is cleared by writing a 1 to the
        corresponding bit in the #link(<gpioicr>)[*GPIOICR*] register.

        For a GPIO level-detect interrupt, the bit is cleared when the level is
        de-asserted.
    ],
))

#pagebreak()

=== GPIO Interrupt Clear (GPIOICR)
<gpioicr>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x41C`
- Type W1C, reset `0x0000.0000`

#cimage("./images/gpioicr-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [IC],
    [W1C],
    [`0x00`],
    [
        GPIO Interrupt Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The corresponding interrupt is unaffected.],

            [1], [The corresponding interrupt is cleared.],
        )
    ],
))

#pagebreak()

=== GPIO Port Control (GPIOPCTL)
<gpiopctl>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x52C`
- Type RW, reset -

#cimage("./images/gpiopctl-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:28],
    [PMC7],
    [RW],
    [-],
    [
        Port Mux Control 7

        This field controls the configuration for GPIO pin 7.
    ],

    [27:24],
    [PMC6],
    [RW],
    [-],
    [
        Port Mux Control 6

        This field controls the configuration for GPIO pin 6.
    ],

    [23:20],
    [PMC5],
    [RW],
    [-],
    [
        Port Mux Control 5

        This field controls the configuration for GPIO pin 5.
    ],

    // Row 4
    [19:16],
    [PMC4],
    [RW],
    [-],
    [
        Port Mux Control 4

        This field controls the configuration for GPIO pin 4.
    ],

    [15:12],
    [PMC3],
    [RW],
    [-],
    [
        Port Mux Control 3

        This field controls the configuration for GPIO pin 3.
    ],

    // Row 6
    [11:8],
    [PMC2],
    [RW],
    [-],
    [
        Port Mux Control 2

        This field controls the configuration for GPIO pin 2.
    ],

    [7:4],
    [PMC1],
    [RW],
    [-],
    [
        Port Mux Control 1

        This field controls the configuration for GPIO pin 1.
    ],

    // Row 8
    [3:0],
    [PMC0],
    [RW],
    [-],
    [
        Port Mux Control 0

        This field controls the configuration for GPIO pin 0.
    ],
))

#pagebreak()

=== GPIO ADC Control (GPIOADCCTL)
<gpioadcctl>
- GPIO Port A (APB) base: `0x4000.4000`
- GPIO Port A (AHB) base: `0x4005.8000`
- GPIO Port B (APB) base: `0x4000.5000`
- GPIO Port B (AHB) base: `0x4005.9000`
- GPIO Port C (APB) base: `0x4000.6000`
- GPIO Port C (AHB) base: `0x4005.A000`
- GPIO Port D (APB) base: `0x4000.7000`
- GPIO Port D (AHB) base: `0x4005.B000`
- GPIO Port E (APB) base: `0x4002.4000`
- GPIO Port E (AHB) base: `0x4005.C000`
- GPIO Port F (APB) base: `0x4002.5000`
- GPIO Port F (AHB) base: `0x4005.D000`
- Offset `0x530`
- Type RW, reset `0x0000.0000`

#cimage("./images/gpioadcctl-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [ADCEN],
    [RW],
    [`0x00`],
    [
        ADC Trigger Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The corresponding pin is not used to trigger the ADC.],

            [1], [The corresponding pin is used to trigger the ADC.],
        )
    ],
))

#pagebreak()

== Initialisation
+ Enable the clock for the port using the #link(<rcgcgpio>)[*RCGCGPIO*]
    register.
+ Enable or disable analogue functionality using the #link(
        <gpioamsel>,
    )[*GPIOAMSEL*] register.
+ Configure the pins as GPIO or non-GPIO using the #link(<gpiopctl>)[*GPIOPCTL*]
    register.
+ Set the pin's direction, like input or output using the #link(
        <gpiodir>,
    )[*GPIODIR*] register.
+ Enable (1) or disable (0) the alternate function using the #link(
        <gpioafsel>,
    )[*GPIOAFSEL*] register.
+ Enable (1) or disable (0) pull-up resistors if needed using the #link(
        <gpiopur>,
    )[*GPIOPUR*] register.
+ Enable (1) or disable (0) the digital ports using the #link(
        <gpioden>,
    )[*GPIODEN*] register.

=== Example
```asm
GPIO_PORTA_DATA_R       EQU 0x400043FC
GPIO_PORTA_DIR_R        EQU 0x40004400
GPIO_PORTA_AFSEL        EQU 0x40004420
GPIO_PORTA_PUR_R        EQU 0x40004510
GPIO_PORTA_DEN_R        EQU 0x4000451C
GPIO_PORTA_AMSEL_R      EQU 0x40004528
GPIO_PORTA_PCTL_R       EQU 0x4000452C
PA_4567                 EQU 0x400043C0	; Port A bits 4-7

SYSCTL_RCGCGPIO_R       EQU 0x400FE608

; Initialize Port A
; Enable digital I/O, ensure alternate functions are off.

; Activate clock for Port A
		LDR R1, =SYSCTL_RCGCGPIO_R
		LDR R0, [R1]
		ORR R0, R0, #0x01       ; Turn on GPIO Port A clock
		STR R0, [R1]
		NOP                     ; Allow time for clock to finish
		NOP
		NOP

; Disable analogue functionality
; 1 for enable, 0 for disable
		LDR R1, =GPIO_PORTA_AMSEL_R
		LDR R0, [R1]
		BIC R0, R0, #0xF0       ; disable analogue mode on Port A bits 4-7
		STR R0, [R1]

; Configure as GPIO
; 0 for GPIO, and 1 for non-GPIO
		LDR R1, =GPIO_PORTA_PCTL_R
		LDR R0, [R1]
		BIC R0, R0,#0x00FF0000  ; clear Port A bits 4 & 5
		BIC R0, R0,#0xFF000000  ; clear Port A bits 6 & 7
		STR R0, [R1]

; Set the direction (input or output)
; 1 for output, and 0 for input
		LDR R1, =GPIO_PORTA_DIR_R
		LDR R0, [R1]
		BIC R0, R0, #0xF0       ; set Port A bits 4-7 as input
		STR R0, [R1]

; Disable alternate function
; 1 for enable, and 0 for disable
		LDR R1, =GPIO_PORTA_AFSEL_R
		LDR R0, [R1]
		BIC R0, R0, #0xF0       ; Disable alternate function on Port A bits 4-7
		STR R0, [R1]

; Enable pull-up resistors on switch pins (optional)
; 1 for enable, and 0 for disable
		LDR R1, =GPIO_PORTA_PUR_R
		LDR R0, [R1]
		ORR R0, R0, #0xF0       ; Enable pull-up resistors on Port A bits 4-7
		STR R0, [R1]

; Enable digital port
; 1 for enable, and 0 for disable
		LDR R1, =GPIO_PORTA_DEN_R
		LDR R0, [R1]
		ORR R0, R0, #0xF0       ; Enable digital I/O on Port A bits 4-7
		STR R0, [R1]
```

== Quick reference
#link(<rcgcgpio>)[*RCGCGPIO*] register (`0x400F.E608`):
- Write a 1 to the binary value below to enable the port.
    ```
    Port:   --FE DCBA
    Binary: 0000 0000
    ```

Base addresses:
- GPIO Port A: `0x4000.4000`
- GPIO Port B: `0x4000.5000`
- GPIO Port C: `0x4000.6000`
- GPIO Port D: `0x4000.7000`
- GPIO Port E: `0x4002.4000`
- GPIO Port F: `0x4002.5000`

Offsets:
- #link(<gpiodata>)[*GPIODATA*]: `0x0000.03FC`
- #link(<gpiodir>)[*GPIODIR*]: `0x0000.0400`
- #link(<gpioafsel>)[*GPIOAFSEL*]: `0x0000.0420`
- #link(<gpiopur>)[*GPIOPUR*]: `0x0000.0510`
- #link(<gpioden>)[*GPIODEN*]: `0x0000.051C`
- #link(<gpioamsel>)[*GPIOAMSEL*]: `0x000.00528`
- #link(<gpiopctl>)[*GPIOPCTL*]: `0x0000.052C`

#link(<gpiodata>)[*GPIODATA*] bit layout for reading and writing:
```
Port:   --76 5432 10--
Binary: 0000 0000 0000
```

#pagebreak()

= TM4C123GH6PM Cortex M4 analogue to digital converter (ADC)

== Functions
- The TM4C123GH6PM has two ADC modules sharing 12 input channels each with
    12-bit resolution, plus an internal temperature sensor.
- Each ADC module has 4 programmable sample sequencers allowing the sampling of
    multiple analogue input sources.
- Each sample sequencer provides fully programmable input source, trigger
    events, interrupt generation, and sequencer priority. Conversion values can
    be diverted to a digital comparator module. Each ADC module provides 8
    digital comparators.
- Each digital comparator evaluates the ADC conversion value against its two
    user-defined values to determine the operation range of the signal. The
    trigger source for ADC0 and ADC1 may be independent of the two ADC modules
    may operate from the same trigger source and operate on the same or
    different inputs.
- A phase shifter can delay the start of the sampling by a specified phase
    angle.

== Main features
The TM4C123GH6PM provides two ADC modules each having:
- 12 shared analogue input channels
- 12-bit precision analogue to digital converter
- On-chip internal temperature sensor
- Maximum sample rate of up to one million samples per second
- Four programmable sample conversion sequencers from 1 to 8 entries long, with
    corresponding conversion result FIFOs.
- Flexible trigger control, like controllers, timers, GPIO, analogue
    comparators, PWM.
- Hardware averaging of up to 64 samples.
- 8 digital comparators
- ADC clock runs at #qty[16][MHz]

== Implementation of 2 ADC blocks
#cimage("./images/two-adc-blocks-circuit.png")

== ADC module block diagram
#cimage("./images/adc-module-block-diagram.png")
#pagebreak()

== ADC signal pin names
<adc-signal-pin-names>
- The `AINx` signals are analogue functions for some GPIO signals.
- Pin or mux assignment is configured by clearing the DEN bit in #link(
        <gpioden>,
    )[*GPIODEN*] and setting the #link(<gpioamsel>)[*GPIOAMSEL*] register.

#align(center, table(
    columns: 6,
    align: left,

    table.header(
        [*Pin Name*],
        [*Pin Number*],
        [*Pin Mux / Pin Assignment*],
        [*Pin Type*],
        [*Buffer Type*],
        [*Description*],
    ),

    [`AIN0`], [6], [PE3], [I], [Analog], [Analog-to-digital converter input 0.],
    [`AIN1`], [7], [PE2], [I], [Analog], [Analog-to-digital converter input 1.],
    [`AIN2`], [8], [PE1], [I], [Analog], [Analog-to-digital converter input 2.],
    [`AIN3`], [9], [PE0], [I], [Analog], [Analog-to-digital converter input 3.],

    [`AIN4`],
    [64],
    [PD3],
    [I],
    [Analog],
    [Analog-to-digital converter input 4.],

    [`AIN5`],
    [63],
    [PD2],
    [I],
    [Analog],
    [Analog-to-digital converter input 5.],

    [`AIN6`],
    [62],
    [PD1],
    [I],
    [Analog],
    [Analog-to-digital converter input 6.],

    [`AIN7`],
    [61],
    [PD0],
    [I],
    [Analog],
    [Analog-to-digital converter input 7.],

    [`AIN8`],
    [60],
    [PE5],
    [I],
    [Analog],
    [Analog-to-digital converter input 8.],

    [`AIN9`],
    [59],
    [PE4],
    [I],
    [Analog],
    [Analog-to-digital converter input 9.],

    [`AIN10`],
    [58],
    [PB4],
    [I],
    [Analog],
    [Analog-to-digital converter input 10.],

    [`AIN11`],
    [57],
    [PB5],
    [I],
    [Analog],
    [Analog-to-digital converter input 11.],
))

#pagebreak()

== ADC register map
<adc-register-map>
#align(center, pad(x: -2em, table(
    columns: 5,
    align: left,

    table.header([*Offset*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [`0x000`], [ADCACTSS], [RW], [`0x0000.0000`], [ADC Active Sample Sequencer],
    [`0x004`], [ADCRIS], [RO], [`0x0000.0000`], [ADC Raw Interrupt Status],
    [`0x008`], [ADCIM], [RW], [`0x0000.0000`], [ADC Interrupt Mask],

    [`0x00C`],
    [ADCISC],
    [RW1C],
    [`0x0000.0000`],
    [ADC Interrupt Status and Clear],

    [`0x010`], [ADCOSTAT], [RW1C], [`0x0000.0000`], [ADC Overflow Status],
    [`0x014`], [ADCEMUX], [RW], [`0x0000.0000`], [ADC Event Multiplexer Select],
    [`0x018`], [ADCUSTAT], [RW1C], [`0x0000.0000`], [ADC Underflow Status],
    [`0x01C`], [ADCTSSEL], [RW], [`0x0000.0000`], [ADC Trigger Source Select],

    [`0x020`],
    [ADCSSPRI],
    [RW],
    [`0x0000.3210`],
    [ADC Sample Sequencer Priority],

    [`0x024`], [ADCSPC], [RW], [`0x0000.0000`], [ADC Sample Phase Control],
    [`0x028`], [ADCPSSI], [RW], [-], [ADC Processor Sample Sequence Initiate],
    [`0x030`], [ADCSAC], [RW], [`0x0000.0000`], [ADC Sample Averaging Control],

    [`0x034`],
    [ADCDICISC],
    [RW1C],
    [`0x0000.0000`],
    [ADC Digital Comparator Interrupt Status and Clear],

    [`0x038`], [ADCCTL], [RW], [`0x0000.0000`], [ADC Control],

    [`0x040`],
    [ADCSSMUX0],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence Input Multiplexer Select 0],

    [`0x044`],
    [ADCSCTL0],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence Control 0],

    [`0x048`], [ADCSSFIFO0], [RO], [-], [ADC Sample Sequence Result FIFO 0],

    [`0x04C`],
    [ADCSSFSTAT0],
    [RO],
    [`0x0000.0100`],
    [ADC Sample Sequence FIFO 0 Status],

    [`0x050`],
    [ADCSSOP0],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence 0 Operation],

    [`0x054`],
    [ADCSSDC0],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence 0 Digital Comparator Select],

    [`0x060`],
    [ADCSSMUX1],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence Input Multiplexer Select 1],

    [`0x064`],
    [ADCSCTL1],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence Control 1],

    [`0x068`], [ADCSSFIFO1], [RO], [-], [ADC Sample Sequence Result FIFO 1],
    [`0x06C`],
    [ADCSSFSTAT1],
    [RO],
    [`0x0000.0100`],
    [ADC Sample Sequence FIFO 1 Status],

    [`0x070`],
    [ADCSSOP1],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence 1 Operation],

    [`0x074`],
    [ADCSSDC1],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence 1 Digital Comparator Select],

    [`0x080`],
    [ADCSSMUX2],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence Input Multiplexer Select 2],

    [`0x084`],
    [ADCSCTL2],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence Control 2],

    [`0x088`], [ADCSSFIFO2], [RO], [-], [ADC Sample Sequence Result FIFO 2],

    [`0x08C`],
    [ADCSSFSTAT2],
    [RO],
    [`0x0000.0100`],
    [ADC Sample Sequence FIFO 2 Status],

    [`0x090`],
    [ADCSSOP2],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence 2 Operation],

    [`0x094`],
    [ADCSSDC2],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence 2 Digital Comparator Select],

    [`0x0A0`],
    [ADCSSMUX3],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence Input Multiplexer Select 3],

    [`0x0A4`],
    [ADCSCTL3],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence Control 3],

    [`0x0A8`], [ADCSSFIFO3], [RO], [-], [ADC Sample Sequence Result FIFO 3],

    [`0x0AC`],
    [ADCSSFSTAT3],
    [RO],
    [`0x0000.0100`],
    [ADC Sample Sequence FIFO 3 Status],

    [`0x0B0`],
    [ADCSSOP3],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence 3 Operation],

    [`0x0B4`],
    [ADCSSDC3],
    [RW],
    [`0x0000.0000`],
    [ADC Sample Sequence 3 Digital Comparator Select],

    [`0xD00`],
    [ADCDCRIC],
    [WO],
    [`0x0000.0000`],
    [ADC Digital Comparator Reset Initial Conditions],

    [`0xE00`],
    [ADCDCTL0],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Control 0],

    [`0xE04`],
    [ADCDCTL1],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Control 1],

    [`0xE08`],
    [ADCDCTL2],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Control 2],

    [`0xE0C`],
    [ADCDCTL3],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Control 3],

    [`0xE10`],
    [ADCDCTL4],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Control 4],

    [`0xE14`],
    [ADCDCTL5],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Control 5],

    [`0xE18`],
    [ADCDCTL6],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Control 6],

    [`0xE1C`],
    [ADCDCTL7],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Control 7],

    [`0xE40`],
    [ADCDCMP0],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Range 0],

    [`0xE44`],
    [ADCDCMP1],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Range 1],

    [`0xE48`],
    [ADCDCMP2],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Range 2],

    [`0xE4C`],
    [ADCDCMP3],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Range 3],

    [`0xE50`],
    [ADCDCMP4],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Range 4],

    [`0xE54`],
    [ADCDCMP5],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Range 5],

    [`0xE58`],
    [ADCDCMP6],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Range 6],

    [`0xE5C`],
    [ADCDCMP7],
    [RW],
    [`0x0000.0000`],
    [ADC Digital Comparator Range 7],

    [`0xF00`], [ADCPP], [RO], [`0x0080.20C7`], [ADC Peripheral Properties],
    [`0xF04`], [ADCPC], [RW], [`0x0000.0007`], [ADC Peripheral Configuration],
    [`0xF08`], [ADCCC], [RW], [`0x0000.0000`], [ADC Clock Configuration],
)))

== GPIOPCTL for ADC
#align(center, pad(x: -3em, table(
    columns: 14,
    align: center,

    table.header(
        table.cell(rowspan: 2)[*IO*],
        table.cell(rowspan: 2)[*Pin*],
        table.cell(rowspan: 2)[*Analog Function*],
        table.cell(colspan: 11)[
            *Digital Function (GPIOPCTL PMC #sym.times Bit Field Encoding)*
        ],

        [1],
        [2],
        [3],
        [4],
        [5],
        [6],
        [7],
        [8],
        [9],
        [14],
        [15],
    ),

    [`PB4`],
    [58],
    [`AIN10`],
    [-],
    [`SSI2Clk`],
    [-],
    [`M0PWM2`],
    [-],
    [-],
    [`T1CCP0`],
    [`CAN0Rx`],
    [-],
    [-],
    [-],

    [`PB5`],
    [57],
    [`AIN11`],
    [-],
    [`SSI2Fss`],
    [-],
    [`M0PWM3`],
    [-],
    [-],
    [`T1CCP1`],
    [`CAN0Tx`],
    [-],
    [-],
    [-],

    [`PD0`],
    [61],
    [`AIN7`],
    [`SSI3Clk`],
    [`SSI1Clk`],
    [`I2C3SCL`],
    [`M0PWM6`],
    [`M1PWM0`],
    [-],
    [`WT2CCP0`],
    [-],
    [-],
    [-],
    [-],

    [`PD1`],
    [62],
    [`AIN6`],
    [`SSI3Fss`],
    [`SSI1Fss`],
    [`I2C3SDA`],
    [`M0PWM7`],
    [`M1PWM1`],
    [-],
    [`WT2CCP1`],
    [-],
    [-],
    [-],
    [-],

    [`PD2`],
    [63],
    [`AIN5`],
    [`SSI3Rx`],
    [`SSI1Rx`],
    [-],
    [`M0FAULT0`],
    [-],
    [-],
    [`WT3CCP0`],
    [`USB0EPEN`],
    [-],
    [-],
    [-],

    [`PD3`],
    [64],
    [`AIN4`],
    [`SSI3Tx`],
    [`SSI1Tx`],
    [-],
    [-],
    [-],
    [`IDX0`],
    [`WT3CCP1`],
    [`USB0PFLT`],
    [-],
    [-],
    [-],

    [`PE0`],
    [9],
    [`AIN3`],
    [`U7Rx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PE1`],
    [8],
    [`AIN2`],
    [`U7Tx`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PE2`],
    [7],
    [`AIN1`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PE3`],
    [6],
    [`AIN0`],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],
    [-],

    [`PE4`],
    [59],
    [`AIN9`],
    [`U5Rx`],
    [-],
    [`I2C2SCL`],
    [`M0PWM4`],
    [`M1PWM2`],
    [-],
    [-],
    [`CAN0Rx`],
    [-],
    [-],
    [-],

    [`PE5`],
    [60],
    [`AIN8`],
    [`U5Tx`],
    [-],
    [`I2C2SDA`],
    [`M0PWM5`],
    [`M1PWM3`],
    [-],
    [-],
    [`CAN0Tx`],
    [-],
    [-],
    [-],
)))

#pagebreak()

== Functional description
- The TM4C123GH6PM ADC collects sample data by using a programmable
    sequence-based approach.
- Each sample sequence is a fully programmed series of consecutive
    (back-to-back) samples, allowing the ADC to collect data from multiple input
    sources without having to be re-configured or serviced by the processor.
- The programming of each sample in the sample sequence includes parameters such
    as the input source and mode (differential versus single-ended input),
    interrupt generation on sample completion, and the indicator for the last
    sample in the sequence.
- The sampling control and data capture is handled by the sample sequencers.
- For a given sample sequence, each sample is defined by bit fields in the
    #link(<adcssmux0>)[ADC Sample Sequence Input Multiplexer Select (ADCSSMUXn)]
    and #link(<adcssctl0>)[ADC Sample Sequence Control (ADCSSCTLn)] registers.

#pagebreak()

== Registers

=== ADC Peripheral Properties (ADCPP)
<adcpp>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0xFC0`
- Type RO, reset `0x00B0.20C7`

#cimage("./images/adcpp-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:24],
    [reserved],
    [RO],
    [`0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [23],
    [TS],
    [RO],
    [`0x1`],
    [
        Temperature Sensor
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The ADC module does not have a temperature sensor.],

            [1], [The ADC module has a temperature sensor.],
        )

        This field provides the similar information as the legacy *DC1* register
        `TEMPSNS` bit.
    ],

    [22:18],
    [RSL],
    [RO],
    [`0xC`],
    [
        Resolution

        This field specifies the maximum number of binary bits used to represent
        the converted sample. The field is encoded as a binary value, in the
        range of 0 to 32 bits.
    ],

    [17:16],
    [TYPE],
    [RO],
    [`0x0`],
    [
        ADC Architecture
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [SAR],

            [`0x1 - 0x3`], [Reserved],
        )
    ],

    [15:10],
    [DC],
    [RO],
    [`0x8`],
    [
        Digital Comparator Count

        This field specifies the number of ADC digital comparators available to
        the converter. The field is encoded as a binary value, in the range of 0
        to 63.

        This field provides similar information to the legacy *DC9* register
        `ADCnDCn` bits.

        #v(10em)
    ],

    [9:4],
    [CH],
    [RO],
    [`0xC`],
    [
        ADC Channel Count

        This field specifies the number of ADC input channels available to the
        converter. This field is encoded as a binary value, in the range of 0
        to 63.

        This field provides similar information to the legacy *DC3* and *DC8*
        register `ADCnAINn` bits.
    ],

    [3:0],
    [MSR],
    [RO],
    [`0x7`],
    [
        Maximum ADC Sample Rate

        This field specifies the maximum number of ADC conversions per second.
        The `MSR` field is encoded as follows:
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [Reserved],

            [`0x1`], [#qty[125][ksps]],

            [`0x2`], [Reserved],

            [`0x3`], [#qty[250][ksps]],

            [`0x4`], [Reserved],

            [`0x5`], [#qty[500][ksps]],

            [`0x6`], [Reserved],

            [`0x7`], [#qty[1][Msps]],

            [`0x8 - 0xF`], [Reserved],
        )
    ],
))

#pagebreak()

=== ADC Peripheral Configuration (ADCPC)
<adcpc>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0xFC4`
- Type RW, reset `0x0000.0007`

#cimage("./images/adcpc-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [`0x0000.0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3:0],
    [SR],
    [RW],
    [`0x7`],
    [
        ADC Sample Rate

        This field specifies the number of ADC conversions per second and is
        used in Run, Sleep, and Deep-Sleep modes. The field encoding is based on
        the legacy *RGCG0* register encoding. The programmed sample rate cannot
        exceed the maximum sample rate specified by the `MSR` field in the
        *ADCPP* register. The `SR` field is encoded as follows:
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [Reserved],

            [`0x1`], [#qty[125][ksps]],

            [`0x2`], [Reserved],

            [`0x3`], [#qty[250][ksps]],

            [`0x4`], [Reserved],

            [`0x5`], [#qty[500][ksps]],

            [`0x6`], [Reserved],

            [`0x7`], [#qty[1][Msps]],

            [`0x8 - 0xF`], [Reserved],
        )
    ],
))

#pagebreak()

=== Analogue-to-Digital Converter Run Mode Clock Gating Control (RCGCADC)
<rcgcadc>
- Base `0x400F.E000`
- Offset `0x638`
- Type RW, reset `0x0000.0000`

#cimage("./images/rcgcadc-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:2],
    [reserved],
    [RO],
    [`0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1],
    [R1],
    [RW],
    [`0`],
    [
        ADC Module 1 Run Mode Clock Gating Control
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [ADC module 1 is disabled.],

            [1], [Enable and provide a clock to ADC module 1 in Run mode.],
        )
    ],

    [0],
    [R0],
    [RW],
    [`0`],
    [
        ADC Module 0 Run Mode Clock Gating Control
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [ADC module 0 is disabled.],

            [1], [Enable and provide a clock to ADC module 0 in Run mode.],
        )
    ],
))

#pagebreak()

=== ADC Sample Sequencer Priority (ADCSSPRI)
<adcsspri>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x020`
- Type RW, reset `0x0000.3210`

#cimage("./images/adcsspri-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:14],
    [reserved],
    [RO],
    [`0x0000.0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [13:12],
    [SS3],
    [RW],
    [`0x3`],
    [
        SS3 Priority

        This field contains a binary-encoded value that specifies the priority
        encoding of Sample Sequencer 3. A priority encoding of `0x0` is highest
        and `0x3` is lowest. The priorities assigned to the sequencers must be
        uniquely mapped. The ADC may not operate properly if two or more fields
        are equal.
    ],

    [11:10],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [9:8],
    [SS2],
    [RW],
    [`0x2`],
    [
        SS2 Priority

        This field contains a binary-encoded value that specifies the priority
        encoding of Sample Sequencer 2. A priority encoding of `0x0` is highest
        and `0x3` is lowest. The priorities assigned to the sequencers must be
        uniquely mapped. The ADC may not operate properly if two or more fields
        are equal.
    ],

    [7:6],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [5:4],
    [SS1],
    [RW],
    [`0x1`],
    [
        SS1 Priority

        This field contains a binary-encoded value that specifies the priority
        encoding of Sample Sequencer 1. A priority encoding of `0x0` is highest
        and `0x3` is lowest. The priorities assigned to the sequencers must be
        uniquely mapped. The ADC may not operate properly if two or more fields
        are equal.
    ],

    [3:2],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1:0],
    [SS0],
    [RW],
    [`0x0`],
    [
        SS0 Priority

        This field contains a binary-encoded value that specifies the priority
        encoding of Sample Sequencer 0. A priority encoding of `0x0` is highest
        and `0x3` is lowest. The priorities assigned to the sequencers must be
        uniquely mapped. The ADC may not operate properly if two or more fields
        are equal.
    ],
))

#pagebreak()

=== ADC Control (ADCCTL)
<adcctl>
Note that the values set in this register apply to *all* ADC modules. It is not
possible to set one module to use internal references and another to use
external references.

- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x038`
- Type RW, reset `0x0000.0000`

#cimage("./images/adcctl-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:7],
    [reserved],
    [RO],
    [`0x0000.0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [6],
    [DITHER],
    [RW],
    [`0`],
    [
        Dither Mode Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Dither mode disabled],

            [1], [Dither mode enabled],
        )
    ],

    [5:1],
    [reserved],
    [RO],
    [`0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [0],
    [VREF],
    [RW],
    [`0x0`],
    [
        Voltage Reference Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`],
            [`VDDA` and `GNDA` are the voltage references for all ADC modules.],

            [`0x1`], [Reserved],
        )
    ],
))

#pagebreak()

=== ADC Sample Sequence Input Multiplexer Select 0 (ADCSSMUX0)
<adcssmux0>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x040`
- Type RW, reset `0x0000.0000`

#cimage("./images/adcssmux0-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:28],
    [MUX7],
    [RW],
    [`0x0`],
    [
        8th Sample Input Select

        The `MUX7` field is used during the eighth sample of a sequence executed
        with the sample sequencer. It specifies which of the analog inputs is
        sampled for the analog-to-digital conversion. The value set here
        indicates the corresponding pin, for example, a value of `0x1` indicates
        the input is `AIN1`.
    ],

    [27:24],
    [MUX6],
    [RW],
    [`0x0`],
    [
        7th Sample Input Select

        The `MUX6` field is used during the seventh sample of a sequence
        executed with the sample sequencer. It specifies which of the analog
        inputs is sampled for the analog-to-digital conversion.
    ],

    [23:20],
    [MUX5],
    [RW],
    [`0x0`],
    [
        6th Sample Input Select

        The `MUX5` field is used during the sixth sample of a sequence executed
        with the sample sequencer. It specifies which of the analog inputs is
        sampled for the analog-to-digital conversion.
    ],

    [19:16],
    [MUX4],
    [RW],
    [`0x0`],
    [
        5th Sample Input Select

        The `MUX4` field is used during the fifth sample of a sequence executed
        with the sample sequencer. It specifies which of the analog inputs is
        sampled for the analog-to-digital conversion.
    ],

    [15:12],
    [MUX3],
    [RW],
    [`0x0`],
    [
        4th Sample Input Select

        The `MUX3` field is used during the fourth sample of a sequence executed
        with the sample sequencer. It specifies which of the analog inputs is
        sampled for the analog-to-digital conversion.
    ],

    [11:8],
    [MUX2],
    [RW],
    [`0x0`],
    [
        3rd Sample Input Select

        The `MUX2` field is used during the third sample of a sequence executed
        with the sample sequencer. It specifies which of the analog inputs is
        sampled for the analog-to-digital conversion.

        #v(10em)
    ],

    [7:4],
    [MUX1],
    [RW],
    [`0x0`],
    [
        2nd Sample Input Select

        The `MUX1` field is used during the second sample of a sequence executed
        with the sample sequencer. It specifies which of the analog inputs is
        sampled for the analog-to-digital conversion.
    ],

    [3:0],
    [MUX0],
    [RW],
    [`0x0`],
    [
        1st Sample Input Select

        The `MUX0` field is used during the first sample of a sequence executed
        with the sample sequencer. It specifies which of the analog inputs is
        sampled for the analog-to-digital conversion.
    ],
))

#pagebreak()

=== ADC Sample Sequence Input Multiplexer Select n (ADCSSMUXn)
<adcssmuxn>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x060`
- Type RW, reset `0x0000.0000`

Registers:
- Register 27: ADC Sample Sequence Input Multiplexer Select 1 (ADCSSMUX1),
    offset `0x060`
- Register 28: ADC Sample Sequence Input Multiplexer Select 2 (ADCSSMUX2),
    offset `0x080`

#cimage("./images/adcssmuxn-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:12],
    [MUX3],
    [RW],
    [`0x0`],
    [
        4th Sample Input Select
    ],

    [11:8],
    [MUX2],
    [RW],
    [`0x0`],
    [
        3rd Sample Input Select
    ],

    [7:4],
    [MUX1],
    [RW],
    [`0x0`],
    [
        2nd Sample Input Select
    ],

    [3:0],
    [MUX0],
    [RW],
    [`0x0`],
    [
        1st Sample Input Select
    ],
))

#pagebreak()

=== ADC Event Multiplexer Select (ADCEMUX)
<adcemux>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x014`
- Type RW, reset `0x0000.0000`

#cimage("./images/adcemux-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:12],
    [EM3],
    [RW],
    [`0x0`],
    [
        SS3 Trigger Select

        This field selects the trigger source for Sample Sequencer 3.
    ],

    [11:8],
    [EM2],
    [RW],
    [`0x0`],
    [
        SS2 Trigger Select

        This field selects the trigger source for Sample Sequencer 2.
    ],

    [7:4],
    [EM1],
    [RW],
    [`0x0`],
    [
        SS1 Trigger Select

        This field selects the trigger source for Sample Sequencer 1.
    ],

    [3:0],
    [EM0],
    [RW],
    [`0x0`],
    [
        SS0 Trigger Select

        This field selects the trigger source for Sample Sequencer 0.
    ],
))

#pagebreak()

==== Valid configurations for the trigger select fields
#table(
    columns: 2,
    align: left,

    table.header([*Value*], [*Event*]),

    [`0x0`],
    [
        Processor (default)

        The trigger is initiated by setting the `SSn` bit in the *ADCPSSI*
        register.
    ],

    [`0x1`],
    [
        Analog Comparator 0

        This trigger is configured by the *Analog Comparator Control 0*
        (*ACCCTL0*) register.
    ],

    [`0x2`],
    [
        Analog Comparator 1

        This trigger is configured by the *Analog Comparator Control 1*
        (*ACCCTL1*) register.
    ],

    [`0x3`], [Reserved],

    [`0x4`],
    [
        External (GPIO Pins)

        This trigger is connected to the GPIO interrupt for the corresponding
        GPIO.

        *Note:* GPIOs that have `AINx` signals as alternate functions can be
        used to trigger the ADC. However, the pin cannot be used as both a GPIO
        and an analog input.
    ],

    [`0x5`],
    [
        Timer

        In addition, the trigger must be enabled with the `TnROTE` bit in the
        *GPTMCTL* register.
    ],

    [`0x6`],
    [
        PWM generator 0

        The PWM generator 0 trigger can be configured with the *PWM0 Interrupt
        and Trigger Enable* (*PWM0INTEN*) register.
    ],

    [`0x7`],
    [
        PWM generator 1

        The PWM generator 1 trigger can be configured with the *PWM1INTEN*
        register.
    ],

    [`0x8`],
    [
        PWM generator 2

        The PWM generator 2 trigger can be configured with the *PWM2INTEN*
        register.
    ],

    [`0x9`],
    [
        PWM generator 3

        The PWM generator 3 trigger can be configured with the *PWM3INTEN*
        register.
    ],

    [`0xA - 0xE`], [Reserved],

    [`0xF`], [Always (continuously sample)],
)

#pagebreak()

=== ADC Trigger Source Select (ADCTSSEL)
<adctssel>
- The Cortex M4 has two PWM modules.
- Each PWM module has 4 signal generators.

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x01C`
- Type RW, reset `0x0000.0000`

#cimage("./images/adctssel-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:30],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [29:28],
    [PS3],
    [RW],
    [`0x0`],
    [
        Generator 3 PWM Module Trigger Select

        This field selects in which PWM module the Generator 3 trigger is
        located.
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [Use Generator 3 (and its trigger) in PWM module 0],

            [`0x1`], [Use Generator 3 (and its trigger) in PWM module 1],

            [`0x2 - 0x3`], [Reserved],
        )
    ],

    [27:22],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [21:20],
    [PS2],
    [RW],
    [`0x0`],
    [
        Generator 2 PWM Module Trigger Select

        This field selects in which PWM module the Generator 2 trigger is
        located.
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [Use Generator 2 (and its trigger) in PWM module 0],

            [`0x1`], [Use Generator 2 (and its trigger) in PWM module 1],

            [`0x2 - 0x3`], [Reserved],
        )

        #v(10em)
    ],

    [19:14],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [13:12],
    [PS1],
    [RW],
    [`0x0`],
    [
        Generator 1 PWM Module Trigger Select

        This field selects in which PWM module the Generator 1 trigger is
        located.
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [Use Generator 1 (and its trigger) in PWM module 0],

            [`0x1`], [Use Generator 1 (and its trigger) in PWM module 1],

            [`0x2 - 0x3`], [Reserved],
        )
    ],

    [11:6],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [5:4],
    [PS0],
    [RW],
    [`0x0`],
    [
        Generator 0 PWM Module Trigger Select

        This field selects in which PWM module the Generator 0 trigger is
        located.
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [Use Generator 0 (and its trigger) in PWM module 0],

            [`0x1`], [Use Generator 0 (and its trigger) in PWM module 1],

            [`0x2 - 0x3`], [Reserved],
        )
    ],

    [3:0],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],
))

#pagebreak()

=== ADC Clock Configuration (ADCCC)
<adccc>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0xFC8`
- Type RW, reset `0x0000.0000`

#cimage("./images/adccc-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [`0x0000.0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3:0],
    [CS],
    [RW],
    [`0`],
    [
        ADC Clock Source

        The following table specifies the clock source that generates the ADC
        clock input, see Figure 5-5 on page 222.
        #table(
            columns: 2,
            align: left,

            table.header([Value], [Description]),

            [`0x0`],
            [
                Either the 16-MHz system clock (if the Phase Lock Loop [PLL]
                bypass is in effect) or the 16 MHz clock derived from PLL
                #sym.div 25 (default).

                Note that when the PLL is bypassed, the system clock must be at
                least 16 MHz.
            ],

            [`0x1`],
            [
                Precision Internal Oscillator (PIOSC)

                The PIOSC provides a 16-MHz clock source for the ADC. If the
                PIOSC is used as the clock source, the ADC module can continue
                to operate in Deep-Sleep mode.
            ],

            [`0x2 - 0xF`], [Reserved],
        )
    ],
))

#pagebreak()

=== ADC Sample Sequence Control 0 (ADCSSCTL0)
<adcssctl0>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x044`
- Type RW, reset `0x0000.0000`

#cimage("./images/adcssctl0-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31],
    [TS7],
    [RW],
    [`0`],
    [
        8th Sample Temp Sensor Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The input pin specified by the #link(<adcssmux0>)[*ADCSSMUXn*]
                register is read during the eighth sample of the sample
                sequence.
            ],

            [1],
            [
                The temperature sensor is read during the eighth sample of the
                sample sequence.
            ],
        )
    ],

    [30],
    [IE7],
    [RW],
    [`0`],
    [
        8th Sample Interrupt Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [
                The raw interrupt signal (`INR0`) bit is asserted at the end of
                the eighth sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.
            ],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [29],
    [END7],
    [RW],
    [`0`],
    [
        8th Sample is End of Sequence
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],

            [1], [The eighth sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence. Samples defined after
        the sample containing a set `ENDn` bit are not requested for conversion
        even though the fields may be non-zero.

        #v(10em)
    ],

    [28],
    [D7],
    [RW],
    [`0`],
    [
        8th Sample Differential Input Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],

            [1],
            [
                The analog input is differentially sampled. The corresponding
                #link(<adcssmux0>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".
            ],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS7` bit is set.
    ],

    [27],
    [TS6],
    [RW],
    [`0`],
    [
        7th Sample Temp Sensor Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The input pin specified by the #link(<adcssmux0>)[*ADCSSMUXn*]
                register is read during the seventh sample of the sample
                sequence.
            ],

            [1],
            [
                The temperature sensor is read during the seventh sample of the
                sample sequence.
            ],
        )
    ],

    [26],
    [IE6],
    [RW],
    [`0`],
    [
        7th Sample Interrupt Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [
                The raw interrupt signal (`INR0`) bit is asserted at the end of
                the seventh sample's conversion. If the `MASK0` bit in the
                #link(<adcim>)[*ADCIM*] register is set, the interrupt is
                promoted to the interrupt controller.
            ],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [25],
    [END6],
    [RW],
    [`0`],
    [
        7th Sample is End of Sequence
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],

            [1], [The seventh sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence. Samples defined after
        the sample containing a set `ENDn` bit are not requested for conversion
        even though the fields may be non-zero.

        #v(10em)
    ],

    [24],
    [D6],
    [RW],
    [`0`],
    [
        7th Sample Differential Input Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],

            [1],
            [
                The analog input is differentially sampled. The corresponding
                #link(<adcssmux0>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".
            ],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS6` bit is set.
    ],

    [23],
    [TS5],
    [RW],
    [`0`],
    [
        6th Sample Temp Sensor Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The input pin specified by the #link(<adcssmux0>)[*ADCSSMUXn*]
                register is read during the sixth sample of the sample sequence.
            ],

            [1],
            [
                The temperature sensor is read during the sixth sample of the
                sample sequence.
            ],
        )
    ],

    [22],
    [IE5],
    [RW],
    [`0`],
    [
        6th Sample Interrupt Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [
                The raw interrupt signal (`INR0`) bit is asserted at the end of
                the sixth sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.
            ],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [21],
    [END5],
    [RW],
    [`0`],
    [
        6th Sample is End of Sequence
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],

            [1], [The sixth sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence. Samples defined after
        the sample containing a set `ENDn` bit are not requested for conversion
        even though the fields may be non-zero.

        #v(10em)
    ],

    [20],
    [D5],
    [RW],
    [`0`],
    [
        6th Sample Differential Input Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],

            [1],
            [
                The analog input is differentially sampled. The corresponding
                #link(<adcssmux0>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".
            ],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS5` bit is set.
    ],

    [19],
    [TS4],
    [RW],
    [`0`],
    [
        5th Sample Temp Sensor Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The input pin specified by the #link(<adcssmux0>)[*ADCSSMUXn*]
                register is read during the fifth sample of the sample sequence.
            ],

            [1],
            [
                The temperature sensor is read during the fifth sample of the
                sample sequence.
            ],
        )
    ],

    [18],
    [IE4],
    [RW],
    [`0`],
    [
        5th Sample Interrupt Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [
                The raw interrupt signal (`INR0`) bit is asserted at the end of
                the fifth sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.
            ],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [17],
    [END4],
    [RW],
    [`0`],
    [
        5th Sample is End of Sequence
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],

            [1], [The fifth sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence. Samples defined after
        the sample containing a set `ENDn` bit are not requested for conversion
        even though the fields may be non-zero.

        #v(10em)
    ],

    [16],
    [D4],
    [RW],
    [`0`],
    [
        5th Sample Differential Input Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],

            [1],
            [
                The analog input is differentially sampled. The corresponding
                #link(<adcssmux0>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".
            ],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS4` bit is set.
    ],

    [15],
    [TS3],
    [RW],
    [`0`],
    [
        4th Sample Temp Sensor Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The input pin specified by the #link(<adcssmux0>)[*ADCSSMUXn*]
                register is read during the fourth sample of the sample
                sequence.
            ],

            [1],
            [
                The temperature sensor is read during the fourth sample of the
                sample sequence.
            ],
        )
    ],

    [14],
    [IE3],
    [RW],
    [`0`],
    [
        4th Sample Interrupt Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [
                The raw interrupt signal (`INR0`) bit is asserted at the end of
                the fourth sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.
            ],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [13],
    [END3],
    [RW],
    [`0`],
    [
        4th Sample is End of Sequence
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],

            [1], [The fourth sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence. Samples defined after
        the sample containing a set `ENDn` bit are not requested for conversion
        even though the fields may be non-zero.

        #v(10em)
    ],

    [12],
    [D3],
    [RW],
    [`0`],
    [
        4th Sample Differential Input Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],

            [1],
            [
                The analog input is differentially sampled. The corresponding
                #link(<adcssmux0>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".
            ],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS3` bit is set.
    ],

    [11],
    [TS2],
    [RW],
    [`0`],
    [
        3rd Sample Temp Sensor Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The input pin specified by the #link(<adcssmux0>)[*ADCSSMUXn*]
                register is read during the third sample of the sample sequence.
            ],

            [1],
            [
                The temperature sensor is read during the third sample of the
                sample sequence.
            ],
        )
    ],

    [10],
    [IE2],
    [RW],
    [`0`],
    [
        3rd Sample Interrupt Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [
                The raw interrupt signal (`INR0`) bit is asserted at the end of
                the third sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.
            ],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [9],
    [END2],
    [RW],
    [`0`],
    [
        3rd Sample is End of Sequence
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],

            [1], [The third sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence. Samples defined after
        the sample containing a set `ENDn` bit are not requested for conversion
        even though the fields may be non-zero.

        #v(10em)
    ],

    [8],
    [D2],
    [RW],
    [`0`],
    [
        3rd Sample Differential Input Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],

            [1],
            [
                The analog input is differentially sampled. The corresponding
                #link(<adcssmux0>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".
            ],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS2` bit is set.
    ],

    [7],
    [TS1],
    [RW],
    [`0`],
    [
        2nd Sample Temp Sensor Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The input pin specified by the #link(<adcssmux0>)[*ADCSSMUXn*]
                register is read during the second sample of the sample
                sequence.
            ],

            [1],
            [
                The temperature sensor is read during the second sample of the
                sample sequence.
            ],
        )
    ],

    [6],
    [IE1],
    [RW],
    [`0`],
    [
        2nd Sample Interrupt Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [
                The raw interrupt signal (`INR0`) bit is asserted at the end of
                the second sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.
            ],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [5],
    [END1],
    [RW],
    [`0`],
    [
        2nd Sample is End of Sequence
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],

            [1], [The second sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence. Samples defined after
        the sample containing a set `ENDn` bit are not requested for conversion
        even though the fields may be non-zero.

        #v(10em)
    ],

    [4],
    [D1],
    [RW],
    [`0`],
    [
        2nd Sample Differential Input Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],

            [1],
            [
                The analog input is differentially sampled. The corresponding
                #link(<adcssmux0>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".
            ],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS1` bit is set.
    ],

    [3],
    [TS0],
    [RW],
    [`0`],
    [
        1st Sample Temp Sensor Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The input pin specified by the #link(<adcssmux0>)[*ADCSSMUXn*]
                register is read during the first sample of the sample sequence.
            ],

            [1],
            [
                The temperature sensor is read during the first sample of the
                sample sequence.
            ],
        )
    ],

    [2],
    [IE0],
    [RW],
    [`0`],
    [
        1st Sample Interrupt Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [
                The raw interrupt signal (`INR0`) bit is asserted at the end of
                the first sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.
            ],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [1],
    [END0],
    [RW],
    [`0`],
    [
        1st Sample is End of Sequence
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],

            [1], [The first sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence. Samples defined after
        the sample containing a set `ENDn` bit are not requested for conversion
        even though the fields may be non-zero.

        #v(10em)
    ],

    [0],
    [D0],
    [RW],
    [`0`],
    [
        1st Sample Differential Input Select
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],

            [1],
            [
                The analog input is differentially sampled. The corresponding
                #link(<adcssmux0>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".
            ],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS0` bit is set.
    ],
))

#pagebreak()

=== ADC Sample Sequence Control n (ADCSSCTLn)
<adcssctln>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x064`
- Type RW, reset `0x0000.0000`

Registers:
- Register 29: ADC Sample Sequence Control 1 (ADCSSCTL1), offset `0x064`
- Register 30: ADC Sample Sequence Control 2 (ADCSSCTL2), offset `0x084`

#cimage("./images/adcssctln-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15],
    [TS3],
    [RW],
    [0],
    [
        4th Sample Temp Sensor Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The input pin specified by the #link(<adcssmuxn>)[*ADCSSMUXn*]
                register is read during the fourth sample of the sample
                sequence.],

            [1],
            [The temperature sensor is read during the fourth sample of the
                sample sequence.],
        )
    ],

    [14],
    [IE3],
    [RW],
    [0],
    [
        4th Sample Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [The raw interrupt signal (`INR0` bit) is asserted at the end of the
                fourth sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.

        #v(10em)
    ],

    [13],
    [END3],
    [RW],
    [0],
    [
        4th Sample is End of Sequence

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],
            [1], [The fourth sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence.

        Samples defined after the sample containing a set `ENDn` bit are not
        requested for conversion even though the fields may be non-zero.
    ],

    [12],
    [D3],
    [RW],
    [0],
    [
        4th Sample Differential Input Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],
            [1],
            [The analog input is differentially sampled. The corresponding
                #link(<adcssmuxn>)[*ADCSSMUXn*] nibble must be set to the pair
                number `1`, where the paired inputs are `3` and `2`.],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS3` bit is set.
    ],

    [11],
    [TS2],
    [RW],
    [0],
    [
        3rd Sample Temp Sensor Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The input pin specified by the #link(<adcssmuxn>)[*ADCSSMUXn*]
                register is read during the third sample of the sample
                sequence.],

            [1],
            [The temperature sensor is read during the third sample of the
                sample sequence.],
        )

        #v(20em)
    ],

    [10],
    [IE2],
    [RW],
    [0],
    [
        3rd Sample Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [The raw interrupt signal (`INR0` bit) is asserted at the end of the
                third sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [9],
    [END2],
    [RW],
    [0],
    [
        3rd Sample is End of Sequence

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],
            [1], [The third sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence.

        Samples defined after the sample containing a set `ENDn` bit are not
        requested for conversion even though the fields may be non-zero.
    ],

    [8],
    [D2],
    [RW],
    [0],
    [
        3rd Sample Differential Input Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],
            [1],
            [The analog input is differentially sampled. The corresponding
                #link(<adcssmuxn>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS2` bit is set.

        #v(10em)
    ],

    [7],
    [TS1],
    [RW],
    [0],
    [
        2nd Sample Temp Sensor Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The input pin specified by the #link(<adcssmuxn>)[*ADCSSMUXn*]
                register is read during the second sample of the sample
                sequence.],

            [1],
            [The temperature sensor is read during the second sample of the
                sample sequence.],
        )
    ],

    [6],
    [IE1],
    [RW],
    [0],
    [
        2nd Sample Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [The raw interrupt signal (`INR0` bit) is asserted at the end of the
                second sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.
    ],

    [5],
    [END1],
    [RW],
    [0],
    [
        2nd Sample is End of Sequence

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],
            [1], [The second sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence.

        Samples defined after the sample containing a set `ENDn` bit are not
        requested for conversion even though the fields may be non-zero.

        #v(20em)
    ],

    [4],
    [D1],
    [RW],
    [0],
    [
        2nd Sample Differential Input Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],
            [1],
            [The analog input is differentially sampled. The corresponding
                #link(<adcssmuxn>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS1` bit is set.
    ],

    [3],
    [TS0],
    [RW],
    [0],
    [
        1st Sample Temp Sensor Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The input pin specified by the #link(<adcssmuxn>)[*ADCSSMUXn*]
                register is read during the first sample of the sample
                sequence.],

            [1],
            [The temperature sensor is read during the first sample of the
                sample sequence.],
        )
    ],

    [2],
    [IE0],
    [RW],
    [0],
    [
        1st Sample Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [The raw interrupt signal (`INR0` bit) is asserted at the end of the
                first sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.

        #v(20em)
    ],

    [1],
    [END0],
    [RW],
    [0],
    [
        1st Sample is End of Sequence

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Another sample in the sequence is the final sample.],
            [1], [The first sample is the last sample of the sequence.],
        )

        It is possible to end the sequence on any sample position. Software must
        set an `ENDn` bit somewhere within the sequence.

        Samples defined after the sample containing a set `ENDn` bit are not
        requested for conversion even though the fields may be non-zero.
    ],

    [0],
    [D0],
    [RW],
    [0],
    [
        1st Sample Differential Input Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],
            [1],
            [The analog input is differentially sampled. The corresponding
                #link(<adcssmuxn>)[*ADCSSMUXn*] nibble must be set to the pair
                number `1`, where the paired inputs are `2i` and `2i+1`.],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS0` bit is set.
    ],
))

#pagebreak()

=== ADC Sample Sequence Control 3 (ADCSSCTL3)
<adcssctl3>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x0A4`
- Type RW, reset `0x0000.0000`

*Note*: When configuring a sample sequence in this register, the `END0` bit must
be set.

#cimage("./images/adcssctl3-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [TS0],
    [RW],
    [0],
    [
        1st Sample Temp Sensor Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The input pin specified by the #link(<adcssmuxn>)[*ADCSSMUXn*]
                register is read during the first sample of the sample
                sequence.],

            [1],
            [The temperature sensor is read during the first sample of the
                sample sequence.],
        )
    ],

    [2],
    [IE0],
    [RW],
    [0],
    [
        Sample Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The raw interrupt is not asserted to the interrupt controller.],

            [1],
            [The raw interrupt signal (`INR0` bit) is asserted at the end of
                this sample's conversion. If the `MASK0` bit in the #link(
                    <adcim>,
                )[*ADCIM*] register is set, the interrupt is promoted to the
                interrupt controller.],
        )

        It is legal to have multiple samples within a sequence generate
        interrupts.

        #v(10em)
    ],

    [1],
    [END0],
    [RW],
    [0],
    [
        End of Sequence

        This bit must be set before initiating a single sample sequence.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Sampling and conversion continues.],
            [1], [This is the end of sequence.],
        )
    ],

    [0],
    [D0],
    [RW],
    [0],
    [
        Sample Differential Input Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The analog inputs are not differentially sampled.],
            [1],
            [The analog input is differentially sampled. The corresponding
                #link(<adcssmuxn>)[*ADCSSMUXn*] nibble must be set to the pair
                number "i", where the paired inputs are "2i and 2i+1".],
        )

        Because the temperature sensor does not have a differential option, this
        bit must not be set when the `TS0` bit is set.
    ],
))

#pagebreak()

=== ADC Active Sample Sequencer (ADCACTSS)
<adcactss>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x000`
- Type RW, reset `0x0000.0000`

#cimage("./images/adcactss-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:17],
    [reserved],
    [RO],
    [`0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [16],
    [BUSY],
    [RO],
    [`0`],
    [
        ADC Busy
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [ADC is idle],

            [1], [ADC is busy],
        )
    ],

    [15:4],
    [reserved],
    [RO],
    [`0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [ASEN3],
    [RW],
    [`0`],
    [
        ADC SS3 Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Sample Sequencer 3 is disabled.],

            [1], [Sample Sequencer 3 is enabled.],
        )
    ],

    [2],
    [ASEN2],
    [RW],
    [`0`],
    [
        ADC SS2 Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Sample Sequencer 2 is disabled.],

            [1], [Sample Sequencer 2 is enabled.],
        )
    ],

    [1],
    [ASEN1],
    [RW],
    [`0`],
    [
        ADC SS1 Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Sample Sequencer 1 is disabled.],

            [1], [Sample Sequencer 1 is enabled.],
        )

        #v(10em)
    ],

    [0],
    [ASEN0],
    [RW],
    [`0`],
    [
        ADC SS0 Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Sample Sequencer 0 is disabled.],

            [1], [Sample Sequencer 0 is enabled.],
        )
    ],
))

#pagebreak()

=== ADC Sample Phase Control (ADCSPC)
<adcspc>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x024`
- Type RW, reset `0x0000.0000`

#cimage("./images/adcspc-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3:0],
    [PHASE],
    [RW],
    [`0x0`],
    [
        Phase Difference

        This field selects the sample phase difference from the standard sample
        time.
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [ADC sample lags by $0.0 degree$],

            [`0x1`], [ADC sample lags by $22.5 degree$],

            [`0x2`], [ADC sample lags by $45.0 degree$],

            [`0x3`], [ADC sample lags by $67.5 degree$],

            [`0x4`], [ADC sample lags by $90.0 degree$],

            [`0x5`], [ADC sample lags by $112.5 degree$],

            [`0x6`], [ADC sample lags by $135.0 degree$],

            [`0x7`], [ADC sample lags by $157.5 degree$],

            [`0x8`], [ADC sample lags by $180.0 degree$],

            [`0x9`], [ADC sample lags by $202.5 degree$],

            [`0xA`], [ADC sample lags by $225.0 degree$],

            [`0xB`], [ADC sample lags by $247.5 degree$],

            [`0xC`], [ADC sample lags by $270.0 degree$],

            [`0xD`], [ADC sample lags by $292.5 degree$],

            [`0xE`], [ADC sample lags by $315.0 degree$],

            [`0xF`], [ADC sample lags by $337.5 degree$],
        )
    ],
))

#pagebreak()

=== ADC Digital Comparator Range n (ADCDCCMPn)
<adcdccmpn>
Each comparator has 2 values:
- `COMP1`: High value
- `COMP0`: Low value

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0xE40`
- Type RW, reset `0x0000.0000`

Registers:
- Register 48: ADC Digital Comparator Range 0 (ADCDCCMP0), offset `0xE40`
- Register 49: ADC Digital Comparator Range 1 (ADCDCCMP1), offset `0xE44`
- Register 50: ADC Digital Comparator Range 2 (ADCDCCMP2), offset `0xE48`
- Register 51: ADC Digital Comparator Range 3 (ADCDCCMP3), offset `0xE4C`
- Register 52: ADC Digital Comparator Range 4 (ADCDCCMP4), offset `0xE50`
- Register 53: ADC Digital Comparator Range 5 (ADCDCCMP5), offset `0xE54`
- Register 54: ADC Digital Comparator Range 6 (ADCDCCMP6), offset `0xE58`
- Register 55: ADC Digital Comparator Range 7 (ADCDCCMP7), offset `0xE5C`

#cimage("./images/adcdccmpn-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:28],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [27:16],
    [COMP1],
    [RW],
    [`0x000`],
    [
        Compare 1

        The value in this field is compared against the ADC conversion data. The
        result of the comparison is used to determine if the data lies within
        the high-band region. Note that the value of `COMP1` must be greater
        than or equal to the value of `COMP0`.
    ],

    [15:12],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11:0],
    [COMP0],
    [RW],
    [`0x000`],
    [
        Compare 0

        The value in this field is compared against the ADC conversion data. The
        result of the comparison is used to determine if the data lies within
        the low-band region.
    ],
))

#pagebreak()

=== ADC Digital Comparator Reset Initial Conditions (ADCDCRIC)
<adcdcric>
Resetting initial conditions of digital comparators.
- Reset of triggers
- Reset of interrupts

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0xD00`
- Type WO, reset `0x0000.0000`

#cimage("./images/adcdcric-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:24],
    [reserved],
    [RO],
    [`0x00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [23],
    [DCTRIG7],
    [WO],
    [`0`],
    [
        Digital Comparator Trigger 7
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 7 trigger unit to its initial
                conditions.],
        )

        When the trigger has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the trigger, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used. After setting
        this bit, software should wait until the bit clears before continuing.

        #v(20em)
    ],

    [22],
    [DCTRIG6],
    [WO],
    [`0`],
    [
        Digital Comparator Trigger 6
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 6 trigger unit to its initial
                conditions.],
        )

        When the trigger has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the trigger, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [21],
    [DCTRIG5],
    [WO],
    [0],
    [
        Digital Comparator Trigger 5
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 5 trigger unit to its initial
                conditions.],
        )

        When the trigger has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the trigger, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [20],
    [DCTRIG4],
    [WO],
    [0],
    [
        Digital Comparator Trigger 4
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 4 trigger unit to its initial
                conditions.],
        )

        When the trigger has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the trigger, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.

        #v(10em)
    ],

    [19],
    [DCTRIG3],
    [WO],
    [0],
    [
        Digital Comparator Trigger 3
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 3 trigger unit to its initial
                conditions.],
        )

        When the trigger has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the trigger, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [18],
    [DCTRIG2],
    [WO],
    [0],
    [
        Digital Comparator Trigger 2
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 2 trigger unit to its initial
                conditions.],
        )

        When the trigger has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the trigger, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [17],
    [DCTRIG1],
    [WO],
    [0],
    [
        Digital Comparator Trigger 1
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 1 trigger unit to its initial
                conditions.],
        )

        When the trigger has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the trigger, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.

        #v(10em)
    ],

    [16],
    [DCTRIG0],
    [WO],
    [0],
    [
        Digital Comparator Trigger 0
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 0 trigger unit to its initial
                conditions.],
        )

        When the trigger has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the trigger, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [15:8],
    [reserved],
    [RO],
    [`0x00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7],
    [DCINT7],
    [WO],
    [0],
    [
        Digital Comparator Interrupt 7
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 7 interrupt unit to its initial
                conditions.],
        )

        When the interrupt has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the interrupt, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [6],
    [DCINT6],
    [WO],
    [0],
    [
        Digital Comparator Interrupt 6
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 6 interrupt unit to its initial
                conditions.],
        )

        When the interrupt has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the interrupt, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.

        #v(10em)
    ],

    [5],
    [DCINT5],
    [WO],
    [0],
    [
        Digital Comparator Interrupt 5
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 5 interrupt unit to its initial
                conditions.],
        )

        When the interrupt has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the interrupt, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [4],
    [DCINT4],
    [WO],
    [0],
    [
        Digital Comparator Interrupt 4
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 4 interrupt unit to its initial
                conditions.],
        )

        When the interrupt has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the interrupt, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [3],
    [DCINT3],
    [WO],
    [0],
    [
        Digital Comparator Interrupt 3
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 3 interrupt unit to its initial
                conditions.],
        )

        When the interrupt has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the interrupt, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.

        #v(10em)
    ],

    [2],
    [DCINT2],
    [WO],
    [0],
    [
        Digital Comparator Interrupt 2
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 2 interrupt unit to its initial
                conditions.],
        )

        When the interrupt has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the interrupt, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [1],
    [DCINT1],
    [WO],
    [0],
    [
        Digital Comparator Interrupt 1
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 1 interrupt unit to its initial
                conditions.],
        )

        When the interrupt has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the interrupt, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],

    [0],
    [DCINT0],
    [WO],
    [0],
    [
        Digital Comparator Interrupt 0
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [Resets the Digital Comparator 0 interrupt unit to its initial
                conditions.],
        )

        When the interrupt has been cleared, this bit is automatically cleared.
        Because the digital comparators use the current and previous ADC
        conversion values to determine when to assert the interrupt, it is
        important to reset the digital comparator to initial conditions when
        starting a new sequence so that stale data is not used.
    ],
))

#pagebreak()

=== ADC Sample Sequence 0 Digital Comparator Select (ADCSSDC0)
<adcssdc0>
This register determines which digital comparator receives the sample from the
given conversion on Sample Sequence 0, if the corresponding `SnDCOP` bit in the
#link(<adcssop0>)[*ADCSSOP0*] register is set.

- Sample sequencer can take up to eight samples.
- Each sample's digital value can be sent to a digital comparator.
- This register assigns a digital comparator to a sample.

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x054`
- Type RW, reset `0x0000.0000`

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:28],
    [S7DCSEL],
    [RW],
    [`0x0`],
    [
        Sample 7 Digital Comparator Select

        When the `S7DCOP` bit in the #link(<adcssop0>)[*ADCSSOP0*] register is
        set, this field indicates which digital comparator unit (and its
        associated set of control registers) receives the eighth sample from
        Sample Sequencer 0.
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [Digital Comparator Unit 0 (`ADCDCMP0` and `ADCDCCTL0`)],

            [`0x1`], [Digital Comparator Unit 1 (`ADCDCMP1` and `ADCDCCTL1`)],

            [`0x2`], [Digital Comparator Unit 2 (`ADCDCMP2` and `ADCDCCTL2`)],

            [`0x3`], [Digital Comparator Unit 3 (`ADCDCMP3` and `ADCDCCTL3`)],

            [`0x4`], [Digital Comparator Unit 4 (`ADCDCMP4` and `ADCDCCTL4`)],

            [`0x5`], [Digital Comparator Unit 5 (`ADCDCMP5` and `ADCDCCTL5`)],

            [`0x6`], [Digital Comparator Unit 6 (`ADCDCMP6` and `ADCDCCTL6`)],

            [`0x7`], [Digital Comparator Unit 7 (`ADCDCMP7` and `ADCDCCTL7`)],

            [`0x8 - 0xF`], [Reserved],
        )
    ],

    [27:24],
    [S6DCSEL],
    [RW],
    [`0x0`],
    [
        This field has the same encodings as `S7DCSEL` but is used during the
        seventh sample.
    ],

    [23:20],
    [S5DCSEL],
    [RW],
    [`0x0`],
    [
        This field has the same encodings as `S7DCSEL` but is used during the
        sixth sample.
    ],

    [19:16],
    [S4DCSEL],
    [RW],
    [`0x0`],
    [
        This field has the same encodings as `S7DCSEL` but is used during the
        fifth sample.
    ],

    [15:12],
    [S3DCSEL],
    [RW],
    [`0x0`],
    [
        This field has the same encodings as `S7DCSEL` but is used during the
        fourth sample.
    ],

    [11:8],
    [S2DCSEL],
    [RW],
    [`0x0`],
    [
        This field has the same encodings as `S7DCSEL` but is used during the
        third sample.
    ],

    [7:4],
    [S1DCSEL],
    [RW],
    [`0x0`],
    [
        This field has the same encodings as `S7DCSEL` but is used during the
        second sample.
    ],

    [3:0],
    [S0DCSEL],
    [RW],
    [`0x0`],
    [
        This field has the same encodings as `S7DCSEL` but is used during the
        first sample.
    ],
))

#pagebreak()

=== ADC Sample Sequence 0 Operation (ADCSSOP0)
<adcssop0>
This register determines whether the sample from the given conversion on Sample
Sequence 0 is saved in the Sample Sequence FIFO0 or sent to the digital
comparator unit.

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x050`
- Type RW, reset `0x0000.0000`

#cimage("./images/adcssop0-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:29],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [28],
    [S7DCOP],
    [RW],
    [0],
    [
        Sample 7 Digital Comparator Operation
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The eighth sample is saved in Sample Sequence FIFO0.],

            [1],
            [
                The eighth sample is sent to the digital comparator unit
                specified by the `S7DCSEL` bit in the #link(
                    <adcssdc0>,
                )[*ADCSSDC0*] register, and the value is not written to the
                FIFO.
            ],
        )
    ],

    [27:25],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [24],
    [S6DCOP],
    [RW],
    [0],
    [
        Sample 6 Digital Comparator Operation

        Same definition as `S7DCOP` but used during the seventh sample.
    ],

    [23:21],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [20],
    [S5DCOP],
    [RW],
    [0],
    [
        Sample 5 Digital Comparator Operation

        Same definition as `S7DCOP` but used during the sixth sample.

        #v(10em)
    ],

    [19:17],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [16],
    [S4DCOP],
    [RW],
    [0],
    [
        Sample 4 Digital Comparator Operation

        Same definition as `S7DCOP` but used during the fifth sample.
    ],

    [15:13],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [12],
    [S3DCOP],
    [RW],
    [0],
    [
        Sample 3 Digital Comparator Operation

        Same definition as `S7DCOP` but used during the fourth sample.
    ],

    [11:9],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [8],
    [S2DCOP],
    [RW],
    [0],
    [
        Sample 2 Digital Comparator Operation

        Same definition as `S7DCOP` but used during the third sample.
    ],

    [7:5],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [4],
    [S1DCOP],
    [RW],
    [0],
    [
        Sample 1 Digital Comparator Operation

        Same definition as `S7DCOP` but used during the second sample.
    ],

    [3:1],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [0],
    [S0DCOP],
    [RW],
    [0],
    [
        Sample 0 Digital Comparator Operation

        Same definition as `S7DCOP` but used during the first sample.
    ],
))

#pagebreak()

=== ADC Processor Sample Sequence Initiate (ADCPSSI)
<adcpssi>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x028`
- Type RW, reset -

#cimage("./images/adcpssi-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31],
    [GSYNC],
    [RW],
    [0],
    [
        Global Synchronize
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [This bit is cleared once sampling has been initiated.],

            [1],
            [
                This bit initiates sampling in multiple ADC modules at the same
                time. Any ADC module that has been initialized by setting an
                `SSn` bit and the `SYNCWAIT` bit starts sampling once this bit
                is written.
            ],
        )
    ],

    [30:28],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [27],
    [SYNCWAIT],
    [RW],
    [0],
    [
        Synchronize Wait
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [Sampling begins when a sample sequence has been initiated.],

            [1],
            [
                This bit allows the sample sequences to be initiated, but delays
                sampling until the `GSYNC` bit is set.
            ],
        )
    ],

    [26:4],
    [reserved],
    [RO],
    [`0x000.0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [3],
    [SS3],
    [WO],
    [-],
    [
        SS3 Initiate
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [
                Begin sampling on Sample Sequencer 3, if the sequencer is
                enabled in the `ADCACTSS` register.
            ],
        )

        Only a write by software is valid; a read of this register returns no
        meaningful data.
    ],

    [2],
    [SS2],
    [WO],
    [-],
    [
        SS2 Initiate
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [
                Begin sampling on Sample Sequencer 2, if the sequencer is
                enabled in the `ADCACTSS` register.
            ],
        )

        Only a write by software is valid; a read of this register returns no
        meaningful data.
    ],

    [1],
    [SS1],
    [WO],
    [-],
    [
        SS1 Initiate
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [
                Begin sampling on Sample Sequencer 1, if the sequencer is
                enabled in the `ADCACTSS` register.
            ],
        )

        Only a write by software is valid; a read of this register returns no
        meaningful data.
    ],

    [0],
    [SS0],
    [WO],
    [-],
    [
        SS0 Initiate
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No effect.],

            [1],
            [
                Begin sampling on Sample Sequencer 0, if the sequencer is
                enabled in the `ADCACTSS` register.
            ],
        )

        Only a write by software is valid; a read of this register returns no
        meaningful data.
    ],
))

#pagebreak()

=== ADC Sample Averaging Control (ADCSAC)
<adcsac>
This register controls the amount of hardware averaging applied to conversion
results.

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x030`
- Type RW, reset `0x0000.0000`

#cimage("./images/adcsac-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:3],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [2:0],
    [AVG],
    [RW],
    [`0x0`],
    [
        Hardware Averaging Control

        Specifies the amount of hardware averaging that will be applied to ADC
        samples. The `AVG` field can be any value between 0 and 6. Entering a
        value of 7 creates unpredictable results.
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [`0x0`], [No hardware oversampling],

            [`0x1`], [2x hardware oversampling],

            [`0x2`], [4x hardware oversampling],

            [`0x3`], [8x hardware oversampling],

            [`0x4`], [16x hardware oversampling],

            [`0x5`], [32x hardware oversampling],

            [`0x6`], [64x hardware oversampling],

            [`0x7`], [Reserved],
        )
    ],
))

#pagebreak()

=== ADC Interrupt Mask (ADCIM)
<adcim>
This register controls whether the sample sequencer and digital comparator raw
interrupt signals are sent to the interrupt controller. Each raw interrupt
signal can be masked independently.

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x008`
- Type RW, reset `0x0000.0000`

#cimage("./images/adcim-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:20],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [19],
    [DCONSS3],
    [RW],
    [0],
    [
        Digital Comparator Interrupt on SS3
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The status of the digital comparators does not affect the SS3
                interrupt status.
            ],

            [1],
            [
                The raw interrupt signal from the digital comparators (`INRDC`
                bit in the #link(<adcris>)[*ADCRIS*] register) is sent to the
                interrupt controller on the SS3 interrupt line.
            ],
        )
    ],

    [18],
    [DCONSS2],
    [RW],
    [0],
    [
        Digital Comparator Interrupt on SS2
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The status of the digital comparators does not affect the SS2
                interrupt status.
            ],

            [1],
            [
                The raw interrupt signal from the digital comparators (`INRDC`
                bit in the #link(<adcris>)[*ADCRIS*] register) is sent to the
                interrupt controller on the SS2 interrupt line.
            ],
        )

        #v(20em)
    ],

    [17],
    [DCONSS1],
    [RW],
    [0],
    [
        Digital Comparator Interrupt on SS1
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The status of the digital comparators does not affect the SS1
                interrupt status.
            ],

            [1],
            [
                The raw interrupt signal from the digital comparators (`INRDC`
                bit in the #link(<adcris>)[*ADCRIS*] register) is sent to the
                interrupt controller on the SS1 interrupt line.
            ],
        )
    ],

    [16],
    [DCONSS0],
    [RW],
    [0],
    [
        Digital Comparator Interrupt on SS0
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The status of the digital comparators does not affect the SS0
                interrupt status.
            ],

            [1],
            [
                The raw interrupt signal from the digital comparators (`INRDC`
                bit in the #link(<adcris>)[*ADCRIS*] register) is sent to the
                interrupt controller on the SS0 interrupt line.
            ],
        )
    ],

    [15:4],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [MASK3],
    [RW],
    [0],
    [
        SS3 Interrupt Mask
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The status of Sample Sequencer 3 does not affect the SS3
                interrupt status.
            ],

            [1],
            [
                The raw interrupt signal from Sample Sequencer 3 (#link(
                    <adcris>,
                )[*ADCRIS*] register `INR3` bit) is sent to the interrupt
                controller.
            ],
        )
    ],

    [2],
    [MASK2],
    [RW],
    [0],
    [
        SS2 Interrupt Mask
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The status of Sample Sequencer 2 does not affect the SS2
                interrupt status.
            ],

            [1],
            [
                The raw interrupt signal from Sample Sequencer 2 (#link(
                    <adcris>,
                )[*ADCRIS*] register `INR2` bit) is sent to the interrupt
                controller.
            ],
        )

        #v(10em)
    ],

    [1],
    [MASK1],
    [RW],
    [0],
    [
        SS1 Interrupt Mask
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [
                The status of Sample Sequencer 1 does not affect the SS1
                interrupt status.
            ],

            [1],
            [
                The raw interrupt signal from Sample Sequencer 1 (#link(
                    <adcris>,
                )[*ADCRIS*] register `INR1` bit) is sent to the interrupt
                controller.
            ],
        )
    ],

    [0],
    [MASK0],
    [RW],
    [0],
    [
        SS0 Interrupt Mask
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0],
            [The status of Sample Sequencer 0 does not affect the SS0 interrupt
                status.],

            [1],
            [
                The raw interrupt signal from Sample Sequencer 0 (#link(
                    <adcris>,
                )[*ADCRIS*] register `INR0` bit) is sent to the interrupt
                controller.
            ],
        )
    ],
))

=== ADC Sample Sequence Result FIFO n (ADCSSFIFOn)
<adcssfifon>
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x048`
- Type RO, reset -

Registers:
- Register 17: ADC Sample Sequence Result FIFO 0 (ADCSSFIFO0), offset `0x048`
- Register 18: ADC Sample Sequence Result FIFO 1 (ADCSSFIFO1), offset `0x068`
- Register 19: ADC Sample Sequence Result FIFO 2 (ADCSSFIFO2), offset `0x088`
- Register 20: ADC Sample Sequence Result FIFO 3 (ADCSSFIFO3), offset `0x0A8`

#cimage("./images/adcssfifon-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:12],
    [reserved],
    [RO],
    [`0x0000.0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11:0], [DATA], [RO], [-], [Conversion Result Data],
))

#pagebreak()

=== ADC Sample Sequence FIFO n Status (ADCSSFSTATn)
<adcssfstatn>
FIFO stands for first in, first out queue.
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x04C`
- Type RO, reset `0x0000.0100`

Registers:
- Register 21: ADC Sample Sequence FIFO 0 Status (ADCSSFSTAT0), offset `0x04C`
- Register 22: ADC Sample Sequence FIFO 1 Status (ADCSSFSTAT1), offset `0x06C`
- Register 23: ADC Sample Sequence FIFO 2 Status (ADCSSFSTAT2), offset `0x08C`
- Register 24: ADC Sample Sequence FIFO 3 Status (ADCSSFSTAT3), offset `0x0AC`

#cimage("./images/adcssfstatn-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:13],
    [reserved],
    [RO],
    [`0x0000.0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [12],
    [FULL],
    [RO],
    [0],
    [
        FIFO Full
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The FIFO is not currently full.],

            [1], [The FIFO is currently full.],
        )
    ],

    [11:9],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [8],
    [EMPTY],
    [RO],
    [1],
    [
        FIFO Empty
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The FIFO is not currently empty.],

            [1], [The FIFO is currently empty.],
        )
    ],

    [7:4],
    [HPTR],
    [RO],
    [`0x0`],
    [
        FIFO Head Pointer

        This field contains the current "head" pointer index for the FIFO, that
        is, the next entry to be written.

        Valid values are:
        - `0x0 - 0x7` for FIFO0
        - `0x0 - 0x3` for FIFO1 and FIFO2
        - `0x0` for FIFO3.
    ],

    [3:0],
    [TPTR],
    [RO],
    [`0x0`],
    [
        FIFO Tail Pointer

        This field contains the current "tail" pointer index for the FIFO, that
        is, the next entry to be read.

        Valid values are:
        - `0x0 - 0x7` for FIFO0
        - `0x0 - 0x3` for FIFO1 and FIFO2
        - `0x0` for FIFO3
    ],
))

==== Illustration of the head and tail address
#cimage("./images/adcssfstatn-head-and-tail-address.png")
#pagebreak()

=== ADC Raw Interrupt Status (ADCRIS)
<adcris>
This register shows the status of the raw interrupt signal of each sample
sequencer. These bits may be polled by software to look for interrupt conditions
without sending the interrupts to the interrupt controller.

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x004`
- Type RO, reset `0x0000.0000`

#cimage("./images/adcris-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:17],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [16],
    [INRDC],
    [RO],
    [0],
    [
        Digital Comparator Raw Interrupt Status
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [All bits in the *ADCDISC* register are clear.],

            [1],
            [
                At least one bit in the *ADCDISC* register is set, meaning that
                a digital comparator interrupt has occurred.
            ],
        )
    ],

    [15:4],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [INR3],
    [RO],
    [0],
    [
        SS3 Raw Interrupt Status
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],

            [1],
            [
                A sample has completed conversion and the respective #link(
                    <adcssctl3>,
                )[*ADCSSCTL3*] `IEn` bit is set, enabling a raw interrupt.
            ],
        )

        This bit is cleared by writing a 1 to the `IN3` bit in the *ADCISC*
        register.

        #v(10em)
    ],

    [2],
    [INR2],
    [RO],
    [0],
    [
        SS2 Raw Interrupt Status
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],

            [1],
            [
                A sample has completed conversion and the respective *ADCSSCTL2*
                `IEn` bit is set, enabling a raw interrupt.
            ],
        )

        This bit is cleared by writing a 1 to the `IN2` bit in the *ADCISC*
        register.
    ],

    [1],
    [INR1],
    [RO],
    [0],
    [
        SS1 Raw Interrupt Status
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],

            [1],
            [
                A sample has completed conversion and the respective *ADCSSCTL1*
                `IEn` bit is set, enabling a raw interrupt.
            ],
        )

        This bit is cleared by writing a 1 to the `IN1` bit in the *ADCISC*
        register.
    ],

    [0],
    [INR0],
    [RO],
    [0],
    [
        SS0 Raw Interrupt Status
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],

            [1],
            [
                A sample has completed conversion and the respective *ADCSSCTL0*
                `IEn` bit is set, enabling a raw interrupt.
            ],
        )

        This bit is cleared by writing a 1 to the `IN0` bit in the *ADCISC*
        register.
    ],
))

#pagebreak()

=== ADC Digital Comparator Interrupt Status and Clear (ADCDCISC)
<adcdcisc>
This register provides status and acknowledgement of digital comparator
interrupts. One bit is provided for each comparator.

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x034`
- Type RW1C, reset `0x0000.0000`

#cimage("./images/adcdcisc-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7],
    [DCINT7],
    [RW1C],
    [0],
    [
        Digital Comparator 7 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt.],

            [1], [Digital Comparator 7 has generated an interrupt.],
        )

        This bit is cleared by writing a 1.
    ],

    [6],
    [DCINT6],
    [RW1C],
    [0],
    [
        Digital Comparator 6 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt.],

            [1], [Digital Comparator 6 has generated an interrupt.],
        )

        This bit is cleared by writing a 1.
    ],

    [5],
    [DCINT5],
    [RW1C],
    [0],
    [
        Digital Comparator 5 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt.],

            [1], [Digital Comparator 5 has generated an interrupt.],
        )

        This bit is cleared by writing a 1.

        #v(10em)
    ],

    [4],
    [DCINT4],
    [RW1C],
    [0],
    [
        Digital Comparator 4 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt.],

            [1], [Digital Comparator 4 has generated an interrupt.],
        )

        This bit is cleared by writing a 1.
    ],

    [3],
    [DCINT3],
    [RW1C],
    [0],
    [
        Digital Comparator 3 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt.],

            [1], [Digital Comparator 3 has generated an interrupt.],
        )

        This bit is cleared by writing a 1.
    ],

    [2],
    [DCINT2],
    [RW1C],
    [0],
    [
        Digital Comparator 2 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt.],

            [1], [Digital Comparator 2 has generated an interrupt.],
        )

        This bit is cleared by writing a 1.
    ],

    [1],
    [DCINT1],
    [RW1C],
    [0],
    [
        Digital Comparator 1 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt.],

            [1], [Digital Comparator 1 has generated an interrupt.],
        )

        This bit is cleared by writing a 1.
    ],

    [0],
    [DCINT0],
    [RW1C],
    [0],
    [
        Digital Comparator 0 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt.],

            [1], [Digital Comparator 0 has generated an interrupt.],
        )

        This bit is cleared by writing a 1.
    ],
))

#pagebreak()

=== ADC Interrupt Status and Clear (ADCISC)
<adcisc>
This register provides the mechanism for clearing sample sequencer interrupt
conditions and shows the status of interrupts generated by the sample sequencers
and the digital comparators which have been sent to the interrupt controller.

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x00C`
- Type RW1C, reset `0x0000.0000`

#cimage("./images/adcisc-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:20],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [19],
    [DCINSS3],
    [RO],
    [0],
    [
        Digital Comparator Interrupt Status on SS3
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],

            [1],
            [
                Both the `INRDC` bit in the #link(<adcris>)[*ADCRIS*] register
                and the `DCONSS3` bit in the #link(<adcim>)[*ADCIM*] register
                are set, providing a level-based interrupt to the interrupt
                controller.
            ],
        )

        This bit is cleared by writing a 1 to it. Clearing this bit also clears
        the `INRDC` bit in the #link(<adcris>)[*ADCRIS*] register.
    ],

    [18],
    [DCINSS2],
    [RO],
    [0],
    [
        Digital Comparator Interrupt Status on SS2
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],

            [1],
            [
                Both the `INRDC` bit in the #link(<adcris>)[*ADCRIS*] register
                and the `DCONSS2` bit in the #link(<adcim>)[*ADCIM*] register
                are set, providing a level-based interrupt to the interrupt
                controller.
            ],
        )

        This bit is cleared by writing a 1 to it. Clearing this bit also clears
        the `INRDC` bit in the #link(<adcris>)[*ADCRIS*] register.

        #v(10em)
    ],

    [17],
    [DCINSS1],
    [RO],
    [0],
    [
        Digital Comparator Interrupt Status on SS1
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],

            [1],
            [
                Both the `INRDC` bit in the #link(<adcris>)[*ADCRIS*] register
                and the `DCONSS1` bit in the #link(<adcim>)[*ADCIM*] register
                are set, providing a level-based interrupt to the interrupt
                controller.
            ],
        )

        This bit is cleared by writing a 1 to it. Clearing this bit also clears
        the `INRDC` bit in the #link(<adcris>)[*ADCRIS*] register.
    ],

    [16],
    [DCINSS0],
    [RO],
    [0],
    [
        Digital Comparator Interrupt Status on SS0
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],

            [1],
            [
                Both the `INRDC` bit in the #link(<adcris>)[*ADCRIS*] register
                and the `DCONSS0` bit in the #link(<adcim>)[*ADCIM*] register
                are set, providing a level-based interrupt to the interrupt
                controller.
            ],
        )

        This bit is cleared by writing a 1 to it. Clearing this bit also clears
        the `INRDC` bit in the #link(<adcris>)[*ADCRIS*] register.
    ],

    [15:4],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [IN3],
    [RW1C],
    [0],
    [
        SS3 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],

            [1],
            [
                Both the `INR3` bit in the #link(<adcris>)[*ADCRIS*] register
                and the `MASK3` bit in the #link(<adcim>)[*ADCIM*] register are
                set, providing a level-based interrupt to the interrupt
                controller.
            ],
        )

        This bit is cleared by writing a 1. Clearing this bit also clears the
        `INR3` bit in the #link(<adcris>)[*ADCRIS*] register.

        #v(10em)
    ],

    [2],
    [IN2],
    [RW1C],
    [0],
    [
        SS2 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],

            [1],
            [
                Both the `INR2` bit in the #link(<adcris>)[*ADCRIS*] register
                and the `MASK2` bit in the #link(<adcim>)[*ADCIM*] register are
                set, providing a level-based interrupt to the interrupt
                controller.
            ],
        )

        This bit is cleared by writing a 1. Clearing this bit also clears the
        `INR2` bit in the #link(<adcris>)[*ADCRIS*] register.
    ],

    [1],
    [IN1],
    [RW1C],
    [0],
    [
        SS1 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],

            [1],
            [
                Both the `INR1` bit in the #link(<adcris>)[*ADCRIS*] register
                and the `MASK1` bit in the #link(<adcim>)[*ADCIM*] register are
                set, providing a level-based interrupt to the interrupt
                controller.
            ],
        )

        This bit is cleared by writing a 1. Clearing this bit also clears the
        `INR1` bit in the #link(<adcris>)[*ADCRIS*] register.
    ],

    [0],
    [IN0],
    [RW1C],
    [0],
    [
        SS0 Interrupt Status and Clear
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],

            [1],
            [
                Both the `INR0` bit in the #link(<adcris>)[*ADCRIS*] register
                and the `MASK0` bit in the #link(<adcim>)[*ADCIM*] register are
                set, providing a level-based interrupt to the interrupt
                controller.
            ],
        )

        This bit is cleared by writing a 1. Clearing this bit also clears the
        `INR0` bit in the #link(<adcris>)[*ADCRIS*] register.
    ],
))

#pagebreak()

=== ADC Overflow Status (ADCOSTAT)
<adcosctat>
This register indicates overflow conditions in the sample sequencer FIFOs.

Documentation:
- ADC0 base: `0x4003.8000`
- ADC1 base: `0x4003.9000`
- Offset `0x010`
- Type RW1C, reset `0x0000.0000`

#cimage("./images/adcostat-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [`0x000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [OV3],
    [RW1C],
    [0],
    [
        SS3 FIFO Overflow
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The FIFO has not overflowed.],

            [1],
            [
                The FIFO for Sample Sequencer 3 has hit an overflow condition,
                meaning that the FIFO is full and a write was requested. When an
                overflow is detected, the most recent write is dropped.
            ],
        )

        This bit is cleared by writing a 1.
    ],

    [2],
    [OV2],
    [RW1C],
    [0],
    [
        SS2 FIFO Overflow
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The FIFO has not overflowed.],

            [1],
            [
                The FIFO for Sample Sequencer 2 has hit an overflow condition,
                meaning that the FIFO is full and a write was requested. When an
                overflow is detected, the most recent write is dropped.
            ],
        )

        This bit is cleared by writing a 1.

        #v(10em)
    ],

    [1],
    [OV1],
    [RW1C],
    [0],
    [
        SS1 FIFO Overflow
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The FIFO has not overflowed.],

            [1],
            [
                The FIFO for Sample Sequencer 1 has hit an overflow condition,
                meaning that the FIFO is full and a write was requested. When an
                overflow is detected, the most recent write is dropped.
            ],
        )

        This bit is cleared by writing a 1.
    ],

    [0],
    [OV0],
    [RW1C],
    [0],
    [
        SS0 FIFO Overflow
        #table(
            columns: 2,
            align: left,
            stroke: none,

            table.header([Value], [Description]),

            [0], [The FIFO has not overflowed.],

            [1],
            [
                The FIFO for Sample Sequencer 0 has hit an overflow condition,
                meaning that the FIFO is full and a write was requested. When an
                overflow is detected, the most recent write is dropped.
            ],
        )

        This bit is cleared by writing a 1.
    ],
))

#pagebreak()

== Reference voltages of Cortex M4 ADC
- #qty[3.3][V]
- Internally provided

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/reference-voltages-of-cortex-m4-adc-diagram.png"),
    $
        V_"refp" = #qty[3.3][V] \
        V_"refn" = #qty[0][V]
    $,
)

== Output from Cortex M4 ADC
12-bit digital numbers: `0x000` to `0xFFF`

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    image("./images/output-from-cortex-m4-adc-graph.png"),
    $ D = frac(V_"in", 3.3) times 2^(12) $,
)

=== Exercise
The Cortex M4 has an internal temperature sensor. The temperature - voltage plot
of the sensor is shown below. If the temperature is #qty[30][#sym.degree C],
what is the digital output from the Cortex M4's ADC?

#grid(
    columns: 2,
    column-gutter: 2em,
    align: horizon,
    [
        $ V_"TSENS" = #qty[2.7][V] - ("Temp" + 55)/75 $
        #image("./images/output-from-cortex-m4-adc-exercise.png")
    ],
    $
        V_"sensor" = 2.7 - (30 + 55) / 75 = #qty[1.567][V] \
        D = 1.567/3.3 times 2^(12) = 1944 "or" #text[`0x798`]
    $,
)

== Initialisation
For the ADC module to be used, the following steps have to be done:
+ Enable the ADC clock using the #link(<rcgcadc>)[*RCGCADC*] register.
+ Enable the clock to the appropriate GPIO modules via the #link(
        <rcgcgpio>,
    )[*RCGCGPIO*]
+ Set the #link(<gpioafsel>)[*GPIOAFSEL*] bits for the ADC input pins. To
    determine which GPIOs to configure, see @adc-signal-pin-names.
+ Configure the `AINx` signals to be analog inputs by *clearing* the
    corresponding `DEN` bit in the #link(<gpioden>)[*GPIO Digital Enable*]
    register.
+ Disable the analogue isolation circuit for all ADC input pins that are to be
    used by writing a `1` to the appropriate bits of the #link(
        <gpioamsel>,
    )[*GPIOAMSEL*] register in the associated GPIO block.
+ If required by the application, reconfigure the sample sequencer priorities in
    the #link(<adcsspri>)[*ADCSSPRI*] register. The default configuration has
    sample sequencer 0 with the highest priority and Sample Sequencer 3 as the
    lowest priority.

#pagebreak()

=== Example
```asm
GPIO_PORTE_AFSEL_R  EQU 0x40024420
GPIO_PORTE_DEN_R    EQU 0x4002451C
GPIO_PORTE_AMSEL_R  EQU 0x40024528

ADC0_ACTSS_R        EQU 0x40038000
ADC0_PC_R           EQU 0x40038FC4
ADC0_SSPRI_R        EQU 0x40038020
ADC0_EMUX_R         EQU 0x40038014
ADC0_SSMUX3_R       EQU 0x400380A0
ADC0_SSCTL3_R       EQU 0x400380A4
ADC0_IM_R           EQU 0x40038008
ADC0_PSSI_R         EQU 0x40038028
ADC0_RIS_R          EQU 0x40038004
ADC0_SSFIFO3_R      EQU 0x400380A8
ADC0_ISC_R          EQU 0x4003800C

SYSCTL_RCGCGPIO_R   EQU 0x400FE608  ; GPIO run mode clock gating control

SYSCTL_RCGCADC_R    EQU 0x400FE638  ; ADC run mode clock gating control

; Initialize Port E
; Activate clock for Port E
		LDR R1, =SYSCTL_RCGCGPIO_R
		LDR R0, [R1]
		ORR R0, R0, #0x10       ; Turn on GPIO E clock
		STR R0, [R1]
		NOP                     ; Allow time for clock to finish
		NOP
		NOP

; Enable alternate function
; 1 for enable, and 0 for disable
		LDR R1, =GPIO_PORTE_AFSEL_R
		LDR R0, [R1]
		ORR R0, R0, #0x10       ; Enable alternate function on PE4
		STR R0, [R1]

; Disable digital port
; 1 for enable, and 0 for disable
		LDR R1, =GPIO_PORTE_DEN_R
		LDR R0, [R1]
		BIC R0, R0, #0x10       ; Disable digital I/O on PE4
		STR R0, [R1]

; Enable analogue functionality
; 1 for enable, 0 for disable
		LDR R1, =GPIO_PORTE_AMSEL_R
		LDR R0, [R1]
		ORR R0, R0, #0x10       ; Enable PE4 analogue function
		STR R0, [R1]





; Activate clock for ADC0
		LDR R1, =SYSCTL_RCGCADC_R
		LDR R0, [R1]
		ORR R0, R0, #0x01       ; Activate ADC0
		STR R0, [R1]
		NOP                     ; Allow time for clock to finish

; Configure the sample rate
		LDR R1, =ADC0_PC_R
		LDR R0, [R1]
		BIC R0, R0, #0x0F       ; Clear max sample rate field
		ORR R0, R0, #0x1        ; Configure for 125K samples/sec
		STR R0, [R1]

; Configure the sample sequencer priority
		LDR R1, =ADC0_SSPRI_R
		LDR R0, =0x0123         ; SS3 is highest priority
		STR R0, [R1]

; Disable the sample sequencer
		LDR R1, =ADC0_ACTSS_R
		LDR R0, [R1]
		BIC R0, R0, #0x08       ; Disable SS3 before configuration to
		STR R0, [R1]            ; prevent erroneous execution

; Set the trigger
		LDR R1, =ADC0_EMUX_R
		LDR R0, [R1]
		BIC R0, R0, #0xF000     ; SS3 is software trigger
		STR R0, [R1]

; Set the channel to sample from
		LDR R1, =ADC0_SSMUX3_R
		LDR R0, [R1]
		BIC R0, R0, #0x000F     ; Clear SS3 field
		ADD R0, R0, #9          ; Set input pin AIN9
		STR R0, [R1]

; Configure the sample
; 0x0006 = 1st sample, no temperature sensor, no differential sampling,
; raw interrupt signal at the end of conversion, first sample is last sample
		LDR R1, =ADC0_SSCTL3_R
		LDR R0, =0x0006
		STR R0, [R1]

; Disable the interrupts on the sample sequencer
		LDR R1, =ADC0_IM_R
		LDR R0, [R1]
		BIC R0, R0, #0x0008     ; Disable SS3 interrupts
		STR R0, [R1]

; Enable the sample sequencer
		LDR R1, =ADC0_ACTSS_R
		LDR R0, [R1]
		ORR R0, R0, #0x0008     ; Enable SS3
		STR R0, [R1]
```

#pagebreak()

== Quick reference
#table(
    columns: 3,
    align: center + horizon,
    table.header(
        [],
        [*Base address*],
        [*#link(<rcgcadc>)[RCGCADC] [Address: `0x400F.E638`] value*],
    ),

    [ADC0], [`0x4003.8000`], [`0x1`],
    [ADC0], [`0x4003.9000`], [`0x2`],
)

*ADC* offsets and values:
- #link(<adcactss>)[*ADCACTSS*]: `0x00000000`
- #link(<adcpc>)[*ADCPC*]: `0x00000FC4`
    - `0x01`: 125K samples per second
    - `0x03`: 250K samples per second
    - `0x05`: 500K samples per second
    - `0x07`: 1M samples per second
- #link(<adcsspri>)[*ADCSSPRI*]: `0x00000020`
- #link(<adcemux>)[*ADCEMUX*]: `0x00000014`
- #link(<adcim>)[*ADCIM*]: `0x00000008`
- #link(<adcpssi>)[*ADCPSSI*]: `0x00000028`
- #link(<adcris>)[*ADCRIS*]: `0x0000.0004`
- #link(<adcisc>)[*ADCISC*]: `0x0000.000C`

*Sample sequencer 0* offsets and values:
- #link(<adcssmux0>)[*ADCSSMUX0*]: `0x0000.0040`
- #link(<adcssctl0>)[*ADCSSCTL0*]: `0x0000.0044`
- #link(<adcssfifon>)[*ADCSSFIFO0*]: `0x0000.0048`
- Value to set for #link(<adcactss>)[*ADCACTSS*] and the value to clear for
    #link(<adcim>)[*ADCIM*]: `0x01`
- Sample sequencer 0 priority for #link(<adcsspri>)[*ADCSSPRI*]: `0x3210`
- Sample sequencer 0 trigger for #link(<adcemux>)[*ADCEMUX*]: `0x000F`

*Sample sequencer 1* offsets and values:
- #link(<adcssmuxn>)[*ADCSSMUX1*]: `0x0000.0060`
- #link(<adcssctln>)[*ADCSSCTL1*]: `0x0000.0064`
- #link(<adcssfifon>)[*ADCSSFIFO1*]: `0x0000.0068`
- Value to set for #link(<adcactss>)[*ADCACTSS*] and the value to clear for
    #link(<adcim>)[*ADCIM*]: `0x02`
- Sample sequencer 1 priority for #link(<adcsspri>)[*ADCSSPRI*]: `0x2103`
- Sample sequencer 1 trigger for #link(<adcemux>)[*ADCEMUX*]: `0x00F0`

*Sample sequencer 2* offsets and values:
- #link(<adcssmuxn>)[*ADCSSMUX2*]: `0x0000.0080`
- #link(<adcssctln>)[*ADCSSCTL2*]: `0x0000.0084`
- #link(<adcssfifon>)[*ADCSSFIFO2*]: `0x0000.0088`
- Value to set for #link(<adcactss>)[*ADCACTSS*] and the value to clear for
    #link(<adcim>)[*ADCIM*]: `0x04`
- Sample sequencer 2 priority for #link(<adcsspri>)[*ADCSSPRI*]: `0x1023`
- Sample sequencer 2 trigger for #link(<adcemux>)[*ADCEMUX*]: `0x0F00`

*Sample sequencer 3* offsets and values:
- #link(<adcssmuxn>)[*ADCSSMUX3*]: `0x0000.00A0`
- #link(<adcssctl3>)[*ADCSSCTL3*]: `0x0000.00A4`
- #link(<adcssfifon>)[*ADCSSFIFO3*]: `0x0000.00A8`
- Value to set for #link(<adcactss>)[*ADCACTSS*] and the value to clear for
    #link(<adcim>)[*ADCIM*]: `0x08`
- Sample sequencer 3 priority for #link(<adcsspri>)[*ADCSSPRI*]: `0x0123`
- Sample sequencer 3 trigger for #link(<adcemux>)[*ADCEMUX*]: `0xF000`

#pagebreak()

== Differential sampling
In addition to traditional single-ended sampling, the ADC module supports
differential sampling of two analogue input channels. To enable differential
sampling, software must set the `Dn` bit in the #link(<adcssctl0>)[*ADCSSCTLn*]
register in a step's configuration nibble.

When a sequence step is configured for differential sampling, the input pair to
sample must be configured in the #link(<adcssmux0>)[*ADCSSMUXn*] register.
Differential pair 0 samples analogue inputs 0 and 1; differential pair 1 samples
analogue inputs 2 and 3; and so on. The ADC does not support other differential
pairings such as analogue input 0 with analogue input 3.

=== Differential sampling pairs
#align(center, table(
    columns: 2,
    align: left,

    table.header([*Differential Pair*], [*Analogue Inputs*]),

    [0], [0 and 1],

    [1], [2 and 3],

    [2], [4 and 5],

    [3], [6 and 7],

    [4], [8 and 9],

    [5], [10 and 11],
))

== Output of interrupts

=== Low band operation
#cimage("./images/output-of-interrupts-in-low-band-operation.png")

=== Mid band operation
#cimage("./images/output-of-interrupts-in-mid-band-operation.png")

=== High band operation
#cimage("./images/output-of-interrupts-in-high-band-operation.png")
#pagebreak()

=== Hardware output averaging
The Cortex M4 has the built-in circuit to support averaging of up to 64 digital
outputs.

#cimage("./images/hardware-output-averaging.png")
#pagebreak()

= TM4C123GH6PM UART
- 8 Universal Asynchronous Receiver/Transmitter (UART) lines.
- Programmable baud-rate generator allowing speeds up to #qty[5][Mbps] for
    regular speed (divide by 16) and #qty[10][Mbps] for high speed (divide by
    8).
- Separate 16x8 transmitting (TX) and receiving (RX) FIFOs to reduce the load of
    CPU interrupts.
- Programmable FIFO length, including 1-byte deep operation providing
    conventional double-buffered interface.
- FIFO trigger levels of $1/8, 1/4, 1/2, 3/4$, and $7/8$.
- Standard asynchronous communication bits for start, stop, and parity
    line-break generation and detection.
- Line-break generation and detection.
- Fully programmable serial interface characteristics with 5, 6, 7 or 8 data
    bits.
- Even, odd, stick, or no-parity bit generation and detection.
- 1 or 2 stop bit generation.
- IrDA serial-IR (SIR) encoder/decoder providing programmable use of IrDA Serial
    Infrared (SIR) or UART input/output.
- Support of IrDA SIR encoder decoder functions for data rates up to
    #qty[115.2][Kbps] half-duplex.
- Support of normal $3/16$ and low-power (1.41 - #qty[2.23][#sym.mu s]) bit
    durations.
- Programmable internal clock generator enabling division of reference clock by
    1 to 256 for low-power mode bit duration Support for communication with ISO
    7816 smart cards.
- Modem flow control (on UART1).
- EIA-485 9-bit support.
- Standard FIFO-level and End-of-Transmission interrupts
- Efficient transfers using Micro Direct Memory Access Controller (μDMA).
    - Separate channels for transmitting and receiving.
    - Receive "single request asserted" when data is in the FIFO, and "burst
        request asserted"" at programmed FIFO level.
- Transmit "single request asserted" when there is space in the FIFO, and "burst
    request asserted"" at programmed FIFO level.

== UARTs in Cortex M4
#cimage("./images/uarts-in-cortex-m4.png")

== UART module block diagram
#cimage("./images/uart-module-block-diagram.png")

== J connectors
#cimage("./images/j1-j4-connectors-description.png")

#let jconnectors = [

    === J1 connector
    #align(center, pad(x: -5em, text(size: 8pt, table(
        align: center + horizon,
        inset: 0.5em,
        columns: 16,
        table.header(
            table.cell(rowspan: 2)[*J1 Pin*],
            table.cell(rowspan: 2)[*GPIO*],
            [*Analog Function*],
            table.cell(rowspan: 2)[*On-board Function*],
            table.cell(rowspan: 2)[*Tiva C Series MCU Pin*],
            table.cell(colspan: 11)[*GPIOPCTL Register Setting*],

            [*GPIO AMSEL*],
            [*1*],
            [*2*],
            [*3*],
            [*4*],
            [*5*],
            [*6*],
            [*7*],
            [*8*],
            [*9*],
            [*14*],
            [*15*],
        ),

        [1.01], table.cell(colspan: 15)[#qty[3.3][V]],

        [1.02],
        [PB5],
        [AIN11],
        [-],
        [57],
        [-],
        [SSI2Fss],
        [-],
        [M0PWM3],
        [-],
        [-],
        [T1CCP1],
        [CAN0Tx],
        [-],
        [-],
        [-],

        [1.03],
        [PB0],
        [USB0ID],
        [-],
        [45],
        [U1Rx],
        [-],
        [-],
        [-],
        [-],
        [-],
        [T2CCP0],
        [-],
        [-],
        [-],
        [-],

        [1.04],
        [PB1],
        [USB0VBUS],
        [-],
        [46],
        [U1Tx],
        [-],
        [-],
        [-],
        [-],
        [-],
        [T2CCP1],
        [-],
        [-],
        [-],
        [-],

        [1.05],
        [PE4],
        [AIN9],
        [-],
        [59],
        [U5Rx],
        [-],
        [I2C2SCL],
        [M0PWM4],
        [M1PWM2],
        [-],
        [-],
        [CAN0Rx],
        [-],
        [-],
        [-],

        [1.06],
        [PE5],
        [AIN8],
        [-],
        [60],
        [U5Tx],
        [-],
        [I2C2SDA],
        [M0PWM5],
        [M1PWM3],
        [-],
        [-],
        [CAN0Tx],
        [-],
        [-],
        [-],

        [1.07],
        [PB4],
        [AIN10],
        [-],
        [58],
        [-],
        [SSI2Clk],
        [-],
        [M0PWM2],
        [-],
        [-],
        [T1CCP0],
        [CAN0Rx],
        [-],
        [-],
        [-],

        [1.08],
        [PA5],
        [-],
        [-],
        [22],
        [-],
        [SSI0Tx],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],

        [1.09],
        [PA6],
        [-],
        [-],
        [23],
        [-],
        [-],
        [I2C1SCL],
        [-],
        [M1PWM2],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],

        [1.10],
        [PA7],
        [-],
        [-],
        [24],
        [-],
        [-],
        [I2C1SDA],
        [-],
        [M1PWM3],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
    ))))

    === J2 connector
    #align(center, pad(x: -5em, text(size: 8pt, table(
        align: center + horizon,
        inset: 0.5em,
        columns: 16,
        table.header(
            table.cell(rowspan: 2)[*J2 Pin*],
            table.cell(rowspan: 2)[*GPIO*],
            [*Analog Function*],
            table.cell(rowspan: 2)[*On-board Function*],
            table.cell(rowspan: 2)[*Tiva C Series MCU Pin*],
            table.cell(colspan: 11)[*GPIOPCTL Register Setting*],

            [*GPIO AMSEL*],
            [*1*],
            [*2*],
            [*3*],
            [*4*],
            [*5*],
            [*6*],
            [*7*],
            [*8*],
            [*9*],
            [*14*],
            [*15*],
        ),

        [2.01], table.cell(colspan: 15, align: center, [GND]),

        [2.02],
        [PB2],
        [-],
        [-],
        [47],
        [-],
        [-],
        [I2C0SCL],
        [-],
        [-],
        [-],
        [T3CCP0],
        [-],
        [-],
        [-],
        [-],

        [2.03],
        [PE0],
        [AIN3],
        [-],
        [9],
        [U7Rx],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],

        [2.04],
        [PF0],
        [-],
        [USR_SW2/WAKE (R1)],
        [28],
        [U1RTS],
        [SSI1Rx],
        [CAN0Rx],
        [-],
        [M1PWM4],
        [PhA0],
        [T0CCP0],
        [NMI],
        [C0o],
        [-],
        [-],

        [2.05], table.cell(colspan: 15)[RESET],

        table.cell(rowspan: 2)[2.06],
        [PB7],
        [-],
        [-],
        [4],
        [-],
        [SSI2Tx],
        [-],
        [M0PWM1],
        [-],
        [-],
        [T0CCP1],
        [-],
        [-],
        [-],
        [-],

        [PD1],
        [AIN6],
        [Connected for MSP430 Compatibility (R10)],
        [62],
        [SSI3Fss],
        [SSI1Fss],
        [I2C3SDA],
        [M0PWM7],
        [M1PWM1],
        [-],
        [WT2CCP1],
        [-],
        [-],
        [-],
        [-],

        table.cell(rowspan: 2)[2.07],
        [PB6],
        [-],
        [-],
        [1],
        [-],
        [SSI2Rx],
        [-],
        [M0PWM0],
        [-],
        [-],
        [T0CCP0],
        [-],
        [-],
        [-],
        [-],

        [PD0],
        [AIN7],
        [Connected for MSP430 Compatibility (R9)],
        [61],
        [SSI3Clk],
        [SSI1Clk],
        [I2C3SCL],
        [M0PWM6],
        [M1PWM0],
        [-],
        [WT2CCP2],
        [-],
        [-],
        [-],
        [-],

        [2.08],
        [PA4],
        [-],
        [-],
        [21],
        [-],
        [SSI0Rx],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],

        [2.09],
        [PA3],
        [-],
        [-],
        [20],
        [-],
        [SSI0Fss],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],

        [2.10],
        [PA2],
        [-],
        [-],
        [19],
        [-],
        [SSI0Clk],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
    ))))

    === J3 connector
    #align(center, pad(x: -5em, text(size: 8pt, table(
        align: center + horizon,
        inset: 0.5em,
        columns: 16,
        table.header(
            table.cell(rowspan: 2)[*J3 Pin*],
            table.cell(rowspan: 2)[*GPIO*],
            [*Analog Function*],
            table.cell(rowspan: 2)[*On-board Function*],
            table.cell(rowspan: 2)[*Tiva C Series MCU Pin*],
            table.cell(colspan: 11)[*GPIOPCTL Register Setting*],

            [*GPIO AMSEL*],
            [*1*],
            [*2*],
            [*3*],
            [*4*],
            [*5*],
            [*6*],
            [*7*],
            [*8*],
            [*9*],
            [*14*],
            [*15*],
        ),

        [3.01], table.cell(colspan: 15)[#qty[5.0][V]],
        [3.02], table.cell(colspan: 15)[GND],

        table.cell(rowspan: 2)[3.03],
        [PD0],
        [AIN7],
        [-],
        [61],
        [SSI3Clk],
        [SSI1Clk],
        [I2C3SCL],
        [M0PWM6],
        [M1PWM0],
        [-],
        [WT2CCP2],
        [-],
        [-],
        [-],
        [-],

        [PB6],
        [-],
        [Connected for MSP430 Compatibility (R9)],
        [1],
        [-],
        [SSI2Rx],
        [-],
        [M0PWM0],
        [-],
        [-],
        [T0CCP0],
        [-],
        [-],
        [-],
        [-],

        table.cell(rowspan: 2)[3.04],
        [PD1],
        [AIN6],
        [-],
        [92],
        [SSI3Fss],
        [SSI1Fss],
        [I2C3SDA],
        [M0PWM7],
        [M1PWM1],
        [-],
        [WT2CCP1],
        [-],
        [-],
        [-],
        [-],

        [PB7],
        [-],
        [Connected for MSP430 Compatibility (R10)],
        [4],
        [-],
        [SSI2Tx],
        [-],
        [M0PWM1],
        [-],
        [-],
        [T0CCP1],
        [-],
        [-],
        [-],
        [-],

        [3.05],
        [PD2],
        [AIN5],
        [-],
        [63],
        [SSI3Rx],
        [SSI1Rx],
        [-],
        [M0FAULT0],
        [-],
        [-],
        [WT3CCP0],
        [USB0EPEN],
        [-],
        [-],
        [-],

        [3.06],
        [PD3],
        [AIN4],
        [-],
        [64],
        [SSI3Tx],
        [SSI1Tx],
        [-],
        [-],
        [-],
        [-],
        [WT3CCP1],
        [USB0PFLT],
        [-],
        [-],
        [-],

        [3.07],
        [PE1],
        [AIN2],
        [-],
        [8],
        [U7Tx],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],

        [3.08],
        [PE2],
        [AIN1],
        [-],
        [7],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],

        [3.09],
        [PE3],
        [AIN0],
        [-],
        [6],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],
        [-],

        [3.10],
        [PF1],
        [-],
        [-],
        [29],
        [U1CTS],
        [SSI1Tx],
        [-],
        [-],
        [M1PWM5],
        [-],
        [T0CCP1],
        [-],
        [C1o],
        [TRD1],
        [-],
    ))))

    #pagebreak()

    === J4 connector
    #align(center, pad(x: -5em, text(size: 8pt, table(
        align: center + horizon,
        inset: 0.5em,
        columns: 16,
        table.header(
            table.cell(rowspan: 2)[*J4 Pin*],
            table.cell(rowspan: 2)[*GPIO*],
            [*Analog Function*],
            table.cell(rowspan: 2)[*On-board Function*],
            table.cell(rowspan: 2)[*Tiva C Series MCU Pin*],
            table.cell(colspan: 11)[*GPIOPCTL Register Setting*],

            [*GPIO AMSEL*],
            [*1*],
            [*2*],
            [*3*],
            [*4*],
            [*5*],
            [*6*],
            [*7*],
            [*8*],
            [*9*],
            [*14*],
            [*15*],
        ),

        [4.01],
        [PF2],
        [-],
        [Blue LED (R11)],
        [30],
        [-],
        [SSI1Clk],
        [-],
        [M0FAULT0],
        [M1PWM6],
        [-],
        [T1CCP0],
        [-],
        [-],
        [-],
        [TRD0],

        [4.02],
        [PF3],
        [-],
        [Green LED (R12)],
        [31],
        [-],
        [SSI1Fss],
        [CAN0Tx],
        [-],
        [M1PWM7],
        [-],
        [T1CCP1],
        [-],
        [-],
        [-],
        [TRCLK],

        [4.03],
        [PB3],
        [-],
        [-],
        [48],
        [-],
        [-],
        [I2C0SDA],
        [-],
        [-],
        [-],
        [T3CCP1],
        [-],
        [-],
        [-],
        [-],

        [4.04],
        [PC4],
        [C1-],
        [-],
        [16],
        [U4Rx],
        [U1Rx],
        [-],
        [M0PWM6],
        [-],
        [IDX1],
        [WT0CCP0],
        [U1RTS],
        [-],
        [-],
        [-],

        [4.05],
        [PC5],
        [C1+],
        [-],
        [15],
        [U4Tx],
        [U1Tx],
        [-],
        [M0PWM7],
        [-],
        [PhA1],
        [WT0CCP1],
        [U1CTS],
        [-],
        [-],
        [-],

        [4.06],
        [PC6],
        [C0+],
        [-],
        [14],
        [U3Rx],
        [-],
        [-],
        [-],
        [-],
        [PhB1],
        [WT1CCP0],
        [USB0EPEN],
        [-],
        [-],
        [-],

        [4.07],
        [PC7],
        [C0-],
        [-],
        [13],
        [U3Tx],
        [-],
        [-],
        [-],
        [-],
        [-],
        [WT1CCP1],
        [USB0PFLT],
        [-],
        [-],
        [-],

        [4.08],
        [PD6],
        [-],
        [-],
        [53],
        [U2Rx],
        [-],
        [-],
        [-],
        [-],
        [PhA0],
        [WT5CCP0],
        [-],
        [-],
        [-],
        [-],

        [4.09],
        [PD7],
        [-],
        [-],
        [10],
        [U2Tx],
        [-],
        [-],
        [-],
        [-],
        [PhB0],
        [WT5CCP1],
        [NMI],
        [-],
        [-],
        [-],

        [4.10],
        [PF4],
        [-],
        [USR_SW1 (R13)],
        [5],
        [-],
        [-],
        [-],
        [-],
        [M1FAULT0],
        [IDX0],
        [T2CCP0],
        [USB0EPEN],
        [-],
        [-],
        [-],
    ))))

]

#{
    show table.cell: cell => {
        show regex("U\d[TR]x"): it => highlight(fill: yellow, extent: 0.2em, it)
        cell
    }
    jconnectors
}

#pagebreak()

== UART description and configuration
#grid(
    columns: 2,
    column-gutter: 5em,
    align: center + horizon,
    table(
        columns: 2,
        align: center + horizon,
        [U0], [U0TX #sym.arrow.r \ U0RX #sym.arrow.l],
        [U1], [U1TX #sym.arrow.r \ U1RX #sym.arrow.l],
        [U2], [U2TX #sym.arrow.r \ U2RX #sym.arrow.l],
        [U3], [U3TX #sym.arrow.r \ U3RX #sym.arrow.l],
        [U4], [U4TX #sym.arrow.r \ U4RX #sym.arrow.l],
        [U5], [U5TX #sym.arrow.r \ U5RX #sym.arrow.l],
        [U6], [U6TX #sym.arrow.r \ U6RX #sym.arrow.l],
        [U7], [U7TX #sym.arrow.r \ U7RX #sym.arrow.l],
    ),
    [
        *Register Map*:
        - UART0: `0x4000.C000`
        - UART1: `0x4000.D000`
        - UART2: `0x4000.E000`
        - UART3: `0x4000.F000`
        - UART4: `0x4001.0000`
        - UART5: `0x4001.1000`
        - UART6: `0x4001.2000`
        - UART7: `0x4001.3000`
    ],
)

Above are the 8 UART lines of the TM4C123GH6PM controller.

== UART register map
#table(
    columns: 5,
    align: center + horizon,
    table.header([*Offset*], [*Name*], [*Type*], [*Reset*], [*Description*]),
    [`0x000`], [UARTDR], [RW], [`0x0000.0000`], [UART Data],

    [`0x004`],
    [UARTRSR/UARTECR],
    [RW],
    [`0x0000.0000`],
    [UART Receive Status/Error Clear],

    [`0x018`], [UARTFR], [RO], [`0x0000.0090`], [UART Flag],

    [`0x020`],
    [UARTILPR],
    [RW],
    [`0x0000.0000`],
    [UART IrDA Low-Power Register],

    [`0x024`],
    [UARTIBRD],
    [RW],
    [`0x0000.0000`],
    [UART Integer Baud-Rate Divisor],

    [`0x028`],
    [UARTFBRD],
    [RW],
    [`0x0000.0000`],
    [UART Fractional Baud-Rate Divisor],

    [`0x02C`], [UARTLCRH], [RW], [`0x0000.0000`], [UART Line Control],
    [`0x030`], [UARTCTL], [RW], [`0x0000.0300`], [UART Control],

    [`0x034`],
    [UARTIFLS],
    [RW],
    [`0x0000.0012`],
    [UART Interrupt FIFO Level Select],

    [`0x038`], [UARTIM], [RW], [`0x0000.0000`], [UART Interrupt Mask],
    [`0x03C`], [UARTRIS], [RO], [`0x0000.0000`], [UART Raw Interrupt Status],
    [`0x040`], [UARTMIS], [RO], [`0x0000.0000`], [UART Masked Interrupt Status],
    [`0x044`], [UARTICR], [W1C], [`0x0000.0000`], [UART Interrupt Clear],
    [`0x048`], [UARTDMACTL], [RW], [`0x0000.0000`], [UART DMA Control],
    [`0x0A4`], [UART9BITADDR], [RW], [`0x0000.0000`], [UART 9-Bit Self Address],

    [`0x0A8`],
    [UART9BITAMASK],
    [RW],
    [`0x0000.00FF`],
    [UART 9-Bit Self Address Mask],

    [`0xFC0`], [UARTPP], [RO], [`0x0000.0003`], [UART Peripheral Properties],
    [`0xFC8`], [UARTCC], [RW], [`0x0000.0000`], [UART Clock Configuration],
)

== Essential registers
#cimage("./images/uart-essential-registers.png")

#pagebreak()

== Registers

#heading(level: 3, [
    Universal Asynchronous Receiver/Transmitter Run Mode Clock Gating Control
    (RCGCUART)
]) <rcgcuart>
- Base `0x400F.E000`
- Offset `0x618`
- Type RW, reset `0x0000.0000`

#cimage("./images/rcgcuart-register.png")

#align(center, table(

    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit.

        To provide compatibility with future products, the value of a reserved
        bit should be preserved across a read-modify-write operation.
    ],

    [7],
    [R7],
    [RW],
    [0],
    [
        UART Module 7 Run Mode Clock Gating Control

        #table(
            columns: 2,
            stroke: none,

            table.header([Value], [Description]),
            [0], [UART module 7 is disabled.],
            [1], [Enable and provide a clock to UART module 7 in Run mode.],
        )
    ],

    [6],
    [R6],
    [RW],
    [0],
    [
        UART Module 6 Run Mode Clock Gating Control

        #table(
            columns: 2,
            stroke: none,

            table.header([Value], [Description]),
            [0], [UART module 6 is disabled.],
            [1], [Enable and provide a clock to UART module 6 in Run mode.],
        )
    ],

    [5],
    [R5],
    [RW],
    [0],
    [
        UART Module 5 Run Mode Clock Gating Control

        #table(
            columns: 2,
            stroke: none,

            table.header([Value], [Description]),
            [0], [UART module 5 is disabled.],
            [1], [Enable and provide a clock to UART module 5 in Run mode.],
        )
    ],

    [4],
    [R4],
    [RW],
    [0],
    [
        UART Module 4 Run Mode Clock Gating Control

        #table(
            columns: 2,
            stroke: none,

            table.header([Value], [Description]),
            [0], [UART module 4 is disabled.],
            [1], [Enable and provide a clock to UART module 4 in Run mode.],
        )

        #v(10em)
    ],

    [3],
    [R3],
    [RW],
    [0],
    [
        UART Module 3 Run Mode Clock Gating Control

        #table(
            columns: 2,
            stroke: none,

            table.header([Value], [Description]),
            [0], [UART module 3 is disabled.],
            [1], [Enable and provide a clock to UART module 3 in Run mode.],
        )
    ],

    [2],
    [R2],
    [RW],
    [0],
    [
        UART Module 2 Run Mode Clock Gating Control

        #table(
            columns: 2,
            stroke: none,

            table.header([Value], [Description]),
            [0], [UART module 2 is disabled.],
            [1], [Enable and provide a clock to UART module 2 in Run mode.],
        )
    ],

    [1],
    [R1],
    [RW],
    [0],
    [
        UART Module 1 Run Mode Clock Gating Control

        #table(
            columns: 2,
            stroke: none,

            table.header([Value], [Description]),
            [0], [UART module 1 is disabled.],
            [1], [Enable and provide a clock to UART module 1 in Run mode.],
        )
    ],

    [0],
    [R0],
    [RW],
    [0],
    [
        UART Module 0 Run Mode Clock Gating Control

        #table(
            columns: 2,
            stroke: none,

            table.header([Value], [Description]),
            [0], [UART module 0 is disabled.],
            [1], [Enable and provide a clock to UART module 0 in Run mode.],
        )
    ],
))

#pagebreak()

=== UART Integer Baud-Rate Divisor (UARTIBRD)
<uartibrd>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x024`
- Type RW, reset `0x0000.0000`

#cimage("./images/uartibrd-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit.

        To provide compatibility with future products, the value of a reserved
        bit should be preserved across a read-modify-write operation.

    ],

    [15:0],
    [DIVINT],
    [RW],
    [`0x0000`],
    [
        Integer Baud-Rate Divisor
    ],
))

#pagebreak()

=== UART Fractional Baud-Rate Divisor (UARTFBRD)
<uartfbrd>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x028`
- Type RW, reset `0x0000.0000`

#cimage("./images/uartfbrd-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:6],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit.

        To provide compatibility with future products, the value of a reserved
        bit should be preserved across a read-modify-write operation.

    ],

    [5:0],
    [DIVFRAC],
    [RW],
    [`0x0`],
    [
        Fractional Baud-Rate Divisor
    ],
))

#pagebreak()

=== UART Line Control (UARTLCRH)
<uartlcrh>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x02C`
- Type RW, reset `0x0000.0000`

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit.

        To provide compatibility with future products, the value of a reserved
        bit should be preserved across a read-modify-write operation.
    ],

    [7],
    [SPS],
    [RW],
    [`0`],
    [
        UART Stick Parity Select

        When bits 1, 2, and 7 of #link(<uartlcrh>)[UARTLCRH] are set, the parity
        bit is transmitted and checked as a 0. When bits 1 and 7 are set and 2
        is cleared, the parity bit is transmitted and checked as a 1.

        When this bit is cleared, stick parity is disabled.
    ],

    [6:5],
    [WLEN],
    [RW],
    [`0x0`],
    [
        UART Word Length The bits indicate the number of data bits transmitted
        or received in a frame as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,

            [Value], [Description],

            [`0x0`], [5 bits (default)],
            [`0x1`], [6 bits],
            [`0x2`], [7 bits],
            [`0x3`], [8 bits],
        )
    ],

    [4],
    [FEN],
    [RW],
    [0],
    [
        UART Enable FIFOs

        #table(
            columns: 2,
            align: left,
            stroke: none,
            [Value], [Description],
            [0],
            [
                The FIFOs are disabled (Character mode). The FIFOs become
                1-byte-deep holding registers.
            ],

            [1],
            [The transmit and receive FIFO buffers are enabled (FIFO mode).],
        )

        #v(10em)
    ],

    [3],
    [STP2],
    [RW],
    [0],
    [
        UART Two Stop Bits Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            [Value], [Description],
            [0], [One stop bit is transmitted at the end of a frame.],
            [1],
            [
                Two stop bits are transmitted at the end of a frame. The receive
                logic does not check for two stop bits being received.

                When in 7816 smartcard mode (the `SMART` bit is set in the
                #link(<uartctl>)[*UARTCTL*] register), the number of stop bits
                is forced to 2.
            ],
        )
    ],

    [2],
    [EPS],
    [RW],
    [0],
    [
        UART Even Parity Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            [Value], [Description],
            [0],
            [Odd parity is performed, which checks for an odd number of 1s.],

            [1],
            [
                Even parity generation and checking is performed during
                transmission and reception, which checks for an even number of
                1s in data and parity bits.
            ],
        )

        This bit has no effect when parity is disabled by the `PEN` bit.
    ],

    [1],
    [PEN],
    [RW],
    [0],
    [
        UART Parity Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            [Value], [Description],

            [0],
            [Parity is disabled and no parity bit is added to the data frame.],

            [1], [Parity checking and generation is enabled.],
        )
    ],

    [0],
    [BRK],
    [RW],
    [0],
    [
        UART Send Break

        #table(
            columns: 2,
            align: left,
            stroke: none,
            [Value], [Description],
            [0], [Normal use.],
            [1],
            [
                A Low level is continually output on the `UnTx` signal, after
                completing transmission of the current character. For the proper
                execution of the break command, software must set this bit for
                at least two frames (character periods).
            ],
        )
    ],
))

#pagebreak()

=== UART Clock Configuration (UARTCC)
<uartcc>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0xFC8`
- Type RW, reset `0x0000.0000`

#cimage("./images/uartcc-register.png")

#align(center, table(
    columns: 5,
    align: left,

    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit.

        To provide compatibility with future products, the value of a reserved
        bit should be preserved across a read-modify-write operation.

    ],

    [3:0],
    [CS],
    [RW],
    [0],
    [
        UART Baud Clock Source

        The following table specifies the source that generates for the UART
        baud clock:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            [Value], [Description],
            [`0x0`], [System clock (based on clock source and divisor factor)],
            [`0x1-0x4`], [Reserved],
            [`0x5`], [PIOSC],
            [`0x5-0xF`], [Reserved],
        )
    ],
))

#pagebreak()

=== UART DMA Control (UARTDMACTL)
<uartdmactl>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x048`
- Type RW, reset `0x0000.0000`

#cimage("./images/uartdmactl-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:3],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [2],
    [DMAERR],
    [RW],
    [0],
    [
        DMA on Error
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [µDMA receive requests are unaffected when a receive error occurs.],

            [1],
            [µDMA receive requests are automatically disabled when a receive
                error occurs.],
        )
    ],

    [1],
    [TXDMAE],
    [RW],
    [0],
    [
        Transmit DMA Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [µDMA for the transmit FIFO is disabled.],
            [1], [µDMA for the transmit FIFO is enabled.],
        )
    ],

    [0],
    [RXDMAE],
    [RW],
    [0],
    [
        Receive DMA Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [µDMA for the receive FIFO is disabled.],
            [1], [µDMA for the receive FIFO is enabled.],
        )
    ],
))

#pagebreak()

=== UART Control (UARTCTL)
<uartctl>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x030`
- Type RW, reset `0x0000.0300`

The UARTCTL register is the control register. All the bits are cleared on reset
except for the Transmit Enable (TXE) and Receive Enable (RXE) bits, which are
set.
- To enable the UART module, the `UARTEN` bit must be set.
- If software requires a configuration change in the module, the `UARTEN` bit
    must be cleared before the configuration changes are written.
- If the UART is disabled during a transmitting or receiving operation, the
    current transaction is completed prior to the UART stopping.
- *Note*: The #link(<uartctl>)[UARTCTL] register should not be changed while the
    UART is enabled, otherwise the results may be unpredictable.

Making changes to the #link(<uartctl>)[UARTCTL] register:
+ Disable the UART, by clearing the `UARTEN` bit.
+ Wait for the end of transmission or reception of the current character, by
    writing a few lines of NOP.
+ Flush the transmission FIFO by clearing bit 4 (FEN) FIFO enable in the line
    control register (#link(<uartlcrh>)[UARTLCRH]).
+ Reprogram the control register.
+ Enabel the UART by setting the `UARTEN` bit.

#cimage("./images/uartctl-register.png")
#pagebreak()

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15],
    [CTSEN],
    [RW],
    [0],
    [
        Enable Clear To Send
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [CTS hardware flow control is disabled.],
            [1],
            [
                CTS hardware flow control is enabled. Data is only transmitted
                when the `U1CTS` signal is asserted.
            ],
        )
    ],

    [14],
    [RTSEN],
    [RW],
    [0],
    [
        Enable Request to Send
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [RTS hardware flow control is disabled.],
            [1],
            [
                RTS hardware flow control is enabled. Data is only requested (by
                asserting `U1RTS`) when the receive FIFO has available entries.
            ],
        )
    ],

    [13:12],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11],
    [RTS],
    [RW],
    [0],
    [
        Request to Send When `RTSEN` is clear, the status of this bit is
        reflected on the `U1RTS` signal. If `RTSEN` is set, this bit is ignored
        on a write and should be ignored on read.
    ],

    [10],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [9],
    [RXE],
    [RW],
    [1],
    [
        UART Receive Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The receive section of the UART is disabled.],
            [1], [The receive section of the UART is enabled.],
        )

        If the UART is disabled in the middle of a receive, it completes the
        current character before stopping.

        *Note:* To enable reception, the `UARTEN` bit must also be set.

        #v(10em)
    ],

    [8],
    [TXE],
    [RW],
    [1],
    [
        UART Transmit Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The transmit section of the UART is disabled.],
            [1], [The transmit section of the UART is enabled.],
        )
        If the UART is disabled in the middle of a transmission, it completes
        the current character before stopping.

        *Note:* To enable transmission, the `UARTEN` bit must also be set.
    ],

    [7],
    [LBE],
    [RW],
    [0],
    [
        UART Loop Back Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [Normal operation.],
            [1], [The `UnTx` path is fed through the `UnRx` path.],
        )
    ],

    [6],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [5],
    [HSE],
    [RW],
    [0],
    [
        High-Speed Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The UART is clocked using the system clock divided by 16.],
            [1], [The UART is clocked using the system clock divided by 8.],
        )
        *Note:* System clock used is also dependent on the baud-rate divisor
        configuration (see @uartibrd and @uartfbrd).

        The state of this bit has no effect on clock generation in ISO 7816
        smart card mode (the `SMART` bit is set).
    ],

    [4],
    [EOT],
    [RW],
    [0],
    [
        End of Transmission

        This bit determines the behavior of the `TXRIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                The `TXRIS` bit is set when the transmit FIFO condition
                specified in #link(<uartifls>)[*UARTIFLS*] is met.
            ],

            [1],
            [
                The `TXRIS` bit is set only after all transmitted data,
                including stop bits, have cleared the serializer.
            ],
        )

        #v(10em)
    ],

    [3],
    [SMART],
    [RW],
    [0],
    [
        ISO 7816 Smart Card Support
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [Normal operation.],
            [1], [The UART operates in Smart Card mode.],
        )
        The application must ensure that it sets 8-bit word length (`WLEN` set
        to `0x3`) and even parity (`PEN` set to 1, `EPS` set to 1, `SPS` set to
        0) in #link(<uartlcrh>)[*UARTLCRH*] when using ISO 7816 mode.

        In this mode, the value of the `STP2` bit in #link(
            <uartlcrh>,
        )[*UARTLCRH*] is ignored and the number of stop bits is forced to 2.
        Note that the UART does not support automatic retransmission on parity
        errors. If a parity error is detected on transmission, all further
        transmit operations are aborted and software must handle retransmission
        of the affected byte or message.
    ],

    [2],
    [SIRLP],
    [RW],
    [0],
    [
        UART SIR Low-Power Mode

        This bit selects the IrDA encoding mode.
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                Low-level bits are transmitted as an active High pulse with a
                width of 3/16th of the bit period.
            ],

            [1],
            [
                The UART operates in SIR Low-Power mode. Low-level bits are
                transmitted with a pulse width which is 3 times the period of
                the `IRLPBaud16` input signal, regardless of the selected bit
                rate.
            ],
        )
        Setting this bit uses less power, but might reduce transmission
        distances.
    ],

    [1],
    [SIREN],
    [RW],
    [0],
    [
        UART SIR Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [Normal operation.],
            [1],
            [
                The IrDA SIR block is enabled, and the UART will transmit and
                receive data using SIR protocol.
            ],
        )

        #v(10em)
    ],

    [0],
    [UARTEN],
    [RW],
    [0],
    [
        UART Enable
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The UART is disabled.],
            [1], [The UART is enabled.],
        )
        If the UART is disabled in the middle of transmission or reception, it
        completes the current character before stopping.
    ],
))

#pagebreak()

=== UART Data (UARTDR)
<uartdr>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x000`
- Type RW, reset `0x0000.0000`

#cimage("./images/uartdr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:12],
    [reserved],
    [RO],
    [`0x0000.0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11],
    [OE],
    [RO],
    [0],
    [
        UART Overrun Error
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No data has been lost due to a FIFO overrun.],
            [1],
            [
                New data was received when the FIFO was full, resulting in data
                loss.
            ],
        )
    ],

    [10],
    [BE],
    [RO],
    [0],
    [
        UART Break Error

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No break condition has occurred],
            [1],
            [
                A break condition has been detected, indicating that the receive
                data input was held Low for longer than a full-word transmission
                time (defined as start, data, parity, and stop bits).
            ],
        )
        In FIFO mode, this error is associated with the character at the top of
        the FIFO. When a break occurs, only one 0 character is loaded into the
        FIFO. The next character is only enabled after the received data input
        goes to a 1 (marking state), and the next valid start bit is received.

        #v(10em)
    ],

    [9],
    [PE],
    [RO],
    [0],
    [
        UART Parity Error

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No parity error has occurred],
            [1],
            [
                The parity of the received data character does not match the
                parity defined by bits 2 and 7 of the #link(
                    <uartlcrh>,
                )[*UARTLCRH*] register.
            ],
        )
        In FIFO mode, this error is associated with the character at the top of
        the FIFO.
    ],

    [8],
    [FE],
    [RO],
    [0],
    [
        UART Framing Error

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No framing error has occurred],
            [1],
            [
                The received character does not have a valid stop bit (a valid
                stop bit is 1).
            ],
        )
    ],

    [7:0],
    [DATA],
    [RW],
    [`0x00`],
    [
        Data Transmitted or Received

        Data that is to be transmitted via the UART is written to this field.
        When read, this field contains the data that was received by the UART.
    ],
))

#pagebreak()

=== UART Flag (UARTFR)
<uartfr>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x018`
- Type RO, reset `0x0000.0090`

#cimage("./images/uartfr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),
    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7],
    [TXFE],
    [RO],
    [1],
    [
        UART Transmit FIFO Empty

        The meaning of this bit depends on the state of the `FEN` bit in the
        #link(<uartlcrh>)[*UARTLCRH*] register.
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The transmitter has data to transmit.],
            [1],
            [
                If the FIFO is disabled (`FEN` is 0), the transmit holding
                register is empty. If the FIFO is enabled (`FEN` is 1), the
                transmit FIFO is empty.
            ],
        )
    ],

    [6],
    [RXFF],
    [RO],
    [0],
    [
        UART Receive FIFO Full

        The meaning of this bit depends on the state of the `FEN` bit in the
        #link(<uartlcrh>)[*UARTLCRH*] register.
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The receiver can receive data.],
            [1],
            [
                If the FIFO is disabled (`FEN` is 0), the receive holding
                register is full. If the FIFO is enabled (`FEN` is 1), the
                receive FIFO is full.
            ],
        )

        #v(10em)
    ],

    [5],
    [TXFF],
    [RO],
    [0],
    [
        UART Transmit FIFO Full

        The meaning of this bit depends on the state of the `FEN` bit in the
        #link(<uartlcrh>)[*UARTLCRH*] register.
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The transmitter is not full.],
            [1],
            [
                If the FIFO is disabled (`FEN` is 0), the transmit holding
                register is full. If the FIFO is enabled (`FEN` is 1), the
                transmit FIFO is full.
            ],
        )
    ],

    [4],
    [RXFE],
    [RO],
    [1],
    [
        UART Receive FIFO Empty

        The meaning of this bit depends on the state of the `FEN` bit in the
        #link(<uartlcrh>)[*UARTLCRH*] register.
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The receiver is not empty.],
            [1],
            [
                If the FIFO is disabled (`FEN` is 0), the receive holding
                register is empty. If the FIFO is enabled (`FEN` is 1), the
                receive FIFO is empty.
            ],
        )
    ],

    [3],
    [BUSY],
    [RO],
    [0],
    [
        UART Busy

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The UART is not busy.],
            [1],
            [
                The UART is busy transmitting data. This bit remains set until
                the complete byte, including all stop bits, has been sent from
                the shift register.
            ],
        )
        This bit is set as soon as the transmit FIFO becomes non-empty
        (regardless of whether UART is enabled).
    ],

    [2:1],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [0],
    [CTS],
    [RO],
    [0],
    [
        Clear To Send

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The `U1CTS` signal is not asserted.],
            [1], [The `U1CTS` signal is asserted.],
        )
    ],
))

#pagebreak()

=== UART Raw Interrupt Status (UARTRIS)
<uartris>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x03C`
- Type RO, reset `0x0000.0000`

#cimage("./images/uartris-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:13],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [12],
    [9BITRIS],
    [RO],
    [0],
    [
        9-Bit Mode Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No interrupt],
            [1], [A receive address match has occurred.],
        )
        This bit is cleared by writing a 1 to the `9BITIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.
    ],

    [11],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [10],
    [OERIS],
    [RO],
    [0],
    [
        UART Overrun Error Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No interrupt],
            [1], [An overrun error has occurred.],
        )
        This bit is cleared by writing a 1 to the `OEIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.

        #v(10em)
    ],

    [9],
    [BERIS],
    [RO],
    [0],
    [
        UART Break Error Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No interrupt],
            [1], [A break error has occurred.],
        )
        This bit is cleared by writing a 1 to the `BEIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.
    ],

    [8],
    [PERIS],
    [RO],
    [0],
    [
        UART Parity Error Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No interrupt],
            [1], [A parity error has occurred.],
        )
        This bit is cleared by writing a 1 to the `PEIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.
    ],

    [7],
    [FERIS],
    [RO],
    [0],
    [
        UART Framing Error Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No interrupt],
            [1], [A framing error has occurred.],
        )
        This bit is cleared by writing a 1 to the `FEIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.
    ],

    [6],
    [RTRIS],
    [RO],
    [0],
    [
        UART Receive Time-Out Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No interrupt],
            [1], [A receive time out has occurred.],
        )
        This bit is cleared by writing a 1 to the `RTIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register. For receive timeout, the `RTIM` bit in the #link(
            <uartim>,
        )[*UARTIM*] register must be set to see the `RTRIS` status.

        #v(20em)
    ],

    [5],
    [TXRIS],
    [RO],
    [0],
    [
        UART Transmit Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No interrupt],
            [1],
            [
                If the `EOT` bit in the #link(<uartctl>)[*UARTCTL*] register is
                clear, the transmit FIFO level has passed through the condition
                defined in the #link(<uartifls>)[*UARTIFLS*] register.

                If the `EOT` bit is set, the last bit of all transmitted data
                and flags has left the serializer.
            ],
        )
        This bit is cleared by writing a 1 to the `TXIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register or by writing data to the transmit FIFO until it
        becomes greater than the trigger level, if the FIFO is enabled, or by
        reading a single byte if the FIFO is disabled.
    ],

    [4],
    [RXRIS],
    [RO],
    [0],
    [
        UART Receive Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No interrupt],
            [1],
            [The receive FIFO level has passed through the condition defined in
                the #link(<uartifls>)[*UARTIFLS*] register.],
        )
        This bit is cleared by writing a 1 to the `RXIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register or by reading data from the receive FIFO until it
        becomes less than the trigger level, if the FIFO is enabled, or by
        reading a single byte if the FIFO is disabled.
    ],

    [3:2],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1],
    [CTSRIS],
    [RO],
    [0],
    [
        UART Clear to Send Modem Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [No interrupt],
            [1], [Clear to Send used for software flow control.],
        )
        This bit is cleared by writing a 1 to the `CTSIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.

        This bit is implemented only on UART1 and is reserved for UART0 and
        UART2.

        #v(10em)
    ],

    [0],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],
))

#pagebreak()

=== UART Interrupt Mask (UARTIM)
<uartim>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x038`
- Type RW, reset `0x0000.0000`

#cimage("./images/uartim-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),
    [31:13],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [12],
    [9BITIM],
    [RW],
    [0],
    [
        9-Bit Mode Interrupt Mask

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                The `9BITRIS` interrupt is suppressed and not sent to the
                interrupt controller.
            ],

            [1],
            [
                An interrupt is sent to the interrupt controller when the
                `9BITRIS` bit in the #link(<uartris>)[*UARTRIS*] register is
                set.
            ],
        )
    ],

    [11],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [10],
    [OEIM],
    [RW],
    [0],
    [
        UART Overrun Error Interrupt Mask

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [The `OERIS` interrupt is suppressed and not sent to the interrupt
                controller.],

            [1],
            [
                An interrupt is sent to the interrupt controller when the
                `OERIS` bit in the #link(<uartris>)[*UARTRIS*] register is set.
            ],
        )

        #v(10em)
    ],

    [9],
    [BEIM],
    [RW],
    [0],
    [
        UART Break Error Interrupt Mask

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                The `BERIS` interrupt is suppressed and not sent to the
                interrupt controller.
            ],

            [1],
            [
                An interrupt is sent to the interrupt controller when the
                `BERIS` bit in the #link(<uartris>)[*UARTRIS*] register is set.
            ],
        )
    ],

    [8],
    [PEIM],
    [RW],
    [0],
    [
        UART Parity Error Interrupt Mask

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                The `PERIS` interrupt is suppressed and not sent to the
                interrupt controller.
            ],

            [1],
            [
                An interrupt is sent to the interrupt controller when the
                `PERIS` bit in the #link(<uartris>)[*UARTRIS*] register is set.
            ],
        )
    ],

    [7],
    [FEIM],
    [RW],
    [0],
    [
        UART Framing Error Interrupt Mask

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                The `FERIS` interrupt is suppressed and not sent to the
                interrupt controller.
            ],

            [1],
            [
                An interrupt is sent to the interrupt controller when the
                `FERIS` bit in the #link(<uartris>)[*UARTRIS*] register is set.
            ],
        )
    ],

    [6],
    [RTIM],
    [RW],
    [0],
    [
        UART Receive Time-Out Interrupt Mask

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                The `RTRIS` interrupt is suppressed and not sent to the
                interrupt controller.
            ],

            [1],
            [
                An interrupt is sent to the interrupt controller when the
                `RTRIS` bit in the #link(<uartris>)[*UARTRIS*] register is set.
            ],
        )
    ],

    [5],
    [TXIM],
    [RW],
    [0],
    [
        UART Transmit Interrupt Mask

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                The `TXRIS` interrupt is suppressed and not sent to the
                interrupt controller.
            ],

            [1],
            [
                An interrupt is sent to the interrupt controller when the
                `TXRIS` bit in the #link(<uartris>)[*UARTRIS*] register is set.
            ],
        )
        #v(10em)
    ],

    [4],
    [RXIM],
    [RW],
    [0],
    [
        UART Receive Interrupt Mask

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                The `RXRIS` interrupt is suppressed and not sent to the
                interrupt controller.
            ],

            [1],
            [
                An interrupt is sent to the interrupt controller when the
                `RXRIS` bit in the #link(<uartris>)[*UARTRIS*] register is set.
            ],
        )
    ],

    [3:2],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1],
    [CTSIM],
    [RW],
    [0],
    [
        UART Clear to Send Modem Interrupt Mask

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [The `CTSRIS` interrupt is suppressed and not sent to the interrupt
                controller.],

            [1],
            [
                An interrupt is sent to the interrupt controller when the
                `CTSRIS` bit in the #link(<uartris>)[*UARTRIS*] register is set.
            ],
        )
        This bit is implemented only on UART1 and is reserved for UART0 and
        UART2.
    ],

    [0],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],
))

#pagebreak()

=== UART Masked Interrupt Status (UARTMIS)
<uartmis>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x040`
- Type RO, reset `0x0000.0000`

#cimage("./images/uartmis-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:13],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [12],
    [9BITMIS],
    [RO],
    [0],
    [
        9-Bit Mode Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [An interrupt has not occurred or is masked.],
            [1],
            [
                An unmasked interrupt was signaled due to a receive address
                match.
            ],
        )
        This bit is cleared by writing a 1 to the `9BITIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.
    ],

    [11],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [10],
    [OEMIS],
    [RO],
    [0],
    [
        UART Overrun Error Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [An interrupt has not occurred or is masked.],
            [1],
            [
                An unmasked interrupt was signaled due to an overrun error.
            ],
        )

        This bit is cleared by writing a 1 to the `OEIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.

        #v(10em)
    ],

    [9],
    [BEMIS],
    [RO],
    [0],
    [
        UART Break Error Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [An interrupt has not occurred or is masked.],
            [1], [An unmasked interrupt was signaled due to a break error.],
        )

        This bit is cleared by writing a 1 to the `BEIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.
    ],

    [8],
    [PEMIS],
    [RO],
    [0],
    [
        UART Parity Error Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [An interrupt has not occurred or is masked.],
            [1], [An unmasked interrupt was signaled due to a parity error.],
        )

        This bit is cleared by writing a 1 to the `PEIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.
    ],

    [7],
    [FEMIS],
    [RO],
    [0],
    [
        UART Framing Error Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [An interrupt has not occurred or is masked.],
            [1], [An unmasked interrupt was signaled due to a framing error.],
        )

        This bit is cleared by writing a 1 to the `FEIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register.
    ],

    [6],
    [RTMIS],
    [RO],
    [0],
    [
        UART Receive Time-Out Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [An interrupt has not occurred or is masked.],
            [1],
            [An unmasked interrupt was signaled due to a receive time out.],
        )

        This bit is cleared by writing a 1 to the `RTIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register. For receive timeout, the `RTIM` bit in the #link(
            <uartim>,
        )[*UARTIM*] register must be set to see the `RTMIS` status.

        #v(20em)
    ],

    [5],
    [TXMIS],
    [RO],
    [0],
    [
        UART Transmit Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [An interrupt has not occurred or is masked.],
            [1],
            [
                An unmasked interrupt was signaled due to passing through the
                specified transmit FIFO level (if the `EOT` bit is clear) or due
                to the transmission of the last data bit (if the `EOT` bit is
                set).
            ],
        )
        This bit is cleared by writing a 1 to the `TXIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register or by writing data to the transmit FIFO until it
        becomes greater than the trigger level, if the FIFO is enabled, or by
        writing a single byte if the FIFO is disabled.
    ],

    [4],
    [RXMIS],
    [RO],
    [0],
    [
        UART Receive Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [An interrupt has not occurred or is masked.],
            [1],
            [An unmasked interrupt was signaled due to passing through the
                specified receive FIFO level.],
        )

        This bit is cleared by writing a 1 to the `RXIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register or by reading data from the receive FIFO until it
        becomes less than the trigger level, if the FIFO is enabled, or by
        reading a single byte if the FIFO is disabled.
    ],

    [3:2],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1],
    [CTSMIS],
    [RO],
    [0],
    [
        UART Clear to Send Modem Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [An interrupt has not occurred or is masked.],
            [1], [An unmasked interrupt was signaled due to Clear to Send.],
        )

        This bit is cleared by writing a 1 to the `CTSIC` bit in the #link(
            <uarticr>,
        )[*UARTICR*] register. This bit is implemented only on UART1 and is
        reserved for UART0 and UART2.
    ],

    [0],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],
))

#pagebreak()

=== UART Interrupt Clear (UARTICR)
<uarticr>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x044`
- Type W1C, reset `0x0000.0000`

#cimage("./images/uarticr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:13],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [12],
    [9BITIC],
    [RW],
    [0],
    [
        9-Bit Mode Interrupt Clear

        Writing a 1 to this bit clears the `9BITRIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register and the `9BITMIS` bit in the #link(
            <uartmis>,
        )[*UARTMIS*] register.
    ],

    [11],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [10],
    [OEIC],
    [W1C],
    [0],
    [
        Overrun Error Interrupt Clear

        Writing a 1 to this bit clears the `OERIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register and the `OEMIS` bit in the #link(
            <uartmis>,
        )[*UARTMIS*] register.
    ],

    [9],
    [BEIC],
    [W1C],
    [0],
    [
        Break Error Interrupt Clear

        Writing a 1 to this bit clears the `BERIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register and the `BEMIS` bit in the #link(
            <uartmis>,
        )[*UARTMIS*] register.
    ],

    [8],
    [PEIC],
    [W1C],
    [0],
    [
        Parity Error Interrupt Clear

        Writing a 1 to this bit clears the `PERIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register and the `PEMIS` bit in the #link(
            <uartmis>,
        )[*UARTMIS*] register.

        #v(10em)
    ],

    [7],
    [FEIC],
    [W1C],
    [0],
    [
        Framing Error Interrupt Clear

        Writing a 1 to this bit clears the `FERIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register and the `FEMIS` bit in the #link(
            <uartmis>,
        )[*UARTMIS*] register.
    ],

    [6],
    [RTIC],
    [W1C],
    [0],
    [
        Receive Time-Out Interrupt Clear

        Writing a 1 to this bit clears the `RTRIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register and the `RTMIS` bit in the #link(
            <uartmis>,
        )[*UARTMIS*] register.
    ],

    [5],
    [TXIC],
    [W1C],
    [0],
    [
        Transmit Interrupt Clear

        Writing a 1 to this bit clears the `TXRIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register and the `TXIM` bit in the #link(
            <uartmis>,
        )[*UARTMIS*] register.
    ],

    [4],
    [RXIC],
    [W1C],
    [0],
    [
        Receive Interrupt Clear

        Writing a 1 to this bit clears the `RXRIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register and the `RXIM` bit in the #link(
            <uartmis>,
        )[*UARTMIS*] register.
    ],

    [3:2],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1],
    [CTSMIC],
    [W1C],
    [0],
    [
        UART Clear to Send Modem Interrupt Clear

        Writing a 1 to this bit clears the `CTSRIS` bit in the #link(
            <uartris>,
        )[*UARTRIS*] register and the `CTSIM` bit in the #link(
            <uartmis>,
        )[*UARTMIS*] register.

        This bit is implemented only on UART1 and is reserved for UART0 and
        UART2.
    ],

    [0],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],
))

#pagebreak()

=== UART Interrupt FIFO Level Select (UARTIFLS)
<uartifls>
- UART0 base: `0x4000.C000`
- UART1 base: `0x4000.D000`
- UART2 base: `0x4000.E000`
- UART3 base: `0x4000.F000`
- UART4 base: `0x4001.0000`
- UART5 base: `0x4001.1000`
- UART6 base: `0x4001.2000`
- UART7 base: `0x4001.3000`
- Offset `0x034`
- Type RW, reset `0x0000.0012`

#cimage("./images/uartifls-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:6],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [5:3],
    [RXIFLSEL],
    [RW],
    [`0x2`],
    [
        UART Receive Interrupt FIFO Level Select

        The trigger points for the receive interrupt are as follows:
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [`0x0`], [RX FIFO $>=$ $1/8$ full],
            [`0x1`], [RX FIFO $>=$ $1/4$ full],
            [`0x2`], [RX FIFO $>=$ $1/2$ full (default)],
            [`0x3`], [RX FIFO $>=$ $3/4$ full],
            [`0x4`], [RX FIFO $>=$ $7/8$ full],
            [`0x5-0x7`], [Reserved],
        )

        #v(20em)
    ],

    [2:0],
    [TXIFLSEL],
    [RW],
    [`0x2`],
    [
        UART Transmit Interrupt FIFO Level Select

        The trigger points for the transmit interrupt are as follows:
        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [`0x0`], [TX FIFO $<=$ $7/8$ empty],
            [`0x1`], [TX FIFO $<=$ $3/4$ empty],
            [`0x2`], [TX FIFO $<=$ $1/2$ empty (default)],
            [`0x3`], [TX FIFO $<=$ $1/4$ empty],
            [`0x4`], [TX FIFO $<=$ $1/8$ empty],
            [`0x5-0x7`], [Reserved],
        )
        *Note:* If the `EOT` bit in #link(<uartctl>)[*UARTCTL*] is set, the
        transmit interrupt is generated once the FIFO is completely empty and
        all data including stop bits have left the transmit serializer. In this
        case, the setting of `TXIFLSEL` is ignored.
    ],
))

#pagebreak()

== Initialisation and configuration
To initialise the UART, the follow steps are necessary:
+ Enable the UART module with the #link(<rcgcuart>)[*RCGCUART*] register.
+ Enable the clock to the appropriate GPIO module via the #link(
        <rcgcgpio>,
    )[*RCGCGPIO*] register.
+ Set the #link(<gpioafsel>)[*GPIOAFSEL*] bits for the appropriate pins.
+ Configure the GPIO current (in #unit[mA]) level and slew rate as specified for
    the mode selected.
+ Configure the Port Mux Control (PMCn) fields in the #link(
        <gpiopctl>,
    )[*GPIOPCTL*] register to assign the UART signals to the appropriate pins.
+ Write the desired serial parameters to the #link(<uartlcrh>)[*UARTLCRH*]
    register.
+ Configure the UART clock source by writing to the #link(<uartcc>)[*UARTCC*]
    register. Bits 3:0 set to 0 to use system clock.
+ Optionally, configure the μDMA channel and enable the DMA options in the
    #link(<uartdmactl>)[*UARTDMACTL*] register.

== UART baud rate settings
- When programming the UART baud rate, you need to calculate the baud-rate
    divider (BRD) first.
- Then the #link(<uartibrd>)[*UARTIBRD*] and #link(<uartfbrd>)[*UARTFBRD*]
    registers are determined.
- Finally, write to the #link(<uartlcrh>)[*UART Line Control (UARTLCRH)*]
    register.

== Baud rate setting
- Registers #link(<uartibrd>)[*UARTIBRD*] and #link(<uartfbrd>)[*UARTFBRD*] set
    the baud rate.
    #cimage("./images/uart-baud-rate-setting.png")
- 22 (16.6) bit binary fixed point value with 2#super[-6] resolution.
    - *DIVINT* (integer -16 binary places)
    - *DIVFRAC* (fractional -6 binary places)
- *Baud16* clock is created with a frequency of
    $"Bus clock frequency"/"Divider"$
- *Baud16* clock is 16x of Baud rate.

$ "Baud rate divider" = "Bus clock" div 16 div "Baud rate" $

=== Example
If the bus clock is #qty[8][MHz], then the baud rate required is
#qty[19200][bits s^-1]. Then:
$ "Baud rate divider" = 8,000,000 div 16 div 19200 = 26.04167 $
$ "Integer part": 26 = 11010_2 = "0x1A" $
$ "Fractional part": 0.04167 $

#pagebreak()

==== How to convert fractions in decimal to binary?
0.04167 to binary:
$ 0.04167 * 2 = 0.08334 -> 0 $
$ 0.08334 * 2 = 0.16668 -> 0 $
$ 0.16668 * 2 = 0.33336 -> 0 $
$ 0.33336 * 2 = 0.66672 -> 0 $
$ 0.66672 * 2 = 1.33344 -> 1 $
$ 0.33344 * 2 = 0.66688 -> 0 $
$ 0.66688 * 2 = 1.33376 -> 1 $

Hence:
$ 0.04167 = 0.0000101_2 "or" 0.000011_2 "(6 places)" $

Faster way:
+ Multiply the fractional part by 2 to the power of the number of decimal places
    you need, i.e.
    $ "Fractional part" times 2^n $

    Where $n$ is the number of decimal places needed.
+ Round the result to the nearest whole number and convert the result to binary.

Example:
$
    0.04167 times 2^6 & = 2.667 \
                      & approx 3_10 = 000011_2 = "0x03"_16
$

==== Continuing the example
$ 26.04167 = 11010.000011_2 $

To have 19200 baud rate:
- Set #link(<uartibrd>)[UARTIBRD] to 11010 (maximum 16 places)
- Set #link(<uartfbrd>)[UARTFBRD] to 000011 (maximum 6 places)

However, there is an error, as:
$ 11010.000011_2 = 26 3/4 = 26.046875 $
$ 26.046875/26.04167 = 1.0002 "or" 0.02% "error" $

The baud rate must be within 5% for the channel to operate properly, otherwise a
framing error will occur when the stop bit is incorrectly captured.

=== Procedure
With the baud-rate divider (BRD) values determined, the UART configuration is
written to the module in the following order:
+ Disable the UART by clearing the `UARTEN` bit in the #link(<uartctl>)[UARTCTL]
    register.
+ Write the integer portion of the BRD to the #link(<uartibrd>)[UARTIBRD]
    register.
+ Write the fractional portion of the BRD to the #link(<uartfbrd>)[UARTFBRD]
    register.

#pagebreak()

== UART transmission procedure
- Enable the UART by setting the `UARTEN` bit in the #link(<uartctl>)[UARTCTL]
    register.
    #cimage("./images/uart-transmission-procedure.png")
- The UART is configured for transmitting or receiving via the `TXE` and `RXE`
    bits of the UART Control #link(<uartctl>)[UARTCTL] register.
- Transmiting and receiving are both enabled out of reset. Before any control
    registers are programmed, the UART must be disabled by clearing the `UARTEN`
    bit in #link(<uartctl>)[UARTCTL].
- If the UART is disabled during a TX or RX operation, the current transaction
    is completed prior to the UART stopping.

== UART transmission sequence
#cimage("./images/uart-transmission-sequence-diagram.png")

+ Program reads #link(<uartfr>)[UARTFR] that $mono("TXFF") = 0$. It will wait if
    $mono("TXFF") = 1$.
    #cimage("./images/uart-transmission-sequence-fr.png")
+ New byte written to the #link(<uartdr>)[UARTDR] register, which is then placed
    in the FIFO.
    #cimage("./images/uart-transmission-sequence-dr.png")
+ 10 bit transmission shift register includes the start bit, 8 data bits, and 1
    stop bit.
+ The data frame is shifted out by the start bit, then from least significant
    bit (LSB) to most significant bit (MSB), then 1 stop bit, to the U0Tx line.

== UART receiving sequence
#cimage("./images/uart-receiving-sequence.png")

+ 10 bit receiving shift register and 16 element FIFO, both 12 bits wide.
+ The #link(<uartdr>)[UARTDR] register is read only when RXE bit 9 of #link(
        <uartctl>,
    )[UARTCTL] is enabled.
+ Bits from U0Rx is shifted in with the start bit, 8 data bits and then the stop
    bit.
+ Start and stop bits are removed and checked for framing error.
+ Program reads #link(<uartfr>)[UARTFR] that $mono("RXFE") = 0$, which means the
    FIFO is not empty, and new data has reached the receiver.
    #cimage("./images/uart-receiving-sequence-fr.png")
+ 8 bits of data and 4 bits of status are put into the #link(<uartdr>)[UARTDR]
    register.
    #cimage("./images/uart-receiving-sequence-dr.png")
+ Read the #link(<uartdr>)[UARTDR] register bits 7:0 for the data and check the
    status condition bits 11:8 for errors.

= TM4C123GH6PM SSI
The TM4C123GH6PM SSI modules have the follow features:
- Has 4 synchronous serial interface (SSI) modules.
- Programmable interface operation for Freescale SPI, MICROWIRE, or Texas
    Instruments.
- Synchronous serial interfaces.
- Master or slave operation.
- Programmable clock bit rate and prescaler.
- Separate transmission and reception FIFOs, each 16 bits wide and 8 locations
    deep.
- Programmable data frame size from 4 to 16 bits.
- Internal loopback test mode for diagnostics or debug testing.
- Standard FIFO-based interrupts and End-of-Transmission interrupt.
- Efficient transfers using Micro Direct Memory Access Controller (µDMA).
    - Separate channels for transmission and reception.
    - Receive "single request asserted" when data is in the FIFO, and "burst
        request asserted" when the FIFO contains 4 entries.
    - Transmit "single request asserted" when there is space in the FIFO, and
        "burst request asserted" when 4 or more entries are available to be
        written in the FIFO.

== SSI pin names
#align(center, table(
    align: left,
    columns: 6,
    table.header(
        [*Pin Name*],
        [*Pin Number*],
        [*Pin Mux / Pin Assignment*],
        [*Pin Type*],
        [*Buffer Type*],
        [*Description*],
    ),

    [`SSI0Clk`], [19], [PA2 (2)], [I/O], [TTL], [SSI module 0 clock.],
    [`SSI0Fss`], [20], [PA3 (2)], [I/O], [TTL], [SSI module 0 frame signal.],
    [`SSI0Rx`], [21], [PA4 (2)], [I], [TTL], [SSI module 0 receive.],
    [`SSI0Tx`], [22], [PA5 (2)], [O], [TTL], [SSI module 0 transmit.],

    table.cell(rowspan: 2, [`SSI1Clk`]),
    [30],
    [PF2 (2)],
    table.cell(rowspan: 2, [I/O]),
    table.cell(rowspan: 2, [TTL]),
    table.cell(rowspan: 2, [SSI module 1 clock.]),

    [61], [PD0 (2)],

    table.cell(rowspan: 2, [`SSI1Fss`]),
    [31],
    [PF3 (2)],
    table.cell(rowspan: 2, [I/O]),
    table.cell(rowspan: 2, [TTL]),
    table.cell(rowspan: 2, [SSI module 1 frame signal.]),
    [62], [PD1 (2)],

    table.cell(rowspan: 2, [`SSI1Rx`]),
    [28],
    [PF0 (2)],
    table.cell(rowspan: 2, [I]),
    table.cell(rowspan: 2, [TTL]),
    table.cell(rowspan: 2, [SSI module 1 receive.]),
    [63], [PD2 (2)],

    table.cell(rowspan: 2, [`SSI1Tx`]),
    [29],
    [PF1 (2)],
    table.cell(rowspan: 2, [O]),
    table.cell(rowspan: 2, [TTL]),
    table.cell(rowspan: 2, [SSI module 1 transmit.]),
    [64], [PD3 (2)],

    [`SSI2Clk`], [58], [PB4 (2)], [I/O], [TTL], [SSI module 2 clock.],
    [`SSI2Fss`], [57], [PB5 (2)], [I/O], [TTL], [SSI module 2 frame signal.],
    [`SSI2Rx`], [1], [PB6 (2)], [I], [TTL], [SSI module 2 receive.],
    [`SSI2Tx`], [4], [PB7 (2)], [O], [TTL], [SSI module 2 transmit.],

    [`SSI3Clk`], [61], [PD0 (1)], [I/O], [TTL], [SSI module 3 clock.],
    [`SSI3Fss`], [62], [PD1 (1)], [I/O], [TTL], [SSI module 3 frame signal.],
    [`SSI3Rx`], [63], [PD2 (1)], [I], [TTL], [SSI module 3 receive.],
    [`SSI3Tx`], [64], [PD3 (1)], [O], [TTL], [SSI module 3 transmit.],
))

#pagebreak()

== SSI module
#grid(
    align: horizon,
    columns: 2,
    column-gutter: 2em,
    [
        SSI protocol has 4 I/O lines:
        - SSI0Fss: Slave select is an optional negative logic control from
            master to slave to indicate that the channel is active.
        - SSI0Clk: 50% duty cycle generated by the master.
        - SSI0Tx: Data line driven by the master and received by the slave
            (master out, slave in, MOSI).
        - SSI0Rx: Data line driven by the slave and received by the master
            (master in, slave out, MISO).
    ],
    table(
        columns: 2,
        align: center + horizon,
        [SSI0],
        [
            SSI0Tx #sym.arrow.r \
            SSI0Rx #sym.arrow.l \
            SSI0Fss #sym.arrow.r \
            SSI0Clk #sym.arrow.r \
        ],

        [SSI1],
        [
            SSI1Tx #sym.arrow.r \
            SSI1Rx #sym.arrow.l \
            SSI1Fss #sym.arrow.r \
            SSI1Clk #sym.arrow.r \
        ],

        [SSI2],
        [
            SSI2Tx #sym.arrow.r \
            SSI2Rx #sym.arrow.l \
            SSI2Fss #sym.arrow.r \
            SSI2Clk #sym.arrow.r \
        ],

        [SSI3],
        [
            SSI3Tx #sym.arrow.r \
            SSI3Rx #sym.arrow.l \
            SSI3Fss #sym.arrow.r \
            SSI3Clk #sym.arrow.r \
        ],
    ),
)

== J connectors
#cimage("./images/j1-j4-connectors-description.png")

#{
    show table.cell: cell => {
        show regex("SSI\d(?:Clk|Fss|[TR]x)"): it => highlight(
            fill: yellow,
            extent: 0.2em,
            it,
        )
        cell
    }
    jconnectors
}

== SSI register map

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Offset*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [`0x000`], [`SSICR0`], [RW], [`0x0000.0000`], [SSI Control 0],
    [`0x004`], [`SSICR1`], [RW], [`0x0000.0000`], [SSI Control 1],
    [`0x008`], [`SSIDR`], [RW], [`0x0000.0000`], [SSI Data],
    [`0x00C`], [`SSISR`], [RO], [`0x0000.0003`], [SSI Status],
    [`0x010`], [`SSICPSR`], [RW], [`0x0000.0000`], [SSI Clock Prescale],
    [`0x014`], [`SSIIM`], [RW], [`0x0000.0000`], [SSI Interrupt Mask],

    [`0x018`], [`SSIRIS`], [RO], [`0x0000.0008`], [SSI Raw Interrupt Status],

    [`0x01C`], [`SSIMIS`], [RO], [`0x0000.0000`], [SSI Masked Interrupt Status],

    [`0x020`], [`SSIICR`], [W1C], [`0x0000.0000`], [SSI Interrupt Clear],
    [`0x024`], [`SSIDMACTL`], [RW], [`0x0000.0000`], [SSI DMA Control],
    [`0xFC8`], [`SSICC`], [RW], [`0x0000.0000`], [SSI Clock Configuration],

    [`0xFD0`],
    [`SSIPeriphID4`],
    [RO],
    [`0x0000.0000`],
    [SSI Peripheral Identification 4],

    [`0xFD4`],
    [`SSIPeriphID5`],
    [RO],
    [`0x0000.0000`],
    [SSI Peripheral Identification 5],

    [`0xFD8`],
    [`SSIPeriphID6`],
    [RO],
    [`0x0000.0000`],
    [SSI Peripheral Identification 6],

    [`0xFDC`],
    [`SSIPeriphID7`],
    [RO],
    [`0x0000.0000`],
    [SSI Peripheral Identification 7],

    [`0xFE0`],
    [`SSIPeriphID0`],
    [RO],
    [`0x0000.0022`],
    [SSI Peripheral Identification 0],

    [`0xFE4`],
    [`SSIPeriphID1`],
    [RO],
    [`0x0000.0000`],
    [SSI Peripheral Identification 1],

    [`0xFE8`],
    [`SSIPeriphID2`],
    [RO],
    [`0x0000.0018`],
    [SSI Peripheral Identification 2],

    [`0xFEC`],
    [`SSIPeriphID3`],
    [RO],
    [`0x0000.0001`],
    [SSI Peripheral Identification 3],

    [`0xFF0`],
    [`SSIPCellID0`],
    [RO],
    [`0x0000.000D`],
    [SSI PrimeCell Identification 0],

    [`0xFF4`],
    [`SSIPCellID1`],
    [RO],
    [`0x0000.00F0`],
    [SSI PrimeCell Identification 1],
))

#pagebreak()

== SSI register names
#cimage("./images/ssi-register-names.png")

#pagebreak()

== Registers

=== SSI Control 0 (SSICR0)
<ssicr0>
- SSI0 base: `0x4000.8000`
- SSI1 base: `0x4000.9000`
- SSI2 base: `0x4000.A000`
- SSI3 base: `0x4000.B000`
- Offset `0x000`
- Type RW, reset `0x0000.0000`

#cimage("./images/ssicr0-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),
    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:8],
    [SCR],
    [RW],
    [`0x00`],
    [
        SSI Serial Clock Rate

        This bit field is used to generate the transmit and receive bit rate of
        the SSI. The bit rate is:
        $
            mono("BR") =
            mono("SysClk") / (mono("CPSDVSR") times (1 + mono("SCR")))
        $

        Where `CPSDVSR` is an even value from 2-254 programmed in the #link(
            <ssicpsr>,
        )[*SSICPSR*] register, and `SCR` is a value from 0-255.
    ],

    [7],
    [SPH],
    [RW],
    [0],
    [
        SSI Serial Clock Phase

        This bit is only applicable to the Freescale SPI Format.

        The `SPH` control bit selects the clock edge that captures data and
        allows it to change state. This bit has the most impact on the first bit
        transmitted by either allowing or not allowing a clock transition before
        the first data capture edge.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [Data is captured on the first clock edge transition.],
            [1], [Data is captured on the second clock edge transition.],
        )

        #v(10em)
    ],

    [6],
    [SPO],
    [RW],
    [0],
    [
        SSI Serial Clock Polarity

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [A steady state Low value is placed on the `SSInClk` pin.],
            [1],
            [
                A steady state High value is placed on the `SSInClk` pin when
                data is not being transferred.
            ],
        )
        *Note*: If this bit is set, then software must also configure the GPIO
        port pin corresponding to the `SSInClk` signal as a pull-up in the
        #link(<gpiopur>)[*GPIO Pull-Up Select (GPIOPUR)*] register.
    ],

    [5:4],
    [FRF],
    [RW],
    [`0x0`],
    [
        SSI Frame Format Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Frame Format]),
            [`0x0`], [Freescale SPI Frame Format],
            [`0x1`], [Texas Instruments Synchronous Serial Frame Format],
            [`0x2`], [MICROWIRE Frame Format],
            [`0x3`], [Reserved],
        )
    ],

    [3:0],
    [DSS],
    [RW],
    [`0x0`],
    [
        SSI Data Size Select

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Data Size]),
            [`0x0-0x2`], [Reserved],
            [`0x3`], [4-bit data],
            [`0x4`], [5-bit data],
            [`0x5`], [6-bit data],
            [`0x6`], [7-bit data],
            [`0x7`], [8-bit data],
            [`0x8`], [9-bit data],
            [`0x9`], [10-bit data],
            [`0xA`], [11-bit data],
            [`0xB`], [12-bit data],
            [`0xC`], [13-bit data],
            [`0xD`], [14-bit data],
            [`0xE`], [15-bit data],
            [`0xF`], [16-bit data],
        )
    ],
))

#pagebreak()

=== SSI Control 1 (SSICR1)
<ssicr1>
- SSI0 base: `0x4000.8000`
- SSI1 base: `0x4000.9000`
- SSI2 base: `0x4000.A000`
- SSI3 base: `0x4000.B000`
- Offset `0x004`
- Type RW, reset `0x0000.0000`

#cimage("./images/ssicr1-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:5],
    [reserved],
    [RO],
    [`0x000.0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [4],
    [EOT],
    [RW],
    [0],
    [
        End of Transmission

        This bit is only valid for Master mode devices and operations
        (`MS = 0x0`).

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0],
            [
                The `TXRIS` interrupt indicates that the transmit FIFO is half
                full or less.
            ],

            [1],
            [
                The End of Transmit interrupt mode for the `TXRIS` interrupt is
                enabled.
            ],
        )
        *Note*: In Freescale SPI mode only, a condition can be created where an
        `EOT` interrupt is generated for every byte transferred even if the FIFO
        is full. If the `EOT` bit has been set to 0 in an integrated slave SSI
        and the µDMA has been configured to transfer data from this SSI to a
        Master SSI on the device using external loopback, an `EOT` interrupt is
        generated by the SSI slave for every byte even if the FIFO is full.
    ],

    [3],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [2],
    [MS],
    [RW],
    [0],
    [
        SSI Master/Slave Select

        This bit selects Master or Slave mode and can be modified only when the
        SSI is disabled (`SSE`=`0`).

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The SSI is configured as a master.],
            [1], [The SSI is configured as a slave.],
        )
    ],

    [1],
    [SSE],
    [RW],
    [0],
    [
        SSI Synchronous Serial Port Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [SSI operation is disabled.],
            [1],
            [
                SSI operation is enabled.

                *Note*: This bit must be cleared before any control registers
                are reprogrammed.
            ],
        )
    ],

    [0],
    [LBM],
    [RW],
    [0],
    [
        SSI Loopback Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [Normal serial port operation enabled.],
            [1],
            [
                Output of the transmit serial shift register is connected
                internally to the input of the receive serial shift register.
            ],
        )
    ],
))

#pagebreak()

=== SSI Clock Configuration (SSICC)
<ssicc>
- SSI0 base: `0x4000.8000`
- SSI1 base: `0x4000.9000`
- SSI2 base: `0x4000.A000`
- SSI3 base: `0x4000.B000`
- Offset `0xFC8`
- Type RW, reset `0x0000.0000`

#cimage("./images/ssicc-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3:0],
    [CS],
    [RW],
    [0],
    [
        SSI Baud Clock Source

        The following table specifies the source that generates the SSI baud
        clock:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [`0x0`], [System clock (based on clock source and divisor factor)],
            [`0x1`-`0x4`], [Reserved],
            [`0x5`], [`PIOSC`],
            [`0x6`-`0xF`], [Reserved],
        )
    ],
))

#pagebreak()

=== SSI Clock Prescale (SSICPSR)
<ssicpsr>
- SSI0 base: `0x4000.8000`
- SSI1 base: `0x4000.9000`
- SSI2 base: `0x4000.A000`
- SSI3 base: `0x4000.B000`
- Offset `0x010`
- Type RW, reset `0x0000.0000`

#cimage("./images/ssicpsr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:0],
    [CPSDVSR],
    [RW],
    [`0x00`],
    [
        SSI Clock Prescale Divisor

        This value must be an even number from 2 to 254, depending on the
        frequency of `SSInClk`. The LSB always returns 0 on reads.
    ],
))

#pagebreak()

=== SSI Status (SSISR)
<ssisr>
- SSI0 base: `0x4000.8000`
- SSI1 base: `0x4000.9000`
- SSI2 base: `0x4000.A000`
- SSI3 base: `0x4000.B000`
- Offset `0x00C`
- Type RO, reset `0x0000.0003`

#cimage("./images/ssisr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:5],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [4],
    [BSY],
    [RO],
    [0],
    [
        SSI Busy Bit

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The SSI is idle.],
            [1],
            [The SSI is currently transmitting and/or receiving a frame, or the
                transmit FIFO is not empty.],
        )
    ],

    [3],
    [RFF],
    [RO],
    [0],
    [
        SSI Receive FIFO Full

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The receive FIFO is not full.],
            [1], [The receive FIFO is full.],
        )
    ],

    [2],
    [RNE],
    [RO],
    [0],
    [
        SSI Receive FIFO Not Empty

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The receive FIFO is empty.],
            [1], [The receive FIFO is not empty.],
        )
    ],

    [1],
    [TNF],
    [RO],
    [1],
    [
        SSI Transmit FIFO Not Full

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The transmit FIFO is full.],
            [1], [The transmit FIFO is not full.],
        )

        #v(10em)
    ],

    [0],
    [TNE],
    [RO],
    [1],
    [
        SSI Transmit FIFO Empty

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [The transmit FIFO is not empty.],
            [1], [The transmit FIFO is empty.],
        )
    ],
))

#pagebreak()

=== Synchronous Serial Interface Run Mode Clock Gating Control (RCGCSSI)
<rcgcssi>
- Base `0x400F.E000`
- Offset `0x61C`
- Type RW, reset `0x0000.0000`

#cimage("./images/rcgcssi-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [R3],
    [RW],
    [0],
    [
        SSI Module 3 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [SSI module 3 is disabled.],
            [1], [Enable and provide a clock to SSI module 3 in Run mode.],
        )
    ],

    [2],
    [R2],
    [RW],
    [0],
    [
        SSI Module 2 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [SSI module 2 is disabled.],
            [1], [Enable and provide a clock to SSI module 2 in Run mode.],
        )
    ],

    [1],
    [R1],
    [RW],
    [0],
    [
        SSI Module 1 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [SSI module 1 is disabled.],
            [1], [Enable and provide a clock to SSI module 1 in Run mode.],
        )
    ],

    [0],
    [R0],
    [RW],
    [0],
    [
        SSI Module 0 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),
            [0], [SSI module 0 is disabled.],
            [1], [Enable and provide a clock to SSI module 0 in Run mode.],
        )
    ],
))

#pagebreak()

=== SSI Data (SSIDR)
<ssidr>
- SSI0 base: `0x4000.8000`
- SSI1 base: `0x4000.9000`
- SSI2 base: `0x4000.A000`
- SSI3 base: `0x4000.B000`
- Offset `0x008`
- Type RW, reset `0x0000.0000`

#cimage("./images/ssidr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [DATA],
    [RW],
    [`0x0000`],
    [
        SSI Receive/Transmit Data

        A read operation reads the receive FIFO. A write operation writes the
        transmit FIFO.

        Software must right-justify data when the SSI is programmed for a data
        size that is less than 16 bits. Unused bits at the top are ignored by
        the transmit logic. The receive logic automatically right-justifies the
        data.
    ],
))

#pagebreak()

== Connection to I/O device
#cimage("./images/tm4c123gh6pm-ssi-connection-data-bits.png")

- Serial protocols will often send the least significant bits first, so the
    smallest bit is on the far left. The lower nibble is actually
    $0011 = "0x3"$, and the upper nibble is $0101 = "0x5"$.

#cimage("./images/tm4c123gh6pm-ssi-connection-data-lines.png")

- The side that generates the clock is called the "master", and the other side
    is called the "slave".

#cimage("./images/ti-max3232-chip-interface.png")

- TI MAX3232 chip line driver is used to improve bandwidth, increase range and
    reduce noise, as well as to bring the voltages to transistor-transistor
    logic (TTL) requirements.

#figure(
    image("./images/tm4c123gh6pm-ssi-connection-mcu-and-io-device.png"),
    caption: [
        TM4C123G SSI connection between the microcontroller and an I/O device.
    ],
)

- Shift register can be configured from 4 to 16 bits #link(<ssicr0>)[(SSICR0)]
- Shift register in the master and shift register in the slave are linked to
    form a distributed register.
- Data is written to the #link(<ssidr>)[SSIDR] register is transmit, and is read
    from the #link(<ssidr>)[SSIDR] register to receive.
- SSI on the TM4C123G has 2 16-bit FIFOs with 8 element depth.
- Data is transmitted by writing to the #link(<ssidr>)[SSIDR] register, which
    puts the data in the transmission FIFO.
- Data is received by reading the #link(<ssidr>)[SSIDR], which gets data from
    the receiving FIFO.
- SSI transmits and receives data at the same time.
- Data is shifted from master to slave, and from slave to master.
- Depending on the configured data of the FIFO (either 4 to 16 bits wide), data
    is serially shifted by 4 bits to 16 bits positions by the SCK clock, so data
    is exchanged between master and slave.

== SSI clock frequency configuration
#cimage("./images/ssi-clock-frequency-configuration-ssi0cr.png")
- SSI serial clock rate (frequency) set by `SCR` (8 bit) in the #link(
        <ssicr0>,
    )[SSICR0] register.
- `SCR` is any 8 bit value from 0 to 255.

#cimage("./images/ssi-clock-frequency-configuration-cpdvsr.png")
- Clock prescale divisor `CPDVSR` (8 bit) is in the #link(<ssicpsr>)[SSICPSR]
    register.
- `CPDVSR` is any *even* number from 2 to 254.

$ "F"_"bus" = "Frequency of bus clock" $
$ "F"_"SSI" = "F"_"bus"/(mono("CPDVSR") times (1 + mono("SCR"))) $
$
    therefore quad mono("SSInClk") =
    mono("SysClk") / (mono("CPSDVSR") times (1 + mono("SCR")))
$

#pagebreak()

== SSI mode control bits
- There are 3 mode control bits, `MS`, `SPO`, and `SPH` to configure the
    transmission protocol.

#cimage("./images/ssi-mode-control-bits-1.png")

- If `MS = 0`, the device is set to master mode, so the device generates the
    SCLK line and outputs data to the SSI0Tx line and receives input on the
    SSI0Rx line.

#cimage("./images/ssi-mode-control-bits-2.png")

- The `SP0` controls polarity of the SCLK.
- The `SPH` controls the phase timing of the first bit to be transferred and
    received.
- When `SPH = 0`, the device will shift data on the 1st, 3rd, 5th, ... clock
    cycle, i.e. odd clock cycles.
- When `SPH = 1`, the device will shift data on the 2nd, 4th, 6th, ... clock
    cycle, i.e. even clock cycles.

== Initialisation
+ Enable the SSI module using the #link(<rcgcssi>)[*RCGCSSI*] register.
+ Enable the clock to the appropriate GPIO module via the #link(
        <rcgcgpio>,
    )[*RCGCGPIO*] register.
+ Set the #link(<gpioafsel>)[*GPIOAFSEL*] bits for the appropriate pins.
+ Configure the `PMCn` fields in the #link(<gpiopctl>)[*GPIOPCTL*] register to
    assign the SSI signals to the appropriate pins.
+ Program the #link(<gpioden>)[*GPIODEN*] register to enable the pin's digital
    function. In addition, the drive strength, drain select and
    pull-up/pull-down functions must be configured.

*Note*: Pull-ups can be used to avoid unnecessary toggles on the SSI pins, which
can take the slave into a wrong state. In addition, if the SSIClk signal is
programmed to steady state High through the `SPO` bit in the #link(
    <ssicr0>,
)[*SSICR0*] register, then software must also configure the GPIO port pin
corresponding to the SSInClk signal as a pull-up in the #link(<gpiopur>)[*GPIO
Pull-Up Select (GPIOPUR)*] register.

#pagebreak()

== Configuration
For each of the frame formats, the SSI is configured using the following steps:
+ Ensure that the `SSE` bit in the #link(<ssicr1>)[SSICR1] register is clear
    before making any configuration changes.
+ Select whether the SSI is a master of slave:
    #enum(
        numbering: "a.",
        [
            For master operations, set the #link(
                <ssicr1>,
            )[SSICR1] register to `0x0000.0000`.
        ],
        [
            For slave mode (output enabled), set the #link(<ssicr1>)[SSICR1]
            register to `0x0000.0004`.
        ],
    )
+ Configure the SSI clock source by writing to the #link(<ssicc>)[SSICC]
    register.
+ Configure the clock prescale divisor by writing to the #link(
        <ssicpsr>,
    )[SSICPSR] register.
+ Write the #link(<ssicr0>)[SSICR0] register with the following configuration:
    - Serial clock rate (`SCR`).
    - Desired clock phase and polarity, if using Freescale SPI mode (`SPH` and
        `SPO`).
    - The protocol mode: Freescale SPI, TI SSF, MICROWAVE (FRF).
    - The data size (DSS).
+ Enable the SSI by setting the `SSE` bit in the #link(<ssicr1>)[SSICR1]
    register.

=== Example
The SSI must be configured to operate with the following parameters:
- Master operation
- Freescale SPI mode (`SPO = 1`, `SPH = 1`)
- #qty[1][Mbps] bit rate
- 8 data bits

Assuming the system clock is #qty[20][MHz], the bit rate calculation would be:
$ mono("SSInClk") = mono("SysClk")/(mono("CPSDVSR") times (1 + mono("SCR"))) $
$ 1 times 10^6 = frac(20 times 10^6, mono("CPSDVSR") times (1 + mono("SCR"))) $

In this case, if `CPSDVSR = 0x2`, `SCR` must be `0x9`.

The configuration sequence would be as follows:
+ Ensure that the `SSE` bit in the #link(<ssicr1>)[SSICR1] register is clear.
+ Write to the #link(<ssicr1>)[SSICR1 (SSI control)] register with a value of
    `0x0000.0000`, which disables SSI.
+ Write to the #link(<ssicpsr>)[SSICPSR (SSI clock prescale)] register with a
    value of `0x0000.0002`.
+ Write the #link(<ssicr0>)[SSICR0 (SSI control 0)] register with a value of
    `0x0000.09C7`.
+ The SSI is then enabled by setting the `SSE` bit in the #link(
        <ssicr1>,
    )[SSICR1] register.

#pagebreak()

= TM4C123GH6PM PWM
- 2 PWM modules.
- Each PWM module has 4 generator blocks and a control block.
- Each generator block can produce 2 PWM signals, so the total is
    $2 times 4 times 2 = 16$ PWM outputs.
- Each generator block has:
    - One fault-condition handling inputs to quickly provide low-latency
        shutdown and prevent damage to the motor being controlled, for a total
        of two inputs.
    - One 16-bit counter.
    - The ability to run in down or up/down mode.
    - Has output frequency controlled by a 16-bit load value.
    - Load value updates that can be synchronised.
    - The ability to produce output signals at zero and load value.
    - Two PWM comparators.
    - Optional output inversion of each PWM signal, or polarity control.
    - Optional fault handling for each PWM signal.
    - Synchronisation of timers in the PWM generator blocks.
    - Synchronisation of timer or comparator updates across the PWM generator
        blocks.
    - Extended PWM synchronisation of timer or comparator updates across the PWM
        generator blocks.
    - Interrupt status summary of the PWM generator blocks.
    - Extended PWM fault handling, with multiple fault signals, programmable
        polarities, and filtering.
    - PWM generators can be operated independently or synchronised with other
        generators.

== Block diagrams

=== PWM module
#cimage("./images/pwm-module-block-diagram.png")

=== PWM generator block
#cimage("./images/pwm-generator-block-diagram.png")
#pagebreak()

== PWM pins
<pwm-pins>

#align(center, table(
    align: (center, center, center, center, center, left),
    columns: (auto, auto, auto, auto, auto, 12em),
    table.header(
        [*Pin Name*],
        [*Pin Number*],
        [*Pin Mux / Pin Assignment*],
        [*Pin Type*],
        [*Buffer Type*],
        [*Description*],
    ),
    table.cell(rowspan: 3)[`M0FAULT0`],
    [30],
    [`PF2 (4)`],
    table.cell(rowspan: 3)[I],
    table.cell(rowspan: 3)[TTL],
    table.cell(rowspan: 3)[Motion Control Module 0 PWM Fault 0.],
    [53],
    [`PB6 (4)`],
    [63],
    [`PD2 (4)`],

    [`M0PWM0`],
    [1],
    [`PB6 (4)`],
    [O],
    [TTL],
    [
        Motion Control Module 0 PWM 0. This signal is controlled by Module 0 PWM
        Generator 0.
    ],

    [`M0PWM1`],
    [4],
    [`PB7 (4)`],
    [O],
    [TTL],
    [
        Motion Control Module 0 PWM 1. This signal is controlled by Module 0 PWM
        Generator 0.
    ],

    [`M0PWM2`],
    [58],
    [`PB4 (4)`],
    [O],
    [TTL],
    [
        Motion Control Module 0 PWM 2. This signal is controlled by Module 0 PWM
        Generator 1.
    ],

    [`M0PWM3`],
    [57],
    [`PB5 (4)`],
    [O],
    [TTL],
    [
        Motion Control Module 0 PWM 3. This signal is controlled by Module 0 PWM
        Generator 1.
    ],

    [`M0PWM4`],
    [59],
    [`PE4 (4)`],
    [O],
    [TTL],
    [
        Motion Control Module 0 PWM 4. This signal is controlled by Module 0 PWM
        Generator 2.
    ],

    [`M0PWM5`],
    [60],
    [`PE5 (4)`],
    [O],
    [TTL],
    [
        Motion Control Module 0 PWM 5. This signal is controlled by Module 0 PWM
        Generator 2.
    ],

    table.cell(rowspan: 2)[`M0PWM6`],
    [16],
    [`PC4 (4)`],
    table.cell(rowspan: 2)[O],
    table.cell(rowspan: 2)[TTL],
    table.cell(rowspan: 2)[
        Motion Control Module 0 PWM 6. This signal is controlled by Module 0 PWM
        Generator 3.
    ],
    [61],
    [`PD0 (4)`],

    table.cell(rowspan: 2)[`M0PWM7`],
    [15],
    [`PC5 (4)`],
    table.cell(rowspan: 2)[O],
    table.cell(rowspan: 2)[TTL],
    table.cell(rowspan: 2)[
        Motion Control Module 0 PWM 7. This signal is controlled by Module 0 PWM
        Generator 3.
    ],
    [62],
    [`PD1 (4)`],

    [`M1FAULT0`],
    [5],
    [`PF4 (5)`],
    [I],
    [TTL],
    [Motion Control Module 1 PWM Fault 0.],

    [`M1PWM0`],
    [61],
    [`PD0 (5)`],
    [O],
    [TTL],
    [
        Motion Control Module 1 PWM 0. This signal is controlled by Module 1 PWM
        Generator 0.
    ],

    [`M1PWM1`],
    [62],
    [`PD1 (5)`],
    [O],
    [TTL],
    [
        Motion Control Module 1 PWM 1. This signal is controlled by Module 1 PWM
        Generator 0.
    ],

    table.cell(rowspan: 2)[`M1PWM2`],
    [23],
    [`PA6 (5)`],
    table.cell(rowspan: 2)[O],
    table.cell(rowspan: 2)[TTL],
    table.cell(rowspan: 2)[
        Motion Control Module 1 PWM 2. This signal is controlled by Module 1 PWM
        Generator 1.
    ],
    [59],
    [`PE4 (5)`],

    table.cell(rowspan: 2)[`M1PWM3`],
    [24],
    [`PA7 (5)`],
    table.cell(rowspan: 2)[O],
    table.cell(rowspan: 2)[TTL],
    table.cell(rowspan: 2)[
        Motion Control Module 1 PWM 3. This signal is controlled by Module 1 PWM
        Generator 1.
    ],
    [60],
    [`PE5 (5)`],

    [`M1PWM4`],
    [28],
    [`PF0 (5)`],
    [O],
    [TTL],
    [
        Motion Control Module 1 PWM 4. This signal is controlled by Module 1 PWM
        Generator 2.
    ],

    [`M1PWM5`],
    [29],
    [`PF1 (5)`],
    [O],
    [TTL],
    [
        Motion Control Module 1 PWM 5. This signal is controlled by Module 1 PWM
        Generator 2.
    ],

    [`M1PWM6`],
    [30],
    [`PF2 (5)`],
    [O],
    [TTL],
    [
        Motion Control Module 1 PWM 6. This signal is controlled by Module 1 PWM
        Generator 3.
    ],

    [`M1PWM7`],
    [31],
    [`PF3 (5)`],
    [O],
    [TTL],
    [
        Motion Control Module 1 PWM 7. This signal is controlled by Module 1 PWM
        Generator 3.
    ],
))

#pagebreak()

== PWM register map

#align(center, table(
    align: left,
    columns: 5,
    table.header([*Offset*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [`0x000`], [`PWMCTL`], [RW], [`0x0000.0000`], [PWM Master Control],

    [`0x004`], [`PWMSYNC`], [RW], [`0x0000.0000`], [PWM Time Base Sync],

    [`0x008`], [`PWMENABLE`], [RW], [`0x0000.0000`], [PWM Output Enable],

    [`0x00C`], [`PWMINVERT`], [RW], [`0x0000.0000`], [PWM Output Inversion],

    [`0x010`], [`PWMFAULT`], [RW], [`0x0000.0000`], [PWM Output Fault],

    [`0x014`], [`PWMINTEN`], [RW], [`0x0000.0000`], [PWM Interrupt Enable],

    [`0x018`], [`PWMRIS`], [RO], [`0x0000.0000`], [PWM Raw Interrupt Status],

    [`0x01C`],
    [`PWMISC`],
    [RW1C],
    [`0x0000.0000`],
    [PWM Interrupt Status and Clear],

    [`0x020`], [`PWMSTATUS`], [RO], [`0x0000.0000`], [PWM Status],

    [`0x024`],
    [`PWMFAULTVAL`],
    [RW],
    [`0x0000.0000`],
    [PWM Fault Condition Value],

    [`0x028`], [`PWMENUPD`], [RW], [`0x0000.0000`], [PWM Enable Update],

    [`0x040`], [`PWM0CTL`], [RW], [`0x0000.0000`], [PWM0 Control],

    [`0x044`],
    [`PWM0INTEN`],
    [RW],
    [`0x0000.0000`],
    [PWM0 Interrupt and Trigger Enable],

    [`0x048`], [`PWM0RIS`], [RO], [`0x0000.0000`], [PWM0 Raw Interrupt Status],

    [`0x04C`],
    [`PWM0ISC`],
    [RW1C],
    [`0x0000.0000`],
    [PWM0 Interrupt Status and Clear],

    [`0x050`], [`PWM0LOAD`], [RW], [`0x0000.0000`], [PWM0 Load],

    [`0x054`], [`PWM0COUNT`], [RO], [`0x0000.0000`], [PWM0 Counter],

    [`0x058`], [`PWM0CMPA`], [RW], [`0x0000.0000`], [PWM0 Compare A],

    [`0x05C`], [`PWM0CMPB`], [RW], [`0x0000.0000`], [PWM0 Compare B],

    [`0x060`], [`PWM0GENA`], [RW], [`0x0000.0000`], [PWM0 Generator A Control],

    [`0x064`], [`PWM0GENB`], [RW], [`0x0000.0000`], [PWM0 Generator B Control],

    [`0x068`], [`PWM0DBCTL`], [RW], [`0x0000.0000`], [PWM0 Dead-Band Control],

    [`0x06C`],
    [`PWM0DBRISE`],
    [RW],
    [`0x0000.0000`],
    [PWM0 Dead-Band Rising-Edge Delay],

    [`0x070`],
    [`PWM0DBFALL`],
    [RW],
    [`0x0000.0000`],
    [PWM0 Dead-Band Falling-Edge-Delay],

    [`0x074`], [`PWM0FLTSRC0`], [RW], [`0x0000.0000`], [PWM0 Fault Source 0],

    [`0x078`], [`PWM0FLTSRC1`], [RW], [`0x0000.0000`], [PWM0 Fault Source 1],

    [`0x07C`],
    [`PWM0MINFLTPER`],
    [RW],
    [`0x0000.0000`],
    [PWM0 Minimum Fault Period],

    [`0x080`], [`PWM1CTL`], [RW], [`0x0000.0000`], [PWM1 Control],

    [`0x084`],
    [`PWM1INTEN`],
    [RW],
    [`0x0000.0000`],
    [PWM1 Interrupt and Trigger Enable],

    [`0x088`], [`PWM1RIS`], [RO], [`0x0000.0000`], [PWM1 Raw Interrupt Status],

    [`0x08C`],
    [`PWM1ISC`],
    [RW1C],
    [`0x0000.0000`],
    [PWM1 Interrupt Status and Clear],

    [`0x090`], [`PWM1LOAD`], [RW], [`0x0000.0000`], [PWM1 Load],

    [`0x094`], [`PWM1COUNT`], [RO], [`0x0000.0000`], [PWM1 Counter],

    [`0x098`], [`PWM1CMPA`], [RW], [`0x0000.0000`], [PWM1 Compare A],

    [`0x09C`], [`PWM1CMPB`], [RW], [`0x0000.0000`], [PWM1 Compare B],

    [`0x0A0`], [`PWM1GENA`], [RW], [`0x0000.0000`], [PWM1 Generator A Control],

    [`0x0A4`], [`PWM1GENB`], [RW], [`0x0000.0000`], [PWM1 Generator B Control],

    [`0x0A8`], [`PWM1DBCTL`], [RW], [`0x0000.0000`], [PWM1 Dead-Band Control],

    [`0x0AC`],
    [`PWM1DBRISE`],
    [RW],
    [`0x0000.0000`],
    [PWM1 Dead-Band Rising-Edge Delay],

    [`0x0B0`],
    [`PWM1DBFALL`],
    [RW],
    [`0x0000.0000`],
    [PWM1 Dead-Band Falling-Edge-Delay],

    [`0x0B4`], [`PWM1FLTSRC0`], [RW], [`0x0000.0000`], [PWM1 Fault Source 0],

    [`0x0B8`], [`PWM1FLTSRC1`], [RW], [`0x0000.0000`], [PWM1 Fault Source 1],

    [`0x0BC`],
    [`PWM1MINFLTPER`],
    [RW],
    [`0x0000.0000`],
    [PWM1 Minimum Fault Period],

    [`0x0C0`], [`PWM2CTL`], [RW], [`0x0000.0000`], [PWM2 Control],

    [`0x0C4`],
    [`PWM2INTEN`],
    [RW],
    [`0x0000.0000`],
    [PWM2 Interrupt and Trigger Enable],

    [`0x0C8`], [`PWM2RIS`], [RO], [`0x0000.0000`], [PWM2 Raw Interrupt Status],

    [`0x0CC`],
    [`PWM2ISC`],
    [RW1C],
    [`0x0000.0000`],
    [PWM2 Interrupt Status and Clear],

    [`0x0D0`], [`PWM2LOAD`], [RW], [`0x0000.0000`], [PWM2 Load],

    [`0x0D4`], [`PWM2COUNT`], [RO], [`0x0000.0000`], [PWM2 Counter],

    [`0x0D8`], [`PWM2CMPA`], [RW], [`0x0000.0000`], [PWM2 Compare A],

    [`0x0DC`], [`PWM2CMPB`], [RW], [`0x0000.0000`], [PWM2 Compare B],

    [`0x0E0`], [`PWM2GENA`], [RW], [`0x0000.0000`], [PWM2 Generator A Control],

    [`0x0E4`], [`PWM2GENB`], [RW], [`0x0000.0000`], [PWM2 Generator B Control],

    [`0x0E8`], [`PWM2DBCTL`], [RW], [`0x0000.0000`], [PWM2 Dead-Band Control],

    [`0x0EC`],
    [`PWM2DBRISE`],
    [RW],
    [`0x0000.0000`],
    [PWM2 Dead-Band Rising-Edge Delay],

    [`0x0F0`],
    [`PWM2DBFALL`],
    [RW],
    [`0x0000.0000`],
    [PWM2 Dead-Band Falling-Edge-Delay],

    [`0x0F4`], [`PWM2FLTSRC0`], [RW], [`0x0000.0000`], [PWM2 Fault Source 0],

    [`0x0F8`], [`PWM2FLTSRC1`], [RW], [`0x0000.0000`], [PWM2 Fault Source 1],

    [`0x0FC`],
    [`PWM2MINFLTPER`],
    [RW],
    [`0x0000.0000`],
    [PWM2 Minimum Fault Period],

    [`0x100`], [`PWM3CTL`], [RW], [`0x0000.0000`], [PWM3 Control],

    [`0x104`],
    [`PWM3INTEN`],
    [RW],
    [`0x0000.0000`],
    [PWM3 Interrupt and Trigger Enable],

    [`0x108`], [`PWM3RIS`], [RO], [`0x0000.0000`], [PWM3 Raw Interrupt Status],

    [`0x10C`],
    [`PWM3ISC`],
    [RW1C],
    [`0x0000.0000`],
    [PWM3 Interrupt Status and Clear],

    [`0x110`], [`PWM3LOAD`], [RW], [`0x0000.0000`], [PWM3 Load],

    [`0x114`], [`PWM3COUNT`], [RO], [`0x0000.0000`], [PWM3 Counter],

    [`0x118`], [`PWM3CMPA`], [RW], [`0x0000.0000`], [PWM3 Compare A],

    [`0x11C`], [`PWM3CMPB`], [RW], [`0x0000.0000`], [PWM3 Compare B],

    [`0x120`], [`PWM3GENA`], [RW], [`0x0000.0000`], [PWM3 Generator A Control],

    [`0x124`], [`PWM3GENB`], [RW], [`0x0000.0000`], [PWM3 Generator B Control],

    [`0x128`], [`PWM3DBCTL`], [RW], [`0x0000.0000`], [PWM3 Dead-Band Control],

    [`0x12C`],
    [`PWM3DBRISE`],
    [RW],
    [`0x0000.0000`],
    [PWM3 Dead-Band Rising-Edge Delay],

    [`0x130`],
    [`PWM3DBFALL`],
    [RW],
    [`0x0000.0000`],
    [PWM3 Dead-Band Falling-Edge-Delay],

    [`0x134`], [`PWM3FLTSRC0`], [RW], [`0x0000.0000`], [PWM3 Fault Source 0],

    [`0x138`], [`PWM3FLTSRC1`], [RW], [`0x0000.0000`], [PWM3 Fault Source 1],

    [`0x13C`],
    [`PWM3MINFLTPER`],
    [RW],
    [`0x0000.0000`],
    [PWM3 Minimum Fault Period],

    [`0x800`],
    [`PWM0FLTSEN`],
    [RW],
    [`0x0000.0000`],
    [PWM0 Fault Pin Logic Sense],

    [`0x804`], [`PWM0FLTSTAT0`], [-], [`0x0000.0000`], [PWM0 Fault Status 0],

    [`0x808`], [`PWM0FLTSTAT1`], [-], [`0x0000.0000`], [PWM0 Fault Status 1],

    [`0x880`],
    [`PWM1FLTSEN`],
    [RW],
    [`0x0000.0000`],
    [PWM1 Fault Pin Logic Sense],

    [`0x884`], [`PWM1FLTSTAT0`], [-], [`0x0000.0000`], [PWM1 Fault Status 0],

    [`0x888`], [`PWM1FLTSTAT1`], [-], [`0x0000.0000`], [PWM1 Fault Status 1],

    [`0x904`], [`PWM2FLTSTAT0`], [-], [`0x0000.0000`], [PWM2 Fault Status 0],

    [`0x908`], [`PWM2FLTSTAT1`], [-], [`0x0000.0000`], [PWM2 Fault Status 1],

    [`0x984`], [`PWM3FLTSTAT0`], [-], [`0x0000.0000`], [PWM3 Fault Status 0],

    [`0x988`], [`PWM3FLTSTAT1`], [-], [`0x0000.0000`], [PWM3 Fault Status 1],

    [`0xFC0`], [`PWMPP`], [RO], [`0x0000.0314`], [PWM Peripheral Properties],
))

#pagebreak()

== Registers

=== Run-Mode Clock Configuration (RCC)
<rcc>
- Base `0x400F.E000`
- Offset `0x060`
- Type RW, reset `0x078E.3AD1`

#cimage("./images/rcc-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:28],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [27],
    [ACG],
    [RW],
    [0],
    [
        Auto Clock Gating

        This bit specifies whether the system uses the *Sleep-Mode Clock Gating
        Control (SCGCn)* registers and *Deep-Sleep-Mode Clock Gating Control
        (DCGCn)* registers if the microcontroller enters a Sleep or Deep-Sleep
        mode (respectively).

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The #link(<rcgc0>)[*Run-Mode Clock Gating Control (RCGCn)*]
                registers are used when the microcontroller enters a sleep mode.
            ],

            [1],
            [
                The *SCGCn* or *DCGCn* registers are used to control the clocks
                distributed to the peripherals when the microcontroller is in a
                sleep mode. The *SCGCn* and *DCGCn* registers allow unused
                peripherals to consume less power when the microcontroller is in
                a sleep mode.
            ],
        )
        The #link(<rcgc0>)[*RCGCn*] registers are always used to control the
        clocks in Run mode.

        #v(10em)
    ],

    [26:23],
    [SYSDIV],
    [RW],
    [`0xF`],
    [
        System Clock Divisor

        Specifies which divisor is used to generate the system clock from either
        the PLL output or the oscillator source (depending on how the `BYPASS`
        bit in this register is configured). See @sysdiv for bit encodings.

        If the `SYSDIV` value is less than `MINSYSDIV`, and the PLL is being
        used, then the `MINSYSDIV` value is used as the divisor.

        If the PLL is not being used, the `SYSDIV` value can be less than
        `MINSYSDIV`.
    ],

    [22],
    [USESYSDIV],
    [RW],
    [0],
    [
        Enable System Clock Divider

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The system clock is used undivided.],
            [1],
            [
                The system clock divider is the source for the system clock. The
                system clock divider is forced to be used when the PLL is
                selected as the source.

                If the `USERCC2` bit in the *RCC2* register is set, then the
                `SYSDIV2` field in the *RCC2* register is used as the system
                clock divider rather than the `SYSDIV` field in this register.
            ],
        )
    ],

    [21],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [20],
    [USEPWMDIV],
    [RW],
    [0],
    [
        Enable PWM Clock Divisor

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The system clock is the source for the PWM clock.],
            [1],
            [
                The PWM clock divider is the source for the PWM clock.

                Note that when the PWM divisor is used, it is applied to the
                clock for both PWM modules.
            ],
        )

        #v(10em)
    ],

    [19:17],
    [PWMDIV],
    [RW],
    [`0x7`],
    [
        PWM Unit Clock Divisor

        This field specifies the binary divisor used to predivide the system
        clock down for use as the timing reference for the PWM module. The
        rising edge of this clock is synchronous with the system clock.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Divisor]),

            [`0x0`], [/2],
            [`0x1`], [/4],
            [`0x2`], [/8],
            [`0x3`], [/16],
            [`0x4`], [/32],
            [`0x5`], [/64],
            [`0x6`], [/64],
            [`0x7`], [/64 (default)],
        )
    ],

    [16:14],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [13],
    [PWRDN],
    [RW],
    [1],
    [
        PLL Power Down

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The PLL is operating normally.],
            [1],
            [
                The PLL is powered down. Care must be taken to ensure that
                another clock source is functioning and that the `BYPASS` bit is
                set before setting this bit.
            ],
        )
    ],

    [12],
    [reserved],
    [RO],
    [1],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(20em)
    ],

    [11],
    [BYPASS],
    [RW],
    [1],
    [
        PLL Bypass

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The system clock is the PLL output clock divided by the divisor
                specified by `SYSDIV` (@sysdiv).
            ],

            [1],
            [
                The system clock is derived from the OSC source and divided by
                the divisor specified by `SYSDIV`.
            ],
        )

        *Note*: The `ADC` must be clocked from the PLL or directly from a 16-MHz
        clock source to operate properly.

        #v(100em)
    ],

    [10:6],
    [XTAL],
    [RW],
    [`0x0B`],
    [
        Crystal Value

        This field specifies the crystal value attached to the main oscillator.
        The encoding for this field is provided below.

        Frequencies that may be used with the USB interface are indicated in the
        table. To function within the clocking requirements of the USB
        specification, a crystal of 5, 6, 8, 10, 12, or 16 MHz must be used.

        #table(
            columns: 3,
            align: center,
            stroke: none,
            table.header(
                [Value],
                [Crystal Frequency (MHz) Not Using the PLL],
                [Crystal Frequency (MHz) Using the PLL],
            ),

            [`0x00`-`0x05`], table.cell(colspan: 2)[reserved],
            [`0x06`], [4 MHz], [Reserved],
            [`0x07`], [4.096 MHz], [Reserved],
            [`0x08`], [4.9152 MHz], [Reserved],
            [`0x09`], table.cell(colspan: 2)[5 MHz (USB)],
            [`0x0A`], table.cell(colspan: 2)[5.12 MHz],
            [`0x0B`], table.cell(colspan: 2)[6 MHz (USB)],
            [`0x0C`], table.cell(colspan: 2)[6.144 MHz],
            [`0x0D`], table.cell(colspan: 2)[7.3728 MHz],
            [`0x0E`], table.cell(colspan: 2)[8 MHz (USB)],
            [`0x0F`], table.cell(colspan: 2)[8.192 MHz],
            [`0x10`], table.cell(colspan: 2)[10.0 MHz (USB)],
            [`0x11`], table.cell(colspan: 2)[12.0 MHz (USB)],
            [`0x12`], table.cell(colspan: 2)[12.288 MHz],
            [`0x13`], table.cell(colspan: 2)[13.56 MHz],
            [`0x14`], table.cell(colspan: 2)[14.31818 MHz],
            [`0x15`], table.cell(colspan: 2)[16.0 MHz (USB)],
            [`0x16`], table.cell(colspan: 2)[16.384 MHz],
            [`0x17`], table.cell(colspan: 2)[18.0 MHz (USB)],
            [`0x18`], table.cell(colspan: 2)[20.0 MHz (USB)],
            [`0x19`], table.cell(colspan: 2)[24.0 MHz (USB)],
            [`0x1A`], table.cell(colspan: 2)[25.0 MHz (USB)],
        )

        #v(10em)
    ],

    [5:4],
    [OSCSRC],
    [RW],
    [`0x1`],
    [
        Oscillator Source

        Selects the input source for the OSC. The values are:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Input Source]),

            [`0x0`],
            [
                MOSC

                Main oscillator
            ],

            [`0x1`],
            [
                PIOSC

                Precision internal oscillator (default)
            ],

            [`0x2`],
            [
                PIOSC/4

                Precision internal oscillator / 4
            ],

            [`0x3`],
            [
                LFIOSC

                Low-frequency internal oscillator
            ],
        )
        For additional oscillator sources, see the *RCC2* register.
    ],

    [3:1],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [0],
    [MOSCDIS],
    [RW],
    [1],
    [
        Main Oscillator Disable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The main oscillator is enabled.],
            [1], [The main oscillator is disabled (default).],
        )
    ],
))

#pagebreak()

==== Possible system clock frequencies using `SYSDIV` field
<sysdiv>
#align(center, pad(x: -5em, table(
    align: left,
    columns: 5,
    table.header(
        [*SYSDIV*],
        [*Divisor*],
        [*Frequency (BYPASS=0)*],
        [*Frequency (BYPASS=1)*],
        [*TivaWare Parameter*],
    ),

    [`0x0`], [/1], [Reserved], [Clock source frequency/1], [`SYSCTL_SYSDIV_1`],

    [`0x1`], [/2], [Reserved], [Clock source frequency/2], [`SYSCTL_SYSDIV_2`],

    [`0x2`], [/3], [66.67 MHz], [Clock source frequency/3], [`SYSCTL_SYSDIV_3`],

    [`0x3`], [/4], [50 MHz], [Clock source frequency/4], [`SYSCTL_SYSDIV_4`],

    [`0x4`], [/5], [40 MHz], [Clock source frequency/5], [`SYSCTL_SYSDIV_5`],

    [`0x5`], [/6], [33.33 MHz], [Clock source frequency/6], [`SYSCTL_SYSDIV_6`],

    [`0x6`], [/7], [28.57 MHz], [Clock source frequency/7], [`SYSCTL_SYSDIV_7`],

    [`0x7`], [/8], [25 MHz], [Clock source frequency/8], [`SYSCTL_SYSDIV_8`],

    [`0x8`], [/9], [22.22 MHz], [Clock source frequency/9], [`SYSCTL_SYSDIV_9`],

    [`0x9`], [/10], [20 MHz], [Clock source frequency/10], [`SYSCTL_SYSDIV_10`],

    [`0xA`],
    [/11],
    [18.18 MHz],
    [Clock source frequency/11],
    [`SYSCTL_SYSDIV_11`],

    [`0xB`],
    [/12],
    [16.67 MHz],
    [Clock source frequency/12],
    [`SYSCTL_SYSDIV_12`],

    [`0xC`],
    [/13],
    [15.38 MHz],
    [Clock source frequency/13],
    [`SYSCTL_SYSDIV_13`],

    [`0xD`],
    [/14],
    [14.29 MHz],
    [Clock source frequency/14],
    [`SYSCTL_SYSDIV_14`],

    [`0xE`],
    [/15],
    [13.33 MHz],
    [Clock source frequency/15],
    [`SYSCTL_SYSDIV_15`],

    [`0xF`],
    [/16],
    [12.5 MHz (default)],
    [Clock source frequency/16],
    [`SYSCTL_SYSDIV_16`],
)))

#pagebreak()

=== Run Mode Clock Gating Control Register 0 (RCGC0)
<rcgc0>
- Base `0x400F.E000`
- Offset `0x100`
- Type RO, reset `0x0000.0040`

#cimage("./images/rcgc0-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:29],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [28],
    [WDT1],
    [RO],
    [`0x0`],
    [
        WDT1 Clock Gating Control

        This bit controls the clock gating for the Watchdog Timer module 1. If
        set, the module receives a clock and functions. Otherwise, the module is
        unlocked and disabled. If the module is unlocked, a read or write to the
        module generates a bus fault.
    ],

    [27:26],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [25],
    [CAN1],
    [RO],
    [`0x0`],
    [
        CAN1 Clock Gating Control

        This bit controls the clock gating for CAN module 1. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [24],
    [CAN0],
    [RO],
    [`0x0`],
    [
        CAN0 Clock Gating Control

        This bit controls the clock gating for CAN module 0. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [23:21],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [20],
    [PWM0],
    [RO],
    [`0x0`],
    [
        PWM Clock Gating Control

        This bit controls the clock gating for the PWM module. If set, the
        module receives a clock and functions. Otherwise, the module is unlocked
        and disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [19:18],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [17],
    [ADC1],
    [RO],
    [`0x0`],
    [
        ADC1 Clock Gating Control

        This bit controls the clock gating for SAR ADC module 1. If set, the
        module receives a clock and functions. Otherwise, the module is unlocked
        and disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [16],
    [ADC0],
    [RO],
    [`0x0`],
    [
        ADC0 Clock Gating Control

        This bit controls the clock gating for ADC module 0. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [15:12],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11:10],
    [MAXADC1SPD],
    [RO],
    [`0x0`],
    [
        ADC1 Sample Speed

        This field sets the rate at which ADC module 1 samples data. You cannot
        set the rate higher than the maximum rate. You can set the sample rate
        by setting the `MAXADC1SPD` bit as follows (all other encodings are
        reserved):

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [125K samples/second],
            [`0x1`], [250K samples/second],
            [`0x2`], [500K samples/second],
            [`0x3`], [1M samples/second],
        )

        #v(10em)
    ],

    [9:8],
    [MAXADC0SPD],
    [RO],
    [`0x0`],
    [
        ADC0 Sample Speed

        This field sets the rate at which ADC0 samples data. You cannot set the
        rate higher than the maximum rate. You can set the sample rate by
        setting the `MAXADC0SPD` bit as follows (all other encodings are
        reserved):

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [125K samples/second],
            [`0x1`], [250K samples/second],
            [`0x2`], [500K samples/second],
            [`0x3`], [1M samples/second],
        )
    ],

    [7],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [6],
    [HIB],
    [RO],
    [`0x1`],
    [
        HIB Clock Gating Control

        This bit controls the clock gating for the Hibernation module. If set,
        the module receives a clock and functions. Otherwise, the module is
        unlocked and disabled. If the module is unlocked, a read or write to the
        module generates a bus fault.
    ],

    [5:4],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [WDT0],
    [RO],
    [`0x0`],
    [
        WDT0 Clock Gating Control

        This bit controls the clock gating for the Watchdog Timer module 0. If
        set, the module receives a clock and functions. Otherwise, the module is
        unlocked and disabled. If the module is unlocked, a read or write to the
        module generates a bus fault.
    ],

    [2:0],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],
))

#pagebreak()

=== Run Mode Clock Gating Control Register 2 (RCGC2)
<rcgc2>
- Base `0x400F.E000`
- Offset `0x108`
- Type RO, reset `0x0000.0000`

#cimage("./images/rcgc2-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:17],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [16],
    [USB0],
    [RO],
    [`0x0`],
    [
        USB0 Clock Gating Control

        This bit controls the clock gating for USB module 0. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [15:14],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [13],
    [UDMA],
    [RO],
    [`0x0`],
    [
        Micro-DMA Clock Gating Control

        This bit controls the clock gating for micro-DMA. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [12:6],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [5],
    [GPIOF],
    [RO],
    [`0x0`],
    [
        Port F Clock Gating Control

        This bit controls the clock gating for Port F. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [4],
    [GPIOE],
    [RO],
    [`0x0`],
    [
        Port E Clock Gating Control

        This bit controls the clock gating for Port E. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [3],
    [GPIOD],
    [RO],
    [`0x0`],
    [
        Port D Clock Gating Control

        This bit controls the clock gating for Port D. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [2],
    [GPIOC],
    [RO],
    [`0x0`],
    [
        Port C Clock Gating Control

        This bit controls the clock gating for Port C. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [1],
    [GPIOB],
    [RO],
    [`0x0`],
    [
        Port B Clock Gating Control

        This bit controls the clock gating for Port B. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],

    [0],
    [GPIOA],
    [RO],
    [`0x0`],
    [
        Port A Clock Gating Control

        This bit controls the clock gating for Port A. If set, the module
        receives a clock and functions. Otherwise, the module is unlocked and
        disabled. If the module is unlocked, a read or write to the module
        generates a bus fault.
    ],
))

#pagebreak()

=== PWMn Control (PWMnCTL)
<pwmnctl>
These registers configure the PWM signal generation blocks (#link(
    <pwmnctl>,
)[*PWM0CTL*] controls the PWM generator 0 block, and so on).

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x040`
- Type RW, reset `0x0000.0000`

Registers:
- Register 12: PWM0 Control (PWM0CTL), offset `0x040`
- Register 13: PWM1 Control (PWM1CTL), offset `0x080`
- Register 14: PWM2 Control (PWM2CTL), offset `0x0C0`
- Register 15: PWM3 Control (PWM3CTL), offset `0x100`

#cimage("./images/pwmnctl-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:19],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [18],
    [LATCH],
    [RW],
    [0],
    [
        Latch Fault Input

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                Fault Condition Not Latched

                A fault condition is in effect for as long as the generating
                source is asserting.
            ],

            [1],
            [
                Fault Condition Latched

                A fault condition is set as the result of the assertion of the
                faulting source and is held (latched) while the #link(
                    <pwmisc>,
                )[*PWMISC*] `INTFAULTn` bit is set. Clearing the `INTFAULTn` bit
                clears the fault condition.
            ],
        )

        *Note*: When using an ADC digital comparator as a fault source, the
        `LATCH` and `MINFLTPER` bits in the #link(<pwmnctl>)[*PWMnCTL*] register
        should be set to 1 to ensure trigger assertions are captured.

        #v(10em)
    ],

    [17],
    [MINFLTPER],
    [RW],
    [0],
    [
        Minimum Fault Period

        This bit specifies that the PWM generator enables a one-shot counter to
        provide a minimum fault condition period.

        The timer begins counting on the rising edge of the fault condition to
        extend the condition to the minimum duration of the count value. The
        timer ignores the state of the fault condition while counting.

        The minimum fault delay is in effect only when the `MINFLTPER` bit is
        set. If a detected fault is in the process of being extended when the
        `MINFLTPER` bit is cleared, the fault condition extension is aborted.

        The delay time is specified by the *PWMnMINFLTPER* register MFF field
        value. The effect of this is to pulse stretch the fault condition input.

        The delay value is defined by the PWM clock period. Because the fault
        input is not synchronized to the PWM clock, the period of the time is
        `PWMnCLOCK` (`MFFP` value + 1) or `PWMnCLOCK` (`MFFP` value + 2).

        The delay function makes sense only if the fault source is unlatched. A
        latched fault source makes the fault condition appear asserted until
        cleared by software and negates the utility of the extend feature. It
        applies to all fault condition sources as specified in the `FLTSRC`
        field.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `FAULT` input deassertion is unaffected.],
            [1],
            [
                The #link(<pwmnminfltper>)[*PWMnMINFLTPER*] one-shot counter is
                active and extends the period of the fault condition to a
                minimum period.
            ],
        )

        *Note*: When using an ADC digital comparator as a fault source, the
        `LATCH` and `MINFLTPER` bits in the #link(<pwmnctl>)[*PWMnCTL*] register
        should be set to 1 to ensure trigger assertions are captured.
    ],

    [16],
    [FLTSRC],
    [RW],
    [0],
    [
        Fault Condition Source

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The fault condition is determined by the `Faultn` input.],
            [1],
            [
                The fault condition is determined by the configuration of the
                `PWMnFLTSRC0` and `PWMnFLTSRC1` registers.
            ],
        )
    ],

    [15:14],
    [DBFALLUPD],
    [RW],
    [`0x0`],
    [
        #link(<pwmndbfall>)[*PWMnDBFALL*] Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [
                Immediate

                #link(<pwmndbfall>)[*PWMnDBFALL*] register value is immediately
                updated on a write.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [
                Locally Synchronized

                Updates to the register are reflected to the generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [
                Globally Synchronized

                Updates to the register are delayed until the next time the
                counter is 0 after a synchronous update has been requested
                through the #link(<pwmctl>)[*PWMCTL*] register.
            ],
        )
    ],

    [13:12],
    [DBRISEUPD],
    [RW],
    [`0x0`],
    [
        #link(<pwmndbrise>)[*PWMnDBRISE*] Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [
                Immediate

                The #link(<pwmndbrise>)[*PWMnDBRISE*] register value is
                immediately updated on a write.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [
                Locally Synchronized

                Updates to the register are reflected to the generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [
                Globally Synchronized

                Updates to the register are delayed until the next time the
                counter is 0 after a synchronous update has been requested
                through the #link(<pwmctl>)[*PWMCTL*] register.
            ],
        )

        #v(20em)
    ],

    [11:10],
    [DBCTLUPD],
    [RW],
    [`0x0`],
    [
        #link(<pwmndbctl>)[*PWMnDBCTL*] Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [
                Immediate

                The #link(<pwmndbctl>)[*PWMnDBCTL*] register value is
                immediately updated on a write.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [
                Locally Synchronized

                Updates to the register are reflected to the generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [
                Globally Synchronized

                Updates to the register are delayed until the next time the
                counter is 0 after a synchronous update has been requested
                through the #link(<pwmctl>)[*PWMCTL*] register.
            ],
        )
    ],

    [9:8],
    [GENBUPD],
    [RW],
    [`0x0`],
    [
        #link(<pwmngenb>)[*PWMnGENB*] Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [
                Immediate

                The #link(<pwmngenb>)[*PWMnGENB*] register value is immediately
                updated on a write.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [
                Locally Synchronized

                Updates to the register are reflected to the generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [
                Globally Synchronized

                Updates to the register are delayed until the next time the
                counter is 0 after a synchronous update has been requested
                through the #link(<pwmctl>)[*PWMCTL*] register.
            ],
        )

        #v(20em)
    ],

    [7:6],
    [GENAUPD],
    [RW],
    [`0x0`],
    [
        #link(<pwmngena>)[*PWMnGENA*] Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [
                Immediate

                The #link(<pwmngena>)[*PWMnGENA*] register value is immediately
                updated on a write.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [
                Locally Synchronized

                Updates to the register are reflected to the generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [
                Globally Synchronized

                Updates to the register are delayed until the next time the
                counter is 0 after a synchronous update has been requested
                through the #link(<pwmctl>)[*PWMCTL*] register.
            ],
        )
    ],

    [5],
    [CMPBUPD],
    [RW],
    [0],
    [
        Comparator B Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                Locally Synchronized

                Updates to the #link(<pwmncmpb>)[*PWMnCMPB*] register are
                reflected to the generator the next time the counter is 0.
            ],

            [1],
            [
                Globally Synchronized

                Updates to the register are delayed until the next time the
                counter is 0 after a synchronous update has been requested
                through the #link(<pwmctl>)[*PWMCTL*] register.
            ],
        )
    ],

    [4],
    [CMPAUPD],
    [RW],
    [0],
    [
        Comparator A Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                Locally Synchronized

                Updates to the #link(<pwmncmpa>)[*PWMnCMPA*] register are
                reflected to the generator the next time the counter is 0.
            ],

            [1],
            [
                Globally Synchronized

                Updates to the register are delayed until the next time the
                counter is 0 after a synchronous update has been requested
                through the #link(<pwmctl>)[*PWMCTL*] register.
            ],
        )

        #v(10em)
    ],

    [3],
    [LOADUPD],
    [RW],
    [0],
    [
        Load Register Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                Locally Synchronized

                Updates to the #link(<pwmnload>)[*PWMnLOAD*] register are
                reflected to the generator the next time the counter is 0.
            ],

            [1],
            [
                Globally Synchronized

                Updates to the register are delayed until the next time the
                counter is 0 after a synchronous update has been requested
                through the #link(<pwmctl>)[*PWMCTL*] register.
            ],
        )
    ],

    [2],
    [DEBUG],
    [RW],
    [0],
    [
        Debug Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The counter stops running when it next reaches 0 and continues
                running again when no longer in Debug mode.],

            [1], [The counter always runs when in Debug mode.],
        )
    ],

    [1],
    [MODE],
    [RW],
    [0],
    [
        Counter Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The counter counts down from the load value to 0 and then wraps
                back to the load value (Count-Down mode).],

            [1],
            [The counter counts up from 0 to the load value, back down to 0, and
                then repeats (Count-Up/Down mode).],
        )
    ],

    [0],
    [ENABLE],
    [RW],
    [0],
    [
        PWM Block Enable

        *Note*: Disabling the PWM by clearing the `ENABLE` bit does not clear
        the `COUNT` field of the #link(<pwmncount>)[*PWMnCOUNT*] register.
        Before re-enabling the PWM (`ENABLE = 0x1`), the `COUNT` field should be
        cleared by resetting the PWM registers through the *SRPWM* register in
        the System Control Module.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The entire PWM generation block is disabled and not clocked.],
            [1],
            [The PWM generation block is enabled and produces PWM signals.],
        )
    ],
))

#pagebreak()

=== PWMn Generator A Control (PWMnGENA)
<pwmngena>
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x060`
- Type RW, reset `0x0000.0000`

Registers:
- Register 44: PWM0 Generator A Control (PWM0GENA), offset `0x060`
- Register 45: PWM1 Generator A Control (PWM1GENA), offset `0x0A0`
- Register 46: PWM2 Generator A Control (PWM2GENA), offset `0x0E0`
- Register 47: PWM3 Generator A Control (PWM3GENA), offset `0x120`

#cimage("./images/pwmngena-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:12],
    [reserved],
    [RO],
    [`0x000.0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11:10],
    [ACTCMPBD],
    [RW],
    [`0x0`],
    [
        Action for Comparator B Down

        This field specifies the action to be taken when the counter matches
        comparator B while counting down.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmA.],
            [`0x2`], [Drive pwmA Low.],
            [`0x3`], [Drive pwmA High.],
        )
    ],

    [9:8],
    [ACTCMPBU],
    [RW],
    [`0x0`],
    [
        Action for Comparator B Up

        This field specifies the action to be taken when the counter matches
        comparator B while counting up. This action can only occur when the
        `MODE` bit in the #link(<pwmnctl>)[*PWMnCTL*] register is set.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmA.],
            [`0x2`], [Drive pwmA Low.],
            [`0x3`], [Drive pwmA High.],
        )

        #v(10em)
    ],

    [7:6],
    [ACTCMPAD],
    [RW],
    [`0x0`],
    [
        Action for Comparator A Down

        This field specifies the action to be taken when the counter matches
        comparator A while counting down.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmA.],
            [`0x2`], [Drive pwmA Low.],
            [`0x3`], [Drive pwmA High.],
        )
    ],

    [5:4],
    [ACTCMPAU],
    [RW],
    [`0x0`],
    [
        Action for Comparator A Up

        This field specifies the action to be taken when the counter matches
        comparator A while counting up. This action can only occur when the
        `MODE` bit in the #link(<pwmnctl>)[*PWMnCTL*] register is set.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmA.],
            [`0x2`], [Drive pwmA Low.],
            [`0x3`], [Drive pwmA High.],
        )
    ],

    [3:2],
    [ACTLOAD],
    [RW],
    [`0x0`],
    [
        Action for Counter=`LOAD`

        This field specifies the action to be taken when the counter matches the
        value in the #link(<pwmnload>)[*PWMnLOAD*] register.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmA.],
            [`0x2`], [Drive pwmA Low.],
            [`0x3`], [Drive pwmA High.],
        )
    ],

    [1:0],
    [ACTZERO],
    [RW],
    [`0x0`],
    [
        Action for Counter=0

        This field specifies the action to be taken when the counter is zero.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmA.],
            [`0x2`], [Drive pwmA Low.],
            [`0x3`], [Drive pwmA High.],
        )
    ],
))

#pagebreak()

=== PWMn Generator B Control (PWMnGENB)
<pwmngenb>
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x064`
- Type RW, reset `0x0000.0000`

Registers:
- Register 48: PWM0 Generator B Control (PWM0GENB), offset `0x064`
- Register 49: PWM1 Generator B Control (PWM1GENB), offset `0x0A4`
- Register 50: PWM2 Generator B Control (PWM2GENB), offset `0x0E4`
- Register 51: PWM3 Generator B Control (PWM3GENB), offset `0x124`

#cimage("./images/pwmngenb-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:12],
    [reserved],
    [RO],
    [`0x000.0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11:10],
    [ACTCMPBD],
    [RW],
    [`0x0`],
    [
        Action for Comparator B Down

        This field specifies the action to be taken when the counter matches
        comparator B while counting down.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmB.],
            [`0x2`], [Drive pwmB Low.],
            [`0x3`], [Drive pwmB High.],
        )
    ],

    [9:8],
    [ACTCMPBU],
    [RW],
    [`0x0`],
    [
        Action for Comparator B Up

        This field specifies the action to be taken when the counter matches
        comparator B while counting up. This action can only occur when the
        `MODE` bit in the #link(<pwmnctl>)[*PWMnCTL*] register is set.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmB.],
            [`0x2`], [Drive pwmB Low.],
            [`0x3`], [Drive pwmB High.],
        )

        #v(10em)
    ],

    [7:6],
    [ACTCMPAD],
    [RW],
    [`0x0`],
    [
        Action for Comparator A Down

        This field specifies the action to be taken when the counter matches
        comparator A while counting down.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmB.],
            [`0x2`], [Drive pwmB Low.],
            [`0x3`], [Drive pwmB High.],
        )
    ],

    [5:4],
    [ACTCMPAU],
    [RW],
    [`0x0`],
    [
        Action for Comparator A Up

        This field specifies the action to be taken when the counter matches
        comparator A while counting up. This action can only occur when the
        `MODE` bit in the #link(<pwmnctl>)[*PWMnCTL*] register is set.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmB.],
            [`0x2`], [Drive pwmB Low.],
            [`0x3`], [Drive pwmB High.],
        )
    ],

    [3:2],
    [ACTLOAD],
    [RW],
    [`0x0`],
    [
        Action for Counter=`LOAD`

        This field specifies the action to be taken when the counter matches the
        load value.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmB.],
            [`0x2`], [Drive pwmB Low.],
            [`0x3`], [Drive pwmB High.],
        )
    ],

    [1:0],
    [ACTZERO],
    [RW],
    [`0x0`],
    [
        Action for Counter=0

        This field specifies the action to be taken when the counter is 0.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Do nothing.],
            [`0x1`], [Invert pwmB.],
            [`0x2`], [Drive pwmB Low.],
            [`0x3`], [Drive pwmB High.],
        )
    ],
))

#pagebreak()

=== PWMn Load (PWMnLOAD)
<pwmnload>
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x050`
- Type RW, reset `0x0000.0000`

Registers:
- Register 28: PWM0 Load (PWM0LOAD), offset `0x050`
- Register 29: PWM1 Load (PWM1LOAD), offset `0x090`
- Register 30: PWM2 Load (PWM2LOAD), offset `0x0D0`
- Register 31: PWM3 Load (PWM3LOAD), offset `0x110`

#cimage("./images/pwmnload-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [LOAD],
    [RW],
    [`0x0000`],
    [
        Counter Load Value

        The counter load value.
    ],
))

#pagebreak()

=== PWMn Compare A (PWMnCMPA)
<pwmncmpa>
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x058`
- Type RW, reset `0x0000.0000`

Registers:
- Register 36: PWM0 Compare A (PWM0CMPA), offset `0x058`
- Register 37: PWM1 Compare A (PWM1CMPA), offset `0x098`
- Register 38: PWM2 Compare A (PWM2CMPA), offset `0x0D8`
- Register 39: PWM3 Compare A (PWM3CMPA), offset `0x118`

#cimage("./images/pwmncmpa-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [COMPA],
    [RW],
    [`0x00`],
    [
        Comparator A Value

        The value to be compared against the counter.
    ],
))

#pagebreak()

=== PWMn Compare B (PWMnCMPB)
<pwmncmpb>
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x05C`
- Type RW, reset `0x0000.0000`

Registers:
- Register 40: PWM0 Compare B (PWM0CMPB), offset `0x05C`
- Register 41: PWM1 Compare B (PWM1CMPB), offset `0x09C`
- Register 42: PWM2 Compare B (PWM2CMPB), offset `0x0DC`
- Register 43: PWM3 Compare B (PWM3CMPB), offset `0x11C`

#cimage("./images/pwmncmpb-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [COMPB],
    [RW],
    [`0x0000`],
    [
        Comparator B Value

        The value to be compared against the counter.
    ],
))

#pagebreak()

=== PWM Output Enable (PWMENABLE)
<pwmenable>
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x008`
- Type RW, reset `0x0000.0000`

#cimage("./images/pwmenable-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7],
    [PWM7EN],
    [RW],
    [0],
    [
        `MnPWM7` Output Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM7` signal has a zero value.],
            [1], [The generated pwm3B' signal is passed to the `MnPWM7` pin.],
        )
    ],

    [6],
    [PWM6EN],
    [RW],
    [0],
    [
        `MnPWM6` Output Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM6` signal has a zero value.],
            [1], [The generated pwm3A' signal is passed to the `MnPWM6` pin.],
        )
    ],

    [5],
    [PWM5EN],
    [RW],
    [0],
    [
        `MnPWM5` Output Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM5` signal has a zero value.],
            [1], [The generated pwm2B' signal is passed to the `MnPWM5` pin.],
        )
    ],

    [4],
    [PWM4EN],
    [RW],
    [0],
    [
        `MnPWM4` Output Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM4` signal has a zero value.],
            [1], [The generated pwm2A' signal is passed to the `MnPWM4` pin.],
        )

        #v(10em)
    ],

    [3],
    [PWM3EN],
    [RW],
    [0],
    [
        `MnPWM3` Output Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM3` signal has a zero value.],
            [1], [The generated pwm1B' signal is passed to the `MnPWM3` pin.],
        )
    ],

    [2],
    [PWM2EN],
    [RW],
    [0],
    [
        `MnPWM2` Output Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM2` signal has a zero value.],
            [1], [The generated pwm1A' signal is passed to the `MnPWM2` pin.],
        )
    ],

    [1],
    [PWM1EN],
    [RW],
    [0],
    [
        `MnPWM1` Output Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM1` signal has a zero value.],
            [1], [The generated pwm0B' signal is passed to the `MnPWM1` pin.],
        )
    ],

    [0],
    [PWM0EN],
    [RW],
    [0],
    [
        `MnPWM0` Output Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM0` signal has a zero value.],
            [1], [The generated pwm0A' signal is passed to the `MnPWM0` pin.],
        )
    ],
))

#pagebreak()

=== PWMn Dead-Band Rising-Edge Delay (PWMnDBRISE)
<pwmndbrise>
This register sets the dead-band rising delay.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x06C`
- Type RW, reset `0x0000.0000`

Registers:
- Register 56: PWM0 Dead-Band Rising-Edge Delay (PWM0DBRISE), offset `0x06C`
- Register 57: PWM1 Dead-Band Rising-Edge Delay (PWM1DBRISE), offset `0x0AC`
- Register 58: PWM2 Dead-Band Rising-Edge Delay (PWM2DBRISE), offset `0x0EC`
- Register 59: PWM3 Dead-Band Rising-Edge Delay (PWM3DBRISE), offset `0x12C`

#cimage("./images/pwmndbrise-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:12],
    [reserved],
    [RO],
    [`0x0000.0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11:0],
    [RISEDELAY],
    [RW],
    [`0x000`],
    [
        Dead-Band Rise Delay

        The number of clock cycles to delay the rising edge of pwmA' after the
        rising edge of pwmA.
    ],
))

#pagebreak()

=== PWMn Dead-Band Falling-Edge-Delay (PWMnDBFALL)
<pwmndbfall>
This register sets the dead-band falling delay.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x070`
- Type RW, reset `0x0000.0000`

Registers:
- Register 60: PWM0 Dead-Band Falling-Edge-Delay (PWM0DBFALL), offset `0x070`
- Register 61: PWM1 Dead-Band Falling-Edge-Delay (PWM1DBFALL), offset `0x0B0`
- Register 62: PWM2 Dead-Band Falling-Edge-Delay (PWM2DBFALL), offset `0x0F0`
- Register 63: PWM3 Dead-Band Falling-Edge-Delay (PWM3DBFALL), offset `0x130`

#cimage("./images/pwmndbfall-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:12],
    [reserved],
    [RO],
    [`0x0000.0`],
    [
        Software should not rely on on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11:0],
    [FALLDELAY],
    [RW],
    [`0x000`],
    [
        Dead-Band Fall Delay

        The number of clock cycles to delay the falling edge of pwmB' from the
        rising edge of pwmA.
    ],
))

#pagebreak()

=== PWMn Fault Source 0 (PWMnFLTSRC0)
<pwmnfltsrc0>
This register enables the PWM's fault source 0, which has 2 fault input pins. It
specifies which fault pin inputs are used to generate a fault condition. Each
bit in this register indicates whether the corresponding fault pin is included
in the fault condition.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x074`
- Type RW, reset `0x0000.0000`

Registers:
- Register 64: PWM0 Fault Source 0 (PWM0FLTSRC0), offset `0x074`
- Register 65: PWM1 Fault Source 0 (PWM1FLTSRC0), offset `0x0B4`
- Register 66: PWM2 Fault Source 0 (PWM2FLTSRC0), offset `0x0F4`
- Register 67: PWM3 Fault Source 0 (PWM3FLTSRC0), offset `0x134`

#cimage("./images/pwmnfltsrc0-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:2],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1],
    [FAULT1],
    [RW],
    [0],
    [
        `Fault1` Input

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `Fault1` signal is suppressed and cannot generate a fault
                condition.
            ],

            [1],
            [
                The `Fault1` signal value is ORed with all other fault condition
                generation inputs (`Faultn` signals and digital comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.

        #v(20em)
    ],

    [0],
    [FAULT0],
    [RW],
    [0],
    [
        `Fault0` Input

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `Fault0` signal is suppressed and cannot generate a fault
                condition.
            ],

            [1],
            [
                The `Fault0` signal value is ORed with all other fault condition
                generation inputs (`Faultn` signals and digital comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.
    ],
))

#pagebreak()

=== PWMn Fault Source 1 (PWMnFLTSRC1)
<pwmnfltsrc1>
This register enables the PWM's fault source 1, which contains ADC's 8 digital
comparators. It also specifies which digital comparator triggers from the ADC
are used to generate a fault condition. Each bit in this register indicates
whether the corresponding digital comparator trigger is included in the fault
condition.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x078`
- Type RW, reset `0x0000.0000`

Registers:
- Register 68: PWM0 Fault Source 1 (PWM0FLTSRC1), offset `0x078`
- Register 69: PWM1 Fault Source 1 (PWM1FLTSRC1), offset `0x0B8`
- Register 70: PWM2 Fault Source 1 (PWM2FLTSRC1), offset `0x0F8`
- Register 71: PWM3 Fault Source 1 (PWM3FLTSRC1), offset `0x138`

#cimage("./images/pwmnfltsrc1-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7],
    [DCMP7],
    [RW],
    [0],
    [
        Digital Comparator 7

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The trigger from digital comparator 7 is suppressed and cannot
                generate a fault condition.
            ],

            [1],
            [
                The trigger from digital comparator 7 is ORed with all other
                fault condition generation inputs (`Faultn` signals and digital
                comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.

        #v(20em)
    ],

    [6],
    [DCMP6],
    [RW],
    [0],
    [
        Digital Comparator 6

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The trigger from digital comparator 6 is suppressed and cannot
                generate a fault condition.
            ],

            [1],
            [
                The trigger from digital comparator 6 is ORed with all other
                fault condition generation inputs (`Faultn` signals and digital
                comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.
    ],

    [5],
    [DCMP5],
    [RW],
    [0],
    [
        Digital Comparator 5

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The trigger from digital comparator 5 is suppressed and cannot
                generate a fault condition.
            ],

            [1],
            [
                The trigger from digital comparator 5 is ORed with all other
                fault condition generation inputs (`Faultn` signals and digital
                comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.
    ],

    [4],
    [DCMP4],
    [RW],
    [0],
    [
        Digital Comparator 4

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The trigger from digital comparator 4 is suppressed and cannot
                generate a fault condition.
            ],

            [1],
            [
                The trigger from digital comparator 4 is ORed with all other
                fault condition generation inputs (`Faultn` signals and digital
                comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.

        #v(10em)
    ],

    [3],
    [DCMP3],
    [RW],
    [0],
    [
        Digital Comparator 3

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The trigger from digital comparator 3 is suppressed and cannot
                generate a fault condition.
            ],

            [1],
            [
                The trigger from digital comparator 3 is ORed with all other
                fault condition generation inputs (`Faultn` signals and digital
                comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.
    ],

    [2],
    [DCMP2],
    [RW],
    [0],
    [
        Digital Comparator 2

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The trigger from digital comparator 2 is suppressed and cannot
                generate a fault condition.
            ],

            [1],
            [
                The trigger from digital comparator 2 is ORed with all other
                fault condition generation inputs (`Faultn` signals and digital
                comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.
    ],

    [1],
    [DCMP1],
    [RW],
    [0],
    [
        Digital Comparator 1

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The trigger from digital comparator 1 is suppressed and cannot
                generate a fault condition.
            ],

            [1],
            [
                The trigger from digital comparator 1 is ORed with all other
                fault condition generation inputs (`Faultn` signals and digital
                comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.

        #v(10em)
    ],

    [0],
    [DCMP0],
    [RW],
    [0],
    [
        Digital Comparator 0

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The trigger from digital comparator 0 is suppressed and cannot
                generate a fault condition.
            ],

            [1],
            [
                The trigger from digital comparator 0 is ORed with all other
                fault condition generation inputs (`Faultn` signals and digital
                comparators).
            ],
        )

        *Note*: The `FLTSRC` bit in the #link(<pwmnctl>)[*PWMnCTL*] register
        must be set for this bit to affect fault condition generation.
    ],
))

#pagebreak()

=== PWMn Dead-Band Control (PWMnDBCTL)
<pwmndbctl>
This register enables the use of the PWM's dead-band between pulses A' and B'.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x068`
- Type RW, reset `0x0000.0000`

Registers:
- Register 52: PWM0 Dead-Band Control (PWM0DBCTL), offset `0x068`
- Register 53: PWM1 Dead-Band Control (PWM1DBCTL), offset `0x0A8`
- Register 54: PWM2 Dead-Band Control (PWM2DBCTL), offset `0x0E8`
- Register 55: PWM3 Dead-Band Control (PWM3DBCTL), offset `0x128`

#cimage("./images/pwmndbctl-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:1],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [0],
    [ENABLE],
    [RW],
    [0],
    [
        Dead-Band Generator Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The pwmA and pwmB signals pass through to the pwmA' and pwmB'
                signals unmodified.
            ],

            [1],
            [
                The dead-band generator modifies the pwmA signal by inserting
                dead bands into the pwmA' and pwmB' signals.
            ],
        )
    ],
))

#pagebreak()

=== PWM Time Base Sync (PWMSYNC)
<pwmsync>
This register provides a method to perform synchronisation of the counters in
the PWM generation blocks. Setting a bit in this register causes the specified
counter to reset back to 0.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x004`
- Type RW, reset `0x0000.0000`

#cimage("./images/pwmsync-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [`0x000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [SYNC3],
    [RW],
    [0],
    [
        Reset Generator 3 Counter

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No effect.],
            [1], [Resets the PWM generator 3 counter.],
        )
    ],

    [2],
    [SYNC2],
    [RW],
    [0],
    [
        Reset Generator 2 Counter

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No effect.],
            [1], [Resets the PWM generator 2 counter.],
        )
    ],

    [1],
    [SYNC1],
    [RW],
    [0],
    [
        Reset Generator 1 Counter

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No effect.],
            [1], [Resets the PWM generator 1 counter.],
        )
    ],

    [0],
    [SYNC0],
    [RW],
    [0],
    [
        Reset Generator 0 Counter

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No effect.],
            [1], [Resets the PWM generator 0 counter.],
        )
    ],
))

#pagebreak()

=== PWM Master Control (PWMCTL)
<pwmctl>
This register provides master control over the PWM generation blocks.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x000`
- Type RW, reset `0x0000.0000`

#cimage("./images/pwmctl-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:4],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [GLOBALSYNC3],
    [RW],
    [0],
    [
        Update PWM Generator 3

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No effect.],
            [1],
            [
                Any queued update to a load or comparator register in PWM
                generator 3 is applied the next time the corresponding counter
                becomes zero.
            ],
        )

        This bit automatically clears when the updates have completed; it cannot
        be cleared by software.
    ],

    [2],
    [GLOBALSYNC2],
    [RW],
    [0],
    [
        Update PWM Generator 2

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No effect.],
            [1],
            [
                Any queued update to a load or comparator register in PWM
                generator 2 is applied the next time the corresponding counter
                becomes zero.
            ],
        )

        This bit automatically clears when the updates have completed; it cannot
        be cleared by software.

        #v(10em)
    ],

    [1],
    [GLOBALSYNC1],
    [RW],
    [0],
    [
        Update PWM Generator 1

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No effect.],
            [1],
            [
                Any queued update to a load or comparator register in PWM
                generator 1 is applied the next time the corresponding counter
                becomes zero.
            ],
        )

        This bit automatically clears when the updates have completed; it cannot
        be cleared by software.
    ],

    [0],
    [GLOBALSYNC0],
    [RW],
    [0],
    [
        Update PWM Generator 0

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No effect.],
            [1],
            [
                Any queued update to a load or comparator register in PWM
                generator 0 is applied the next time the corresponding counter
                becomes zero.
            ],
        )

        This bit automatically clears when the updates have completed; it cannot
        be cleared by software.
    ],
))

#pagebreak()

=== PWMn Minimum Fault Period (PWMnMINFLTPER)
<pwmnminfltper>
This register sets the minimum delay period before releasing the fault
condition. It specifies the 16-bit time extension value to be used in extending
the fault condition.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x07C`
- Type RW, reset `0x0000.0000`

Registers:
- Register 72: PWM0 Minimum Fault Period (PWM0MINFLTPER), offset `0x07C`
- Register 73: PWM1 Minimum Fault Period (PWM1MINFLTPER), offset `0x0BC`
- Register 74: PWM2 Minimum Fault Period (PWM2MINFLTPER), offset `0x0FC`
- Register 75: PWM3 Minimum Fault Period (PWM3MINFLTPER), offset `0x13C`

#cimage("./images/pwmnminfltper-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [MFP],
    [RW],
    [`0x0000`],
    [
        Minimum Fault Period

        The number of PWM clocks by which a fault condition is extended when the
        delay is enabled by #link(<pwmnctl>)[*PWMnCTL*] `MINFLIPER`.
    ],
))

#pagebreak()

=== PWMn Fault Pin Logic Sense (PWMnFLTSEN)
<pwmnfltsen>
This register defines the PWM fault pin logic sense.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x800`
- Type RW, reset `0x0000.0000`

Registers:
- Register 76: PWM0 Fault Pin Logic Sense (PWM0FLTSEN), offset `0x800`
- Register 77: PWM1 Fault Pin Logic Sense (PWM1FLTSEN), offset `0x880`

#cimage("./images/pwmnfltsen-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:2],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1],
    [FAULT1],
    [RW],
    [0],
    [
        Fault1 Sense

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An error is indicated if the `Fault1` signal is High.],
            [1], [An error is indicated if the `Fault1` signal is Low.],
        )
    ],

    [0],
    [FAULT0],
    [RW],
    [0],
    [
        Fault0 Sense

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An error is indicated if the `Fault0` signal is High.],
            [1], [An error is indicated if the `Fault0` signal is Low.],
        )
    ],
))

#pagebreak()

=== PWM Enable Update (PWMENUPD)
<pwmenupd>
This register specifies when updates to the `PWMnEN` bit in #link(
    <pwmenable>,
)[*PWMENABLE*] register are performed.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x028`
- Type RW, reset `0x0000.0000`

#cimage("./images/pwmenupd-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:14],
    [ENUPD7],
    [RW],
    [0],
    [
        `MnPWM7` Enable Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [Immediate

                Writes to the `PWM7EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator
                immediately.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [Locally Synchronized

                Writes to the `PWM7EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [Globally Synchronized

                Writes to the `PWM7EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0 after a synchronous update has been
                requested through the PWM Master Control (#link(
                    <pwmctl>,
                )[*PWMCTL*]) register.
            ],
        )

        #v(20em)
    ],

    [13:12],
    [ENUPD6],
    [RW],
    [0],
    [
        `MnPWM6` Enable Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [Immediate

                Writes to the `PWM6EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator
                immediately.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [Locally Synchronized

                Writes to the `PWM6EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [Globally Synchronized

                Writes to the `PWM6EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0 after a synchronous update has been
                requested through the PWM Master Control (#link(
                    <pwmctl>,
                )[*PWMCTL*]) register.
            ],
        )
    ],

    [11:10],
    [ENUPD5],
    [RW],
    [0],
    [
        `MnPWM5` Enable Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [Immediate

                Writes to the `PWM5EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator
                immediately.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [Locally Synchronized

                Writes to the `PWM5EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [Globally Synchronized

                Writes to the `PWM5EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0 after a synchronous update has been
                requested through the PWM Master Control (#link(
                    <pwmctl>,
                )[*PWMCTL*]) register.
            ],
        )

        #v(10em)
    ],

    [9:8],
    [ENUPD4],
    [RW],
    [0],
    [
        `MnPWM4` Enable Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [Immediate

                Writes to the `PWM4EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator
                immediately.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [Locally Synchronized

                Writes to the `PWM4EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [Globally Synchronized

                Writes to the `PWM4EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0 after a synchronous update has been
                requested through the PWM Master Control (#link(
                    <pwmctl>,
                )[*PWMCTL*]) register.
            ],
        )
    ],

    [7:6],
    [ENUPD3],
    [RW],
    [0],
    [
        `MnPWM3` Enable Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [Immediate

                Writes to the `PWM3EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator
                immediately.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [Locally Synchronized

                Writes to the `PWM3EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [Globally Synchronized

                Writes to the `PWM3EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0 after a synchronous update has been
                requested through the PWM Master Control (#link(
                    <pwmctl>,
                )[*PWMCTL*]) register.
            ],
        )

        #v(10em)
    ],

    [5:4],
    [ENUPD2],
    [RW],
    [0],
    [
        `MnPWM2` Enable Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [Immediate

                Writes to the `PWM2EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator
                immediately.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [Locally Synchronized

                Writes to the `PWM2EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [Globally Synchronized

                Writes to the `PWM2EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0 after a synchronous update has been
                requested through the PWM Master Control (#link(
                    <pwmctl>,
                )[*PWMCTL*]) register.
            ],
        )
    ],

    [3:2],
    [ENUPD1],
    [RW],
    [0],
    [
        `MnPWM1` Enable Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [Immediate

                Writes to the `PWM1EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator
                immediately.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [Locally Synchronized

                Writes to the `PWM1EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [Globally Synchronized

                Writes to the `PWM1EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0 after a synchronous update has been
                requested through the PWM Master Control (#link(
                    <pwmctl>,
                )[*PWMCTL*]) register.
            ],
        )

        #v(10em)
    ],

    [1:0],
    [ENUPD0],
    [RW],
    [0],
    [
        `MnPWM0` Enable Update Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [Immediate

                Writes to the `PWM0EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator
                immediately.
            ],

            [`0x1`], [Reserved],
            [`0x2`],
            [Locally Synchronized

                Writes to the `PWM0EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0.
            ],

            [`0x3`],
            [Globally Synchronized

                Writes to the `PWM0EN` bit in the #link(
                    <pwmenable>,
                )[*PWMENABLE*] register are used by the PWM generator the next
                time the counter is 0 after a synchronous update has been
                requested through the PWM Master Control (#link(
                    <pwmctl>,
                )[*PWMCTL*]) register.
            ],
        )
    ],
))

#pagebreak()

=== PWM Output Inversion (PWMINVERT)
<pwminvert>
This register provides a master control of the polarity of the `MnPWMn` signals
on the device pins.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x00C`
- Type RW, reset `0x0000.0000`

#cimage("./images/pwminvert-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7],
    [PWM7INV],
    [RW],
    [0],
    [
        Invert `MnPWM7` Signal

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM7` signal is not inverted.],
            [1], [The `MnPWM7` signal is inverted.],
        )
    ],

    [6],
    [PWM6INV],
    [RW],
    [0],
    [
        Invert `MnPWM6` Signal

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM6` signal is not inverted.],
            [1], [The `MnPWM6` signal is inverted.],
        )
    ],

    [5],
    [PWM5INV],
    [RW],
    [0],
    [
        Invert `MnPWM5` Signal

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM5` signal is not inverted.],
            [1], [The `MnPWM5` signal is inverted.],
        )
    ],

    [4],
    [PWM4INV],
    [RW],
    [0],
    [
        Invert `MnPWM4` Signal

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM4` signal is not inverted.],
            [1], [The `MnPWM4` signal is inverted.],
        )

        #v(10em)
    ],

    [3],
    [PWM3INV],
    [RW],
    [0],
    [
        Invert `MnPWM3` Signal

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM3` signal is not inverted.],
            [1], [The `MnPWM3` signal is inverted.],
        )
    ],

    [2],
    [PWM2INV],
    [RW],
    [0],
    [
        Invert `MnPWM2` Signal

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM2` signal is not inverted.],
            [1], [The `MnPWM2` signal is inverted.],
        )
    ],

    [1],
    [PWM1INV],
    [RW],
    [0],
    [
        Invert `MnPWM1` Signal

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM1` signal is not inverted.],
            [1], [The `MnPWM1` signal is inverted.],
        )
    ],

    [0],
    [PWM0INV],
    [RW],
    [0],
    [
        Invert `MnPWM0` Signal

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The `MnPWM0` signal is not inverted.],
            [1], [The `MnPWM0` signal is inverted.],
        )
    ],
))

#pagebreak()

=== PWM Output Fault (PWMFAULT)
<pwmfault>
This register controls the behaviour of the `MnPWMn` outputs in the presence of
fault conditions.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x010`
- Type RW, reset `0x0000.0000`

#cimage("./images/pwmfault-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7],
    [FAULT7],
    [RW],
    [0],
    [
        `MnPWM7` Fault

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The generated pwm3B' signal is passed to the `MnPWM7` pin.],
            [1],
            [
                The `MnPWM7` output signal is driven to the value specified by
                the `PWM7` bit in the #link(<pwmfaultval>)[*PWMFAULTVAL*]
                register.
            ],
        )
    ],

    [6],
    [FAULT6],
    [RW],
    [0],
    [
        `MnPWM6` Fault

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The generated pwm3A' signal is passed to the `MnPWM6` pin.],
            [1],
            [
                The `MnPWM6` output signal is driven to the value specified by
                the `PWM6` bit in the #link(<pwmfaultval>)[*PWMFAULTVAL*]
                register.
            ],
        )
    ],

    [5],
    [FAULT5],
    [RW],
    [0],
    [
        `MnPWM5` Fault

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The generated pwm2B' signal is passed to the `MnPWM5` pin.],
            [1],
            [
                The `MnPWM5` output signal is driven to the value specified by
                the `PWM5` bit in the #link(<pwmfaultval>)[*PWMFAULTVAL*]
                register.
            ],
        )

        #v(10em)
    ],

    [4],
    [FAULT4],
    [RW],
    [0],
    [
        `MnPWM4` Fault

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The generated pwm2A' signal is passed to the `MnPWM4` pin.],
            [1],
            [
                The `MnPWM4` output signal is driven to the value specified by
                the `PWM4` bit in the #link(<pwmfaultval>)[*PWMFAULTVAL*]
                register.
            ],
        )
    ],

    [3],
    [FAULT3],
    [RW],
    [0],
    [
        `MnPWM3` Fault

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The generated pwm1B' signal is passed to the `MnPWM3` pin.],
            [1],
            [
                The `MnPWM3` output signal is driven to the value specified by
                the `PWM3` bit in the #link(<pwmfaultval>)[*PWMFAULTVAL*]
                register.
            ],
        )
    ],

    [2],
    [FAULT2],
    [RW],
    [0],
    [
        `MnPWM2` Fault

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The generated pwm1A' signal is passed to the `MnPWM2` pin.],
            [1],
            [
                The `MnPWM2` output signal is driven to the value specified by
                the `PWM2` bit in the #link(<pwmfaultval>)[*PWMFAULTVAL*]
                register.
            ],
        )
    ],

    [1],
    [FAULT1],
    [RW],
    [0],
    [
        `MnPWM1` Fault

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The generated pwm0B' signal is passed to the `MnPWM1` pin.],
            [1],
            [
                The `MnPWM1` output signal is driven to the value specified by
                the `PWM1` bit in the #link(<pwmfaultval>)[*PWMFAULTVAL*]
                register.
            ],
        )
    ],

    [0],
    [FAULT0],
    [RW],
    [0],
    [
        `MnPWM0` Fault

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The generated pwm0A' signal is passed to the `MnPWM0` pin.],
            [1],
            [
                The `MnPWM0` output signal is driven to the value specified by
                the `PWM0` bit in the #link(<pwmfaultval>)[*PWMFAULTVAL*]
                register.
            ],
        )
    ],
))

#pagebreak()

=== PWM Fault Condition Value (PWMFAULTVAL)
<pwmfaultval>
This register sets the output value (high or low) of fault conditions. It
specifies the output value driven on the `MnPWMn` signals during a fault
condition if enabled by the corresponding bit in the #link(
    <pwmfault>,
)[*PWMFAULT*] register.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x024`
- Type RW, reset `0x0000.0000`

#cimage("./images/pwmfault-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7],
    [PWM7],
    [RW],
    [0],
    [
        `MnPWM7` Fault Value

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `MnPWM7` output signal is driven Low during fault conditions
                if the `FAULT7` bit in the #link(<pwmfault>)[*PWMFAULT*]
                register is set.
            ],

            [1],
            [
                The `MnPWM7` output signal is driven High during fault
                conditions if the `FAULT7` bit in the #link(
                    <pwmfault>,
                )[*PWMFAULT*] register is set.
            ],
        )
    ],

    [6],
    [PWM6],
    [RW],
    [0],
    [
        `MnPWM6` Fault Value

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `MnPWM6` output signal is driven Low during fault conditions
                if the `FAULT6` bit in the #link(<pwmfault>)[*PWMFAULT*]
                register is set.
            ],

            [1],
            [
                The `MnPWM6` output signal is driven High during fault
                conditions if the `FAULT6` bit in the #link(
                    <pwmfault>,
                )[*PWMFAULT*] register is set.
            ],
        )

        #v(10em)
    ],

    [5],
    [PWM5],
    [RW],
    [0],
    [
        `MnPWM5` Fault Value

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `MnPWM5` output signal is driven Low during fault conditions
                if the `FAULT5` bit in the #link(<pwmfault>)[*PWMFAULT*]
                register is set.
            ],

            [1],
            [
                The `MnPWM5` output signal is driven High during fault
                conditions if the `FAULT5` bit in the #link(
                    <pwmfault>,
                )[*PWMFAULT*] register is set.
            ],
        )
    ],

    [4],
    [PWM4],
    [RW],
    [0],
    [
        `MnPWM4` Fault Value

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `MnPWM4` output signal is driven Low during fault conditions
                if the `FAULT4` bit in the #link(<pwmfault>)[*PWMFAULT*]
                register is set.
            ],

            [1],
            [
                The `MnPWM4` output signal is driven High during fault
                conditions if the `FAULT4` bit in the #link(
                    <pwmfault>,
                )[*PWMFAULT*] register is set.
            ],
        )
    ],

    [3],
    [PWM3],
    [RW],
    [0],
    [
        `MnPWM3` Fault Value

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `MnPWM3` output signal is driven Low during fault conditions
                if the `FAULT3` bit in the #link(<pwmfault>)[*PWMFAULT*]
                register is set.
            ],

            [1],
            [
                The `MnPWM3` output signal is driven High during fault
                conditions if the `FAULT3` bit in the #link(
                    <pwmfault>,
                )[*PWMFAULT*] register is set.
            ],
        )
    ],

    [2],
    [PWM2],
    [RW],
    [0],
    [
        `MnPWM2` Fault Value

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `MnPWM2` output signal is driven Low during fault conditions
                if the `FAULT2` bit in the #link(<pwmfault>)[*PWMFAULT*]
                register is set.
            ],

            [1],
            [
                The `MnPWM2` output signal is driven High during fault
                conditions if the `FAULT2` bit in the #link(
                    <pwmfault>,
                )[*PWMFAULT*] register is set.
            ],
        )

        #v(10em)
    ],

    [1],
    [PWM1],
    [RW],
    [0],
    [
        `MnPWM1` Fault Value

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `MnPWM1` output signal is driven Low during fault conditions
                if the `FAULT1` bit in the #link(<pwmfault>)[*PWMFAULT*]
                register is set.
            ],

            [1],
            [
                The `MnPWM1` output signal is driven High during fault
                conditions if the `FAULT1` bit in the #link(
                    <pwmfault>,
                )[*PWMFAULT*] register is set.
            ],
        )
    ],

    [0],
    [PWM0],
    [RW],
    [0],
    [
        `MnPWM0` Fault Value

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The `MnPWM0` output signal is driven Low during fault conditions
                if the `FAULT0` bit in the #link(<pwmfault>)[*PWMFAULT*]
                register is set.
            ],

            [1],
            [
                The `MnPWM0` output signal is driven High during fault
                conditions if the `FAULT0` bit in the #link(
                    <pwmfault>,
                )[*PWMFAULT*] register is set.
            ],
        )
    ],
))

#pagebreak()

=== PWM Interrupt Enable (PWMINTEN)
<pwminten>
This register controls the global interrupt generation capabilities of the PWM
module.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x014`
- Type RW, reset `0x0000.0000`

#cimage("./images/pwminten-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:18],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [17],
    [INTFAULT1],
    [RW],
    [0],
    [
        Interrupt Fault 1

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The fault condition for PWM generator 1 is suppressed and not sent
                to the interrupt controller.],

            [1],
            [An interrupt is sent to the interrupt controller when the fault
                condition for PWM generator 1 is asserted.],
        )
    ],

    [16],
    [INTFAULT0],
    [RW],
    [0],
    [
        Interrupt Fault 0

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The fault condition for PWM generator 0 is suppressed and not sent
                to the interrupt controller.],

            [1],
            [An interrupt is sent to the interrupt controller when the fault
                condition for PWM generator 0 is asserted.],
        )
    ],

    [15:4],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [3],
    [INTPWM3],
    [RW],
    [0],
    [
        PWM3 Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The PWM generator 3 interrupt is suppressed and not sent to the
                interrupt controller.],

            [1],
            [An interrupt is sent to the interrupt controller when the PWM
                generator 3 block asserts an interrupt.],
        )
    ],

    [2],
    [INTPWM2],
    [RW],
    [0],
    [
        PWM2 Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The PWM generator 2 interrupt is suppressed and not sent to the
                interrupt controller.],

            [1],
            [An interrupt is sent to the interrupt controller when the PWM
                generator 2 block asserts an interrupt.],
        )
    ],

    [1],
    [INTPWM1],
    [RW],
    [0],
    [
        PWM1 Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The PWM generator 1 interrupt is suppressed and not sent to the
                interrupt controller.],

            [1],
            [An interrupt is sent to the interrupt controller when the PWM
                generator 1 block asserts an interrupt.],
        )
    ],

    [0],
    [INTPWM0],
    [RW],
    [0],
    [
        PWM0 Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The PWM generator 0 interrupt is suppressed and not sent to the
                interrupt controller.],

            [1],
            [An interrupt is sent to the interrupt controller when the PWM
                generator 0 block asserts an interrupt.],
        )
    ],
))

#pagebreak()

=== PWMn Interrupt and Trigger Enable (PWMnINTEN)
<pwmninten>
This register enables the PWM counter's interrupts and triggers.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x044`
- Type RW, reset `0x0000.0000`

Registers:
- Register 16: PWM0 Interrupt and Trigger Enable (PWM0INTEN), offset `0x044`
- Register 17: PWM1 Interrupt and Trigger Enable (PWM1INTEN), offset `0x084`
- Register 18: PWM2 Interrupt and Trigger Enable (PWM2INTEN), offset `0x0C4`
- Register 19: PWM3 Interrupt and Trigger Enable (PWM3INTEN), offset `0x104`

#cimage("./images/pwmninten-register.png")

#cimage("./images/pwm-comparators-graph.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:14],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [13],
    [TRCMPBD],
    [RW],
    [0],
    [
        Trigger for Counter=#link(<pwmncmpb>)[*PWMnCMPB*] Down

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No ADC trigger is output.],
            [1],
            [An ADC trigger pulse is output when the counter matches the value
                in the #link(<pwmncmpb>)[*PWMnCMPB*] register value while
                counting down.],
        )

        #v(10em)
    ],

    [12],
    [TRCMPBU],
    [RW],
    [0],
    [
        Trigger for Counter=#link(<pwmncmpb>)[*PWMnCMPB*] Up

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No ADC trigger is output.],
            [1],
            [An ADC trigger pulse is output when the counter matches the value
                in the #link(<pwmncmpb>)[*PWMnCMPB*] register value while
                counting up.],
        )
    ],

    [11],
    [TRCMPAD],
    [RW],
    [0],
    [
        Trigger for Counter=#link(<pwmncmpa>)[*PWMnCMPA*] Down

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No ADC trigger is output.],
            [1],
            [An ADC trigger pulse is output when the counter matches the value
                in the #link(<pwmncmpa>)[*PWMnCMPA*] register value while
                counting down.],
        )
    ],

    [10],
    [TRCMPAU],
    [RW],
    [0],
    [
        Trigger for Counter=#link(<pwmncmpa>)[*PWMnCMPA*] Up

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No ADC trigger is output.],
            [1],
            [An ADC trigger pulse is output when the counter matches the value
                in the #link(<pwmncmpa>)[*PWMnCMPA*] register value while
                counting up.],
        )
    ],

    [9],
    [TRCNTLOAD],
    [RW],
    [0],
    [
        Trigger for Counter=#link(<pwmnload>)[*PWMnLOAD*]

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No ADC trigger is output.],
            [1],
            [An ADC trigger pulse is output when the counter matches the #link(
                    <pwmnload>,
                )[*PWMnLOAD*] register.],
        )
    ],

    [8],
    [TRCNTZERO],
    [RW],
    [0],
    [
        Trigger for Counter=`0`

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No ADC trigger is output.],
            [1], [An ADC trigger pulse is output when the counter is `0`.],
        )
    ],

    [7:6],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [5],
    [INTCMPBD],
    [RW],
    [0],
    [
        Interrupt for Counter=#link(<pwmncmpb>)[*PWMnCMPB*] Down

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt.],
            [1],
            [A raw interrupt occurs when the counter matches the value in the
                #link(<pwmncmpb>)[*PWMnCMPB*] register value while counting
                down.],
        )
    ],

    [4],
    [INTCMPBU],
    [RW],
    [0],
    [
        Interrupt for Counter=#link(<pwmncmpb>)[*PWMnCMPB*] Up

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt.],
            [1],
            [A raw interrupt occurs when the counter matches the value in the
                #link(<pwmncmpb>)[*PWMnCMPB*] register value while counting
                up.],
        )
    ],

    [3],
    [INTCMPAD],
    [RW],
    [0],
    [
        Interrupt for Counter=#link(<pwmncmpa>)[*PWMnCMPA*] Down

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt.],
            [1],
            [A raw interrupt occurs when the counter matches the value in the
                #link(<pwmncmpa>)[*PWMnCMPA*] register value while counting
                down.],
        )
    ],

    [2],
    [INTCMPAU],
    [RW],
    [0],
    [
        Interrupt for Counter=#link(<pwmncmpa>)[*PWMnCMPA*] Up

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt.],
            [1],
            [A raw interrupt occurs when the counter matches the value in the
                #link(<pwmncmpa>)[*PWMnCMPA*] register value while counting
                up.],
        )
    ],

    [1],
    [INTCNTLOAD],
    [RW],
    [0],
    [
        Interrupt for Counter=#link(<pwmnload>)[*PWMnLOAD*]

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt.],
            [1],
            [A raw interrupt occurs when the counter matches the value in the
                #link(<pwmnload>)[*PWMnLOAD*] register value.],
        )

        #v(10em)
    ],

    [0],
    [INTCNTZERO],
    [RW],
    [0],
    [
        Interrupt for Counter=`0`

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt.],
            [1], [A raw interrupt occurs when the counter is zero.],
        )
    ],
))

#pagebreak()

=== PWM Peripheral Properties (PWMPP)
<pwmpp>
This register provides information regarding the properties of the PWM module.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0xFC0`
- Type RO, reset `0x0000.0314`

#cimage("./images/pwmpp-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:11],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [10],
    [ONE],
    [RO],
    [`0x0`],
    [
        One-Shot Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [One-shot modes are not available.],
            [1], [One-shot modes are available.],
        )
    ],

    [9],
    [EFAULT],
    [RO],
    [`0x1`],
    [
        Extended Fault

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Extended fault capabilities are not available.],
            [1], [Extended fault capabilities are available.],
        )
    ],

    [8],
    [ESYNC],
    [RO],
    [`0x1`],
    [
        Extended Synchronization

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Extended synchronization is not available.],
            [1], [Extended synchronization is available.],
        )
    ],

    [7:4],
    [FCNT],
    [RO],
    [`0x1`],
    [
        Fault Inputs

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [No fault inputs.],
            [`0x1`], [1 fault input.],
            [`0x2`], [2 fault inputs.],
            [`0x3`], [3 fault inputs.],
            [`0x4`], [4 fault inputs.],
            [`0x5 - 0xF`], [Reserved],
        )

        #v(10em)
    ],

    [3:0],
    [GCNT],
    [RO],
    [`0x4`],
    [
        Generators

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [No generators.],
            [`0x1`], [1 generator],
            [`0x2`], [2 generators],
            [`0x3`], [3 generators],
            [`0x4`], [4 generators],
            [`0x5 - 0xF`], [Reserved],
        )

        The number of PWM outputs is 2 times the number of PWM generators.
    ],
))

#pagebreak()

=== PWMn Fault Status 0 (PWMnFLTSTAT0)
<pwmnfltstat0>
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x804`
- Type -, reset `0x0000.0000`

Registers:
- Register 78: PWM0 Fault Status 0 (PWM0FLTSTAT0), offset `0x804`
- Register 79: PWM1 Fault Status 0 (PWM1FLTSTAT0), offset `0x884`
- Register 80: PWM2 Fault Status 0 (PWM2FLTSTAT0), offset `0x904`
- Register 81: PWM3 Fault Status 0 (PWM3FLTSTAT0), offset `0x984`

Along with the #link(<pwmnfltstat1>)[*PWMnFLTSTAT1*] register, this register
provides status regarding the fault condition inputs.

If in unlatched mode, `FAULT1` and `FAULT0` indicate the status of fault
conditions (read-only). If in latched mode, `FAULT1` and `FAULT0` indicate the
status of fault conditions and can be cleared.

#cimage("./images/pwmnfltstat0-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:2],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1],
    [FAULT1],
    [-],
    [0],
    [
        Fault Input 1

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit is RO and represents the current state of the `MnFAULT1` input
        signal after the logic sense adjustment.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        is RW1C and represents a sticky version of the `MnFAULT1` input signal
        after the logic sense adjustment.

        - If `FAULT1` is set, the input transitioned to the active state
            previously.
        - If `FAULT1` is clear, the input has not transitioned to the active
            state since the last time it was cleared.
        - The `FAULT1` bit is cleared by writing it with the value `1`.

        #v(20em)
    ],

    [0],
    [FAULT0],
    [-],
    [0],
    [
        Fault Input 0

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit is RO and represents the current state of the input signal after the
        logic sense adjustment.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        is RW1C and represents a sticky version of the input signal after the
        logic sense adjustment.

        - If `FAULT0` is set, the input transitioned to the active state
            previously.
        - If `FAULT0` is clear, the input has not transitioned to the active
            state since the last time it was cleared.
        - The `FAULT0` bit is cleared by writing it with the value `1`.
    ],
))

#pagebreak()

=== PWMn Fault Status 1 (PWMnFLTSTAT1)
<pwmnfltstat1>
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x808`
- Type -, reset `0x0000.0000`

Registers:
- Register 82: PWM0 Fault Status 1 (PWM0FLTSTAT1), offset `0x808`
- Register 83: PWM1 Fault Status 1 (PWM1FLTSTAT1), offset `0x888`
- Register 84: PWM2 Fault Status 1 (PWM2FLTSTAT1), offset `0x908`
- Register 85: PWM3 Fault Status 1 (PWM3FLTSTAT1), offset `0x988`

Along with the #link(<pwmnfltstat0>)[*PWMnFLTSTAT0*] register, this register
provides status regarding the fault condition inputs.

If in unlatched mode, bits 0 to 7 indicate the status of fault conditions
(read-only). If in latched mode, bits 0 to 7 indicate the status of fault
conditions and can be cleared.

#cimage("./images/pwmnfltstat1-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:8],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7],
    [DCMP7],
    [-],
    [0],
    [
        Digital Comparator 7 Trigger

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit represents the current state of the Digital Comparator 7 trigger
        input.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        represents a sticky version of the trigger.

        - If `DCMP7` is set, the trigger transitioned to the active state
            previously.
        - If `DCMP7` is clear, the trigger has not transitioned to the active
            state since the last time it was cleared.
        - The `DCMP7` bit is cleared by writing it with the value `1`.

        #v(20em)
    ],

    [6],
    [DCMP6],
    [-],
    [0],
    [
        Digital Comparator 6 Trigger

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit represents the current state of the Digital Comparator 6 trigger
        input.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        represents a sticky version of the trigger.

        - If `DCMP6` is set, the trigger transitioned to the active state
            previously.
        - If `DCMP6` is clear, the trigger has not transitioned to the active
            state since the last time it was cleared.
        - The `DCMP6` bit is cleared by writing it with the value `1`.
    ],

    [5],
    [DCMP5],
    [-],
    [0],
    [
        Digital Comparator 5 Trigger

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit represents the current state of the Digital Comparator 5 trigger
        input.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        represents a sticky version of the trigger.

        - If `DCMP5` is set, the trigger transitioned to the active state
            previously.
        - If `DCMP5` is clear, the trigger has not transitioned to the active
            state since the last time it was cleared.
        - The `DCMP5` bit is cleared by writing it with the value `1`.
    ],

    [4],
    [DCMP4],
    [-],
    [0],
    [
        Digital Comparator 4 Trigger

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit represents the current state of the Digital Comparator 4 trigger
        input.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        represents a sticky version of the trigger.

        - If `DCMP4` is set, the trigger transitioned to the active state
            previously.
        - If `DCMP4` is clear, the trigger has not transitioned to the active
            state since the last time it was cleared.
        - The `DCMP4` bit is cleared by writing it with the value `1`.

        #v(10em)
    ],

    [3],
    [DCMP3],
    [-],
    [0],
    [
        Digital Comparator 3 Trigger

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit represents the current state of the Digital Comparator 3 trigger
        input.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        represents a sticky version of the trigger.

        - If `DCMP3` is set, the trigger transitioned to the active state
            previously.
        - If `DCMP3` is clear, the trigger has not transitioned to the active
            state since the last time it was cleared.
        - The `DCMP3` bit is cleared by writing it with the value `1`.
    ],

    [2],
    [DCMP2],
    [-],
    [0],
    [
        Digital Comparator 2 Trigger

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit represents the current state of the Digital Comparator 2 trigger
        input.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        represents a sticky version of the trigger.

        - If `DCMP2` is set, the trigger transitioned to the active state
            previously.
        - If `DCMP2` is clear, the trigger has not transitioned to the active
            state since the last time it was cleared.
        - The `DCMP2` bit is cleared by writing it with the value `1`.
    ],

    [1],
    [DCMP1],
    [-],
    [0],
    [
        Digital Comparator 1 Trigger

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit represents the current state of the Digital Comparator 1 trigger
        input.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        represents a sticky version of the trigger.

        - If `DCMP1` is set, the trigger transitioned to the active state
            previously.
        - If `DCMP1` is clear, the trigger has not transitioned to the active
            state since the last time it was cleared.
        - The `DCMP1` bit is cleared by writing it with the value `1`.

        #v(10em)
    ],

    [0],
    [DCMP0],
    [-],
    [0],
    [
        Digital Comparator 0 Trigger

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is clear, this
        bit represents the current state of the Digital Comparator 0 trigger
        input.

        If the #link(<pwmnctl>)[*PWMnCTL*] register `LATCH` bit is set, this bit
        represents a sticky version of the trigger.

        - If `DCMP0` is set, the trigger transitioned to the active state
            previously.
        - If `DCMP0` is clear, the trigger has not transitioned to the active
            state since the last time it was cleared.
        - The `DCMP0` bit is cleared by writing it with the value `1`.
    ],
))

=== PWMn Counter (PWMnCOUNT)
<pwmncount>
These registers contain the current value of the PWM counter (#link(
    <pwmncount>,
)[*PWM0COUNT*] is the value of the PWM generator 0 block, and so on).

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x054`
- Type RO, reset `0x0000.0000`

Registers:
- Register 32: PWM0 Counter (PWM0COUNT), offset `0x054`
- Register 33: PWM1 Counter (PWM1COUNT), offset `0x094`
- Register 34: PWM2 Counter (PWM2COUNT), offset `0x0D4`
- Register 35: PWM3 Counter (PWM3COUNT), offset `0x114`

#cimage("./images/pwmncount-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [COUNT],
    [RO],
    [`0x0000`],
    [
        Counter Value

        The current value of the counter.
    ],
))

#pagebreak()

=== PWM Raw Interrupt Status (PWMRIS)
<pwmris>
This register provides the current set of interrupt sources that are asserted,
regardless of whether they are enabled to cause an interrupt to be asserted to
the interrupt controller.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x018`
- Type RO, reset `0x0000.0000`

#cimage("./images/pwmris-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:18],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [17],
    [INTFAULT1],
    [RO],
    [0],
    [
        Interrupt Fault PWM 1

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The fault condition for PWM generator 1 has not been asserted.],

            [1], [The fault condition for PWM generator 1 is asserted.],
        )

        *Note*: If the `LATCH` bit is set in the #link(<pwmnctl>)[*PWM1CTL*]
        register, the `INTFAULT1` bit in this register can be cleared by writing
        a `1` to the `INTFAULT1` bit in the #link(<pwmisc>)[*PWMISC*] register.
        If the `LATCH` bit is `0` in the #link(<pwmnctl>)[*PWM1CTL*] register,
        writing a `1` to the `INTFAULT1` bit in the #link(<pwmisc>)[*PWMISC*]
        register has no effect.

        #v(20em)
    ],

    [16],
    [INTFAULT0],
    [RO],
    [0],
    [
        Interrupt Fault PWM 0

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The fault condition for PWM generator 0 has not been asserted.],

            [1], [The fault condition for PWM generator 0 is asserted.],
        )

        *Note*: If the `LATCH` bit is set in the #link(<pwmnctl>)[*PWM0CTL*]
        register, the `INTFAULT0` bit in this register can be cleared by writing
        a `1` to the `INTFAULT0` bit in the #link(<pwmisc>)[*PWMISC*] register.
        If the `LATCH` bit is `0` in the #link(<pwmnctl>)[*PWM0CTL*] register,
        writing a `1` to the `INTFAULT0` bit in the #link(<pwmisc>)[*PWMISC*]
        register has no effect.
    ],

    [15:4],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [3],
    [INTPWM3],
    [RO],
    [0],
    [
        PWM3 Interrupt Asserted

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The PWM generator 3 block interrupt has not been asserted.],
            [1], [The PWM generator 3 block interrupt is asserted.],
        )

        The #link(<pwmnris>)[*PWM3RIS*] register shows the source of this
        interrupt. This bit is cleared by writing a `1` to the corresponding bit
        in the #link(<pwmnisc>)[*PWM3ISC*] register.
    ],

    [2],
    [INTPWM2],
    [RO],
    [0],
    [
        PWM2 Interrupt Asserted

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The PWM generator 2 block interrupt has not been asserted.],
            [1], [The PWM generator 2 block interrupt is asserted.],
        )

        The #link(<pwmnris>)[*PWM2RIS*] register shows the source of this
        interrupt. This bit is cleared by writing a `1` to the corresponding bit
        in the #link(<pwmnisc>)[*PWM2ISC*] register.

        #v(10em)
    ],

    [1],
    [INTPWM1],
    [RO],
    [0],
    [
        PWM1 Interrupt Asserted

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The PWM generator 1 block interrupt has not been asserted.],
            [1], [The PWM generator 1 block interrupt is asserted.],
        )

        The #link(<pwmnris>)[*PWM1RIS*] register shows the source of this
        interrupt. This bit is cleared by writing a `1` to the corresponding bit
        in the #link(<pwmnisc>)[*PWM1ISC*] register.
    ],

    [0],
    [INTPWM0],
    [RO],
    [0],
    [
        PWM0 Interrupt Asserted

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The PWM generator 0 block interrupt has not been asserted.],
            [1], [The PWM generator 0 block interrupt is asserted.],
        )

        The #link(<pwmnris>)[*PWM0RIS*] register shows the source of this
        interrupt. This bit is cleared by writing a `1` to the corresponding bit
        in the #link(<pwmnisc>)[*PWM0ISC*] register.
    ],
))

#pagebreak()

=== PWM Interrupt Status and Clear (PWMISC)
<pwmisc>
This register provides a summary of the interrupt status of the individual PWM
generator blocks. If a fault interrupt is set, the corresponding `MnFAULTn`
input has caused an interrupt.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x01C`
- Type RW1C, reset `0x0000.0000`

#cimage("./images/pwmisc-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:18],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [17],
    [INTFAULT1],
    [RW1C],
    [0],
    [
        FAULT1 Interrupt Asserted

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The fault condition for PWM generator 1 has not been asserted or is
                not enabled.],

            [1],
            [An enabled interrupt for the fault condition for PWM generator 1 is
                asserted or is latched.],
        )

        Writing a `1` to this bit clears it and the `INTFAULT1` bit in the
        #link(<pwmris>)[*PWMRIS*] register.
    ],

    [16],
    [INTFAULT0],
    [RW1C],
    [0],
    [
        FAULT0 Interrupt Asserted

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The fault condition for PWM generator 0 has not been asserted or is
                not enabled.],

            [1],
            [An enabled interrupt for the fault condition for PWM generator 0 is
                asserted or is latched.],
        )

        Writing a `1` to this bit clears it and the `INTFAULT0` bit in the
        #link(<pwmris>)[*PWMRIS*] register.
    ],

    [15:4],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [3],
    [INTPWM3],
    [RO],
    [0],
    [
        PWM3 Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The PWM generator 3 block interrupt is not asserted or is not
                enabled.],

            [1],
            [An enabled interrupt for the PWM generator 3 block is asserted.],
        )

        The #link(<pwmnris>)[*PWM3RIS*] register shows the source of this
        interrupt. This bit is cleared by writing a `1` to the corresponding bit
        in the #link(<pwmnisc>)[*PWM3ISC*] register.
    ],

    [2],
    [INTPWM2],
    [RO],
    [0],
    [
        PWM2 Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The PWM generator 2 block interrupt is not asserted or is not
                enabled.],

            [1],
            [An enabled interrupt for the PWM generator 2 block is asserted.],
        )

        The #link(<pwmnris>)[*PWM2RIS*] register shows the source of this
        interrupt. This bit is cleared by writing a `1` to the corresponding bit
        in the #link(<pwmnisc>)[*PWM2ISC*] register.
    ],

    [1],
    [INTPWM1],
    [RO],
    [0],
    [
        PWM1 Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The PWM generator 1 block interrupt is not asserted or is not
                enabled.],

            [1],
            [An enabled interrupt for the PWM generator 1 block is asserted.],
        )

        The #link(<pwmnris>)[*PWM1RIS*] register shows the source of this
        interrupt. This bit is cleared by writing a `1` to the corresponding bit
        in the #link(<pwmnisc>)[*PWM1ISC*] register.

        #v(20em)
    ],

    [0],
    [INTPWM0],
    [RO],
    [0],
    [
        PWM0 Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The PWM generator 0 block interrupt is not asserted or is not
                enabled.],

            [1],
            [An enabled interrupt for the PWM generator 0 block is asserted.],
        )

        The #link(<pwmnris>)[*PWM0RIS*] register shows the source of this
        interrupt. This bit is cleared by writing a `1` to the corresponding bit
        in the #link(<pwmnisc>)[*PWM0ISC*] register.
    ],
))

#pagebreak()

=== PWMn Raw Interrupt Status (PWMnRIS)
<pwmnris>
These registers provide the current set of interrupt sources that are asserted,
regardless of whether they cause an interrupt to be asserted to the controller
(#link(<pwmnris>)[*PWM0RIS*] controls the PWM generator 0 block, and so on).

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x048`
- Type RO, reset `0x0000.0000`

Registers:
- Register 20: PWM0 Raw Interrupt Status (PWM0RIS), offset `0x048`
- Register 21: PWM1 Raw Interrupt Status (PWM1RIS), offset `0x088`
- Register 22: PWM2 Raw Interrupt Status (PWM2RIS), offset `0x0C8`
- Register 23: PWM3 Raw Interrupt Status (PWM3RIS), offset `0x108`

#cimage("./images/pwmnris-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:6],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [5],
    [INTCMPBD],
    [RO],
    [0],
    [
        Comparator B Down Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],
            [1],
            [The counter has matched the value in the #link(
                    <pwmncmpb>,
                )[*PWMnCMPB*] register while counting down.],
        )

        This bit is cleared by writing a `1` to the `INTCMPBD` bit in the #link(
            <pwmnisc>,
        )[*PWMnISC*] register.
    ],

    [4],
    [INTCMPBU],
    [RO],
    [0],
    [
        Comparator B Up Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],
            [1],
            [The counter has matched the value in the #link(
                    <pwmncmpb>,
                )[*PWMnCMPB*] register while counting up.],
        )

        This bit is cleared by writing a `1` to the `INTCMPBU` bit in the #link(
            <pwmnisc>,
        )[*PWMnISC*] register.

        #v(10em)
    ],

    [3],
    [INTCMPAD],
    [RO],
    [0],
    [
        Comparator A Down Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],
            [1],
            [The counter has matched the value in the #link(
                    <pwmncmpa>,
                )[*PWMnCMPA*] register while counting down.],
        )

        This bit is cleared by writing a `1` to the `INTCMPAD` bit in the #link(
            <pwmnisc>,
        )[*PWMnISC*] register.
    ],

    [2],
    [INTCMPAU],
    [RO],
    [0],
    [
        Comparator A Up Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],
            [1],
            [The counter has matched the value in the #link(
                    <pwmncmpa>,
                )[*PWMnCMPA*] register while counting up.],
        )

        This bit is cleared by writing a `1` to the `INTCMPAU` bit in the #link(
            <pwmnisc>,
        )[*PWMnISC*] register.
    ],

    [1],
    [INTCNTLOAD],
    [RO],
    [0],
    [
        Counter=Load Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],
            [1],
            [The counter has matched the value in the #link(
                    <pwmnload>,
                )[*PWMnLOAD*] register.],
        )

        This bit is cleared by writing a `1` to the `INTCNTLOAD` bit in the
        #link(<pwmnisc>)[*PWMnISC*] register.
    ],

    [0],
    [INTCNTZERO],
    [RO],
    [0],
    [
        Counter=0 Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An interrupt has not occurred.],
            [1], [The counter has matched zero.],
        )

        This bit is cleared by writing a `1` to the `INTCNTZERO` bit in the
        #link(<pwmnisc>)[*PWMnISC*] register.
    ],
))

#pagebreak()

=== PWMn Interrupt Status and Clear (PWMnISC)
<pwmnisc>
These registers provide the current set of interrupt sources that are asserted
to the interrupt controller (#link(<pwmnisc>)[*PWM0ISC*] controls the PWM
generator 0 block, and so on).

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x04C`
- Type RW1C, reset `0x0000.0000`

#cimage("./images/pwmnisc-register.png")

Registers:
- Register 24: PWM0 Interrupt Status and Clear (PWM0ISC), offset `0x04C`
- Register 25: PWM1 Interrupt Status and Clear (PWM1ISC), offset `0x08C`
- Register 26: PWM2 Interrupt Status and Clear (PWM2ISC), offset `0x0CC`
- Register 27: PWM3 Interrupt Status and Clear (PWM3ISC), offset `0x10C`

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:6],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [5],
    [INTCMPBD],
    [RW1C],
    [0],
    [
        Comparator B Down Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],
            [1],
            [The `INTCMPBD` bits in the #link(<pwmnris>)[*PWMnRIS*] and #link(
                    <pwmninten>,
                )[*PWMnINTEN*] registers are set, providing an interrupt to the
                interrupt controller.],
        )

        This bit is cleared by writing a `1`. Clearing this bit also clears the
        `INTCMPBD` bit in the #link(<pwmnris>)[*PWMnRIS*] register.

        #v(20em)
    ],

    [4],
    [INTCMPBU],
    [RW1C],
    [0],
    [
        Comparator B Up Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],
            [1],
            [The `INTCMPBU` bits in the #link(<pwmnris>)[*PWMnRIS*] and #link(
                    <pwmninten>,
                )[*PWMnINTEN*] registers are set, providing an interrupt to the
                interrupt controller.],
        )

        This bit is cleared by writing a `1`. Clearing this bit also clears the
        `INTCMPBU` bit in the #link(<pwmnris>)[*PWMnRIS*] register.
    ],

    [3],
    [INTCMPAD],
    [RW1C],
    [0],
    [
        Comparator A Down Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],
            [1],
            [The `INTCMPAD` bits in the #link(<pwmnris>)[*PWMnRIS*] and #link(
                    <pwmninten>,
                )[*PWMnINTEN*] registers are set, providing an interrupt to the
                interrupt controller.],
        )

        This bit is cleared by writing a `1`. Clearing this bit also clears the
        `INTCMPAD` bit in the #link(<pwmnris>)[*PWMnRIS*] register.
    ],

    [2],
    [INTCMPAU],
    [RW1C],
    [0],
    [
        Comparator A Up Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],
            [1],
            [The `INTCMPAU` bits in the #link(<pwmnris>)[*PWMnRIS*] and #link(
                    <pwmninten>,
                )[*PWMnINTEN*] registers are set, providing an interrupt to the
                interrupt controller.],
        )

        This bit is cleared by writing a `1`. Clearing this bit also clears the
        `INTCMPAU` bit in the #link(<pwmnris>)[*PWMnRIS*] register.

        #v(10em)
    ],

    [1],
    [INTCNTLOAD],
    [RW1C],
    [0],
    [
        Counter=Load Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],
            [1],
            [The `INTCNTLOAD` bits in the #link(<pwmnris>)[*PWMnRIS*] and #link(
                    <pwmninten>,
                )[*PWMnINTEN*] registers are set, providing an interrupt to the
                interrupt controller.],
        )

        This bit is cleared by writing a `1`. Clearing this bit also clears the
        `INTCNTLOAD` bit in the #link(<pwmnris>)[*PWMnRIS*] register.
    ],

    [0],
    [INTCNTZERO],
    [RW1C],
    [0],
    [
        Counter=0 Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No interrupt has occurred or the interrupt is masked.],
            [1],
            [The `INTCNTZERO` bits in the #link(<pwmnris>)[*PWMnRIS*] and #link(
                    <pwmninten>,
                )[*PWMnINTEN*] registers are set, providing an interrupt to the
                interrupt controller.],
        )

        This bit is cleared by writing a `1`. Clearing this bit also clears the
        `INTCNTZERO` bit in the #link(<pwmnris>)[*PWMnRIS*] register.
    ],
))

#pagebreak()

=== PWM Status (PWMSTATUS)
<pwmstatus>
This register provides the unlatched status of the PWM generator fault
condition.

Documentation:
- PWM0 base: `0x4002.8000`
- PWM1 base: `0x4002.9000`
- Offset `0x020`
- Type RO, reset `0x0000.0000`

#cimage("./images/pwmstatus-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:2],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [1],
    [FAULT1],
    [RO],
    [0],
    [
        Generator 1 Fault Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The fault condition for PWM generator 1 is not asserted.],
            [1],
            [
                The fault condition for PWM generator 1 is asserted. If the
                `FLTSRC` bit in the #link(<pwmnctl>)[*PWM1CTL*] register is
                clear, the input is the source of the fault condition, and is
                therefore asserted.
            ],
        )
    ],

    [0],
    [FAULT0],
    [RO],
    [0],
    [
        Generator 0 Fault Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The fault condition for PWM generator 0 is not asserted.],
            [1],
            [
                The fault condition for PWM generator 0 is asserted. If the
                `FLTSRC` bit in the #link(<pwmnctl>)[*PWM0CTL*] register is
                clear, the input is the source of the fault condition, and is
                therefore asserted.
            ],
        )
    ],
))

#pagebreak()

== PWM module clock source
Each of the Cortex M4's two PWM module has two clock sources:
- System clock (TM4C123GH6PM's system clock is #qty[80][MHz])
- PWM clock, which is a pre-divided system clock ($#qty[80][MHz]/64$ (default))

The clock source is selected by programming the `USEPWMDIV` bit, bit 20, in the
#link(<rcc>)[*Run-Mode Clock Configuration (RCC)*] register at system control
offset `0x060`.

The `PWMDIV` bit field specifies the divisor of the system clock that is used to
create the PWM clock.

== PWM generator timer
- Count-down mode: The timer starts from a digital value (called the load value)
    and decrements continuously to zero. Then, it is reset to the load value and
    is decremented continuously to zero again.
- Count-up/down mode: The timer starts from zero and increments continuously to
    a digital value (called the load value), and then decrements continuously to
    zero, and the process repeats.
- The are 3 different types of pulses, zero pulses, direction pulses and load
    pulses.

#cimage("./images/pwm-timer-pulses.png")
#pagebreak()

== PWM generator comparators
- Each PWM generator has two digital comparators.
- One digital comparator holds the match value `COMPA`.
- Another digital comparator holds the match value `COMPB`.
- When the timer's count reaches one of these two match values, a high pulse is
    produced.

#cimage("./images/pwm-comparators-graph.png")

== PWM signal generator
- The PWM generator has 5 internal pulses: load pulses, zero pulses, direction
    pulses, `COMPA` pulses, and `COMPB` pulses.
- The signal generator takes these pulses and produces two PWM waves: pwmA and
    pwmB.

#cimage("./images/pwm-signal-generator.png")
#pagebreak()

== PWM dead-band generator
- The dead-band generator gets inputs pwmA and pwmB from the signal generator
    and produces outputs pwmA' and pwmB'.
- pwmA' is the version of pwmA with a rising edge delay.
- pwmB' is the inverted version of pwmA with a falling edge delay.

#cimage("./images/pwm-dead-band-generator.png")
#pagebreak()

== Initialisation and configuration
Initialise PWM generator 0 with a #qty[25][kHz] frequency, a 25% duty cycle on
the `MnPWM0` pin, and a 75% duty cycle on the `MnPWM1` pin. The system clock is
#qty[20][MHz].

+ Enable the PWM clock by writing a value of `0x0010.0000` to the #link(
        <rcgc0>,
    )[*RCGC0*] register in the system control module.
+ Enable the clock to the appropriate module via the #link(<rcgc2>)[*RCGC2*]
    register in the system control module.
+ In the GPIO module, enable the appropriate pins for their alternate function
    using the #link(<gpioafsel>)[*GPIOAFSEL*] register. To determine which GPIOs
    to configure, see @pwm-pins.
+ Configure the `PMCn` fields in the #link(<gpiopctl>)[*GPIOPCTL*] register to
    assign the PWM signals to the appropriate pins. See @gpio-pins and
    @gpiopctl.
+ Configure the #link(<rcc>)[*Run-Mode Clock Configuration (RCC)*] register in
    the system control module to use the PWM divide (`USEPWMDIV`) and set the
    divider (`PWMDIV`) to divide by 2 (`0x00`).
+ Configure the PWM generator for count-down mode with immediate updates to the
    parameters.
    - Write `0x0000.0000` (reset) to the #link(<pwmnctl>)[*PWM0CTL*] register.
    - Write `0x0000.008C` to the #link(<pwmngena>)[*PWM0GENA*] register.
    - Write `0x0000.080C` to the #link(<pwmngenb>)[*PWM0GENB*] register.
+ Set the period.
    - For a #qty[25][kHz] frequency, each period is $1/(25,000)$ or
        #qty[40][#sym.mu s].
    - The PWM clock source is #qty[10][MHz], which is the system clock,
        #qty[20][MHz], divided by 2. #qty[10][MHz] is 10 clock ticks, or
        #qty[1][#sym.mu s]. Hence, #qty[40][#sym.mu s] is 400 clock ticks.
    - Use this value to set the #link(<pwmnload>)[*PWM0LOAD*] register. In
        count-down mode, set the `LOAD` field in the #link(
            <pwmnload>,
        )[*PWM0LOAD*] register to the requested period minus 1.
    - Hence, write `0x0000.018F` (399) to the #link(<pwmnload>)[*PWM0LOAD*]
        register.
+ Set the pulse width of the `MnPWM0` pin for a 25% duty cycle.
    - Write `0x0000.012B` (299) to the #link(<pwmncmpa>)[*PWM0CMPA*] register.
+ Set the pulse width of the `MnPWM1` pin for a 75% duty cycle.
    - Write `0x0000.0063` (99) to the #link(<pwmncmpb>)[*PWM0CMPB*] register.
+ Start the timers in PWM generator 0.
    - Write `0x0000.0001` (enable bit 0) to the #link(<pwmnctl>)[*PWM0CTL*]
        register.
+ Enable PWM outputs.
    - Write `0x0000.0003` to the #link(<pwmenable>)[*PWMENABLE*] register.

= TM4C123GH6PM timers and counters
#cimage("./images/tm4c123gh6pm-timers-and-counters.png")

== System timer (SysTick)
The Cortex-m4 has an integrated 24-bit system timer (SysTick) running on the bus
clock frequency.

SysTick features:
- 24-bit clear-on write
- Decrementing
- Wrap-on-zero counter with flexible control mechanism

The SysTick can be used as a *timer* in several different ways:
- A *real time operating system (RTOS) tick timer* that fires at a programmable
    rate, like at #qty[100][Hz] for example, and invokes a SysTick routine.
- A *high-speed alarm timer* using the system clock.
- A *variable rate alarm or signal timer*. The duration is range-dependent on
    the reference clock used and the dynamic range of the counter.

The SysTick can be used as a *counter* in the following ways:
- *A simple counter* used to measure time to completion and time taken.
- *An internal clock source* control based on missing or meeting durations.
- The `COUNT` bit in the #link(<stctrl>)[*STCTRL*] control and status register
    can be used to determine if an action completed with a set duration.

#pagebreak()

=== Register map
Base: `0xE000.E000`

#align(center, table(
    align: left,
    columns: 5,
    table.header([*Offset*], [*Name*], [*Type*], [*Reset*], [*Description*]),
    table.cell(colspan: 5)[*System Timer (SysTick) Registers*],

    [`0x010`],
    [`STCTRL`],
    [RW],
    [`0x0000.0004`],
    [SysTick Control and Status Register],

    [`0x014`],
    [`STRELOAD`],
    [RW],
    [-],
    [SysTick Reload Value Register],

    [`0x018`],
    [`STCURRENT`],
    [RWC],
    [-],
    [SysTick Current Value Register],
))

=== Registers
The timer consists of 3 registers:
+ #link(<stctrl>)[SysTick Control and Status (STCTRL)]
    - Control the status counter to configure its clock.
    - Enable the counter.
    - Enable the SysTick interrupt.
    - Determine the counter status.
+ #link(<streload>)[SysTick Reload Value (STRELOAD)]
    - Reload the value for the counter.
    - Provide the counter's wrap value.
+ #link(<stcurrent>)[SysTick Current Value (STCURRENT)]
    - The current value of the counter.

#pagebreak()

==== SysTick Control and Status Register (STCTRL)
<stctrl>
*Note*: This register can only be accessed from privileged mode.
- Base `0xE000.E000`
- Offset `0x010`
- Type RW, reset `0x0000.0004`

#cimage("./images/stctrl-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:17],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [16],
    [COUNT],
    [RO],
    [0],
    [
        Count Flag

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [The SysTick timer has not counted to `0` since the last time this
                bit was read.],

            [1],
            [The SysTick timer has counted to `0` since the last time this bit
                was read.],
        )

        This bit is cleared by a read of the register or if the #link(
            <stcurrent>,
        )[*STCURRENT*] register is written with any value.

        If read by the debugger using the DAP, this bit is cleared only if the
        `MasterType` bit in the *AHB-AP Control Register* is clear. Otherwise,
        the `COUNT` bit is not changed by the debugger read. See the _ARM® Debug
        Interface V5 Architecture Specification_ for more information on
        `MasterType`.
    ],

    [15:3],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [2],
    [CLK_SRC],
    [RW],
    [1],
    [
        Clock Source

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Precision internal oscillator (PIOSC) divided by 4],
            [1], [System clock],
        )

        #v(10em)
    ],

    [1],
    [INTEN],
    [RW],
    [0],
    [
        Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [Interrupt generation is disabled. Software can use the `COUNT` bit
                to determine if the counter has ever reached `0`.],

            [1],
            [An interrupt is generated to the NVIC when SysTick counts to `0`.],
        )
    ],

    [0],
    [ENABLE],
    [RW],
    [0],
    [
        Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The counter is disabled.],
            [1],
            [Enables SysTick to operate in a multi-shot way. That is, the
                counter loads the `RELOAD` value and begins counting down. On
                reaching `0`, the `COUNT` bit is set and an interrupt is
                generated if enabled by `INTEN`. The counter then loads the
                `RELOAD` value again and begins counting.],
        )
    ],
))

#pagebreak()

==== SysTick Reload Value Register (STRELOAD)
<streload>
*Note*: This register can only be accessed from privileged mode.
- Base `0xE000.E000`
- Offset `0x014`
- Type RW, reset -

#cimage("./images/streload-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:24],
    [reserved],
    [RO],
    [`0x00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [23:0],
    [RELOAD],
    [RW],
    [`0x00.0000`],
    [
        Reload Value

        Value to load into the #link(<stcurrent>)[*SysTick Current Value
        (STCURRENT)*] register when the counter reaches `0`.
    ],
))

#pagebreak()

==== SysTick Current Value Register (STCURRENT)
<stcurrent>
- Base `0xE000.E000`
- Offset `0x018`
- Type RWC, reset -

#cimage("./images/stcurrent-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:24],
    [reserved],
    [RO],
    [`0x00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [23:0],
    [CURRENT],
    [RWC],
    [`0x00.0000`],
    [
        Current Value

        This field contains the current value at the time the register is
        accessed. No read-modify-write protection is provided, so change with
        care.

        This register is write-clear. Writing to it with any value clears the
        register. Clearing this register also clears the `COUNT` bit of the
        #link(<stctrl>)[*STCTRL*] register.
    ],
))

#pagebreak()

=== Initialisation sequence
+ Clear the `ENABLE` bit, which is bit 0 of the #link(<stctrl>)[*STCTRL*]
    register, to turn off the SysTick during initialisation.
+ Program the value in the #link(<streload>)[*STRELOAD*] register to a value
    that is *1 bit less* than the actual value required.

    For example, for a #qty[80][MHz] clock, the value of 800,000 is
    #qty[10][ms].
+ Clear the #link(<stcurrent>)[*STCURRENT*] register by writing to it with any
    value.
+ Configure the #link(<stctrl>)[*STCTRL*] register for the required operation.
    - Set `CLK_SRC` (bit 2) to `1` to use the system clock.
    - Clear `INTEN` (bit 1) if interrupt is not needed.
    - Set `ENABLE` (bit 0) to `1` to turn on the SysTick timer.

*Note*: When the processor is halted for debugging, the counter does not
decrement.

- When SysTick timer is enabled, the timer counts down on each clock from the
    #link(<streload>)[*STRELOAD*] value to zero.
- Reloads (wraps) to the value in the #link(<streload>)[*STRELOAD*] register on
    the next clock edge.
- Clearing the #link(<streload>)[*STRELOAD*] register disables the counter on
    the next wrap.
- When the timer reaches zero, the `COUNT` status (bit 16) in the #link(
        <stctrl>,
    )[*STCTRL*] register is set. THe `COUNT` bit clears on reads.
- On the next clock cycle, the #link(<stcurrent>)[*STCURRENT*] register is
    loaded with the #link(<streload>)[*STRELOAD*] value again.
- Writing to the #link(<stcurrent>)[*STCURRENT*] register clears the register
    and the `COUNT` status bit.
- On a read, the current value is the value of the register at the time the
    register is accessed.

==== Example code
```asm
STCTRL      EQU 0xE000E010      ; STCTRL register address
STRELOAD    EQU 0xE000E014      ; STRELOAD register address
STCURRENT   EQU 0xE000E018      ; STCURRENT register address

        AREA |.text|, CODE, READONLY, ALIGN=2
        THUMB

        LDR R1, =STCTRL
        LDR R0, [R1]
        LDR R0, =0              ; Disable SysTick during setup
        STR R0, [R1]

        LDR R1, =STRELOAD
        LDR R0, =0x00FFFFFF     ; Set the maximum reload value
        STR R0, [R1]

        LDR R1, =STCURRENT
        LDR R0, =0              ; Write any number to clear STCURRENT register
        STR R0, [R1]            ; Clear counter

        LDR R1, =STCTRL
        LDR R0, =0x05           ; Set enable bit and set CLK_SRC bit
        STR R0, [R1]
        BX LR
        END                     ; End of file
```

== General purpose timers (GPTM)
- These are different timers to SysTick.
- Input capture mode to make time measurements of input signals.
- Input capture to measure period or pulse width of digital signals.
- Use to trigger interrupts on rising or falling edges of external signals.
- Programmable timers can be used to count or time external events that drive
    the Timer input pins.
- Timers can be used to trigger analogue-to-digital conversions (ADC) when a
    time-out occurs in periodic and one-shot mode.
- The general-purpose timer module (GPTM) contains six 16/32-bit GPTM blocks and
    six 32/64-bit wide GPTM blocks.
- Count up or down.
- Twelve 16/32-bit Capture Compare PWM pins (CCP).
- Twelve 32/64-bit Capture Compare PWM pins (CCP).
- Daisy chaining of timer modules to allow a single timer to initiate multiple
    timing events.
- Timer synchronisation allows selected timers to start counting on the same
    clock cycle.
- ADC event trigger.
- User-enabled stalling when the microcontroller asserts CPU Halt flag during
    debug (excluding RTC mode).
- Ability to determine the elaspsed time between the assertion of the timer
    interrupt and entry into the interrupt service routine.
- Efficient transfers using Micro Direct Memory Access Controller (µDMA)
    - Dedicated channel for each timer.
    - Burst request generated on timer interrupt.

Each block has the following functional options:
- 16/32-bit operating modes:
    - 16 or 32-bit programmable one-shot timers.
    - 16 or 32-bit programmable periodic timer.
    - 16-bit general-purpose timer with an 8-bit prescaler.
    - 32-bit Real-Time Clock (RTC) when using an external #qty[32.768][kHz]
        clock as the input.
    - 16-bit input-edge count or time-capture modes with an 8-bit prescaler.
    - 16-bit PWM mode with an 8-bit prescaler and software-programmable output
        inversion of the PWM signal.
- 32/64-bit operating modes:
    - 32 or 64-bit programmable one-shot timer.
    - 32 or 64-bit programmable periodic timer.
    - 32-bit general-purpose timer with an 16-bit prescaler.
    - 64-bit Real-Time Clock (RTC) when using an external #qty[32.768][kHz]
        clock as the input.
    - 32-bit input-edge count or time-capture modes with a 16-bit prescaler.
    - 32-bit PWM mode with a 16-bit prescaler and software-programmable output
        inversion of the PWM signal.

#pagebreak()

=== Block diagram
#cimage("./images/gptm-block-diagram.png")
#pagebreak()

=== Input capture pins
Input capture pins are `TnCCP0` or `TnCCP1`.

#align(center, table(
    align: left,
    columns: 4,
    table.header(
        [*Timer*], [*Up/Down Counter*], [*Even CCP Pin*], [*Odd CCP Pin*]
    ),

    table.cell(rowspan: 2)[16/32-Bit Timer 0],
    [Timer A],
    [`T0CCP0`],
    [-],
    [Timer B],
    [-],
    [`T0CCP1`],

    table.cell(rowspan: 2)[16/32-Bit Timer 1],
    [Timer A],
    [`T1CCP0`],
    [-],
    [Timer B],
    [-],
    [`T1CCP1`],

    table.cell(rowspan: 2)[16/32-Bit Timer 2],
    [Timer A],
    [`T2CCP0`],
    [-],
    [Timer B],
    [-],
    [`T2CCP1`],

    table.cell(rowspan: 2)[16/32-Bit Timer 3],
    [Timer A],
    [`T3CCP0`],
    [-],
    [Timer B],
    [-],
    [`T3CCP1`],

    table.cell(rowspan: 2)[16/32-Bit Timer 4],
    [Timer A],
    [`T4CCP0`],
    [-],
    [Timer B],
    [-],
    [`T4CCP1`],

    table.cell(rowspan: 2)[16/32-Bit Timer 5],
    [Timer A],
    [`T5CCP0`],
    [-],
    [Timer B],
    [-],
    [`T5CCP1`],

    table.cell(rowspan: 2)[32/64-Bit Wide Timer 0],
    [Timer A],
    [`WT0CCP0`],
    [-],
    [Timer B],
    [-],
    [`WT0CCP1`],

    table.cell(rowspan: 2)[32/64-Bit Wide Timer 1],
    [Timer A],
    [`WT1CCP0`],
    [-],
    [Timer B],
    [-],
    [`WT1CCP1`],

    table.cell(rowspan: 2)[32/64-Bit Wide Timer 2],
    [Timer A],
    [`WT2CCP0`],
    [-],
    [Timer B],
    [-],
    [`WT2CCP1`],

    table.cell(rowspan: 2)[32/64-Bit Wide Timer 3],
    [Timer A],
    [`WT3CCP0`],
    [-],
    [Timer B],
    [-],
    [`WT3CCP1`],

    table.cell(rowspan: 2)[32/64-Bit Wide Timer 4],
    [Timer A],
    [`WT4CCP0`],
    [-],
    [Timer B],
    [-],
    [`WT4CCP1`],

    table.cell(rowspan: 2)[32/64-Bit Wide Timer 5],
    [Timer A],
    [`WT5CCP0`],
    [-],
    [Timer B],
    [-],
    [`WT5CCP1`],
))

For input capture, an external signal is connected to an input, either `TnCCP0`
or `TnCCP1`. Three different input capture applications are:
- Interrupt service routine (ISR) is executed on the active edge of an external
    signal.
- Perform two rising edge input captures and subtract the two to get the
    *period*.
- Perform a rising edge and then a falling edge capture and subtract the two
    measurements to get the *pulse width*.

#pagebreak()

=== Functional description
- Each GPTM block are two free-running up/down counters, referred to as Timer A
    and Timer B, controlled by the #link(<gptmtav>)[*GPTMTAV*].
- Two prescaler registers #link(<gptmtapr>)[*GPTMTAPR*].
- Two match registers #link(<gptmtamatchr>)[*GPTMTAMATCHR*].
- Two prescaler match registers #link(<gptmtapmr>)[*GPTMTAPMR*].
- 16-bit counters have a 16-bit counting range and can be joined together to
    provide a 32-bit counting range.
- 32-bit counters have a 32-bit counting range and can be joined together to
    provide a 64-bit counting range.

=== Timer modes
#align(center, pad(x: -5em, table(
    align: left,
    columns: 8,
    table.header(
        table.cell(rowspan: 2)[*Mode*],
        table.cell(rowspan: 2)[*Timer Use*],
        table.cell(rowspan: 2)[*Count Direction*],
        table.cell(colspan: 2)[*Counter Size*],
        table.cell(colspan: 2)[*Prescaler Size#super[a]*],
        table.cell(rowspan: 2)[*Prescaler Behavior (Count Direction)*],

        [*16/32-bit GPTM*],
        [*32/64-bit Wide GPTM*],
        [*16/32-bit GPTM*],
        [*32/64-bit Wide GPTM*],
    ),

    table.cell(rowspan: 2)[One-shot],
    [Individual],
    [Up or Down],
    [16-bit],
    [32-bit],
    [8-bit],
    [16-bit],
    [Timer Extension (Up), Prescaler (Down)],

    [Concatenated],
    [Up or Down],
    [32-bit],
    [64-bit],
    [-],
    [-],
    [N/A],

    table.cell(rowspan: 2)[Periodic],
    [Individual],
    [Up or Down],
    [16-bit],
    [32-bit],
    [8-bit],
    [16-bit],
    [Timer Extension (Up), Prescaler (Down)],

    [Concatenated],
    [Up or Down],
    [32-bit],
    [64-bit],
    [-],
    [-],
    [N/A],

    [RTC],
    [Concatenated],
    [Up],
    [32-bit],
    [64-bit],
    [-],
    [-],
    [N/A],

    [Edge Count],
    [Individual],
    [Up or Down],
    [16-bit],
    [32-bit],
    [8-bit],
    [16-bit],
    [Timer Extension (Both)],

    [Edge Time],
    [Individual],
    [Up or Down],
    [16-bit],
    [32-bit],
    [8-bit],
    [16-bit],
    [Timer Extension (Both)],

    [PWM],
    [Individual],
    [Down],
    [16-bit],
    [32-bit],
    [8-bit],
    [16-bit],
    [Timer Extension],
)))

a. The prescaler is only available when the timers are used individually.

#pagebreak()

=== Register map
Base addresses
- 16/32-bit Timer 0: `0x4003.0000`
- 16/32-bit Timer 1: `0x4003.1000`
- 16/32-bit Timer 2: `0x4003.2000`
- 16/32-bit Timer 3: `0x4003.3000`
- 16/32-bit Timer 4: `0x4003.4000`
- 16/32-bit Timer 5: `0x4003.5000`
- 32/64-bit Wide Timer 0: `0x4003.6000`
- 32/64-bit Wide Timer 1: `0x4003.7000`
- 32/64-bit Wide Timer 2: `0x4004.C000`
- 32/64-bit Wide Timer 3: `0x4004.D000`
- 32/64-bit Wide Timer 4: `0x4004.E000`
- 32/64-bit Wide Timer 5: `0x4004.F000`

#align(center, table(
    align: left,
    columns: 5,
    table.header([*Offset*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [`0x000`], [`GPTMCFG`], [RW], [`0x0000.0000`], [GPTM Configuration],

    [`0x004`], [`GPTMTAMR`], [RW], [`0x0000.0000`], [GPTM Timer A Mode],

    [`0x008`], [`GPTMTBMR`], [RW], [`0x0000.0000`], [GPTM Timer B Mode],

    [`0x00C`], [`GPTMCTL`], [RW], [`0x0000.0000`], [GPTM Control],

    [`0x010`], [`GPTMSYNC`], [RW], [`0x0000.0000`], [GPTM Synchronize],

    [`0x018`], [`GPTMIMR`], [RW], [`0x0000.0000`], [GPTM Interrupt Mask],

    [`0x01C`], [`GPTMRIS`], [RO], [`0x0000.0000`], [GPTM Raw Interrupt Status],

    [`0x020`],
    [`GPTMMIS`],
    [RO],
    [`0x0000.0000`],
    [GPTM Masked Interrupt Status],

    [`0x024`], [`GPTMICR`], [W1C], [`0x0000.0000`], [GPTM Interrupt Clear],

    [`0x028`],
    [`GPTMTAILR`],
    [RW],
    [`0xFFFF.FFFF`],
    [GPTM Timer A Interval Load],

    [`0x02C`], [`GPTMTBILR`], [RW], [-], [GPTM Timer B Interval Load],

    [`0x030`], [`GPTMTAMATCHR`], [RW], [`0xFFFF.FFFF`], [GPTM Timer A Match],

    [`0x034`], [`GPTMTBMATCHR`], [RW], [`0x0000.0000`], [GPTM Timer B Match],

    [`0x038`], [`GPTMTAPR`], [RW], [`0x0000.0000`], [GPTM Timer A Prescale],

    [`0x03C`], [`GPTMTBPR`], [RW], [`0x0000.0000`], [GPTM Timer B Prescale],

    [`0x040`],
    [`GPTMTAPMR`],
    [RW],
    [`0x0000.0000`],
    [GPTM Timer A Prescale Match],

    [`0x044`],
    [`GPTMTBPMR`],
    [RW],
    [`0x0000.0000`],
    [GPTM Timer B Prescale Match],

    [`0x048`], [`GPTMTAR`], [RO], [`0xFFFF.FFFF`], [GPTM Timer A],

    [`0x04C`], [`GPTMTBR`], [RO], [-], [GPTM Timer B],

    [`0x050`], [`GPTMTAV`], [RW], [`0xFFFF.FFFF`], [GPTM Timer A Value],

    [`0x054`], [`GPTMTBV`], [RW], [-], [GPTM Timer B Value],

    [`0x058`], [`GPTMRTCPD`], [RO], [`0x0000.7FFF`], [GPTM RTC Predivide],

    [`0x05C`],
    [`GPTMTAPS`],
    [RO],
    [`0x0000.0000`],
    [GPTM Timer A Prescale Snapshot],

    [`0x060`],
    [`GPTMTBPS`],
    [RO],
    [`0x0000.0000`],
    [GPTM Timer B Prescale Snapshot],

    [`0x064`],
    [`GPTMTAPV`],
    [RO],
    [`0x0000.0000`],
    [GPTM Timer A Prescale Value],

    [`0x068`],
    [`GPTMTBPV`],
    [RO],
    [`0x0000.0000`],
    [GPTM Timer B Prescale Value],

    [`0xFC0`], [`GPTMPP`], [RO], [`0x0000.0000`], [GPTM Peripheral Properties],
))

=== Timer 0 registers
#cimage("./images/gptm-timer-0-registers.png")

=== Essential function in registers
- External input pins (`CCP0`, `CCP1`)
- Trigger flag bit [Raw Interrupt Status] (`CAERIS`)
- Two edge control bits (positive, negative, both edges) or event mode
    (`TAEVENT`)
- Interrupt Mask (`CAEIM`)
- 16/32-bit capture register (`TAR`, `TBR`)

=== Overview of GPTM use
- An external signal is connected to input capture pin.
- Specify whether input capture event will trigger on rising or falling edge
    during initialisation.
- The timer counts down from the 16-bit integer limit. When it hits zero, it
    rolls over back to `0xFFFF` and continues counting down.
- When an input capture event happens, the current timer value is copied into
    the input capture register (`TAR`, `TBR`).
- The input capture flag is set (`CAERIS`).
- An interrupt is requested if armed (`CAEIM`).

=== Prescaler configurations
#figure(
    [
        #table(
            align: left,
            columns: 4,
            table.header(
                [*Prescale (8-bit value)*],
                [*Number of Timer Clocks (Tc#super[a])*],
                [*Max Time*],
                [*Units*],
            ),
            [`00000000`], [1], [0.8192], [ms],

            [`00000001`], [2], [1.6384], [ms],

            [`00000010`], [3], [2.4576], [ms],

            [`--------`], [-], [-], [-],

            [`11111101`], [254], [208.0768], [ms],

            [`11111110`], [255], [208.896], [ms],

            [`11111111`], [256], [209.7152], [ms],
        )

        a. Tc is the clock period.
    ],
    caption: "16-bit Timer with Prescaler Configurations",
) <16-bit-timer>

#figure(
    [
        #table(
            align: left,
            columns: 4,
            table.header(
                [*Prescale (16-bit value)*],
                [*Number of Timer Clocks (Tc#super[a])*],
                [*Max Time*],
                [*Units*],
            ),
            [`0x0000`], [1], [53.687], [s],

            [`0x0001`], [2], [107.374], [s],

            [`0x0002`], [3], [214.748], [s],

            [`--------`], [-], [-], [-],

            [`0xFFFD`], [65534], [0.879], [10#super[6] s],

            [`0xFFFE`], [65535], [1.759], [10#super[6] s],

            [`0xFFFF`], [65536], [3.518], [10#super[6] s],
        )

        a. Tc is the clock period.
    ],
    caption: [
        32-bit Timer (configured in 32/64-bit mode) with Prescaler
        Configurations
    ],
) <32-bit-timer>

#pagebreak()

=== Registers
- GPTM configuration (#link(<gptmcfg>)[*GPTMCFG*]) register.
- GPTM Timer A mode (#link(<gptmtamr>)[*GPTMTAMR*]) register.
- GPTM Timer B mode (#link(<gptmtbmr>)[*GPTMTBMR*]) register.
    - When in one of the concatenated modes, Timer A and Timer B can only
        operate in one mode.
    - When configured in individual mode, Timer A and Timer B can be
        independently configured in any combination of the individual modes.

==== GPTM Configuration (GPTMCFG)
<gptmcfg>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x000`
- Type RW, reset `0x0000.0000`

#cimage("./images/gptmcfg-register.png")
#pagebreak()

#align(center, table(
    align: left,
    columns: 5,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:3],
    [Reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [2:0],
    [GPTMCFG],
    [RW],
    [`0x0`],
    [
        GPTM Configuration

        The `GPTMCFG` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`],
            [
                For a 16/32-bit timer, this value selects the 32-bit timer
                configuration. For a 32/64-bit wide timer, this value selects
                the 64-bit configuration.
            ],

            [`0x1`],
            [
                For a 16/32-bit timer, this value selects the 32-bit real-time
                clock (RTC) counter configuration. For a 32/64-bit wide timer,
                this value selects the 64-bit real-time clock (RTC) counter
                configuration.
            ],

            [`0x2-0x3`], [Reserved],
            [`0x4`],
            [
                For a 16/32-bit timer, this value selects the 16-bit timer
                configuration. For a 32/64-bit wide timer, this value selects
                the 32-bit timer configuration. The function is controlled by
                bits `1:0` of #link(<gptmtamr>)[*GPTMTAMR*] and #link(
                    <gptmtbmr>,
                )[*GPTMTBMR*].
            ],

            [`0x5-0x7`], [Reserved],
        )
    ],
))

#pagebreak()

==== GPTM Control (GPTMCTL)
<gptmctl>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x00C`
- Type RW, reset `0x0000.0000`

*Note*: Bits in this register should only be changed when the TnEN bit for the
respective timer is cleared.

#cimage("./images/gptmctl-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:15],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [14],
    [TBPWML],
    [RW],
    [0],
    [
        GPTM Timer B PWM Output Level

        The `TBPWML` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Output is unaffected.],
            [1], [Output is inverted.],
        )

        #v(20em)
    ],

    [13],
    [TBOTE],
    [RW],
    [0],
    [
        GPTM Timer B Output Trigger Enable

        The `TBOTE` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The output Timer B ADC trigger is disabled.],
            [1],
            [
                The output Timer B ADC trigger is enabled.

                *Note*: The timer must be configured for one-shot or periodic
                time-out mode to produce an ADC trigger assertion. The GPTM does
                not generate triggers for match, compare events or compare match
                events.

                In addition, the ADC must be enabled and the timer selected as a
                trigger source with the `EXn` bit in the #link(
                    <adcemux>,
                )[*ADCEMUX*] register.
            ],
        )
    ],

    [12],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11:10],
    [TBEVENT],
    [RW],
    [`0x0`],
    [
        GPTM Timer B Event Mode

        The `TBEVENT` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Positive edge],
            [`0x1`], [Negative edge],
            [`0x2`], [Reserved],
            [`0x3`], [Both edges],
        )

        *Note*: If PWM output inversion is enabled, edge detection interrupt
        behavior is reversed. Thus, if a positive-edge interrupt trigger has
        been set and the PWM inversion generates a positive edge, no
        event-trigger interrupt asserts. Instead, the interrupt is generated on
        the negative edge of the PWM signal.

        #v(20em)
    ],

    [9],
    [TBSTALL],
    [RW],
    [0],
    [
        GPTM Timer B Stall Enable

        The `TBSTALL` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [Timer B continues counting while the processor is halted by the
                debugger.],

            [1],
            [Timer B freezes counting while the processor is halted by the
                debugger.],
        )

        If the processor is executing normally, the `TBSTALL` bit is ignored.
    ],

    [8],
    [TBEN],
    [RW],
    [0],
    [
        GPTM Timer B Enable

        The `TBEN` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Timer B is disabled.],
            [1],
            [Timer B is enabled and begins counting or the capture logic is
                enabled based on the #link(<gptmcfg>)[*GPTMCFG*] register.],
        )
    ],

    [7],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [6],
    [TAPWML],
    [RW],
    [0],
    [
        GPTM Timer A PWM Output Level

        The `TAPWML` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Output is unaffected.],
            [1], [Output is inverted.],
        )

        #v(20em)
    ],

    [5],
    [TAOTE],
    [RW],
    [0],
    [
        GPTM Timer A Output Trigger Enable

        The `TAOTE` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The output Timer A ADC trigger is disabled.],
            [1],
            [
                The output Timer A ADC trigger is enabled.

                *Note*: The timer must be configured for one-shot or periodic
                time-out mode to produce an ADC trigger assertion. The GPTM does
                not generate triggers for match, compare events or compare match
                events.

                In addition, the ADC must be enabled and the timer selected as a
                trigger source with the `EXn` bit in the #link(
                    <adcemux>,
                )[*ADCEMUX*] register.
            ],
        )
    ],

    [4],
    [RTCEN],
    [RW],
    [0],
    [
        GPTM RTC Stall Enable

        The `RTCEN` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [RTC counting continues while the processor is halted by the
                debugger.],

            [1],
            [RTC counting continues while the processor is halted by the
                debugger.],
        )

        If the `RTCEN` bit is set, it prevents the timer from stalling in all
        operating modes, even if `TnSTALL` is set.
    ],

    [3:2],
    [TAEVENT],
    [RW],
    [`0x0`],
    [
        GPTM Timer A Event Mode

        The `TAEVENT` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Positive edge],
            [`0x1`], [Negative edge],
            [`0x2`], [Reserved],
            [`0x3`], [Both edges],
        )

        *Note*: If PWM output inversion is enabled, edge detection interrupt
        behavior is reversed. Thus, if a positive-edge interrupt trigger has
        been set and the PWM inversion generates a positive edge, no
        event-trigger interrupt asserts. Instead, the interrupt is generated on
        the negative edge of the PWM signal.

        #v(10em)
    ],

    [1],
    [TASTALL],
    [RW],
    [0],
    [
        GPTM Timer A Stall Enable

        The `TASTALL` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [Timer A continues counting while the processor is halted by the
                debugger.],

            [1],
            [Timer A freezes counting while the processor is halted by the
                debugger.],
        )

        If the processor is executing normally, the `TASTALL` bit is ignored.
    ],

    [0],
    [TAEN],
    [RW],
    [0],
    [
        GPTM Timer A Enable

        The `TAEN` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Timer A is disabled.],
            [1],
            [Timer A is enabled and begins counting or the capture logic is
                enabled based on the #link(<gptmcfg>)[*GPTMCFG*] register.],
        )
    ],
))

#pagebreak()

==== GPTM Timer A Mode (GPTMTAMR)
<gptmtamr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x004`
- Type RW, reset `0x0000.0000`

#cimage("./images/gptmtamr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:12],
    [reserved],
    [RO],
    [`0x0000.00`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11],
    [TAPLO],
    [RW],
    [0],
    [
        GPTM Timer A PWM Legacy Operation

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [Legacy operation with CCP pin driven Low when the #link(
                    <gptmtailr>,
                )[*GPTMTAILR*] is reloaded after the timer reaches `0`.],

            [1],
            [CCP is driven High when the #link(<gptmtailr>)[*GPTMTAILR*] is
                reloaded after the timer reaches `0`.],
        )

        This bit is only valid in PWM mode.

        #v(20em)
    ],

    [10],
    [TAMRSU],
    [RW],
    [0],
    [
        GPTM Timer A Match Register Update

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [Update the #link(<gptmtamatchr>)[*GPTMTAMATCHR*] register and the
                #link(<gptmtapr>)[*GPTMTAPR*] register, if used, on the next
                cycle.],

            [1],
            [Update the #link(<gptmtamatchr>)[*GPTMTAMATCHR*] register and the
                #link(<gptmtapr>)[*GPTMTAPR*] register, if used, on the next
                timeout.],
        )

        If the timer is disabled (`TAEN` is clear) when this bit is set, #link(
            <gptmtamatchr>,
        )[*GPTMTAMATCHR*] and #link(<gptmtapr>)[*GPTMTAPR*] are updated when the
        timer is enabled. If the timer is stalled (`TASTALL` is set), #link(
            <gptmtamatchr>,
        )[*GPTMTAMATCHR*] and #link(<gptmtapr>)[*GPTMTAPR*] are updated
        according to the configuration of this bit.
    ],

    [9],
    [TAPWMIE],
    [RW],
    [0],
    [
        GPTM A PWM Interrupt Enable

        This bit enables interrupts in PWM mode on rising, falling, or both
        edges of the CCP output, as defined by the `TAEVENT` field in the #link(
            <gptmctl>,
        )[*GPTMCTL*] register.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Capture event interrupt is disabled.],
            [1], [Capture event interrupt is enabled.],
        )

        This bit is only valid in PWM mode.

        #v(30em)
    ],

    [8],
    [TAILD],
    [RW],
    [0],
    [
        GPTM Timer A Interval Load Write

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                Update the #link(<gptmtar>)[*GPTMTAR*] and #link(
                    <gptmtav>,
                )[*GPTMTAV*] registers with the value in the #link(
                    <gptmtailr>,
                )[*GPTMTAILR*] register on the next cycle. Also update the
                #link(<gptmtaps>)[*GPTMTAPS*] and #link(<gptmtapv>)[*GPTMTAPV*]
                registers with the value in the #link(<gptmtapr>)[*GPTMTAPR*]
                register on the next cycle.
            ],

            [1],
            [
                Update the #link(<gptmtar>)[*GPTMTAR*] and #link(
                    <gptmtav>,
                )[*GPTMTAV*] registers with the value in the #link(
                    <gptmtailr>,
                )[*GPTMTAILR*] register on the next timeout. Also update the
                #link(<gptmtaps>)[*GPTMTAPS*] and #link(<gptmtapv>)[*GPTMTAPV*]
                registers with the value in the #link(<gptmtapr>)[*GPTMTAPR*]
                register on the next timeout.
            ],
        )

        Note the state of this bit has no effect when counting up.

        The bit descriptions above apply if the timer is enabled and running. If
        the timer is disabled (`TAEN` is clear) when this bit is set, #link(
            <gptmtar>,
        )[*GPTMTAR*], #link(<gptmtav>)[*GPTMTAV*], #link(
            <gptmtaps>,
        )[*GPTMTAPS*], and #link(<gptmtapv>)[*GPTMTAPV*] are updated when the
        timer is enabled. If the timer is stalled (`TASTALL` is set), #link(
            <gptmtar>,
        )[*GPTMTAR*] and #link(<gptmtaps>)[*GPTMTAPS*] are updated according to
        the configuration of this bit.
    ],

    [7],
    [TASNAPS],
    [RW],
    [0],
    [
        GPTM Timer A Snap-Shot Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Snap-shot mode is disabled.],
            [1],
            [
                If Timer A is configured in the periodic mode, the actual
                free-running capture or snapshot value of Timer A is loaded at
                the time-out event/capture or snapshot event into the GPTM Timer
                A (#link(<gptmtar>)[*GPTMTAR*]) register. If the timer prescaler
                is used, the prescaler snapshot is loaded into the GPTM Timer A
                (#link(<gptmtapr>)[*GPTMTAPR*]) register.
            ],
        )

        #v(10em)
    ],

    [6],
    [TAWOT],
    [RW],
    [0],
    [
        GPTM Timer A Wait-on-Trigger

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Timer A begins counting as soon as it is enabled.],
            [1],
            [
                If Timer A is enabled (`TAEN` is set in the #link(
                    <gptmctl>,
                )[*GPTMCTL*] register), Timer A does not begin counting until it
                receives a trigger from the timer in the previous position in
                the daisy chain. This function is valid for one-shot, periodic,
                and PWM modes.
            ],
        )

        This bit must be clear for GP Timer Module `0`, Timer A.
    ],

    [5],
    [TAMIE],
    [RW],
    [0],
    [
        GPTM Timer A Match Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [
                The match interrupt is disabled for match events.

                *Note*: Clearing the `TAMIE` bit in the #link(
                    <gptmtamr>,
                )[*GPTMTAMR*] register prevents assertion of μDMA or ADC
                requests generated on a match event. Even if the `TATODMAEN` bit
                is set in the *GPTMDMAEV* register or the `TATOADCEN` bit is set
                in the *GPTMADCEV* register, a μDMA or ADC match trigger is not
                sent to the μDMA or ADC, respectively, when the `TAMIE` bit is
                clear.
            ],

            [1],
            [An interrupt is generated when the match value in the #link(
                    <gptmtamatchr>,
                )[*GPTMTAMATCHR*] register is reached in the one-shot and
                periodic modes.],
        )
    ],

    [4],
    [TACDIR],
    [RW],
    [0],
    [
        GPTM Timer A Count Direction

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The timer counts down.],
            [1],
            [The timer counts up. When counting up, the timer starts from a
                value of `0x0`.],
        )

        When in PWM or RTC mode, the status of this bit is ignored. PWM mode
        always counts down and RTC mode always counts up.

        #v(10em)
    ],

    [3],
    [TAAMS],
    [RW],
    [0],
    [
        GPTM Timer A Alternate Mode Select

        The `TAAMS` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Capture or compare mode is enabled.],
            [1],
            [
                PWM mode is enabled.

                *Note*: To enable PWM mode, you must also clear the `TACMR` bit
                and configure the `TAMR` field to `0x1` or `0x2`.
            ],
        )
    ],

    [2],
    [TACMR],
    [RW],
    [0],
    [
        GPTM Timer A Capture Mode

        The `TACMR` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Edge-Count mode],
            [1], [Edge-Time mode],
        )
    ],

    [1:0],
    [TAMR],
    [RW],
    [`0x0`],
    [
        GPTM Timer A Mode

        The `TAMR` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Reserved],
            [`0x1`], [One-Shot Timer mode],
            [`0x2`], [Periodic Timer mode],
            [`0x3`], [Capture mode],
        )

        The Timer mode is based on the timer configuration defined by bits 2:0
        in the #link(<gptmcfg>)[*GPTMCFG*] register.
    ],
))

#pagebreak()

==== GPTM Timer A Value (GPTMTAV)
<gptmtav>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x050`
- Type RW, reset `0xFFFF.FFFF`

#cimage("./images/gptmtav-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [TAV],
    [RW],
    [`0xFFFF.FFFF`],
    [
        GPTM Timer A Value

        A read returns the current, free-running value of Timer A in all modes.
        When written, the value written into this register is loaded into the
        #link(<gptmtar>)[*GPTMTAR*] register on the next clock cycle.

        *Note*: In 16-bit mode, only the lower 16-bits of the #link(
            <gptmtav>,
        )[*GPTMTAV*] register can be written with a new value. Writes to the
        prescaler bits have no effect.
    ],
))

#pagebreak()

==== GPTM Timer A Prescale (GPTMTAPR)
<gptmtapr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x038`
- Type RW, reset `0x0000.0000`

#cimage("./images/gptmtamr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:8],
    [TAPSRH],
    [RW],
    [`0x00`],
    [
        GPTM Timer A Prescale High Byte

        The register loads this value on a write. A read returns the current
        value of the register.

        For the 16/32-bit GPTM, this field is reserved. For the 32/64-bit Wide
        GPTM, this field contains the upper 8-bits of the 16-bit prescaler.

        Refer to @16-bit-timer for more details.
    ],

    [7:0],
    [TAPSR],
    [RW],
    [`0x00`],
    [
        GPTM Timer A Prescale

        The register loads this value on a write. A read returns the current
        value of the register.

        For the 16/32-bit GPTM, this field contains the entire 8-bit prescaler.
        For the 32/64-bit Wide GPTM, this field contains the lower 8-bits of the
        16-bit prescaler.

        Refer to @16-bit-timer for more details.
    ],
))

#pagebreak()

==== GPTM Timer A Match (GPTMTAMATCHR)
<gptmtamatchr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x030`
- Type RW, reset `0xFFFF.FFFF`

#cimage("./images/gptmtamatchr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [TAMR],
    [RW],
    [`0xFFFF.FFFF`],
    [
        GPTM Timer A Match Register

        This value is compared to the #link(<gptmtar>)[*GPTMTAR*] register to
        determine match events.
    ],
))

#pagebreak()

==== GPTM Timer A Prescale Match (GPTMTAPMR)
<gptmtapmr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x040`
- Type RW, reset `0x0000.0000`

#cimage("./images/gptmtapmr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:8],
    [TAPSRMH],
    [RW],
    [`0x00`],
    [
        GPTM Timer A Prescale Match High Byte

        This value is used alongside #link(<gptmtamatchr>)[*GPTMTAMATCHR*] to
        detect timer match events while using a prescaler.

        For the 16/32-bit GPTM, this field is reserved. For the 32/64-bit Wide
        GPTM, this field contains the upper 8-bits of the 16-bit prescale match
        value.
    ],

    [7:0],
    [TAPSMR],
    [RW],
    [`0x00`],
    [
        GPTM Timer A Prescale Match

        This value is used alongside #link(<gptmtamatchr>)[*GPTMTAMATCHR*] to
        detect timer match events while using a prescaler.

        For the 16/32-bit GPTM, this field contains the entire 8-bit prescaler
        match value. For the 32/64-bit Wide GPTM, this field contains the lower
        8-bits of the 16-bit prescaler match value.
    ],
))

#pagebreak()

==== GPTM Timer A Interval Load (GPTMTAILR)
<gptmtailr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x028`
- Type RW, reset `0xFFFF.FFFF`

#cimage("./images/gptmtailr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [TAILR],
    [RW],
    [`0xFFFF.FFFF`],
    [
        GPTM Timer A Interval Load Register

        Writing this field loads the counter for Timer A. A read returns the
        current value of #link(<gptmtailr>)[*GPTMTAILR*].
    ],
))

#pagebreak()

==== GPTM Timer A (GPTMTAR)
<gptmtar>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x048`
- Type RO, reset `0xFFFF.FFFF`

#cimage("./images/gptmtar-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [TAR],
    [RO],
    [`0xFFFF.FFFF`],
    [
        GPTM Timer A Register

        A read returns the current value of the #link(<gptmtar>)[*GPTM Timer A
        Count Register*], in all cases except for Input Edge Count and Time
        modes. In the Input Edge Count mode, this register contains the number
        of edges that have occurred. In the Input Edge Time mode, this register
        contains the time at which the last edge event took place.
    ],
))

#pagebreak()

==== GPTM Timer A Prescale Snapshot (GPTMTAPS)
<gptmtaps>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x05C`
- Type RO, reset `0x0000.0000`

#cimage("./images/gptmtaps-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [PSS],
    [RO],
    [`0x0000`],
    [
        GPTM Timer A Prescaler Snapshot

        A read returns the current value of the #link(<gptmtaps>)[*GPTM Timer A
        Prescaler*].
    ],
))

#pagebreak()

==== GPTM Timer A Prescale Value (GPTMTAPV)
<gptmtapv>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x064`
- Type RO, reset `0x0000.0000`

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [PSV],
    [RO],
    [`0x0000`],
    [
        GPTM Timer A Prescaler Value

        A read returns the current, free-running value of the Timer A prescaler.
    ],
))

#pagebreak()

==== GPTM Timer B Mode (GPTMTBMR)
<gptmtbmr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x008`
- Type RW, reset `0x0000.0000`

#cimage("./images/gptmtbmr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:12],
    [reserved],
    [RO],
    [`0x0000.0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11],
    [TBPLO],
    [RW],
    [0],
    [
        GPTM Timer B PWM Legacy Operation

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [Legacy operation with CCP pin driven Low when the #link(
                    <gptmtailr>,
                )[*GPTMTAILR*] is reloaded after the timer reaches 0.],

            [1],
            [CCP is driven High when the #link(<gptmtailr>)[*GPTMTAILR*] is
                reloaded after the timer reaches 0.],
        )

        This bit is only valid in PWM mode.

        #v(20em)
    ],

    [10],
    [TBMRSU],
    [RW],
    [0],
    [
        GPTM Timer B Match Register Update

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [Update the #link(<gptmtbmatchr>)[*GPTMTBMATCHR*] register and the
                #link(<gptmtbpr>)[*GPTMTBPR*] register, if used, on the next
                cycle.],

            [1],
            [Update the #link(<gptmtbmatchr>)[*GPTMTBMATCHR*] register and the
                #link(<gptmtbpr>)[*GPTMTBPR*] register, if used, on the next
                timeout.],
        )

        If the timer is disabled (`TBEN` is clear) when this bit is set, #link(
            <gptmtbmatchr>,
        )[*GPTMTBMATCHR*] and #link(<gptmtbpr>)[*GPTMTBPR*] are updated when the
        timer is enabled. If the timer is stalled (`TBSTALL` is set), #link(
            <gptmtbmatchr>,
        )[*GPTMTBMATCHR*] and #link(<gptmtbpr>)[*GPTMTBPR*] are updated
        according to the configuration of this bit.
    ],

    [9],
    [TBPWMIE],
    [RW],
    [0],
    [
        GPTM Timer B PWM Interrupt Enable

        This bit enables interrupts in PWM mode on rising, falling, or both
        edges of the CCP output as defined by the `TBEVENT` field in the #link(
            <gptmctl>,
        )[*GPTMCTL*] register.

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Capture event interrupt is disabled.],
            [1], [Capture event interrupt is enabled.],
        )

        This bit is only valid in PWM mode.

        #v(30em)
    ],

    [8],
    [TBILD],
    [RW],
    [0],
    [
        GPTM Timer B Interval Load Write

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [Update the #link(<gptmtbr>)[*GPTMTBR*] and #link(
                    <gptmtbv>,
                )[*GPTMTBV*] registers with the value in the #link(
                    <gptmtbilr>,
                )[*GPTMTBILR*] register on the next cycle. Also update the
                #link(
                    <gptmtbps>,
                )[*GPTMTBPS*] and #link(<gptmtbpv>)[*GPTMTBPV*] registers with
                the value in the #link(<gptmtbpr>)[*GPTMTBPR*] register on the
                next cycle.],

            [1],
            [Update the #link(<gptmtbr>)[*GPTMTBR*] and #link(
                    <gptmtbv>,
                )[*GPTMTBV*] registers with the value in the #link(
                    <gptmtbilr>,
                )[*GPTMTBILR*] register on the next timeout. Also update the
                #link(
                    <gptmtbps>,
                )[*GPTMTBPS*] and #link(<gptmtbpv>)[*GPTMTBPV*] registers with
                the value in the #link(<gptmtbpr>)[*GPTMTBPR*] register on the
                next timeout.],
        )

        Note the state of this bit has no effect when counting up.

        The bit descriptions above apply if the timer is enabled and running. If
        the timer is disabled (`TBEN` is clear) when this bit is set, #link(
            <gptmtbr>,
        )[*GPTMTBR*], #link(<gptmtbv>)[*GPTMTBV*], #link(
            <gptmtbps>,
        )[*GPTMTBPS*], and #link(<gptmtbpv>)[*GPTMTBPV*] are updated when the
        timer is enabled. If the timer is stalled (`TBSTALL` is set), #link(
            <gptmtbr>,
        )[*GPTMTBR*] and #link(<gptmtbps>)[*GPTMTBPS*] are updated according to
        the configuration of this bit.
    ],

    [7],
    [TBSNAPS],
    [RW],
    [0],
    [
        GPTM Timer B Snap-Shot Mode

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Snap-shot mode is disabled.],
            [1],
            [If Timer B is configured in the periodic mode, the actual
                free-running value of Timer B is loaded at the time-out event
                into the #link(<gptmtbr>)[*GPTM Timer B (GPTMTBR)*] register. If
                the timer prescaler is used, the prescaler snapshot is loaded
                into the #link(<gptmtbpr>)[*GPTM Timer B (GPTMTBPR)*].],
        )

        #v(10em)
    ],

    [6],
    [TBWOT],
    [RW],
    [0],
    [
        GPTM Timer B Wait-on-Trigger

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Timer B begins counting as soon as it is enabled.],
            [1],
            [
                If Timer B is enabled (`TBEN` is set in the #link(
                    <gptmctl>,
                )[*GPTMCTL*] register), Timer B does not begin counting until it
                receives a trigger from the timer in the previous position in
                the daisy chain. This function is valid for one-shot, periodic,
                and PWM modes.
            ],
        )
    ],

    [5],
    [TBMIE],
    [RW],
    [0],
    [
        GPTM Timer B Match Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The match interrupt is disabled for match events.],
            [1],
            [
                An interrupt is generated when the match value in the #link(
                    <gptmtbmatchr>,
                )[*GPTMTBMATCHR*] register is reached in the one-shot and
                periodic modes.

                *Note*: Clearing the `TBMIE` bit in the #link(
                    <gptmtbmr>,
                )[*GPTMTBMR*] register prevents assertion of µDMA or ADC
                requests generated on a match event. Even if the `TBTODMAEN` bit
                is set in the *GPTMDMAEV* register or the `TBTOADCEN` bit is set
                in the *GPTMADCEV* register, a µDMA or ADC match trigger is not
                sent to the µDMA or ADC, respectively, when the `TBMIE` bit is
                clear.
            ],
        )
    ],

    [4],
    [TBCDIR],
    [RW],
    [0],
    [
        GPTM Timer B Count Direction

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The timer counts down.],
            [1],
            [The timer counts up. When counting up, the timer starts from a
                value of `0x0`.],
        )

        When in PWM or RTC mode, the status of this bit is ignored. PWM mode
        always counts down and RTC mode always counts up.

        #v(10em)
    ],

    [3],
    [TBAMS],
    [RW],
    [0],
    [
        GPTM Timer B Alternate Mode Select

        The `TBAMS` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Capture or compare mode is enabled.],
            [1],
            [
                PWM mode is enabled.

                *Note*: To enable PWM mode, you must also clear the `TBCMR` bit
                and configure the `TBMR` field to `0x1` or `0x2`.
            ],
        )
    ],

    [2],
    [TBCMR],
    [RW],
    [0],
    [
        GPTM Timer B Capture Mode

        The `TBCMR` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Edge-Count mode],
            [1], [Edge-Time mode],
        )
    ],

    [1:0],
    [TBMR],
    [RW],
    [`0x0`],
    [
        GPTM Timer B Mode

        The `TBMR` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [`0x0`], [Reserved],
            [`0x1`], [One-Shot Timer mode],
            [`0x2`], [Periodic Timer mode],
            [`0x3`], [Capture mode],
        )

        The timer mode is based on the timer configuration defined by bits 2:0
        in the #link(<gptmcfg>)[*GPTMCFG*] register.
    ],
))

#pagebreak()

==== GPTM Timer B Value (GPTMTBV)
<gptmtbv>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x054`
- Type RW, reset -

#cimage("./images/gptmtbv-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [TBV],
    [RW],
    [`0x0000.FFFF` (for 16/32-bit) \ `0xFFFF.FFFF` (for 32/64-bit)],
    [
        GPTM Timer B Value

        A read returns the current, free-running value of Timer A in all modes.
        When written, the value written into this register is loaded into the
        #link(<gptmtar>)[*GPTMTAR*] register on the next clock cycle.

        *Note*: In 16-bit mode, only the lower 16-bits of the #link(
            <gptmtbv>,
        )[*GPTMTBV*] register can be written with a new value. Writes to the
        prescaler bits have no effect.
    ],
))

#pagebreak()

==== GPTM Timer B Prescale (GPTMTBPR)
<gptmtbpr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x03C`
- Type RW, reset `0x0000.0000`

#cimage("./images/gptmtbpr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:8],
    [TBPSRH],
    [RW],
    [`0x00`],
    [
        GPTM Timer B Prescale High Byte

        The register loads this value on a write. A read returns the current
        value of the register.

        For the 16/32-bit GPTM, this field is reserved. For the 32/64-bit Wide
        GPTM, this field contains the upper 8-bits of the 16-bit prescaler.

        Refer to @16-bit-timer for more details.
    ],

    [7:0],
    [TBPSR],
    [RW],
    [`0x00`],
    [
        GPTM Timer B Prescale

        The register loads this value on a write. A read returns the current
        value of this register.

        For the 16/32-bit GPTM, this field contains the entire 8-bit prescaler.
        For the 32/64-bit Wide GPTM, this field contains the lower 8-bits of the
        16-bit prescaler.

        Refer to @16-bit-timer for more details.
    ],
))

#pagebreak()

==== GPTM Timer B Match (GPTMTBMATCHR)
<gptmtbmatchr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x034`
- Type RW, reset -

#cimage("./images/gptmtbmatchr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [TBMR],
    [RW],
    [`0x0000.FFFF` (for 16/32-bit) \ `0xFFFF.FFFF` (for 32/64-bit)],
    [
        GPTM Timer B Match Register

        This value is compared to the #link(<gptmtbr>)[*GPTMTBR*] register to
        determine match events.
    ],
))

#pagebreak()

==== GPTM Timer B Prescale Match (GPTMTBPMR)
<gptmtbpmr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x044`
- Type RW, reset `0x0000.0000`

#cimage("./images/gptmtbpmr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:8],
    [TBPSRMH],
    [RW],
    [`0x00`],
    [
        GPTM Timer B Prescale Match High Byte

        This value is used alongside #link(<gptmtbpmr>)[*GPTMTBPMR*] to detect
        timer match events while using a prescaler.

        For the 16/32-bit GPTM, this field is reserved. For the 32/64-bit Wide
        GPTM, this field contains the upper 8-bits of the 16-bit prescale match
        value.
    ],

    [7:0],
    [TBPSMR],
    [RW],
    [`0x00`],
    [
        GPTM Timer B Prescale Match

        This value is used alongside #link(<gptmtbpmr>)[*GPTMTBPMR*] to detect
        timer match events while using a prescaler.

        For the 16/32-bit GPTM, this field contains the entire 8-bit prescaler
        match value. For the 32/64-bit Wide GPTM, this field contains the lower
        8-bits of the 16-bit prescaler match value.
    ],
))

#pagebreak()

==== GPTM Timer B Interval Load (GPTMTBILR)
<gptmtbilr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x02C`
- Type RW, reset -

#cimage("./images/gptmtbilr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [TBILR],
    [RW],
    [`0x0000.FFFF` (for 16/32-bit) \ `0xFFFF.FFFF` (for 32/64-bit)],
    [
        GPTM Timer B Interval Load Register

        Writing this field loads the counter for Timer B. A read returns the
        current value of #link(<gptmtbilr>)[*GPTMTBILR*].

        When a 16/32-bit GPTM is in 32-bit mode, writes are ignored, and reads
        return the current value of #link(<gptmtbilr>)[*GPTMTBILR*].
    ],
))

#pagebreak()

==== GPTM Timer B (GPTMTBR)
<gptmtbr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x04C`
- Type RO, reset -

#cimage("./images/gptmtbr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [TBR],
    [RO],
    [`0x0000.FFFF` (for 16/32-bit) \ `0xFFFF.FFFF` (for 32/64-bit)],
    [
        GPTM Timer B Register

        A read returns the current value of the #link(<gptmtbr>)[*GPTM Timer B
        Count Register*], in all cases except for Input Edge Count and Time
        modes. In the Input Edge Count mode, this register contains the number
        of edges that have occurred. In the Input Edge Time mode, this register
        contains the time at which the last edge event took place.
    ],
))

#pagebreak()

==== GPTM Timer B Prescale Snapshot (GPTMTBPS)
<gptmtbps>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x060`
- Type RO, reset `0x0000.0000`

#cimage("./images/gptmtbps-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [PSS],
    [RO],
    [`0x0000`],
    [
        GPTM Timer B Prescaler Snapshot

        A read returns the current value of the #link(<gptmtbps>)[*GPTM Timer B
        Prescaler*].
    ],
))

#pagebreak()

==== GPTM Timer B Prescale Value (GPTMTBPV)
<gptmtbpv>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x068`
- Type RO, reset `0x0000.0000`

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:16],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:0],
    [PSV],
    [RO],
    [`0x0000`],
    [
        GPTM Timer B Prescaler Value

        A read returns the current, free-running value of the Timer B prescaler.
    ],
))

#pagebreak()

==== 16/32-Bit General-Purpose Timer Run Mode Clock Gating Control (RCGCTIMER)
<rcgctimer>
- Base `0x400F.E000`
- Offset `0x604`
- Type RW, reset `0x0000.0000`

#cimage("./images/rcgctimer-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:6],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [5],
    [R5],
    [RW],
    [0],
    [
        16/32-Bit General-Purpose Timer 5 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [16/32-bit general-purpose timer module 5 is disabled.],
            [1],
            [Enable and provide a clock to 16/32-bit general-purpose timer
                module 5 in Run mode.],
        )
    ],

    [4],
    [R4],
    [RW],
    [0],
    [
        16/32-Bit General-Purpose Timer 4 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [16/32-bit general-purpose timer module 4 is disabled.],
            [1],
            [Enable and provide a clock to 16/32-bit general-purpose timer
                module 4 in Run mode.],
        )
    ],

    [3],
    [R3],
    [RW],
    [0],
    [
        16/32-Bit General-Purpose Timer 3 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [16/32-bit general-purpose timer module 3 is disabled.],
            [1],
            [Enable and provide a clock to 16/32-bit general-purpose timer
                module 3 in Run mode.],
        )

        #v(10em)
    ],

    [2],
    [R2],
    [RW],
    [0],
    [
        16/32-Bit General-Purpose Timer 2 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [16/32-bit general-purpose timer module 2 is disabled.],
            [1],
            [Enable and provide a clock to 16/32-bit general-purpose timer
                module 2 in Run mode.],
        )
    ],

    [1],
    [R1],
    [RW],
    [0],
    [
        16/32-Bit General-Purpose Timer 1 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [16/32-bit general-purpose timer module 1 is disabled.],
            [1],
            [Enable and provide a clock to 16/32-bit general-purpose timer
                module 1 in Run mode.],
        )
    ],

    [0],
    [R0],
    [RW],
    [0],
    [
        16/32-Bit General-Purpose Timer 0 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [16/32-bit general-purpose timer module 0 is disabled.],
            [1],
            [Enable and provide a clock to 16/32-bit general-purpose timer
                module 0 in Run mode.],
        )
    ],
))

#pagebreak()

#heading(level: 4, [
    32/64-Bit Wide General-Purpose Timer Run Mode Clock Gating Control
    (RCGCWTIMER)
])
<rcgcwtimer>
- Base `0x400F.E000`
- Offset `0x65C`
- Type RW, reset `0x0000.0000`

#cimage("./images/rcgcwtimer-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:6],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [5],
    [R5],
    [RW],
    [0],
    [
        32/64-Bit Wide General-Purpose Timer 5 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [32/64-bit wide general-purpose timer module 5 is disabled.],
            [1],
            [Enable and provide a clock to 32/64-bit wide general-purpose timer
                module 5 in Run mode.],
        )
    ],

    [4],
    [R4],
    [RW],
    [0],
    [
        32/64-Bit Wide General-Purpose Timer 4 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [32/64-bit wide general-purpose timer module 4 is disabled.],
            [1],
            [Enable and provide a clock to 32/64-bit wide general-purpose timer
                module 4 in Run mode.],
        )
    ],

    [3],
    [R3],
    [RW],
    [0],
    [
        32/64-Bit Wide General-Purpose Timer 3 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [32/64-bit wide general-purpose timer module 3 is disabled.],
            [1],
            [Enable and provide a clock to 32/64-bit wide general-purpose timer
                module 3 in Run mode.],
        )

        #v(10em)
    ],

    [2],
    [R2],
    [RW],
    [0],
    [
        32/64-Bit Wide General-Purpose Timer 2 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [32/64-bit wide general-purpose timer module 2 is disabled.],
            [1],
            [Enable and provide a clock to 32/64-bit wide general-purpose timer
                module 2 in Run mode.],
        )
    ],

    [1],
    [R1],
    [RW],
    [0],
    [
        32/64-Bit Wide General-Purpose Timer 1 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [32/64-bit wide general-purpose timer module 1 is disabled.],
            [1],
            [Enable and provide a clock to 32/64-bit wide general-purpose timer
                module 1 in Run mode.],
        )
    ],

    [0],
    [R0],
    [RW],
    [0],
    [
        32/64-Bit Wide General-Purpose Timer 0 Run Mode Clock Gating Control

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [32/64-bit wide general-purpose timer module 0 is disabled.],
            [1],
            [Enable and provide a clock to 32/64-bit wide general-purpose timer
                module 0 in Run mode.],
        )
    ],
))

#pagebreak()

==== GPTM Interrupt Clear (GPTMICR)
<gptmicr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x024`
- Type W1C, reset `0x0000.0000`

#cimage("./images/gptmicr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:17],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [16],
    [WUECINT],
    [RW],
    [0],
    [
        32/64-Bit Wide GPTM Write Update Error Interrupt Clear

        Writing a 1 to this bit clears the `WUERIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `WUEMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.
    ],

    [15:12],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11],
    [TBMCINT],
    [W1C],
    [0],
    [
        GPTM Timer B Match Interrupt Clear

        Writing a 1 to this bit clears the `TBMRIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `TBMMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.
    ],

    [10],
    [CBECINT],
    [W1C],
    [0],
    [
        GPTM Timer B Capture Mode Event Interrupt Clear

        Writing a 1 to this bit clears the `CBERIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `CBEMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.

        #v(10em)
    ],

    [9],
    [CBMCINT],
    [W1C],
    [0],
    [
        GPTM Timer B Capture Mode Match Interrupt Clear

        Writing a 1 to this bit clears the `CBMRIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `CBMMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.
    ],

    [8],
    [TBTOCINT],
    [W1C],
    [0],
    [
        GPTM Timer B Time-Out Interrupt Clear

        Writing a 1 to this bit clears the `TBTORIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `TBTOMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.
    ],

    [7:5],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [4],
    [TAMCINT],
    [W1C],
    [0],
    [
        GPTM Timer A Match Interrupt Clear

        Writing a 1 to this bit clears the `TAMRIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `TAMMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.
    ],

    [3],
    [RTCCINT],
    [W1C],
    [0],
    [
        GPTM RTC Interrupt Clear

        Writing a 1 to this bit clears the `RTCRIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `RTCMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.
    ],

    [2],
    [CAECINT],
    [W1C],
    [0],
    [
        GPTM Timer A Capture Mode Event Interrupt Clear

        Writing a 1 to this bit clears the `CAERIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `CAEMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.
    ],

    [1],
    [CAMCINT],
    [W1C],
    [0],
    [
        GPTM Timer A Capture Mode Match Interrupt Clear

        Writing a 1 to this bit clears the `CAMRIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `CAMMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.
    ],

    [0],
    [TATOCINT],
    [W1C],
    [0],
    [
        GPTM Timer A Time-Out Raw Interrupt

        Writing a 1 to this bit clears the `TATORIS` bit in the #link(
            <gptmris>,
        )[*GPTMRIS*] register and the `TATOMIS` bit in the #link(
            <gptmmis>,
        )[*GPTMMIS*] register.
    ],
))

#pagebreak()

==== GPTM Interrupt Mask (GPTMIMR)
<gptmimr>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x018`
- Type RW, reset `0x0000.0000`

#cimage("./images/gptmimr-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:17],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [16],
    [WUEIM],
    [RW],
    [0],
    [
        32/64-Bit Wide GPTM Write Update Error Interrupt Mask

        The `WUEIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )
    ],

    [15:12],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [11],
    [TBMIM],
    [RW],
    [0],
    [
        GPTM Timer B Match Interrupt Mask

        The `TBMIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )

        #v(10em)
    ],

    [10],
    [CBEIM],
    [RW],
    [0],
    [
        GPTM Timer B Capture Mode Event Interrupt Mask

        The `CBEIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )
    ],

    [9],
    [CBMIM],
    [RW],
    [0],
    [
        GPTM Timer B Capture Mode Match Interrupt Mask

        The `CBMIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )
    ],

    [8],
    [TBTOIM],
    [RW],
    [0],
    [
        GPTM Timer B Time-Out Interrupt Mask

        The `TBTOIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )
    ],

    [7:5],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [4],
    [TAMIM],
    [RW],
    [0],
    [
        GPTM Timer A Match Interrupt Mask

        The `TAMIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )
    ],

    [3],
    [RTCIM],
    [RW],
    [0],
    [
        GPTM RTC Interrupt Mask

        The `RTCIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )
    ],

    [2],
    [CAEIM],
    [RW],
    [0],
    [
        GPTM Timer A Capture Mode Event Interrupt Mask

        The `CAEIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )
    ],

    [1],
    [CAMIM],
    [RW],
    [0],
    [
        GPTM Timer A Capture Mode Match Interrupt Mask

        The `CAMIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )
    ],

    [0],
    [TATOIM],
    [RW],
    [0],
    [
        GPTM Timer A Time-Out Interrupt Mask

        The `TATOIM` values are defined as follows:

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Interrupt is disabled.],
            [1], [Interrupt is enabled.],
        )
    ],
))

#pagebreak()

==== GPTM Raw Interrupt Status (GPTMRIS)
<gptmris>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x01C`
- Type RO, reset `0x0000.0000`

#cimage("./images/gptmris-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:17],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [16],
    [WUERIS],
    [RW],
    [0],
    [
        32/64-Bit Wide GPTM Write Update Error Raw Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [No error.],
            [1],
            [
                Either a Timer A register or a Timer B register was written
                twice in a row or a Timer A register was written before the
                corresponding Timer B register was written.
            ],
        )
    ],

    [15:12],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [11],
    [TBMRIS],
    [RO],
    [0],
    [
        GPTM Timer B Match Raw Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The match value has not been reached.],
            [1],
            [
                The `TBMRIS` bit is set in the #link(<gptmtbmr>)[*GPTMTBMR*]
                register, and the match values in the #link(
                    <gptmtbmatchr>,
                )[*GPTMTBMATCHR*] and (optionally) #link(
                    <gptmtbpmr>,
                )[*GPTMTBPMR*] registers have been reached when configured in
                one-shot or periodic mode.
            ],
        )

        This bit is cleared by writing a 1 to the `TBMCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [10],
    [CBERIS],
    [RO],
    [0],
    [
        GPTM Timer B Capture Mode Event Raw Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The capture mode event for Timer B has not occurred.],
            [1],
            [
                A capture mode event has occurred for Timer B. This interrupt
                asserts when the subtimer is configured in Input Edge-Time mode
                or when configured in PWM mode with the PWM interrupt enabled by
                setting the `TBPWMIE` bit in the #link(<gptmtbmr>)[*GPTMTBMR*]
                register.
            ],
        )

        This bit is cleared by writing a 1 to the `CBECINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [9],
    [CBMRIS],
    [RO],
    [0],
    [
        GPTM Timer B Capture Mode Match Raw Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The capture mode match for Timer B has not occurred.],
            [1],
            [
                The capture mode match has occurred for Timer B. This interrupt
                asserts when the values in the #link(<gptmtbr>)[*GPTMTBR*] and
                #link(<gptmtbpr>)[*GPTMTBPR*] match the values in the #link(
                    <gptmtbmatchr>,
                )[*GPTMTBMATCHR*] and #link(<gptmtbpmr>)[*GPTMTBPMR*] when
                configured in Input Edge-Time mode.
            ],
        )

        This bit is cleared by writing a 1 to the `CBMCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.

        #v(10em)
    ],

    [8],
    [TBTORIS],
    [RO],
    [0],
    [
        GPTM Timer B Time-Out Raw Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Timer B has not timed out.],
            [1],
            [
                Timer B has timed out. This interrupt is asserted when a
                one-shot or periodic mode timer reaches its count limit (0 or
                the value loaded into #link(<gptmtbilr>)[*GPTMTBILR*], depending
                on the count direction).
            ],
        )

        This bit is cleared by writing a 1 to the `TBTOCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [7:5],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [4],
    [TAMRIS],
    [RO],
    [0],
    [
        GPTM Timer A Match Raw Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The match value has not been reached.],
            [1],
            [
                The `TAMIE` bit is set in the #link(<gptmtamr>)[*GPTMTAMR*]
                register, and the match value in the #link(
                    <gptmtamatchr>,
                )[*GPTMTAMATCHR*] and (optionally) #link(
                    <gptmtapmr>,
                )[*GPTMTAPMR*] registers have been reached when configured in
                one-shot or periodic mode.
            ],
        )

        This bit is cleared by writing a 1 to the `TAMCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [3],
    [RTCRIS],
    [RO],
    [0],
    [
        GPTM RTC Raw Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The RTC event has not occurred.],
            [1], [The RTC event has occurred.],
        )

        This bit is cleared by writing a 1 to the `RTCCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.

        #v(20em)
    ],

    [2],
    [CAERIS],
    [RO],
    [0],
    [
        GPTM Timer A Capture Mode Event Raw Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The capture mode event for Timer A has not occurred.],
            [1],
            [
                A capture mode event has occurred for Timer A. This interrupt
                asserts when the subtimer is configured in Input Edge-Time mode
                or when configured in PWM mode with the PWM interrupt enabled by
                setting the `TAPWMIE` bit in the #link(<gptmtamr>)[*GPTMTAMR*]
                register.
            ],
        )

        This bit is cleared by writing a 1 to the `CAECINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [1],
    [CAMRIS],
    [RO],
    [0],
    [
        GPTM Timer A Capture Mode Match Raw Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [The capture mode match for Timer A has not occurred.],
            [1],
            [
                This interrupt asserts when the values in the #link(
                    <gptmtar>,
                )[*GPTMTAR*] and #link(<gptmtapr>)[*GPTMTAPR*] match the values
                in the #link(<gptmtamatchr>)[*GPTMTAMATCHR*] and #link(
                    <gptmtapmr>,
                )[*GPTMTAPMR*] when configured in Input Edge-Time mode.
            ],
        )

        This bit is cleared by writing a 1 to the `CAMCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [0],
    [TATORIS],
    [RO],
    [0],
    [
        GPTM Timer A Time-Out Raw Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [Timer A has not timed out.],
            [1],
            [
                Timer A has timed out. This interrupt is asserted when a
                one-shot or periodic mode timer reaches its count limit (0 or
                the value loaded into #link(<gptmtailr>)[*GPTMTAILR*], depending
                on the count direction).
            ],
        )

        This bit is cleared by writing a 1 to the `TATOCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],
))

#pagebreak()

==== GPTM Masked Interrupt Status (GPTMMIS)
<gptmmis>
- 16/32-bit Timer 0 base: `0x4003.0000`
- 16/32-bit Timer 1 base: `0x4003.1000`
- 16/32-bit Timer 2 base: `0x4003.2000`
- 16/32-bit Timer 3 base: `0x4003.3000`
- 16/32-bit Timer 4 base: `0x4003.4000`
- 16/32-bit Timer 5 base: `0x4003.5000`
- 32/64-bit Wide Timer 0 base: `0x4003.6000`
- 32/64-bit Wide Timer 1 base: `0x4003.7000`
- 32/64-bit Wide Timer 2 base: `0x4004.C000`
- 32/64-bit Wide Timer 3 base: `0x4004.D000`
- 32/64-bit Wide Timer 4 base: `0x4004.E000`
- 32/64-bit Wide Timer 5 base: `0x4004.F000`
- Offset `0x020`
- Type RO, reset `0x0000.0000`

#cimage("./images/gptmmis-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:17],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [16],
    [WUEMIS],
    [RO],
    [0],
    [
        32/64-Bit Wide GPTM Write Update Error Masked Interrupt Status

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An unmasked Write Update Error has not occurred.],
            [1], [An unmasked Write Update Error has occurred.],
        )
    ],

    [15:12],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [11],
    [TBMMIS],
    [RO],
    [0],
    [
        GPTM Timer B Match Masked Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [A Timer B Mode Match interrupt has not occurred or is masked.],

            [1], [An unmasked Timer B Mode Match interrupt has occurred.],
        )

        This bit is cleared by writing a 1 to the `TBMCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [10],
    [CBEMIS],
    [RO],
    [0],
    [
        GPTM Timer B Capture Mode Event Masked Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [A Capture B event interrupt has not occurred or is masked.],
            [1], [An unmasked Capture B event interrupt has occurred.],
        )

        This bit is cleared by writing a 1 to the `CBECINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [9],
    [CBMMIS],
    [RO],
    [0],
    [
        GPTM Timer B Capture Mode Match Masked Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [A Capture B Mode Match interrupt has not occurred or is masked.],

            [1], [An unmasked Capture B Match interrupt has occurred.],
        )

        This bit is cleared by writing a 1 to the `CBMCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [8],
    [TBTOMIS],
    [RO],
    [0],
    [
        GPTM Timer B Time-Out Masked Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [A Timer B Time-Out interrupt has not occurred or is masked.],
            [1], [An unmasked Timer B Time-Out interrupt has occurred.],
        )

        This bit is cleared by writing a 1 to the `TBTOCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [7:5],
    [reserved],
    [RO],
    [0],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.

        #v(10em)
    ],

    [4],
    [TAMMIS],
    [RO],
    [0],
    [
        GPTM Timer A Match Masked Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [A Timer A Mode Match interrupt has not occurred or is masked.],

            [1], [An unmasked Timer A Mode Match interrupt has occurred.],
        )

        This bit is cleared by writing a 1 to the `TAMCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [3],
    [RTCMIS],
    [RO],
    [0],
    [
        GPTM RTC Masked Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [An RTC event interrupt has not occurred or is masked.],
            [1], [An unmasked RTC event interrupt has occurred.],
        )

        This bit is cleared by writing a 1 to the `RTCCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [2],
    [CAEMIS],
    [RO],
    [0],
    [
        GPTM Timer A Capture Mode Event Masked Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [A Capture A event interrupt has not occurred or is masked.],
            [1], [An unmasked Capture A event interrupt has occurred.],
        )

        This bit is cleared by writing a 1 to the `CAECINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],

    [1],
    [CAMMIS],
    [RO],
    [0],
    [
        GPTM Timer A Capture Mode Match Masked Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [A Capture A Mode Match interrupt has not occurred or is masked.],

            [1], [An unmasked Capture A Match interrupt has occurred.],
        )

        This bit is cleared by writing a 1 to the `CAMCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.

        #v(10em)
    ],

    [0],
    [TATOMIS],
    [RO],
    [0],
    [
        GPTM Timer A Time-Out Masked Interrupt

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [A Timer A Time-Out interrupt has not occurred or is masked.],
            [1], [An unmasked Timer A Time-Out interrupt has occurred.],
        )

        This bit is cleared by writing a 1 to the `TATOCINT` bit in the #link(
            <gptmicr>,
        )[*GPTMICR*] register.
    ],
))

#pagebreak()

=== Initialisation and configuration
+ To use a GPTM, the appropriate `TIMERn` bit must be set in the #link(
        <rcgctimer>,
    )[*RCGCTIMER*] or #link(<rcgcwtimer>)[*RCGCWTIMER*] register.
+ Enable the clock to the appropriate GPIO module via the #link(
        <rcgcgpio>,
    )[*RCGCGPIO*] register.
+ Configure the `PMCn` fields in the #link(<gpiopctl>)[*GPIOPCTL*] register to
    assign the CCP signals to the appropriate pins (@gpio-pins).

==== One-shot or periodic timer configuration
+ Ensure the timer is disabled, which means to ensure that the `TnEN` bit in the
    #link(<gptmctl>)[*GPTMCTL*] register is cleared before making any changes.
+ Write `0x0000.0000` to the #link(<gptmcfg>)[*GPTM Configuration (GPTMCFG)*]
    register.
+ Configure the `TnMR` field in the #link(<gptmtamr>)[*GPTM Timer n Mode
    (GPTMTnMR)*] register:
    #enum(
        numbering: "a.",
        [Write a value of `0x1` for One-Shot mode.],
        [Write a value of `0x2` for Periodic mode.],
    )
+ Configure the `TnSNAPS`, `TnWOT`, `TnMIE`, and `TnCDIR` bits in the #link(
        <gptmtamr>,
    )[*GPTMTnMR*] register.
+ Load the start value into the #link(<gptmtailr>)[*GPTM Timer n Interval Load
    (GPTMTnILR)*] register.
+ If interrupts are required, set the appropriate bits in the #link(
        <gptmimr>,
    )[*GPTM Interrupt Mask (GPTMIMR)*].
+ Set the `TnEN` bit in the #link(<gptmctl>)[*GPTMCTL*] register to enable the
    timer and start counting.
+ Poll the #link(<gptmris>)[*GPTMRIS*] register or wait for the interrupt to be
    generated (if enabled). In both cases, the status flags are cleared by
    writing a 1 to the appropriate bit of the #link(<gptmicr>)[*GPTM Interrupt
    Clear (GPTMICR)*] register.

In One-Shot mode, the timer stops counting after the time-out event. To
re-enable the timer, repeat the sequence.

==== Real time clock mode
+ Ensure the timer is disabled, which means the `TnEN` bit is cleared, before
    making any changes.
+ If the timer has been operating in a different mode prior to this, clear any
    residual set bits in the #link(<gptmtamr>)[*GPTM Timer n Mode (GPTMTnMR)*]
    register before reconfiguring.
+ Write `0x0000.0001` to the #link(<gptmcfg>)[*GPTM Configuration Register
    (GPTMCFG)*] register.
+ Write the match value to the #link(<gptmtamatchr>)[*GPTM Timer n Match
    (GPTMTnMATCHR)*] register.
+ Set or clear the `RTCEN` and `TnSTALL` bit in the #link(<gptmctl>)[*GPTM
    Control (GPTMCTL)*] register as needed.
+ If interrupts are required, set the `RTCIM` bit in the #link(<gptmimr>)[*GPTM
    Interrupt Mask (GPTMIMR)*] register.
+ Set the `TAEN` bit in the #link(<gptmctl>)[*GPTMCTL*] register to enable the
    timer and start counting.

When the timer count equals the value in the #link(
    <gptmtamatchr>,
)[*GPTMTnMATCHR*] register, the GPTM asserts the `RTCRIS` bit in the #link(
    <gptmris>,
)[*GPTMRIS*] register and continues counting until Timer A is disabled or a
hardware reset occurs.

The interrupt is cleared by writing to the `RTCCINT` bit in the #link(
    <gptmicr>,
)[*GPTMICR*] register.

Not that if the #link(<gptmtailr>)[*GPTMTnILR*] register is loaded with a new
value, the timer begins counting at this new value and continues until it
reaches `0xFFFF.FFFF`, at which point it rolls over.

#pagebreak()

==== Input Edge Count mode
A timer is configured to the Input Edge Count mode by the follow sequence:
+ Ensure the timer is disabled, which means the `TnEN` bit is cleared, before
    making any changes.
+ Write `0x0000.0004` to the #link(<gptmcfg>)[*GPTM Configuration (GPTMCFG)*]
    register.
+ In the #link(<gptmtamr>)[*GPTM Timer n Mode (GPTMTnMR)*] register, write `0x0`
    to the `TnCMR` field and the `0x3` to the `TnMR` field.
+ Configure the type of events that the timer captures by writing to the
    `TnEVENT` field of the #link(<gptmctl>)[*GPTM Control (GPTMCTL)*] register.
+ Program registers according to the count direction:
    - In down-count mode, the #link(<gptmtamatchr>)[*GPTMTnMATCHR*] and #link(
            <gptmtapmr>,
        )[*GPTMTnPMR*] registers are configured so that the difference between
        the value in the #link(<gptmtailr>)[*GPTMTnILR*] and the #link(
            <gptmtapr>,
        )[*GPTMTnPR*] registers and the #link(<gptmtamatchr>)[*GPTMTnMATCHR*]
        and #link(<gptmtapmr>)[*GPTMTnPMR*] equals the number of edge events
        that must be counted.
    - In up-count mode, the timer counts from `0x0` to the value in the #link(
            <gptmtamatchr>,
        )[*GPTMTnMATCHR*] and #link(<gptmtapmr>)[*GPTMTnPMR*] registers. Note
        that when executing an up-count, the value of the #link(
            <gptmtapr>,
        )[*GPTMTnPR*] and #link(<gptmtailr>)[*GPTMTnILR*] must be greater than
        the value of #link(<gptmtapmr>)[*GPTMTnPMR*] and #link(
            <gptmtamatchr>,
        )[*GPTMTnMATCHR*].
+ If interrupts are required, set the `CnMIM` bit in the #link(<gptmimr>)[*GPTM
    Interrupt Mask (GPTMIMR)*] register.
+ Set the `TnEN` bit in the #link(<gptmctl>)[*GPTMCTL*] register to enable the
    timer and begin waiting for edge events.
+ Poll the `CnMRIS` bit in the #link(<gptmris>)[*GPTMRIS*] register or wait for
    the interrupt to be generated if enabled.

In both cases, the status flags are cleared by writing a 1 to the `CnMCINT` bit
of the #link(<gptmicr>)[*GPTM Interrupt Clear (GPTMICR)*] register.

When counting down in Input Edge Count mode, the timer stops after the
programmed number of edge events has been detected. To re-enable the timer,
ensure that the `TnEN` bit is cleared and repeat steps 4 through 8.

#pagebreak()

==== Input Edge Time mode
A timer is configured to Input Edge Time mode by the following sequence:
+ Ensure the timer is disabled, which means the `TnEN` bit is cleared, before
    making any changes.
+ Write `0x0000.0004` to the #link(<gptmcfg>)[*GPTM Configuration (GPTMCFG)*]
    register.
+ In the #link(<gptmtamr>)[*GPTM Timer Mode (GPTMTnMR)*] register, write `0x1`
    to the `TnCMR` field and `0x3` to the `TnMR` field and select a count
    direction by programming the `TnCDIR` bit.
+ Configure the type of event that the timer captures by writing to the
    `TnEVENT` field of the #link(<gptmctl>)[*GPTM Control (GPTMCTL)*] register.
+ If a prescaler is to be used, write the prescale value to the #link(
        <gptmtapr>,
    )[*GPTM Timer n Interval Load (GPTMTnPR)*] register.
+ Load the timer start value into the #link(<gptmtailr>)[*GPTM Timer n Interval
    Load (GPTMTnILR)*] register.
+ If interrupts are required, set the `CnEIM` bit in the #link(<gptmimr>)[*GPTM
    Interrupt Mask (GPTMIMR)*] register.
+ Set the `TnEN` bit in the #link(<gptmctl>)[*GPTM Control (GPTMCTL)*] register
    to enable the timer and start counting.
+ Poll the `CnERIS` bit in the #link(<gptmris>)[*GPTMRIS*] register or wait for
    the interrupt to be generated (if enabled).

In both cases, the status flags are cleared by writing a 1 to the `CnECINT` bit
of the #link(<gptmicr>)[*GPTM Interrupt Clear (GPTMICR)*] register. The time at
which the event happened can be obtained by reading the #link(
    <gptmtar>,
)[*GPTM Timer n (GPTMTnR)*] register.

==== PWM mode
A timer is configured to PWM mode using the following sequence:
+ Ensure the timer is disabled, which means the `TnEN` bit is cleared, before
    making any changes.
+ Write `0x0000.0004` to the #link(<gptmcfg>)[*GPTM Configuration (GPTMCFG)*]
    register.
+ In the #link(<gptmtamr>)[*GPTM Timer n Mode (GPTMTnMR)*] register, set the
    `TnAMS` bit to `0x1`, the `TnCMR` bit to `0x0`, and the `TnMR` field to
    `0x2`.
+ Configure the output state of the PWM signal, like whether or not is inverted,
    in the `TnPWML` field of the #link(<gptmctl>)[*GPTM Control (GPTMCTL)*]
    register.
+ If a prescaler is to be used, write the prescale value to the #link(
        <gptmtapr>,
    )[*GPTM Timer n Prescale (GPTMTnPR)*] register.
+ If PWM interrupts are used, configure the interrupt condition in the `TnEVENT`
    field in the #link(<gptmctl>)[*GPTMCTL*] register and enable the interrupts
    by setting the `TnPWMIE` bit in the #link(<gptmtamr>)[*GPTMTnMR*] register.
    Note that the edge detection interrupt behaviour is reversed when the PWM
    output is inverted.
+ Load the timer start value into the #link(<gptmtailr>)[*GPTM Timer n Interval
    Load (GPTMTnILR)*] register.
+ Load the #link(<gptmtamatchr>)[*GPTM Timer n Match (GPTMTnMATCHR)*] register
    with the match value.
+ Set the `TnEN` bit in the #link(<gptmctl>)[*GPTM Control (GPTMCTL)*] register
    to enable the timer and begin generation of the output PWM signal.

In PWM time mode, the timer continues running after the PWM signal has been
generated. THe PWM period can be adjusted at any time by writing to the #link(
    <gptmtailr>,
)[*GPTMTnILR*] register, and the change takes effect on the next cycle after the
write.

= TM4C123GH6PM interrupts
#cimage("./images/tm4c123gh6pm-interrupts.png")

- Controlled by the Nested Vectored Interrupt Controller (NVIC).
- Interrupt Request (IRQ) is an exception signaled by a peripheral or generated
    by a software request and fed through the NVIC. The latter is prioritised.
- All interrupts are asynchronous to instruction execution.
- In the system, peripherals use interrupts to communicate with the processor.

#pagebreak()

== Interrupts
#align(center, table(
    align: left,
    columns: 4,
    table.header(
        [*Vector Number*],
        [*Interrupt Number (Bit in Interrupt Registers)*],
        [*Vector Address or Offset*],
        [*Description*],
    ),
    [0-15], [-], [`0x0000.0000 - 0x0000.003C`], [Processor exceptions],

    [16], [0], [`0x0000.0040`], [GPIO Port A],

    [17], [1], [`0x0000.0044`], [GPIO Port B],

    [18], [2], [`0x0000.0048`], [GPIO Port C],

    [19], [3], [`0x0000.004C`], [GPIO Port D],

    [20], [4], [`0x0000.0050`], [GPIO Port E],

    [21], [5], [`0x0000.0054`], [UART0],

    [22], [6], [`0x0000.0058`], [UART1],

    [23], [7], [`0x0000.005C`], [SSIO],

    [24], [8], [`0x0000.0060`], [I#super[2]C0],

    [25], [9], [`0x0000.0064`], [PWM0 Fault],

    [26], [10], [`0x0000.0068`], [PWM0 Generator 0],

    [27], [11], [`0x0000.006C`], [PWM0 Generator 1],

    [28], [12], [`0x0000.0070`], [PWM0 Generator 2],

    [29], [13], [`0x0000.0074`], [QEI0],

    [30], [14], [`0x0000.0078`], [ADC0 Sequence 0],

    [31], [15], [`0x0000.007C`], [ADC0 Sequence 1],

    [32], [16], [`0x0000.0080`], [ADC0 Sequence 2],

    [33], [17], [`0x0000.0084`], [ADC0 Sequence 3],

    [34], [18], [`0x0000.0088`], [Watchdog Timers 0 and 1],

    [35], [19], [`0x0000.008C`], [16/32-Bit Timer 0A],

    [36], [20], [`0x0000.0090`], [16/32-Bit Timer 0B],

    [37], [21], [`0x0000.0094`], [16/32-Bit Timer 1A],

    [38], [22], [`0x0000.0098`], [16/32-Bit Timer 1B],

    [39], [23], [`0x0000.009C`], [16/32-Bit Timer 2A],

    [40], [24], [`0x0000.00A0`], [16/32-Bit Timer 2B],

    [41], [25], [`0x0000.00A4`], [Analog Comparator 0],

    [42], [26], [`0x0000.00A8`], [Analog Comparator 1],

    [43], [27], [-], [Reserved],

    [44], [28], [`0x0000.00B0`], [System Control],

    [45], [29], [`0x0000.00B4`], [Flash Memory Control and EEPROM Control],

    [46], [30], [`0x0000.00B8`], [GPIO Port F],

    [47-48], [31-32], [-], [Reserved],

    [49], [33], [`0x0000.00C4`], [UART2],

    [50], [34], [`0x0000.00C8`], [SSI1],

    [51], [35], [`0x0000.00CC`], [16/32-Bit Timer 3A],

    [52], [36], [`0x0000.00D0`], [16/32-Bit Timer 3B],

    [53], [37], [`0x0000.00D4`], [I#super[2]C1],

    [54], [38], [`0x0000.00D8`], [QEI1],

    [55], [39], [`0x0000.00DC`], [CAN0],

    [56], [40], [`0x0000.00E0`], [CAN1],

    [57-58], [41-42], [-], [Reserved],

    [59], [43], [`0x0000.00EC`], [Hibernation Module],

    [60], [44], [`0x0000.00F0`], [USB],

    [61], [45], [`0x0000.00F4`], [PWM Generator 3],

    [62], [46], [`0x0000.00F8`], [μDMA Software],

    [63], [47], [`0x0000.00FC`], [μDMA Error],

    [64], [48], [`0x0000.0100`], [ADC1 Sequence 0],

    [65], [49], [`0x0000.0104`], [ADC1 Sequence 1],

    [66], [50], [`0x0000.0108`], [ADC1 Sequence 2],

    [67], [51], [`0x0000.010C`], [ADC1 Sequence 3],

    [68-72], [52-56], [-], [Reserved],

    [73], [57], [`0x0000.0124`], [SSI2],

    [74], [58], [`0x0000.0128`], [SSI3],

    [75], [59], [`0x0000.012C`], [UART3],

    [76], [60], [`0x0000.0130`], [UART4],

    [77], [61], [`0x0000.0134`], [UART5],

    [78], [62], [`0x0000.0138`], [UART6],

    [79], [63], [`0x0000.013C`], [UART7],

    [80-83], [64-67], [`0x0000.0140 - 0x0000.014C`], [Reserved],

    [84], [68], [`0x0000.0150`], [I#super[2]C2],

    [85], [69], [`0x0000.0154`], [I#super[2]C3],

    [86], [70], [`0x0000.0158`], [16/32-Bit Timer 4A],

    [87], [71], [`0x0000.015C`], [16/32-Bit Timer 4B],

    [88-107], [72-91], [`0x0000.0160 - 0x0000.01AC`], [Reserved],

    [108], [92], [`0x0000.01B0`], [16/32-Bit Timer 5A],

    [109], [93], [`0x0000.01B4`], [16/32-Bit Timer 5B],

    [110], [94], [`0x0000.01B8`], [32/64-Bit Timer 0A],

    [111], [95], [`0x0000.01BC`], [32/64-Bit Timer 0B],

    [112], [96], [`0x0000.01C0`], [32/64-Bit Timer 1A],

    [113], [97], [`0x0000.01C4`], [32/64-Bit Timer 1B],

    [114], [98], [`0x0000.01C8`], [32/64-Bit Timer 2A],

    [115], [99], [`0x0000.01CC`], [32/64-Bit Timer 2B],

    [116], [100], [`0x0000.01D0`], [32/64-Bit Timer 3A],

    [117], [101], [`0x0000.01D4`], [32/64-Bit Timer 3B],

    [118], [102], [`0x0000.01D8`], [32/64-Bit Timer 4A],

    [119], [103], [`0x0000.01DC`], [32/64-Bit Timer 4B],

    [120], [104], [`0x0000.01E0`], [32/64-Bit Timer 5A],

    [121], [105], [`0x0000.01E4`], [32/64-Bit Timer 5B],

    [122], [106], [`0x0000.01E8`], [System Exception (imprecise)],

    [123-149], [107-133], [-], [Reserved],

    [150], [134], [`0x0000.0258`], [PWM1 Generator 0],

    [151], [135], [`0x0000.025C`], [PWM1 Generator 1],

    [152], [136], [`0x0000.0260`], [PWM1 Generator 2],

    [153], [137], [`0x0000.0264`], [PWM1 Generator 3],

    [154], [138], [`0x0000.0268`], [PWM1 Fault],
))

#pagebreak()

#let interrupt_priority_table = align(center, table(
    align: left,
    columns: 2,
    table.header([*PRIn Register Bit Field*], [*Interrupt*]),
    [Bits 31:29 (`INTD`)], [Interrupt [4n+3]],

    [Bits 23:21 (`INTC`)], [Interrupt [4n+2]],

    [Bits 15:13 (`INTB`)], [Interrupt [4n+1]],

    [Bits 7:5 (`INTA`)], [Interrupt [4n]],
))

== Registers

=== Interrupt 0-31 Set Enable (EN0)
<en0>
- Base `0xE000.E000`
- Offset `0x100`
- Type RW, reset `0x0000.0000`

Registers:
- Register 4: Interrupt 0-31 Set Enable (EN0), offset `0x100`
- Register 5: Interrupt 32-63 Set Enable (EN1), offset `0x104`
- Register 6: Interrupt 64-95 Set Enable (EN2), offset `0x108`
- Register 7: Interrupt 96-127 Set Enable (EN3), offset `0x10C`

*Note*: This register can only be accessed from privileged mode.

#cimage("./images/en0-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [INT],
    [RW],
    [`0x0000.0000`],
    [
        Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [On a read, indicates the interrupt is disabled. On a write, no
                effect.],

            [1],
            [On a read, indicates the interrupt is enabled. On a write, enables
                the interrupt.],
        )

        A bit can only be cleared by setting the corresponding `INT[n]` bit in
        the #link(<dis0>)[*DISn*] register.
    ],
))

#pagebreak()

=== Interrupt 128-138 Set Enable (EN4)
<en4>
- Base `0xE000.E000`
- Offset `0x110`
- Type RW, reset `0x0000.0000`

*Note*: This register can only be accessed from privileged mode.

#cimage("./images/en4-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:11],
    [reserved],
    [RO],
    [`0x0000.0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [10:0],
    [INT],
    [RW],
    [`0x0`],
    [
        Interrupt Enable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [On a read, indicates the interrupt is disabled. On a write, no
                effect.],

            [1],
            [On a read, indicates the interrupt is enabled. On a write, enables
                the interrupt.],
        )

        A bit can only be cleared by setting the corresponding `INT[n]` bit in
        the #link(<dis4>)[*DIS4*] register.
    ],
))

#pagebreak()

=== Interrupt 0-31 Clear Enable (DIS0)
<dis0>
- Base `0xE000.E000`
- Offset `0x180`
- Type RW, reset `0x0000.0000`

Registers:
- Register 9: Interrupt 0-31 Clear Enable (DIS0), offset `0x180`
- Register 10: Interrupt 32-63 Clear Enable (DIS1), offset `0x184`
- Register 11: Interrupt 64-95 Clear Enable (DIS2), offset `0x188`
- Register 12: Interrupt 96-127 Clear Enable (DIS3), offset `0x18C`

#cimage("./images/dis0-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:0],
    [INT],
    [RW],
    [`0x0000.0000`],
    [
        Interrupt Disable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0], [On a read, indicates the interrupt is disabled.],
            [1],
            [
                On a read, indicates the interrupt is enabled. On a write,
                clears the corresponding `INT[n]` bit in the #link(<en0>)[*EN0*]
                register, disabling interrupt [n].
            ],
        )
    ],
))

#pagebreak()

=== Interrupt 128-138 Clear Enable (DIS4)
<dis4>
- Base `0xE000.E000`
- Offset `0x190`
- Type RW, reset `0x0000.0000`

#cimage("./images/dis4-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:11],
    [reserved],
    [RO],
    [`0x0000.000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [10:0],
    [INT],
    [RW],
    [`0x0`],
    [
        Interrupt Disable

        #table(
            columns: 2,
            align: left,
            stroke: none,
            table.header([Value], [Description]),

            [0],
            [On a read, indicates the interrupt is disabled. On a write, no
                effect.],

            [1],
            [
                On a read, indicates the interrupt is enabled. On a write,
                clears the corresponding `INT[n]` bit in the #link(<en4>)[*EN4*]
                register, disabling interrupt [n].
            ],
        )
    ],
))

#pagebreak()

=== Interrupt 0-3 Priority (PRI0)
<pri0>
- Base `0xE000.E000`
- Offset `0x400`
- Type RW, reset `0x0000.0000`

Registers:
- Register 29: Interrupt 0-3 Priority (PRI0), offset `0x400`
- Register 30: Interrupt 4-7 Priority (PRI1), offset `0x404`
- Register 31: Interrupt 8-11 Priority (PRI2), offset `0x408`
- Register 32: Interrupt 12-15 Priority (PRI3), offset `0x40C`
- Register 33: Interrupt 16-19 Priority (PRI4), offset `0x410`
- Register 34: Interrupt 20-23 Priority (PRI5), offset `0x414`
- Register 35: Interrupt 24-27 Priority (PRI6), offset `0x418`
- Register 36: Interrupt 28-31 Priority (PRI7), offset `0x41C`
- Register 37: Interrupt 32-35 Priority (PRI8), offset `0x420`
- Register 38: Interrupt 36-39 Priority (PRI9), offset `0x424`
- Register 39: Interrupt 40-43 Priority (PRI10), offset `0x428`
- Register 40: Interrupt 44-47 Priority (PRI11), offset `0x42C`
- Register 41: Interrupt 48-51 Priority (PRI12), offset `0x430`
- Register 42: Interrupt 52-55 Priority (PRI13), offset `0x434`
- Register 43: Interrupt 56-59 Priority (PRI14), offset `0x438`
- Register 44: Interrupt 60-63 Priority (PRI15), offset `0x43C`
- Register 45: Interrupt 64-67 Priority (PRI16), offset `0x440`
- Register 46: Interrupt 68-71 Priority (PRI17), offset `0x444`
- Register 47: Interrupt 72-75 Priority (PRI18), offset `0x448`
- Register 48: Interrupt 76-79 Priority (PRI19), offset `0x44C`
- Register 49: Interrupt 80-83 Priority (PRI20), offset `0x450`
- Register 50: Interrupt 84-87 Priority (PRI21), offset `0x454`
- Register 51: Interrupt 88-91 Priority (PRI22), offset `0x458`
- Register 52: Interrupt 92-95 Priority (PRI23), offset `0x45C`
- Register 53: Interrupt 96-99 Priority (PRI24), offset `0x460`
- Register 54: Interrupt 100-103 Priority (PRI25), offset `0x464`
- Register 55: Interrupt 104-107 Priority (PRI26), offset `0x468`
- Register 56: Interrupt 108-111 Priority (PRI27), offset `0x46C`
- Register 57: Interrupt 112-115 Priority (PRI28), offset `0x470`
- Register 58: Interrupt 116-119 Priority (PRI29), offset `0x474`
- Register 59: Interrupt 120-123 Priority (PRI30), offset `0x478`
- Register 60: Interrupt 124-127 Priority (PRI31), offset `0x47C`
- Register 61: Interrupt 128-131 Priority (PRI32), offset `0x480`
- Register 62: Interrupt 132-135 Priority (PRI33), offset `0x484`
- Register 63: Interrupt 136-138 Priority (PRI34), offset `0x488`

*Note*: This register can only be accessed from privileged mode.

#pagebreak()

The #link(<pri0>)[*PRIn*] registers provide 3-bit priority fields for each
interrupt. These registers are byte accessible. Each register holds four
priority fields that are assigned to interrupts as follows:

#interrupt_priority_table

#cimage("./images/prin-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:29],
    [INTD],
    [RW],
    [`0x0`],
    [
        Interrupt Priority for Interrupt [4n+3]

        This field holds a priority value, 0-7, for the interrupt with the
        number [4n+3], where n is the number of the *Interrupt Priority*
        register (n=0 for #link(<pri0>)[*PRI0*], and so on). The lower the
        value, the greater the priority of the corresponding interrupt.
    ],

    [28:24],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [23:21],
    [INTC],
    [RW],
    [`0x0`],
    [
        Interrupt Priority for Interrupt [4n+2]

        This field holds a priority value, 0-7, for the interrupt with the
        number [4n+2], where n is the number of the *Interrupt Priority*
        register (n=0 for #link(<pri0>)[*PRI0*], and so on). The lower the
        value, the greater the priority of the corresponding interrupt.
    ],

    [20:16],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [15:13],
    [INTB],
    [RW],
    [`0x0`],
    [
        Interrupt Priority for Interrupt [4n+1]

        This field holds a priority value, 0-7, for the interrupt with the
        number [4n+1], where n is the number of the *Interrupt Priority*
        register (n=0 for #link(<pri0>)[*PRI0*], and so on). The lower the
        value, the greater the priority of the corresponding interrupt.

        #v(10em)
    ],

    [12:8],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:5],
    [INTA],
    [RW],
    [`0x0`],
    [
        Interrupt Priority for Interrupt [4n]

        This field holds a priority value, 0-7, for the interrupt with the
        number [4n], where n is the number of the *Interrupt Priority* register
        (n=0 for #link(<pri0>)[*PRI0*], and so on). The lower the value, the
        greater the priority of the corresponding interrupt.
    ],

    [4:0],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],
))

#pagebreak()

=== System Handler Priority 3 (SYSPRI3)
<syspri3>
- Base `0xE000.E000`
- Offset `0xD20`
- Type RW, reset `0x0000.0000`

#cimage("./images/syspri3-register.png")

#align(center, table(
    columns: 5,
    align: left,
    table.header([*Bit/Field*], [*Name*], [*Type*], [*Reset*], [*Description*]),

    [31:29],
    [TICK],
    [RW],
    [`0x0`],
    [
        SysTick Exception Priority

        This field configures the priority level of the SysTick exception.
        Configurable priority values are in the range 0-7, with lower values
        having higher priority.
    ],

    [28:24],
    [reserved],
    [RO],
    [`0x0`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [23:21],
    [PENDSV],
    [RW],
    [`0x0`],
    [
        PendSV Priority

        This field configures the priority level of PendSV. Configurable
        priority values are in the range 0-7, with lower values having higher
        priority.
    ],

    [20:8],
    [reserved],
    [RO],
    [`0x000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],

    [7:5],
    [DEBUG],
    [RW],
    [`0x0`],
    [
        Debug Priority

        This field configures the priority level of Debug. Configurable priority
        values are in the range 0-7, with lower values having higher priority.
    ],

    [4:0],
    [reserved],
    [RO],
    [`0x0000`],
    [
        Software should not rely on the value of a reserved bit. To provide
        compatibility with future products, the value of a reserved bit should
        be preserved across a read-modify-write operation.
    ],
))

#pagebreak()

== Working with interrupts
- There are 5 sets of enable (#link(<en0>)[*ENn*]) registers on the
    TM4C123GH6PM.
- They enable the interrupts and show which interrupts are enabled.
- Base: `0xE000.E000`
    - #link(<en0>)[Interrupt 0-31 Set Enable (EN0)], offset `0x100`
    - #link(<en0>)[Interrupt 32-63 Set Enable (EN1)], offset `0x104`
    - #link(<en0>)[Interrupt 64-95 Set Enable (EN2)], offset `0x108`
    - #link(<en0>)[Interrupt 96-127 Set Enable (EN3)], offset `0x10C`
    - #link(<en4>)[Interrupt 128-138 Set Enable (EN4)], offset `0x110`
- Bit mappings for #link(<en0>)[*ENn*]:
    - Bit 0 of #link(<en0>)[*EN0*] corresponds to interrupt 0, and bit 31
        corresponds to interrupt 31.
    - Bit 0 of #link(<en0>)[*EN1*] corresponds to interrupt 32, and bit 31
        corresponds to interrupt 63.
    - Bit 0 of #link(<en0>)[*EN2*] corresponds to interrupt 64, and bit 31
        corresponds to interrupt 95.
    - Bit 0 of #link(<en0>)[*EN3*] corresponds to interrupt 96, and bit 31
        corresponds to interrupt 127.
    - Bit 0 of #link(<en4>)[*EN4*] corresponds to interrupt 128, and bit 10
        corresponds to interrupt 138.
- If a pending interrupt is enabled, the NVIC activates the interrupt based on
    its priority.
- If an interrupt is not enabled, asserting its interrupt signal changes the
    interrupt state to pending, but the NVIC never activates the interrupt,
    regardless of its priority.
- To enable an interrupt, like `SS1` (interrupt 34) for example.
    - Set bit 2 of #link(<en0>)[*EN1*] to 1.
    - Note that *writing zeros* to the registers #link(<en0>)[*EN0*] through
        #link(<en4>)[*EN4*] *does not disable the interrupt*.
    - To disable the interrupt, write 1s to the corresponding #link(
            <dis0>,
        )[*DIS0*] to #link(<dis4>)[*DIS4*] registers.
- Bit mappings for #link(<dis0>)[*DISn*]:
    - Bit 0 of #link(<dis0>)[*DIS0*] corresponds to interrupt 0, and bit 31
        corresponds to interrupt 31.
    - Bit 0 of #link(<dis0>)[*DIS1*] corresponds to interrupt 32, and bit 31
        corresponds to interrupt 63.
    - Bit 0 of #link(<dis0>)[*DIS2*] corresponds to interrupt 64, and bit 31
        corresponds to interrupt 95.
    - Bit 0 of #link(<dis0>)[*DIS3*] corresponds to interrupt 96, and bit 31
        corresponds to interrupt 127.
    - Bit 0 of #link(<dis4>)[*DIS4*] corresponds to interrupt 128, and bit 10
        corresponds to interrupt 138.

#pagebreak()

== Interrupt priority
- There are 35 priority registers #link(<pri0>)[*PRIn*] on the TM4C123GH6PM.
- Each interrupt priority level can be specified by a 3-bit priority field
    giving a priority level of 0 to 7 for each interrupt. 0 is the highest
    priority, and 7 is the lowest priority.
- Each #link(<pri0>)[*PRIn*] register controls 4 priority fields. These 4
    priority fields (`INTA`, `INTB`, `INTC`, and `INTD`) are assigned to
    interrupts as follows:

    #interrupt_priority_table

== Initialising edge triggered interrupt on a pin
For example, making use of Port C bit 4 (`PC4`), interrupting on the rising
edges:
+ Activate clock for Port C by writing `0x04` to the #link(
        <rcgcgpio>,
    )[*RCGCGPIO*] register.
+ Enable `PC4` by writing `0x10` to the #link(<gpioden>)[*GPIODEN*] register.
+ Configure `PC4` to be edge sensitive by writing `0x10` to the #link(
        <gpiois>,
    )[*GPIOIS*] register.
+ Configure `PC4` to not interrupt on both edges by clearing the `0x10` bit in
    the #link(
        <gpioibe>,
    )[*GPIOIBE*] register.
+ Configure `PC4` to interrupt on the rising edge by writing `0x10` to the
    #link(<gpioiev>)[*GPIOIEV*] register.
+ Clear the interrupt on `PC4` by writing `0x10` to the #link(
        <gpioicr>,
    )[*GPIOICR*] register.
+ Turn on the interrupt on `PC4` by writing `0x10` to the #link(
        <gpioim>,
    )[*GPIOIM*] register.
+ Set the interrupt priority of `PC4` to 5 by writing `0x00A0.0000` to the
    #link(<pri0>)[*PRI0*] register to set bits 21 - 23.
+ Enable NVIC interrupt 2, which is the handler for Port C, by writing `0x04` to
    the #link(<en0>)[*EN0*] register.

#pagebreak()

== SysTick periodic interrupt
- The SysTick timer is a simple way to create periodic interrupts.
- A periodic interrupt is one that is generated on a fixed time basis.
- Useful when you need to do periodic polling.

The SysTick registers below are used to create a periodic interrupt.

#cimage("./images/systick-registers.png")

=== How to determine the frequency of the periodic interrupt
$ F_"bus" = "Frequency of the bus clock" $
$ n = "24 bit reload value" $

Hence the frequency of the periodic interrupt is $F_"bus"/(n + 1)$.

=== SysTick periodic interrupt initialisation
+ Clear the `Enable` bit in the #link(<stctrl>)[*STCTRL*] register.
+ Enter the 24 bit value into the #link(<streload>)[*STRELOAD*] register.
+ Write any value to the #link(<stcurrent>)[*STCURRENT*] register to clear the
    counter.
+ Set `CLK_SRC` (bit 2) to 1 in the #link(<stctrl>)[*STCTRL*] register.
+ Enable `ITEN` to enable interrupts in the #link(<stctrl>)[*STCTRL*] register.
+ Set the priority level of the TICK interrupts (bits 29 - 31) on #link(
        <syspri3>,
    )[*SYSPRI3*] register.
+ Set the `Enable` bit back in the #link(<stctrl>)[*STCTRL*] register to turn on
    the counter.
+ When the `CURRENT` value counts to 0, the `COUNT` flag is set.
+ On the next clock, the `CURRENT` is loaded with the `RELOAD` value.
+ If the `RELOAD` value is n, the `COUNT` flag will be configured to trigger an
    interrupt at every n+1 counts.

==== Example
+ Activate the clock for Port D by writing `0x08` to the #link(
        <rcgcgpio>,
    )[*RCGCGPIO*] register.
+ Disable analogue mode for Port D by writing `0` to the #link(
        <gpioamsel>,
    )[*GPIOAMSEL*] register.
+ Set Port D bit 0 (PD0) to output by writing `0x01` to the #link(
        <gpiodir>,
    )[*GPIODIR*] register.
+ Enable digital I/O on PD0 by writing `0x01` to the #link(<gpioden>)[*GPIODEN*]
    register.
+ Disable SysTick during setup by writing `0` to the #link(<stctrl>)[*STCTRL*]
    register.
+ Set the reload value by writing `0x00FFFF` to the #link(
        <streload>,
    )[*STRELOAD*] register.
+ Write any value, like a `0`, to the #link(<stcurrent>)[*STCURRENT*] register
    to clear the register.
+ Set #link(<syspri3>)[*SYSPRI3*] register to priority 2 by writing `0x40000000`
    (bits 29 - 31) to it.
+ Enable the core clock and interrupts by writing `0x00000007` to the #link(
        <stctrl>,
    )[*STCTRL*] register.

#pagebreak()

== Timer period interrupt
To create a periodic interrupt:
- Set a prescale value, which can be any 8 bit number, loaded into the #link(
        <gptmtapr>,
    )[*GPTMTAPR*] register.
- $"Timer frequency" = "Bus frequency"/("Prescale" + 1)$
- If using the default prescale of 0, then the timer frequency is equal to the
    bus frequency.
- Load the 32 bit counting value of the time, or the period, into the #link(
        <gptmtailr>,
    )[*GPTMTAILR*] register.

=== Initialisation
+ Enable the General Purpose Timer Module in the #link(<rcgctimer>)[*RCGCTIMER*]
    register.
+ Clear the `TAEN` bit in the #link(<gptmctl>)[*GPTMCTL*] register to turn off
    the timer.
+ Write `0x00` to the #link(<gptmcfg>)[*GPTMCFG*] register to set the timer to
    32 bit mode.
+ Write `0x02` to the #link(<gptmtamr>)[*GPTMTAMR*] register to configure for
    periodic mode.
+ Load the 32 bit PERIOD value into the #link(<gptmtailr>)[*GPTMTAILR*]
    register.
+ Load PRESCALE into the #link(<gptmtapr>)[*GPTMTAPR*] register.
+ Write a 1 to `TATOCINT` in the #link(<gptmicr>)[*GPTMICR*] register to clear
    the time out flag.
+ Write a 1 to `TATIM` in the #link(<gptmimr>)[*GPTMIMR*] register to set the
    timeout interrupt.
+ Set the interrupt priority to the correct NVIC register.
+ Enable the correct interrupt in the NVIC interrupt enable register.
+ Set the `TAEN` bit back on to start the timer to begin counting down from the
    PERIOD value.

#pagebreak()

= ARM reference

== ARM's instruction format
#cimage("./images/arm-instruction-format-table.png")

- The ARM's instruction format is a 4-byte instruction, consisting of the
    operation code (opcode), and the operands.
- Format 1: `Opcode DestReg, Operand2`
- Format 2: `Opcode DestReg, SrcReg, Operand2`
- Where:
    - `Opcode` is the operation code.
    - `DestReg` is the destination register to write the result to.
    - `Operand2` is the 2nd operand or argument given to the operation.
    - `SrcReg` is the source register where the data is read from.
- Most, if not all instructions on the Tiva C are 8-bit instructions and can
    only take 8-bit values.

== ARM's data formats
- Decimal numbers like `123`.
- Hexadecimal numbers like `0x3F`.
- `n_xxx`, where `n` is the base of the number from 2 to 9, and `xxx` is the
    number. For example, `8_12` is the octal number 12.
- A single character constant like `'A'`.
- String constants like `"string"`.

#pagebreak()

== Syntax

=== Semicolon (`;`)
```asm
; This is a comment.
```

Semicolons in ARM denote the start of a comment.

=== Hash (`#`)
```asm
#2
```

- The hash symbol (`#`) stands for a literal in ARM.
- Use the hash symbol to indicate numbers or strings.

==== Example
Copy the number 1 into the register `R0`.
```asm
MOV R0, #1
```

=== Square brackets (`[]`)
```asm
[value{, optional_offset}]{!}
[value], {optional_offset}      ; Post-indexed addressing
```

- Square brackets (`[]`) are the *value of* operator in ARM, which is equivalent
    to *dereferencing a pointer* in low-level programming languages like C or
    Rust.
- Use it to use the given value (`value`) as a memory address instead of a
    regular value.
- An optional offset (`optional_offset`) can be provided to add the offset to
    the given value to obtain the memory address.
- The `!` represents write-back, and it is optional. Including the `!` will
    update the `value` given to include the `optional_offset`, which means
    `value` becomes `value + optional_offset` after the instruction is done.
- The second form is for post-indexed addressing, which is when the `value` is
    used as the address for the memory access, then the `optional_offset` is
    applied to the address and written back to the register. Basically, `value`
    is used to access the memory, then once the memory is accessed, the
    `optional_offset` is added to `value`, so `value` becomes
    `value + optional_offset`.

==== Example 1
- Use the value in the `R1` register as a memory address.
- Load into register `R5` the data found at the memory address.
    ```asm
    LDR R5, [R1]
    ```

==== Example 2
- Use the value in the `R1` register as a memory address, and add 4 to the
    value.
- Load into register `R6` the data found at the memory address.
    ```asm
    LDR R6, [R1, 4]
    ```

==== Example 3
- Use the value in the `R1` register as a memory address.
- Load into register `R0` the data found at the memory address.
- Register `R1` in this example is called the base address register.
```asm
LDR R0, [R1]    ; Equivalent to: LDR R0, [R1, #0]
                ; C code: R0 = memory[R1]
```

#pagebreak()

==== Example 4
- Use the value in the `R1` register as a memory address.
- Store into register `R0` the data found at the memory address.
- Register `R1` in this example is called the base address register.
```asm
STR R0, [R1]    ; Equivalent to: STR R0, [R1, #0]
                ; C code: memory[R1] = R0
```

==== Example 5
- Use the value in the `R1` register as a memory address, offset by 4.
- Store into register `R0` the data found at the memory address.
- Write the offset back into register `R1`, so that `R1` becomes `R1 + 4`.
```asm
LDR R0, [R1, #4]!
```

==== Example 6
- Use the value in the `R1` register as a memory address.
- Load into register `R0` the data found at the memory address given by register
    `R1`.
- Offset the memory address in register `R1` by 32 and save it back to register
    `R1`.
```asm
LDR R0, [R1], #32
```

== Addressing modes
There are multiple addressing modes that can be used for loads and stores. The
number in parentheses refers to the examples below:

- Register addressing, where the address is in a register (1).
- Pre-indexed addressing, where an offset to the base register is added before
    the memory access. The offset can be positive or negative and can be an
    immediate value of another register with an optional shift applied. (2),
    (3).
- Pre-indexed with write-back, which is indicated with an exclamation mark (!)
    added after the instruction. After the memory access has occurred, this
    updates the base register by adding the offset value (4).
- Post-index with write-back, where the offset is written after the square
    bracket. The address from the base register is only used for memory access,
    with the offset value added to the base register after the memory access
    (5).

```asm
; Address pointed to by R1
(1) LDR R0, [R1]

; Address pointed to by R1 + R2
(2) LDR R0, [R1, R2]

; Address is R1 + (R2 * 4)
(3) LDR R0, [R1, R2, LSL #2]

; Address pointed to by R1 + 32, then R1 = R1 + 32
(4) LDR R0, [R1, #32]!

; Read R0 from pointed to by R1, then R1 = R1 + 32
(5) LDR R0, [R1], #32
```

=== Examples with `LDR`
#align(center)[#table(
    columns: (8em, auto, auto, auto),
    align: left,
    table.header([], [*Instruction*], [*`R0 = `*], [*`R1 +=`*]),

    table.cell(rowspan: 3)[*Pre-index with write-back*],
    [`LDR R0, [R1, #0x4]!`], [`memory[R1 + 0x4]`], [`0x4`],
    [`LDR R0, [R1, R2]!`], [`memory[R1 + R2]`], [`R2`],

    [`LDR R0, [R1, R2, LSR #0x4]!`],
    [`memory[R1 + (R2 LSR 0x4)]`],
    [`R2 LSR 0x4`],

    table.cell(rowspan: 3)[*Pre-index without write-back*],
    [`LDR R0, [R1, #0x4]`], [`memory[R1 + 0x4]`], [Not updated],
    [`LDR R0, [R1, R2]`], [`memory[R1 + R2]`], [Not updated],

    [`LDR R0, [R1, -R2, LSR #0x4]`],
    [`memory[R1 - (R2 LSR 0x4)]`],
    [Not updated],

    table.cell(rowspan: 3)[*Post-index*],
    [`LDR R0, [R1], #0x4`], [`memory[R1]`], [`0x4`],
    [`LDR R0, [R1, R2]`], [`memory[R1]`], [`R2`],
    [`LDR R0, [R1], R2 LSR #0x4]`], [`memory[R2]`], [`R2 LSR 0x4`],
)]

=== Syntax examples
The `shift` in the table below can be one of `LSL`, `LSR`, `ASR` or `ROR`, which
are the bit shifting operations in ARM assembly.

#align(center)[#table(
    columns: (auto, 25em),
    align: left,
    table.header([*Addressing mode and index method*], [*Addressing syntax*]),
    [Pre-index with immediate offset], [`[register #+/-offset]`],
    [Pre-index with register offset], [`[register_1 +/-register_2]`],

    [Pre-index with scaled register offset],
    [`[register_1 +/-register_2, shift #shift_amount]`],

    [Pre-index write-back with immediate offset], [`[register #+/-offset]!`],

    [Pre-index write-back with register offset],
    [`[register_1 +/-register_2]!`],

    [Pre-index write-back with scaled register offset],
    [`[register_1 +/-register_2, shift #shift_amount]!`],

    [Immediate post-indexed], [`[register], #+/-offset`],
    [Register post-indexed], [`[register_1], +/-register_2`],

    [Scaled register post-indexed],
    [`[register_1], +/-register_2, shift #shift_amount`],
)]

#pagebreak()

== Condition code suffixes
<condition-code-suffixes>

#align(center)[#table(
    columns: 4,
    align: (auto, auto, auto),
    table.header([*Opcode [31:28]*], [*Suffix*], [*Flags*], [*Meaning*]),
    [0000], [`EQ`], [Z = 1], [Equal],
    [0001], [`NE`], [Z = 0], [Not equal],
    [0010], [`CS` or `HS`], [C = 1], [Higher or same, unsigned],
    [0011], [`CC` or `LO`], [C = 0], [Lower, unsigned],
    [0100], [`MI`], [N = 1], [Negative],
    [0101], [`PL`], [N = 0], [Positive or zero],
    [0110], [`VS`], [V = 1], [Overflow],
    [0111], [`VC`], [V = 0], [No overflow],
    [1000], [`HI`], [C = 1 and Z = 0], [Higher, unsigned],
    [1001], [`LS`], [C = 0 or Z = 1], [Lower or same, unsigned],
    [1010], [`GE`], [N = V], [Greater than or equal, signed],
    [1011], [`LT`], [N $eq.not$ V], [Less than, signed],
    [1100], [`GT`], [Z = 0 and N = V], [Greater than, signed],
    [1101], [`LE`], [Z = 1 and N $eq.not$ V], [Less than or equal, signed],

    [1110],
    [`AL`],
    [Can have any value],
    [Always, or unconditional. This is the default when no suffix is given.],
)]

#let condition_doc = [
    `{condition}` is an optional condition suffix. Refer to the #link(
        <condition-code-suffixes>,
    )[condition code suffixes] for more information on the available suffixes
    and what they mean.
]

#let s_suffix_doc = [
    `{S}` is an optional suffix. If `S` is specified, the condition flags are
    updated on the result of the operation. In other words, the current program
    status register (CPSR) is updated when `S` is specified.
]

== ARM CPU instructions
ARM instructions are performed by the microprocessor when the program is being
run, and are used to do useful things with the microprocessor, like read and
modify data to perform a task.

== `MOV` (Move)
<mov-instruction>

```asm
MOV{S}{condition} destination, data
```

#cimage("./images/mov-instruction-encoding.png")

- The `MOV` instruction copies the data given into the destination register.
- Note that the `MOV` instruction only supports 8-bit values on the Tiva C.
- Larger values like 32-bit values need to be loaded in some other way, like the
    #link(<ldr-pseudo-instruction>)[`LDR` pseudo-instruction].
- #s_suffix_doc
- #condition_doc

=== Example
Copy the value `0x11` into the register `R0`.

```asm
MOV R0, #0x11
```

#pagebreak()

== `MVN` (Move Not)
```asm
MVN{S}{condition} destination, data
```

- The `MVN` instruction performs a bitwise `NOT` on the data given and saves it
    into the destination register.
- It is the bitwise `NOT` operator on ARM.
- #s_suffix_doc
- #condition_doc

=== Example
Invert the value of 4, which is 100 in binary, to obtain 011 in binary. Then
copy the value of 011 into the register `R2`.

```asm
MVN R2, #4
```

== `MOVT` (Move Top)
```asm
MOVT{S}{condition} destination, data
```

- The `MOVT` instruction is just like the #link(<mov-instruction>)[`MOV`
        instruction], but copies the data given, a 16-bit half-word, into the
    *top* 16-bits of the register.
- #s_suffix_doc
- #condition_doc

=== Example
Copy `0xFEED` into the *top* 16-bits of register `R3`.

```asm
MOVT R3, #0xFEED
```

== `MOVW` (Move Wide)
```asm
MOVW{S}{condition} destination, data
```

- The `MOVW` instruction is just like the #link(<mov-instruction>)[`MOV`
        instruction], but copies the data given, a 16-bit half-word, into the
    *bottom* 16-bits of the register.
- #s_suffix_doc
- #condition_doc

=== Example
Copy `0xC0DE` into the *bottom* 16-bits of register `R3`.

```asm
MOVW R3, #0xC0DE
```

#pagebreak()

#let load_store_docs(base_instruction, size_letter) = {
    let instruction = base_instruction + size_letter
    let raw_instruction = raw(instruction)
    let instruction_word
    if base_instruction == "LDR" {
        instruction_word = "load"
    } else if base_instruction == "STR" {
        instruction_word = "store"
    }
    let instruction_word_s = instruction_word + "s"
    let memory_type
    let memory_size
    if size_letter == "D" {
        memory_size = "8 bytes"
        memory_type = "double-word"
    } else if size_letter == "B" {
        memory_size = "1 byte"
        memory_type = "byte"
    } else if size_letter == "SB" {
        memory_size = "1 signed byte"
        memory_type = "signed byte"
    } else if size_letter == "H" {
        memory_type = "half-word"
    } else if size_letter == "SH" {
        memory_size = "2 signed bytes"
        memory_type = "signed half-word"
    }

    heading(
        level: 2,
        (
            raw_instruction,
            " (",
            titlecase(instruction_word),
            " ",
            titlecase(memory_type),
            ")",
        ).join(""),
    )
    raw(lang: "asm", instruction + "{condition} destination, source")
    [
        - The #raw_instruction instruction #instruction_word_s a *#memory_type*
            of the given `source` register into the `destination` memory
            address.
        - The difference between #raw_instruction and the #link(label(
                lower(base_instruction) + "-instruction",
            ))[#raw(base_instruction) instruction] is that #raw_instruction only
            #instruction_word_s a *#memory_type*, which is *#memory_size*
            instead of *a word*, which is *4 bytes*.
        - #condition_doc

        === Example
        - Use the value in register `R1` as a memory address.
    ]
    if base_instruction == "LDR" {
        [
            - #instruction_word_s a *#memory_type* from the memory address of
                `R1`, and save the contents in register `R4`.
        ]
    } else if base_instruction == "STR" {
        [
            - #instruction_word_s a *#memory_type* from the contents of register
                `R4` into the memory address.
        ]
    }
    raw(lang: "asm", instruction + " R4, [R1]")
}

== `LDR` (Load)
<ldr-instruction>

```asm
LDR{condition} destination, source
```

- The `LDR` instruction loads the value found at the given memory address
    (`source`), into the destination register.
- #condition_doc

=== Example
- Use the value in the `R1` register as a memory address.
- Load into register `R5` the data found at the memory address.
```asm
LDR R5, [R1]
```

=== Pseudo-instruction
<ldr-pseudo-instruction>

```asm
LDR destination, =value
```

The `LDR` pseudo-instruction either loads a 32-bit immediate value or a memory
address (`value`) into the destination register. This instruction is used mostly
used to load 32-bit values that cannot be loaded with #link(
    <mov-instruction>,
)[`MOV` instruction] into a register with one single instruction.

#load_store_docs("LDR", "D")
#load_store_docs("LDR", "B")
#pagebreak()
#load_store_docs("LDR", "SB")
#load_store_docs("LDR", "H")
#load_store_docs("LDR", "SH")

#pagebreak()

== `STR` (Store)
<str-instruction>

```asm
STR{condition} destination, source
```

- The `STR` instruction stores the value of the given `source` register into the
    `destination` memory address.
- #condition_doc

=== Example 1
- Use the value in the `R1` register as a memory address.
- Store the contents of register `R3` into the memory address.
```asm
STR R3, [R1]
```

#load_store_docs("STR", "D")
#load_store_docs("STR", "B")
#pagebreak()
#load_store_docs("STR", "SB")
#load_store_docs("STR", "H")
#load_store_docs("STR", "SH")

#pagebreak()

== `ADD` (Add)
<add-instruction>

```asm
ADD{S}{condition} {destination, }register, value
```

#cimage("./images/add-instruction-encoding.png")

- The `ADD` instruction adds the value in the `register` with the `value` given
    and stores the result in the `destination` register.
- If the `destination` register is not given, the result will be stored in the
    given `register`.
- #s_suffix_doc
- #condition_doc

=== Example 1
Add the value of `R0` twice and store the result in register `R1`

```asm
ADD R1, R0, R0
```

=== Example 2
Add the value of `R0` and 2 and store the result in register `R2`.
```asm
ADD R2, R0, #2
```

=== Example 3
Add the value of `R0` and `R0` shifted left by 2, and store the result in
register `R2`.
```asm
ADD R2, R0, R0, LSL #2
```

=== Example 4
Add 4 to the value of the program counter (`PC`), which is the address of the
`ADD` instruction itself plus 8 bytes and store the result in register `R2`.
```asm
ADD R2, PC, #4
```

#pagebreak()

== `ADC` (Add with Carry)
```asm
ADC{S}{condition} {destination, }register, value
```

#cimage("./images/adc-instruction-encoding.png")

- The `ADC` instruction adds the value in the given `register` with the given
    `value` and stores the result in the `destination` register, which is the
    same as the #link(<add-instruction>)[`ADD` instruction], but it also adds
    the carry flag to the result of the addition.
- If the `destination` register is not given, the result will be stored in the
    given `register`.
- This instruction is usually used to add the overflow from a previous #link(
        <add-instruction>,
    )[`ADD` instruction].
- #s_suffix_doc
- #condition_doc

=== Example
- Use `ADC` to synthesise multi-word addition.
- If register pairs `R0`, `R1` and `R2`, `R3` hold 64-bit values, where `R0` and
    `R2` hold the least significant words, the following instructions leave the
    64-bit sum in `R4` and `R5`.

#stack(
    dir: ltr,
    spacing: 20em,
    ```asm
    ADDS    R4, R0, R2
    ADC     R5, R1, R3
    ```,

    table(
        columns: 3,
        stroke: none,
        align: (left, center, center),
        [], [`R1`], [`R0`],
        [+], [`R3`], [`R2`],
        table.hline(),
        [], [`R5`], [`R4`],
    ),
)

If the second instruction is changed from:
```asm
ADC     R5, R1, R3
```

To:
```asm
ADCS    R5, R1, R3
```

The resulting values of the flags indicate:
- `N` - The 64-bit addition produced a negative result.
- `C` - An unsigned integer overflow occurred.
- `V` - An signed integer overflow occurred.
- `Z` - The most significant 32 bits are all zero.

#pagebreak()

== `SADD16` and `SADD8` (Signed Add)
```asm
SADD16{condition} {destination, }register_1, register_2
SADD8{condition} {destination, }register_1, register_2
```

#cimage("./images/sadd-instruction-encoding.png")

- The `SADD16` and `SADD8` instructions are signed add operations.
- Both add the values in `register_1` and `register_2` together and store the
    result in the `destination` register.
- If the `destination` register is not given, the result will be stored in
    `register_1`.
- They also set the `GE` bits in the current program status register (CPSR)
    according to the results of the additions.
- `SADD16` performs two 16-bit signed integer additions while `SADD8` performs 4
    8-bit signed integer additions.

=== Example
Use the `SADD16` instruction to speed up operations on arrays of half-word data.
For example:
```asm
LDR     R3, [R0], #4    ; Load 4 bytes from R0 and skip to the next 4 bytes
LDR     R5, [R1], #4    ; Load 4 bytes from R1 and skip to the next 4 bytes
SADD16  R3, R3, R5      ; Add R3 and R5 together and store the result in R3
STR     R3, [R2], #4    ; Store 4 bytes in R3 and skip to the next 4 bytes
```

The above performs the same operations as the following:
```asm
LDRH    R3, [R0], #2    ; Load 2 bytes from R0 and skip to the next 2 bytes
LDRH    R4, [R1], #2    ; Load 2 bytes from R1 and skip to the next 2 bytes
ADD     R3, R3, R4      ; Add R3 and R4 together and store the result in R3
STRH    R3, [R2], #2    ; Store 2 bytes in R2 and skip to the next 2 bytes
```

#pagebreak()

== `SUB` (Subtract)
```asm
SUB{S}{condition} {destination, }register, value
```

#cimage("./images/sub-instruction-encoding.png")

- The `SUB` instruction subtracts the given `value` from the value in the given
    `register` and stores the result in the `destination` register.
- If the `destination` register is not given, the result will be stored in the
    given `register`.
- #s_suffix_doc
- Borrow = NOT(Carry) = C - 1
- If the `S` suffix is set, the `C` flag is set to:
    - 1 if no borrow occurs.
    - 0 if a borrow does occur.
- #condition_doc

=== Example
Use `SUB` to subtract one value from another. To decrement the value of register
`R0`, use:
```asm
SUB R0, R0, #1
```

`SUBS` is useful as a loop counter decrement, as the loop branch can test the
flags for the appropriate termination condition, without the need for a separate
compare instruction:
```asm
SUBS R0, R0, #1
```

The code above both decrements the loop counter in `R0` and checks whether it
has reached zero.

#pagebreak()

== `SBC` (Subtract with Carry)
```asm
SUB{S}{condition} {destination, }register, value
```

#cimage("./images/sbc-instruction-encoding.png")

- The `SBC` instruction subtracts the carry (`C`) flag from the given `value`,
    as well as the value in the given `register`, and stores the result in the
    `destination` register.
- If the `destination` register is not given, the result will be stored in the
    given `register`.
- #s_suffix_doc
- Borrow = NOT(Carry) = C - 1
- If the `S` suffix is set, the `C` flag is set to:
    - 1 if no borrow occurs.
    - 0 if a borrow does occur.
- #condition_doc

=== Example
Use `SBC` to synthesise multi-word subtraction. For example, if register pairs
`R0` and `R1` and `R2` and `R3` hold 64-bit values (`R0` and `R2` hold the least
significant words), the following instructions will leave the 64-bit difference
in `R4` and `R5`.
#stack(
    dir: ltr,
    spacing: 20em,
    ```asm
    SUBS    R4, R0, R2
    SUBS    R5, R1, R3
    ```,

    table(
        columns: 3,
        align: (left, center, center),
        stroke: none,
        [], [`R1 + C - 1`], [`R0`],
        [-], [`R3`], [`R2`],
        table.hline(),
        [], [`R5`], [`R4`],
    ),
)

== `RSB` (Reverse Subtract)
<rsb-instruction>
```asm
RSB{S}{condition} {destination, }register, value
```

- The `RSB` instruction subtracts the value in the `register` from the given
    `value` and stores the result in the `destination` register.
- If the `destination` register is not given, the result will be stored in the
    given `register`.
- #s_suffix_doc
- #condition_doc

=== Example
Subtract the value in register `R0` from 5, i.e. 5 - R0.
```asm
RSB R0, R0, #5
```

#pagebreak()

== `RSC` (Reverse Subtract with Carry)
```asm
RSC{S}{condition} {destination, }register, value
```

- The `RSC` instruction subtracts the value in the `register` from the given
    `value` and stores the result in the `destination` register, which is the
    same as the #link(<rsb-instruction>)[`RSB` instruction], but it adds the
    negation of the carry flag to the result of the subtraction.
- If the `destination` register is not given, the result will be stored in the
    given `register`.
- This instruction is usually used to add the underflow, or borrow, from a
    previous #link(<rsb-instruction>)[`RSB` instruction].
- #s_suffix_doc
- #condition_doc

=== Example
Add the negation of the carry flag to the value in register `R2`, then subtract
the value in register `R1` from `R2`, and store the result in register `R0`.
Essentially, it is R2 + C - 1, where `C` is the carry flag.
```asm
RSC R0, R1, R2
```

== `SSUB16` and `SSUB8` (Signed Subtract)
```asm
SSUB16{condition} {destination, }register_1, register_2
SSUB8{condition} {destination, }register_1, register_2
```

#cimage("./images/ssub-instruction-encoding.png")

- The `SSUB16` and `SSUB8` instructions are signed subtract operations.
- Both subtract the value in `register_2` from the value in `register_1` and
    store the result in the `destination` register.
- If the `destination` register is not given, the result will be stored in
    `register_1`.
- They also set the `GE` bits in the current program status register (CPSR)
    according to the results of the additions.
- `SADD16` performs two 16-bit signed integer additions while `SADD8` performs 4
    8-bit signed integer additions.

=== Example
- Use `SSUB16` to for operations on arrays of half-word data. This is similar to
    the way you can use `SADD16`.
- You can also use `SSUB16` for operations on complex numbers that are held as
    pairs of 16-bit integers of Q15 numbers. If you hold the real and imaginary
    parts of a complex number in the bottom and top half of a register
    respectively, then the instruction below will perform the complex arithmetic
    operation R0 = R1 - R2.
    ```asm
    SSUB16 R0, R1, R2
    ```

#pagebreak()

== `MUL` (Multiply)
```asm
MUL{S}{condition} {destination, }register_1, register_2
```

#cimage("./images/mul-instruction-encoding.png")

- The `MUL` instruction multiplies two values from the registers and stores the
    least significant 32 bits of the result in the `destination` register.
- #s_suffix_doc
- #condition_doc

=== Example
Multiply the value of `R0` with `R1` and store the result in register `R2`.
```asm
MUL R2, R0, R1
```

== `MLA` (Multiply Accumulate)
```asm
MLA{S}{condition} destination, register_1, register_2, add_register
```

#cimage("./images/mla-instruction-encoding.png")

- The `MLA` instruction multiplies two values from the registers, then adds the
    value from the `add_register`, then stores the least significant 32 bits of
    the result in the `destination` register.
- Essentially, it does `destination = register_1 * register 2 + add_register`
- #s_suffix_doc
- #condition_doc

=== Example
Multiply the value of `R0` with `R1`, then add the value of `R3`, and store the
result in register `R2`, i.e. `R2 = R0 * R1 + R3`.
```asm
MLA R2, R0, R1, R3
```

#pagebreak()

== `MLS` (Multiply Subtract)
```asm
MLA{S}{condition} destination, register_1, register_2, subtract_register
```

- The `MLS` instruction multiplies two values from the registers, then subtracts
    the value in `subtract_register` from the result of the multiplication, then
    stores the least significant 32 bits of the result in the `destination`
    register.
- Essentially, it does
    `destination = register_1 * register 2 - subtract_register`
- #s_suffix_doc
- #condition_doc

=== Example
Multiply the value of `R0` with `R1`, then subtract the value of `R3` from the
result, and store the result in register `R2`, i.e. `R2 = R0 * R1 - R3`.
```asm
MLS R2, R0, R1, R3
```

== `UMULL` (Unsigned Multiply Long)
```asm
UMULL{S}{condition} destination_low, destination_high, register_1, register_2
```

#cimage("./images/umull-instruction-encoding.png")

- The `UMULL` instruction takes the values from registers `register_1` and
    `register_2` as unsigned integers and multiplies these two integers. Then it
    places the least significant 32 bits of the result in `destination_low` and
    the most significant 32 bits of the result in `destination_high`.
- #s_suffix_doc
- #condition_doc

=== Example
Multiply the values in `R2` and `R3` together, then places the least significant
32 bits of the result in `R0`, and the most significant 32 bits of the result in
`R1`.
```asm
UMULL R0, R1, R2, R3
```

#pagebreak()

== `UMLAL` (Unsigned Multiply Long with Accumulate)
```asm
UMLAL{S}{condition} destination_low, destination_high, register_1, register_2
```

- The `UMLAL` instruction takes the values from registers `register_1` and
    `register_2` as unsigned integers and multiplies these two integers. Then it
    adds the result to the 64-bit unsigned integer contained in
    `destination_low` and `destination_high`.
- #s_suffix_doc
- #condition_doc

=== Example
Multiply the values in `R2` and `R3` together, then add the result to the 64-bit
unsigned integer contained in `R0` and `R1`.
```asm
UMLAL R0, R1, R2, R3
```

== `SMULL` (Signed Multiply Long)
```asm
SMULL{S}{condition} destination_low, destination_high, register_1, register_2
```

- The `SMULL` instruction takes the values from registers `register_1` and
    `register_2` as two's complement signed integers and multiplies these two
    integers. Then it places the least significant 32 bits of the result in
    `destination_low` and the most significant 32 bits of the result in
    `destination_high`.
- #s_suffix_doc
- #condition_doc

=== Example
Multiply the values in `R2` and `R3` together, then places the least significant
32 bits of the result in `R0`, and the most significant 32 bits of the result in
`R1`.
```asm
SMULL R0, R1, R2, R3
```

== `SMLAL` (Signed Multiply Long with Accumulate)
```asm
SMLAL{S}{condition} destination_low, destination_high, register_1, register_2
```

- The `SMLAL` instruction takes the values from registers `register_1` and
    `register_2` as two's complement signed integers and multiplies these two
    integers. Then adds the result to the 64-bit signed integer contained in
    `destination_low` and `destination_high`.
- #s_suffix_doc
- #condition_doc

=== Example
Multiply the values in `R2` and `R3` together, then adds the result to the
64-bit signed integer contained in `R0` and `R1`.
```asm
SMLAL R0, R1, R2, R3
```

== `UDIV` (Unsigned Divide)
```asm
UDIV{condition} {destination, }register_1, register_2
```

- The `UDIV` instruction divides the 32-bit unsigned integer value in
    `register_1` by the 32-bit unsigned integer value in `register_2`, and
    stores the result in the `destination` register.
- If the `destination` register is not given, the result will be stored in
    `register_1`.
- #condition_doc

=== Example
Perform unsigned integer division by dividing the value in `R2` by the value in
`R0`, and store the result in the register `R3`.

```asm
UDIV R3, R2, R0
```

== `AND` (Bitwise AND)
<and-instruction>
```asm
AND{S}{condition} destination, register, value
```

#cimage("./images/and-instruction-encoding.png")

#table(
    align: center,
    columns: 9,
    stroke: none,
    [], [0], [0], [1], [1], [1], [1], [0], [0],
    [AND], [1], [0], [1], [0], [1], [0], [1], [0],
    table.hline(),

    [],
    [#text("0", red)],
    [0],
    [1],
    [#text("0", red)],
    [1],
    [#text("0", red)],
    [#text("0", red)],
    [0],
)

- The `AND` instruction performs a bitwise `AND` on the value from the
    `register` and the given `value`, and stores the result in the destination
    register.
- #s_suffix_doc
- #condition_doc

=== Example
Perform a bitwise `AND` on the value in `R3` and `R0` and store the result in
register `R4`.

```asm
AND R4, R3, R0
```

=== Example of forcing bits to 0
- `R0 = 0000 0001 0001 0000`
- `~R0 = 1111 1110 1110 1111`
- `R1 = 0000 0000 0001 0001`
- `R3 = 1010 1011 1100 1101`

```asm
MOVW    R0, #0x0110     ; Bit mask
MVN     R0, R0          ; Invert the bit mask
AND     R2, R1, R0      ; Zero out the bits in R1 that are also in the mask
AND     R4, R3, R0      ; Zero out the bits in R3 that are also in the mask
```

Result:
- `R2 = 0000 0000 0000 0001`
- `R4 = 1010 1010 1100 1101`

== `ORR` (Bitwise OR)
```asm
ORR{S}{condition} destination, register, value
```

#cimage("./images/orr-instruction-encoding.png")

#table(
    align: center,
    columns: 9,
    stroke: none,
    [], [0], [0], [1], [1], [1], [1], [0], [0],
    [OR], [1], [0], [1], [0], [1], [0], [1], [0],
    table.hline(),

    [],
    [#text("1", red)],
    [0],
    [1],
    [#text("1", red)],
    [1],
    [#text("1", red)],
    [#text("1", red)],
    [0],
)

- The `ORR` instruction performs a bitwise `OR` on the value from the `register`
    and the given `value`, and stores the result in the `destination` register.
- #s_suffix_doc
- #condition_doc

=== Example
Perform a bitwise `OR` on the value in `R1` and `R0` and store the result in
register `R2`.

```asm
ORR R2, R1, R0
```

=== Example of forcing bits to 1
- `R0 = 0000 0001 0001 0000`
- `R1 = 0000 0000 0001 0001`
- `R3 = 1010 1011 1100 1101`

```asm
MOVW    R0, #0x0110     ; Bit mask
ORR     R2, R1, R0      ; Force the bits in R1 that are also in the mask to be 1
ORR     R4, R3, R0      ; Force the bits in R3 that are also in the mask to be 1
```

Result:
- `R2 = 0000 0001 0001 0001`
- `R4 = 1010 1011 1101 1101`

#pagebreak()

== `EOR` (Exclusive OR, XOR)
<eor-instruction>
```asm
EOR{S}{condition} destination, register, value
```

#cimage("./images/eor-instruction-encoding.png")

#table(
    align: center,
    columns: 9,
    stroke: none,
    [], [0], [0], [1], [1], [1], [1], [0], [0],
    [XOR], [1], [0], [1], [0], [1], [0], [1], [0],
    table.hline(),

    [],
    [#text("1", red)],
    [0],
    [#text("0", red)],
    [#text("1", red)],
    [#text("0", red)],
    [#text("1", red)],
    [#text("1", red)],
    [0],
)

- The `EOR` instruction performs a bitwise `XOR`, or exclusive `OR` on the value
    from the `register` and the given `value`, and stores the result in the
    destination register.
- #s_suffix_doc
- #condition_doc

=== Example
Perform a bitwise `XOR`, or exclusive `OR`, on the value in `R1` and `R0` and
store the result in register `R2`.

```asm
EOR R2, R1, R0
```

=== Example of flipping bits
- `R0 = 0000 0001 0001 0000`
- `R1 = 0000 0000 0001 0001`
- `R3 = 1010 1011 1100 1101`

```asm
MOVW    R0, #0x0110     ; Bit mask
EOR     R2, R1, R0      ; Flip the bits in R1 that are also in the mask
EOR     R4, R3, R0      ; Flip the bits in R3 that are also in the mask
```

Result:
- `R2 = 0000 0001 0000 0001`
- `R4 = 1010 1010 1101 1101`

#pagebreak()

== `BIC` (Bit Clear)
```asm
BIC{S}{condition} destination, source, bits
```

#cimage("./images/bic-instruction-encoding.png")

#table(
    align: center,
    columns: 9,
    stroke: none,
    [], [0], [0], [1], [1], [1], [1], [0], [0],

    [BIC],
    [#text("1", red)],
    [0],
    [#text("1", red)],
    [0],
    [#text("1", red)],
    [0],
    [#text("1", red)],
    [0],

    table.hline(),

    [],
    [#text("0", red)],
    [0],
    [#text("0", red)],
    [1],
    [#text("0", red)],
    [1],
    [#text("0", red)],
    [0],
)

- The `BIC` (bit clear) instruction performs a #link(<and-instruction>)[bitwise
        `AND`] on the bits in the `source` register with the complements of the
    corresponding bits in the `bits` given, then copies the result to the
    `destination` register.
- Essentially, it does `source AND NOT bits` and copies the result to the
    `destination` register.
- If the documentation above still does not make sense, the instruction's name
    should give a good idea of what it does.
- Basically, to clear a bit (i.e. set the bit to 0) in the `source` register,
    the bits to clear should be indicated by a `1` in the binary value given in
    `bits`.
- To clear a byte instead, provide a hexadecimal value with the byte to clear
    indicated as `F` to clear a whole byte at once.
- #s_suffix_doc
- #condition_doc

=== Example
Clear the last byte in the register `R1` and copy the result to register `R2`.
```asm
BIC R2, R1, #0xF
```

#pagebreak()

== Shift operators
- `LSL`: Logical shift left
    - `x << y` the least significant bits are filled with zeros.
- `LSR`: Logical shift right
    - `(unsigned) x >> y` the most significant bits are filled with zeros.
- `ASR`: Logical shift right
    - `(signed) x >> y`, copy the sign bit to the most significant bit.
- `ROR`: Rotate right
    - `((unsigned) x >> y) | (x << (32 - y))`.
- `RRX`: Rotate right extended
    - `C flag << 31 | ((unsigned) x >> 1)`
    - Performs 33-bit rotate, with the current program status register's `C` bit
        being inserted above the sign bit of the word.

#cimage("./images/shift-operators.png")

#pagebreak()

== `LSL` (Logical Shift Left)
<lsl-instruction>
```asm
LSL{S}{condition} destination, value, shift_amount
```

#stack(
    dir: ltr,
    spacing: 2em,
    cimage("./images/lsl-instruction-diagram.png", height: 15em),
    cimage("./images/shift-left-vs-rotate-left.png", height: 15em),
)

- The `LSL` instruction performs a bitwise logical shift left on the given
    `value` by the given `shift_amount`.
- The least significant bits are filled with zeros.
- This is equivalent to C's `value << shift_amount`.
- #s_suffix_doc
- #condition_doc

=== Example 1
Perform a logical left shift by 2 bits on the value in register `R1` and store
the result in register `R0`.
```asm
LSL R0, R1, #2
```

=== Example 2
```asm
        AREA    Prog1, CODE, READONLY
        ENTRY
        MOV     R0, #0x11   ; Load initial value
        LSL     R1, R0, #1  ; Shift 1 bit left
        LSL     R2, R1, #1  ; Shift 1 bit left

stop    B   stop    ; Stop program
        END
```

=== Example 3
Example of doing n! (factorial of n).
```asm
        AREA    Prog2, CODE, READONLY
        ENTRY
        MOV     R6, #10     ; Load n into R6
        MOV     R7, #1      ; Initial value of n! is 1, for the case of n = 0
loop    CMP     R7, #0      ; Compare R6 with 0
        MULGT   R7, R6, R7  ; n(n - 1)(n - 2) * ... * 2 * 1
        SUBGT   R6, R6, #1  ; Decrement n by 1
        BGT     loop        ; Multiply again if the counter isn't 0
stop    B       stop        ; Stop program
        END
```

== `LSR` (Logical Shift Right)
<lsr-instruction>
```asm
LSR{S}{condition} destination, value, shift_amount
```

#cimage("./images/lsr-instruction-diagram.png")

- The `LSR` instruction performs a bitwise logical shift right on the given
    `value` by the given `shift_amount`.
- #s_suffix_doc
- #condition_doc

=== Example
Perform a logical right shift by 6 bits on the value in register `R1` and store
the result in register `R0`.
```asm
LSR R0, R1, #6
```

#pagebreak()

== `ASR` (Arithmetic Shift Right)
```asm
ASR{S}{condition} destination, value, shift_amount
```

#cimage("./images/asr-instruction-diagram.png", height: 35em)

- The `ASR` instruction performs a bitwise arithmetic shift right on the given
    `value` by the given `shift_amount`.
- The only difference between `ASR` and #link(<lsr-instruction>)[`LSR`], or an
    arithmetic right shift and a logical right shift, is that the highest bit is
    preserved when doing an arithmetic right shift, while a logical right shift
    will just set the highest bit to 0. This is useful for calculating signed
    integers, as the arithmetic right shift will preserve the sign of the
    integer, i.e. a negative integer will remain negative, while you lose the
    sign when doing a logical right shift.
- #s_suffix_doc
- #condition_doc

=== Example
Perform an arithmetic right shift by 4 bits on the value in register `R1` and
store the result in register `R0`.
```asm
ASR R0, R1, #4
```

#pagebreak()

== `ROR` (Rotate Right)
<ror-instruction>
```asm
ROR{S}{condition} destination, value, shift_amount
```

#cimage("./images/ror-instruction-diagram.png")

- The `ROR` instruction rotates the given `value` right by the given
    `shift_amount`.
- Essentially, what this instruction does is the same as the #link(
        <lsr-instruction>,
    )[`LSR` instruction], or logical shift right, but instead of replacing the
    highest bits with zeros, they are instead replaced with the lowest bits that
    are shifted off.
- #s_suffix_doc
- #condition_doc

=== Example
Rotate the value in register `R1` right by 2 bits and store the result in
register `R0`.
```asm
ROR R0, R1, #2
```

#pagebreak()

== `RRX` (Rotate Right Extended)
```asm
RRX{S}{condition} destination, value, shift_amount
```

#cimage("./images/rrx-instruction-diagram.png")

- The `ROR` instruction rotates the given `value` right by the given
    `shift_amount`, but also writes to the carry (`C`) flag.
- Essentially, what this instruction does is the same as the #link(
        <ror-instruction>,
    )[`LSR` instruction], or rotate right, but instead of just having 32-bits to
    rotate around, there are 33-bits thanks to the carry (`C`) flag being
    included.
- #s_suffix_doc
- #condition_doc

=== Example
Rotate the value in register `R1` right by 10 bits, including the carry bit
(`C`) and store the result in register `R0`.
```asm
RRX R0, R1, #10
```

#pagebreak()

== `B` (Branch)
<b-instruction>
```asm
B{condition}{.W} label
```

#cimage("./images/b-instruction-encoding.png")

- The `B` instruction tells the microprocessor to branch to a different part of
    the code, which is indicated by the `label`.
- `label` can also be a register containing a memory address.
- #condition_doc

=== Example 1
Go to the section of the code labelled `loop`.
```asm
B loop
```

=== Example 2
Go to the section of the code labelled `loop` if the carry flag is clear.
```asm
BCC loop
```

=== Example 3
Go to the section of the code labelled `loop` if the zero flag is set
```asm
BEQ loop
```

== `BL` (Branch with Link)
<bl-instruction>
```asm
BL{condition}{.W} label
```

- The `BL` instruction tells the microprocessor to branch to a different part of
    the code, which is indicated by the `label`, which is the same function as
    the #link(<b-instruction>)[`B` instruction], but also copies the memory
    address of the next instruction into the link register `LR`.
- This instruction is normally used with the #link(<bx-instruction>)[`BX`
        instruction], where the `BL` instruction will jump to a section of code
    to perform a certain task, and the `BX` instruction will be used to jump
    back to the link register `LR` to continue executing from where it left off.
- `label` can also be a register containing a memory address.
- #condition_doc

=== Example
Branch into the section of the code named `function` and save the memory address
of the next instruction into the link register `LR`.
```asm
BL function
```

#pagebreak()

== `BX` and `BXNS` (Branch and Exchange, and Branch and Exchange Non-Secure)
<bx-instruction>
```asm
BX{condition} register
BXNS{condition} register
```

- The `BX` instruction tells the microprocessor to branch to the address
    contained in `register` and exchanges the instruction set if necessary.
- The `BXNS` instruction performs the same function as the `BX` instruction, but
    also transitions from the secure to the non-secure domain.
- If the first bit of the address contained in `register` is `0`, the processor
    changes to, or remains in ARM state.
- If the first bit of the address contained in `register` is `1`, the processor
    changes to, or remains in Thumb state.
- This instruction is normally used with the #link(<bl-instruction>)[`BL`
        instruction], where the `BL` instruction will jump to a section of code
    to perform a certain task, and the `BX` instruction will be used to jump
    back to the link register `LR` to continue executing from where it left off.

=== Example 1
Branch to the link register, which is usually used to return from a function in
ARM assembly.
```asm
BX LR
```

=== Example 2
```asm
        ; Subroutine call to function
        BL func

func
        ; Function body

        ; Code
        ; Code
        ; Code

        ; R15 = R14, set the program counter to the value of the link register.
        ;
        ; This jumps out of the function
        ; and goes back to the instruction after the BL.
        MOV PC, LR

        ; Branch to the address in R12 and
        ; begin ARM execution if bit 0 of R12 is zero.
        ; Otherwise, continue executing thumb code.
        BX R12
```

== `ADR`
```asm
ADR destination, label
```
- The `ADR` instruction loads a memory address to the `destination` register.
- The `label` is the label of the memory address to load. Note that it must be
    defined in the *same* code section.

=== Example
Get the memory address of `var_a` and save it in register `R0`.
```asm
ADR R0, var_a
```

== `CMP` (Compare)
```asm
CMP{condition} register, value
```

- The `CMP` instruction compares whether the value in the `register` is the same
    as the given `value`, and updates the #link(
        <condition-code-suffixes>,
    )[condition flags] on the result.
- This instruction does not place the result in any register.
- `CMP` subtracts the given `value` from the value in the `register`.
- #condition_doc

=== Example
Check whether the value in register `R1` is equal to 1.
```asm
CMP R1, #1
```

== `CMN` (Compare Negative)
```asm
CMN{condition} register, value
```

- The `CMN` instruction compares whether the value in the `register` is the same
    as the given `value`, and updates the #link(
        <condition-code-suffixes>,
    )[condition flags] on the result.
- This instruction does not place the result in any register.
- `CMN` adds the given `value` to the value in the `register`.
- #condition_doc

=== Example
Check whether the value in register `R0` is *not* equal to 1.
```asm
CMN R0, #1
```

#pagebreak()

== `TEQ` (Test Equivalence)
```asm
TST{condition} register, value
```

#cimage("./images/teq-instruction-encoding.png")

- The `TEQ` instruction tests the value in the `register` for equality with the
    `value` given, and updates the #link(<condition-code-suffixes>)[condition
        flags].
- More specifically, the `TEQ` instruction performs a *bitwise XOR* or
    *Exclusive OR* operation on the value in `register` and the given `value`.
- It is the same as the #link(<eor-instruction>)[`EORS` instruction], but the
    result is discarded.
- This instruction is the same as `register == value` in higher level
    programming languages like C and Python.
- This instruction does not store the result in any register, and only updates
    the condition flags.
- #condition_doc
- Use the `TEQ` instruction to test if two values are equal without affecting
    the `V` or `C` flags.
- `TEQ` is also useful for testing the sign of a value. After the comparison,
    the `N` flag is the logical Exclusive OR of the sign bits of the two given
    values.

=== Example
Conditionally test if the value in `R10` is equal to the value in `R9`. The
application program status register (APSR) is updated, but the result is
discarded.
```asm
TEQEQ R10, R9
```

== `TST` (Test bits)
```asm
TST{condition} register, value
```

- The `TST` instruction performs a *bitwise AND* operation on the value in
    `register` and the given `value`.
- It is the same as the #link(<and-instruction>)[`ANDS` instruction], but the
    result is discarded.
- This instruction does not store the result in any register, and only updates
    the condition flags.
- #condition_doc
- To test whether a bit of the given `register` is 0 or 1, use the `TST`
    instruction with a constant that has that bit set to 1 and all other bits
    cleared to 0.

=== Example
Perform bitwise AND of the value in `R0` to `0x3F8`. The application program
status register (APSR) is updated, but the result is discarded.
```asm
TST R2, #1
```

#pagebreak()

== Vector floating point (VFP) operations
- Before performing any vector floating point (VFP) operations on the Tiva C
    microcontroller, the floating point unit (FPU) needs to be enabled.

- The processor must be in privileged mode to read from and write to the
    Coprocessor Access Control (CPAC) register.

- The code below enables the FPU in both privileged and user modes.

    ```asm
    ; CPAC register is located ad address 0xE000ED88,
    ; so load the address into a register
    ; using the LDR pseudo-instruction as it is 32-bit
    LDR R0, =0xE000ED88

    ; Read from the CPAC register into another register
    LDR R1, [R0]

    ; Set bits 20 - 23 to enable CP10 and CP11 coprocessors
    ORR R1, R1, #(0xF << 20)

    ; Write the modified value back to the CPAC register
    STR R1, [R0]
    ```

- All VFP operations basically perform the same function as their non VFP
    counterparts, but manipulate data on either a single-precision or a
    double-precision floating point register.

- A single-precision floating point register is a usually a register on the
    floating point unit (FPU) starting with `S`, like `S0` and `S1`. A
    single-precision floating point register can hold 32-bits.

- A double-precision floating point register is a usually a register on the
    floating point unit (FPU) starting with `D`, like `D0` and `D1`. A
    double-precision floating point register can hold 64-bits.

#let v_func_doc(base_func) = {
    let base_instruction = raw(upper(base_func))
    let v_func = raw("V" + upper(base_func))
    [
        - #v_func performs the same function as the #link(label(
                lower(base_func) + "-instruction",
            ))[#base_instruction instruction]
        - The main difference with #v_func and #base_instruction is that the
            `destination` can either be a single-precision, like `S0` and `S1`,
            or double-precision floating point register, like `D0` and `D1`.
        - #condition_doc
    ]
}

== `VLDR` (Vector Load)
```asm
VLDR{condition}.32 destination, value
VLDR{condition}.64 destination, value
```

#v_func_doc("LDR")
- The `.32` and `.64` part of the instruction is optional.

=== Example
Load the value from the memory address in the register `R6` offset by 8 into the
single-precision floating point register `S5`.

```asm
VLDR S5, [R6, #08]
```

#pagebreak()

== `VSTR` (Vector Load)
```asm
VSTR{condition}.32 destination, value
VSTR{condition}.64 destination, value
```

#v_func_doc("STR")
- The `.32` and `.64` part of the instruction is optional.

=== Example
Store the value from the single-precision floating point register `S5` to the
memory address in the register `R6`.

```asm
VSTR R6, S5
```

== `VMOV` (Vector Move)
```asm
VMOV{condition}.F32 destination, value
VMOV{condition}.F64 destination, value
```
#v_func_doc("MOV")
- The `32` and `64` part of the instruction is optional.

=== Example
Load the value from register `R6` into single-precision register `S12`, and the
value from register `R11` into single-precision register `S13`.

```asm
VMOV S12, S13, R6, R11
```

== `VADD` (Vector Add)
```asm
VADD{condition}.F32 destination, value
VADD{condition}.F64 destination, value
```

#v_func_doc("ADD")
- The `32` and `64` part of the instruction is optional.

=== Example
Add the value from single-precision registers `S1` and `S0` and store the result
in single-precision register `S2`.

```asm
VADD.F S2, S1, S0
```

#pagebreak()

== Directives
- Directives are *not* CPU instructions, as they are not executed by the CPU
    when running the program.
- Instead, directives are instructions to the assembler, which is the ARM
    assembler (`armasm`) if you are using the ARM Keil IDE.
- If you are using GCC or ArmClang, then the directives would differ from the
    ones listed below.

== Allocating memory to house instructions or data
```asm
{label} {instruction | directive | pseudo_instruction}
```

- The `label` is the label for the memory allocation.
- `{instruction | directive | pseudo_instruction}` is the CPU instructions or
    assembler directives to execute.

=== Example
```asm
        EXPORT Start    ; Export the start label of the program

        ; Assembler directive to allocate memory for code
        AREA ARMex, CODE, READONLY

Start   MOV R0, #10     ; Label and processor instruction
        MOV R1, #3      ; Another processor instruction
stop    B   stop        ; Label and another processor instruction
        END             ; Assembler directive signifying the end of the file
```

== `SETS`
```asm
{name} SETS string
```

The `SETS` directive sets a string value to a variable given by `{name}`.
- `string` is the string the variable is set to.

=== Example
Set the variable `my_text` to the string, `"This is my text"`.
```asm
my_text SETS "This is my text"
```

== `EQU`
```asm
{name} EQU number{, type}
```

The `EQU` directive sets a number value to a variable given by `{name}`.
- `number` is the number the variable is set to.
- `type` is optional, and it refers to the type of the number given to the `EQU`
    directive.

=== Example
Set the variable `temperature` to the number `25.6`.
```asm
temperature EQU 25.6
```

#pagebreak()

== `RN`
```asm
name RN expression
```

The `RN` directive defines a name for a specified register.
- `name` is the name to be assigned to the register. `name` cannot be the same
    as any of the predefined names.
- `expr` is either a register like `R0`, or a register number from 0 to 15.

=== Example
Define the name `regname` for the register `r11`.
```asm
regname RN 11
```

== `MACRO` and `MEND`
```asm
MACRO
{$label}     macro_name{$condition} {$parameter_1{, $parameter_2}...}
            ; Code for the macro
            MEND
```
- The `MACRO` directive signifies the start of the definition of a macro.
- Likewise, the `MEND` directive signifies the end of the definition of a macro.
- Take note that the `$` characters are required in a macro definition.
- The `label` is the label for the start of the macro.
- #condition_doc
- `parameter_1, parameter_2, ...` are the parameters the macro can take.

=== Example 1
```asm
MACRO
            ; Macro definition
            ; var_a = 8 * (var_b + var_c + 6)
$Label_1    AddMul $var_a, $var_b, $var_c

$Label_1
            ; Add var_a, var_b and var_c together
            ; and store the result in var_a
            ADD $var_a, $var_b, $var_c

            ; Add 6 to var_a
            ADD $var_a, $var_a, #6

            ; Bitwise shift var_a left by 3 bits.
            ; This basically multiplies var_a by 8,
            ; since 2^3 is 8.
            LSL $var_a, $var_a, #3

            MEND
```

When the above macro is invoked using:
```asm
    AddMul R0, R1, R2
```

It expands into:
```asm
    ADD R0, R1, R2
    ADD R0, R1, #6
    LSL R0, R1, #3
```

#pagebreak()

=== Example 2
Macro definition:
```asm
                MACRO   ; Start of macro definition
$label          xmac    $p1, $p2
                ; Code
$label.loop1    ; Code
                ; Code
                BGE     $label.loop1
$label.loop2    ; Code
                BL      $p1
                BGT     $label.loop2
                ; Code
                ADR     $p2
                MEND    ; End of macro definition
```

When the macro is invoked, it expands into:
```asm
abc         xmac    subr1,de    ; Macro invocation
; Below this line is what the macro is expanded into
            ; Code
abcloop1    ; Code
            ; Code
            BGE     abcloop1
abcloop2    ; Code
            BL      subr1
            BGT     abcloop2
            ; Code
            ADR     de
            ; Code
```

== `AREA`
<area-directive>
```asm
AREA section_name{, attribute_1, attribute_2, ...}
```

The `AREA` directive instructs the assembler to assemble a new code or data
section.
- `section_name` is the name of the section, which can be anything.
- `attribute_1, attribute_2, ...` are the section attributes in ARM.

=== Valid section attributes
#align(center)[#table(
    align: left,
    columns: 2,
    table.header([*Attribute*], [*Description*]),

    [`ALIGN`=_expr_],
    [This aligns a section on a 2 _expr_-byte boundary. Note that this is
        different from the `ALIGN` directive. For example, if _expr_ = 10, then
        the section is aligned to a 1 KB boundary.],

    [`CODE`], [This section is machine code (`READONLY` is the default).],
    [`DATA`], [This section is data (`READWRITE` is the default).],

    [`READONLY`],
    [This section can be placed in read-only memory (default for sections of
        `CODE`).],

    [`READWRITE`],
    [This section can be placed in read-write memory (default for sections of
        `DATA`).],
)]

=== Example
Defines new code (`CODE`) section called `main` which is read-only (`READONLY`).
```asm
AREA main, CODE, READONLY
```

== `ENTRY` and `END`
```asm
ENTRY
; Code
END
```

- The `ENTRY` directive specifies the entry point of the program.
- In simpler terms, it tells the computer which part of the code to start
    executing from when running the program.
- All programs must have an entry point.
- If the program contains multiple entry points, you must select one of them by
    exporting the symbol for the `ENTRY` directive that you want to use as the
    entry point.

=== Example
```asm
        AREA    ARMex, CODE, READONLY

        ; Entry point for the application
        ENTRY

        ; Export the symbol so the linker can find it
        ; in the object file.
        EXPORT Start
Start
        ; Code
        END
```

// Function to generate the documentation for all the declare directives
#let dc_docs(bits) = {
    let last_char
    let memory_type_singular
    let memory_type
    if bits == 8 {
        last_char = "B"
        memory_type_singular = "byte"
        memory_type = "bytes"
    } else if bits == 16 {
        last_char = "W"
        memory_type_singular = "half-word"
        memory_type = "half-words"
    } else if bits == 32 {
        last_char = "D"
        memory_type_singular = "word"
        memory_type = "words"
    }
    let instruction = "DC" + last_char
    let bytes = bits / 8
    let bit_string = str(bits) + "-bit"
    let byte_string = str(bytes) + "-byte"
    [
        == #raw(instruction) (Declare #bit_string #memory_type)
        #raw(
            lang: "asm",
            (
                "{label} ",
                instruction,
                "{U} value_1{, value_2, value_3, ...}",
            ).join(""),
        )
        - The #raw(instruction) directive allocates one or more #memory_type
            (#bit_string value for ARM), aligned on #byte_string (#bit_string)
            boundaries.
        - It also initialises the memory with the value given to it, `value_1`.
        - `{, value_2, value_3, ...}` are additional values to be initialised.
        - `{label}` is an optional label to place the initialised memory in.
        - `{U}` is an optional suffix that tells the assembler to *not* align
            the memory on #byte_string (#bit_string) boundaries.


        === Example 1
        Define 3 #memory_type (#bit_string values) in the `data1` section, the
        first containing the decimal value 1, the next containing the decimal
        value 5, and the last one containing the decimal value 20.

        #raw(("data1", instruction, "1, 5, 20").join(" "), lang: "asm")

        === Example 2
        Define 1 #memory_type_singular (#bit_string value) in the `data2`
        section, containing `4 + the address of the label mem06`. Essentially,
        the #memory_type initialised will contain the memory address in the
        label `mem06` offset by 4.

        #raw(("data2", instruction, "mem06 + 4").join(" "), lang: "asm")

        === Example 3
        Define 3 #memory_type (#bit_string values) in the `data1` section, the
        first containing the decimal value 1, the next containing the decimal
        value 5, and the last one containing the decimal value 20. However, the
        memory is not aligned to #memory_type boundaries (#byte_string or
        #bit_string boundaries).

        #raw(("data3", instruction, "1, 5, 20").join(" "), lang: "asm")
    ]
}

#dc_docs(8)
#pagebreak()

#dc_docs(16)
#pagebreak()

#dc_docs(32)
#pagebreak()

== `ALIGN`
```asm
ALIGN {byte_boundary_size{, offset}}
```

The `ALIGN` directive aligns the current location within the code to a word
(4-byte or 32-bit) boundary.
- `byte_boundary_size` is the size of the next byte boundary to align the
    current location on. It can be any power of 2 from 2 to 2#super[31], and the
    current location will be aligned to the next 2#super[n]-byte boundary. If
    this parameter is not given, the instruction location will be set to the
    next word boundary.
- `offset` is optional, and is the byte offset from the alignment given in
    `byte_boundary_size`.
- Note that the current location in bytes is given by (`offset` + n #sym.times
    `byte_boundary_size`), where n is the constant needed to get to the next
    `byte_boundary_size` boundary

=== Example 1
```asm
        AREA    cacheable, CODE, ALIGN=3
rout1   ; Code      ; Aligned on 8-byte boundary
        ; Code
        MOV pc, lr  ; Aligned only on 4-byte boundary
        ALIGN 8     ; Now aligned on 8-byte boundary
rout2   ; Code
```

=== Example 2
```asm
AREA    OffsetExample, CODE

; Place 1 byte at the start.
; Let's call this byte 1.
DCB     1

; Offset 3 bytes from the current location,
; then align on the next 4-byte boundary.
ALIGN   4, 3

; Current location is now 3 bytes away
; from the very first byte or byte 1.
;
; The first 3 bytes come from the offset given
; to the ALIGN directive, which is 3-bytes away
; from the boundary, so the current location is at byte 4.
;
; Byte 4 is the start of a 4-byte boundary,
; so it is already at the next word boundary to align on,
; and there is nothing else to do.
; There is no need to move to the next 4-byte boundary.
;
; Hence, the second byte from the second DCB directive
; is placed at byte 4, or 3 bytes away from the very first byte.
DCB     1
```

Below is an image to illustrate the alignment.
#cimage("./images/align-offset-example.png", height: 6em)

== `SPACE`
<space-directive>
```asm
{label} SPACE bytes
```

The `SPACE` directive reserves a zeroed block or memory, which is basically just
setting the block of memory to 0.
- `{label}` is an optional label to place the memory in.
- `bytes` is the number of bytes of memory to zero.

=== Example
Fill 255 bytes of memory with 0.
```asm
SPACE 255
```

== `FILL`
```asm
{label} FILL bytes{, value{, value_size_in_bytes}}
```

The `FILL` directive is similar to the #link(<space-directive>)[`SPACE`
    directive], but it fills the memory with the given `value` instead of
`zero`.
- `{label}` is an optional label to place the memory in.
- `bytes` is the number of bytes of memory to fill up with the `value`.
- `value` is the value used to fill the memory with, and it is optional as it
    will default to 0 if not given.
- `value_size_in_bytes` is the size of the `value` given in bytes, and is
    optional.

=== Example
Fill 50 bytes of memory with the hexadecimal value 0xAB, which is 1 byte in
size.
```asm
FILL 50, 0xAB, 1
```

#pagebreak()

== `LTORG` (Lookup table organised)
```asm
LTORG
```

- The `LTORG` directive instructs the assembler to assemble the current literal
    pool immediately.
- The assembler assembles the current literal pool at the end of every code
    section.
- The end of a code section is determined by the #link(<area-directive>)[`AREA`]
    directive at the beginning of the following section, or the end of the
    assembly.
- A literal pool is a lookup table used to hold literals during assembly and
    execution.
- The assembler uses literal pools to store some constant data in code sections.
- The literal pool is part of the working memory of a function, but only the
    constant data in the function.
- The purpose of this function is because some code sections are very long, so
    the memory addresses to those constants might be out of range of the #link(
        <ldr-instruction>,
    )[`LDR` instruction], so the `LTORG` directive is used to keep those memory
    addresses in range.

=== Example
```asm
        AREA    Example, CODE, READONLY
start   BL      func1
func1                           ; Function body
        ; Code

        ; Load into register R1, the memory address of the first literal pool
        ; LDR R1, [pc, #offset to Literal Pool 1]
        LDR     R1,=0x55555555
        ; Code
        MOV     pc,lr           ; End function

        ; Literal Pool 1 contains literal &55555555.
        LTORG

        ; Clears 4200 bytes of memory starting at current location.
data    SPACE   4200

        ; Default literal pool is empty.
        END
```

#pagebreak()

== `EXPORT` or `GLOBAL`
```asm
EXPORT symbol {[qualifer{, qualifier}{, qualifier}]}
```

- The `EXPORT` directive declares a symbol that be used by the linker to resolve
    symbol references in separate object and library files.
- `GLOBAL` is a synonym for `EXPORT`.
- `symbol` is the symbol name to export, which is case-sensitive.
- `qualifier` be any of:
    - `FPREGARGS`, which means that `symbol` refers to a function that expects
        floating-point arguments to be passed in floating-point registers.
    - `DATA`, which means that `symbol` refers to a data location rather than a
        function or a procedure entry point.
    - `LEAF`, which denotes that the exported function is a leaf function that
        calls no other functions. This qualifier is obsolete.

=== Example
Export the function name `DoAdd` to be used by external modules.
```asm
        AREA    Example, CODE, READONLY
        EXPORT  DoAdd
DoAdd   ADD     R0, R1, R2
```

== `IMPORT` or `EXTERN`
```asm
IMPORT symbol {[qualifer{, qualifier}]}
```

- The `IMPORT` directive provides the assembler with a name that is not defined
    in the current assembly.
- `EXTERN` is a synonym for `IMPORT`.
- `symbol` is a symbol name defined in a separately assembled source file,
    object file, or library. The symbol name is case-sensitive.
- `qualifier` can be any of:
    - `FPREGARGS`, which means that `symbol` defines a function that expects
        floating-point arguments passed in floating-point registers.
    - `WEAK`, which prevents the linker from generating an error message if the
        symbol is not defined elsewhere. It also prevents the linker from
        searching libraries that are not already included.

=== Example
Test if a C++ library has been linked, and branches conditionally on the result.
```asm
        AREA    Example, CODE, READONLY
        IMPORT  __CPP_INITIALISE[WEAK]

        LDR R0, __CPP_INITIALISE

        CMP R0, #0
        BEQ nocplusplus
```

#pagebreak()

== `GET` or `INCLUDE`
```asm
GET filename
```

- The `GET` directive includes a file within the file being assembled. The
    included file is assembled.
- `INCLUDE` is a synonym for `GET`.
- `filename` is the name of the file to be included in the assembly. The
    assembler accepts path names in either UNIX or MS-DOS format.

=== Example
Includes `file_1.s` if it exists in the current place, and also include
`file_2.s` from the path given.
```asm
        AREA    Example, CODE, READONLY
        GET     file_1.s

        GET     C:\Project\file_2.s
```

== Other directives offered by ARM Keil
#align(center)[#table(
    align: left,
    columns: 2,
    table.header([*Directive*], [*Description*]),
    [`A:MOD:B`], [`A modulo B` or `A % B`.],
    [`A:ROL:B`], [Rotate A left by B bits.],
    [`A:ROR:B`], [Rotate A right by B bits.],
    [`A:SHL:B` or `A << B`], [Shift A left by B bits.],
    [`A:SHR:B` or `A >> B`], [Shift A right by B bits.],
    [`A + B`], [Add A to B],
    [`A - B`], [Subtract B from A],
    [`A:AND:B`], [Bitwise AND of A and B],
    [`A:EOR:B`], [Bitwise Exclusive OR of A and B],
    [`A:OR:B`], [Bitwise OR of A and B],
)]
