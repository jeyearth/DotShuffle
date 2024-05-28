//
//  ListContentView.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/24.
//

import SwiftUI

struct ListContentView: View {
    @EnvironmentObject var data: WordData
    @State private var selection: Word? = nil
    var selectedList: DotList
    var listIndex: Int
    
    @State private var selectedWord: Word = Word()
    
    var body: some View {
        VStack {
//            List (selection: $selection) {
//                    ForEach(data.lists[listIndex].dotlists, id: \.self) { word in
////                        return lists.first { $0.dotlists.contains(where: { $0.id == word.id }) }
//                        if let index = data.lists.firstIndex(where: {$0.id == selectedList.id}), let wordIndex = data.lists[listIndex].dotlists.firstIndex(of: word)
//                        {
////                            selectedWord = word
//                            NavigationLink(
////                                destination: EditView(word: $data.lists[index].dotlists[data.lists[index].dotlists.firstIndex(of: word)!])
//                                destination: EditView(word: $data.lists[listIndex].dotlists[wordIndex])
//                                    .onDisappear {
//                                        // 一覧に戻る時にselectionをnilに変更
//                                        print("onDisappear!")
//                                        selection = nil
//                                        data.save()
//                                    }
//                            ) {
//                                Text(word.text)
//                                    .swipeActions {
//                                        Button(role: .destructive) {
//                                            selection = nil
//                                            data.remove(word)
//                                            data.save()
//                                        } label: {
//                                            Label("Delete", systemImage: "trash")
//                                        }
//                                    }
//                            } // NavigationLinkここまで
//                        }
//                    } // ForEachここまで
//                    //                    .onMove(perform: rowReplace)
//            } // Listここまで
//            .navigationTitle(selectedList.name)
            
            
            List (selection: $selection) {
                ForEach(data.lists[listIndex].dotlists, id: \.self) { word in
                    NavigationLink(
                        destination: EditView(word: $data.lists[listIndex].dotlists[data.lists[listIndex].dotlists.firstIndex(of: word)!])
                            .onDisappear {
                                // データの変更をビューの更新とは別のタイミングで行う
                                DispatchQueue.main.async {
                                    selection = nil
                                    data.save()
                                }
                            }
                    ) {
                        Text(word.text)
                            .swipeActions {
                                Button(role: .destructive) {
                                    selection = nil
                                    data.remove(listIndex, word)
                                    data.save()
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    } // NavigationLinkここまで
                } // ForEachここまで
                .onMove(perform: rowReplace)
            } // Listここまで
            .navigationTitle(selectedList.name)
        } // VStackここまで
    } // bodyここまで
    
    private func rowReplace(_ from: IndexSet, _ to: Int) {
        data.lists[listIndex].dotlists.move(fromOffsets: from, toOffset: to)
        data.save()
    }
    
}

#Preview {
    ListContentView( selectedList: DotList(), listIndex: 0)
        .environmentObject(WordData())
}
