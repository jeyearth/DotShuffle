//
//  HomeView.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/08.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var data: WordData
    @State var selectedWord: Word = Word()
    
    @State private var selectedNum: Int = 0
    @State private var beforeNum: Int = 0
    
    @State private var showingSheet: Bool = false
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                Text("\(selectedWord.text)")
                    .frame(width: 340.0)
                Spacer()
                
                ShuffleButton(
                    selectedWord: $selectedWord,
                    selectedNum: $selectedNum,
                    beforeNum: $beforeNum
                )
                .padding(.bottom, 100)
            } // VStackここまで
            HStack {
                EditButton(selectedWord: $selectedWord)
                AddButton()
            }
            .padding()
        } // ZStackここまで
        .onAppear {
            initializeSelectedWord()
        }
    } // bodyここまで
    
    func initializeSelectedWord() {
        data.load()
        if data.lists[0].dotlists.count != 0 {
            // ランダムな単語と番号を初期化する
            let randomIndex = Int.random(in: 0..<data.lists[0].dotlists.count)
            beforeNum = randomIndex
            selectedWord = data.lists[0].dotlists[randomIndex]
            selectedNum = randomIndex
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(WordData())
}
