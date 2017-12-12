//
//  TDUserRepository.swift
//  TestData
//
//  Created by Krzysztof Biskupski on 11.12.2017.
//  Copyright © 2017 pl.naosoft. All rights reserved.
//
import UIKit
import Alamofire
import CodableAlamofire

class TDUserRepository {
    func fetchUsersList(completion: @escaping ([TDUser]) -> Void) {
        let decoder =  JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        Alamofire.request(
            URL(string: "https://randomuser.me/api/?results=100&inc=gender,name,nat,email,picture")!,
            method: .get)
            .responseDecodableObject(keyPath: "results", decoder: decoder) { (response:DataResponse<[TDUser]>) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote users: \(String(describing: response.result.error))")
                    completion([TDUser]())
                    return
                }
                let repo = response.result.value
                completion(repo!)
                
        }
    }
}
