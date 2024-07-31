//
//  ListContentView.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/24.
//

import SwiftUI

struct ListContentView: View {
    @EnvironmentObject var data: WordData
    @State var toList: DotList = DotList()
    @State private var pickerList: DotList = DotList()
    var selectedList: DotList
    var listIndex: Int
    
    init(selectedList: DotList, listIndex: Int) {
        self.selectedList = selectedList
        self.listIndex = listIndex
        self._toList = State(initialValue: selectedList)
        self._pickerList = State(initialValue: selectedList)
    }
    
    @State private var selectedItems: Set<Int> = []
    @State private var editMode: EditMode = .inactive
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        List(selection: $selectedItems) {
            ForEach(data.lists[listIndex].dotlists.indices, id: \.self) { index in
                NavigationLink(destination:
                                EditView(word: $data.lists[listIndex].dotlists[index], toList: $toList)
                    .onDisappear {
                        selectedItems = []
                        if !toList.name.isEmpty {
                            if data.lists[listIndex].id != toList.id {
                                data.changeList(data.lists[listIndex].dotlists[index], from: data.lists[listIndex], to: toList)
                                data.save()
                            }
                        }
                    }
                ) {
                    Text(data.lists[listIndex].dotlists[index].text).tag(index)
                        .swipeActions {
                            Button(role: .destructive) {
                                selectedItems = []
                                data.remove(listIndex, data.lists[listIndex].dotlists[index])
                                editMode = .inactive
                                data.save()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .contextMenu {
                            Button {
                                print("リスト移動")
                            } label: {
                                Menu("リスト移動") {
                                    Picker("List", selection: $pickerList) {
                                        ForEach(data.lists, id: \.self) { list in
                                            Text(list.name).tag(DotList?.some(list))
                                        }
                                    }
                                    .onChange(of: pickerList, initial: false) { oldList, newList in
                                        print("onChange Start!!")
                                        if oldList.id != newList.id {
                                            data.changeList(data.lists[listIndex].dotlists[index], from: oldList, to: newList)
                                            print("onChange Done!!!!!")
                                            data.save()
                                        }
                                    }
                                }
                            }
                            Button(role: .destructive) {
                                selectedItems = []
                                data.remove(listIndex, data.lists[listIndex].dotlists[index])
                                data.save()
                                print("削除完了！")
                            } label: {
                                Label("削除", systemImage: "trash")
                            }
                        } // contextMenu ここまで
                }
            } // ForEachここまで
            .onMove(perform: rowReplace)
        } // Listここまで
        .navigationBarItems(
            trailing:
                HStack {
                    if editMode == .active {
                        if selectedItems.count != 0 {
                            Button(role: .destructive) {
                                removeSelectedItems(selectedItems, listIndex)
                                selectedItems = []
                                editMode = .inactive
                                data.save()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            Menu("移動") {
                                Picker("List", selection: $pickerList) {
                                    ForEach(data.lists, id: \.self) { list in
                                        Text(list.name).tag(DotList?.some(list))
                                    }
                                }
                                .onChange(of: pickerList, initial: false) { oldList, newList in
                                    if selectedItems.count != 0 && newList != data.lists[listIndex] {
                                        print("onChange Start!!")
                                        if oldList.id != newList.id {
                                            changeListWords(selectedItems, from: oldList, to: newList)
                                            print("onChange Done!!!!!")
                                            data.save()
                                        }
                                        editMode = .inactive
                                    }
                                    
                                    if selectedItems.count == 0 {
                                        self.pickerList = data.lists[listIndex]
                                    }
                                } // onChangeここまで
                            } // Menuここまで
                        } else {
                            HStack {
                                Button {
                                    isShowAlert = true
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button {
                                    isShowAlert = true
                                } label: {
                                    Text("移動")
                                }
                            }
                        } // if ここまで
                    } // if ここまで
                    EditButton()
                }
        )
        .environment(\.editMode, $editMode)
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("エラー"), message: Text("選択されていません。"), dismissButton: .default(Text("OK")))
        }
        .navigationTitle(selectedList.name)
    } // bodyここまで
    
    private func rowReplace(_ from: IndexSet, _ to: Int) {
        data.lists[listIndex].dotlists.move(fromOffsets: from, toOffset: to)
        data.save()
    }
    
    func changeListWords(_ selectedItems: Set<Int>, from oldList: DotList, to newList: DotList) {
        var selectedWords: [Word] = []
        let selectedItems = selectedItems.sorted()
        
        for selectedItem in selectedItems {
            selectedWords.append(data.lists[listIndex].dotlists[selectedItem])
        }
        
        if let oldListIndex = data.lists.firstIndex(where: { $0.id == oldList.id }) {
            print("oldListIndex→ \(oldListIndex)")
            for selectedWord in selectedWords {
                data.lists[oldListIndex].dotlists.removeAll(where: { $0.id == selectedWord.id })
            }
        }
        
        if let newListIndex = data.lists.firstIndex(where: { $0.id == newList.id }) {
            print("newListIndex→ \(newListIndex)")
            print("word→ \(selectedItems)")
            for selectedWord in selectedWords {
                data.lists[newListIndex].dotlists.append(selectedWord)
            }
        }
        print("chnageList success")
        self.selectedItems = []
    }
    
    func removeSelectedItems(_ selectedItems: Set<Int>, _ listindex: Int) {
        let items = selectedItems.sorted(){ $0 > $1 }
        print(items)
        items.forEach { item in
            data.remove(listIndex, data.lists[listIndex].dotlists[item])
        }
    }
}

#Preview {
    ListContentView( selectedList: DotList(), listIndex: 0)
        .environmentObject(WordData())
}
