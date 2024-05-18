//
//  Puzzles.swift
//  PicCross
//
//  Created by Teresa Villegas on 5/16/24.
//

import Foundation

struct Puzzles: Decodable, Identifiable {
    struct Hint: Decodable {
        let count: Int
        let color: String
    }
    struct Colors: Decodable {
        let color: String
        let count: Int
    }
    let id: String
    let level: String
    let colors: [[Colors]]
    let gridSize: [Int]
    let solution: [[Int]]
    let hintsXArray: [[Hint]]
    let hintsYArray: [[Hint]]
}


// "hintsXArray": [{3: "black",1 : "black"}, {1: "black",1: "black",1: "black"}, {1: "black",1: "black",1: "black"}, {1: "black",1: "black",1: "black"}, {1: "black",3: "black"}],
//         "hintsYArray": [{5: "black"}, {1: "black"}, {5: "black"}, {1: "black"}, {5: "black"}]


