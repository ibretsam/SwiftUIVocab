//
//  WordFormView.swift
//  NewVocab
//
//  Created by MasterBi on 13/10/24.
//
import SwiftUI

struct WordFormView: View {
    var title: String
    var icon: String
    var forms: [RelatedWord?]
    @State private var currentPage: Int = 0
    
    var body: some View {
        CustomStackView {
            Label {
                Text(title)
                    .font(.caption)
            } icon: {
                Image(systemName: icon)
            }
        } contentView: {
            ZStack {
                VStack {
                    TabView(selection: $currentPage) {
                        ForEach(forms.compactMap { $0 }.indices, id: \.self) { index in
                            RelatedWordPage(form: forms.compactMap { $0 }[index])
                                .tag(index)
                        }
                        Spacer()
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    Spacer()
                }
                
                if forms.count > 1 {
                    CustomPageControl(numberOfPages: forms.count, currentPage: $currentPage)
                        .padding(.top, 90)
                }
            }
        }
        .padding(.horizontal, 15)
        .frame(width: UIScreen.main.bounds.width, height: 190)
    }
}

private struct RelatedWordPage: View {
    let form: RelatedWord
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                
//                Spacer()
                
                // Left side: Word info
                VStack(alignment: .leading, spacing: 6) {
                    Text(form.relationType.rawValue)
                        .font(.system(size: 10, weight: .medium))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                    
                    Text(form.word)
                        .font(.system(size: 18, weight: .bold))
                    
                    Text(form.englishMeaning)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.8))
                }
                .layoutPriority(1)
                
                Spacer()
                
                // Right side: Example
                if let example = form.example {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(example.example)
                            .multilineTextAlignment(.trailing)
                            .font(.system(size: 12))
                            .italic()
                            .lineLimit(3)
                        
                        Text(example.englishMeaning)
                            .multilineTextAlignment(.trailing)
                            .font(.system(size: 11))
                            .foregroundColor(.white.opacity(0.7))
                            .lineLimit(3)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
//                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 15)
            
            Spacer()
        }
    }
}
