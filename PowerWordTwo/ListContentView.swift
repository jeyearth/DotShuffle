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
    
    @State private var selectedWord: Word = Word()
    
    @State private var selectedItems: Set<Int> = []
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        //        VStack {
        //            List (selection: $selection) {
        //                ForEach(data.lists[listIndex].dotlists, id: \.self) { word in
        //                    NavigationLink(
        //                        destination: EditView(word: $data.lists[listIndex].dotlists[data.lists[listIndex].dotlists.firstIndex(of: word)!])
        //                            .onDisappear {
        //                                // データの変更をビューの更新とは別のタイミングで行う
        //                                DispatchQueue.main.async {
        //                                    selection = nil
        //                                    data.save()
        //                                }
        //                            }
        //                    ) {
        //                        Text(word.text)
        //                            .swipeActions {
        //                                Button(role: .destructive) {
        //                                    selection = nil
        //                                    data.remove(listIndex, word)
        //                                    data.save()
        //                                } label: {
        //                                    Label("Delete", systemImage: "trash")
        //                                }
        //                            }
        //                    } // NavigationLinkここまで
        //                } // ForEachここまで
        //                .onMove(perform: rowReplace)
        //            } // Listここまで
        //            .navigationTitle(selectedList.name)
        //        } // VStackここまで
        
        //        NavigationView {
        //            List(selection: $selection) {
        //                ForEach(data.lists[listIndex].dotlists, id: \.self) { word in
        //                    NavigationLink(
        //                        destination: EditView(word: $data.lists[listIndex].dotlists[data.lists[listIndex].dotlists.firstIndex(of: word)!])
        //                            .onDisappear {
        //                                selection = nil
        //                                // データの変更をビューの更新とは別のタイミングで行う
        //                                DispatchQueue.main.async {
        //                                    selection = nil
        //                                    data.save()
        //                                }
        //                            }
        //                    ) {
        //                        Text(word.text)
        //                            .swipeActions {
        //                                Button(role: .destructive) {
        //                                    selection = nil
        //                                    data.remove(listIndex, word)
        //                                    data.save()
        //                                } label: {
        //                                    Label("Delete", systemImage: "trash")
        //                                }
        //                            }
        //                            .contextMenu {
        //                                Button {
        //                                    print()
        //                                } label: {
        //                                    VStack {
        //                                        Text("リストを移動")
        //                                        Picker("色を選択", selection: $selectionColor) {
        //                                            Text("赤").tag(Color.red)
        //                                            Text("青").tag(Color.blue)
        //                                            Text("緑").tag(Color.green)
        //                                        }                                    }
        //                                }
        //                            } // contextMenu ここまで
        //                            .onDisappear {
        //                                selection = nil
        //                            }
        //                    } // NavigationLinkここまで
        //                } // ForEachここまで
        //            } // Listここまで
        //            .navigationBarItems(
        //                trailing: EditButton()
        //            )
        //            .environment(\.editMode, $editMode)
        //            .navigationTitle(selectedList.name)
        //            .navigationBarItems(trailing: AddListButton())
        //        } // NavigationViewここまで
        
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
                        Menu("移動") {
                            Text("他のリストに移動する")
                            Picker("List", selection: $pickerList) {
                                ForEach(data.lists, id: \.self) { list in
                                    Text(list.name).tag(DotList?.some(list))
                                }
                            }
                            .onChange(of: pickerList, initial: false) { oldList, newList in
                                print("onChange Start!!")
                                if oldList.id != newList.id {
                                    changeListWords(selectedItems, from: oldList, to: newList)
                                    print("onChange Done!!!!!")
                                    data.save()
                                }
                                editMode = .inactive
                            }
                        }
                    }
                    
                    EditButton()
                }
        )
        .environment(\.editMode, $editMode)
        .navigationTitle(selectedList.name)
    } // bodyここまで
    
    private func rowReplace(_ from: IndexSet, _ to: Int) {
        data.lists[listIndex].dotlists.move(fromOffsets: from, toOffset: to)
        data.save()
    }
    
    func changeListWords(_ selectedItems: Set<Int>, from oldList: DotList, to newList: DotList) {
        var selectedWords: [Word] = []
        
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
    
}

#Preview {
    ListContentView( selectedList: DotList(), listIndex: 0)
        .environmentObject(WordData())
}
