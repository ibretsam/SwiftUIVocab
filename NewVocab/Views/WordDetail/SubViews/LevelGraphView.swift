//
//  LevelGraphView.swift
//  NewVocab
//
//  Created by MasterBi on 11/11/2024.
//
import SwiftUI

struct LevelGraphView: View {
    let level: LanguageLevel
    
    private let levels: [LanguageLevel] = [.a1, .a2, .b1, .b2, .c1, .c2]
    private let barWidth: CGFloat = 8
    private let spacing: CGFloat = 6
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(level.rawValue.capitalized)")
                .font(.title2)
                .bold()
            
            Text(level.details.subtitle)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            
            HStack(alignment: .bottom, spacing: spacing) {
                ForEach(levels, id: \.self) { currentLevel in
                    VStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(getBarColor(for: currentLevel))
                            .frame(width: barWidth, height: getBarHeight(for: currentLevel))
                        
                        Text(currentLevel.rawValue.uppercased())
                            .font(.system(size: 8))
                            .foregroundColor(getTextColor(for: currentLevel))
                    }
                }
            }
        }
        .padding()
    }
    
    private func getBarHeight(for currentLevel: LanguageLevel) -> CGFloat {
        let baseHeight: CGFloat = 10
        let increment: CGFloat = 5
        let index = levels.firstIndex(of: currentLevel) ?? 0
        return baseHeight + (CGFloat(index) * increment)
    }
    
    private func getBarColor(for currentLevel: LanguageLevel) -> Color {
        if currentLevel == level {
            return .white
        }
        return .white.opacity(0.3)
    }
    
    private func getTextColor(for currentLevel: LanguageLevel) -> Color {
        if currentLevel == level {
            return .white
        }
        return .white.opacity(0.5)
    }
}

