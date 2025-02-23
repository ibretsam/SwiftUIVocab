//
//  BackgroundView.swift
//  NewVocab
//
//  Created by MasterBi on 01/11/2024.
//

import SwiftUI

struct WordBackgroundView: View {
    let word: FrenchWordType
    @State private var animate = false
    
    private var combinedGradientColors: [Color]
	
	init(word: FrenchWordType) {
		self.word = word
		self.combinedGradientColors = getWordColors(for: word)
	}
    
    var body: some View {
		
        GeometryReader { geometry in
            ZStack {
                // Base soft gradient
                LinearGradient(
                    gradient: Gradient(colors: [.white, Color(hex: "#F8F8F8")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // Main radial gradient
                RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: combinedGradientColors[0].opacity(0.3), location: 0),
                        .init(color: combinedGradientColors[1].opacity(0.2), location: 0.3),
                        .init(color: .white.opacity(1), location: 0.8)
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: max(geometry.size.width, geometry.size.height) * 0.5
                )
                .scaleEffect(animate ? 1.1 : 1.0)
                
                // Accent gradient
                RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: combinedGradientColors[1].opacity(0.1), location: 0),
                        .init(color: combinedGradientColors[0].opacity(0.05), location: 0.5),
                        .init(color: .clear, location: 0.8)
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: max(geometry.size.width, geometry.size.height) * 0.3
                )
            }
            .animation(.easeInOut(duration: 8.0).repeatForever(autoreverses: true), value: animate)
        }
        .ignoresSafeArea()
        .onAppear {
//            animate = true
        }
    }
}
