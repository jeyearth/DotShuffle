//
//  PowerWordTwoApp.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/07.
//

import SwiftUI

@main
struct DotShuffle: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WordData())
        }
    }
}
