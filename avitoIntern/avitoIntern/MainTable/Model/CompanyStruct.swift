//
//  CompanyStruct.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//


import Foundation
    
struct Company:Codable {
    var company:CompanyEmployees
}

struct CompanyEmployees:Codable{
    var name:String
    var employees:[CompanyEmployer]
}

struct CompanyEmployer:Codable{
    var name:String
    var number:String
    var skills:[String]
    
    enum CodingKeys:String,CodingKey{
        case name
        case number = "phone_number"
        case skills
    }
}
