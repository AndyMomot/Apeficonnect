//
//  RootContentViewModel.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import Foundation

extension RootContentView {
    final class RootContentViewModel: ObservableObject {
        @Published var showPreloader = true
        
        @Published var viewState: ViewState = .onboarding
        
        func getFlow() {
            DispatchQueue.main.async { [weak self] in
                self?.viewState = DefaultsService.shared.flow
            }
        }
        
        func setFlow(_ flow: ViewState) {
            DispatchQueue.main.async { [weak self] in
                DefaultsService.shared.flow = flow
                self?.getFlow()
            }
        }
    }
}

extension RootContentView {
    enum ViewState: String {
        case onboarding
        case main
    }
}
