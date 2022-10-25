//
//  CourseCellViewModel.swift
//  CoursesApp
//
//  Created by igor s on 25.10.2022.
//

import Foundation

protocol CourseCellViewModelProtocol {
    var courseName: String { get }
    var imageData: Data? { get }
    init(course: Course)
}

class CourseCellViewModel: CourseCellViewModelProtocol {
    var courseName: String {
        course.name
    }
    
    var imageData: Data? {
        NetworkManager.shared.fetchImageData(from: course.imageUrl)
    }
    
    private var course: Course
    
    required init(course: Course) {
        self.course = course
    }
}
