//
//  UserDetailViewController.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//
import UIKit

// This screen displays the details of a user.
class UserDetailViewController: UIViewController {
    
    private let viewModel: UserDetailViewModel
    
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let websiteLabel = UILabel()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    // This is the initializer for the UserDetailViewController.
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           title = NSLocalizedString("user_detail", comment: "User detail screen title")
        
   
        let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                    .foregroundColor: UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0)
                ]
                navigationController?.navigationBar.titleTextAttributes = attributes
                
        
        setupUI()
        fetchUserDetails()
    }
    
    // This func setups the UI elements programmatically.
    private func setupUI() {
      
        view.backgroundColor = UIColor.systemGray6
    
        
        
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        
       
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
       
        emailLabel.font = UIFont.systemFont(ofSize: 18)
        emailLabel.textColor = .darkGray
        emailLabel.numberOfLines = 0
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        
      
        phoneLabel.font = UIFont.systemFont(ofSize: 18)
        phoneLabel.textColor = .darkGray
        phoneLabel.numberOfLines = 0
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneLabel)
        
       
        websiteLabel.font = UIFont.systemFont(ofSize: 18)
        websiteLabel.textColor = .darkGray
        websiteLabel.numberOfLines = 0
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(websiteLabel)
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            websiteLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 20),
            websiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            websiteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            websiteLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    // This function fetches user details from the API and sets the labels.
    private func fetchUserDetails() {
        loadingIndicator.startAnimating()

        let nameText = NSLocalizedString("name", comment: "Name label text")
        let emailText = NSLocalizedString("email", comment: "Email label text")
        let phoneText = NSLocalizedString("phone", comment: "Phone label text")
        let websiteText = NSLocalizedString("website", comment: "Website label text")
        
        let nameError = NSLocalizedString("no_name_provided", comment: "Name label text")
        let emailError = NSLocalizedString("no_email_provided", comment: "Email label text")
        let phoneError = NSLocalizedString("no_phone_provided", comment: "Phone label text")
        let websiteError = NSLocalizedString("no_website_provided", comment: "Website label text")
        
        viewModel.fetchUserDetails { [weak self] result in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                switch result {
                case .success(let user):
                    
                    self?.nameLabel.text = "\(nameText): \(user.name ?? nameError)"
                    self?.emailLabel.text = "\(emailText): \(user.email ?? emailError)"
                    self?.phoneLabel.text = "\(phoneText): \(user.phone ?? phoneError)"
                    self?.websiteLabel.text = "\(websiteText): \(user.website ?? websiteError)"
                case .failure(let error):
                    self?.showError(error)
                }
            }
        }
    }


    // This function shows an alert with the given error message.
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
