//
//  ListBlockView.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/17.
//

import SwiftUI

struct ListBlockView: View {
    @EnvironmentObject var data: WordData
    @State private var selection: Word?
    
    @State private var showingAddListSheet = false
    
    @State private var selectedWord: Word = Word()
    @State private var selectedList: DotList = DotList()
    
    var body: some View {
        VStack {
//            List(data.lists) { list in
////                if let index = data.lists.firstIndex(where: {$0.id == list.id}) {
//                    NavigationLink(
//                        destination: List(selection: $selection) {
//                            ForEach(list.dotlists, id: \.self) { word in
////                                selectedWord = word
//                                NavigationLink(
////                                    destination: EditView(word: $word)
//                                    destination: EditView(word: $data.lists[0].dotlists[data.lists[0].dotlists.firstIndex(of: word)!])
////                                    destination: EditView(word: $data.lists[index].dotlists[data.lists[index].dotlists.firstIndex(of: word)!])
////                                    destination: EditView(word: $data.lists[index ?? 0].dotlists[data.lists[index ?? 0].dotlists.firstIndex(of: word)!])
//                                        .onDisappear {
//                                            selection = nil
//                                            data.save()
//                                        }
//                                ) {
//                                    Text(word.text)
//                                } // NavigationLnkここまで
//                                .navigationBarTitle(Text(list.name), displayMode: .inline)
//                            } // ForEachここまで
//                            .onMove(perform: { from, to in
//                                rowReplace(from: from, to: to, listIndex: data.lists.firstIndex(where: { $0.id == list.id })!)
//                            })
//                            //                        .onMove(perform: rowReplace)
//                        }
//                    ) {
//                        Text(list.name)
//                    } // NavigationLinkここまで
//                    . navigationTitle("List")
//                    .navigationBarItems(trailing: AddListButton())
////                } // if文ここまで
//            } // Lustここまで
            
            List(data.lists) { list in
                    NavigationLink(
                        destination: ListContentView(selectedList: list, listIndex: data.lists.firstIndex(where: {$0.id == list.id}) ?? 0)
                    ) {
                        Text(list.name)
                    } // NavigationLinkここまで
                    .swipeActions {
                        Button(role: .destructive) {
                            selection = nil
                            data.removeList(list)
                            data.save()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .navigationTitle("List")
                    .navigationBarItems(trailing: AddListButton())
            } // Lustここまで
            
//            List (selection: $selection) {
//                Section(header: Text("inbox")) {
//                    ForEach(data.lists[0].dotlists, id: \.self) { word in
//                        let index = 0
//                        NavigationLink(
//                            destination: EditView(word: $data.lists[index].dotlists[data.lists[index].dotlists.firstIndex(of: word)!])
////                            destination: EditView(word: $data.lists[0].dotlists[data.lists[0].dotlists.firstIndex(of: word)!])
//                                .onDisappear {
//                                    // 一覧に戻る時にselectionをnilに変更
//                                    print("onDisappear!")
//                                    selection = nil
//                                    data.save()
//                                }
//                        ) {
//                            Text(word.text)
//                                .swipeActions {
//                                    Button(role: .destructive) {
//                                        selection = nil
//                                        data.remove(word)
//                                        data.save()
//                                    } label: {
//                                        Label("Delete", systemImage: "trash")
//                                    }
//                                }
//                        } // NavigationLinkここまで
//                    } // ForEachここまで
////                    .onMove(perform: rowReplace)
//                } // Sectionここまで
//            } // Listここまで
//            .navigationTitle("List")
////            .navigationBarTitle(Text("Configure List Items"), displayMode: .inline)
//            .navigationBarItems(trailing: AddListButton())
            
        } // VStackここまで
//        .onAppear {
//            initialize()
//        }
    } // body ここまで
    
//    private func rowReplace(_ from: IndexSet, _ to: Int) {
//        data.lists[0].dotlists.move(fromOffsets: from, toOffset: to)
//        data.save()
//    }
    
    func initialize() {
        data.load()
    }
    
    private func rowReplace(from: IndexSet, to: Int, listIndex: Int) {
        data.lists[listIndex].dotlists.move(fromOffsets: from, toOffset: to)
        data.save()
    }

}

#Preview {
    ListBlockView()
        .environmentObject(WordData())
}
