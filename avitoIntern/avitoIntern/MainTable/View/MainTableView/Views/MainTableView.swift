//
//  MainTableView.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//

import UIKit

class MainTableView: UIView {

    var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var emptyResultLabel:UILabel = {
        var label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "Ничего не найдено"
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        self.setupTableView()
        self.addSubview(emptyResultLabel)
        self.setupConstraints()
        self.setupRefreshControl()
    }
    
    func setupTableView(){
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        self.addSubview(tableView)
    }
    
    func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .gray
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            emptyResultLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            emptyResultLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            emptyResultLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            emptyResultLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
            ])
    }

}
