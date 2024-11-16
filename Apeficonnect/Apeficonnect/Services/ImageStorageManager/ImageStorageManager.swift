//
//  ImageStorageManager.swift
//  Metiflolux
//
//  Created by Andrii Momot on 18.10.2024.
//

import Foundation

struct ImageStorageManager {
    func saveImage(data: Data, for id: String) {
        DispatchQueue.main.async {
            let path = FileManagerService.Keys.image(id: id).path
            FileManagerService().saveFile(data: data, forPath: path)
        }
    }
    
    func fetchImage(with id: String, completion: @escaping (Data?) -> Void) {
        let path = FileManagerService.Keys.image(id: id).path
        DispatchQueue.global().async {
            let imageData = FileManagerService().getFile(forPath: path)
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}
