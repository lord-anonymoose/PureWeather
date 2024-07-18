//
//  MainViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 18.07.2024.
//

import Foundation
import UIKit
import MapKit



class MainViewController: UIPageViewController {

    var pages: [CityViewController] = []
    
    // MARK: - Subviews
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = pages.count
        control.currentPage = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        testFunctionality()

        self.dataSource = self
        self.delegate = self

        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
        setupUI()
        addSubviews()
        setupConsraints()
        setupNavigationBar()
    }
    
    // MARK: - Actions
    @objc func settingsButtonTapped(_ button: UIButton) {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @objc func addCityButtonTapped(_ button: UIButton) {
        let addCityViewController = AddCityViewController()
        self.navigationController?.pushViewController(addCityViewController, animated: true)
    }
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(pageControl)
    }
    
    private func setupConsraints() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let addCityImage = UIImage(systemName: "plus")
        let addCityButton = UIBarButtonItem(image: addCityImage, style: .plain, target: self, action: #selector(addCityButtonTapped))
        navigationItem.leftBarButtonItem = addCityButton
        
        let settingsImage = UIImage(systemName: "gear")
        let settingsButton = UIBarButtonItem(image: settingsImage, style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    private func testFunctionality() {
        let moscow = CLLocation(latitude: 55.7558, longitude: 37.6173)
        StorageService.shared().postLocation(location: moscow)
        //let moscowViewController = CityViewController(city: moscow)
        let sanFrancisco = CLLocation(latitude: 37.7749, longitude: -122.4194)
        StorageService.shared().postLocation(location: sanFrancisco)
        //let sanFranciscoViewController = CityViewController(city: sanFrancisco)
        //self.pages.append(moscowViewController)
        //self.pages.append(sanFranciscoViewController)
        let locations = StorageService.shared().fetchLocations()
        for location in locations {
            let locationViewController = CityViewController(city: location)
            self.pages.append(locationViewController)
        }
    }
}


extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let contentVC = viewController as? CityViewController,
              let currentIndex = pages.firstIndex(of: contentVC),
              currentIndex > 0 else {
            return nil
        }
        return pages[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let contentVC = viewController as? CityViewController,
              let currentIndex = pages.firstIndex(of: contentVC),
              currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let currentPage = pageViewController.viewControllers?.first, let currentIndex = pages.firstIndex(of: currentPage as! CityViewController) else { return }
        pageControl.currentPage = currentIndex
    }
}
