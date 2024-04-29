//
//  EditView.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/09.
//

import SwiftUI

struct EditView: View {
    @Binding var word: Word
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
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
        }
    } // bodyここまで
}

#Preview {
    EditView(
        word: .constant(Word())
    )
}
