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
    @State private var randomIndex: Int = 0
    @State private var synthesizer = AVSpeechSynthesizer()
    
    // Add property accessors
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
        ZStack {
            WordBackgroundView(word: word)
            
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
                    Text("/\(ipaText)/")
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
        .onAppear {
            randomIndex = examples.indices.randomElement() ?? 0
        }
    }
}
