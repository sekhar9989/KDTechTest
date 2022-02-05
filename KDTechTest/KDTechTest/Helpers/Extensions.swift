//
//  Extensions.swift
//  KDTechTest
//
//  Created by Sekhar Simhadri on 05/02/22.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func pushVC(_ controller: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

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
    request.setValue( "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJiZWFyZXIiLCJzdwIiOjIsImlhdCI6MTYwNTc2NzEyOCwiZXhwIjoxNj A1NzcwNzI4fQ.wytEMAeAzUUEzDGHx5opFwaf97r2slzzBTdvHqp6", forHTTPHeaderField: "Authorization")
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
