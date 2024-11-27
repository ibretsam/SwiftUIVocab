//
//  NewVocabApp.swift
//  NewVocab
//
//  Created by MasterBi on 16/9/24.
//

import SwiftUI
import SwiftData

@main
struct NewVocabApp: App {
    
    let container: ModelContainer = {
		let schema = Schema([FrenchVerb.self, FrenchNoun.self, FrenchAdjective.self, FrenchAdverb.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(container)
    }
}
