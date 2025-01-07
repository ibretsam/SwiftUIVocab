//
//  Helper.swift
//  NewVocab
//
//  Created by MasterBi on 21/12/2024.
//

import SwiftUI

func getWordColors(for word: FrenchWordType) -> [Color] {
	var combinedGradientColors: [Color] {
		switch word {
			case .verb(let verb): return verb.frenchWordAttribute.wordAttribute.combinedGradientColors
			case .noun(let noun): return noun.frenchWordAttribute.wordAttribute.combinedGradientColors
			case .adjective(let adj): return adj.frenchWordAttribute.wordAttribute.combinedGradientColors
			case .adverb(let adv): return adv.frenchWordAttribute.wordAttribute.combinedGradientColors
		}
	}
	return combinedGradientColors
}
