//
//  SnapTimerView.swift
//  SnapTimer
//
//  Created by Andres on 8/18/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import UIKit

@IBDesignable class SnapTimerView: UIView {
	static let startAngle = 3/2 * CGFloat(M_PI)
	static let endAngle = 7/2 * CGFloat(M_PI)

	var mainCircleLayer: SnapTimerMainLayer!
	var centerLayer: SnapTimerCenterLayer!
	var borderLayer: SnapTimerBorderLayer!

	@IBInspectable var mainBackgroundColor: UIColor = UIColor.darkGrayColor() {
		didSet{
			self.mainCircleLayer.circleColor = self.mainBackgroundColor.CGColor
		}
	}
	@IBInspectable var centerBackgroundColor: UIColor = UIColor.lightGrayColor() {
		didSet{
			self.centerLayer.circleColor = self.centerBackgroundColor.CGColor
		}
	}
	@IBInspectable var borderBackgroundColor: UIColor = UIColor.whiteColor() {
		didSet{
			self.borderLayer.circleColor = borderBackgroundColor.CGColor
		}
	}
	@IBInspectable var outerValue: CGFloat = 0 {
		didSet{
			self.borderLayer.startAngle = self.radianForValue(self.outerValue)
		}
	}
	@IBInspectable var innerValue: CGFloat = 0 {
		didSet{
			self.centerLayer.startAngle = self.radianForValue(self.innerValue)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	override func prepareForInterfaceBuilder() {
		commonInit()
	}

	private func commonInit() {
		self.mainCircleLayer = SnapTimerMainLayer()
		self.mainCircleLayer.circleColor = self.mainBackgroundColor.CGColor
		self.mainCircleLayer.contentsScale = UIScreen.mainScreen().scale
		self.mainCircleLayer.frame = self.bounds
		self.layer.addSublayer(mainCircleLayer)
		
		self.centerLayer = SnapTimerCenterLayer()
		self.centerLayer.circleColor = self.centerBackgroundColor.CGColor
		self.centerLayer.startAngle = self.radianForValue(self.innerValue)
		self.centerLayer.contentsScale = UIScreen.mainScreen().scale
		self.centerLayer.frame = self.bounds
		self.layer.addSublayer(centerLayer)
		
		self.borderLayer = SnapTimerBorderLayer()
		self.borderLayer.circleColor = self.borderBackgroundColor.CGColor
		self.borderLayer.startAngle = self.radianForValue(self.outerValue)
		self.borderLayer.contentsScale = UIScreen.mainScreen().scale
		self.borderLayer.frame = self.bounds
		self.layer.addSublayer(borderLayer)
	}

	private func radianForValue(value: CGFloat) -> CGFloat{
		var realValue = value < 0 ? 0 : value
		realValue = value > 100 ? 100 : value

		return (realValue * 4/2 * CGFloat(M_PI) / 100) + SnapTimerView.startAngle
	}
}
