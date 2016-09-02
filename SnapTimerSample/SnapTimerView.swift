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

	var mainCircleLayer: SnapTimerCircleLayer!
	var centerLayer: SnapTimerCircleLayer!
	var borderLayer: SnapTimerBorderLayer!

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
			return self.outerProperty
		}
	}

	public func animateOuterValue(value: CGFloat) {
		self.outerProperty = value
		self.borderLayer.startAngle = self.radianForValue(self.outerProperty)
	}

	public func animateInnerValue(value: CGFloat) {
		self.innerProperty = value
		self.centerLayer.startAngle = self.radianForValue(self.innerProperty)
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
		self.centerLayer.startAngle = self.radianForValue(self.innerProperty)
		self.centerLayer.radius = radius/2
		self.centerLayer.contentsScale = UIScreen.mainScreen().scale
		self.centerLayer.frame = self.bounds
		self.layer.addSublayer(centerLayer)

		self.borderLayer = SnapTimerBorderLayer()
		self.borderLayer.circleColor = self.borderBackgroundColor.CGColor
		self.borderLayer.startAngle = self.radianForValue(self.outerProperty)
		self.borderLayer.radius = radius * 0.75
		self.borderLayer.width = radius * 0.33
		self.borderLayer.contentsScale = UIScreen.mainScreen().scale
		self.borderLayer.frame = self.bounds
		self.layer.addSublayer(borderLayer)
	}

	public func animateOuterToValue(value: CGFloat, duration: NSTimeInterval, completion: (() -> Void)?) {
		CATransaction.begin()
		CATransaction.setDisableActions(false)
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

	private func radianForValue(value: CGFloat) -> CGFloat {
		var realValue = value < 0 ? 0 : value
		realValue = value > 100 ? 100 : value

		return (realValue * 4/2 * CGFloat(M_PI) / 100) + SnapTimerView.startAngle
	}
}
