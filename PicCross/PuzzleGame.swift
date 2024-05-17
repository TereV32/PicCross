//
//  PuzzleGame.swift
//  PicCross
//
//  Created by Teresa Villegas on 5/16/24.
//

import SwiftUI

struct PuzzleGame: View {
    
    @EnvironmentObject var puzzleData: PuzzleData
    @Binding var puzzleComplete: Bool
    @Binding var puzzleFailed: Bool
    @State var count = 0
    
    @State var toolSelected: String = "Fill"
    @State var squareColor: Color  = .white
    @State var emptySquare = ""
    @State var mistake = [false, false, false]
    
    var body: some View {
        VStack {
            HStack {
                Text("Mistakes: ")
                Text("X")
                    .font(.headline)
                    .foregroundStyle(mistake[0] ? Color.red : Color.gray)
                    .opacity(mistake[0] ? 1.0 : 0.50)
                Text("X")
                    .font(.headline)
                    .foregroundStyle(mistake[1] ? Color.red : Color.gray)
                    .opacity(mistake[1] ? 1.0 : 0.50)
                Text("X")
                    .font(.headline)
                    .foregroundStyle(mistake[2] ? Color.red : Color.gray)
                    .opacity(mistake[2] ? 1.0 : 0.50)
            }
            Grid {
                GridRow {
                    Color.clear
                        .gridCellUnsizedAxes([.vertical, .horizontal])
                    ForEach(puzzleData.gridSolution.indices, id: \.self) { column in
                        ZStack(alignment: .bottom) {
                            Rectangle().foregroundStyle(Color.gray)
                                .opacity(0.25)
                                .frame(width: 15, height: 55)
                            VStack {
                                ForEach(puzzleData.hintsXArray[column].indices, id: \.self) { num in
                                    Text("\(puzzleData.hintsXArray[column][num])")
                                        .frame(width: 12, height: 12)
                                        .font(.system(size: 10))
                                }
                                .padding(-4)
                            }
                            .padding(4)
                        }
                        
                    }
                }
                ForEach(puzzleData.gridSolution.indices, id: \.self) { row in
                    GridRow {
                        ZStack(alignment: .trailing) {
                            Rectangle().foregroundStyle(Color.gray)
                                .opacity(0.25)
                                .frame(width: 55, height: 15)
                            HStack {
                                ForEach(puzzleData.hintsYArray[row].indices, id: \.self) { num in
                                    Text("\(puzzleData.hintsYArray[row][num])")
                                        .font(.system(size: 10))
                                        .frame(width: 12.0, height: 12.0)
                                }
                                .padding(-4)
                            }
                            .padding(4)
                        }
                        ForEach(puzzleData.gridSolution[row].indices, id: \.self) { column in
                            SquareView(squareVal: puzzleData.gridState[row][column], squareColorVal: puzzleData.gridState[row][column])
                                .onTapGesture {
                                    checkSolution(squareVal: puzzleData.gridState[row][column], row: row, column: column, tool: toolSelected)
                                }
                        }
                    }
                }
            }
            HStack {
                Button(action: {
                    toolSelected = "Empty"
                    print(toolSelected)
                }, label: {
                    Rectangle().foregroundStyle(.gray)
                        .frame(width: 20, height: 20)
                })
                Button(action: {
                    toolSelected = "Fill"
                    print(toolSelected)
                }, label: {
                    Rectangle().foregroundStyle(.black)
                        .frame(width: 20, height: 20)
                })
            }
            .padding()
        }
    }
    
    func checkSolution(squareVal: Int, row: Int, column: Int, tool: String) {
        if toolSelected == "Fill" {
            if puzzleData.gridSolution[row][column] == 0 {
                print(squareVal)
                mistake[mistake.firstIndex(where: {$0 == false}) ?? 0] = true
                print(puzzleData.gridSolution[row][column])
                puzzleData.gridState[row][column] = -1
            } else if puzzleData.gridSolution[row][column] == 1{
                print(puzzleData.gridSolution[row][column])
                puzzleData.gridState[row][column] = 1
            }
        } else if toolSelected == "Empty" {
            if puzzleData.gridSolution[row][column] == 0 {
                print(squareVal)
                print(puzzleData.gridSolution[row][column])
                puzzleData.gridState[row][column] = 2
            } else if squareVal == 0 && puzzleData.gridSolution[row][column] == 1{
                print(puzzleData.gridSolution[row][column])
                mistake[mistake.firstIndex(where: {$0 == false}) ?? 0] = true
                puzzleData.gridState[row][column] = -1
            }
        }
        if puzzleData.gridSolution == puzzleData.gridState {
            puzzleComplete = true
        }
        if mistake[2] == true {
            puzzleFailed = true
        }
    }
}

struct SquareView: View {
    let squareVal: Int
    let squareColorVal: Int

    var squareColor: Color {
        switch squareColorVal {
        case 0:
                .white
        case 1:
                .black
        case 2:
                .gray
        case -1:
                .white
        default:
                .white
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(squareColor)
                .frame(width: 30, height: 30)
                .border(Color.black)
                .padding(-5.0)
            
            if squareVal == -1 {
                Text("X")
                    .frame(width: 20, height: 20)
                    .font(.system(size: 20))
                    .foregroundColor(Color.red)
            }
        }
    }
}

#Preview {
    PuzzleGame(puzzleComplete: .constant(false), puzzleFailed: .constant(false)).environmentObject(PuzzleData())
}
