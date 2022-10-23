//
//  Course.swift
//  CoursesApp
//
//  Created by igor s on 22.10.2022.
//

import Foundation

struct Course: Decodable {
    let name: String
    let imageUrl: String
    let numberOfLessons: Int
    let numberOfTests: Int
}
