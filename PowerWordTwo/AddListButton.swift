//
//  AddListButton.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/20.
//

import SwiftUI

struct AddListButton: View {
    @EnvironmentObject var data: WordData

    @State var newList: DotList = DotList()
    @State private var showingAddListSheet = false

    var body: some View {
        Button {
            showingAddListSheet.toggle()
        } label: {
            Image(systemName: "plus")
        }
        .sheet(isPresented: $showingAddListSheet) {
            NavigationStack {
                AddListView(newList: $newList, showingAddListSheet: $showingAddListSheet)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                showingAddListSheet = false
                            } label: {
                                 Image(systemName: "xmark")
                                    .foregroundColor(Color.blue)
                                    .font(.title2)
                                    .padding(.top, 6)
                            }
                        }
                        ToolbarItem {
                            Button {
                                data.addList(newList)
                                showingAddListSheet = false
                                newList = DotList()
                                data.save()
                                print("List Added")
                            } label: {
                                Text("リストを作成")
                                    .foregroundColor(Color.blue)
                                    .font(.title3)
                                    .padding(.top, 6)
                            }
                        }
                    } // toolbar ここまで
            } // NavigationStackここまで
        }
    }
}

#Preview {
    AddListButton()
}
