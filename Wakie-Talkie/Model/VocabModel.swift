//
//  VocabModel.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/21/24.
//

import Foundation
struct Vocab:Codable, Equatable {
    let word: String
    let koreanMeaning: String
    let antonym: String
    let synonym: String
    let sentence: String

    enum CodingKeys: String, CodingKey {
        case word
        case koreanMeaning = "korean meaning"
        case antonym
        case synonym
        case sentence
    }
}
