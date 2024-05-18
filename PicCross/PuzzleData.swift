//
//  PuzzleData.swift
//  PicCross
//
//  Created by Teresa Villegas on 5/16/24.
//

import SwiftUI

final class PuzzleData: ObservableObject {
    @Published var puzzleNumber: Int = 1
    @Published var gridSolution: [[Int]] = [[]]
    @Published var colors: [[Puzzles.Colors]] = [[]]
    @Published var hintsXArray: [[Puzzles.Hint]] = [[]]
    @Published var hintsYArray: [[Puzzles.Hint]] = [[]]
    @Published var gridState: [[Int]] = [[]]
    @Published var emptyRow: [Int] = []
    
    // 0 = empty
    // 1 = filled
    // -1 = mistake (X)
    // 2 = blank
    
    
    init() {
        //        puzzleNumber = Int.random(in: 0..<puzzles.count)
        puzzleNumber = 2
        colors = puzzles[puzzleNumber].colors
        gridState = Array(repeating: Array(repeating: 0, count: puzzles[puzzleNumber].gridSize[0]), count: puzzles[puzzleNumber].gridSize[1])
        gridSolution = puzzles[puzzleNumber].solution
        hintsXArray = puzzles[puzzleNumber].hintsXArray
        hintsYArray = puzzles[puzzleNumber].hintsYArray

    }
}
