//
//  EditButton.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/15.
//

import SwiftUI

struct EditButton: View {
    @EnvironmentObject var data: WordData
    @Binding var selectedWord: Word
    @State private var showingSheet: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                self.showingSheet.toggle()
            }) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            } // Buttonここまで
            .sheet(isPresented: $showingSheet) {
                NavigationStack {
                    EditView(word: $selectedWord)
                        .toolbar {
                            ToolbarItem {
                                Button {
                                    showingSheet = false
                                    if let index = data.words.firstIndex(where: { $0.id == selectedWord.id }) {
                                        // data.wordsの要素を直接変更
                                        data.words[index].text = selectedWord.text
                                        data.save()
                                    } else {
                                        print("Item not found")
                                    }
                                    
                                } label: {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                        .padding(.top, 6)
                                }
                            }
                        }
                } // NavigationStackここまで
            }
            .buttonStyle()
        } // HStackここまで
    }
}

#Preview {
    EditButton(selectedWord: .constant(Word()))
        .environmentObject(WordData())
}
