//
//  AdjectivePositionView.swift
//  NewVocab
//
//  Created by MasterBi on 18/11/2024.
//

import SwiftUI

struct AdjectivePositionView: View {
    let word: FrenchAdjective
    
    var body: some View {
        let position = word.defaultPosition
        
        VStack(spacing: 8) {
            // Example sentence structure
            HStack(spacing: 8) {
                if position.position == .before {
                    HighlightedWord(text: word.word, isHighlighted: true)
                    Image(systemName: "plus")
                    HighlightedWord(text: "n", isHighlighted: false)
                } else {
                    HighlightedWord(text: "n", isHighlighted: false)
                    Image(systemName: "plus")
                    HighlightedWord(text: word.word, isHighlighted: true)
                }
            }
            .padding(.vertical, 6)
            
            // Position description
            Text(position.position.rawValue)
                .font(.callout)
                .foregroundColor(.white.opacity(0.8))
            
            Text(position.example.example)
                .font(.footnote)
                .italic()
                .foregroundColor(.white.opacity(0.7))
            
        }
        .frame(maxHeight: .infinity)
        .padding(.vertical, 20)
    }
}

struct HighlightedWord: View {
    let text: String
    let isHighlighted: Bool
    
    var body: some View {
        Text(text)
            .font(.system(.body, design: .serif))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(isHighlighted ? Color.white.opacity(0.15) : Color.clear)
            )
            .foregroundColor(isHighlighted ? .white : .white.opacity(0.8))
    }
}
