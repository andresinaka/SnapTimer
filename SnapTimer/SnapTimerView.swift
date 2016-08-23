//
//  SnapTimerView.swift
//  SnapTimer
//
//  Created by Andres on 8/18/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit

@IBDesignable class SnapTimerView: UIView {
	let pi: CGFloat = CGFloat(M_PI)
	var snapCenter: CGPoint!
	var radius: CGFloat!
	let startAngle = 3/2 * CGFloat(M_PI)
	let endAngle = 7/2 * CGFloat(M_PI)

	@IBInspectable var mainBackgroundColor: UIColor = UIColor.darkGrayColor()
	@IBInspectable var centerBackgroundColor: UIColor = UIColor.lightGrayColor()
	@IBInspectable var outerBackgroundColor: UIColor = UIColor.whiteColor()
	
	@IBInspectable var outerValue: CGFloat = 0 {
		didSet{
			if let layer = self.layer as? SnapTimerLayer {
				layer.outerValue = outerValue
			}
		}
	}
	@IBInspectable var innerValue: CGFloat = 0 {
		didSet{
			if let layer = self.layer as? SnapTimerLayer {
				layer.innerValue = innerValue
			}
		}
	}
	
	private func commonInit() {
		self.snapCenter = CGPoint(x:bounds.width/2, y: bounds.height/2)
		self.radius = min(bounds.width, bounds.height) * 0.5
	}
	
    override func drawRect(rect: CGRect) {
		
    }
	
	override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
		super.drawLayer(layer, inContext: ctx)
		self.commonInit()

		UIGraphicsPushContext(ctx)
		self.mainCircle()
		self.innerCompletion()
		self.outterCompletion()
		UIGraphicsPopContext()
	}
	
	private func radianForValue(value: CGFloat) -> CGFloat{
		var realValue = value < 0 ? 0 : value
		realValue = value > 100 ? 100 : value
		
		return (realValue * 4/2 * pi / 100) + self.startAngle
	}

	private func mainCircle() {
		let bigCircle = UIBezierPath(arcCenter: self.snapCenter,
		                             radius: self.radius,
		                             startAngle: self.startAngle,
		                             endAngle: self.endAngle,
		                             clockwise: true)
		
		self.mainBackgroundColor.setFill()
		bigCircle.fill()
	}

	private func innerCompletion() {
		let startValue = self.radianForValue(self.innerValue)
		
		let innerCircle = UIBezierPath(arcCenter: self.snapCenter,
		                               radius: self.radius / 2,
		                               startAngle: startValue,
		                               endAngle: self.endAngle,
		                               clockwise: true)
		innerCircle.addLineToPoint(self.snapCenter)
		innerCircle.closePath()

		self.centerBackgroundColor.setFill()
		innerCircle.fill()
	}

	private func outterCompletion() {
		let startValue = self.radianForValue(self.outerValue)

		let outterCircle = UIBezierPath(arcCenter: self.snapCenter,
		                                radius: self.radius * 0.75,
		                                startAngle: startValue,
		                                endAngle: self.endAngle,
		                                clockwise: true)

		self.outerBackgroundColor.setStroke()
		outterCircle.lineWidth = radius * 0.35
		outterCircle.stroke()
	}
	
	override class func layerClass() -> AnyClass {
		return SnapTimerLayer.self
	}
}
