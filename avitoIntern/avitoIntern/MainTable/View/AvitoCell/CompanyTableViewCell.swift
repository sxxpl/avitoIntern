//
//  CompanyTableViewCell.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    static let identifier: String = "CompanyCell"

    var nameLabel:UILabel = {
        var label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var phoneLabel:UILabel = {
        var label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var skillsLabel:UILabel = {
        var label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(skillsLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor,constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20),
            
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 5),
            phoneLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20),
            phoneLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20),
            
            skillsLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor,constant: 5),
            skillsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20),
            skillsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20),
            skillsLabel.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor,constant: -5)
        ])
    }
    
    func configure(name:String,phone:String,skills:[String]){
        nameLabel.text = name
        phoneLabel.text = "Телефон: " + phone
        skillsLabel.text = "Умения: "
        for skill in skills {
            skillsLabel.text! += skill + ", "
        }
        skillsLabel.text!.removeLast(2)
    }
}
