//
//  SnapTimerView.swift
//  SnapTimer
//
//  Created by Andres on 8/18/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit

@IBDesignable public class SnapTimerView: UIView {
	static let startAngle = 3/2 * CGFloat(M_PI)
	static let endAngle = 7/2 * CGFloat(M_PI)

	internal var mainCircleLayer: SnapTimerCircleLayer!
	internal var centerLayer: SnapTimerCircleLayer!
	internal var borderLayer: SnapTimerBorderLayer!
	
	internal var animationsPaused = false

	@IBInspectable var mainBackgroundColor: UIColor = UIColor.darkGrayColor() {
		didSet {
			self.mainCircleLayer.circleColor = self.mainBackgroundColor.CGColor
		}
	}
	@IBInspectable var centerBackgroundColor: UIColor = UIColor.lightGrayColor() {
		didSet {
			self.centerLayer.circleColor = self.centerBackgroundColor.CGColor
		}
	}
	@IBInspectable var borderBackgroundColor: UIColor = UIColor.whiteColor() {
		didSet {
			self.borderLayer.circleColor = borderBackgroundColor.CGColor
		}
	}

	private var outerProperty: CGFloat = 0
	private var innerProperty: CGFloat = 0

	@IBInspectable var outerValue: CGFloat {
		set {
			CATransaction.begin()
			CATransaction.setDisableActions(true)
			self.animateOuterValue(newValue)
			CATransaction.commit()
		}

		get {
			return self.outerProperty
		}
	}

	@IBInspectable var innerValue: CGFloat {
		set {
			CATransaction.begin()
			CATransaction.setDisableActions(true)
			self.animateInnerValue(newValue)
			CATransaction.commit()
		}

		get {
			return self.innerProperty
		}
	}

	public func animateOuterValue(value: CGFloat) {
		self.outerProperty = SnapTimerView.sanitizeValue(value)
		self.borderLayer.startAngle = SnapTimerView.radianForValue(self.outerProperty)
	}

	public func animateInnerValue(value: CGFloat) {
		self.innerProperty = SnapTimerView.sanitizeValue(value)
		self.centerLayer.startAngle = SnapTimerView.radianForValue(self.innerProperty)
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	override public func prepareForInterfaceBuilder() {
		commonInit()
	}

	private func commonInit() {
		let radius = min(bounds.width, bounds.height) * 0.5

		self.mainCircleLayer = SnapTimerCircleLayer()
		self.mainCircleLayer.circleColor = self.mainBackgroundColor.CGColor
		self.mainCircleLayer.radius = radius
		self.mainCircleLayer.contentsScale = UIScreen.mainScreen().scale
		self.mainCircleLayer.frame = self.bounds
		self.layer.addSublayer(mainCircleLayer)

		self.centerLayer = SnapTimerCircleLayer()
		self.centerLayer.circleColor = self.centerBackgroundColor.CGColor
		self.centerLayer.startAngle = SnapTimerView.radianForValue(self.innerProperty)
		self.centerLayer.radius = radius/2
		self.centerLayer.contentsScale = UIScreen.mainScreen().scale
		self.centerLayer.frame = self.bounds
		self.layer.addSublayer(centerLayer)

		self.borderLayer = SnapTimerBorderLayer()
		self.borderLayer.circleColor = self.borderBackgroundColor.CGColor
		self.borderLayer.startAngle = SnapTimerView.radianForValue(self.outerProperty)
		self.borderLayer.radius = radius * 0.75
		self.borderLayer.width = radius * 0.33
		self.borderLayer.contentsScale = UIScreen.mainScreen().scale
		self.borderLayer.frame = self.bounds
		self.layer.addSublayer(borderLayer)
	}

	public func animateOuterToValue(value: CGFloat, duration: NSTimeInterval, completion: (() -> Void)?) {
		CATransaction.begin()
		CATransaction.setAnimationDuration(duration)
		CATransaction.setCompletionBlock(completion)
		self.animateOuterValue(value)
		CATransaction.commit()
	}

	public func animateInnerToValue(value: CGFloat, duration: NSTimeInterval, completion: (() -> Void)?) {
		CATransaction.begin()
		CATransaction.setAnimationDuration(duration)
		CATransaction.setCompletionBlock(completion)
		self.animateInnerValue(value)
		CATransaction.commit()
	}
	
	public func pauseAnimation() {
		self.animationsPaused = true

		let pausedTime = self.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
		self.layer.speed = 0.0
		self.layer.timeOffset = pausedTime
	}
	
	public func resumeAnimation() {
		if !self.animationsPaused {
			return
		}
		self.animationsPaused = false

		let pausedTime = self.layer.timeOffset
		self.layer.speed = 1.0;
		self.layer.timeOffset = 0.0;
		self.layer.beginTime = 0.0;
		let timeSincePause = self.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
		self.layer.beginTime = timeSincePause;
	}

	internal class func sanitizeValue(value: CGFloat) -> CGFloat {
		var realValue = value
		if value < 0 {
			realValue = 0
		} else if value > 100 {
			realValue = 100
		}
		return realValue
	}

	internal class func radianForValue(value: CGFloat) -> CGFloat {
		let realValue = SnapTimerView.sanitizeValue(value)
		return (realValue * 4/2 * CGFloat(M_PI) / 100) + SnapTimerView.startAngle
	}
}
