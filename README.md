![SnapTimer](images/snaptimer-logo.png)

# SnapTimer

SnapTimer is a custom UIView that behaves exactly the same as the one on Snapchat's stories. 

[![Build Status](https://travis-ci.org/andresinaka/SnapTimer.svg?branch=master)](https://travis-ci.org/andresinaka/SnapTimer) [![codecov.io](https://codecov.io/github/andresinaka/SnapTimer/badge.svg?branch=master)](https://codecov.io/github/andresinaka/SnapTimer?branch=master)

```
Swift 3.0 Support on master branch! 👌👌 
Swift 2.3 Support on Swift2.3.
```

## Features

- Two different timers, 'outer' and 'inner'.
- Independent animations for each of the timers.
- Customizable colors.
- Completion handlers.
- Fully Swift.

# What does it look like?

> A picture is worth a thousand words

![samples](images/sample-timers.png)

# Installation

You can just clone the repo and copy the ```SnapTimer``` folder to your project or you can use one of the following options:
 
### Setting up with [CocoaPods](http://cocoapods.org/)

```ruby
pod 'SnapTimer'
```

Then:

```swift
import SnapTimer
```

And you are all set! 

### Setting up with [Carthage](https://github.com/Carthage/Carthage)

- TODO

# How do I add it?

1. Add a `UIView` to your Storyboard.
2. Select the view, go to the `Identity Inspector` and set the class to `SnapTimerView`
 
    ![identity-inspector](images/identity-inspector.png)

3. Create an `@IBOutlet` in your view controller and that's it.
 
    `SnapTimerView` implements `@IBDesignable` so the view should automatically render in your Interface Builder. Also it implements `@IBInspectable` for the view properties:

   ![properties](images/properties.png)

4. That's it!

### Setting inner and outer values

**innerValue** and **outerValue** ranges go from 0 to 100.

* To set values without animations you just have to:

    ```swift
self.snapTimerView.outerValue = 25
self.snapTimerView.innerValue = 50
```
   ![ej1](images/ej1.gif)

* To animate values:

    ```swift
self.snapTimerView.animateOuterValue(50)
self.snapTimerView.animateInnerValue(25)
```
   ![ej1](images/ej2.gif)

* To animate values setting the time and a completion handler:

  ```swift
  self.snapTimerView.animateOuterToValue(50, duration: 30) {
	  puts("Done!")
  }
 
  self.snapTimerView.animateInnerToValue(100, duration: 30) {
	  puts("Done!")
  }
  ```
 
### Pausing and resuming animations:

if your app goes to background or the Notifications/Control center are opened you may want to pause the animations, to do that SnapTimer has two handy methods:

```swift
self.snapTimerView.resumeAnimation()
self.snapTimerView.pauseAnimation()
```

# Check the sample project!

![samples](images/ej3.gif)

# Cool ways to improve it?

Hey, If you have cool ideas to add to this please feel free to send a PR! Also if you are using this in your app and what to let me know I'll be happy to add a section here with the apps currently using this!
