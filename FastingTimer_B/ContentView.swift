//
//  ContentView.swift
//  FastingTimer_B
//
//  Created by Martin.Q on 2023/02/15.
//

import SwiftUI
import SwiftUIVisualEffects

struct ContentView: View {
    var body: some View {
		VStack(spacing: 40) {
			header
			
			ProgressRing()
			
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
			Text("Let's get started!")
				.font(.headline)
				.foregroundColor(Color(#colorLiteral(red: 0.8567120433, green: 0.5915268064, blue: 1, alpha: 1)))
			
			// MARK: Fasting Plan
			Text("16:8")
				.fontWeight(.bold)
				.padding(.horizontal, 24)
				.padding(.vertical, 8)
				.background(BlurEffect().blurEffectStyle(.systemThickMaterial))
				.cornerRadius(25)
		}
	}
	
	var times: some View {
		HStack(spacing: 60) {
			// MARK: Start Time
			VStack(spacing: 5) {
				Text("Start")
					.opacity(0.7)
				
				if #available(iOS 15.0, *) {
					Text(Date(), format: .dateTime.weekday().hour().minute().second())
						.fontWeight(.bold)
				} else {
					Text(Date(), formatter: Self.DateFormat)
						.fontWeight(.bold)
				}

			}
			
			// MARK: End Time
			VStack(spacing: 5) {
				Text("End")
					.opacity(0.7)
				
				Text(Date().addingTimeInterval(16), formatter: Self.DateFormat)
					.fontWeight(.bold)
			}
		}
	}
	
	var strBtn: some View {
		Button {
			// MARK: Button Action
		} label: {
			Text("Start Fasting")
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
