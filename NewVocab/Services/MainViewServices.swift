//
//  MainViewServices.swift
//  NewVocab
//
//  Created by MasterBi on 19/9/24.
//

import Foundation
import GRPC

enum VocabError: LocalizedError {
	case connectionFailed
	case serverError(String)
	case noData
	
	var errorDescription: String? {
		switch self {
			case .connectionFailed:
				return "Could not connect to the server. Please check your internet connection."
			case .serverError(let message):
				return "Server error: \(message)"
			case .noData:
				return "No vocabulary data available."
		}
	}
}

@available(iOS 13.0.0, *)
class MainViewServices {
	private let client = VocabClient()
	
	func fetchWords() async throws -> [FrenchWordType] {
		do {
//			let words = try await client.getRecentWords()
			let words = WordPreview.shared.frenchWords // Using mock data
			guard !words.isEmpty else { throw VocabError.noData }
			return words
		} catch let error as GRPCStatus {
			// Check for specific GRPC status codes
			switch error.code {
				case .unavailable:
					throw VocabError.connectionFailed
				default:
					throw VocabError.serverError(error.message ?? "Unknown error")
			}
		} catch {
			throw VocabError.serverError(error.localizedDescription)
		}
	}
}
