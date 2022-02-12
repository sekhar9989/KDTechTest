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
    @IBOutlet weak var txtFldPrice: UITextField!
    @IBOutlet weak var btnAddEdit: UIButton!
    
    // MARK: - Constants and Variables
    var objItem: Item?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard objItem != nil else { return }
        txtFldQuantity.text = "\(objItem!.qty)"
        txtFldProductName.text = objItem?.productName
        txtFldPrice.text = "\(objItem!.price)"
        btnAddEdit.setTitle("Update", for: .normal)
        self.title = "Edit"
    }

    // MARK: - IBActions
    @IBAction func actionAddToCart(_ sender: UIButton) {
        let param = ["sku": "OBT-\(NetworkManager.shared.userID)",
                     "qty": txtFldQuantity.text ?? "1",
                     "product_name": txtFldProductName.text ?? "Sehat01",
                     "price": txtFldPrice.text ?? "100000",
                     "unit": "carton",
                     "status": "1"]
        let url = "https://hoodwink.medkomtek.net/api/item/\(objItem != nil ? "update" : "add")"
        NetworkManager.shared.postAPI(urlString: url, param: param) { response in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
