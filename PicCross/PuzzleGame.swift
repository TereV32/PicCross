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
    @Binding var mistakes: Array<Bool>
    @Binding var toolSelected: String
    @Binding var colorSelected: Int
    @State var squareColor: Color  = .white
    @State var emptySquare = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Mistakes: ")
                Text("X")
                    .font(.headline)
                    .foregroundStyle(mistakes[0] ? Color.red : Color.gray)
                    .opacity(mistakes[0] ? 1.0 : 0.50)
                Text("X")
                    .font(.headline)
                    .foregroundStyle(mistakes[1] ? Color.red : Color.gray)
                    .opacity(mistakes[1] ? 1.0 : 0.50)
                Text("X")
                    .font(.headline)
                    .foregroundStyle(mistakes[2] ? Color.red : Color.gray)
                    .opacity(mistakes[2] ? 1.0 : 0.50)
            }
            
            PuzzleGrid(toolSelected: $toolSelected, mistakes: $mistakes, puzzleComplete: $puzzleComplete, puzzleFailed: $puzzleFailed, colorSelected: $colorSelected)
            
            PuzzleToolbar(toolSelected: $toolSelected, colorSelected: $colorSelected)
            .padding()
        }
    }
}

struct SquareView: View {
    
    @EnvironmentObject var puzzleData : PuzzleData
    let squareVal: Int
    let squareColorVal: Int

    var squareColor: Color {
        switch squareColorVal {
        case 0:
                .white
        case 1:
                .black
        case 2:
                .blue
        case 3:
                .yellow
        case 4:
                .red
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
            
            if squareVal == -2 {
                Text("X")
                    .frame(width: 20, height: 20)
                    .font(.system(size: 20))
                    .foregroundColor(Color.red)
            }
            
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
    PuzzleGame(puzzleComplete: .constant(false), puzzleFailed: .constant(false), mistakes: .constant([false, false, false]), toolSelected: .constant("Fill"), colorSelected: .constant(1)).environmentObject(PuzzleData())
}
