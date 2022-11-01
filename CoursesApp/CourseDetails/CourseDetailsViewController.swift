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
    
    var viewModel: CourseDetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func toggleFavorite() {
        viewModel.favoriteButtonPressed()
    }
    
    private func setupUI() {
        setStatusForFavoriteButton(viewModel.isFavorite.value)
        
        viewModel.isFavorite.bind { [unowned self] value in
            setStatusForFavoriteButton(value)
        }
        
        viewModel.viewModelDidChange = { [unowned self] viewModel in
            courseImage.image = UIImage(data: viewModel.imageData ?? Data())
        }
        
        courseNameLabel.text = viewModel.courseName
        numberOfLessonsLabel.text = viewModel.numberOfLessons
        numberOfTestsLabel.text = viewModel.numberOfTests
        courseImage.image = UIImage(data: viewModel.imageData ?? Data() )
        
    }
    
    private func setStatusForFavoriteButton(_ status: Bool) {
        favoriteButton.tintColor = status ? .systemPink : .gray
    }
    
}
