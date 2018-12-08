//
//  ChineseChar.swift
//  ChineseCharacterApp
//
//  Created by Risa Ulinski on 10/3/18.
//  Copyright © 2018 Hamilton College CS Senior Seminar. All rights reserved.
//

import Foundation

class ChineseChar {
    var char : String
    var definition : String
    var pinyin: [String]
    var decomposition: String
    var radical: String
    var level: Int
    var strokes: [String]
    
    init(character: String, def: String, pin: [String], decomp: String, rad: String, strks: [String]) {
        char = character
        definition = def
        pinyin = pin
        radical = rad
        decomposition = decomp
        level = 0
        strokes = strks
    }
    
    init(character: String, def: String,  decomp: String, rad: String) {
        char = character
        definition = def
        pinyin = []
        radical = rad
        decomposition = decomp
        level = 0
        strokes = []
    }
}

extension ChineseChar: Equatable {
    static func == (lhs: ChineseChar, rhs: ChineseChar) -> Bool {
        return lhs.char == rhs.char
    }
}

extension ChineseChar: Hashable {
    var hashValue: Int {
        return char.hashValue 
    }
}
