//
//  CacheService.swift
//  avitoIntern
//
//  Created by Артем Тихонов on 04.11.2022.
//

import Foundation

class CacheService{

    private let cacheLifeTime:TimeInterval = 60 * 60

    private static let pathName:String = {
        let pathName = "companiesCache"

        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return pathName}
        let url = cacheDirectory.appendingPathComponent(pathName,isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        
        return pathName
    }()

    func getEmplFromCache(url:String) -> Company?{
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date else {return nil}
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime else {return nil}
            do {
                var data = NSData(contentsOfFile: fileName)
                var company = try JSONDecoder().decode(Company.self, from: data as? Data ?? Data())
                return company
            }
        catch {
            return nil
        }
        
    }

    private func getFilePath(url:String) -> String? {
        guard let  cacheDirectory  = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}

        let hashName = url.split(separator: "/").last ?? "default"
        return cacheDirectory.appendingPathComponent(CacheService.pathName + "/" + hashName).path
    }

    func saveEmplToCache(url: String, company: Company){
        guard let fileName = getFilePath(url: url) else {return}
        do {
            let data = try JSONEncoder().encode(company)
            FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
        } catch {
            return
        }
    }
    
}


