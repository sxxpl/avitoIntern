//
//  MainTableViewController.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//

import UIKit

class MainTableViewController: UIViewController {
    
    private let presenter:MainTableViewOutput
    
    private var mainTableView: MainTableView {
        return self.view as! MainTableView
    }
    
    var employers: [Character:[CompanyEmployer]]?
    {
        didSet {
            DispatchQueue.main.async {
                self.mainTableView.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = MainTableView()
    }
    
    init(presenter: MainTableViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        mainTableView.tableView.register(CompanyTableViewCell.self, forCellReuseIdentifier: CompanyTableViewCell.identifier)
        mainTableView.tableView.delegate = self
        mainTableView.tableView.dataSource = self
        mainTableView.tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        presenter.viewDidSearchEmployees()
    }
    
    @objc func refreshNews(){
        presenter.viewDidSearchEmployees()
        mainTableView.tableView.refreshControl?.endRefreshing()
    }
    
}

extension MainTableViewController: MainTableViewInput {
    
    func showError(error: String) {
        DispatchQueue.main.async {
            self.mainTableView.showErrorView(description: error)
        }
    }

    func showNoResults() {
        DispatchQueue.main.async {
            self.mainTableView.emptyResultLabel.isHidden = false
            self.mainTableView.tableView.reloadData()
        }
    }
    
    func hideNoResults() {
        DispatchQueue.main.async {
            self.mainTableView.emptyResultLabel.isHidden = true
        }
    }
}

extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sortedKeys = employers?.keys.sorted()
        return self.employers?[sortedKeys![section]]?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return employers?.keys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.identifier,for: indexPath) as! CompanyTableViewCell
        
        let firstChar = employers?.keys.sorted()[indexPath.section]
        
        guard let firstChar = firstChar else {return UITableViewCell()}
        
        cell.configure(name: self.employers?[firstChar]![indexPath.row].name ?? "", phone: self.employers?[firstChar]![indexPath.row].number ?? "", skills: self.employers?[firstChar]![indexPath.row].skills ?? [])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedKeys = employers?.keys.sorted()
        guard let sortedKeys = sortedKeys else {return nil}
        return String(sortedKeys[section])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { [weak self]_, _, complete in
            let sortedKeys = self?.employers?.keys.sorted()
            guard let key = sortedKeys?[indexPath.section] else {return}
            if let url = URL(string: "tel://" + (self?.employers?[key]?[indexPath.row].number ?? "")),
               UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            }
            complete(true)
        }
        
        action.image = UIImage(systemName: "phone.fill")
        action.backgroundColor = .systemGreen
        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        return swipeAction
    }
}
