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
    
    @State var selectedListNum: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ModeSettingButton()
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
                EditWordButton(selectedWord: $selectedWord, selectedList: data.getDotListContainingWord(selectedWord) ?? DotList(), listIndex: data.lists.firstIndex{ $0.dotlists.contains(where: { $0.id == selectedWord.id }) } ?? 0)
                AddButton()
            }
            .padding()
        } // ZStackここまで
        .onAppear {
            wordShuffle()
        }
    } // bodyここまで
    
    func wordShuffle() {
        data.load()
        let trueIndices = data.lists.enumerated().compactMap { (index, dotList) -> Int? in
            if dotList.isshow {
                if dotList.dotlists.count != 0 {
                    return index
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
        
        if trueIndices.count > 0 {
            if trueIndices.count > 1 {
                selectedListNum = trueIndices[Int.random(in: 0...(trueIndices.count-1))]
            } else {
                selectedListNum = trueIndices[0]
            }
            
            if data.lists[selectedListNum].dotlists.count > 1 {
                while selectedNum == beforeNum {
                    selectedNum = Int.random(in: 0...(data.lists[selectedListNum].dotlists.count-1))
                }
                beforeNum = selectedNum
                selectedWord = data.lists[selectedListNum].dotlists[selectedNum]
                doShuffle()
            } else {
                isShowAlert.toggle()
            }
        } else {
            isShowAlert.toggle()
        }
    } // wordShuffle()ここまで
    
}

#Preview {
    HomeView()
        .environmentObject(WordData())
}
