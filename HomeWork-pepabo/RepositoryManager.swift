//
//  Controller.swift
//  HomeWork-pepabo
//
//  Created by pmac273s on 2017/02/08.
//  Copyright © 2017年 西村歩夢. All rights reserved.
//

import Alamofire
import SwiftyJSON

class RepositoryManager {
    var page = 1
    var item: [Repository] = []
    var url = "https://api.github.com/search/repositories?q=swift+language:swift&sort=stars&order=desc&page="
    let baseUrl = URL(string: "https://api.github.com/search/repositories")!
    var parameters = ["q": "swift",
                      "language": "swift",
                      "sort": "stars",
                      "order": "desc",
                      "page": "1"]
    
    var repositoryCount: Int {
        return item.count
    }
}

extension RepositoryManager {
    
    // ダウンロード
    func download(callback: @escaping (Bool) -> Void) {
        Alamofire.request(baseUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            // nilチェック
            guard let object = response.result.value else {
                callback(false)
                return
            }
            
            // ページ送り
            self.page += 1
            self.parameters["page"] = "\(self.page)"
            
            // jsonに変換
            let json = JSON(object)
            print(json)
            
            // 取り出し
            json["items"].forEach({ (item) in
                self.item.append(Repository(json: item.1))
            })
            
            callback(true)
        }
    }
    
    func shouldDownload(indexPath: IndexPath) -> Bool {
        // 最後のセル
        return indexPath.row == repositoryCount - 1
    }
}
