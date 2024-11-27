//
//  FrenchVerb.swift
//  NewVocab
//
//  Created by MasterBi on 19/10/24.
//
import Foundation
import SwiftData

/// Represents a French verb, inheriting from `FrenchWord`.
@Model
class FrenchVerb: Identifiable {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade) var frenchWordAttribute: FrenchWordAttribute
    var infinitive: String
    @Relationship(deleteRule: .cascade) var conjugation: FrenchConjugation
    
    init(
        id: UUID,
        frenchWordAttribute: FrenchWordAttribute,
        infinitive: String,
        conjugation: FrenchConjugation
    ) {
        self.id = id
        self.frenchWordAttribute = frenchWordAttribute
        self.infinitive = infinitive
        self.conjugation = conjugation
    }
    
    // Delegate properties
    var word: String { frenchWordAttribute.word }
    var englishMeaning: String { frenchWordAttribute.englishMeaning }
    var ipa: String { frenchWordAttribute.ipa }
    var examples: [Example] { frenchWordAttribute.examples }
    var level: LanguageLevel { frenchWordAttribute.level }
}

/// Represents the conjugation details of a French verb.
///
/// - Properties:
///   - moods: An array of `FrenchMood` representing the moods of the verb.
@Model
class FrenchConjugation {
    @Relationship(deleteRule: .cascade) var moods: [FrenchMood]
    
    init(moods: [FrenchMood]) {
        self.moods = moods
    }
}

/// Represents a mood in French conjugation.
///
/// - Properties:
///   - id: A unique identifier for the mood.
///   - name: The name of the mood.
///   - tenses: An array of `FrenchTense` representing the tenses of the mood.
@Model
class FrenchMood: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: FrenchMoodName
    var tenses: [FrenchTense]
    
    init(id: UUID, name: FrenchMoodName, tenses: [FrenchTense]) {
        self.id = id
        self.name = name
        self.tenses = tenses
    }
}

/// Represents a tense in French conjugation.
///
/// - Properties:
///   - id: A unique identifier for the tense.
///   - name: The name of the tense.
///   - conjugations: An array of `FrenchConjugationForm` representing the conjugation forms.
///   - example: An optional example of the tense.
@Model
class FrenchTense: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: FrenchTenseName
    var conjugations: [FrenchConjugationForm]
    @Relationship(deleteRule: .nullify) var example: Example?
    
    init(id: UUID, name: FrenchTenseName, conjugations: [FrenchConjugationForm], example: Example? = nil) {
        self.id = id
        self.name = name
        self.conjugations = conjugations
        self.example = example
    }
}

/// Represents a conjugation form in French.
///
/// - Properties:
///   - pronoun: The pronoun associated with the conjugation form.
///   - form: The conjugated form of the verb.
@Model
class FrenchConjugationForm {
    var pronoun: FrenchPronoun
    var form: String
    
    init(pronoun: FrenchPronoun, form: String) {
        self.pronoun = pronoun
        self.form = form
    }
}

/// Represents the names of moods in French conjugation.
enum FrenchMoodName: String, Codable {
    case indicatif = "Indicatif"
    case conditionnel = "Conditionnel"
    case subjonctif = "Subjonctif"
    case impératif = "Impératif"
    case gérondif = "Gérondif"
}

/// Represents the names of tenses in French conjugation.
enum FrenchTenseName: String, Codable {
    case présent = "Présent"
    case imparfait = "Imparfait"
    case passéComposé = "Passé Composé"
    case passéSimple = "Passé Simple"
    case futurSimple = "Futur Simple"
    case plusQueParfait = "Plus que Parfait"
    case passéAntérieur = "Passé Antérieur"
    case futurAntérieur = "Futur Antérieur"
    case passé = "Passé"
}

/// Represents the pronouns used in French conjugation.
enum FrenchPronoun: String, Codable {
    case je = "je"
    case tu = "tu"
    case il = "il"
    case elle = "elle"
    case on = "on"
    case nous = "nous"
    case vous = "vous"
    case ils = "ils"
    case elles = "elles"
    case en = "en"
}
