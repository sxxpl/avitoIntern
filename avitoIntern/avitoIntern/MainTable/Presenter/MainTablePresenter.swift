//
//  MainTablePresenter.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//

import UIKit

class MainTablePresenter {
    
    let avitoService = AvitoService()
    
    var isCompaniesArePresented = false
        
    weak var viewInput: (UIViewController & MainTableViewInput)?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(downloadWhenTheInternetAppears(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
    }
    
    @objc func downloadWhenTheInternetAppears(notification: Notification) {
        if NetworkMonitor.shared.isConnected && !isCompaniesArePresented {
            loadEmployees()
        }
    }
    
    private func loadEmployees(){
        avitoService.loadCompany { result in
            switch result {
            case .success(let company):
                guard !company.company.employees.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.employers = self.sortEmployees(employes: company.company.employees)
                DispatchQueue.main.async {
                    self.viewInput?.title = company.company.name
                }
                break
                
            case .failure(let error):
                if error as? Errors == Errors.internetError {
                    self.viewInput?.showError(error: "Нет соединения с интернетом")
                } else {
                    self.viewInput?.showError(error: "Ошибка запроса")
                }
                self.viewInput?.employers = [:]
                DispatchQueue.main.async {
                    self.viewInput?.title = ""
                }
                self.viewInput?.showNoResults()
                break
            }
        }
    }
    
    private func sortEmployees(employes:[CompanyEmployer]) -> [Character:[CompanyEmployer]]{
        var empDict = [Character:[CompanyEmployer]]()
        for i in 0..<employes.count{
            let employer = employes[i]
            guard let firstChar = employer.name.first else {break}

            if var thisCharEmp = empDict[firstChar]
            {
                binaryInsert(num: employer, array: &thisCharEmp)
                empDict[firstChar] = thisCharEmp
            } else {
                empDict[firstChar] = [employer]
            }
        }
        return empDict
    }
    
    private func binaryInsert(num: CompanyEmployer, array: inout [CompanyEmployer]) {
           var left = 0
           var right = array.count - 1
           while left <= right {
               let middle = left + (right - left)/2
               if array[middle].name < num.name {
                   left = middle + 1
               } else {
                   right = middle - 1
               }
           }
           array.insert(num, at: left)
       }
}

extension MainTablePresenter:MainTableViewOutput {
    func viewDidSearchEmployees() {
        self.loadEmployees()
    }
}
