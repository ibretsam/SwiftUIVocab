//
//  Test.swift
//  NewVocab
//
//  Created by MasterBi on 23/11/2024.
//

import Foundation
import SwiftData

@Model
/// For testing and experiment random things...
class Expense {
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
}
