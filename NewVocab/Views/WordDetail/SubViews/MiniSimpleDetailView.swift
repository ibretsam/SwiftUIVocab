//
//  MiniSimpleDetailView.swift
//  NewVocab
//
//  Created by MasterBi on 13/10/24.
//
import SwiftUI

enum Side {
    case left
    case right
}

struct MiniSimpleDetailView: View {
    var title: String
    var icon: String
    var dataTitle: String
    var dataSubtitle: String
    var side: Side
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
                HStack {
                    Text("\(dataTitle)")
                        .font(.title)
                        .bold()
                        .lineLimit(1) // Ensure the text stays on a single line
                        .minimumScaleFactor(0.5) // Scale down to 50% of the original size if needed
                    Spacer()
                }
                Spacer()
                HStack {
                    Text("\(dataSubtitle)")
                        .font(.callout)
                    Spacer()
                }
            }
            .padding()
        }
        .padding(.trailing, side == .right ? 20 : 0)
        .padding(.leading, side == .left ? 20 : 0)
        .frame(width: UIScreen.main.bounds.width / 2, height: 190)
    }
}
