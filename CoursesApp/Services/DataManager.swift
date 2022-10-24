//
//  DataManager.swift
//  CoursesApp
//
//  Created by igor s on 23.10.2022.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()

    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func setFavoriteStatus(for courseName: String, with status: Bool) {
        userDefaults.set(status, forKey: courseName)
    }
    
    func getFavoriteStatus(for courseName: String) -> Bool {
        userDefaults.bool(forKey: courseName)
    }
    
}
