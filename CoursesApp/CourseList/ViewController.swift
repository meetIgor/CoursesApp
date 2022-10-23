//
//  ViewController.swift
//  CoursesApp
//
//  Created by igor s on 22.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func getCourses() {
        NetworkManager.shared.fetchCourse(from: Link.coursesURL.rawValue) { [unowned self] result in
            switch result {
            case .success(let courses):
                self.courses = courses
            case .failure(let error):
                print(error)
            }
        }
    }
}

