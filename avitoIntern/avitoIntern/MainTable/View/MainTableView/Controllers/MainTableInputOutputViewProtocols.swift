//
//  MainTableInputOutputViewProtocols.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//
import Foundation

protocol MainTableViewInput {
    
    var employers: [Character:[CompanyEmployer]]? { get set }
    
    func showError(error: String)
    
    func showNoResults()
    
    func hideNoResults()
    
}

protocol MainTableViewOutput{
    
    func viewDidSearchEmployees()

}
