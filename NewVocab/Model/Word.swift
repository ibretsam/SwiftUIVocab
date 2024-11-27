//
//  Word.swift
//  NewVocab
//
//  Created by MasterBi on 16/9/24.
//

import SwiftUI
import SwiftData

protocol WordProtocol {
    var word: String { get }
    var englishMeaning: String { get }
    var ipa: String { get }
    var examples: [Example] { get }
    var level: LanguageLevel { get }
    var grammaticalCategory: GrammaticalCategory { get }
}

@Model
class WordAttribute: Identifiable, WordProtocol {
    var word: String
    var englishMeaning: String
    var ipa: String
    @Relationship(deleteRule: .cascade) var examples: [Example]
    var level: LanguageLevel
    var grammaticalCategory: GrammaticalCategory
    @Relationship(deleteRule: .nullify) var relatedWords: [RelatedWord?]
    var frequency: FrequencyLevel
    var subjectDomains: [SubjectDomain]
    var formalityLevel: FormalityLevel
    @Relationship(deleteRule: .nullify) var etymology: Etymology?
    @Relationship(deleteRule: .nullify) var culturalNotes: [CulturalNote]?
    
    var combinedGradientColors: [Color] {
        let allGradientColors = subjectDomains.flatMap { $0.gradientColors }
        return allGradientColors.isEmpty ? [Color.white, Color.gray] : allGradientColors
    }
    
    
    init(
            word: String,
            englishMeaning: String,
            ipa: String,
            examples: [Example],
            level: LanguageLevel,
            grammaticalCategory: GrammaticalCategory,
            relatedWords: [RelatedWord?],
            frequency: FrequencyLevel,
            subjectDomains: [SubjectDomain],
            formalityLevel: FormalityLevel = .standard,
            etymology: Etymology? = nil,
            culturalNotes: [CulturalNote]? = nil
        ) {
            self.word = word
            self.englishMeaning = englishMeaning
            self.ipa = ipa
            self.examples = examples
            self.level = level
            self.grammaticalCategory = grammaticalCategory
            self.relatedWords = relatedWords
            self.frequency = frequency
            self.subjectDomains = subjectDomains
            self.formalityLevel = formalityLevel
            self.etymology = etymology
            self.culturalNotes = culturalNotes
        }
    
}

// Supporting structures
@Model
class Example: Identifiable, Codable {
	@Attribute(.unique) var id: UUID
	var example: String
	var englishMeaning: String
	
	init(id: UUID, example: String, englishMeaning: String) {
		self.id = id
		self.example = example
		self.englishMeaning = englishMeaning
	}
	
	enum CodingKeys: String, CodingKey {
		case id
		case example
		case englishMeaning
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		example = try container.decode(String.self, forKey: .example)
		englishMeaning = try container.decode(String.self, forKey: .englishMeaning)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(example, forKey: .example)
		try container.encode(englishMeaning, forKey: .englishMeaning)
	}
}

@Model
class RelatedWord: Codable {
	var word: String
	var englishMeaning: String
	@Relationship(deleteRule: .nullify) var example: Example?
	var relationType: WordRelationType
	
	init(word: String, englishMeaning: String, example: Example? = nil, relationType: WordRelationType) {
		self.word = word
		self.englishMeaning = englishMeaning
		self.example = example
		self.relationType = relationType
	}
	
	enum CodingKeys: String, CodingKey {
		case word
		case englishMeaning
		case example
		case relationType
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		word = try container.decode(String.self, forKey: .word)
		englishMeaning = try container.decode(String.self, forKey: .englishMeaning)
		example = try? container.decode(Example?.self, forKey: .example)
		relationType = try container.decode(WordRelationType.self, forKey: .relationType)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(word, forKey: .word)
		try container.encode(englishMeaning, forKey: .englishMeaning)
		try container.encode(example, forKey: .example)
		try container.encode(relationType, forKey: .relationType)
	}
}

// Enums
enum Language: String, Codable {
    case french, chinese
}

enum GrammaticalCategory: String, Codable {
    case verb = "v."
    case noun = "n."
    case adjective = "adj."
    case adverb = "adv."
}

enum LanguageLevel: String, Codable {
    case a1, a2, b1, b2, c1, c2
    var details: (title: String, subtitle: String) {
        switch self {
        case .a1:
            return (title: "A1", subtitle: "Beginner")
        case .a2:
            return (title: "A2", subtitle: "Elementary")
        case .b1:
            return (title: "B1", subtitle: "Intermediate")
        case .b2:
            return (title: "B2", subtitle: "Upper Intermediate")
        case .c1:
            return (title: "C1", subtitle: "Advanced")
        case .c2:
            return (title: "C2", subtitle: "Proficient")
        }
    }
}

enum FrequencyLevel: String, Codable {
    case veryCommon = "Very Common"
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
    case veryRare = "Very Rare"
    
    var details: (title: String, subtitle: String) {
        switch self {
        case .veryCommon:
            return (title: "Very Common", subtitle: "Frequently used in everyday language")
        case .common:
            return (title: "Common", subtitle: "Often used in various contexts")
        case .uncommon:
            return (title: "Uncommon", subtitle: "Not frequently used")
        case .rare:
            return (title: "Rare", subtitle: "Seldom used in everyday language")
        case .veryRare:
            return (title: "Very Rare", subtitle: "Almost never used")
        }
    }
}

enum SubjectDomain: String, Codable {
    case general = "General"
    case lifestyle = "Lifestyle"
    case emotions = "Emotions"
    case home = "Home"
    case food = "Food"
    case animals = "Animals"
    case aesthetics = "Aesthetics"
    case temporal = "Temporal"
    case manners = "Manners"
    
    var gradientColors: [Color] {
        switch self {
        case .general:
            return [Color(hex: "#8FB8CC"), Color(hex: "#B8CCE0"), Color(hex: "#CCB08F")] // Dominant sky blue with cloud and sand
        case .lifestyle:
            return [Color(hex: "#98C9A3"), Color(hex: "#C2E0CC"), Color(hex: "#C998BE")] // Dominant green with mint and rose
        case .emotions:
            return [Color(hex: "#F19DAB"), Color(hex: "#FFB5C1"), Color(hex: "#9DF1E3")] // Dominant cherry with soft pink and mint
        case .home:
            return [Color(hex: "#A7AEE0"), Color(hex: "#C1C6F2"), Color(hex: "#E0D9A7")] // Dominant twilight with periwinkle and butter
        case .food:
            return [Color(hex: "#F2A583"), Color(hex: "#FFBEA1"), Color(hex: "#83D2F2")] // Dominant peach with coral and ocean
        case .animals:
            return [Color(hex: "#9EC4B5"), Color(hex: "#B5D6CA"), Color(hex: "#C49EA8")] // Dominant moss with sage and rose
        case .aesthetics:
            return [Color(hex: "#D4ACC8"), Color(hex: "#E5C6DB"), Color(hex: "#ACD4B6")] // Dominant wisteria with lilac and sage
        case .temporal:
            return [Color(hex: "#99B0CB"), Color(hex: "#B5C6DD"), Color(hex: "#CB99B4")] // Dominant morning blue with sky and sunset
        case .manners:
            return [Color(hex: "#C2AFA1"), Color(hex: "#D6C5B8"), Color(hex: "#A1B4C2")] // Dominant warm beige with cream and cool blue
        }
    }
}

enum FormalityLevel: String, Codable {
    case formal, informal, archaic, modern, standard, vulgar, literary
    
    var details: (title: String, subtitle: String) {
        switch self {
        case .formal:
            return (title: "Formal", subtitle: "Used in formal contexts")
        case .informal:
            return (title: "Informal", subtitle: "Used in casual or familiar contexts")
        case .archaic:
            return (title: "Archaic", subtitle: "No longer in common use")
        case .modern:
            return (title: "Modern", subtitle: "Used in contemporary language")
        case .standard:
            return (title: "Standard", subtitle: "Widely accepted and used")
        case .vulgar:
            return (title: "Vulgar", subtitle: "Offensive or coarse language")
        case .literary:
            return (title: "Literary", subtitle: "Used in literary works")
        }
    }
}

enum WordRelationType: String, Codable {
    case homophone = "Homophone"
    case wordFamily = "Word Family"
    case diminutive = "Diminutive Form"
    case augmentative = "Augmentative Form"
    case collective = "Collective Form"
    case compound = "Compound Form"
}

struct Etymology: Codable {
    let origin: String
    let originalWord: String
    let evolutionSteps: [String]?
}

struct CulturalNote: Codable {
    let note: String
    let idioms: [String]?
    let culturalContext: String
}
