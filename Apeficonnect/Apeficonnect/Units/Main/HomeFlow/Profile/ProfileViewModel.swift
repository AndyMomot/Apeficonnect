//
//  ProfileViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import Foundation
import UIKit.UIImage

extension ProfileView {
    final class ViewModel: ObservableObject {
        @Published var canEdit = false
        @Published var image = Asset.profilePlaceholder.image
        @Published var nickName = "User"
        @Published var showImagePicker = false
        @Published var showLoader = false
        @Published var showClearCacheAlert = false
        
        var appUrl = "https://apps.apple.com/app/id6738513209"
        //6738513209
        private var saveNicknameWorkItem: DispatchWorkItem?
        
        func getUser() {
            DispatchQueue.global().async { [weak self] in
                guard let self, let user = DefaultsService.shared.user else { return }
                self.getImage(withId: user.id)
                DispatchQueue.main.async { [self] in
                    self.nickName = user.nickName
                }
            }
        }
        
        private func getImage(withId id: String) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                ImageStorageManager().fetchImage(with: id) { data in
                    guard let data, let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async { [self] in
                        self.image = image
                    }
                }
            }
        }
        
        func saveNickname() {
            saveNicknameWorkItem?.cancel()
            saveNicknameWorkItem = nil
            
            saveNicknameWorkItem = DispatchWorkItem { [weak self] in
                guard let self else { return }
                DefaultsService.shared.user?.nickName = self.nickName
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: saveNicknameWorkItem!)
        }
        
        func saveUserImage() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                guard self.image != Asset.profilePlaceholder.image,
                      let userId =  DefaultsService.shared.user?.id,
                      let data = self.image.jpegData(compressionQuality: 1) else { return }
                ImageStorageManager().saveImage(data: data, for: userId)
            }
        }
        
        func clearCache(completion: @escaping () -> Void) {
            DispatchQueue.global().async {
                DefaultsService.shared.removeAll()
                FileManagerService().removeAllFiles()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    completion()
                }
            }
        }
    }
}
