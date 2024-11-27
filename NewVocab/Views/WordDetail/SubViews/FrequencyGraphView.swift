//
//  FrequencyGraphView.swift
//  NewVocab
//
//  Created by MasterBi on 11/11/2024.
//

import SwiftUI

struct FrequencyGraphView: View {
    let frequency: FrequencyLevel
    
    private let frequencies: [FrequencyLevel] = [
        .veryCommon, .common, .uncommon, .rare, .veryRare
    ]
    private let barHeight: CGFloat = 6
    private let spacing: CGFloat = 6
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(frequency.rawValue)")
                .font(.title3)
                .bold()
            
            VStack(alignment: .leading) {
                ForEach(frequencies, id: \.self) { currentFrequency in
                    HStack {
                        Text(currentFrequency.rawValue)
                            .font(.system(size: 8))
                            .foregroundColor(getTextColor(for: currentFrequency))
                            .frame(width: 60, alignment: .trailing)
                        
                        RoundedRectangle(cornerRadius: 3)
                            .fill(getBarColor(for: currentFrequency))
                            .frame(width: getBarWidth(for: currentFrequency), height: barHeight)
                    }
                }
            }
            
        }
        .padding()
    }
    
    private func getBarWidth(for currentFrequency: FrequencyLevel) -> CGFloat {
        let baseWidth: CGFloat = 75
        let multiplier: CGFloat
        
        switch currentFrequency {
        case .veryCommon: multiplier = 1.0
        case .common:     multiplier = 0.8
        case .uncommon:   multiplier = 0.6
        case .rare:       multiplier = 0.4
        case .veryRare:   multiplier = 0.2
        }
        
        return baseWidth * multiplier
    }
    
    private func getBarColor(for currentFrequency: FrequencyLevel) -> Color {
        if currentFrequency == frequency {
            return .white
        }
        return .white.opacity(0.3)
    }
    
    private func getTextColor(for currentFrequency: FrequencyLevel) -> Color {
        if currentFrequency == frequency {
            return .white
        }
        return .white.opacity(0.5)
    }
}
