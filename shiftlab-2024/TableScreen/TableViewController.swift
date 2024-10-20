//
//  TableViewController.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 14.10.2024.
//

import UIKit

class TableViewController: UIViewController {
    
    private let contentView = TableView()
    
    private var dataSource: UITableViewDiffableDataSource<Int, Product>?
    private var viewModel = TableViewModel()
    
    
    private let greetingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Приветствие", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(TableViewController.self, action: #selector(showGreeting), for: .touchUpInside)
        
        return button
    }()
    
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
        fetchData()
        setupNavigationBar()
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: contentView.tableView) { (tableView, indexPath, product) -> UITableViewCell? in
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! TableViewCell
        cell.configure(with: product)
        return cell
        }
    }
    
    
    private func fetchData() {
        Task {
            do {
                let products = try await viewModel.fetchData()
                var snapshot = NSDiffableDataSourceSnapshot<Int, Product>()
                snapshot.appendSections([0])
                snapshot.appendItems(products, toSection: 0)
                
                DispatchQueue.main.async {
                    self.dataSource?.apply(snapshot, animatingDifferences: true)
                }
            }
            catch {
                print("Failed to fetch data: \(error)")
            }
        }
    }
    
    private func setupNavigationBar() {
        let greetingButton = UIBarButtonItem(title: "Приветствие", style: .plain, target: self, action: #selector(showGreeting))
        navigationItem.leftBarButtonItem = greetingButton
        
        //MARK: - кнопка для удаления пользователя из CoreData
//        let logoutButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: #selector(logout))
//        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc private func showGreeting() {
        if let userName = CoreDataManager.shared.obtainSavedData() {
            let alert = UIAlertController(title: "Приветствие", message: "Здравствуйте, \(userName)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    //MARK: - метод для удаления пользователя из CoreData
//    @objc private func logout() {
//        CoreDataManager.shared.deleteUser()
//    }
}


