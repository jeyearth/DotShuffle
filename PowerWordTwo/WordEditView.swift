//
//  WordEditView.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/07/01.
//

import SwiftUI

struct WordEditView: View {
    @EnvironmentObject var data: WordData
    @Binding var shuffleData: ShuffleData
    @Binding var toList: DotList
    
    init(shuffleData: Binding<ShuffleData>, toList: Binding<DotList>) {
        self._shuffleData = shuffleData
        self._toList = toList
    }
    
    var body: some View {
        VStack {
            Form {
                Picker("List", selection: $toList) {
                    ForEach(data.lists, id: \.self) { list in
                        Text(list.name).tag(list)
                    }
                }
                TextEditor(text: $shuffleData.selectedWord.text)
                    .frame(height: 200)
                    .disableAutocorrection(true)
            }
        }
        .onAppear {
            initializeSelectedList()
        }
    } // bodyここまで
    
    func initializeSelectedList() {
        toList = data.lists[shuffleData.selectedListIndex]
    }
}

#Preview {
    WordEditView(
        shuffleData: .constant(ShuffleData()),
        toList: .constant(DotList())
    )
}
