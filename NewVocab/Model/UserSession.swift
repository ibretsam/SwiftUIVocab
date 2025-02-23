//
//  UserSession.swift
//  NewVocab
//
//  Created by MasterBi on 30/01/2025.
//

import Foundation
import SwiftData

@Model
class UserSession: Identifiable {
	@Attribute(.unique) var id: UUID
	var createdAt: Date
	var lastActiveAt: Date
	var difficultyLevel: LanguageLevel
	var isAnonymous: Bool
	var userId: String?
	@Relationship(deleteRule: .cascade) var wordInteractions: [WordInteraction]
	
	init(
		id: UUID = UUID(),
		createdAt: Date = Date(),
		lastActiveAt: Date = Date(),
		difficultyLevel: LanguageLevel = .a1,
		isAnonymous: Bool = true,
		userId: String? = nil
	) {
		self.id = id
		self.createdAt = createdAt
		self.lastActiveAt = lastActiveAt
		self.difficultyLevel = difficultyLevel
		self.isAnonymous = isAnonymous
		self.userId = userId
		self.wordInteractions = []
	}
}

@Model
class WordInteraction: Identifiable {
	@Attribute(.unique) var id: UUID
	var wordId: UUID
	var seenCount: Int
	var lastSeenAt: Date?
	var isSaved: Bool
	var isLiked: Bool
	var hasViewedDetail: Bool
	
	init(
		id: UUID = UUID(),
		wordId: UUID,
		seenCount: Int = 0,
		lastSeenAt: Date? = nil,
		isSaved: Bool = false,
		isLiked: Bool = false,
		hasViewedDetail: Bool = false
	) {
		self.id = id
		self.wordId = wordId
		self.seenCount = seenCount
		self.lastSeenAt = lastSeenAt
		self.isSaved = isSaved
		self.isLiked = isLiked
		self.hasViewedDetail = hasViewedDetail
	}
}
