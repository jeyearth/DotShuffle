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
    @State private var beforeListNum: Int = 0
    
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
                    beforeNum: $beforeNum,
                    beforeListNum: $beforeListNum
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
            doShuffle(
                data: data,
                selectedWord: &selectedWord,
                selectedNum: &selectedNum,
                beforeNum: &beforeNum,
                beforeListNum: &beforeListNum,
                selectedListNum: &selectedListNum,
                isShowAlert: &isShowAlert
            )
        }
    } // bodyここまで
    
}

#Preview {
    HomeView()
        .environmentObject(WordData())
}
