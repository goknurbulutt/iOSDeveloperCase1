//
//  UserListViewController.swift
//  iOSDeveloperCase
//
//  Created by Göknur Bulut on 4.03.2025.
//

import UIKit

// ViewController to display the list of users.
class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel = UserListViewModel()
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.fetchUsers()
        
        // Binding ViewModel to the view
        viewModel.didUpdateUsers = { [weak self] in
            self?.activityIndicator.stopAnimating() 
            self?.tableView.reloadData()
        }
        
        viewModel.didFailWithError = { [weak self] error in
            self?.activityIndicator.stopAnimating() // Stop loading indicator in case of error
            print("Error: \(error.localizedDescription)")
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = viewModel.users[indexPath.row]
        
        cell.textLabel?.text = "\(user.name) - \(user.email)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = viewModel.users[indexPath.row]
        let detailViewModel = UserDetailViewModel(user: selectedUser)
        let detailVC = UserDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
