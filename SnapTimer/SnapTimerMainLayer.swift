//
//  SnapTimerMainLayer.swift
//  SnapTimer
//
//  Created by Andres on 8/28/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit

class SnapTimerMainLayer: CALayer {
	@NSManaged var circleColor: CGColor

	override init(layer: AnyObject) {
		super.init(layer: layer)
		if let layer = layer as? SnapTimerBorderLayer {
			circleColor = layer.circleColor
		} else {
			circleColor = UIColor.darkGrayColor().CGColor
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init() {
		super.init()
	}

	override class func needsDisplayForKey(key: String) -> Bool{
		if key == "circleColor" {
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
		CGContextAddArc(ctx, center.x, center.y, radius, SnapTimerView.startAngle, SnapTimerView.endAngle, 0)
		
		CGContextSetFillColorWithColor(ctx, self.circleColor);
		CGContextDrawPath(ctx, .FillStroke);
	}
}
