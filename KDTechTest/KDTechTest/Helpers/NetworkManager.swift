//
//  NetworkManager.swift
//  KDTechTest
//
//  Created by Sekhar Simhadri on 05/02/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    var userID = "001"
    
    private init() {}
    
    func postAPI(forSignInUp: Bool = false, urlString: String, param: [String: Any], completionHandler: @escaping(_ response: [String: Any]) -> Void) {
        let url = URL(string: urlString)
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: param, options: .fragmentsAllowed)
        } catch  {
            print(error.localizedDescription )
        }
        request.httpBody = jsonData
        if NetworkManager.shared.userID != "001" {
        request.setValue( "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJiZWFyZXIiLCJzdwIiOjIsImlhdCI6MTYwNTc2NzEyOCwiZXhwIjoxNj A1NzcwNzI4fQ.wytEMAeAzUUEzDGHx5opFwaf97r2slzzBTdvHqp6", forHTTPHeaderField: "Authorization")
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else {
                print("API failed")
                return
            }    
            guard let data = data else {return}
            do {
                let responseDict = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] ?? [:]
                print(responseDict)
                completionHandler(responseDict)
            } catch let jsonErr {
                print(jsonErr)
            }
        }
        task.resume()
    }
}
