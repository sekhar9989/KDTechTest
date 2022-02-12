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
    var objItem: Item?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        getAllItems()
    }

    // MARK: - IBActions
    @IBAction func actionLogOut(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "userID")
        UserDefaults.standard.removeObject(forKey: "token")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func actionAddItem(_ sender: UIBarButtonItem) {
        guard let addItemVC = self.storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as? AddProductViewController else { return }
        self.navigationController?.pushViewController(addItemVC, animated: true)
    }
    
    @IBAction func actionEdit(_ sender: UIButton) {
        guard let addItemVC = self.storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as? AddProductViewController else { return }
        addItemVC.objItem = objItem
        self.navigationController?.pushViewController(addItemVC, animated: true)
    }
    
    @IBAction func actionDelete(_ sender: UIButton) {
        getAllItems(toDelete: true)
    }
    
    // MARK: - Custom methods
    func getAllItems(toDelete: Bool = false) {
        NetworkManager.shared.postAPI(urlString: "https://hoodwink.medkomtek.net/api/item/\(toDelete ? "delete" : "search")", param: ["sku": "OBT-\(NetworkManager.shared.userID)"]) { response in
            do {
                let data = try JSONSerialization.data(withJSONObject: response, options: .fragmentsAllowed)
                self.objItem = try JSONDecoder().decode(Item.self, from: data)
            } catch {
                print(error.localizedDescription)
                self.objItem = nil
            }
            if toDelete {
                self.getAllItems()
            } else {
                DispatchQueue.main.async {
                    self.tblVwList.reloadData()
                }
            }
        }
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if objItem != nil {
            tableView.backgroundView = nil
            return 1
        } else if let noRecords = UINib(nibName: "NoRecords", bundle: .main).instantiate(withOwner: nil, options: nil).first as? NoRecords {
            noRecords.lbl.text = "No items added yet"
            noRecords.imgVw.image = #imageLiteral(resourceName: "2038854")
            noRecords.frame = tableView.bounds
            tableView.backgroundView = noRecords
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as? CartItemTableViewCell else {
            return UITableViewCell()
        }
        cell.lblName.text = objItem?.productName
        cell.lblPrice.text = "\(objItem?.price ?? 0)"
        cell.lblQuantity.text = "\(objItem?.qty ?? 0)"
        return cell
    }
    
    
}
