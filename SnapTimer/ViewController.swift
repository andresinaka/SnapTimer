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

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.snapTimerView.innerValue = 0

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
			
			UIView.animateWithDuration(10, delay: 3, options: [], animations: {
				self.snapTimerView.innerValue = 10
				}, completion: nil)
		}
		
		
	
	}

	@IBAction func changeInner(sender: UISlider) {
		self.snapTimerView.innerValue = CGFloat(sender.value)
	}
	
	@IBAction func changeOuter(sender: UISlider) {
		self.snapTimerView.outerValue = CGFloat(sender.value)
	}
	
}

