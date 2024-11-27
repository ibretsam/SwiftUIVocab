//
//  FrenchNoun.swift
//  NewVocab
//
//  Created by MasterBi on 19/10/24.
//
import Foundation
import SwiftData

@Model
class FrenchNoun: Identifiable {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade) var frenchWordAttribute: FrenchWordAttribute
    var masculineForm: GenderForm?
    var feminineForm: GenderForm?
    var primaryGender: FrenchGender
    var isCountable: Bool
    
    init(
        id: UUID,
        frenchWordAttribute: FrenchWordAttribute,
        masculineForm: GenderForm?,
        feminineForm: GenderForm?,
        primaryGender: FrenchGender,
        isCountable: Bool = true
    ) {
        self.id = id
        self.frenchWordAttribute = frenchWordAttribute
        self.masculineForm = masculineForm
        self.feminineForm = feminineForm
        self.primaryGender = primaryGender
        self.isCountable = isCountable
    }
    
    // Delegate properties
    var word: String { frenchWordAttribute.word }
    var englishMeaning: String { frenchWordAttribute.englishMeaning }
    var ipa: String { frenchWordAttribute.ipa }
    var examples: [Example] { frenchWordAttribute.examples }
    var level: LanguageLevel { frenchWordAttribute.level }
}

struct GenderForm: Codable {
    let gender: FrenchGender
    let singular: String
    let plural: String
    let definiteArticle: String?
    let indefiniteArticle: String?
}

@Model
class WordFamilyMember {
    var word: String
    var englishMeaning: String
    var example: Example?
    
    init(word: String, englishMeaning: String, example: Example? = nil) {
        self.word = word
        self.englishMeaning = englishMeaning
        self.example = example
    }
}

@Model
class WordForm {
    var word: String
    var englishMeaning: String
    var example: Example?
    
    init(word: String, englishMeaning: String, example: Example? = nil) {
        self.word = word
        self.englishMeaning = englishMeaning
        self.example = example
    }
}

@Model
class RegionalUsage {
    var region: FrenchRegion
    var usage: String
    var example: Example?
    
    init(region: FrenchRegion, usage: String, example: Example? = nil) {
        self.region = region
        self.usage = usage
        self.example = example
    }
}

@Model
class PronunciationVariation {
    var region: FrenchRegion
    var ipa: String
    var notes: String?
    
    init(region: FrenchRegion, ipa: String, notes: String? = nil) {
        self.region = region
        self.ipa = ipa
        self.notes = notes
    }
}

@Model
class FalseFriend {
    var language: String
    var word: String
    var meaning: String
    
    init(language: String, word: String, meaning: String) {
        self.language = language
        self.word = word
        self.meaning = meaning
    }
}

enum FrenchGender: String, Codable {
    case masculine, feminine
}

enum FrenchRegion: String, Codable {
    case france = "France"
    case quebec = "Québec"
    case belgium = "Belgium"
    case switzerland = "Switzerland"
    case africa = "African French"
}
