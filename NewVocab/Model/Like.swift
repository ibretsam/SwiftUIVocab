//
//  Like.swift
//  NewVocab
//
//  Created by MasterBi on 18/12/2024.
//

import SwiftUI

struct Like: Identifiable {
	var id: UUID = .init()
	var tappedRect: CGPoint = .zero
	var isAnimated: Bool = false
}
