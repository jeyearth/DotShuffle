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
    
    var body: some View {
        VStack {
            List(data.lists) { list in
                NavigationLink(
                    destination: List(selection: $selection) {
                        ForEach(list.dotlists, id: \.self) { word in
                            NavigationLink(
                                destination: EditView(word: $data.lists[0].dotlists[data.lists[0].dotlists.firstIndex(of: word)!])
                                    .onDisappear {
                                        selection = nil
                                        data.save()
                                    }
                            ) {
                                Text(word.text)
                            }
                            .navigationBarTitle(Text(list.name), displayMode: .inline)
                        }
                    }
                ) {
                    Text(list.name)
                } // Listここまで
                . navigationTitle("List")
            .navigationBarItems(trailing: AddListButton())
            }
            
//            List (selection: $selection) {
//                Section(header: Text("inbox")) {
//                    ForEach(data.lists[0].dotlists, id: \.self) { word in
//                        NavigationLink(
//                            destination: EditView(word: $data.lists[0].dotlists[data.lists[0].dotlists.firstIndex(of: word)!])
//                                .onDisappear {
//                                    // 一覧に戻る時にselectionをnilに変更
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
//                    .onMove(perform: rowReplace)
//                } // Sectionここまで
//            } // Listここまで
//            .navigationTitle("List")
////            .navigationBarTitle(Text("Configure List Items"), displayMode: .inline)
//            .navigationBarItems(trailing: AddListButton())
            
            
        } // VStackここまで
    } // body ここまで
    
    private func rowReplace(_ from: IndexSet, _ to: Int) {
        data.lists[0].dotlists.move(fromOffsets: from, toOffset: to)
        data.save()
    }
}

#Preview {
    ListBlockView()
        .environmentObject(WordData())
}
