//
//  Question.swift
//  PrefectureMaster
//
//  Created by 千葉和義 on 2023/02/20.
//

import SwiftUI

struct Question: Codable {
    var name: String
    var image: String
    var prefix: Prefix
    var tip: String
    var position: CGPoint
    
    enum Prefix: String, Codable {
        case to, `do`, fu, ken
        
        var string: String {
            switch self {
                case .to:
                    return "都"
                case .do:
                    return "道"
                case .fu:
                    return "府"
                case .ken:
                    return "県"
            }
        }
    }
    
    init(_ name: String, image: String, prefix: Prefix, tip: String, position: CGPoint) {
        self.name = name
        self.image = image
        self.prefix = prefix
        self.tip = tip
        self.position = position
    }
}

extension Question {
    static var allPrefecture: [Question] {
        let url = Bundle.main.url(forResource: "QuestionAllCases", withExtension: "json")
        guard let url else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        guard let decoded = data.decoded([Question].self) else {
            fatalError()
        }
        return decoded
    }
}
