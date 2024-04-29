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
                
                //シャッフルボタン
                VStack {
                    Button {
                        if data.words.count > 1 {
                            while selectedNum == beforeNum {
                                selectedNum = Int.random(in: 0...(data.words.count-1))
                            }
                            beforeNum = selectedNum
                            selectedWord = data.words[selectedNum]
                        } else {
                            isShowAlert.toggle()
                        }
                    } label: {
                        Image(systemName: "shuffle")
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    }
                    .alert("Error", isPresented: $isShowAlert) {
                    } message: {
                        // アラートのメッセージ...
                        if data.words.count == 1 {
                            Text("ワードがひとつです。")
                        } else if data.words.count == 0 {
                            Text("ワードがありません。")
                        }
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 7)
                    .font(.title)
                }
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
        if data.words.count > 0 {
            // ランダムな単語と番号を初期化する
            let randomIndex = Int.random(in: 0..<data.words.count)
            beforeNum = randomIndex
            selectedWord = data.words[randomIndex]
            selectedNum = randomIndex
        }
    }
}

#Preview {
    HomeView( selectedWord: Word())
        .environmentObject(WordData())
}
