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
	static let startAngle = 3/2 * CGFloat(M_PI)
	static let endAngle = 7/2 * CGFloat(M_PI)
	
	var mainCircleLayer: SnapTimerMainLayer! = nil
	var centerLayer: SnapTimerCenterLayer! = nil
	var borderLayer: SnapTimerBorderLayer! = nil

	@IBInspectable var mainBackgroundColor: UIColor = UIColor.darkGrayColor() {
		didSet{
			if let layer = mainCircleLayer {
				layer.circleColor = self.mainBackgroundColor.CGColor
			}
		}
	}
	@IBInspectable var centerBackgroundColor: UIColor = UIColor.lightGrayColor() {
		didSet{
			if let layer = centerLayer {
				layer.circleColor = self.centerBackgroundColor.CGColor
			}
		}
	}
	@IBInspectable var borderBackgroundColor: UIColor = UIColor.whiteColor() {
		didSet{
			if let layer = borderLayer {
				layer.circleColor = borderBackgroundColor.CGColor
			}
		}
	}
	@IBInspectable var outerValue: CGFloat = 0 {
		didSet{
			if let layer = borderLayer {
				layer.startAngle = self.radianForValue(self.outerValue)
			}
		}
	}
	@IBInspectable var innerValue: CGFloat = 0 {
		didSet{
			if let layer = centerLayer {
				layer.startAngle = self.radianForValue(self.innerValue)
			}
		}
	}

	private func commonInit() {
		self.snapCenter = CGPoint(x:bounds.width/2, y: bounds.height/2)
		self.radius = min(bounds.width, bounds.height) * 0.5
	}

    override func drawRect(rect: CGRect) {
		self.commonInit()
		
		mainCircleLayer = SnapTimerMainLayer()
		mainCircleLayer.circleColor = self.mainBackgroundColor.CGColor
		mainCircleLayer.contentsScale = UIScreen.mainScreen().scale
		mainCircleLayer.frame = self.bounds
		self.layer.addSublayer(mainCircleLayer)

		centerLayer = SnapTimerCenterLayer()
		centerLayer.circleColor = self.centerBackgroundColor.CGColor
		centerLayer.startAngle = self.radianForValue(self.innerValue)
		centerLayer.contentsScale = UIScreen.mainScreen().scale
		centerLayer.frame = self.bounds
		self.layer.addSublayer(centerLayer)
		
		borderLayer = SnapTimerBorderLayer()
		borderLayer.circleColor = self.borderBackgroundColor.CGColor
		borderLayer.startAngle = self.radianForValue(self.innerValue)
		borderLayer.contentsScale = UIScreen.mainScreen().scale
		borderLayer.frame = self.bounds
		self.layer.addSublayer(borderLayer)
    }

	private func radianForValue(value: CGFloat) -> CGFloat{
		var realValue = value < 0 ? 0 : value
		realValue = value > 100 ? 100 : value

		return (realValue * 4/2 * pi / 100) + SnapTimerView.startAngle
	}
}
