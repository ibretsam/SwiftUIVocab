//
//  Extensions.swift
//  NewVocab
//
//  Created by MasterBi on 13/12/2024.
//

import Foundation
import SwiftData

// Base type conversions
extension WordAttribute {
	convenience init(from proto: Vocab_WordAttribute) {
		self.init(
			word: proto.word,
			englishMeaning: proto.englishMeaning,
			ipa: proto.ipa,
			examples: proto.examples.map { Example(from: $0) },
			level: LanguageLevel(from: proto.level),
			grammaticalCategory: GrammaticalCategory(from: proto.grammaticalCategory),
			relatedWords: proto.relatedWords.map { RelatedWord(from: $0) },
			frequency: FrequencyLevel(from: proto.frequency),
			subjectDomains: proto.subjectDomains.map { SubjectDomain(from: $0) },
			formalityLevel: FormalityLevel(from: proto.formalityLevel),
			etymology: proto.hasEtymology ? Etymology(from: proto.etymology) : nil,
			culturalNotes: proto.culturalNotes.map { CulturalNote(from: $0) }
		)
	}
}

extension Example {
	convenience init(from proto: Vocab_Example) {
		self.init(
			id: UUID(),
			example: proto.text,  // Changed from proto.example to proto.text
			englishMeaning: proto.englishMeaning
		)
	}
}

extension RegionalUsage {
	convenience init(from proto: Vocab_RegionalUsage) {
		self.init(
			region: FrenchRegion(from: proto.region),
			usage: "Standard",  // RegionalUsage in proto only has region and example
			example: proto.hasExample ? Example(from: proto.example) : nil
		)
	}
}

extension PronunciationVariation {
	convenience init(from proto: Vocab_PronunciationVariation) {
		self.init(
			region: .france,  // Default since proto doesn't have region
			ipa: proto.variation,  // Use variation field as IPA
			notes: proto.description_p  // Use description field as notes
		)
	}
}

extension FalseFriend {
	convenience init(from proto: Vocab_FalseFriend) {
		let languageStr = proto.language == .french ? "french" : "english"
		self.init(
			language: languageStr,
			word: proto.word,
			meaning: proto.englishMeaning
		)
	}
}

// Verb-related conversions
extension FrenchConjugation {
	convenience init(from proto: Vocab_FrenchConjugation) {
		self.init(moods: proto.moods.map { FrenchMood(from: $0) })
	}
}

extension FrenchMood {
	convenience init(from proto: Vocab_FrenchMood) {
		self.init(
			id: UUID(),
			name: FrenchMoodName(from: proto.name),
			tenses: proto.tenses.map { FrenchTense(from: $0) }
		)
	}
}

extension FrenchTense {
	convenience init(from proto: Vocab_FrenchTense) {
		self.init(
			id: UUID(),
			name: FrenchTenseName(from: proto.name),
			conjugations: proto.conjugations.map { FrenchConjugationForm(from: $0) },
			example: proto.hasExample ? Example(from: proto.example) : nil
		)
	}
}

extension FrenchConjugationForm {
	convenience init(from proto: Vocab_FrenchConjugationForm) {
		self.init(
			pronoun: FrenchPronoun(from: proto.pronoun),
			form: proto.form
		)
	}
}

// Position and comparison forms
extension AdjectivePosition {
	convenience init(from proto: Vocab_AdjectivePosition) {
		self.init(
			position: Position(from: proto.position),
			example: Example(from: proto.example)
		)
	}
}

extension ComparisonForms {
	convenience init(from proto: Vocab_ComparisonForms) {
		self.init(
			masculine: proto.masculine,
			feminine: proto.feminine,
			example: proto.hasExample ? Example(from: proto.example) : nil
		)
	}
}

// Enum conversions
extension Position {
	init(from proto: Vocab_Position) {
		switch proto {
			case .beforeNoun: self = .before
			case .afterNoun: self = .after
			case .both: self = .both
			default: self = .after
		}
	}
}

extension AdverbPosition {
	init(from proto: Vocab_AdverbPosition) {
		switch proto {
			case .beginning: self = .beginning
			case .afterVerb: self = .afterVerb
			case .endOfSentence: self = .endOfSentence
			case .flexible: self = .flexible
			default: self = .flexible
		}
	}
}

extension AdverbModifies {
	init(from proto: Vocab_AdverbModifies) {
		switch proto {
			case .verb: self = .verb
			case .adjective: self = .adjective
			case .adverb: self = .adverb
			case .entireSentence: self = .entireSentence
			case .multiple: self = .multiple
			default: self = .verb
		}
	}
}

extension LanguageLevel {
	init(from proto: Vocab_LanguageLevel) {
		switch proto {
			case .a1: self = .a1
			case .a2: self = .a2
			case .b1: self = .b1
			case .b2: self = .b2
			case .c1: self = .c1
			case .c2: self = .c2
			default: self = .a1
		}
	}
}

extension GrammaticalCategory {
	init(from proto: Vocab_GrammaticalCategory) {
		switch proto {
			case .verb: self = .verb
			case .noun: self = .noun
			case .adjective: self = .adjective
			case .adverb: self = .adverb
			default: self = .noun
		}
	}
}

extension FrequencyLevel {
	init(from proto: Vocab_FrequencyLevel) {
		switch proto {
			case .veryCommon: self = .veryCommon
			case .common: self = .common
			case .uncommon: self = .uncommon
			case .rare: self = .rare
			case .veryRare: self = .veryRare
			default: self = .common
		}
	}
}

extension SubjectDomain {
	init(from proto: Vocab_SubjectDomain) {
		switch proto {
			case .general: self = .general
			case .lifestyle: self = .lifestyle
			case .emotions: self = .emotions
			case .home: self = .home
			case .food: self = .food
			case .animals: self = .animals
			case .aesthetics: self = .aesthetics
			case .temporal: self = .temporal
			case .manners: self = .manners
			default: self = .general
		}
	}
}

extension FormalityLevel {
	init(from proto: Vocab_FormalityLevel) {
		switch proto {
			case .formal: self = .formal
			case .informal: self = .informal
			case .archaic: self = .archaic
			case .modern: self = .modern
			case .standard: self = .standard
			case .vulgar: self = .vulgar
			case .literary: self = .literary
			default: self = .standard
		}
	}
}

// Model type conversions
extension Etymology {
	init(from proto: Vocab_Etymology) {
		self.init(
			origin: proto.origin,
			originalWord: proto.originalWord,
			evolutionSteps: proto.evolutionSteps
		)
	}
}

extension CulturalNote {
	init(from proto: Vocab_CulturalNote) {
		self.init(
			note: proto.note,
			idioms: proto.idioms,
			culturalContext: proto.culturalContext
		)
	}
}

extension RelatedWord {
	convenience init(from proto: Vocab_RelatedWord) {
		self.init(
			word: proto.word,
			englishMeaning: proto.englishMeaning,
			example: proto.hasExample ? Example(from: proto.example) : nil,
			relationType: WordRelationType(from: proto.relationType)
		)
	}
}

extension WordRelationType {
	init(from proto: Vocab_WordRelationType) {
		switch proto {
			case .homophone: self = .homophone
			case .wordFamily: self = .wordFamily
			case .diminutive: self = .diminutive
			case .augmentative: self = .augmentative
			case .collective: self = .collective
			case .compound: self = .compound
			default: self = .wordFamily
		}
	}
}

extension FrenchRegion {
	init(from proto: Vocab_FrenchRegion) {
		switch proto {
			case .france: self = .france
			case .quebec: self = .quebec
			case .belgium: self = .belgium
			case .switzerland: self = .switzerland
			case .africa: self = .africa
			default: self = .france
		}
	}
}

extension FrenchMoodName {
	init(from proto: Vocab_FrenchMoodName) {
		switch proto {
			case .indicatif: self = .indicatif
			case .conditionnel: self = .conditionnel
			case .subjonctif: self = .subjonctif
			case .imperatif: self = .impératif
			case .gerondif: self = .gérondif
			default: self = .indicatif
		}
	}
}

extension FrenchTenseName {
	init(from proto: Vocab_FrenchTenseName) {
		switch proto {
			case .present: self = .présent
			case .imparfait: self = .imparfait
			case .passeCompose: self = .passéComposé
			case .passeSimple: self = .passéSimple
			case .futurSimple: self = .futurSimple
			case .plusQueParfait: self = .plusQueParfait
			case .passeAnterieur: self = .passéAntérieur
			case .futurAnterieur: self = .futurAntérieur
			case .passe: self = .passé
			default: self = .présent
		}
	}
}

extension FrenchPronoun {
	init(from proto: Vocab_FrenchPronoun) {
		switch proto {
			case .je: self = .je
			case .tu: self = .tu
			case .il: self = .il
			case .elle: self = .elle
			case .on: self = .on
			case .nous: self = .nous
			case .vous: self = .vous
			case .ils: self = .ils
			case .elles: self = .elles
			case .en: self = .en
			default: self = .je
		}
	}
}

extension FrenchGender {
	init(from proto: Vocab_FrenchGender) {
		switch proto {
			case .masculine: self = .masculine
			case .feminine: self = .feminine
			default: self = .masculine
		}
	}
}
