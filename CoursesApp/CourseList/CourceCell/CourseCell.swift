//
//  CourseCell.swift
//  CoursesApp
//
//  Created by igor s on 23.10.2022.
//

import UIKit

class CourseCell: UITableViewCell {
    var viewModel: CourseCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.courseName
            guard let imageData = viewModel.imageData else { return }
            content.image = UIImage(data: imageData)
            contentConfiguration = content
        }
    }
}
