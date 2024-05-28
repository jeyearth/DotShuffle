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
    
    @State private var selectedList: DotList?
    
    @State private var editedText: String
    
    init(word: Binding<Word>) {
        self._word = word
        self._editedText = State(initialValue: word.wrappedValue.text)
    }
    
    @State var lists:[DotList]?
    
    var body: some View {
        VStack {
            
            List {
                Picker("List", selection: $selectedList) {
                    ForEach(data.lists, id: \.self) { list in
                        Text(list.name).tag(DotList?.some(list))
                    }
                }
                .onChange(of: selectedList ?? DotList(), initial: false) { oldList, newList in
                    print("onChange Start!!")
                    if oldList.name != "" {
                        if oldList.id != newList.id {
                            changeList(word, from: oldList, to: newList)
                            print("onChange Done!!!!!")
                            data.save()
                        }
                    }
                }
                
                ZStack(alignment: .topLeading) {
                    VStack {
                        TextEditor(text: $editedText)
                            .frame(height: 200)
                            .onChange(of: editedText) {
                                // inputTextが変更されたときに、newWord.textも更新します
                                word.text = editedText
                            }
                            .disableAutocorrection(true)
                        if word.text.isEmpty {
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
    } // bodyここまで
    
    func initializeSelectedList(word: Word) {
        guard !data.lists.isEmpty else {
            selectedList = nil
            return
        }
        
        if let containingList = data.getDotListContainingWord(word) {
            selectedList = containingList
        } else {
            selectedList = data.lists.first
        }
        print("initialize done")
    }
    
    func changeList(_ word: Word, from oldList: DotList, to newList: DotList) {
        if let oldListIndex = data.lists.firstIndex(where: { $0.id == oldList.id }) {
            print("oldListIndex→ \(oldListIndex)")
            data.lists[oldListIndex].dotlists.removeAll(where: { $0.id == word.id })
        }
        
        if let newListIndex = data.lists.firstIndex(where: { $0.id == newList.id }) {
            print("newListIndex→ \(newListIndex)")
            print("word→ \(word)")
            data.lists[newListIndex].dotlists.append(word)
        }
        print("chnageList success")
    }
    
    func updateWordList(to newListID: UUID) {
        if let oldListIndex = data.lists.firstIndex(where: { $0.dotlists.contains(word) }) {
            data.lists[oldListIndex].dotlists.removeAll(where: { $0.id == word.id })
        }
        
        if let newListIndex = data.lists.firstIndex(where: { $0.id == newListID }) {
            data.lists[newListIndex].dotlists.append(word)
        }
    }
}

#Preview {
    EditView(
        word: .constant(Word())
    )
    .environmentObject(WordData())
}
