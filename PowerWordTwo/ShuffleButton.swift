//
//  ShuffleButtonTwo.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/06/29.
//

import SwiftUI

struct ShuffleButton: View {
    @EnvironmentObject var data: WordData
    @State private var isShowAlert: Bool = false
    
    @Binding var shuffleData: ShuffleData
    
    var body: some View {
        VStack {
            Button {
                doShuffle(data: data, shuffleData: &shuffleData)
            } label: {
                Image(systemName: "shuffle")
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
            .alert("Error", isPresented: $shuffleData.isShowAlert) {
            } message: {
                // アラートのメッセージ...
                if shuffleData.trueIndices.count == 0 {
                    VStack {
                        Text("表示がオンのリストがありません。\n表示したいリストをオンにしてください。")
                    }
                } else {
                    if shuffleData.shuffleItemsCount == 0 {
                        Text("ワードがありません。")
                    } else if shuffleData.shuffleItemsCount == 1 {
                        Text("ワードがひとつです。")
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
        shuffleData: .constant(ShuffleData())
    )
    .environmentObject(WordData())
}
