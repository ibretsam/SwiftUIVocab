//
//  ExamplesView.swift
//  NewVocab
//
//  Created by MasterBi on 19/10/24.
//
import SwiftUI

struct ExamplesView: View {
    let examples: [Example]
    var body: some View {
        VStack {
            CustomStackView {
                Label {
                    Text("EXAMPLES")
                        .font(.caption)
                } icon: {
                    Image(systemName: "e.circle")
                }
            } contentView: {
                VStack {
                    ForEach(examples, id: \.id) { example in
                        HStack {
                            Text(example.example)
                                .font(.headline)
                            Spacer()
                        }
                        HStack {
                            Text(example.englishMeaning)
                                .font(.subheadline)
                            Spacer()
                        }
                        
                        VStack {
                            
                        }
                        .frame(height: 10)
                    }
                }
                .padding()
            }
            .padding(.horizontal, 15)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}
