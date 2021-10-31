//
//  WordItem.swift
//  DiffableExample
//
//  Created by 晋先森 on 10/31/21.
//

import Foundation

enum SectionType {
    case word
}

class WordItem: Codable {
    
    var riddle: String
    var answer: String
    
    private var identifier: UUID { UUID() }

}

extension WordItem: Hashable {
    static func == (lhs: WordItem, rhs: WordItem) -> Bool {
        lhs.identifier == rhs.identifier
    }
 
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
