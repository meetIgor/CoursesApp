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
    var isFavorite: Bool { get }
    var viewModelDidChanged: ((CourseDetailsViewModelProtocol) -> Void)? { get set }
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
    
    var imageData: Data? {
        NetworkManager.shared.fetchImageData(from: course.imageUrl)
    }
    
    var viewModelDidChanged: ((CourseDetailsViewModelProtocol) -> Void)?
    
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: course.name)
        } set {
            DataManager.shared.setFavoriteStatus(for: course.name, with: newValue)
            // возвращаем обновленное состояние модели представления
            // в нем и будет обновленное значение св-ва isFavourite
            viewModelDidChanged?(self)
        }
    }
    
    // view, обращаясь напрямую к модели представления, ничего не должна знать про модель,
    //поэтому прячем эту модель, делая ее приватной
    private let course: Course
    
    required init(course: Course) {
        self.course = course
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }
    
}
