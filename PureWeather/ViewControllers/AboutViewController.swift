//
//  MainViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 10.07.2024.
//

import UIKit
import MessageUI



class AboutViewController: UIViewController {
    
    // MARK: - Private
    private lazy var philippImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.image = UIImage(named: "PhilippImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var aboutTextView: UITextView = {
        let textView = UITextView()
        let text = String(localized: "I am an aspiring iOS Developer. ")
        textView.text = text
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var linkedinButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "linkedinIcon")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(linkedinButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var githubButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "githubIcon")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(githubButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mailButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "mailIcon")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(mailButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var copiedLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .secondarySystemFill
        label.textAlignment = .center
        label.layer.cornerRadius = 15.0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var projectrepoButton: UIButton = {
        let button = UIButton()
        let text = String(localized: "PureWeather on GitHub")
        let attributedString = NSAttributedString(string: text, attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(projectrepoButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var copiedLabelBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    
    
    // MARK: - Actions
    @objc func linkedinButtonTapped(_ button: UIButton) {
        let string = "https://www.linkedin.com/in/philipp-lazarev-782b14167/"
        guard let url = URL(string: string) else {
            showCopiedLabel(subject: .link, text: string)
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            showCopiedLabel(subject: .link, text: string)
        }
    }
    
    @objc func githubButtonTapped(_ button: UIButton) {
        let string = "https://github.com/lord-anonymoose"
        guard let url = URL(string: string) else {
            showCopiedLabel(subject: .link, text: string)
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            showCopiedLabel(subject: .link, text: string)
        }
    }
    
    @objc func mailButtonTapped(_ button: UIButton) {
        sendEmail()
    }
    
    @objc func projectrepoButtonTapped(_ button: UIButton) {
        let string = "https://github.com/lord-anonymoose/PureWeather"
        guard let url = URL(string: string) else {
            showCopiedLabel(subject: .link, text: string)
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            showCopiedLabel(subject: .link, text: string)
        }
    }
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.navigationController?.isNavigationBarHidden = false
        let title = String(localized: "About developer")
        self.navigationItem.title = title
    }
    
    private func addSubviews() {
        view.addSubview(philippImageView)
        view.addSubview(linkedinButton)
        view.addSubview(githubButton)
        view.addSubview(mailButton)
        view.addSubview(copiedLabel)
        view.addSubview(projectrepoButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            philippImageView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            philippImageView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            philippImageView.heightAnchor.constraint(equalToConstant: 150),
            philippImageView.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        NSLayoutConstraint.activate([
            linkedinButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -125),
            linkedinButton.heightAnchor.constraint(equalToConstant: 50),
            linkedinButton.widthAnchor.constraint(equalToConstant: 50),
            linkedinButton.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            githubButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -125),
            githubButton.heightAnchor.constraint(equalToConstant: 50),
            githubButton.widthAnchor.constraint(equalToConstant: 50),
            githubButton.trailingAnchor.constraint(equalTo: linkedinButton.leadingAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            mailButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -125),
            mailButton.heightAnchor.constraint(equalToConstant: 50),
            mailButton.widthAnchor.constraint(equalToConstant: 50),
            mailButton.leadingAnchor.constraint(equalTo: linkedinButton.trailingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            projectrepoButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -75),
            projectrepoButton.heightAnchor.constraint(equalToConstant: 50),
            projectrepoButton.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            projectrepoButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        
        copiedLabelBottomConstraint = copiedLabel.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: 100)
        
        copiedLabelBottomConstraint.isActive = true
        NSLayoutConstraint.activate([
            copiedLabel.heightAnchor.constraint(equalToConstant: 50),
            copiedLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            copiedLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    enum Subject: String {
        case email
        case link
        
        var localized: String {
            switch self {
            case .email:
                return String(localized: "email copied")
            case .link:
                return String(localized: "link copied")
            }
        }
    }
    
    func showCopiedLabel(subject: Subject, text: String = "") {
        copiedLabel.isHidden = false
        copiedLabelBottomConstraint.constant = -5
        copiedLabel.text = subject.localized
        UIPasteboard.general.string = text
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
            self.copiedLabel.layer.cornerRadius = 10.0
        }) { _ in
            UIView.animate(withDuration: 1, delay: 2, animations: {
                self.copiedLabel.alpha = 0
            }, completion: { _ in
                self.copiedLabel.isHidden = true
                self.copiedLabel.alpha = 1
                self.copiedLabelBottomConstraint.constant = 70
                self.view.layoutIfNeeded()
            })
        }
    }
}



extension AboutViewController: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["philipp.lazareff@gmail.com"])
            mail.setSubject("PureWeather")
            present(mail, animated: true)
        } else {
            let title = String(localized: "Error!")
            let description = String(localized: "Your device is not configured to send emails. Try to send it manually.")
            self.showAlert(title: title, description: description) { action in
                self.showCopiedLabel(subject: .email, text: "philipp.lazareff@gmail.com")
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

