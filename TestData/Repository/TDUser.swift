//
//  TDUser.swift
//  TestData
//
//  Created by Krzysztof Biskupski on 11.12.2017.
//  Copyright © 2017 pl.naosoft. All rights reserved.
//

import UIKit

struct  TDUser : Codable {
    var gender: String?
    var name : TDName?
    var picture: TDPicture?
    var nat: String?
    var email : String?
}

struct TDPicture : Codable {
    var large: String?
    var medium: String?
    var thumbnail: String?
}

struct TDName : Codable {
    var title: String?
    var first : String?
    var last: String?
}

