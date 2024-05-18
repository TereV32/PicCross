//
//  PuzzleToolbar.swift
//  PicCross
//
//  Created by Teresa Villegas on 5/17/24.
//

import SwiftUI

struct PuzzleToolbar: View {
    
    @EnvironmentObject var puzzleData: PuzzleData
    @Binding var toolSelected: String
    @Binding var colorSelected: Int
    
    var body: some View {
        HStack {
            Button(action: {
                toolSelected = "Empty"
                print(toolSelected)
            }, label: {
                Text("X")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.red)
                    .border(Color.black)

            })
            ForEach(puzzleData.colors.indices, id: \.self) { item in
                ForEach(puzzleData.colors[item].indices, id: \.self) { color in
                    Button(action: {
                        toolSelected = "Fill"
                        colorSelected = puzzleData.colors[item][color].count
                        print(toolSelected)
                        print(colorSelected)
                    }, label: {
                        Rectangle().foregroundStyle(colorFromString(color: puzzleData.colors[item][color].color))
                            .frame(width: 20, height: 20)
                            .border(Color.black)
                    })
                }
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
    PuzzleToolbar(toolSelected: .constant("Fill"), colorSelected: .constant(1)).environmentObject(PuzzleData())
}
