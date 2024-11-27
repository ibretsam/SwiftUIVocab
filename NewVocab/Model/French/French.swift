//
//  French.swift
//  NewVocab
//
//  Created by MasterBi on 16/9/24.
//

/// A class representing a French word, inheriting from the `Word` class.
/// This class includes additional properties specific to French words such as homophones, word family members, regional usage, pronunciation variations, and false friends.
import Foundation
import SwiftData

@Model
final class FrenchWordAttribute: Identifiable {
    @Relationship(deleteRule: .cascade) var wordAttribute: WordAttribute
    @Relationship(deleteRule: .nullify) var regionalUsage: [RegionalUsage]?
    @Relationship(deleteRule: .nullify) var pronunciationVariations: [PronunciationVariation]?
    @Relationship(deleteRule: .nullify) var falseFriends: [FalseFriend]?
    
    init(
        wordAttribute: WordAttribute,
        regionalUsage: [RegionalUsage]? = nil,
        pronunciationVariations: [PronunciationVariation]? = nil,
        falseFriends: [FalseFriend]? = nil
    ) {
        self.wordAttribute = wordAttribute
        self.regionalUsage = regionalUsage
        self.pronunciationVariations = pronunciationVariations
        self.falseFriends = falseFriends
    }
    
    var word: String { wordAttribute.word }
    var englishMeaning: String { wordAttribute.englishMeaning }
    var ipa: String { wordAttribute.ipa }
    var examples: [Example] { wordAttribute.examples }
    var level: LanguageLevel { wordAttribute.level }
    var grammaticalCategory: GrammaticalCategory { wordAttribute.grammaticalCategory }
}
