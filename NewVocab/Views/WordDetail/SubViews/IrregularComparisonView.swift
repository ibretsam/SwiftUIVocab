//
//  IrregularComparisonView.swift
//  NewVocab
//
//  Created by MasterBi on 19/11/2024.
//
import SwiftUI

struct IrregularComparisonView: View {
    let word: FrenchAdjective
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if word.isIrregularComparison {
                // Show regular vs irregular pattern
                VStack(alignment: .leading, spacing: 8) {
                    // Regular pattern (crossed out)
                    HStack(spacing: 6) {
                        Text("plus")
                            .strikethrough()
                        Text("+")
                            .strikethrough()
                        Text(word.word)
                            .strikethrough()
                    }
                    .foregroundColor(.white.opacity(0.6))
                    
                    // Irregular form
                    if let comparativeForm = word.comparativeForm {
                        Text(comparativeForm.masculine)
                            .font(.system(.title3, design: .serif))
                    }
                }
                
                // Example if available
                if let example = word.comparativeForm?.example {
                    Text(example.example)
                        .font(.footnote)
                        .italic()
                        .foregroundColor(.white.opacity(0.7))
                }
                
                // Explanation
                Text("This adjective has special comparative forms instead of using 'plus'")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 4)
            } else {
                // Show regular pattern
                VStack(alignment: .leading, spacing: 5) {
                    Text("Regular pattern:")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    
                    HStack(spacing: 6) {
                        Text("plus")
                        Text("+")
                        Text(word.word)
                    }
                    .font(.system(.title3, design: .serif))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
