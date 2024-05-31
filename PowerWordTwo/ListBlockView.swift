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
            List(data.lists) { list in
                if data.lists.firstIndex(where: {$0.id == list.id}) == 0 {
                    Section {
                        NavigationLink(
                            destination: ListContentView(selectedList: list, listIndex: data.lists.firstIndex(where: {$0.id == list.id}) ?? 0)
                        ) {
                            Text(list.name)
                        } // NavigationLinkここまで
                    }
                } else {
                    NavigationLink(
                        destination: ListContentView(selectedList: list, listIndex: data.lists.firstIndex(where: {$0.id == list.id}) ?? 0)
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
                    }
                }
            } // Lustここまで
            .navigationTitle("List")
            .navigationBarItems(trailing: AddListButton())
            
//            List {
//                ForEach(data.lists) { list in
//                    let listIndex = data.lists.firstIndex(where: { $0.id == list.id }) ?? 0
//                    if listIndex == 0 {
//                        Section {
//                            NavigationLink(
//                                destination: ListContentView(selectedList: list, listIndex: listIndex)
//                            ) {
//                                Text(list.name)
//                            }
//                        }
//                    } else {
//                        NavigationLink(
//                            destination: ListContentView(selectedList: list, listIndex: listIndex)
//                        ) {
//                            Text(list.name)
//                        }
//                        .swipeActions {
//                            Button(role: .destructive) {
//                                data.removeList(list)
//                                data.save()
//                            } label: {
//                                Label("Delete", systemImage: "trash")
//                            }
//                        }
//                    }
//                }
//            } // Listここまで
//            .navigationTitle("Lists")
//            .navigationBarItems(trailing: AddListButton())
    
        } // VStackここまで
    } // body ここまで
    
    private func rowReplace(from: IndexSet, to: Int, listIndex: Int) {
        data.lists[listIndex].dotlists.move(fromOffsets: from, toOffset: to)
        data.save()
    }

}

#Preview {
    ListBlockView()
        .environmentObject(WordData())
}
