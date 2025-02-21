# WheelFree

A [Hammerspoon](http://www.hammerspoon.org) ["Spoon"](https://github.com/Hammerspoon/hammerspoon/blob/master/SPOONS.md) to enable scrolling with wheel-free mice.

**Motivation:** I like three button mice, and many good options don't have scroll wheels. My current favorite is the [ELECOM](https://en.wikipedia.org/wiki/Elecom) [3D CAD Mouse](https://elecomusa.com/products/3d-cad-mouse-1).

## Installation

After [installing and setting up](http://www.hammerspoon.org/go/) Hammerspoon:

1. Download and unzip [WheelFree.spoon.zip](WheelFree.spoon.zip).
2. Install using one of these methods:
    * Double-click `WheelFree.spoon` to let Hammerspoon handle installation, or 
    * Copy `WheelFree.spoon` to your Spoons directory
3. Add this line to your Hammerspoon config: `hs.loadSpoon("WheelFree"):start()`
4. Reload your Hammerspoon configuration

For more details about Spoons installation and configuration paths, see the [Hammerspoon Spoon Documentation](https://github.com/Hammerspoon/hammerspoon/blob/master/SPOONS.md).

## Use

Press and hold the middle mouse button. Move your mouse up/down or left/right to scroll vertically or horizontally. Release the button to stop scrolling. 

A simple click (press and release) of the middle mouse button behaves normally.

## Notes

**1. Compatibility**

This Spoon has been tested primarily with standard macOS desktop applications and [the Acme editor](https://en.wikipedia.org/wiki/Acme_(text_editor)). I have no idea whether this (or Hammerspoon in general) works with games and more specialized capplications (e.g. CAD software).

**2. Alternative Installation**

You can create a symbolic link from your Spoons directory to the WheelFree.spoon package:

```
$ cd $HOME/.hammerspoon/Spoons && ln -s /path/to/WheelFree.spoon
```

Hammerspoon seems to handle this fine, but it is not one of the documented installation methods.
