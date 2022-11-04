//
//  NetworkErrorView.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//


import UIKit

class NetworkErrorView: UIView {
    
    var networkErrorLabel:UILabel = {
        var label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    
    private func configureUI() {
        self.backgroundColor = .red
        self.addSubview(networkErrorLabel)
        
        NSLayoutConstraint.activate([
            networkErrorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            networkErrorLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            networkErrorLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    
    
    override func layoutSubviews() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.width / 15
    }

}

