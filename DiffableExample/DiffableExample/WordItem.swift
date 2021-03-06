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
    
    var identifier: UUID { UUID() }
//    var identifier: TimeInterval { Date().timeIntervalSince1970 }

}

extension WordItem: Hashable {
    static func == (lhs: WordItem, rhs: WordItem) -> Bool {
        lhs.identifier == rhs.identifier
    }
 
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
