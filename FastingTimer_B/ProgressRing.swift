//
//  ProgressRing.swift
//  FastingTimer_B
//
//  Created by Martin.Q on 2023/02/15.
//

import SwiftUI

struct ProgressRing: View {
	@State var progress = 0.0
	
    var body: some View {
		ZStack {
			// MARK: Place Holder
			Circle()
				.stroke(lineWidth: 20)
				.foregroundColor(Color(UIColor.systemGray))
				.opacity(0.2)
			
			// MARK: Process Ring
			Circle()
				.trim(from: 0, to: min(progress, 1.0))
				.stroke(AngularGradient(colors: [Color(#colorLiteral(red: 0.8567120433, green: 0.5915268064, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5821906924, blue: 0.729834497, alpha: 1)), Color(#colorLiteral(red: 0.7210034728, green: 0.9851679206, blue: 0.5617409945, alpha: 1)), Color(#colorLiteral(red: 0.5453777909, green: 0.9893621802, blue: 0.850672543, alpha: 1)), Color(#colorLiteral(red: 0.8567120433, green: 0.5915268064, blue: 1, alpha: 1))], center: .center), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
				.rotationEffect(Angle(degrees: 270))
				.animation(.easeInOut(duration: 1.0), value: progress)
			
			// MARK: Timer
			VStack(spacing: 30) {
				// MARK: Elapsed Time
				VStack(spacing: 5) {
					Text("Elapsed Time")
						.opacity(0.7)
					
					Text("0:00")
						.font(.title)
						.fontWeight(.bold)
				}
				.padding(.top)
				
				// MARK: Remaining Time
				VStack(spacing: 5) {
					Text("Remaing Time")
						.opacity(0.7)
						
					Text("0:00")
						.font(.title2)
						.fontWeight(.bold)
				}
			}
		}
		.onAppear {
			progress = 0.5
		}
		.frame(width: 250, height: 250)
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
    }
}
