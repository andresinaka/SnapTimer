//
//  SnapTimerBorderLayer.swift
//  SnapTimer
//
//  Created by Andres on 8/28/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit

class SnapTimerBorderLayer: CALayer {
	@NSManaged var circleColor: CGColor
	@NSManaged var startAngle: CGFloat
	@NSManaged var radius: CGFloat
	@NSManaged var width: CGFloat

	override init(layer: AnyObject) {
		super.init(layer: layer)
		if let layer = layer as? SnapTimerBorderLayer {
			startAngle = layer.startAngle
			circleColor = layer.circleColor
		} else {
			startAngle = 0
			circleColor = UIColor.whiteColor().CGColor
		}
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override init() {
		super.init()
	}

	func animation(key: String) -> CAAnimation {
		let animation = CABasicAnimation(keyPath: key)

		if let pLayer = self.presentationLayer(), value = pLayer.valueForKey(key) {
			animation.fromValue = value
		}

		let animationTiming = CATransaction.animationTimingFunction() ?? CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		let duration = CATransaction.animationDuration() ?? 0
		animation.timingFunction = animationTiming
		animation.duration = duration
		return animation
	}

	override func actionForKey(key: String) -> CAAction? {
		if key == "startAngle" {
			return self.animation(key)
		}
		return super.actionForKey(key)
	}

	override class func needsDisplayForKey(key: String) -> Bool {
		if key == "startAngle" || key == "circleColor" || key == "radius" ||
			key == "borderWidth" {
			return true
		}
		return super.needsDisplayForKey(key)
	}

	override func drawInContext(ctx: CGContext) {
		let center = CGPoint(x:bounds.width/2, y: bounds.height/2)

		CGContextBeginPath(ctx)
		CGContextSetStrokeColorWithColor(ctx, self.circleColor)
		CGContextSetLineWidth(ctx, self.width)
		CGContextAddArc(ctx, center.x, center.y, self.radius, self.startAngle, SnapTimerView.endAngle, 0)
		CGContextDrawPath(ctx, .Stroke)
	}
}
