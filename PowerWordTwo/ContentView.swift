//
//  ContentView.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: WordData
    @Environment(\.scenePhase) private var scenePhase
    
    @State var selection = 1  //タブの選択項目を保持する
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView( selectedWord: Word())
                .tabItem {
                    Label("Home",
                          systemImage: "person")
                }
                .tag(1)
            
            ListView()
                .tabItem {
                    Label("List",
                          systemImage: "list.bullet")
                }
                .tag(2)
        } // TabView ここまで
        .onChange(of: scenePhase) { _, phase in
            if phase == .inactive {
                data.save()
            }
        }
        .task {
            data.load()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WordData())
}
