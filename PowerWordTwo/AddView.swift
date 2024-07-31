//
//  AddView.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/08.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var data: WordData
    @Binding var newWord: Word
    @State private var inputText: String = ""
    
    var body: some View {
        
        VStack {
            List {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $inputText)
                        .frame(height: 200)
                        .onChange(of: inputText) {
                            // inputTextが変更されたときに、newWord.textも更新します
                            newWord.text = inputText
                        }
                        .disableAutocorrection(true)
                    
                    if newWord.text.isEmpty {
                        Text("ここに文字を入力してください。")
                            .foregroundColor(Color(uiColor: .placeholderText))
                            .allowsHitTesting(false)
                            .padding(7)
                            .padding(.top, 2)
                    }
                } // ZStackここまで
            } // Listここまで
        } //VStackここまで
        .edgesIgnoringSafeArea(.bottom)
    } //bodyここまで
}

#Preview {
    AddView(newWord: .constant(Word()))
}
