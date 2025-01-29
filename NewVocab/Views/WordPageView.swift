//
//  WordPageView.swift
//  NewVocab
//
//  Created by MasterBi on 20/9/24.
//
import AVFoundation
import SwiftUI

struct WordPageView: View {
    let word: FrenchWordType
    let namespace: Namespace.ID
	@State private var liked: [Like] = []
    @State private var randomIndex: Int = 0
    @State private var synthesizer = AVSpeechSynthesizer()
    
	private func getWordText(_ word: FrenchWordType) -> String {
		switch word {
			case .verb(let verb): return verb.word
			case .noun(let noun): return noun.word
			case .adjective(let adj): return adj.word
			case .adverb(let adv): return adv.word
		}
	}
    
    private var ipaText: String {
        switch word {
        case .verb(let verb): return verb.frenchWordAttribute.wordAttribute.ipa
        case .noun(let noun): return noun.frenchWordAttribute.wordAttribute.ipa
        case .adjective(let adj): return adj.frenchWordAttribute.wordAttribute.ipa
        case .adverb(let adv): return adv.frenchWordAttribute.wordAttribute.ipa
        }
    }
    
    private var englishMeaning: String {
        switch word {
        case .verb(let verb): return verb.frenchWordAttribute.wordAttribute.englishMeaning
        case .noun(let noun): return noun.frenchWordAttribute.wordAttribute.englishMeaning
        case .adjective(let adj): return adj.frenchWordAttribute.wordAttribute.englishMeaning
        case .adverb(let adv): return adv.frenchWordAttribute.wordAttribute.englishMeaning
        }
    }
    
    private var examples: [Example] {
        switch word {
        case .verb(let verb): return verb.frenchWordAttribute.wordAttribute.examples
        case .noun(let noun): return noun.frenchWordAttribute.wordAttribute.examples
        case .adjective(let adj): return adj.frenchWordAttribute.wordAttribute.examples
        case .adverb(let adv): return adv.frenchWordAttribute.wordAttribute.examples
        }
    }
    
    private var grammaticalCategory: GrammaticalCategory {
        switch word {
        case .verb(let verb): return verb.frenchWordAttribute.wordAttribute.grammaticalCategory
        case .noun(let noun): return noun.frenchWordAttribute.wordAttribute.grammaticalCategory
        case .adjective(let adj): return adj.frenchWordAttribute.wordAttribute.grammaticalCategory
        case .adverb(let adv): return adv.frenchWordAttribute.wordAttribute.grammaticalCategory
        }
    }
    
    private var combinedGradientColors: [Color] {
        switch word {
        case .verb(let verb): return verb.frenchWordAttribute.wordAttribute.combinedGradientColors
        case .noun(let noun): return noun.frenchWordAttribute.wordAttribute.combinedGradientColors
        case .adjective(let adj): return adj.frenchWordAttribute.wordAttribute.combinedGradientColors
        case .adverb(let adv): return adv.frenchWordAttribute.wordAttribute.combinedGradientColors
        }
    }
    
    var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .topLeading) {
				WordBackgroundView(word: word)
				
				ZStack {
					ForEach(liked) { like in
						AnimatedHeartView(
							color: combinedGradientColors[0],
							like: like
						)
						.onDisappear {
							liked.removeAll(where: { $0.id == like.id })
						}
					}
				}
				
				ZStack(alignment: .center) {
					VStack(spacing: 20) {
						Spacer()
						
						Text(getWordText(word))
							.font(.system(size: 56, weight: .bold, design: .serif))
							.matchedGeometryEffect(id: getWordText(word), in: namespace)
							.foregroundStyle(
								LinearGradient(
									colors: [
										combinedGradientColors[0],
										combinedGradientColors[1],
									],
									startPoint: .topLeading,
									endPoint: .bottomTrailing
								)
							)
						
						HStack {
							Text("\(ipaText)")
								.font(.title2)
								.matchedGeometryEffect(id: ipaText, in: namespace)
								.foregroundColor(.gray)
							
							Button(action: {
								speakWord(wordText: getWordText(word), synthesizer: synthesizer)
							}) {
								Image(systemName: "speaker.wave.2")
									.font(.title2)
									.foregroundColor(.gray)
							}
							.matchedGeometryEffect(id: word.id, in: namespace)
						}
						
						Text("(\(grammaticalCategory.rawValue)) \(englishMeaning)")
							.font(.title3)
							.matchedGeometryEffect(id: englishMeaning, in: namespace)
							.foregroundColor(.black.opacity(0.8))
						
						VStack(spacing: 12) {
							Text(examples[randomIndex].example)
								.font(.body)
								.italic()
								.foregroundColor(.black.opacity(0.7))
								.multilineTextAlignment(.center)
							
							Text(examples[randomIndex].englishMeaning)
								.font(.subheadline)
								.foregroundColor(.black.opacity(0.6))
						}
						.padding(.top, 30)
						
						Spacer()
					}
					.padding(.horizontal, 30)
				}
				.frame(width: geometry.size.width, height: geometry.size.height)
			}
			.onAppear {
				randomIndex = examples.indices.randomElement() ?? 0
			}
			.onTapGesture(count: 2, coordinateSpace: .local) { position in
				let id = UUID()
				liked.append(.init(id: id, tappedRect: position, isAnimated: false))
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
					withAnimation {
						if let idx = liked.firstIndex(where: { $0.id == id }) {
							liked[idx].isAnimated = true
						}
					}
				}
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
					liked.removeAll(where: { $0.id == id })
				}
			}
		}
    }
}

// MARK: - Detail Overlay
private struct DetailOverlayView: View {
	@Binding var selectedWord: FrenchWordType?
	@Binding var showDetail: Bool
	let size: CGSize
	
	var body: some View {
		GeometryReader { geometry in
			let topEdge = geometry.safeAreaInsets.top + 60
			
			if let selectedWord = selectedWord {
				WordDetailView(word: selectedWord, namespace: Namespace().wrappedValue, showDetail: $showDetail, topEdge: topEdge)
					.frame(width: size.width, height: size.height)
			} else {
				Text("No word selected")
					.frame(width: size.width, height: size.height)
			}
		}
	}
}

// MARK: - HeartOverlayView
private struct HeartOverlayView: View {
	let color: Color
	@Binding var liked: [Like]
	
	var body: some View {
		ZStack {
			ForEach(liked) { like in
				AnimatedHeartView(
					color: color,
					like: like
				)
				.onDisappear {
					liked.removeAll(where: { $0.id == like.id })
				}
			}
		}
	}
}

// MARK: - Animated Heart View
private struct AnimatedHeartView: View {
	let color: Color
	let like: Like
	
	var body: some View {
		Image(systemName: "suit.heart.fill")
			.font(.system(size: 75))
			.foregroundStyle(color)
			.frame(width: 100, height: 100)
			.modifier(HeartAnimationModifier(isAnimated: like.isAnimated))
			.offset(
				x: like.tappedRect.x - 50,
				y: like.tappedRect.y - 50
			)
	}
}

struct HeartAnimationModifier: ViewModifier {
	let isAnimated: Bool
	
	func body(content: Content) -> some View {
		content
			.scaleEffect(isAnimated ? 2.5 : 1)
			.rotationEffect(.degrees(isAnimated ? .random(in: -25...25) : 0))
			.offset(y: isAnimated ? -80 : 0)
			.opacity(isAnimated ? 0 : 1)
			.animation(
				.interpolatingSpring(
					mass: 1.0,
					stiffness: 80,
					damping: 10,
					initialVelocity: 0
				)
				.speed(0.6),
				value: isAnimated
			)
	}
}
