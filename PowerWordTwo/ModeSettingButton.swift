//
//  ModeSetting.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/20.
//

import SwiftUI

struct ModeSettingButton: View {
    @EnvironmentObject var data: WordData
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
                NavigationStack {
                    ModeSettingView()
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button {
                                    showingModeSheet = false
                                    print(data.lists)
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                        .padding(.top, 6)
                                }
                            }
                        } // toolbarここまで
                        .onDisappear {
                            data.save()
                        }
                } // NavigationStackここまで
                .presentationDetents([.medium])
            } // sheetここまで
            Spacer()
        } // HStackここまで
    }
}

#Preview {
    ModeSettingButton()
        .environmentObject(WordData())
}
