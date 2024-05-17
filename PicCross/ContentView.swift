//
//  ContentView.swift
//  PicCross
//
//  Created by Teresa Villegas on 5/14/24.
//

import SwiftUI


struct ContentView: View {

    @State private var puzzleComplete = false
    @State private var puzzleFailed = false
    
    var body: some View {
        NavigationStack{
            PuzzleGame(puzzleComplete: $puzzleComplete, puzzleFailed: $puzzleFailed)
            
                .navigationDestination(isPresented: $puzzleComplete) {
                    VStack {
                        Text("Complete")
                    }
                }
                .navigationDestination(isPresented: $puzzleFailed) {
                    VStack {
                        Text("Failed")
                    }
                }
        }
    }
}

struct CompletePuzzle: View {
    var body: some View {
        VStack {
            Text("Complete")
        }
    }
}


#Preview {
    ContentView().environmentObject(PuzzleData())
}
