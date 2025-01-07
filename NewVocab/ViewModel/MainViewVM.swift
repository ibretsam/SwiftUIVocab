//
//  MainViewVM.swift
//  NewVocab
//
//  Created by MasterBi on 19/9/24.
//

import Foundation

class MainViewVM: ObservableObject {
	@Published var words = [FrenchWordType]()
	@Published var error: Error?
	@Published var isLoading = false
	private let service: MainViewServices
	
	init(service: MainViewServices) {
		self.service = service
		Task {
			await fetchWords()
		}
	}
	
	@MainActor
	func fetchWords() async {
		isLoading = true
		do {
			self.words = try await service.fetchWords()
			error = nil
		} catch {
			self.error = error
			print("DEBUG: Error fetching words: \(error.localizedDescription)")
		}
		isLoading = false
	}
}
