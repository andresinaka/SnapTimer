//
//  SnapTimerTests.swift
//  SnapTimerTests
//
//  Created by Andres on 8/18/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import XCTest
@testable import SnapTimer

class SnapTimerTests: XCTestCase {

	func testAssingPropertyValues() {
		let snapTimer = SnapTimerView()
		snapTimer.outerValue = 50
		snapTimer.innerValue = 20

		XCTAssertEqual(snapTimer.outerValue, 50)
		XCTAssertEqual(snapTimer.borderLayer.startAngle, SnapTimerView.radianForValue(50))
		XCTAssertEqual(snapTimer.innerValue, 20)
		XCTAssertEqual(snapTimer.centerLayer.startAngle, SnapTimerView.radianForValue(20))
	}

	func testAssingColors() {
		let snapTimer = SnapTimerView()
		snapTimer.mainBackgroundColor = UIColor.red
		XCTAssertTrue(CGColorEqualToColor(snapTimer.mainCircleLayer.circleColor, UIColor.red.cgColor))

		snapTimer.centerBackgroundColor = UIColor.blue
		XCTAssertTrue(CGColorEqualToColor(snapTimer.mainCircleLayer.circleColor, UIColor.red.cgColor))

		snapTimer.borderBackgroundColor = UIColor.black
		XCTAssertTrue(CGColorEqualToColor(snapTimer.borderLayer.circleColor, UIColor.black.cgColor))
	}

	func testStartEndAngle() {
		XCTAssertEqual(SnapTimerView.endAngle, 7/2 * CGFloat(M_PI))
		XCTAssertEqual(SnapTimerView.startAngle, 3/2 * CGFloat(M_PI))
	}

	func testRadianForValue() {
		// Degrees for CGContextAddArc start on X postitive and go positive
		// clockwise. I want my 0 to be 270 degrees or 3/2* pi. If I add
		// 90 degrees or (pi/2) to 3/2*pi that would be a quarter of the total
		// size of the circumference. If I add pi to the cero that would be
		// half of the circumference and so on...
		XCTAssertEqual(SnapTimerView.radianForValue(0), 3/2 * CGFloat(M_PI))
		XCTAssertEqual(SnapTimerView.radianForValue(25), 2 * CGFloat(M_PI))
		XCTAssertEqual(SnapTimerView.radianForValue(50), 5/2 * CGFloat(M_PI))
		XCTAssertEqual(SnapTimerView.radianForValue(75), 3 * CGFloat(M_PI))
		XCTAssertEqual(SnapTimerView.radianForValue(100), 7/2 * CGFloat(M_PI))
	}

	func testRadianForValueOnlyPossitiveNumbersBetween0and100() {
		XCTAssertEqual(SnapTimerView.radianForValue(-30), 3/2 * CGFloat(M_PI))
		XCTAssertEqual(SnapTimerView.radianForValue(180), 7/2 * CGFloat(M_PI))
	}

	func testInnerAnimationCallbacks() {
		let expectation = self.expectation(description: "animation callbacks")

		let snapTimer = SnapTimerView()
		snapTimer.outerValue = 0
		snapTimer.innerValue = 50

		snapTimer.animateInnerToValue(75, duration: 2) {
			XCTAssertEqual(snapTimer.innerValue, 75)
			expectation.fulfill()
		}

		self.waitForExpectations(timeout: 3) { (error) in
			if let _ = error {
				XCTFail("Expectation not fulfilled")
			}
		}
	}

	func testOuterAnimationCallbacks() {
		let expectation = self.expectation(description: "animation callbacks")

		let snapTimer = SnapTimerView()
		snapTimer.outerValue = 25
		snapTimer.innerValue = 50

		snapTimer.animateOuterToValue(55, duration: 2) {
			XCTAssertEqual(snapTimer.outerValue, 55)
			expectation.fulfill()
		}

		self.waitForExpectations(timeout: 3) { (error) in
			if let _ = error {
				XCTFail("Expectation not fulfilled")
			}
		}
	}

	func testPauseResumeAnimations() {
		let snapTimer = SnapTimerView()
		XCTAssertFalse(snapTimer.animationsPaused)
		snapTimer.outerValue = 0
		snapTimer.innerValue = 0

		snapTimer.pauseAnimation()
		XCTAssertTrue(snapTimer.animationsPaused)
		XCTAssertEqual(snapTimer.layer.speed, 0.0)

		snapTimer.resumeAnimation()
		XCTAssertFalse(snapTimer.animationsPaused)
		XCTAssertEqual(snapTimer.layer.speed, 1.0)

		snapTimer.resumeAnimation()
		XCTAssertFalse(snapTimer.animationsPaused)
	}

	func testChangeNotAllowedValues() {
		let snapTimer = SnapTimerView()
		snapTimer.outerValue = -50
		snapTimer.innerValue = 150

		XCTAssertEqual(snapTimer.outerValue, 0)
		XCTAssertEqual(snapTimer.innerValue, 100)
	}

	func testSanitizeValue() {
		XCTAssertEqual(SnapTimerView.sanitizeValue(-10), 0)
		XCTAssertEqual(SnapTimerView.sanitizeValue(50), 50)
		XCTAssertEqual(SnapTimerView.sanitizeValue(200), 100)
	}
}
