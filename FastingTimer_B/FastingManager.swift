//
//  FastingManager.swift
//  FastingTimer_B
//
//  Created by Martin.Q on 2023/02/16.
//

import Foundation

enum FastingState {
	case notStarted
	case fasting
	case feeding
}

enum FastingPlan: String {
	case beginner = "12:12"
	case intermediate = "16:8"
	case advanced = "20:4"
	
	var fastingPeriod: Double {
		switch self {
		case .beginner:
			return 12
		case .intermediate:
			return 16
		case .advanced:
			return 20
		}
	}
}

class FastingManager: ObservableObject {
	@Published private(set) var fastingState: FastingState = .notStarted
	@Published private(set) var fastingPlan: FastingPlan = .intermediate
	@Published private(set) var startTime: Date {
		didSet {
			if fastingState == .fasting {
				endTime = startTime.addingTimeInterval(fastingTime)
			} else {
				endTime = startTime.addingTimeInterval(feedingTime)
			}
		}
	}
	@Published private(set) var endTime: Date
	
	var fastingTime: Double {
		return fastingPlan.fastingPeriod
	}
	var feedingTime: Double {
		return 24 - fastingPlan.fastingPeriod
	}
	
	init() {
		let calendar = Calendar.current
		let components = DateComponents(hour: 20)
		let scheduledTime = calendar.nextDate(after: Date(), matching: components, matchingPolicy: .nextTime)!
		
		startTime = scheduledTime
		endTime = scheduledTime.addingTimeInterval(FastingPlan.intermediate.fastingPeriod)
	}

	
	func toggleFastingState() {
		fastingState = fastingState == .fasting ? .feeding : .fasting
		startTime = Date()
	}
}
