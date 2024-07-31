//
//  WordEditButton.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/07/01.
//

import SwiftUI

struct WordEditButton: View {
    @EnvironmentObject var data: WordData
    @State private var showingSheet: Bool = false
    @Binding var shuffleData: ShuffleData
    @State var toList: DotList = DotList()
    
    var selectedList: DotList
    
    init(shuffleData: Binding<ShuffleData>, selectedList: DotList) {
        self.selectedList = selectedList
        self._shuffleData = shuffleData
        self._toList = State(initialValue: selectedList)
    }

    var body: some View {
        VStack {
            Button {
                showingSheet.toggle()
            } label: {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            } // Button Labelここまで
            .sheet(isPresented: $showingSheet) {
                NavigationStack {
                    WordEditView(shuffleData: $shuffleData, toList: $toList)
                        .onDisappear {
                            // リスト間移動
                            if data.lists[shuffleData.selectedListIndex].id != toList.id {
                                data.changeList(shuffleData.selectedWord, from: data.lists[shuffleData.selectedListIndex], to: toList)
                            }
                        }
                        .toolbar {
                            ToolbarItem {
                                Button {
                                    data.updataWordText(shuffleData.selectedWord, shuffleData.selectedWord.text)
                                    showingSheet = false
                                } label: {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                        .padding(.top, 6)
                                }
                            }
                        } // toolbarここまで
                }
            } // sheetここまで
            .buttonStyle()
        } // VStackここまで
        .onAppear {
            initializeSelectedList()
        }
    } // bodyここまで
    
    func initializeSelectedList() {
        toList = data.lists[shuffleData.selectedListIndex]
    }

}

#Preview {
    WordEditButton(
        shuffleData: .constant(ShuffleData()),
        selectedList: DotList()
    )
}
