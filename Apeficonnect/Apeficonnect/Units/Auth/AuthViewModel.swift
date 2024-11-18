//
//  AuthViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 17.11.2024.
//

import Foundation

extension AuthView {
    final class ViewModel: ObservableObject {
        @Published var nickName = ""
        
        func saveUser(completion: @escaping () -> Void) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let user = UserModel(nickName: self.nickName)
                DefaultsService.shared.user = user
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
