//
//  AvitoService.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//

import Foundation

class AvitoService{
    
    let cacheService = CacheService()
    
    func loadCompany(completion: @escaping (Swift.Result<Company,Error>)->Void){
        
        let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        
        if let company = cacheService.getEmplFromCache(url: urlString) {
            completion(.success(company))
            return
        }
        
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let error = error {
                if error.localizedDescription == "The Internet connection appears to be offline." {
                    completion(.failure(Errors.internetError))
                } else {
                    completion(.failure(error))
                }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let company = try decoder.decode(Company.self, from: data)
                    self.cacheService.saveEmplToCache(url: urlString, company: company)
                    completion(.success(company))
                } catch {
                    completion(.failure(Errors.parsingError))
                    return
                }
            }
        }.resume()
        
    }
    
    
}
