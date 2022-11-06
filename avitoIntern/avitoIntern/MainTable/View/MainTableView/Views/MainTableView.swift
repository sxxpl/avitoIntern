//
//  MainTableView.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//

import UIKit

class MainTableView: UIView {
    
    private var isNetworkErrorViewIsHidden = true

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
    
    var networkErrorView = NetworkErrorView()
    
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
            
            emptyResultLabel.topAnchor.constraint(equalTo: self.topAnchor),
            emptyResultLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            emptyResultLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            emptyResultLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
            ])
    }
    
    func showErrorView(description: String){
        
        if isNetworkErrorViewIsHidden {
            self.isNetworkErrorViewIsHidden = false
            networkErrorView = NetworkErrorView(frame: CGRect(x: self.frame.width * 0.05, y: self.frame.height, width: self.frame.width * 0.9, height: self.frame.height * 0.1))
            networkErrorView.networkErrorLabel.text = description
            self.addSubview(networkErrorView)
            
            
            UIView.animate(withDuration: 2, delay: 0) {
                self.networkErrorView.frame.origin.y -= self.frame.height * 0.1 + self.frame.width*0.05
            }
            
            UIView.animate(withDuration: 1, delay: 3) {
                if !self.isNetworkErrorViewIsHidden {
                    self.networkErrorView.frame.origin.y += self.frame.height * 0.1 + self.frame.width*0.05
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0){
                self.networkErrorView.removeFromSuperview()
                self.isNetworkErrorViewIsHidden = true
            }
        }
    }

}
