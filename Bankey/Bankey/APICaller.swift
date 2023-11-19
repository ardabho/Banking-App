//
//  APICaller.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 19.11.2023.
//

import Alamofire

class APICaller {
    static let shared = APICaller()
    
    func fetchProfileData(id: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        let url = "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(id)"
        AF.request(url).response { response in
            
            switch response.result {
            case .success(let data):
                if let data {
                    do {
                        let profile = try JSONDecoder().decode(Profile.self, from: data)
                        completion(.success(profile))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "YourAppDomain", code: 999, userInfo: [NSLocalizedDescriptionKey: "Data is nil"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAccountsData(id: String, completion: @escaping (Result<[Account], Error>) -> Void) {
        let url = "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(id)/accounts"
        
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                if let data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        
                        let accounts = try decoder.decode([Account].self, from: data)
                        completion(.success(accounts))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "YourAppDomain", code: 999, userInfo: [NSLocalizedDescriptionKey: "Data is nil"])
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    
}
