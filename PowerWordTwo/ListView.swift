//
//  ListView.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/08.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var data: WordData
    
    var body: some View {
        VStack {
            NavigationStack {
                ZStack(alignment: .bottom) {
                    ListBlockView()
                    
                    HStack {
                        AddButton()
                    }
                    .padding()
                } // ZStackここまで
            } //NavigationStackここまで
        }
    } // bodyここまで
    
}

#Preview {
    ListView()
        .environmentObject(WordData())
}
