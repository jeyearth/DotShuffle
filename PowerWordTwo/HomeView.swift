//
//  HomeView.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/08.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var data: WordData
    @State private var selectedWord: Word = Word()
    
    @State private var selectedNum: Int = 0
    @State private var beforeNum: Int = 0
    
    @State private var showingSheet: Bool = false
    @State private var isShowAlert: Bool = false
    
    init() {
        _beforeNum = State(initialValue: Int.random(in: 0...(WordData().words.count - 1)))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                //ワード表示
                if selectedWord.text == "" {
                    Text("\(data.words[beforeNum].text)")
                        .frame(width: 340.0)
                }
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
    } // bodyここまで
}

#Preview {
    HomeView()
        .environmentObject(WordData())
}
