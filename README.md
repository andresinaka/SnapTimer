![SnapTimer](snapTimer-logo.png)

# SnapTimer

SnapTimer is a custom UIView that behaves exactly the same as the one on Snapchat's stories. 

[![Build Status](https://travis-ci.org/andresinaka/SnapTimer.svg)](https://travis-ci.org/andresinaka/SnapTimer) [![codecov.io](https://codecov.io/github/andresinaka/SnapTimer/badge.svg?branch=master)](https://codecov.io/github/andresinaka/SnapTimer?branch=master)

## Features

- Two different timers, 'outer' and 'inner'.
- Independent animations for each of the timers.
- Completion handlers.
- Fully Swift.

# What does it look like?

> A picture is worth a thousand words

![samples](sample-timers.png)

# Installation

You can just clone the repo and copy the ```SnapTimer``` folder to your project or you can use one of the following options:
 
### Setting up with [CocoaPods](http://cocoapods.org/)

```
pod 'SnapTimer'
```

Then:

``` 
import SnapTimer
```

And you are all set! 

### Setting up with [Carthage](https://github.com/Carthage/Carthage)

- TODO

# How do I add it?

1. Add a `UIView` to your Storyboard.
2. Select the view, go to the `Identity Inspector` and set the class to `SnapTimerView`
 
    ![identity-inspector](identity-inspector.png)

3. Create an `@IBOutlet` in your view controller and that's it.
 
    `SnapTimerView` implements `@IBDesignable` so the view should automatically render in your Interface Builder. Also it implements `@IBInspectable` for the view properties:

   ![properties](properties.png)

4. That's it!

