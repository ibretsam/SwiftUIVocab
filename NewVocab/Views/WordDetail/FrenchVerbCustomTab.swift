//
//  TabView.swift
//  NewVocab
//
//  Created by MasterBi on 21/9/24.
//

import SwiftUI

struct FrenchVerbCustomTab: View {
    let word: FrenchVerb
    @Binding var selectedTab: Int
    @Binding var stackContentHeight: CGFloat
    @State private var tabHeights: [Int: CGFloat] = [:]
    
    var body: some View {
        ScrollViewReader { _ in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 0) {
                    // First page with index 0
                    VerbFirstTabView(word: word)
                        .frame(width: UIScreen.main.bounds.width)
                        .id(0)
                        .background(
                            GeometryReader { geometry in
                                Color.clear.onAppear {
                                    tabHeights[0] = geometry.size.height
                                    if selectedTab == 0 {
                                        stackContentHeight = geometry.size.height
                                    }
                                }
                                .onChange(of: geometry.size.height) { _, newValue in
                                    tabHeights[0] = newValue
                                    if selectedTab == 0 {
                                        stackContentHeight = newValue
                                    }
                                }
                            }
                        )
                    
                    // Mood pages starting from index 1
                    ForEach(word.conjugation.moods.indices, id: \.self) { index in
                        TabContent(mood: word.conjugation.moods[index])
                            .frame(width: UIScreen.main.bounds.width)
                            .id(index + 1) // Offset by 1
                            .background(
                                GeometryReader { geometry in
                                    Color.clear.onAppear {
                                        tabHeights[index + 1] = geometry.size.height
                                        if selectedTab == index + 1 {
                                            stackContentHeight = geometry.size.height
                                        }
                                    }
                                    .onChange(of: geometry.size.height) { _, newValue in
                                        tabHeights[index + 1] = newValue
                                        if selectedTab == index + 1 {
                                            stackContentHeight = newValue
                                        }
                                    }
                                }
                            )
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
            .onChange(of: selectedTab) { _, newValue in
                if let newHeight = tabHeights[newValue] {
                    stackContentHeight = newHeight
                }
            }
        }
    }
}

private struct TabContent: View {
    let mood: FrenchMood
    var body: some View {
        VStack {
            ForEach(mood.tenses, id: \.id) { tense in
                CustomStackView {
                    Label  {
                        Text(tense.name.rawValue)
                    } icon: {
                        Image(systemName: "clock")
                    }
                } contentView: {
                    VStack (alignment: .leading) {
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(tense.conjugations, id: \.pronoun) { conjugation in
                                    VStack {
                                        Text(conjugation.pronoun.rawValue.capitalized)
                                        Text(conjugation.form)
                                            .font(.title3)
                                            .bold()
                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(tense.example!.example)
                            Text(tense.example!.englishMeaning)
                        }
                    }
                    .padding()
                }
                .padding(.horizontal, 15)
                .frame(height: 190)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}

private struct VerbFirstTabView: View {
    let word: FrenchVerb
    var body: some View {
        VStack {
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
            
            WordFormView(title: "RELATED WORDS", icon: "r.circle", forms: word.frenchWordAttribute.wordAttribute.relatedWords)
            
			if let etymology = word.frenchWordAttribute.wordAttribute.etymology {
                EtymologyView(etymology: etymology)
            }
        }
    }
}
