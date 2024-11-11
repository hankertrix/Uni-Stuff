# Cone Layer Controller

The code for the phone application to
control the Arduino Cone Layer using Bluetooth,
written in the TypeScript programming language.

## Getting the source files

You can download the source files as a `.zip` file from this
[link](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2Fhankertrix%2FUni-Stuff%2Ftree%2Fmain%2Fy1-special-term%2Fps5888-making-and-tinkering-cy2003-research-attachment-3%2Fcone-layer-controller).
You should rename the file to something shorter and more readable,
like `cone-layer-controller` for example.

Otherwise, you can use one of the commands
below to clone the repository if you have `git` installed.

To clone from the GitHub repository:

```sh
git clone --depth 1 https://github.com/hankertrix/Uni-Stuff cone-layer-controller
cd cone-layer-controller
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch --prune-empty --subdirectory-filter y1-special-term/ps5888-making-and-tinkering/cone-layer-controller/ HEAD
```

To clone from the Codeberg repository:

```sh
git clone --depth 1 https://codeberg.org/Hanker/Uni-Stuff cone-layer-controller
cd cone-layer-controller
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch --prune-empty --subdirectory-filter y1-special-term/ps5888-making-and-tinkering/cone-layer-controller/ HEAD
```

## Installing `npm`

### Windows

You can install Node.js using this
[link](https://nodejs.org/en/#download).
It comes with `npm`.

### macOS

You can install Node.js using Homebrew
using the command below:

```sh
brew install node
```

If you don't have Homebrew installed,
install it by running this command in your terminal:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Linux

Use your package manager to install `npm`:

- For Arch-based distributions:

  ```sh
  sudo pacman -S npm
  ```

- For Debian-based distributions:

  ```sh
  sudo apt install npm
  ```

## Building the application

### Building the application for both iOS and Android using `eas`

You will need an [Expo](https://expo.dev) account for this.
To successfully build the iOS version of the app,
an Apple account that has been enrolled in the
[Apple Developer Program](https://developer.apple.com/enroll/)
is required, which costs $148 SGD a year.

Run the command below to log in to EAS:

```sh
npx eas login
```

Run the command below to build the application using EAS:

```sh
npx eas build
```

### Building the iOS version using Xcode

1. Run the command below to pre-build
   parts of the application.

   ```sh
   npx expo prebuild
   ```

2. You will likely be prompted to install `expo`,
   so just install it and let it run.

3. Now, you can either use `npm`
   to run `pod install`, like so:

   ```sh
   npx pod-install
   ```

   Or just run `pod install` directly
   when you are inside the project folder,
   which should be `cone-layer-controller`:

   ```sh
   cd ios
   pod install
   ```

4. Open the `ios` folder in Xcode by
   looking for the `.xcworkspace` file
   extension inside the folder and
   double-clicking it.

5. You might be prompted to verify
   your signing and capabilities settings,
   so you should just tick
   "Automatically manage signing" to leave
   certificate signing to Xcode.

6. Find the "Product" menu in the menu bar
   and select "Archive". You might see quite
   a few warnings, but that should be fine.

7. After archiving is done, you should get a pop-up
   where you can choose to export the application or
   distribute it to the App Store.

# Licence
This project is licenced under the GNU AGPL v3.
You can view the `LICENCE.txt` file for the full
licence text.

# Privacy
This application doesn't collect any user data.
