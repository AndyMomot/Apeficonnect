//
//  LiniarGradiaentView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct LiniarGradientView: View {
    var colors: [Color] = [
        Color.blue,
        Color.purple,
        Color.pink,
        Color.orange
    ]
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .leading,
            endPoint: .trailing)
    }
}

#Preview {
    LiniarGradientView()
}
