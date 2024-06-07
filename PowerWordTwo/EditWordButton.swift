//
//  EditButton.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/15.
//

import SwiftUI

struct EditWordButton: View {
    @EnvironmentObject var data: WordData
    @Binding var selectedWord: Word
    @State private var showingSheet: Bool = false
    @State var toList: DotList = DotList()
    
    var selectedList: DotList
    var listIndex: Int
    
    init(
        selectedWord: Binding<Word>, selectedList: DotList, listIndex: Int
    ) {
        self._selectedWord = selectedWord
        self.selectedList = selectedList
        self.listIndex = listIndex
        self._toList = State(initialValue: selectedList)
    }
    
    var body: some View {
        HStack {
            Button(action: {
                self.showingSheet.toggle()
            }) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            } // Buttonここまで
            .sheet(isPresented: $showingSheet) {
                NavigationStack {
                    EditView(word: $selectedWord, toList: $toList)
                        .onDisappear {
                            if !toList.name.isEmpty {
                                if data.lists[listIndex].id != toList.id {
                                    data.changeList(selectedWord, from: data.lists[listIndex], to: toList)
                                    data.save()
                                }
                            }
                        }
                        .toolbar {
                            ToolbarItem {
                                Button {
                                    showingSheet = false
                                    if let listIndex =  data.lists.firstIndex(where: {$0.id == data.getDotListContainingWord(selectedWord)?.id}) {
                                        if let index = data.lists[listIndex].dotlists.firstIndex(where: { $0.id == selectedWord.id }) {
                                            // data.wordsの要素を直接変更
                                            data.lists[listIndex].dotlists[index].text = selectedWord.text
                                            data.save()
                                        } else {
                                            print("Item not found")
                                        }
                                    }
                                    
                                } label: {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                        .padding(.top, 6)
                                }
                            }
                        }
                } // NavigationStackここまで
            }
            .buttonStyle()
        } // HStackここまで
    } // bodyここまで
}

#Preview {
    EditWordButton(
        selectedWord: .constant(Word()),
        selectedList: DotList(),
        listIndex: 0
    )
        .environmentObject(WordData())
}
