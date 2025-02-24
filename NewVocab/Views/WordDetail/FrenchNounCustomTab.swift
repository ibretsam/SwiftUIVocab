//
//  FrenchNounCustomTab.swift
//  NewVocab
//
//  Created by MasterBi on 9/10/24.
//
import SwiftUI

struct FrenchNounCustomTab: View {
    let word: FrenchNoun
    @State var firstTabHeight: CGFloat = 0
    @State var secondTabHeight: CGFloat = 0
    @Binding var selectedTab: Int
    @Binding var stackContentHeight: CGFloat
    
    private var hasMultipleGenders: Bool {
        return word.masculineForm != nil && word.feminineForm != nil
    }
    
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
            if hasMultipleGenders {
                if let masculineForm = word.masculineForm, let feminineForm = word.feminineForm {
                    HStack {
                        MiniGenderView(genderForms: [masculineForm, feminineForm])
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
            } else {
                primaryGenderView
            }
            
            HStack {
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
                .padding(.leading, 20)
                .frame(width: UIScreen.main.bounds.width / 2, height: 190)
                
                MiniSimpleDetailView(title: "FORMALITY", icon: "book.closed", dataTitle: word.frenchWordAttribute.wordAttribute.formalityLevel.details.title, dataSubtitle: word.frenchWordAttribute.wordAttribute.formalityLevel.details.subtitle, side: .right)
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
                        Text("FALSE FRIEND")
                            .font(.caption)
                    } icon: {
                        Image(systemName: "person.fill.questionmark")
                    }
                } contentView: {
                    if let falseFriends = word.frenchWordAttribute.falseFriends {
                        TabView {
                            ForEach(falseFriends, id: \.meaning) { falseFriend in
                                VStack {
                                    HStack {
                                        Text(falseFriend.word)
                                            .bold()
                                        Spacer()
                                    }
                                    HStack {
                                        Text(falseFriend.meaning)
                                        Spacer()
                                    }
                                    Spacer()
                                    HStack {
                                        Text("Language")
                                            .font(.footnote)
                                        Spacer()
                                        Text(falseFriend.language)
                                            .bold()
                                    }
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .padding()
                    }
                }
                .padding(.trailing, 15)
                .frame(width: UIScreen.main.bounds.width / 2, height: 190)
            }
            .frame(width: UIScreen.main.bounds.width)
            
            WordFormView(title: "RELATED WORDS", icon: "r.circle", forms: word.frenchWordAttribute.wordAttribute.relatedWords)
            if let etymology = word.frenchWordAttribute.wordAttribute.etymology {
                EtymologyView(etymology: etymology)
            }
        }
    }
    
    private var primaryGenderView: some View {
        CustomStackView {
            Label {
                Text("PRIMARY GENDER")
                    .font(.caption)
            } icon: {
                Text("⚤")
            }
        } contentView: {
            HStack {
                VStack {
                    Text("\(word.primaryGender == .feminine ? "♀" : "♂")")
                        .font(.largeTitle)
                    Text("\(word.primaryGender.rawValue.capitalized)")
                }
                .padding(.trailing, 15)
                .frame(maxWidth: .infinity)
                .layoutPriority(1)
                
                VStack {
                    HStack {
                        Text("Singular")
                            .font(.footnote)
                        Spacer()
                        if let singular = word.primaryGender == .masculine ? word.masculineForm?.singular : word.feminineForm?.singular {
                            Text(singular.capitalized)
                                .bold()
                        } else {
                            Text("N/A")
                                .bold()
                        }
                    }
                    HStack {
                        Text("Plural")
                            .font(.footnote)
                        Spacer()
                        if let plural = word.primaryGender == .masculine ? word.masculineForm?.plural : word.feminineForm?.plural {
                            Text(plural.capitalized)
                                .bold()
                        } else {
                            Text("N/A")
                                .bold()
                        }
                    }
                    HStack {
                        Text("Definite Article")
                            .font(.footnote)
                        Spacer()
                        if let definiteArticle = word.primaryGender == .masculine ? word.masculineForm?.definiteArticle : word.feminineForm?.definiteArticle {
                            Text(definiteArticle.capitalized)
                                .bold()
                        } else {
                            Text("N/A")
                                .bold()
                        }
                    }
                    HStack {
                        Text("Indefinite Article")
                            .font(.footnote)
                        Spacer()
                        if let indefiniteArticle = word.primaryGender == .masculine ? word.masculineForm?.indefiniteArticle : word.feminineForm?.indefiniteArticle {
                            Text(indefiniteArticle.capitalized)
                                .bold()
                        } else {
                            Text("N/A")
                                .bold()
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .layoutPriority(1)
            }
            .padding()
        }
        .padding(.horizontal, 15)
        .frame(width: UIScreen.main.bounds.width, height: 190)
    }
}
