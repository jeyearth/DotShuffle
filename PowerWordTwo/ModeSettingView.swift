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
                ForEach(data.lists) { list in
                    if let index = data.lists.firstIndex(where: {$0.id == list.id}) {
                        Toggle(isOn: $data.lists[index].isshow, label: {
                            Text(list.name)
                        })
                    }
                } // ForEachここまで
            } // Listここまで
            .navigationTitle("表示するリストを選択")
        } // VStackここまで
    }
}

#Preview {
    ModeSettingView()
        .environmentObject(WordData())
}
