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

    var pages: [UIViewController] = []
    
    // MARK: - Subviews
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = pages.count
        control.currentPage = 0
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = .accentColor

        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var nothingToShowLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .secondaryTitleFont
        let text = String(localized: "Cities are yet to be added")
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        setupUI()
        addSubviews()
        setupConsraints()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePages()
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
        view.addSubview(nothingToShowLabel)
    }
    
    private func setupConsraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nothingToShowLabel.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            nothingToShowLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            nothingToShowLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25),
            nothingToShowLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor)
        ])
    }
    
    private func updatePages() {
        self.pages = []

        let locations = StorageService.shared().fetchLocations()
        for location in locations {
            let locationViewController = CityViewController(city: location)
            self.pages.append(locationViewController)
        }

        self.dataSource = self
            
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = 0
        
        if self.pages.count == 0 {
            self.nothingToShowLabel.isHidden = false
        } else {
            self.nothingToShowLabel.isHidden = true
        }
            
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
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
        guard completed,
              let currentPage = pageViewController.viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentPage) else { return }
        pageControl.currentPage = currentIndex
    }
}
