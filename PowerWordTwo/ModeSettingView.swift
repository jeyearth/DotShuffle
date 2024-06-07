//
//  ModeSettingView.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/20.
//

import SwiftUI

struct ModeSettingView: View {
    @EnvironmentObject var data: WordData
    
    var body: some View {
        VStack {
            List {
                Section {
                    Toggle(isOn: $data.lists[0].isshow, label: {
                        Text(data.lists[0].name)
                    })
                }
                
                ForEach(data.lists) { list in
                    let listIndex = data.lists.firstIndex(where: { $0.id == list.id }) ?? 0
                    if listIndex != 0 {
                        if let index = data.lists.firstIndex(where: {$0.id == list.id}) {
                            Toggle(isOn: $data.lists[index].isshow, label: {
                                Text(list.name)
                            })
                        }
                    }
                } // ForEachここまで
            } // Listここまで
            .navigationBarTitle("表示するリストを選択", displayMode: .inline)
        } // VStackここまで
    }
}

#Preview {
    ModeSettingView()
        .environmentObject(WordData())
}
