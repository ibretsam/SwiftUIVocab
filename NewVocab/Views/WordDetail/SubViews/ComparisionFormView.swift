//
//  ComparisionFormView.swift
//  NewVocab
//
//  Created by MasterBi on 26/10/24.
//

import SwiftUI

struct ComparisionFormView: View {
    var title: String
    var icon: String
    var form: ComparisonForms
    
    var body: some View {
        CustomStackView {
            Label {
                Text(title)
                    .font(.caption)
            } icon: {
                Image(systemName: icon)
            }
        } contentView: {
            VStack {
                // Comparison Forms
                HStack() {
                    ComparisonColumn(symbol: "♂", text: form.masculine)
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 1)
                        .padding(.vertical, 5)
                    
                    ComparisonColumn(symbol: "♀", text: form.feminine)
                }
                
                if let example = form.example {
                    Divider()
                        .overlay(Color.white.opacity(0.8))
                    
                    // Example
                    VStack(alignment: .leading) {
                        Text(example.example)
                            .font(.callout)
                        Text(example.englishMeaning)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            }
            .padding()
        }
        .padding(.horizontal, 15)
        .frame(width: UIScreen.main.bounds.width, height: 190)
    }
}

private struct ComparisonColumn: View {
    let symbol: String
    let text: String
    
    var body: some View {
        VStack {
            Text(symbol)
                .font(.title3)
            
            Text(text.capitalized)
                .font(.callout)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}
