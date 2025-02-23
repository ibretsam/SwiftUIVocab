//
//  UserSessionManager.swift
//  NewVocab
//
//  Created by MasterBi on 30/01/2025.
//

import SwiftUI
import SwiftData

@Observable
class UserSessionManager {
	static let shared = UserSessionManager()
	private var modelContext: ModelContext?
	private(set) var currentSession: UserSession?
	
	private init() {}
	
	func initialize(modelContext: ModelContext) {
		self.modelContext = modelContext
		loadOrCreateSession()
	}
	
	private func loadOrCreateSession() {
		guard let modelContext = modelContext else { return }
		
		do {
			let descriptor = FetchDescriptor<UserSession>()
			let sessions = try modelContext.fetch(descriptor)
			
			if let existingSession = sessions.first {
				currentSession = existingSession
				currentSession?.lastActiveAt = Date()
			} else {
				let newSession = UserSession()
				modelContext.insert(newSession)
				try modelContext.save()
				currentSession = newSession
			}
		} catch {
			print("Error loading session: \(error)")
		}
	}
	
	func linkToUser(userId: String) {
		guard let modelContext = modelContext,
			  let currentSession = currentSession else { return }
		
		do {
			// Update current session
			currentSession.isAnonymous = false
			currentSession.userId = userId
			try modelContext.save()
		} catch {
			print("Error linking session to user: \(error)")
		}
	}
	
	func switchToUserSession(userId: String, userData: UserSessionData) {
		guard let modelContext = modelContext else { return }
		
		do {
			// Delete current session if it's anonymous
			if let currentSession = currentSession, currentSession.isAnonymous {
				modelContext.delete(currentSession)
			}
			
			// Create new session with user data
			let newSession = UserSession(
				difficultyLevel: userData.difficultyLevel,
				isAnonymous: false,
				userId: userId
			)
			modelContext.insert(newSession)
			try modelContext.save()
			currentSession = newSession
			
			// Import word interactions
			importWordInteractions(userData.wordInteractions)
		} catch {
			print("Error switching to user session: \(error)")
		}
	}
	
	private func importWordInteractions(_ interactions: [WordInteractionData]) {
		guard let modelContext = modelContext,
			  let currentSession = currentSession else { return }
		
		for interaction in interactions {
			let wordInteraction = WordInteraction(
				wordId: interaction.wordId,
				seenCount: interaction.seenCount,
				lastSeenAt: interaction.lastSeenAt,
				isSaved: interaction.isSaved,
				isLiked: interaction.isLiked,
				hasViewedDetail: interaction.hasViewedDetail
			)
			currentSession.wordInteractions.append(wordInteraction)
		}
		
		try? modelContext.save()
	}
	
	func updateWordInteraction(wordId: UUID, update: (WordInteraction) -> Void) {
		guard let modelContext = modelContext,
			  let currentSession = currentSession else { return }
		
		if let existingInteraction = currentSession.wordInteractions.first(where: { $0.wordId == wordId }) {
			update(existingInteraction)
		} else {
			let newInteraction = WordInteraction(wordId: wordId)
			update(newInteraction)
			currentSession.wordInteractions.append(newInteraction)
		}
		
		try? modelContext.save()
	}
}

// Data transfer objects for user session sync
struct UserSessionData {
	let difficultyLevel: LanguageLevel
	let wordInteractions: [WordInteractionData]
}

struct WordInteractionData {
	let wordId: UUID
	let seenCount: Int
	let lastSeenAt: Date?
	let isSaved: Bool
	let isLiked: Bool
	let hasViewedDetail: Bool
}
