//
//  ListBlockView.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/17.
//

import SwiftUI

struct ListBlockView: View {
    @EnvironmentObject var data: WordData
    
    @State private var showingAddListSheet = false
    
    @State private var selectedWord: Word = Word()
    @State private var selectedList: DotList = DotList()
    
    var body: some View {
        VStack {
//            List(data.lists) { list in
//                if data.lists.firstIndex(where: {$0.id == list.id}) == 0 {
//                    Section {
//                        NavigationLink(
//                            destination: ListContentView(selectedList: list, listIndex: data.lists.firstIndex(where: {$0.id == list.id}) ?? 0)
//                        ) {
//                            Text(list.name)
//                        } // NavigationLinkここまで
//                    }
//                } else {
//                    NavigationLink(
//                        destination: ListContentView(selectedList: list, listIndex: data.lists.firstIndex(where: {$0.id == list.id}) ?? 0)
//                    ) {
//                        Text(list.name)
//                    } // NavigationLinkここまで
//                    .swipeActions {
//                        Button(role: .destructive) {
//                            data.removeList(list)
//                            data.save()
//                        } label: {
//                            Label("Delete", systemImage: "trash")
//                        }
//                    }
//                }
//            } // Lustここまで
//            .navigationTitle("List")
//            .navigationBarItems(trailing: AddListButton())
            
            List() {
                Section {
                    NavigationLink(
                        destination: ListContentView(selectedList: data.lists[0], listIndex: 0)
                    ) {
                        Text(data.lists[0].name)
                    } // NavigationLinkここまで
                }
                    
                ForEach(data.lists) { list in
                    if data.lists.firstIndex(where: {$0.id == list.id}) != 0 {
                        NavigationLink(
                            destination: 
                                ListContentView(selectedList: list, listIndex: data.lists.firstIndex(where: {$0.id == list.id}) ?? 0)
                        ) {
                            Text(list.name)
                        } // NavigationLinkここまで
                        .swipeActions {
                            Button(role: .destructive) {
                                data.removeList(list)
                                data.save()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        } // swipeActions
                        .contextMenu {
                            Button(role: .destructive) {
                                data.removeList(list)
                                data.save()
                                print("リスト削除完了！")
                            } label: {
                                Label("削除", systemImage: "trash")
                            }
                        } // contextMenu ここまで
                    } // ifここまで
                } // ForEachここまで
                .onMove(perform: rowReplace)
            } // Lustここまで
            .navigationTitle("List")
            .navigationBarItems(trailing: AddListButton())
        } // VStackここまで
    } // body ここまで
    
    private func rowReplace(_ from: IndexSet, _ to: Int) {
        data.lists.move(fromOffsets: from, toOffset: to)
        data.save()
    }

}

#Preview {
    ListBlockView()
        .environmentObject(WordData())
}
