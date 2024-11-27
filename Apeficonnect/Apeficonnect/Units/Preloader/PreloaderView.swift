//
//  PreloaderView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI

struct PreloaderView: View {
    
    var onDidLoad: () -> Void
    
    @State private var timer: Timer?
    @State private var progress: Double = 0.0
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.preloaderBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Asset.preloaderLogo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 68)
                
                Spacer()
                
                CircularProgressBar(
                    progress: progress,
                    showProgress: true,
                    trackColor: .purpleCustom.opacity(0.1),
                    progressColor: .purpleCustom,
                    lineWidth: 10,
                    textColor: .purpleCustom,
                    font: Fonts.SFProDisplay.semibold.swiftUIFont(size: 16)
                )
                .padding(.horizontal, 150)
                Spacer()
            }
        }
        .onAppear {
            startTimer()
        }
    }
}

private extension PreloaderView {
    func startTimer() {
        stopTimer()
        
        timer = .scheduledTimer(withTimeInterval: 0.05,
                                repeats: true, block: { timer in
            let value = Double.random(in: 0.03...0.05)
            updateProgress(value: value)
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress(value: Double) {
        DispatchQueue.main.async {
            if progress + value > 1 {
                progress = 1
                stopTimer()
                onDidLoad()
                stopTimer()
            } else {
                progress = progress + value
            }
            
            
        }
    }
}

#Preview {
    PreloaderView {}
}
