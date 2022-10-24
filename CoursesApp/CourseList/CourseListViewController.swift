//
//  ViewController.swift
//  CoursesApp
//
//  Created by igor s on 22.10.2022.
//

import UIKit

class CourseListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var activityIndicator: UIActivityIndicatorView?
    
    private var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.rowHeight = 100
        activityIndicator = showActivityIndicatro(in: view)
        getCourses()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? CourseDetailsViewController else { return }
        detailsVC.course = sender as? Course
    }
    
    private func getCourses() {
        NetworkManager.shared.fetchCourse(from: Link.coursesURL.rawValue) { [weak self] result in
            switch result {
            case .success(let courses):
                self?.courses = courses
                self?.tableView.reloadData()
                self?.activityIndicator?.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showActivityIndicatro(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
}

extension CourseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.configure(with: course)
        return cell
    }
}

extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let course = courses[indexPath.row]
        performSegue(withIdentifier: "CourseDetails", sender: course)
    }
}

