//
//  DataProvider.swift
//  CoordinatesViewer
//
//  Created by Valery Kokanov on 24.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

typealias DataProviderCompletionHandler = (Data?) -> Void

class DataProvider {
    
    func loadData(handler: DataProviderCompletionHandler) {
        let pathToFile = Bundle.main.path(forResource: "track", ofType: "json")
        if let fileContent = try? String(contentsOfFile: pathToFile!) {
            let data = fileContent.data(using: .utf8)
            handler(data)
        } else {
            handler(nil)
        }
    }
    
}
