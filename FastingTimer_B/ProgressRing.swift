//
//  ProgressRing.swift
//  FastingTimer_B
//
//  Created by Martin.Q on 2023/02/15.
//

import SwiftUI

struct ProgressRing: View {
	@EnvironmentObject var fastingManager: FastingManager
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
    var body: some View {
		ZStack {
			// MARK: Place Holder
			Circle()
				.stroke(lineWidth: 20)
				.foregroundColor(Color(UIColor.systemGray))
				.opacity(0.2)
			
			// MARK: Process Ring
			Circle()
				.trim(from: 0, to: min(fastingManager.progress, 1.0))
				.stroke(AngularGradient(colors: [Color(#colorLiteral(red: 0.8567120433, green: 0.5915268064, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5821906924, blue: 0.729834497, alpha: 1)), Color(#colorLiteral(red: 0.7210034728, green: 0.9851679206, blue: 0.5617409945, alpha: 1)), Color(#colorLiteral(red: 0.5453777909, green: 0.9893621802, blue: 0.850672543, alpha: 1)), Color(#colorLiteral(red: 0.8567120433, green: 0.5915268064, blue: 1, alpha: 1))], center: .center), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
				.rotationEffect(Angle(degrees: 270))
				.animation(.easeInOut(duration: 1.0), value: fastingManager.progress)
			
			// MARK: Timer
			VStack(spacing: 30) {
				// MARK: Upcoming Time
				if fastingManager.fastingState == .notStarted {
					VStack(spacing: 5) {
						Text("Upcoming fast")
							.opacity(0.7)
						
						Text("\(fastingManager.fastingPlan.fastingPeriod, specifier: "%0.f") Hours")
							.font(.title)
							.fontWeight(.bold)
					}
				} else {
					// MARK: Elapsed Time
					VStack(spacing: 5) {
						Text("Elapsed Time (\(fastingManager.progress * 100, specifier: "%.0f")%)")
							.opacity(0.7)
						
						Text(fastingManager.startTime, style: .timer)
							.font(.title)
							.fontWeight(.bold)
					}
					.padding(.top)
					
					// MARK: Remaining Time
					VStack(spacing: 5) {
						if  !fastingManager.elapsed {
							Text("Remaing Time (\((1 - fastingManager.progress) * 100, specifier: "%.0f")%)")
								.opacity(0.7)
						} else {
							Text("Extra Time")
								.opacity(0.7)
						}
							
						Text(fastingManager.endTime, style: .timer)
							.font(.title2)
							.fontWeight(.bold)
					}
				}
			}
		}
		.frame(width: 250, height: 250)
		.padding()
		.onReceive(timer) { _ in
			fastingManager.track()
		}
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
			.environmentObject(FastingManager())
    }
}
