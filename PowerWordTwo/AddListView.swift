//
//  AddListView.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/20.
//

import SwiftUI

struct AddListView: View {
    @Binding var newList: DotList
    @State private var inputText: String = ""
    
    var body: some View {
        VStack {
            List {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $inputText)
                        .frame(height: 200)
                        .onChange(of: inputText) {
                            newList.name = inputText
                        }
                        .disableAutocorrection(true)
                    
                    if newList.name.isEmpty {
                        Text("ここにリスト名を入力してください。")
                            .foregroundColor(Color(uiColor: .placeholderText))
                            .allowsHitTesting(false)
                            .padding(7)
                            .padding(.top, 2)
                    }
                }
            }
            //Spacer()
        } //VStackここまで
                .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    AddListView(
        newList: .constant(DotList())
    )
}
