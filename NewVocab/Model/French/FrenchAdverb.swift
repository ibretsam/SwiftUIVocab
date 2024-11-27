//
//  FrenchAdverb.swift
//  NewVocab
//
//  Created by MasterBi on 19/10/24.
//
import Foundation
import SwiftData

@Model
class FrenchAdverb: Identifiable {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade) var frenchWordAttribute: FrenchWordAttribute
    var derivedFromAdjective: Bool
    var sourceAdjective: String?
    var typicalPosition: AdverbPosition
    var modifies: AdverbModifies
    var comparativeForm: ComparisonForms?
    var superlativeForm: ComparisonForms?
    var isIrregularComparison: Bool
    
    init(
        id: UUID,
        frenchWordAttribute: FrenchWordAttribute,
        derivedFromAdjective: Bool,
        sourceAdjective: String? = nil,
        typicalPosition: AdverbPosition,
        modifies: AdverbModifies,
        comparativeForm: ComparisonForms? = nil,
        superlativeForm: ComparisonForms? = nil,
        isIrregularComparison: Bool = false
    ) {
        self.id = id
        self.frenchWordAttribute = frenchWordAttribute
        self.derivedFromAdjective = derivedFromAdjective
        self.sourceAdjective = sourceAdjective
        self.typicalPosition = typicalPosition
        self.modifies = modifies
        self.comparativeForm = comparativeForm
        self.superlativeForm = superlativeForm
        self.isIrregularComparison = isIrregularComparison
    }
    
    // Delegate properties
    var word: String { frenchWordAttribute.word }
    var englishMeaning: String { frenchWordAttribute.englishMeaning }
    var ipa: String { frenchWordAttribute.ipa }
    var examples: [Example] { frenchWordAttribute.examples }
    var level: LanguageLevel { frenchWordAttribute.level }
}

enum AdverbPosition: String, Codable {
    case beginning = "Beginning of sentence"
    case afterVerb = "After verb"
    case endOfSentence = "End of sentence"
    case flexible = "Flexible position"
}

enum AdverbModifies: String, Codable {
    case verb = "Modifies verb"
    case adjective = "Modifies adjective"
    case adverb = "Modifies another adverb"
    case entireSentence = "Modifies entire sentence"
    case multiple = "Multiple uses"
}
