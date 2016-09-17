//
//  SnapTimerView.swift
//  SnapTimer
//
//  Created by Andres on 8/18/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit

@IBDesignable open class SnapTimerView: UIView {
	static let startAngle = 3/2 * CGFloat(M_PI)
	static let endAngle = 7/2 * CGFloat(M_PI)

	internal var mainCircleLayer: SnapTimerCircleLayer!
	internal var centerLayer: SnapTimerCircleLayer!
	internal var borderLayer: SnapTimerBorderLayer!

	internal var animationsPaused = false

	@IBInspectable var mainBackgroundColor: UIColor = UIColor.darkGray {
		didSet {
			self.mainCircleLayer.circleColor = self.mainBackgroundColor.cgColor
		}
	}
	@IBInspectable var centerBackgroundColor: UIColor = UIColor.lightGray {
		didSet {
			self.centerLayer.circleColor = self.centerBackgroundColor.cgColor
		}
	}
	@IBInspectable var borderBackgroundColor: UIColor = UIColor.white {
		didSet {
			self.borderLayer.circleColor = borderBackgroundColor.cgColor
		}
	}

	fileprivate var outerProperty: CGFloat = 0
	fileprivate var innerProperty: CGFloat = 0

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

	open func animateOuterValue(_ value: CGFloat) {
		self.outerProperty = SnapTimerView.sanitizeValue(value)
		self.borderLayer.startAngle = SnapTimerView.radianForValue(self.outerProperty)
	}

	open func animateInnerValue(_ value: CGFloat) {
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

	override open func prepareForInterfaceBuilder() {
		commonInit()
	}

    override open func layoutSubviews() {
        super.layoutSubviews()

        let radius = min(bounds.width, bounds.height) * 0.5
        self.mainCircleLayer.radius = radius
        self.mainCircleLayer.frame = self.bounds

        self.centerLayer.radius = radius/2
        self.centerLayer.frame = self.bounds

        self.borderLayer.radius = radius * 0.75
        self.borderLayer.width = radius * 0.33
        self.borderLayer.frame = self.bounds
    }

	fileprivate func commonInit() {
		self.mainCircleLayer = SnapTimerCircleLayer()
		self.mainCircleLayer.circleColor = self.mainBackgroundColor.cgColor
		self.mainCircleLayer.contentsScale = UIScreen.main.scale
		self.layer.addSublayer(mainCircleLayer)

		self.centerLayer = SnapTimerCircleLayer()
		self.centerLayer.circleColor = self.centerBackgroundColor.cgColor
		self.centerLayer.startAngle = SnapTimerView.radianForValue(self.innerProperty)
		self.centerLayer.contentsScale = UIScreen.main.scale
		self.layer.addSublayer(centerLayer)

		self.borderLayer = SnapTimerBorderLayer()
		self.borderLayer.circleColor = self.borderBackgroundColor.cgColor
		self.borderLayer.startAngle = SnapTimerView.radianForValue(self.outerProperty)
		self.borderLayer.contentsScale = UIScreen.main.scale
		self.layer.addSublayer(borderLayer)
	}

	open func animateOuterToValue(_ value: CGFloat, duration: TimeInterval, completion: (() -> Void)?) {
		CATransaction.begin()
		CATransaction.setAnimationDuration(duration)
		CATransaction.setCompletionBlock(completion)
		self.animateOuterValue(value)
		CATransaction.commit()
	}

	open func animateInnerToValue(_ value: CGFloat, duration: TimeInterval, completion: (() -> Void)?) {
		CATransaction.begin()
		CATransaction.setAnimationDuration(duration)
		CATransaction.setCompletionBlock(completion)
		self.animateInnerValue(value)
		CATransaction.commit()
	}

	open func pauseAnimation() {
		self.animationsPaused = true

		let pausedTime = self.layer.convertTime(CACurrentMediaTime(), from: nil)
		self.layer.speed = 0.0
		self.layer.timeOffset = pausedTime
	}

	open func resumeAnimation() {
		if !self.animationsPaused {
			return
		}
		self.animationsPaused = false

		let pausedTime = self.layer.timeOffset
		self.layer.speed = 1.0
		self.layer.timeOffset = 0.0
		self.layer.beginTime = 0.0
		let timeSincePause = self.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
		self.layer.beginTime = timeSincePause
	}

	internal class func sanitizeValue(_ value: CGFloat) -> CGFloat {
		var realValue = value
		if value < 0 {
			realValue = 0
		} else if value > 100 {
			realValue = 100
		}
		return realValue
	}

	internal class func radianForValue(_ value: CGFloat) -> CGFloat {
		let realValue = SnapTimerView.sanitizeValue(value)
		return (realValue * 4/2 * CGFloat(M_PI) / 100) + SnapTimerView.startAngle
	}
}
