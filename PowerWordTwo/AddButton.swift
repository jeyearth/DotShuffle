//
//  AddButton.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/09.
//

import SwiftUI

struct AddButton: View {
    @EnvironmentObject var data: WordData
    @State private var showingSheet: Bool = false
    
    @State private var newWord = Word()
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.showingSheet.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
            .sheet(isPresented: $showingSheet) {
                NavigationStack {
                    AddView(newWord: $newWord)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button {
                                    showingSheet = false
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                        .padding(.top, 6)
                                }
                            }
                            ToolbarItem {
                                Button {
                                    data.add(newWord)
                                    showingSheet = false
                                    newWord = Word()
                                    data.save()
                                    print("add!")
                                } label: {
                                    Image(systemName: "plus.app")
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
    } // bodyここまで
}

#Preview {
    AddButton()
}
