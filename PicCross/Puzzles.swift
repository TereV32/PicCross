//
//  Puzzles.swift
//  PicCross
//
//  Created by Teresa Villegas on 5/16/24.
//

import Foundation

struct Puzzles: Decodable, Identifiable {
    let id: String
    let name: String
    let gridSize: [Int]
    let solution: [[Int]]
    let hintsXArray: [[Int]]
    let hintsYArray: [[Int]]
}
