//
//  EditView.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/09.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var data: WordData
    @Binding var word: Word
    
    @FocusState var isFocused: Bool
    
    @State var selectionValue = "Inbox"
    
    @State private var selectedList: DotList?
    
//    init(word: Binding<Word>) {
//        self._word = word
////        _selectedList = State(initialValue: data.getDotListContainingWord(word.wrappedValue))
//        _selectedList = State(initialValue: 
//                                data.lists.firstIndex(where: { $0.dotlists.contains(word.wrappedValue) })
//        )
//    }
    
    var body: some View {
        VStack {
            List {
//                Picker("List", selection: $selectedList) {
//                    ForEach(data.lists, id: \.self) { list in
//                        Text(list.name).tag(list)
//                    }
//                }
//                .pickerStyle(MenuPickerStyle())
//                .onChange(of: selectedList) { newList in
////                    if let newList = newList {
////                        changeList(newList)
////                    }
//                    
//                    if selectedList != nil {
//                        changeList(selectedList ?? DotList())
//                    }
//                }
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $word.text)
                        .frame(height: 200)
                        .focused($isFocused)
                    if word.text.isEmpty {
                        Text("ここに文字を入力してください。")
                            .foregroundColor(Color(uiColor: .placeholderText))
                            .allowsHitTesting(false)
                            .padding(7)
                            .padding(.top, 2)
                    }
                }
            } // Listここまで
        } // VStackここまで
    } // bodyここまで
    
//    // wordを渡して所属するlistを返す関数
//    func getDotListContainingWord(_ word: Word) -> DotList? {
//        for dotList in data.lists {
////            if let index = dotList.dotlists.firstIndex(where: { $0.id == word.id }) {
//            if dotList.dotlists.firstIndex(where: { $0.id == word.id }) != nil {
//                return dotList
//            }
//        }
//        return nil
//    }
    
    func changeList(_ newList: DotList) {
         // wordが現在のリストから削除される
        if let oldListIndex = data.lists.firstIndex(where: { $0.dotlists.contains(word) }) {
            data.lists[oldListIndex].dotlists.removeAll(where: { $0.id == word.id })
         }
        
         // wordが新しいリストに追加される
//         newList.dotlists.append(word)
     }
    
}

#Preview {
    EditView(
        word: .constant(Word())
    )
    .environmentObject(WordData())
}
