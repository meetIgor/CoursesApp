//
//  CourseDetailsViewController.swift
//  CoursesApp
//
//  Created by igor s on 23.10.2022.
//

import UIKit

class CourseDetailsViewController: UIViewController {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var numberOfLessonsLabel: UILabel!
    @IBOutlet weak var numberOfTestsLabel: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var course: Course!
    
    private var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavoriteStatus()
        setupUI()
        
    }
    
    @IBAction func toggleFavorite() {
        isFavorite.toggle()
        setStatusForFavoriteButton()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite)
    }
    
    private func setupUI() {
        courseNameLabel.text = course.name
        numberOfLessonsLabel.text = "Number of lessons: \(course.numberOfLessons)"
        numberOfTestsLabel.text = "Number of test: \(course.numberOfTests)"
        setStatusForFavoriteButton()
        
        NetworkManager.shared.fetchImgae(from: course.imageUrl) { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.courseImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setStatusForFavoriteButton() {
        favoriteButton.tintColor = isFavorite ? .systemPink : .gray
    }
    
    private func loadFavoriteStatus() {
        isFavorite = DataManager.shared.getFavoriteStatus(for: course.name)
    }
}
