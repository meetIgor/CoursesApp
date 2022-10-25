//
//  CourseListViewModel.swift
//  CoursesApp
//
//  Created by igor s on 24.10.2022.
//

import Foundation

protocol CourseListViewModelProtocol {
    func fetchCourses(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func getCourseCellViewModel(at indexPath: IndexPath) -> CourseCellViewModelProtocol
    func getCourseDetailsViewModel(at indexPath: IndexPath) -> CourseDetailsViewModelProtocol
}

class CourseListViewModel: CourseListViewModelProtocol {
    
    private var courses: [Course] = []
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchCourse(from: Link.coursesURL.rawValue) { result in
            switch result {
            case .success(let courses):
                self.courses = courses
            case .failure(let error):
                print(error)
            }
            
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        courses.count
    }
    
    func getCourseCellViewModel(at indexPath: IndexPath) -> CourseCellViewModelProtocol {
        CourseCellViewModel(course: courses[indexPath.row])
    }
    
    func getCourseDetailsViewModel(at indexPath: IndexPath) -> CourseDetailsViewModelProtocol {
        CourseDetailsViewModel(course: courses[indexPath.row])
    }
    
}
