//
//  FrenchAdverbCustomTab.swift.swift
//  NewVocab
//
//  Created by MasterBi on 19/10/24.
//

import SwiftUI

private struct AdverbFirstTabView: View {
	let word: FrenchAdverb
	
	var body: some View {
		VStack {
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
				
				MiniSimpleDetailView(title: "TYPICAL POSITION",
									 icon: "arrow.right",
									 dataTitle: word.typicalPosition.rawValue,
									 dataSubtitle: "",
									 side: .right)
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
					LevelGraphView(level: word.frenchWordAttribute.wordAttribute.level)
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
						Text(word.isIrregularComparison ? "Yes" : "No")
							.font(.largeTitle)
							.bold()
							.padding(.vertical, 10)
						Text(word.isIrregularComparison ?
							 "This word has irregular comparison forms" :
								"This word doesn't have irregular comparison forms")
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
			
			if word.frenchWordAttribute.wordAttribute.relatedWords.count > 0 {
				WordFormView(title: "RELATED WORDS",
							 icon: "r.circle",
							 forms: word.frenchWordAttribute.wordAttribute.relatedWords)
			}
			
			if let comparativeForm = word.comparativeForm {
				ComparisionFormView(title: "COMPARATIVE FORM",
									icon: "greaterthan.circle",
									form: comparativeForm)
			}
			
			if let superlativeForm = word.superlativeForm {
				ComparisionFormView(title: "SUPERLATIVE FORM",
									icon: "greaterthan.circle.fill",
									form: superlativeForm)
			}
			
			if let etymology = word.frenchWordAttribute.wordAttribute.etymology {
				EtymologyView(etymology: etymology)
			}
		}
	}
}

struct FrenchAdverbCustomTab: View {
	let word: FrenchAdverb
	@Binding var selectedTab: Int
	@Binding var stackContentHeight: CGFloat
	@State var firstTabHeight: CGFloat = 0
	@State var secondTabHeight: CGFloat = 0
	
	var body: some View {
		ScrollViewReader { proxy in
			ScrollView(.horizontal, showsIndicators: false) {
				LazyHStack(alignment: .top, spacing: 0) {
					ForEach(0...1, id: \.self) { index in
						VStack {
							if index == 0 {
								// Tab for displaying word properties
								AdverbFirstTabView(word: word)
								.background(
									GeometryReader { geometry in
										Color.clear.onAppear {
											stackContentHeight = geometry.size.height
											firstTabHeight = geometry.size.height
										}
										.onChange(of: geometry.size.height) { _, newValue in
											firstTabHeight = newValue
											if selectedTab == 0 {
												stackContentHeight = newValue
											}
										}
									}
								)
							} else {
								ExamplesView(examples: word.frenchWordAttribute.wordAttribute.examples)
									.background(
										GeometryReader { geometry in
											Color.clear.onAppear {
												secondTabHeight = geometry.size.height
											}
											.onChange(of: geometry.size.height) { _, newValue in
												secondTabHeight = newValue
												if selectedTab == 1 {
													stackContentHeight = newValue
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
			.onChange(of: selectedTab) { oldValue, newValue in
				stackContentHeight = selectedTab == 0 ? firstTabHeight : secondTabHeight
			}
		}
	}
}
