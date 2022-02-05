//
//  AddProductViewController.swift
//  KDTechTest
//
//  Created by Sekhar Simhadri on 05/02/22.
//

import UIKit

class AddProductViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var txtFldProductName: UITextField!
    @IBOutlet weak var txtFldQuantity: UITextField!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - IBActions
    @IBAction func actionAddToCart(_ sender: UIButton) {
        let param = ["sku": "OBT-\(NetworkManager.shared.userID)",
                     "qty": "OBT-\(txtFldQuantity.text ?? "231")",
                     "product_name": "OBT-\(txtFldProductName.text ?? "Sehat01")",
                     "price": "1111",
                     "unit": "sekhar",
                     "status": "1"]
        let url = "https://hoodwink.medkomtek.net/api/item/add"
        NetworkManager.shared.postAPI(urlString: url, param: param) { response in
            print("Added: \(response)")
        }
    }
    
}
