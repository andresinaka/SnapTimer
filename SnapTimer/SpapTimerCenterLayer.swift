//
//  SpapTimerCenterLayer.swift
//  SnapTimer
//
//  Created by Andres on 8/23/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit

class SpapTimerCenterLayer: CALayer {
	
	let maxEndAngle = 7/2 * CGFloat(M_PI)
	
	@NSManaged var circleColor: CGColor
	@NSManaged var startAngle: CGFloat

	override init(layer: AnyObject) {
		super.init(layer: layer)
		if let layer = layer as? SpapTimerCenterLayer {
			startAngle = layer.startAngle
			circleColor = layer.circleColor
		} else {
			startAngle = 0
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init() {
		super.init()
	}
	
	func animation(key: String) -> CAAnimation{
		let animation = CABasicAnimation(keyPath: key)
		
		if let pLayer = self.presentationLayer() as? SpapTimerCenterLayer,
			value = pLayer.valueForKey(key) {
			animation.fromValue = value
		}
		puts ("Disabled: \(CATransaction.disableActions())")
		puts ("Duration: \(CATransaction.animationDuration())")
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		animation.duration = 0.5
		return animation
	}
	
	override func actionForKey(key: String) -> CAAction? {
		if key == "startAngle" {
			return self.animation(key)
		}
		return super.actionForKey(key)
	}

	override class func needsDisplayForKey(key: String) -> Bool{
		if key == "startAngle" || key == "circleColor" {
			return true;
		}
		return super.needsDisplayForKey(key)
	}
	
	override func drawInContext(ctx: CGContext) {
		let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
		let radius = min(bounds.width, bounds.height) * 0.5

		CGContextBeginPath(ctx)
		CGContextSetLineWidth(ctx, 0);

		CGContextMoveToPoint(ctx, center.x, center.y)
		CGContextAddArc(ctx, center.x, center.y, radius/2, self.startAngle, maxEndAngle, 0)

		CGContextSetFillColorWithColor(ctx, self.circleColor);
		CGContextDrawPath(ctx, .FillStroke);

	}
}
