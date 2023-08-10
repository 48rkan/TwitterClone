//
//  TableCellViewModel.swift
//  TwitterClone
//  Created by Erkan Emir on 03.07.23.

import Foundation

class TableCellViewModel {
    var datas: (description:String,image:String)
    
    init(datas: (String, String)) {
        self.datas = datas
    }
}
