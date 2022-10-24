//
//  CourseCell.swift
//  CoursesApp
//
//  Created by igor s on 23.10.2022.
//

import UIKit

class CourseCell: UITableViewCell {
    //private var activityIndicator: UIActivityIndicatorView?
    
    func configure(with course: Course) {
        var content = defaultContentConfiguration()
        content.text = course.name
        //activityIndicator = showActivityIndicatro(in: content.image)
        
        NetworkManager.shared.fetchImgae(from: course.imageUrl) { [unowned self] result in
            switch result {
            case .success(let imageData):
                content.image = UIImage(data: imageData)
                contentConfiguration = content
            case .failure(let error):
                print(error)
            }
        }
        
        contentConfiguration = content
    }
    
    private func showActivityIndicatro(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }

}
