//
//  ModeSetting.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/20.
//

import SwiftUI

struct ModeSetting: View {
    @State private var showingModeSheet: Bool = false
    var body: some View {
        HStack {
            Button {
                showingModeSheet.toggle()
            } label: {
                 Image(systemName: "wand.and.stars")
                    .foregroundColor(Color.gray)
                    .font(.title)
                    .padding()
            } // Buttonここまで
            .sheet(isPresented: $showingModeSheet) {
                VStack {
                    Text("aaa")
                }
                .presentationDetents([.medium]) // ⬅︎
            } // sheetここまで
            Spacer()
        } // HStackここまで
    }
}

#Preview {
    ModeSetting()
}
