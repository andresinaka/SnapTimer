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
	@IBOutlet weak var randomSnapTimer: SnapTimerView!
	@IBOutlet weak var animSnapTimer: SnapTimerView!
	@IBOutlet weak var animSnapTimer2: SnapTimerView!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func randomInnerAction(_ sender: AnyObject) {
		self.randomSnapTimer.innerValue = CGFloat(arc4random_uniform(100))
	}

	@IBAction func randomOuterAction(_ sender: AnyObject) {
		self.randomSnapTimer.outerValue = CGFloat(arc4random_uniform(100))
	}

	@IBAction func animInnerAction(_ sender: AnyObject) {
		self.animSnapTimer.animateInnerValue(CGFloat(arc4random_uniform(100)))
	}

	@IBAction func animOuterAction(_ sender: AnyObject) {
		self.animSnapTimer.animateOuterValue(CGFloat(arc4random_uniform(100)))
	}

	@IBAction func changeInner(_ sender: UISlider) {
		self.animSnapTimer2.animateInnerValue(CGFloat(sender.value))
	}

	@IBAction func changeOuter(_ sender: UISlider) {
		self.animSnapTimer2.animateOuterValue(CGFloat(sender.value))
	}

	@IBAction func animateBoth(_ sender: AnyObject) {

		self.randomSnapTimer.animateOuterValue(CGFloat(arc4random_uniform(100)))
		self.randomSnapTimer.animateInnerValue(CGFloat(arc4random_uniform(100)))

		self.animSnapTimer.animateOuterValue(CGFloat(arc4random_uniform(100)))
		self.animSnapTimer.animateInnerValue(CGFloat(arc4random_uniform(100)))

		self.animSnapTimer2.animateOuterValue(CGFloat(arc4random_uniform(100)))
		self.animSnapTimer2.animateInnerValue(CGFloat(arc4random_uniform(100)))

	}

	@IBAction func changeColor(_ sender: AnyObject) {
		var borderColor = UIColor.white
		var centerColor = UIColor.lightGray
		var mainColor = UIColor.darkGray

		if self.randomSnapTimer.borderBackgroundColor == borderColor {
			mainColor = UIColor(red: 217/255,
			                  green: 108/255,
			                   blue: 6/255,
			                  alpha: 4)

			centerColor = UIColor(red: 189/255,
			                    green: 191/255,
			                     blue: 9/255,
			                    alpha: 4)

			borderColor = UIColor(red: 34/255,
			                    green: 146/255,
			                     blue: 164/255,
			                    alpha: 4)
		}

		self.randomSnapTimer.mainBackgroundColor = mainColor
		self.randomSnapTimer.centerBackgroundColor = centerColor
		self.randomSnapTimer.borderBackgroundColor = borderColor

		self.animSnapTimer.mainBackgroundColor = mainColor
		self.animSnapTimer.centerBackgroundColor = centerColor
		self.animSnapTimer.borderBackgroundColor = borderColor

		self.animSnapTimer2.mainBackgroundColor = mainColor
		self.animSnapTimer2.centerBackgroundColor = centerColor
		self.animSnapTimer2.borderBackgroundColor = borderColor
	}


}
