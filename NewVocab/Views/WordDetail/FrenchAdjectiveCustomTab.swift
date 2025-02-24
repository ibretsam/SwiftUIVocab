//
//  FrenchAdjectiveCustomTab.swift
//  NewVocab
//
//  Created by MasterBi on 19/10/24.
//

import SwiftUI

struct FrenchAdjectiveCustomTab: View {
    let word: FrenchAdjective
    @Binding var selectedTab: Int
    @Binding var stackContentHeight: CGFloat
    @State var firstTabHeight: CGFloat = 0
    @State var secondTabHeight: CGFloat = 0
    
    var body: some View {
            ScrollViewReader { _ in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 0) {
                        ForEach(0...1, id: \.self) { index in
                            VStack {
                                if index == 0 {
                                    firstTabView
                                        .background(
                                            GeometryReader { geometry in
                                                Color.clear.onAppear {
                                                    stackContentHeight = geometry.size.height
                                                    firstTabHeight = geometry.size.height
                                                }
                                                .onChange(of: geometry.size.height) { _, newHeight in
                                                    firstTabHeight = newHeight
                                                    if selectedTab == 0 {
                                                        stackContentHeight = newHeight
                                                    }
                                                }
                                            }
                                        )
                                } else {
                                    ExamplesView(examples: word.examples)
                                        .background(
                                            GeometryReader { geometry in
                                                Color.clear.onAppear {
                                                    secondTabHeight = geometry.size.height
                                                }
                                                .onChange(of: geometry.size.height) { _, newHeight in
                                                    secondTabHeight = newHeight
                                                    if selectedTab == 1 {
                                                        stackContentHeight = newHeight
                                                    }
                                                }
                                            }
                                        )
                                }
                            }
                        }
                    }
                }
                .scrollTargetLayout()
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: .init(
                    get: { selectedTab },
                    set: { newValue in
                        if let newValue {
                            selectedTab = newValue
                        }
                    }
                ))
                .onChange(of: selectedTab) { _, _ in
                    stackContentHeight = selectedTab == 0 ? firstTabHeight : secondTabHeight
                }
            }
        }
    
    private var firstTabView: some View {
        VStack {
            // Gender and number agreement
            HStack {
                MiniGenderView(genderForms: [word.masculineForm, word.feminineForm])
            }.frame(width: UIScreen.main.bounds.width)
            
            // Position and usage
            HStack {
                CustomStackView {
                    Label {
                        Text("DEFAULT POSITION")
                            .font(.caption)
                    } icon: {
                        Image(systemName: "arrow.right")
                    }
                } contentView: {
                    AdjectivePositionView(word: word)
                }
                .padding(.leading, 20)
                .frame(width: UIScreen.main.bounds.width / 2, height: 190)
                
                CustomStackView {
                    Label {
                        Text("FREQUENCY")
                            .font(.caption)
                    } icon: {
                        Image(systemName: "chart.bar")
                    }
                } contentView: {
					FrequencyGraphView(frequency: word.frenchWordAttribute.wordAttribute.frequency)
                }
                .padding(.trailing, 20)
                .frame(width: UIScreen.main.bounds.width / 2, height: 190)
            }
            .frame(width: UIScreen.main.bounds.width)
            
            HStack {
                CustomStackView {
                    Label {
                        Text("LEVEL")
                            .font(.caption)
                    } icon: {
                        Image(systemName: "square.stack.3d.up.fill")
                    }
                } contentView: {
                    LevelGraphView(level: word.level)
                }
                .padding(.leading, 20)
                .frame(width: UIScreen.main.bounds.width / 2, height: 190)
                
                CustomStackView {
                    Label {
                        Text("IRREGULAR")
                            .font(.caption)
                    } icon: {
                        Image(systemName: "arrow.trianglehead.branch")
                    }
                } contentView: {
                    VStack {
                        Text("\(word.isIrregularComparison == true ? "Yes" : "No")")
                            .font(.largeTitle)
                            .bold()
                            .padding(.vertical, 10)
                        Text("\(word.isIrregularComparison == true ? "This word has irregular comparison forms" : "This word doesn't has irregular comparison forms")")
                            .font(.callout)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                        Spacer()
                    }
                    .padding()
                }
                .padding(.trailing, 20)
                .frame(width: UIScreen.main.bounds.width / 2, height: 190)
                
            }
            .frame(width: UIScreen.main.bounds.width)
            
			if word.frenchWordAttribute.wordAttribute.relatedWords.count > 0 {
                WordFormView(title: "RELATED WORDS", icon: "r.circle", forms: word.frenchWordAttribute.wordAttribute.relatedWords)
            }
            
            // Comparison Forms
            if let comparativeForm = word.comparativeForm {
                ComparisionFormView(title: "COMPARATIVE FORM", icon: "greaterthan.circle", form: comparativeForm)
            }
            
            if let superlativeForm = word.superlativeForm {
                ComparisionFormView(title: "SUPERLATIVE FORM", icon: "greaterthan.circle.fill", form: superlativeForm)
            }
            
            if let preposition = word.requiresPreposition {
                PrepositionView(preposition: preposition)
            }
            
			if let etymology = word.frenchWordAttribute.wordAttribute.etymology {
                EtymologyView(etymology: etymology)
            }
        }
    }
}
