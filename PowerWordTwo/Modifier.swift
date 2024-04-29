//
//  Modifier.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/03/21.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        
            .frame(width: 68, height: 68)
            .background(Color.blue)
            .cornerRadius(35.0)
            .shadow(radius: 7)
            .padding(20)
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(ButtonStyle())
    }
}
