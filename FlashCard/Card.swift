//
//  Card.swift
//  FlashCard
//
//  Created by Daichi Morihara on 2022/01/16.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "who is current apples's CEO?", answer: "Tim Cook")
}
