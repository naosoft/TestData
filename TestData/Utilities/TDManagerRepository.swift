//
//  TDManagerRepository.swift
//  TestData
//
//  Created by Krzysztof Biskupski on 11.12.2017.
//  Copyright © 2017 pl.naosoft. All rights reserved.
//

import UIKit
class TDManagerRepository : NSObject {
    static let instante = TDManagerRepository()
    var userRepository: TDUserRepository
    override init() {
        self.userRepository = TDUserRepository()
    }
}
