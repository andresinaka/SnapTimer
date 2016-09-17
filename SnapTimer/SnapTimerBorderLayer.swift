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

	override init(layer: Any) {
		super.init(layer: layer)
		if let layer = layer as? SnapTimerBorderLayer {
			startAngle = layer.startAngle
			circleColor = layer.circleColor
		} else {
			startAngle = 0
			circleColor = UIColor.white.cgColor
		}
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override init() {
		super.init()
	}

	func animation(_ key: String) -> CAAnimation {
		let animation = CABasicAnimation(keyPath: key)

		if let pLayer = self.presentation(),
			let value = pLayer.value(forKey: key) {
			animation.fromValue = value
		}

		let animationTiming = CATransaction.animationTimingFunction() ?? CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		let duration = CATransaction.animationDuration()
		animation.timingFunction = animationTiming
		animation.duration = duration
		return animation
	}

	override func action(forKey key: String) -> CAAction? {
		if key == "startAngle" {
			return self.animation(key)
		}
		return super.action(forKey: key)
	}

	override class func needsDisplay(forKey key: String) -> Bool {
		if key == "startAngle" || key == "circleColor" || key == "radius" ||
			key == "borderWidth" {
			return true
		}
		return super.needsDisplay(forKey: key)
	}

	override func draw(in ctx: CGContext) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        ctx.beginPath()
        ctx.setStrokeColor(self.circleColor)
        ctx.setLineWidth(self.width)
        ctx.addArc(
            center: center,
            radius: self.radius,
            startAngle: self.startAngle,
            endAngle: SnapTimerView.endAngle,
            clockwise: false
        )
		ctx.drawPath(using: .stroke)
	}
}
