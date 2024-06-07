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
    @Binding var beforeListNum: Int
    
    @State var selectedListNum: Int = 0
    
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        VStack {
            Button {
                doShuffle(
                    data: data,
                    selectedWord: &selectedWord,
                    selectedNum: &selectedNum,
                    beforeNum: &beforeNum,
                    beforeListNum: &beforeListNum,
                    selectedListNum: &selectedListNum,
                    isShowAlert: &isShowAlert
                )
            } label: {
                Image(systemName: "shuffle")
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
            .alert("Error", isPresented: $isShowAlert) {
            } message: {
                // アラートのメッセージ...
                let trueIndices = data.lists.enumerated().compactMap { (index, dotList) -> Int? in
                    if dotList.isshow {
                        return index
                    } else {
                        return nil
                    }
                }
                
                if trueIndices.count == 0 {
                    VStack {
                        Text("表示がオンのリストがありません。\n表示したいリストをオンにしてください。")
                    }
                } else {
                    if data.lists[trueIndices[0]].dotlists.count == 1 {
                        Text("ワードがひとつです。")
                    } else if data.lists[trueIndices[0]].dotlists.count == 0 {
                        Text("ワードがありません。")
                    }
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
        beforeNum: .constant(0),
        beforeListNum: .constant(0)
    )
        .environmentObject(WordData())
}
