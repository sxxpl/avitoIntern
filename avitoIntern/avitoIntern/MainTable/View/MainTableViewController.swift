//
//  MainTableViewController.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//

import UIKit

class MainTableViewController: UIViewController {
    
    private let presenter:MainTableViewOutput

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    init(presenter: MainTableViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableViewController: MainTableViewInput {
    
}
