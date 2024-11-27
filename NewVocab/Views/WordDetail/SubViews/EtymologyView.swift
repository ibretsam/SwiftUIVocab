//
//  EtymologyView.swift
//  NewVocab
//
//  Created by MasterBi on 23/11/2024.
//
import SwiftUI

struct EtymologyView: View {
    let etymology: Etymology
    
    var body: some View {
        CustomStackView {
            Label {
                Text("ETYMOLOGY")
                    .font(.caption)
            } icon: {
                Image(systemName: "clock.arrow.circlepath")
            }
        } contentView: {
            VStack(spacing: 12) {
                // Origin and original word
                HStack(spacing: 0) {
                    // Origin
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Origin")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        Text(etymology.origin)
                            .font(.system(.title3, design: .serif))
                    }
                    .frame(maxWidth: .infinity)
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 1, height: 40)
                        .padding(.horizontal, 16)
                    
                    // Original word
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Original Form")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        Text(etymology.originalWord)
                            .font(.system(.title3, design: .serif))
                            .italic()
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Evolution steps if available
                if let steps = etymology.evolutionSteps {
                    Divider()
                        .background(Color.white.opacity(0.3))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(steps.indices, id: \.self) { index in
                                HStack(spacing: 6) {
                                    Text(steps[index])
                                        .font(.system(.callout, design: .serif))
                                        .italic()
                                    
                                    if index < steps.count - 1 {
                                        Image(systemName: "arrow.right")
                                            .font(.caption2)
                                            .foregroundColor(.white.opacity(0.6))
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 2)
                    }
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
        }
        .padding(.horizontal, 15)
        .frame(width: UIScreen.main.bounds.width, height: 190)
    }
}
