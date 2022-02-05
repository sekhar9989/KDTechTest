//
//  CartViewController.swift
//  KDTechTest
//
//  Created by Sekhar Simhadri on 05/02/22.
//

import UIKit

class CartViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tblVwList: UITableView!
    
    // MARK: - Constants and variables
    var arrItems = [Item]()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllItems()
    }

    // MARK: - IBActions
    @IBAction func actionLogOut(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func actionAddItem(_ sender: UIBarButtonItem) {
        guard let addItemVC = self.storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as? AddProductViewController else { return }
        self.navigationController?.pushViewController(addItemVC, animated: true)
    }
    
    // MARK: - Custom methods
    func getAllItems() {
        NetworkManager.shared.postAPI(urlString: "https://hoodwink.medkomtek.net/api/item/search", param: ["sku": "OBT-\(NetworkManager.shared.userID)"]) { response in
            if let isSuccess = response["success"] as? Bool,
               isSuccess {
                do {
                    let data = try JSONSerialization.data(withJSONObject: response, options: .fragmentsAllowed)
                    let item = try JSONDecoder().decode(Item.self, from: data)
                    self.arrItems.append(item)
                } catch {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.tblVwList.reloadData()
                }
            }
        }
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !arrItems.isEmpty {
            tableView.backgroundView = nil
        } else if let noRecords = UINib(nibName: "NoRecords", bundle: .main).instantiate(withOwner: nil, options: nil).first as? NoRecords {
            noRecords.lbl.text = "No items added yet"
            noRecords.imgVw.image = #imageLiteral(resourceName: "2038854")
            noRecords.frame = tableView.bounds
            tableView.backgroundView = noRecords
        }
        return arrItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as? CartItemTableViewCell else {
            return UITableViewCell()
        }
        let model = arrItems[indexPath.row]
        cell.lblName.text = model.productName
        cell.lblPrice.text = "\(model.price)"
        cell.lblQuantity.text = model.qty
        return cell
    }
    
    
}
