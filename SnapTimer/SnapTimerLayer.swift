//
//  SnapTimerLayer.swift
//  SnapTimer
//
//  Created by Andres on 8/20/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit

class SnapTimerLayer: CALayer {
	@NSManaged var innerValue: CGFloat
	@NSManaged var outerValue: CGFloat

	override init() {
		super.init()
		self.innerValue = 0
		self.outerValue = 0
	}

	override func actionForKey(key: String) -> CAAction? {
		if key == "innerValue" || key == "outerValue" {
			print("aminarse deberia")
		}
		return super.actionForKey(key)
	}
	
	override init(layer: AnyObject) {
		super.init(layer: layer)
		if let snapTimerLayer = layer as? SnapTimerLayer {
			self.innerValue = snapTimerLayer.innerValue
			self.outerValue = snapTimerLayer.outerValue
		} else {
			self.innerValue = 0
			self.outerValue = 0
		}
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.innerValue = 0
		self.outerValue = 0
	}

	override class func needsDisplayForKey(key: String) -> Bool{
		if key == "innerValue" || key == "outerValue" {
			return true;
		}
		return super.needsDisplayForKey(key)
	}
}
