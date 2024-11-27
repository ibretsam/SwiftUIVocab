//
//  MainViewServices.swift
//  NewVocab
//
//  Created by MasterBi on 19/9/24.
//

class MainViewServices {
    func fetchWords() async throws -> [FrenchWordType] {
        return WordPreview.shared.frenchWords
    }
}
