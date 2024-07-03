//
//  EditView.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/09.
//
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var data: WordData
    @Binding var word: Word
    @Binding var toList: DotList
    
    @State private var selectedList: DotList?
    
    @State var editedText: String
    
    init(word: Binding<Word>, toList: Binding<DotList>) {
        self._word = word
        self._editedText = State(initialValue: word.wrappedValue.text)
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
                
                ZStack(alignment: .topLeading) {
                    VStack {
                        TextEditor(text: $editedText)
                            .frame(height: 200)
                            .disableAutocorrection(true)
                        if editedText.isEmpty {
                                Text("ここに文字を入力してください。")
                                    .foregroundColor(Color(uiColor: .placeholderText))
                                    .allowsHitTesting(false)
                                    .padding(7)
                                    .padding(.top, 2)
                            }
                    }
                } // ZStackここまで
            } // Listここまで
        } // VStackここまで
        .onAppear {
            initializeSelectedList(word: word)
        }
        .onDisappear {
            word.text = editedText
            data.save()
        }
    } // bodyここまで
    
    func initializeSelectedList(word: Word) {
        guard !data.lists.isEmpty else {
            selectedList = nil
            return
        }
        
        if let containingList = data.getDotListContainingWord(word) {
            selectedList = containingList
            toList = containingList
        } else {
            selectedList = data.lists.first
            toList = data.lists.first!
        }
    }
    
}

#Preview {
    EditView(
        word: .constant(Word()),
        toList: .constant(DotList())
    )
    .environmentObject(WordData())
}
