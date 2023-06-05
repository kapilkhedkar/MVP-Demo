//
//  UsersViewController.swift
//  MVP-Demo
//
//  Created by Kapil Khedkar on 05/06/23.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UserPresenterDelegate {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var users = [User]()
    
    private let presenter = UsersPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        
        // Table
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // Table Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Ask the presenter to handle the tap
        presenter.didTap(user: users[indexPath.row])
    }
    
    // Presenter Delegate
    func presentUsers(users: [User]) {
        self.users = users
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

