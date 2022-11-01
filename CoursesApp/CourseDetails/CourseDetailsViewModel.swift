//
//  CourseDetailsViewModel.swift
//  CoursesApp
//
//  Created by igor s on 24.10.2022.
//

import Foundation

//определяем публичный интерфейс для модели представления.
//в качестве интерфейса у нас выступает протокол
//название протокола начинается с названия сцены
protocol CourseDetailsViewModelProtocol {
    var courseName: String { get }
    var numberOfLessons: String { get }
    var numberOfTests: String { get }
    var imageData: Data? { get }
    var isFavorite: Box<Bool> { get }
    var viewModelDidChange: ((CourseDetailsViewModelProtocol) -> Void)? { get set }
    init(course: Course) // экз-р модели для отображения данных
    func favoriteButtonPressed()
}

// модель представления, про нее будет знать View, будет напрямую к ней обращаться
class CourseDetailsViewModel: CourseDetailsViewModelProtocol {
    
    var courseName: String {
        course.name
    }
    
    var numberOfLessons: String {
        "Number of lessons: \(course.numberOfLessons)"
    }
    
    var numberOfTests: String {
        "number of tests: \(course.numberOfTests)"
    }
    
    var imageData: Data?
    
    var viewModelDidChange: ((CourseDetailsViewModelProtocol) -> Void)?
    
    var isFavorite: Box<Bool>
    
    // view, обращаясь напрямую к модели представления, ничего не должна знать про модель,
    //поэтому прячем эту модель, делая ее приватной
    private let course: Course
    
    required init(course: Course) {
        self.course = course
        isFavorite = Box(DataManager.shared.getFavoriteStatus(for: course.name))
        
        NetworkManager.shared.fetchImage(from: course.imageUrl) { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.imageData = imageData
                viewModelDidChange?(self)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func favoriteButtonPressed() {
        isFavorite.value.toggle()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite.value)
    }
    
}
