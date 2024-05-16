//
//  ListView.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/08.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var data: WordData
    @State private var selection: Word?
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                List (selection: $selection) {
                    ForEach(data.words, id: \.self) { word in
                        NavigationLink(
                            destination: EditView(word: $data.words[data.words.firstIndex(of: word)!])
                                .onDisappear {
                                    // 一覧に戻る時にselectionをnilに変更
                                    selection = nil
                                    data.save()
                                }
                        ) {
                            Text(word.text)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        selection = nil
                                        data.remove(word)
                                        data.save()
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        } // NavigationLinkここまで
                    } // ForEachここまで
                    .onMove(perform: rowReplace)
                } // Listここまで
                .navigationTitle("List")
                HStack {
                    AddButton()
                }
                .padding()
            } // ZStackここまで
        } //NavigationStackここまで
    } // bodyここまで
    
    private func rowReplace(_ from: IndexSet, _ to: Int) {
        data.words.move(fromOffsets: from, toOffset: to)
    }
}

#Preview {
    ListView()
        .environmentObject(WordData())
}
