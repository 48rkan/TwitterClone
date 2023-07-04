//  ImageUploader.swift
//  TwitterClone
//  Created by Erkan Emir on 22.06.23.

import Foundation
import FirebaseStorage
import UIKit
import FirebaseAuth
import FirebaseFirestore

struct ImageUploader {
    static func uploadImage(image: UIImage,
                            completion: @escaping (String) -> ()) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName = NSUUID().uuidString
        
        //burada referans yaradiriq bir nov bos bir referans
        let ref = Storage.storage().reference(withPath: "/profile/images/\(fileName)")
        
        // burada ise hemin bos referansa data qoyuruq
        ref.putData(imageData) {  metaData, error in
            if error != nil {
                print("Error : \(error?.localizedDescription ?? "" )")
                return
            }

            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString  else { return  }
                completion(imageUrl)
            }
        }
    }
}
