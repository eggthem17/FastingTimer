//
//  ContentView.swift
//  FastingTimer_B
//
//  Created by Martin.Q on 2023/02/15.
//

import SwiftUI
import SwiftUIVisualEffects

struct ContentView: View {
	@StateObject var fastingManager = FastingManager()
	
	var title: String {
		switch fastingManager.fastingState {
		case .notStarted:
			return "Let's get started!"
		case .fasting:
			return "You are now fasting"
		case .feeding:
			return "You are now feeding"
		}
	}
	
    var body: some View {
		VStack(spacing: 40) {
			header
			
			ProgressRing()
				.environmentObject(fastingManager)
			
			times
			
			strBtn
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
	var header: some View {
		VStack(spacing: 40) {
			// MARK: Title
			Text(title)
				.font(.headline)
				.foregroundColor(Color(#colorLiteral(red: 0.8567120433, green: 0.5915268064, blue: 1, alpha: 1)))
			
			// MARK: Fasting Plan
			Menu {
				ForEach(FastingPlan.allCases, id: \.rawValue) { value in
					Button {
						fastingManager.setPlan(selected: value)
					} label: {
						Text("\(value.title) \(value.rawValue)")
					}
				}
			} label: {
				Text(fastingManager.fastingPlan.rawValue)
					.fontWeight(.bold)
					.padding(.horizontal, 24)
					.padding(.vertical, 8)
					.background(BlurEffect().blurEffectStyle(.systemThickMaterial))
					.cornerRadius(25)
			}
			.foregroundColor(.primary)
			.minimumScaleFactor(0.1)
		}
	}
	
	var times: some View {
		HStack(spacing: 60) {
			// MARK: Start Time
			VStack(spacing: 5) {
				Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
					.opacity(0.7)
				
				if #available(iOS 15.0, *) {
					Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
						.fontWeight(.bold)
				} else {
					Text(Date(), formatter: Self.DateFormat)
						.fontWeight(.bold)
				}

			}
			
			// MARK: End Time
			VStack(spacing: 5) {
				Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
					.opacity(0.7)
				
				Text(fastingManager.endTime, formatter: Self.DateFormat)
					.fontWeight(.bold)
			}
		}
	}
	
	var strBtn: some View {
		Button {
			fastingManager.toggleFastingState()
		} label: {
			Text(fastingManager.fastingState == .fasting ? "End Fast" : "Start Fasting")
				.font(.title3)
				.fontWeight(.bold)
				.padding(.horizontal, 24)
				.padding(.vertical, 8)
				.background(BlurEffect().blurEffectStyle(.systemThickMaterial))
				.cornerRadius(25)
		}
		.foregroundColor(.primary)
	}
}

extension ContentView {
	// MARK: DateFormat
	static let DateFormat: DateFormatter = {
			let formatter = DateFormatter()
			formatter.dateFormat = "E h:mm:ss a"
			return formatter
		}()
}
