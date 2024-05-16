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
