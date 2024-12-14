# Arduino Cone Layer

The code for the cone layer written in the Rust programming language.
The Arduino used for this project is the
[Arduino Mega 2560 Rev 3](https://store.arduino.cc/products/arduino-mega-2560-rev3).

## Installing prerequisite software

### Windows

1. Install rustup from the website using the installer for Windows [here](https://rustup.rs/).
2. Press <kbd>⊞ Win</kbd> + <kbd>R</kbd> to open the run dialogue
   and type "powershell" without the double quotes into the text box
   and press <kbd>Enter</kbd> to open Windows PowerShell.
3. Copy and paste the command below to install [Scoop](https://scoop.sh/).
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Needed to run a remote script the first time
   irm get.scoop.sh | iex
   ```
4. Run the commands below to install `avr-gcc` and `avrdude`.
   ```powershell
   scoop install avr-gcc
   scoop install avrdude
   ```

### macOS

1. Open up the terminal and run the command below to install rustup.
   ```sh
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
2. Install [Homebrew](https://brew.sh/) using the command below:
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. Set up the [`homebrew-avr`](https://github.com/osx-cross/homebrew-avr)
   tap by running the commands below:
   ```sh
   xcode-select --install  # for the fist time
   brew tap osx-cross/avr
   brew install avr-binutils avr-gcc avrdude
   ```

### Linux

1. Use your package manager to install `avr-gcc` (`gcc-avr`) and `avrdude`.

   For Arch-based distributions:

   ```sh
   sudo pacman -S avr-gcc avrdude
   ```

   For Debian-based distributions (Ubuntu, Linux Mint, etc.):

   ```sh
   sudo apt install avr-libc gcc-avr pkg-config avrdude libudev-dev build-essential
   ```

## Installation of Rust components

1. Use the command below to install the nightly toolchain for Rust:

   ```sh
   rustup toolchain install nightly-2024-07-25
   ```

   Currently, because of [this issue](https://github.com/Rahix/avr-hal/issues/571),
   the nightly compiler version is pinned to
   `rustc 1.82.0-nightly (c1a6199e9 2024-07-24)`.

2. Install `ravedude` using the command below:
   ```sh
   cargo +stable install ravedude
   ```

## Getting the source files
You can download the source files as a `.zip` file from this
[link](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2Fhankertrix%2FUni-Stuff%2Ftree%2Fmain%2Fy1-special-term%2Fps5888-making-and-tinkering%2Farduino-cone-layer).
You should rename the file to something shorter and more readable,
like `arduino-cone-layer` for example.

Alternatively, if you have [`git`](https://git-scm.com/) installed,
navigate into the directory you want to clone the repository to and
run either of the commands below:

To clone the repository from GitHub:
```sh
git clone --depth 1 https://github.com/hankertrix/Uni-Stuff arduino-cone-layer
cd arduino-cone-layer
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch --prune-empty --subdirectory-filter y1-special-term/ps5888-making-and-tinkering/arduino-cone-layer/ HEAD
```

To clone the repository from Codeberg:
```sh
git clone --depth 1 https://codeberg.org/Hanker/Uni-Stuff arduino-cone-layer
cd arduino-cone-layer
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch --prune-empty --subdirectory-filter y1-special-term/ps5888-making-and-tinkering/arduino-cone-layer/ HEAD
```

## Building the project
Run `cargo build` to build the firmware for the Arduino.

## Loading the project into an Arduino
With the Arduino Mega 2560 Rev 3 connected to your computer,
run the `cargo run` command to flash the firmware to the
Arduino.

If `ravedude` fails to detect the board, check its documentation
[here](https://crates.io/crates/ravedude). You will most likely
need to modify the `config.toml` file in the `.cargo` folder
to get the `ravedude` command to detect the board.
This usually only happens when the board is not a genuine Arduino board.

`ravedude` will open a console session after flashing the firmware
where you can interact with the USART0 console of the Arduino board.

## Licence

This project is licenced under the [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.en.html).
You can view the full licence text in the `LICENCE.txt` file.
