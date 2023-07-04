//
//  Firebase+ext.swift
//  TwitterClone
//  Created by Erkan Emir on 26.06.23.

import UIKit
import FirebaseFirestore

extension Timestamp {
    func convertToRealTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits     = [.second,.minute,.hour,.day,.weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle       = .abbreviated
        let now = Date()
        
        return formatter.string(from: self.dateValue(), to: now) ?? "2h"
    }
}
