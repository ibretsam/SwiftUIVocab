//
//  MainViewVM.swift
//  NewVocab
//
//  Created by MasterBi on 19/9/24.
//

import Foundation

class MainViewVM: ObservableObject {
    @Published var words = [FrenchWordType]()
    private let service: MainViewServices
    
    init(service: MainViewServices) {
        self.service = service
        
        Task {
            await fetchWords()
        }
    }
    
    @MainActor
    func fetchWords() async {
        do {
            self.words = try await service.fetchWords()
        } catch {
            print("DEBUG: Error fetching words: \(error.localizedDescription)")
        }
    }
}
