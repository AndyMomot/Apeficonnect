//
//  GradientLoaderView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 16.11.2024.
//

import SwiftUI

struct GradientLoaderView: View {
    
    var onDidLoad: () -> Void
    
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 16) {
                // Loading Text
                Text("Loading...")
                    .font(Fonts.SFProDisplay.semiboldItalic.swiftUIFont(size: 16))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue,
                                Color.purple,
                                Color.pink,
                                Color.orange
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                ProgressProgressBar(width: min(progress * geo.size.width,
                                               geo.size.width))
                .animation(.linear(duration: 1.0), value: progress)
                .frame(height: 20)
                .onAppear {
                    startTimer()
                }
            }
        }
    }
}

private extension GradientLoaderView {
    func startTimer() {
        stopTimer()
        timer = .scheduledTimer(
            withTimeInterval: 0.02,
            repeats: true) { _ in
                updateProgress()
            }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress() {
        DispatchQueue.main.async {
            let newValue = progress + 0.01
            
            if newValue >= 1 {
                withAnimation {
                    progress = 1
                }
                self.onDidLoad()
            } else {
                withAnimation {
                    progress = newValue
                }
            }
        }
    }
}

#Preview {
    GradientLoaderView {}
        .padding()
}
