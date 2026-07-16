# OpenSim

OpenSim is an open source alternative to [SimPholders](https://simpholders.com), written in Swift.

This fork adds a simulator-level **Reveal Files App Storage in Finder** action, making it easy to open the selected simulator's Files app storage from the menu bar.

## Build and Run

This fork is not distributed through Homebrew. The existing [`opensim` Homebrew cask](https://formulae.brew.sh/cask/opensim) points to the original project and is currently disabled.

To build and launch this fork from source, install Xcode and run:

```bash
git clone https://github.com/NSErfan/OpenSim.git
cd OpenSim
./script/build_and_run.sh
```

Alternatively, open `OpenSim.xcodeproj` in Xcode and run the `OpenSim` scheme.

## TODO

- [x] Parsing results from `xcrun` command rather than `device_set.plist` file (thank @bradvandyk)
- [x] Watch for changes from simulators directory and reload dynamically
- [x] Filter out empty simulators
- [x] Better UI
- [ ] Other functionalities like uninstalling apps or resetting data
