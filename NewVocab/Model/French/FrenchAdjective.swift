//
//  FrenchAdjective.swift
//  NewVocab
//
//  Created by MasterBi on 19/10/24.
//
import Foundation
import SwiftData

@Model
class FrenchAdjective: Identifiable {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade) var frenchWordAttribute: FrenchWordAttribute
    var masculineForm: GenderForm
    var feminineForm: GenderForm
    var defaultPosition: AdjectivePosition
    var comparativeForm: ComparisonForms?
    var superlativeForm: ComparisonForms?
    var isIrregularComparison: Bool
    var requiresPreposition: PrepositionRequirement?
    
    init(
        id: UUID,
        frenchWordAttribute: FrenchWordAttribute,
        masculineForm: GenderForm,
        feminineForm: GenderForm,
        defaultPosition: AdjectivePosition,
        comparativeForm: ComparisonForms? = nil,
        superlativeForm: ComparisonForms? = nil,
        isIrregularComparison: Bool = false,
        requiresPreposition: PrepositionRequirement? = nil
    ) {
        self.id = id
        self.frenchWordAttribute = frenchWordAttribute
        self.masculineForm = masculineForm
        self.feminineForm = feminineForm
        self.defaultPosition = defaultPosition
        self.comparativeForm = comparativeForm
        self.superlativeForm = superlativeForm
        self.isIrregularComparison = isIrregularComparison
        self.requiresPreposition = requiresPreposition
    }
    
    // Delegate properties to baseWord
    var word: String { frenchWordAttribute.word }
    var englishMeaning: String { frenchWordAttribute.englishMeaning }
    var ipa: String { frenchWordAttribute.ipa }
    var examples: [Example] { frenchWordAttribute.examples }
    var level: LanguageLevel { frenchWordAttribute.level }
}

// Supporting structures
@Model
class ComparisonForms {
    var masculine: String
    var feminine: String
    var example: Example?
    
    init(masculine: String, feminine: String, example: Example?) {
        self.masculine = masculine
        self.feminine = feminine
        self.example = example
    }
}

@Model
class PrepositionRequirement {
    var preposition: String
    var usage: String
    var example: Example
    
    init(preposition: String, usage: String, example: Example) {
        self.preposition = preposition
        self.usage = usage
        self.example = example
    }
}

@Model
class AdjectivePosition {
    var position: Position
    var example: Example
    
    init(position: Position, example: Example) {
        self.position = position
        self.example = example
    }
}



// Supporting enums
enum Position: String, Codable {
    case before = "Before noun"
    case after = "After noun"
    case both = "Both positions possible"
}
