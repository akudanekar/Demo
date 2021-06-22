//
//  Utility.swift
//  DemoApp
//
//  Created by Abhas on 22/06/21.
//  Copyright © 2021 Abhas. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Utility {
    
    private init() {}
    
    static let sharedInstance = Utility()
    
    func getDataFromFile(resource: String, fileType: String, completion: (_ data: [JSON]?) -> ()) {
        
        if let path = Bundle.main.path(forResource: resource, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                completion(jsonObj.arrayValue)              // Parsing JSON file in an array
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                completion(nil)
            }
        } else {
            print("Invalid filename/path.")
            completion(nil)
        }
    }
}
