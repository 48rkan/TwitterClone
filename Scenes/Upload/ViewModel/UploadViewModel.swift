//
//  UploadViewModel.swift
//  TwitterClone
//
//  Created by Erkan Emir on 23.06.23.

import Foundation

class UploadViewModel {
    var profilimage: String {
        AccountService.instance.currentUser?.profilimage ?? ""
    }
}
