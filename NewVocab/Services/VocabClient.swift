//
//  VocabClient.swift
//  NewVocab
//
//  Created by MasterBi on 13/12/2024.
//

import GRPC
import NIO
import SwiftProtobuf
import Foundation

@available(iOS 13.0.0, *)
class VocabClient {
	private let client: Vocab_VocabServiceAsyncClient
	private let config: Config
	
	init(config: Config = Config.load()) {
		self.config = config
		let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
		let channel = try! GRPCChannelPool.with(
			target: .host(config.serverHost, port: config.serverPort),
			transportSecurity: .plaintext,
			eventLoopGroup: group
		)
		self.client = Vocab_VocabServiceAsyncClient(channel: channel)
	}
	
	func getRecentWords() async throws -> [FrenchWordType] {
		let request = Vocab_GetRecentWordsRequest.with {
			$0.limit = 10
		}
		let response = try await client.getRecentWords(request)
		return response.words.compactMap { convertToFrenchWordType($0) }
	}
	
	private func convertToFrenchWordType(_ word: Vocab_Word) -> FrenchWordType? {
		switch word.wordType {
			case .frenchVerb(let verb):
				return .verb(createFrenchVerb(from: verb))
			case .frenchNoun(let noun):
				return .noun(createFrenchNoun(from: noun))
			case .frenchAdjective(let adj):
				return .adjective(createFrenchAdjective(from: adj))
			case .frenchAdverb(let adv):
				return .adverb(createFrenchAdverb(from: adv))
			case .none:
				return nil
		}
	}
	
	private func createFrenchVerb(from proto: Vocab_FrenchVerb) -> FrenchVerb {
		FrenchVerb(
			id: UUID(),
			frenchWordAttribute: createFrenchWordAttribute(from: proto.base),
			infinitive: proto.infinitive,
			conjugation: createFrenchConjugation(from: proto.conjugation)
		)
	}
	
	private func createFrenchNoun(from proto: Vocab_FrenchNoun) -> FrenchNoun {
		FrenchNoun(
			id: UUID(),
			frenchWordAttribute: createFrenchWordAttribute(from: proto.base),
			masculineForm: proto.hasMasculineForm ? createGenderForm(from: proto.masculineForm) : nil,
			feminineForm: proto.hasFeminineForm ? createGenderForm(from: proto.feminineForm) : nil,
			primaryGender: FrenchGender(from: proto.primaryGender),
			isCountable: proto.isCountable
		)
	}
	
	private func createFrenchAdjective(from proto: Vocab_FrenchAdjective) -> FrenchAdjective {
		FrenchAdjective(
			id: UUID(),
			frenchWordAttribute: createFrenchWordAttribute(from: proto.base),
			masculineForm: createGenderForm(from: proto.masculineForm),
			feminineForm: createGenderForm(from: proto.feminineForm),
			defaultPosition: createAdjectivePosition(from: proto.defaultPosition),
			comparativeForm: proto.hasComparativeForm ? createComparisonForms(from: proto.comparativeForm) : nil,
			superlativeForm: proto.hasSuperlativeForm ? createComparisonForms(from: proto.superlativeForm) : nil,
			isIrregularComparison: proto.isIrregularComparison,
			requiresPreposition: proto.hasRequiresPreposition ? createPrepositionRequirement(from: proto.requiresPreposition) : nil
		)
	}
	
	private func createFrenchAdverb(from proto: Vocab_FrenchAdverb) -> FrenchAdverb {
		FrenchAdverb(
			id: UUID(),
			frenchWordAttribute: createFrenchWordAttribute(from: proto.base),
			derivedFromAdjective: proto.derivedFromAdjective,
			sourceAdjective: proto.sourceAdjective,
			typicalPosition: AdverbPosition(from: proto.typicalPosition),
			modifies: AdverbModifies(from: proto.modifies),
			comparativeForm: proto.hasComparativeForm ? createComparisonForms(from: proto.comparativeForm) : nil,
			superlativeForm: proto.hasSuperlativeForm ? createComparisonForms(from: proto.superlativeForm) : nil,
			isIrregularComparison: proto.isIrregularComparison
		)
	}
	
	private func createFrenchWordAttribute(from proto: Vocab_FrenchWordAttribute) -> FrenchWordAttribute {
		let wordAttribute = WordAttribute(from: proto.base)
		let regionalUsages = proto.regionalUsage.map { createRegionalUsage(from: $0) }
		let pronunciationVariations = proto.pronunciationVariations.map { createPronunciationVariation(from: $0) }
		let falseFriends = proto.falseFriends.map { createFalseFriend(from: $0) }
		
		return FrenchWordAttribute(
			wordAttribute: wordAttribute,
			regionalUsage: regionalUsages,
			pronunciationVariations: pronunciationVariations,
			falseFriends: falseFriends
		)
	}
}

extension VocabClient {
	private func createGenderForm(from proto: Vocab_GenderForm) -> GenderForm {
		GenderForm(
			gender: FrenchGender(from: proto.gender),
			singular: proto.singular,
			plural: proto.plural,
			definiteArticle: proto.hasDefiniteArticle ? proto.definiteArticle : nil,
			indefiniteArticle: proto.hasIndefiniteArticle ? proto.indefiniteArticle : nil
		)
	}
	
	private func createAdjectivePosition(from proto: Vocab_AdjectivePosition) -> AdjectivePosition {
		let position = Position(from: proto.position)
		let example = Example(from: proto.example)
		
		return AdjectivePosition(
			position: position,
			example: example
		)
	}
	
	private func createComparisonForms(from proto: Vocab_ComparisonForms) -> ComparisonForms {
		ComparisonForms(
			masculine: proto.masculine,
			feminine: proto.feminine,
			example: proto.hasExample ? Example(from: proto.example) : nil
		)
	}
	
	private func createPrepositionRequirement(from proto: Vocab_PrepositionRequirement) -> PrepositionRequirement {
		let example = proto.hasExample ? Example(from: proto.example) : Example(
			id: UUID(),
			example: "",
			englishMeaning: ""
		)
		
		return PrepositionRequirement(
			preposition: proto.preposition,
			usage: proto.usage,
			example: example
		)
	}
	
	private func createRegionalUsage(from proto: Vocab_RegionalUsage) -> RegionalUsage {
		RegionalUsage(
			region: FrenchRegion(from: proto.region),
			usage: "Standard", // RegionalUsage in proto only has region and example
			example: proto.hasExample ? Example(from: proto.example) : nil
		)
	}
	
	private func createPronunciationVariation(from proto: Vocab_PronunciationVariation) -> PronunciationVariation {
		PronunciationVariation(
			region: .france, // Default since proto doesn't have region
			ipa: proto.variation,
			notes: proto.description_p
		)
	}
	
	private func createFalseFriend(from proto: Vocab_FalseFriend) -> FalseFriend {
		FalseFriend(
			language: proto.language == .french ? "french" : "english",
			word: proto.word,
			meaning: proto.englishMeaning
		)
	}
	
	private func createFrenchConjugation(from proto: Vocab_FrenchConjugation) -> FrenchConjugation {
		FrenchConjugation(
			moods: proto.moods.map { FrenchMood(from: $0) }
		)
	}
}
