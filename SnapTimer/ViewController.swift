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

	@IBAction func animatedAction(sender: AnyObject) {
//		self.snapTimerView.outerValue = 0
//		print("\(NSDate())")
		self.snapTimerView.animateOuterToValue(50, duration: 10) {
			puts("Termino inner!")
			puts("\(NSThread.isMainThread())")
			print("\(NSDate())")
		}
		
//		self.snapTimerView.innerValue = 50
		self.snapTimerView.animateInnerToValue(100, duration: 10) {
			puts("Termino outer!")
			puts("\(NSThread.isMainThread())")
			print("\(NSDate())")
		}
	}
	
	@IBAction func notAnimatedAction(sender: AnyObject) {
		self.snapTimerView.outerValue = 0
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.snapTimerView.innerValue = 0
//		UIView.animateWithDuration(10, delay: 0, options: [], animations: {
//				self.snapTimerView.innerValue = 10
//			}, completion: nil)
		
		
	}

	@IBAction func changeColor(sender: AnyObject) {
//		self.snapTimerView.centerBackgroundColor = UIColor.blueColor()
//		self.snapTimerView.borderBackgroundColor = UIColor.purpleColor()
		self.snapTimerView.innerValue = 100
	}
	
	@IBAction func changeInner(sender: UISlider) {
		self.snapTimerView.innerValue = CGFloat(sender.value)
		self.innerValue.text = String(sender.value)
	}
	
	@IBAction func changeOuter(sender: UISlider) {
		self.snapTimerView.outerValue = CGFloat(sender.value)
	}
	
}

