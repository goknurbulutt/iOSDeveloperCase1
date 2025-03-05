//
//  UserListViewController.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//

import UIKit

// UserListViewController is responsible for displaying a list of users fetched from the API.
class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel = UserListViewModel()
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("user", comment: "User  screen title")
        
        
        let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                    .foregroundColor: UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0) 
                ]
                navigationController?.navigationBar.titleTextAttributes = attributes
                
        
        setupUI()
        viewModel.fetchUsers()
        
        viewModel.didUpdateUsers = { [weak self] in
            self?.activityIndicator.stopAnimating() 
            self?.tableView.reloadData()
        }
        
        viewModel.didFailWithError = { [weak self] error in
            self?.activityIndicator.stopAnimating()
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // This func setups the UI elements programmatically.
    private func setupUI() {
        
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // ActivityIndicator setup
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    // Below are the required UITableViewDataSource and UITableViewDelegate methods.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = viewModel.users[indexPath.row]
        
        cell.textLabel?.text = "\(user.name ?? "No name provided") - \(user.email ?? "No email provided")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = viewModel.users[indexPath.row]
        let detailViewModel = UserDetailViewModel(user: selectedUser)
        let detailVC = UserDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true) 
    }

}
