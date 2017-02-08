//
//  Repository.swift
//  HomeWork-pepabo
//
//  Created by pmac273s on 2017/02/08.
//  Copyright © 2017年 西村歩夢. All rights reserved.
//

import SwiftyJSON

struct Repository {
    var name: String
    var star: Int
    var url: URL
    
    init(json: JSON) {
        self.name = json["name"].string!
        self.star = json["stargazers_count"].int!
        self.url = json["html_url"].url!
    }
}
