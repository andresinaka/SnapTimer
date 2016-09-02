//
//  ViewController.swift
//  SnapTimer
//
//  Created by Andres on 8/18/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var snapTimerView: SnapTimerView!
	@IBOutlet weak var innerValue: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func animatedAction(sender: AnyObject) {

		self.snapTimerView.outerValue = 0
		self.snapTimerView.animateOuterToValue(50, duration: 30) {
			puts("Termino outer!")
			puts("\(self.snapTimerView.outerValue)")
		}

		self.snapTimerView.innerValue = 50
		self.snapTimerView.animateInnerToValue(100, duration: 30) {
			puts("Termino outer!")
		}
	}

	@IBAction func notAnimatedAction(sender: AnyObject) {
		self.snapTimerView.outerValue = 0
	}

	@IBAction func changeColor(sender: AnyObject) {
		self.snapTimerView.centerBackgroundColor = UIColor.yellowColor()
		self.snapTimerView.borderBackgroundColor = UIColor.orangeColor()
		self.snapTimerView.mainBackgroundColor = UIColor.blueColor()
	}

	@IBAction func changeInner(sender: UISlider) {
		self.snapTimerView.animateInnerValue(CGFloat(sender.value))
		self.innerValue.text = String(sender.value)
	}

	@IBAction func changeOuter(sender: UISlider) {
		self.snapTimerView.animateOuterValue(CGFloat(sender.value))
	}
}
