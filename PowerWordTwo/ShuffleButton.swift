//
//  ShuffleButton.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/15.
//

import SwiftUI

struct ShuffleButton: View {
    @EnvironmentObject var data: WordData
    @Binding var selectedWord: Word
    @Binding var selectedNum: Int
    @Binding var beforeNum: Int
    
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        VStack {
            Button {
//                print(data.lists[0].dotlists[1].text)
//                data.addList(
//                    DotList(name: "two", dotlists:
//                        [
//                            Word(text: "Connecting the Dots"),
//                            Word(text: "Stay hungry, Stay foolish"),
//                            Word(text: "If today were the last day of my life, would I want to do what I am about to do today?"),
//                        ]
//                    )
//                )
                
                wordShuffle()
            } label: {
                Image(systemName: "shuffle")
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
            .alert("Error", isPresented: $isShowAlert) {
            } message: {
                // アラートのメッセージ...
                if data.lists[0].dotlists.count == 1 {
                    Text("ワードがひとつです。")
                } else if data.lists[0].dotlists.count == 0 {
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
    }
    
    func wordShuffle() {
        if data.lists[0].dotlists.count > 1 {
            while selectedNum == beforeNum {
                selectedNum = Int.random(in: 0...(data.lists[0].dotlists.count-1))
            }
            beforeNum = selectedNum
            selectedWord = data.lists[0].dotlists[selectedNum]
            doShuffle()
        } else {
            isShowAlert.toggle()
        }
    }
}

#Preview {
    ShuffleButton(
        selectedWord: .constant(Word()),
        selectedNum: .constant(0),
        beforeNum: .constant(0)
    )
        .environmentObject(WordData())
}
