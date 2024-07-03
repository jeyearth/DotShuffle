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
    
    @State var shuffleData: ShuffleData = ShuffleData()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ModeSettingButton(shuffleData: $shuffleData)
                Spacer()
                Text("\(shuffleData.selectedWord.text)")
                    .frame(width: 340.0)
                Spacer()
                ShuffleButton(shuffleData: $shuffleData)
                    .padding(.bottom, 100)
            } // VStackここまで
            HStack {
                WordEditButton(shuffleData: $shuffleData, selectedList: data.lists[shuffleData.selectedListIndex])
                AddButton()
            }
            .padding()
        } // ZStackここまで
        .onAppear {
            shuffleData = ShuffleData(data: data)
            doShuffle(data: data, shuffleData: &shuffleData)
        }
    } // bodyここまで
    
}

#Preview {
    HomeView()
        .environmentObject(WordData())
}
