//
//  ProgressProgressBar.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct ProgressProgressBar: View {
    var width: CGFloat
    
    var body: some View {
        // Progress Bar
        ZStack(alignment: .leading) {
            // Background Bar
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 20)
            
            // Animated Gradient Bar
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.blue,
                            Color.purple,
                            Color.pink,
                            Color.orange]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: width,
                       height: 20)
        }
    }
}

#Preview {
    ProgressProgressBar(width: 200)
        .frame(height: 20)
}
