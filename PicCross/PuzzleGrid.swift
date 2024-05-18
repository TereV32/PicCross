//
//  PuzzleGrid.swift
//  PicCross
//
//  Created by Teresa Villegas on 5/17/24.
//

import SwiftUI

struct PuzzleGrid: View {
    
    @EnvironmentObject var puzzleData: PuzzleData
    @Binding var toolSelected: String
    @Binding var mistakes: Array<Bool>
    @Binding var puzzleComplete: Bool
    @Binding var puzzleFailed: Bool
    @Binding var colorSelected: Int
    
    var body: some View {
        Grid {
            GridRow {
                Color.clear
                    .gridCellUnsizedAxes([.vertical, .horizontal])
                ForEach(puzzleData.gridSolution.indices, id: \.self) { column in
                    VStack {
                        ForEach(puzzleData.hintsXArray[column].indices, id: \.self) { num in
                            Text("\(puzzleData.hintsXArray[column][num].count)")
                                .frame(width: 12, height: 12)
                                .background(colorFromString(color: puzzleData.hintsXArray[column][num].color))
                                .foregroundStyle(Color.white)
                                .font(.system(size: 10))
                        }
                        .padding(-4)
                    }
                    .padding(4)
                }
            }
            ForEach(puzzleData.gridSolution.indices, id: \.self) { row in
                GridRow {
                    HStack {
                        ForEach(puzzleData.hintsYArray[row].indices, id: \.self) { num in
                            Text("\(puzzleData.hintsYArray[row][num].count)")
                                .frame(width: 12.0, height: 12.0)
                                .background(colorFromString(color: puzzleData.hintsYArray[row][num].color))
                                .foregroundStyle(Color.white)
                                .font(.system(size: 10))
                        }
                        .padding(-4)
                    }
                    .padding(4)
                    ForEach(puzzleData.gridSolution[row].indices, id: \.self) { column in
                        SquareView(squareVal: puzzleData.gridState[row][column], squareColorVal: puzzleData.gridState[row][column])
                            .onTapGesture {
                                checkSolution(squareVal: puzzleData.gridState[row][column], row: row, column: column, tool: toolSelected)
                            }
                    }
                }
            }
        }
    }
    
    func checkSolution(squareVal: Int, row: Int, column: Int, tool: String) {
        if toolSelected == "Fill" {
            if puzzleData.gridSolution[row][column] == 0 {
                print(squareVal)
                mistakes[mistakes.firstIndex(where: {$0 == false}) ?? 0] = true
                print(puzzleData.gridSolution[row][column])
                puzzleData.gridState[row][column] = -1
            } else if puzzleData.gridSolution[row][column] >= 1{
                print(puzzleData.gridSolution[row][column])
                print(colorSelected)
                if colorSelected == puzzleData.gridSolution[row][column] {
                    puzzleData.gridState[row][column] = colorSelected
                } else {
                    mistakes[mistakes.firstIndex(where: {$0 == false}) ?? 0] = true
                    puzzleData.gridState[row][column] = -1
                }
            }
        } else if toolSelected == "Empty" {
            if puzzleData.gridSolution[row][column] == 0 {
                print("Empty")
                print(squareVal)
                print(puzzleData.gridSolution[row][column])
                puzzleData.gridState[row][column] = -2
                print(puzzleData.gridState)
            } else if squareVal == 0 && puzzleData.gridSolution[row][column] == 1{
                print(puzzleData.gridSolution[row][column])
                mistakes[mistakes.firstIndex(where: {$0 == false}) ?? 0] = true
                puzzleData.gridState[row][column] = -1
            }
        }
        if puzzleData.gridSolution == puzzleData.gridState {
            puzzleComplete = true
        }
        if mistakes[2] == true {
            puzzleFailed = true
        }
    }
    
    func colorFromString(color: String) -> Color {
        switch color {
        case "black":
            return .black
        case "white":
            return .white
        case "red":
            return .red
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        default:
            return .black
        }
    }
}

#Preview {
    PuzzleGrid(toolSelected: .constant("Fill"), mistakes: .constant([false, false, false]), puzzleComplete: .constant(false), puzzleFailed: .constant(false), colorSelected: .constant(1)).environmentObject(PuzzleData())
}
