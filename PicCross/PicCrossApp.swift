//
//  PicCrossApp.swift
//  PicCross
//
//  Created by Teresa Villegas on 5/14/24.
//

import SwiftUI

@main
struct PicCrossApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PuzzleData())
        }
    }
}
