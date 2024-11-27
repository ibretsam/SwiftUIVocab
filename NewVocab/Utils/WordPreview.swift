//
//  WordPreview.swift
//  NewVocab
//
//  Created by MasterBi on 16/9/24.
//

import SwiftUI

enum FrenchWordType {
    case verb(FrenchVerb)
    case noun(FrenchNoun)
    case adjective(FrenchAdjective)
    case adverb(FrenchAdverb)
}

class WordPreview {
    static let shared = WordPreview()
    
    let frenchWords: [FrenchWordType] = [
        .verb(
            FrenchVerb(
                id: UUID(),
                frenchWordAttribute: FrenchWordAttribute(
                    wordAttribute: WordAttribute(
                        word: "prendre",
                        englishMeaning: "to take",
                        ipa: "pʁɑ̃dʁ",
                        examples: [
                            Example(
                                id: UUID(),
                                example: "Je prends un café tous les matins.",
                                englishMeaning: "I have a coffee every morning."
                            ),
                            Example(
                                id: UUID(),
                                example: "Il prend le train pour aller au travail.",
                                englishMeaning: "He takes the train to go to work."
                            ),
                            Example(
                                id: UUID(),
                                example: "Je pris un taxi pour rentrer chez moi.",
                                englishMeaning: "I took a taxi to go back home."
                            ),
                            Example(
                                id: UUID(),
                                example: "Je prendrai le train pour aller en vacances.",
                                englishMeaning: "I will take the train to go on vacation."
                            ),
                            Example(
                                id: UUID(),
                                example: "J'ai pris un livre à la bibliothèque.",
                                englishMeaning: "I took a book from the library."
                            )
                        ],
                        level: .a1,
                        grammaticalCategory: .verb,
                        relatedWords: [
                            RelatedWord(
                                word: "reprendre",
                                englishMeaning: "to resume",
                                example: Example(
                                    id: UUID(),
                                    example: "Je reprends mes études.",
                                    englishMeaning: "I resume my studies."
                                ),
                                relationType: .wordFamily
                            )
                        ],
                        frequency: .common,
                        subjectDomains: [.general],
                        etymology: Etymology(
                            origin: "Latin",
                            originalWord: "prehendere",
                            evolutionSteps: [
                                "prehendere",
                                "prendre"
                            ]
                        )
                    ),
                    falseFriends: [
                        FalseFriend(
                            language: "English",
                            word: "pretend",
                            meaning: "to act as if something is true when it is not"
                        )
                    ]
                ),
                infinitive: "prendre",
                conjugation: FrenchConjugation(
                    moods: [
                        FrenchMood(
                            id: UUID(),
                            name: .indicatif,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "prends"),
                                        FrenchConjugationForm(pronoun: .tu, form: "prends"),
                                        FrenchConjugationForm(pronoun: .il, form: "prend"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prenons"),
                                        FrenchConjugationForm(pronoun: .vous, form: "prenez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prennent")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je prends un café.",
                                        englishMeaning: "I take a coffee."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .imparfait,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "prenais"),
                                        FrenchConjugationForm(pronoun: .tu, form: "prenais"),
                                        FrenchConjugationForm(pronoun: .il, form: "prenait"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prenions"),
                                        FrenchConjugationForm(pronoun: .vous, form: "preniez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prenaient")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je prenais le bus pour aller à l'école.",
                                        englishMeaning: "I used to take the bus to go to school."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passéSimple,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "prit"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prîmes"),
                                        FrenchConjugationForm(pronoun: .vous, form: "prîtes"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prirent")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je pris un taxi pour rentrer chez moi.",
                                        englishMeaning: "I took a taxi to go back home."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passéComposé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "ai pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "as pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "a pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "avons pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "avez pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "ont pris")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'ai pris un livre à la bibliothèque.",
                                        englishMeaning: "I took a book from the library."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .futurSimple,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "prendrai"),
                                        FrenchConjugationForm(pronoun: .tu, form: "prendras"),
                                        FrenchConjugationForm(pronoun: .il, form: "prendra"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prendrons"),
                                        FrenchConjugationForm(pronoun: .vous, form: "prendrez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prendront")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je prendrai le train pour aller en vacances.",
                                        englishMeaning: "I will take the train to go on vacation."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .plusQueParfait,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "avais pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "avais pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "avait pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "avions pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "aviez pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "avaient pris")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'avais pris mon parapluie mais il n'a pas plu.",
                                        englishMeaning: "I had taken my umbrella but it didn't rain."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passéAntérieur,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "eus pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "eus pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "eut pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "eûmes pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "eûtes pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "eurent pris")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'eus pris le dernier morceau de gâteau.",
                                        englishMeaning: "I had taken the last piece of cake."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .futurAntérieur,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "aurai pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "auras pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "aura pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "aurons pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "aurez pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "auront pris")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'aurai pris ma décision demain.",
                                        englishMeaning: "I will have made my decision tomorrow."
                                    )
                                ),
                            ]
                        ),
                        FrenchMood(
                            id: UUID(),
                            name: .conditionnel,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "prendrais"),
                                        FrenchConjugationForm(pronoun: .tu, form: "prendrais"),
                                        FrenchConjugationForm(pronoun: .il, form: "prendrait"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prendrions"),
                                        FrenchConjugationForm(pronoun: .vous, form: "prendriez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prendraient")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je prendrais un taxi s'il pleuvait.",
                                        englishMeaning: "I would take a taxi if it was raining."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "aurais pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "aurais pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "aurait pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "aurions pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "auriez pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "auraient pris")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'aurais pris une bonne décision si j'avais su.",
                                        englishMeaning: "I would have made a good decision if I had known."
                                    )
                                )
                            ]
                        ),
                        FrenchMood(
                            id: UUID(),
                            name: .subjonctif,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "prenne"),
                                        FrenchConjugationForm(pronoun: .tu, form: "prennes"),
                                        FrenchConjugationForm(pronoun: .il, form: "prenne"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prenions"),
                                        FrenchConjugationForm(pronoun: .vous, form: "preniez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prennent"),
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je veux que tu prennes le train.",
                                        englishMeaning: "I want you to take the train."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "aie pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "aies pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "ait pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "ayons pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "ayez pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "aient pris"),
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je suis content que tu aies pris cette décision.",
                                        englishMeaning: "I'm glad you made that decision."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .imparfait,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "prisse"),
                                        FrenchConjugationForm(pronoun: .tu, form: "prisses"),
                                        FrenchConjugationForm(pronoun: .il, form: "prît"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prissions"),
                                        FrenchConjugationForm(pronoun: .vous, form: "prissiez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prissent"),
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Il était important que je prisse cette route.",
                                        englishMeaning: "It was important that I took that road."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .plusQueParfait,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "eusse pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "eusses pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "eût pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "eussions pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "eussiez pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "eussent pris"),
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'aurais aimé que tu eusses pris plus de temps.",
                                        englishMeaning: "I wish you had taken more time."
                                    )
                                )
                            ]
                        ),
                        FrenchMood(
                            id: UUID(),
                            name: .impératif,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .tu, form: "prends"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prenons"),
                                        FrenchConjugationForm(pronoun: .vous, form: "prenez"),
                                    ],
                                    example: Example (
                                        id: UUID(),
                                        example: "Prends soin de toi.",
                                        englishMeaning: "Take care of yourself."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .tu, form: "aie pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "ayons pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "ayez pris"),
                                    ],
                                    example: Example (
                                        id: UUID(),
                                        example: "Aie pris cette décision.",
                                        englishMeaning: "Have made this decision."
                                    )
                                ),
                            ]
                        ),
                        FrenchMood(
                            id: UUID(),
                            name: .gérondif,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .en, form: "prenant")
                                    ],
                                    example: Example (
                                        id: UUID(),
                                        example: "En prenant mon temps, je suis moins stressé.",
                                        englishMeaning: "By taking my time, I am less stressed."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .en, form: "ayant pris")
                                    ],
                                    example: Example (
                                        id: UUID(),
                                        example: "En ayant pris une bonne décision, je me sens mieux.",
                                        englishMeaning: "By having made a good decision, I feel better."
                                    )
                                ),
                            ]
                        )
                    ]
                )
            )
        ),
        .verb(
            FrenchVerb(
                id: UUID(),
                frenchWordAttribute: FrenchWordAttribute(
                    wordAttribute: WordAttribute(
                        word: "vivre",
                        englishMeaning: "to live",
                        ipa: "vivʁ",
                        examples: [
                            Example(
                                id: UUID(),
                                example: "Je vis dans une grande ville.",
                                englishMeaning: "I live in a big city."
                            ),
                            Example(
                                id: UUID(),
                                example: "Il vivait heureux.",
                                englishMeaning: "He lived happily."
                            ),
                            Example(
                                id: UUID(),
                                example: "Nous avons vécu des moments difficiles.",
                                englishMeaning: "We have lived through difficult times."
                            ),
                            Example(
                                id: UUID(),
                                example: "Je vivrai à l'étranger.",
                                englishMeaning: "I will live abroad."
                            ),
                            Example(
                                id: UUID(),
                                example: "J'avais vécu avec eux avant de déménager.",
                                englishMeaning: "I had lived with them before moving out."
                            )
                        ],
                        level: .a1,
                        grammaticalCategory: .verb,
                        relatedWords: [
                            RelatedWord(
                                word: "survivre",
                                englishMeaning: "to survive",
                                example: Example(
                                    id: UUID(),
                                    example: "Il a survécu à l'accident.",
                                    englishMeaning: "He survived the accident."
                                ),
                                relationType: .wordFamily
                            )
                        ],
                        frequency: .common,
                        subjectDomains: [.lifestyle],
                        etymology: Etymology(
                            origin: "Latin",
                            originalWord: "vivere",
                            evolutionSteps: [
                                "vivere",
                                "vivre"
                            ]
                        )
                    ),
                    falseFriends: []
                ),
                infinitive: "vivre",
                conjugation: FrenchConjugation(
                    moods: [
                        FrenchMood(
                            id: UUID(),
                            name: .indicatif,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "vis"),
                                        FrenchConjugationForm(pronoun: .tu, form: "vis"),
                                        FrenchConjugationForm(pronoun: .il, form: "vit"),
                                        FrenchConjugationForm(pronoun: .nous, form: "vivons"),
                                        FrenchConjugationForm(pronoun: .vous, form: "vivez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "vivent")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je vis dans une grande ville.",
                                        englishMeaning: "I live in a big city."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .imparfait,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "vivais"),
                                        FrenchConjugationForm(pronoun: .tu, form: "vivais"),
                                        FrenchConjugationForm(pronoun: .il, form: "vivait"),
                                        FrenchConjugationForm(pronoun: .nous, form: "vivions"),
                                        FrenchConjugationForm(pronoun: .vous, form: "viviez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "vivaient")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Il vivait heureux",
                                        englishMeaning: "He lived happily."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passéSimple,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "vécus"),
                                        FrenchConjugationForm(pronoun: .tu, form: "vécus"),
                                        FrenchConjugationForm(pronoun: .il, form: "vécut"),
                                        FrenchConjugationForm(pronoun: .nous, form: "vécûmes"),
                                        FrenchConjugationForm(pronoun: .vous, form: "vécûtes"),
                                        FrenchConjugationForm(pronoun: .ils, form: "vécurent")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Nous vécûmes des moments difficiles.",
                                        englishMeaning: "We lived through difficult times."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passéComposé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "ai vécu"),
                                        FrenchConjugationForm(pronoun: .tu, form: "as vécu"),
                                        FrenchConjugationForm(pronoun: .il, form: "a vécu"),
                                        FrenchConjugationForm(pronoun: .nous, form: "avons vécu"),
                                        FrenchConjugationForm(pronoun: .vous, form: "avez vécu"),
                                        FrenchConjugationForm(pronoun: .ils, form: "ont vécu")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'ai vécu à l'étranger.",
                                        englishMeaning: "I lived abroad."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .futurSimple,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "vivrai"),
                                        FrenchConjugationForm(pronoun: .tu, form: "vivras"),
                                        FrenchConjugationForm(pronoun: .il, form: "vivra"),
                                        FrenchConjugationForm(pronoun: .nous, form: "vivrons"),
                                        FrenchConjugationForm(pronoun: .vous, form: "vivrez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "vivront")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je vivrai à l'étranger.",
                                        englishMeaning: "I will live abroad."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .plusQueParfait,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "avais vécu"),
                                        FrenchConjugationForm(pronoun: .tu, form: "avais vécu"),
                                        FrenchConjugationForm(pronoun: .il, form: "avait vécu"),
                                        FrenchConjugationForm(pronoun: .nous, form: "avions vécu"),
                                        FrenchConjugationForm(pronoun: .vous, form: "aviez vécu"),
                                        FrenchConjugationForm(pronoun: .ils, form: "avaient vécu")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'avais vécu avec eux avant de déménager.",
                                        englishMeaning: "I had lived with them before moving out."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passéAntérieur,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "eus vécu"),
                                        FrenchConjugationForm(pronoun: .tu, form: "eus vécu"),
                                        FrenchConjugationForm(pronoun: .il, form: "eut vécu"),
                                        FrenchConjugationForm(pronoun: .nous, form: "eûmes vécu"),
                                        FrenchConjugationForm(pronoun: .vous, form: "eûtes vécu"),
                                        FrenchConjugationForm(pronoun: .ils, form: "eurent vécu")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Après que nous eûmes vécu cela, tout a changé.",
                                        englishMeaning: "After we had lived through that, everything changed."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .futurAntérieur,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "aurai vécu"),
                                        FrenchConjugationForm(pronoun: .tu, form: "auras vécu"),
                                        FrenchConjugationForm(pronoun: .il, form: "aura vécu"),
                                        FrenchConjugationForm(pronoun: .nous, form: "aurons vécu"),
                                        FrenchConjugationForm(pronoun: .vous, form: "aurez vécu"),
                                        FrenchConjugationForm(pronoun: .ils, form: "auront vécu")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Quand tu auras vécu cela, tu comprendras.",
                                        englishMeaning: "When you have lived through that, you will understand."
                                    )
                                ),
                            ]
                        ),
                        FrenchMood(
                            id: UUID(),
                            name: .conditionnel,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "prendrais"),
                                        FrenchConjugationForm(pronoun: .tu, form: "prendrais"),
                                        FrenchConjugationForm(pronoun: .il, form: "prendrait"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prendrions"),
                                        FrenchConjugationForm(pronoun: .vous, form: "prendriez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prendraient")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je prendrais un taxi s'il pleuvait.",
                                        englishMeaning: "I would take a taxi if it was raining."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "aurais pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "aurais pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "aurait pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "aurions pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "auriez pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "auraient pris")
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'aurais pris une bonne décision si j'avais su.",
                                        englishMeaning: "I would have made a good decision if I had known."
                                    )
                                )
                            ]
                        ),
                        FrenchMood(
                            id: UUID(),
                            name: .subjonctif,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "prenne"),
                                        FrenchConjugationForm(pronoun: .tu, form: "prennes"),
                                        FrenchConjugationForm(pronoun: .il, form: "prenne"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prenions"),
                                        FrenchConjugationForm(pronoun: .vous, form: "preniez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prennent"),
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je veux que tu prennes le train.",
                                        englishMeaning: "I want you to take the train."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "aie pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "aies pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "ait pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "ayons pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "ayez pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "aient pris"),
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Je suis content que tu aies pris cette décision.",
                                        englishMeaning: "I'm glad you made that decision."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .imparfait,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "prisse"),
                                        FrenchConjugationForm(pronoun: .tu, form: "prisses"),
                                        FrenchConjugationForm(pronoun: .il, form: "prît"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prissions"),
                                        FrenchConjugationForm(pronoun: .vous, form: "prissiez"),
                                        FrenchConjugationForm(pronoun: .ils, form: "prissent"),
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "Il était important que je prisse cette route.",
                                        englishMeaning: "It was important that I took that road."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .plusQueParfait,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .je, form: "eusse pris"),
                                        FrenchConjugationForm(pronoun: .tu, form: "eusses pris"),
                                        FrenchConjugationForm(pronoun: .il, form: "eût pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "eussions pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "eussiez pris"),
                                        FrenchConjugationForm(pronoun: .ils, form: "eussent pris"),
                                    ],
                                    example: Example(
                                        id: UUID(),
                                        example: "J'aurais aimé que tu eusses pris plus de temps.",
                                        englishMeaning: "I wish you had taken more time."
                                    )
                                )
                            ]
                        ),
                        FrenchMood(
                            id: UUID(),
                            name: .impératif,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .tu, form: "prends"),
                                        FrenchConjugationForm(pronoun: .nous, form: "prenons"),
                                        FrenchConjugationForm(pronoun: .vous, form: "prenez"),
                                    ],
                                    example: Example (
                                        id: UUID(),
                                        example: "Prends soin de toi.",
                                        englishMeaning: "Take care of yourself."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .tu, form: "aie pris"),
                                        FrenchConjugationForm(pronoun: .nous, form: "ayons pris"),
                                        FrenchConjugationForm(pronoun: .vous, form: "ayez pris"),
                                    ],
                                    example: Example (
                                        id: UUID(),
                                        example: "Aie pris cette décision.",
                                        englishMeaning: "Have made this decision."
                                    )
                                ),
                            ]
                        ),
                        FrenchMood(
                            id: UUID(),
                            name: .gérondif,
                            tenses: [
                                FrenchTense(
                                    id: UUID(),
                                    name: .présent,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .en, form: "prenant")
                                    ],
                                    example: Example (
                                        id: UUID(),
                                        example: "En prenant mon temps, je suis moins stressé.",
                                        englishMeaning: "By taking my time, I am less stressed."
                                    )
                                ),
                                FrenchTense(
                                    id: UUID(),
                                    name: .passé,
                                    conjugations: [
                                        FrenchConjugationForm(pronoun: .en, form: "ayant pris")
                                    ],
                                    example: Example (
                                        id: UUID(),
                                        example: "En ayant pris une bonne décision, je me sens mieux.",
                                        englishMeaning: "By having made a good decision, I feel better."
                                    )
                                ),
                            ]
                        )
                    ]
                )
            )
        ),
        .noun(
            FrenchNoun(
                id: UUID(),
                frenchWordAttribute: FrenchWordAttribute(
                    wordAttribute: WordAttribute(
                        word: "pain",
                        englishMeaning: "bread",
                        ipa: "pɛ̃",
                        examples: [
                            Example(
                                id: UUID(),
                                example: "Le boulanger fait du bon pain.",
                                englishMeaning: "The baker makes good bread."
                            ),
                            Example(
                                id: UUID(),
                                example: "Je mange du pain au petit-déjeuner.",
                                englishMeaning: "I eat bread for breakfast."
                            )
                        ],
                        level: .a1,
                        grammaticalCategory: .noun,
                        relatedWords: [
                            RelatedWord(
                                word: "panetier",
                                englishMeaning: "bread seller",
                                example: Example(
                                    id: UUID(),
                                    example: "Le panetier vend du pain.",
                                    englishMeaning: "The bread seller sells bread."
                                ),
                                relationType: .wordFamily
                            ),
                            RelatedWord(
                                word: "petit pain",
                                englishMeaning: "small bread",
                                example: Example(
                                    id: UUID(),
                                    example: "Je prends un petit pain.",
                                    englishMeaning: "I take a small bread."
                                ),
                                relationType: .augmentative
                            ),
                            RelatedWord(
                                word: "gros pain",
                                englishMeaning: "big bread",
                                example: Example(
                                    id: UUID(),
                                    example: "Il a acheté un gros pain.",
                                    englishMeaning: "He bought a big bread."
                                ),
                                relationType: .augmentative
                            ),
                            RelatedWord(
                                word: "fournée de pain",
                                englishMeaning: "batch of bread",
                                example: Example(
                                    id: UUID(),
                                    example: "Une fournée de pain sort du four.",
                                    englishMeaning: "A batch of bread comes out of the oven."
                                ),
                                relationType: .collective
                            ),
                            RelatedWord(
                                word: "pain au chocolat",
                                englishMeaning: "chocolate bread",
                                example: Example(
                                    id: UUID(),
                                    example: "Je mange un pain au chocolat.",
                                    englishMeaning: "I eat chocolate bread."
                                ),
                                relationType: .compound
                            )
                        ],
                        frequency: .veryCommon,
                        subjectDomains: [.food],
                        formalityLevel: .standard,
                        etymology: Etymology(
                            origin: "Latin",
                            originalWord: "panis",
                            evolutionSteps: [
                                "Latin: panis",
                                "Old French: pain"
                            ]
                        ),
                        culturalNotes: [
                            CulturalNote(
                                note: "Bread is a staple food in France.",
                                idioms: ["gagner son pain (to earn one's living)"],
                                culturalContext: "Bread is deeply ingrained in French culture."
                            )
                        ]
                    ),
                    regionalUsage: [
                        RegionalUsage(
                            region: .france,
                            usage: "Common",
                            example: Example(
                                id: UUID(),
                                example: "Je mange du pain.",
                                englishMeaning: "I eat bread."
                            )
                        )
                    ],
                    pronunciationVariations: [
                        PronunciationVariation(
                            region: .france,
                            ipa: "pɛ̃",
                            notes: "Standard pronunciation"
                        )
                    ],
                    falseFriends: [
                        FalseFriend(
                            language: "English",
                            word: "pain",
                            meaning: "Physical suffering or discomfort"
                        )
                    ]
                ),
                masculineForm: GenderForm(
                    gender: .masculine,
                    singular: "pain",
                    plural: "pains",
                    definiteArticle: "le",
                    indefiniteArticle: "un"
                ),
                feminineForm: nil,
                primaryGender: .masculine,
                isCountable: true
            )
        ),
        .noun(
            FrenchNoun(
                id: UUID(),
                frenchWordAttribute: FrenchWordAttribute(
                    wordAttribute: WordAttribute(
                        word: "chat",
                        englishMeaning: "cat",
                        ipa: "ʃa",
                        examples: [
                            Example(
                                id: UUID(),
                                example: "Le chat dort sur le canapé.",
                                englishMeaning: "The cat sleeps on the couch."
                            ),
                            Example(
                                id: UUID(),
                                example: "J'ai un chat noir.",
                                englishMeaning: "I have a black cat."
                            )
                        ],
                        level: .a1,
                        grammaticalCategory: .noun,
                        relatedWords: [
                            RelatedWord(
                                word: "chaton",
                                englishMeaning: "kitten",
                                example: Example(
                                    id: UUID(),
                                    example: "Le chaton joue.",
                                    englishMeaning: "The cat plays."
                                ),
                                relationType: .wordFamily
                            ),
                            RelatedWord(
                                word: "chat sauvage",
                                englishMeaning: "wild cat",
                                example: Example(
                                    id: UUID(),
                                    example: "Le chat sauvage chasse.",
                                    englishMeaning: "The wild cat hunts."
                                ),
                                relationType: .compound
                            )
                        ],
                        frequency: .common,
                        subjectDomains: [.animals],
                        formalityLevel: .standard,
                        etymology: Etymology(
                            origin: "Latin",
                            originalWord: "cattus",
                            evolutionSteps: [
                                "Latin: cattus",
                                "Old French: chat"
                            ]
                        ),
                        culturalNotes: [
                            CulturalNote(
                                note: "Cats are popular pets in France.",
                                idioms: ["donner sa langue au chat (to give up)"],
                                culturalContext: "Cats are often featured in French idioms."
                            )
                        ]
                    ),
                    regionalUsage: [
                        RegionalUsage(
                            region: .france,
                            usage: "Common",
                            example: Example(
                                id: UUID(),
                                example: "Le chat dort.",
                                englishMeaning: "The cat sleeps."
                            )
                        )
                    ],
                    pronunciationVariations: [
                        PronunciationVariation(
                            region: .france,
                            ipa: "ʃa",
                            notes: "Standard pronunciation"
                        )
                    ],
                    falseFriends: [
                        FalseFriend(
                            language: "English",
                            word: "chat",
                            meaning: "Online conversation"
                        )
                    ]
                ),
                masculineForm: GenderForm(
                    gender: .masculine,
                    singular: "chat",
                    plural: "chats",
                    definiteArticle: "le",
                    indefiniteArticle: "un"
                ),
                feminineForm: GenderForm(
                    gender: .feminine,
                    singular: "chatte",
                    plural: "chattes",
                    definiteArticle: "la",
                    indefiniteArticle: "une"
                ),
                primaryGender: .masculine,
                isCountable: true
            )
        ),
        .noun(
            FrenchNoun(
                id: UUID(),
                frenchWordAttribute: FrenchWordAttribute(
                    wordAttribute: WordAttribute(
                        word: "maison",
                        englishMeaning: "house",
                        ipa: "mɛ.zɔ̃",
                        examples: [
                            Example(
                                id: UUID(),
                                example: "La maison est grande.",
                                englishMeaning: "The house is big."
                            ),
                            Example(
                                id: UUID(),
                                example: "J'habite dans une maison bleue.",
                                englishMeaning: "I live in a blue house."
                            )
                        ],
                        level: .a1,
                        grammaticalCategory: .noun,
                        relatedWords: [
                            RelatedWord(
                                word: "maisonnette",
                                englishMeaning: "small house",
                                example: Example(
                                    id: UUID(),
                                    example: "Ils vivent dans une maisonnette.",
                                    englishMeaning: "They live in a small house."
                                ),
                                relationType: .wordFamily
                            ),
                            RelatedWord(
                                word: "maison de campagne",
                                englishMeaning: "country house",
                                example: Example(
                                    id: UUID(),
                                    example: "Ils ont une maison de campagne.",
                                    englishMeaning: "They have a country house."
                                ),
                                relationType: .compound
                            ),
                            RelatedWord(
                                word: "méson",
                                englishMeaning: "meson particle",
                                example: Example(
                                    id: UUID(),
                                    example: "Cette particule est dénommée méson.",
                                    englishMeaning: "This particle is called a meson."
                                ),
                                relationType: .homophone
                            )
                        ],
                        frequency: .veryCommon,
                        subjectDomains: [.home],
                        formalityLevel: .standard,
                        etymology: Etymology(
                            origin: "Latin",
                            originalWord: "mansio",
                            evolutionSteps: [
                                "Latin: mansio",
                                "Old French: maison"
                            ]
                        ),
                        culturalNotes: [
                            CulturalNote(
                                note: "Houses in France often have unique architectural styles.",
                                idioms: ["être comme chez soi (to feel at home)"],
                                culturalContext: "The concept of 'home' is important in French culture."
                            )
                        ]
                    ),
                    regionalUsage: [
                        RegionalUsage(
                            region: .france,
                            usage: "Common",
                            example: Example(
                                id: UUID(),
                                example: "La maison est grande.",
                                englishMeaning: "The house is big."
                            )
                        )
                    ],
                    pronunciationVariations: [
                        PronunciationVariation(
                            region: .france,
                            ipa: "mɛ.zɔ̃",
                            notes: "Standard pronunciation"
                        )
                    ],
                    falseFriends: [
                        FalseFriend(
                            language: "English",
                            word: "mansion",
                            meaning: "A large, grand house"
                        )
                    ]
                ),
                masculineForm: nil,
                feminineForm: GenderForm(
                    gender: .feminine,
                    singular: "maison",
                    plural: "maisons",
                    definiteArticle: "la",
                    indefiniteArticle: "une"
                ),
                primaryGender: .feminine,
                isCountable: true
        )),
        .adjective(
            FrenchAdjective(
                id: UUID(),
                frenchWordAttribute: FrenchWordAttribute(
                    wordAttribute: WordAttribute(
                        word: "petit",
                        englishMeaning: "small, little",
                        ipa: "pəti",
                        examples: [Example(
                            id: UUID(),
                            example: "C'est un petit chat.",
                            englishMeaning: "It's a small cat."
                        )],
                        level: .a1,
                        grammaticalCategory: .adjective,
                        relatedWords: [
                            RelatedWord(
                                word: "petitesse",
                                englishMeaning: "smallness",
                                example: Example(
                                    id: UUID(),
                                    example: "La petitesse de l'appartement ne me dérange pas.",
                                    englishMeaning: "The smallness of the apartment doesn't bother me."
                                ),
                                relationType: .wordFamily
                            )
                        ],
                        frequency: .veryCommon,
                        subjectDomains: [.general]
                    )
                ),
                masculineForm: GenderForm(
                    gender: .masculine,
                    singular: "petit",
                    plural: "petits",
                    definiteArticle: nil,
                    indefiniteArticle: nil
                ),
                feminineForm: GenderForm(
                    gender: .feminine,
                    singular: "petite",
                    plural: "petites",
                    definiteArticle: nil,
                    indefiniteArticle: nil
                ),
                defaultPosition: AdjectivePosition(
                    position: .before,
                    example: Example(
                        id: UUID(),
                        example: "C'est un petit chat.",
                        englishMeaning: "It's a small cat."
                    )
                ),
                comparativeForm: ComparisonForms(
                    masculine: "plus petit",
                    feminine: "plus petite",
                    example: Example(
                        id: UUID(),
                        example: "Mon chat est plus petit que le tien.",
                        englishMeaning: "My cat is smaller than yours."
                    )
                ),
                superlativeForm: ComparisonForms(
                    masculine: "le plus petit",
                    feminine: "la plus petite",
                    example: Example(
                        id: UUID(),
                        example: "C'est le plus petit chat du monde.",
                        englishMeaning: "It's the smallest cat in the world."
                    )
                ),
                isIrregularComparison: true
        )),
        .adjective(FrenchAdjective(
            id: UUID(),
            frenchWordAttribute: FrenchWordAttribute(
                wordAttribute: WordAttribute(
                    word: "content",
                    englishMeaning: "happy, satisfied",
                    ipa: "kɔ̃.tɑ̃",
                    examples: [
                        Example(
                            id: UUID(),
                            example: "Je suis content de te voir.",
                            englishMeaning: "I am happy to see you."
                        )
                    ],
                    level: .a1,
                    grammaticalCategory: .adjective,
                    relatedWords: [],
                    frequency: .veryCommon,
                    subjectDomains: [.emotions]
                )
            ),
            masculineForm: GenderForm(
                gender: .masculine,
                singular: "content",
                plural: "contents",
                definiteArticle: nil,
                indefiniteArticle: nil
            ),
            feminineForm: GenderForm(
                gender: .feminine,
                singular: "contente",
                plural: "contentes",
                definiteArticle: nil,
                indefiniteArticle: nil
            ),
            defaultPosition: AdjectivePosition(
                position: .after,
                example: Example(
                    id: UUID(),
                    example: "Un enfant content.",
                    englishMeaning: "A happy child."
                )
            ),
            comparativeForm: ComparisonForms(
                masculine: "plus content",
                feminine: "plus contente",
                example: Example(
                    id: UUID(),
                    example: "Je suis plus content que toi.",
                    englishMeaning: "I am happier than you."
                )
            ),
            superlativeForm: ComparisonForms(
                masculine: "le plus content",
                feminine: "la plus contente",
                example: Example(
                    id: UUID(),
                    example: "C'est la plus contente de nous tous.",
                    englishMeaning: "She is the happiest of all of us."
                )
            ),
            requiresPreposition: PrepositionRequirement(
                preposition: "de",
                usage: "Used with 'de' when followed by an infinitive or noun",
                example: Example(
                    id: UUID(),
                    example: "Elle est contente de son travail.",
                    englishMeaning: "She is happy with her work."
                )
            )
        )),
        .adjective(FrenchAdjective(
            id: UUID(),
            frenchWordAttribute: FrenchWordAttribute(
                wordAttribute: WordAttribute(
                    word: "beau",
                    englishMeaning: "beautiful, handsome",
                    ipa: "bo",
                    examples: [
                        Example(
                            id: UUID(),
                            example: "C'est un beau jardin.",
                            englishMeaning: "It's a beautiful garden."
                        )
                    ],
                    level: .a1,
                    grammaticalCategory: .adjective,
                    relatedWords: [],
                    frequency: .veryCommon,
                    subjectDomains: [.aesthetics]
                )
            ),
            masculineForm: GenderForm(
                gender: .masculine,
                singular: "beau",
                plural: "beaux",
                definiteArticle: nil,
                indefiniteArticle: nil
            ),
            feminineForm: GenderForm(
                gender: .feminine,
                singular: "belle",
                plural: "belles",
                definiteArticle: nil,
                indefiniteArticle: nil
            ),
            defaultPosition: AdjectivePosition(
                position: .after,
                example: Example(
                    id: UUID(),
                    example: "C'est un beau jardin.",
                    englishMeaning: "It's a beautiful garden."
                )
            ),
            comparativeForm: ComparisonForms(
                masculine: "plus beau",
                feminine: "plus belle",
                example: Example(
                    id: UUID(),
                    example: "C'est plus beau que hier.",
                    englishMeaning: "It's more beautiful than yesterday."
                )
            ),
            superlativeForm: ComparisonForms(
                masculine: "le plus beau",
                feminine: "la plus belle",
                example: Example(
                    id: UUID(),
                    example: "C'est le plus beau jardin de la ville.",
                    englishMeaning: "It's the most beautiful garden in the city."
                )
            ),
            isIrregularComparison: false
        )),
        .adjective(FrenchAdjective(
            id: UUID(),
            frenchWordAttribute: FrenchWordAttribute(
                wordAttribute: WordAttribute(
                    word: "ancien",
                    englishMeaning: "former, old, ancient",
                    ipa: "ɑ̃sjɛ̃",
                    examples: [
                        Example(
                            id: UUID(),
                            example: "C'est mon ancien professeur.",
                            englishMeaning: "That's my former teacher."
                        ),
                        Example(
                            id: UUID(),
                            example: "C'est un livre ancien.",
                            englishMeaning: "It's an old (antique) book."
                        )
                    ],
                    level: .a2,
                    grammaticalCategory: .adjective,
                    relatedWords: [],
                    frequency: .common,
                    subjectDomains: [.temporal]
                )
            ),
            masculineForm: GenderForm(
                gender: .masculine,
                singular: "ancien",
                plural: "anciens",
                definiteArticle: nil,
                indefiniteArticle: nil
            ),
            feminineForm: GenderForm(
                gender: .feminine,
                singular: "ancienne",
                plural: "anciennes",
                definiteArticle: nil,
                indefiniteArticle: nil
            ),
            defaultPosition: AdjectivePosition(
                position: .before,
                example: Example(
                    id: UUID(),
                    example: "Un livre ancien.",
                    englishMeaning: "An old book."
                )
            )
        )),
        .adverb(FrenchAdverb(
            id: UUID(),
            frenchWordAttribute: FrenchWordAttribute(
                wordAttribute: WordAttribute(
                    word: "rapidement",
                    englishMeaning: "quickly, rapidly",
                    ipa: "ʁapidmɑ̃",
                    examples: [
                        Example(
                            id: UUID(),
                            example: "Il court rapidement.",
                            englishMeaning: "He runs quickly."
                        )
                    ],
                    level: .a2,
                    grammaticalCategory: .adverb,
                    relatedWords: [
                        RelatedWord(
                            word: "rapide",
                            englishMeaning: "quick, fast",
                            example: Example(
                                id: UUID(),
                                example: "C'est une voiture rapide.",
                                englishMeaning: "It's a fast car."
                            ),
                            relationType: .wordFamily
                        )
                    ],
                    frequency: .common,
                    subjectDomains: [.general]
                )
            ),
            derivedFromAdjective: true,
            sourceAdjective: "rapide",
            typicalPosition: .afterVerb,
            modifies: .verb,
            comparativeForm: ComparisonForms(
                masculine: "plus rapidement",
                feminine: "plus rapidement",
                example: Example(
                    id: UUID(),
                    example: "Il court plus rapidement que moi.",
                    englishMeaning: "He runs faster than me."
                )
            ),
            superlativeForm: ComparisonForms(
                masculine: "le plus rapidement",
                feminine: "la plus rapidement",
                example: Example(
                    id: UUID(),
                    example: "Il court le plus rapidement de tous.",
                    englishMeaning: "He runs the fastest of all."
                )
            ),
            isIrregularComparison: false
        )),
        .adverb(FrenchAdverb(
            id: UUID(),
            frenchWordAttribute: FrenchWordAttribute(
                wordAttribute: WordAttribute(
                    word: "bien",
                    englishMeaning: "well, good",
                    ipa: "bjɛ̃",
                    examples: [
                        Example(
                            id: UUID(),
                            example: "Il parle bien français.",
                            englishMeaning: "He speaks French well."
                        )
                    ],
                    level: .a1,
                    grammaticalCategory: .adverb,
                    relatedWords: [],
                    frequency: .veryCommon,
                    subjectDomains: [.lifestyle]
                )
            ),
            derivedFromAdjective: false,
            typicalPosition: .afterVerb,
            modifies: .multiple,
            comparativeForm: ComparisonForms(
                masculine: "mieux",
                feminine: "mieux",
                example: Example(
                    id: UUID(),
                    example: "Il parle mieux que moi.",
                    englishMeaning: "He speaks better than me."
                )
            ),
            superlativeForm: ComparisonForms(
                masculine: "le mieux",
                feminine: "la mieux",
                example: Example(
                    id: UUID(),
                    example: "Il parle le mieux de nous tous.",
                    englishMeaning: "He speaks the best of all of us."
                )
            ),
            isIrregularComparison: true
        ))
    ]
    
    func getVerbs() -> [FrenchVerb] {
        frenchWords.compactMap { if case .verb(let verb) = $0 { return verb } else { return nil } }
    }
    
    func getNouns() -> [FrenchNoun] {
        frenchWords.compactMap { if case .noun(let noun) = $0 { return noun } else { return nil } }
    }
    
    func getAdjectives() -> [FrenchAdjective] {
        frenchWords.compactMap { if case .adjective(let adj) = $0 { return adj } else { return nil } }
    }
    
    func getAdverbs() -> [FrenchAdverb] {
        frenchWords.compactMap { if case .adverb(let adv) = $0 { return adv } else { return nil } }
    }
}

//#Preview {
//    MainView()
//}
