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
    @State var toList: DotList = DotList()
    @State private var showingSheet: Bool = false
    
    var selectedList: DotList
    var listIndex: Int
    
    init(
        selectedWord: Binding<Word>, selectedList: DotList, listIndex: Int
    ) {
        self._selectedWord = selectedWord
        self._toList = State(initialValue: selectedList)
        self.selectedList = selectedList
        self.listIndex = listIndex
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
                                    if let listIndex =  data.lists.firstIndex(where: {$0.id == data.getDotListContainingWord(selectedWord)?.id}) {
                                        if let index = data.lists[listIndex].dotlists.firstIndex(where: { $0.id == selectedWord.id }) {
                                            data.lists[listIndex].dotlists[index].text = selectedWord.text
                                            data.save()
                                            print(selectedWord.text)
                                            print("word changed!")
                                            print(data.lists[listIndex].dotlists[index].text)
                                        } else {
                                            print("Item not found")
                                        }
                                    }
                                    showingSheet = false
                                } label: {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                        .padding(.top, 6)
                                } // Buttonここまで
                            } // ToolbarItemここまで
                        } // toolbarここまで
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
