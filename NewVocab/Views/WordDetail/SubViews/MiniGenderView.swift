//
//  MiniGenderView.swift
//  NewVocab
//
//  Created by MasterBi on 19/10/24.
//
import SwiftUI

// Create a view for the gender form content
struct GenderFormContent: View {
    let genderForms: [GenderForm]
    
    var body: some View {
        HStack {
            ForEach(Array(genderForms.enumerated()), id: \.element.gender) { index, genderForm in
                VStack {
                    VStack {
                        Text("\(genderForm.gender == .masculine ? "♂" : "♀")")
                            .font(.title2)
                        Text("\(genderForm.gender.rawValue.capitalized)")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .layoutPriority(1)
                    
                    VStack {
                        HStack {
                            Text("Singular")
                                .font(.caption2)
                            Spacer()
                            Text(genderForm.singular.capitalized)
                                .bold()
                        }
                        HStack {
                            Text("Plural")
                                .font(.caption2)
                            Spacer()
                            Text(genderForm.plural.capitalized)
                                .bold()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .layoutPriority(1)
                }
                .padding(.horizontal, 10)
                if index == 0 {
                    Divider().frame(width: 1)
                        .overlay(Color.white.opacity(0.8))
                }
            }
        }
    }
}

// Simplified main view
struct MiniGenderView: View {
    var genderForms: [GenderForm]
    
    var body: some View {
        CustomStackView {
            Label {
                Text("\(genderForms.count > 1 ? "FORMES" : "FORM")")
                    .font(.caption)
            } icon: {
                Text("⚤")
            }
        } contentView: {
            GenderFormContent(genderForms: genderForms)
                .frame(height: 105)
                .padding()
        }
        .padding(.horizontal, 15)
        .frame(width: UIScreen.main.bounds.width, height: 190)
    }
}
