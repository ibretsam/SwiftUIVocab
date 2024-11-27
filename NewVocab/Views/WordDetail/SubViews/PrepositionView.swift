//
//  PrepositionView.swift
//  NewVocab
//
//  Created by MasterBi on 17/11/2024.
//
import SwiftUI

struct PrepositionView: View {
    let preposition: PrepositionRequirement
    
    var body: some View {
        CustomStackView {
            Label {
                Text("REQUIRES PREPOSITION")
                    .font(.caption)
            } icon: {
                Image(systemName: "arrow.left.arrow.right")
            }
        } contentView: {
            HStack(spacing: 0) {
                // Left section: Preposition & Usage
                VStack(spacing: 12) {
                    // Floating preposition badge
                    Text(preposition.preposition)
                        .font(.title.weight(.bold))
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.15))
                                .shadow(color: .white.opacity(0.1), radius: 8, y: 4)
                        )
                    
                    // Usage text
                    Text(preposition.usage)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.horizontal, 8)
                }
                .frame(width: UIScreen.main.bounds.width * 0.35)
                .padding(.top, 5)
                
                // Vertical divider
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 1)
                    .padding(.vertical, 20)
                
                // Right section: Example
                VStack(alignment: .leading, spacing: 12) {
                    Text(preposition.example.example)
                        .font(.callout.weight(.medium))
                        .italic()
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(preposition.example.englishMeaning)
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
            }
        }
        .padding(.horizontal, 15)
        .frame(width: UIScreen.main.bounds.width, height: 190)
    }
}
