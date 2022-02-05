//
//  SignInUpViewController.swift
//  KDTechTest
//
//  Created by Sekhar Simhadri on 05/02/22.
//

import UIKit

class SignInUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var btnRegSignIn: UIButton!
    
    // MARK: - Constants and Variables
    var forSignUp = false
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleString = forSignUp ? "Register" : "Login"
        btnRegSignIn.setTitle(titleString, for: .normal)
        self.title = titleString
    }

    // MARK: - IBActions
    @IBAction func actionSignInUp(_ sender: UIButton) {
        if !(txtFldEmail.text ?? "").isValidEmail() {
            showAlert(message: "Please enter valid email")
            return
        } else if (txtFldPassword.text ?? "").isEmpty {
            showAlert(message: "Please enter password")
            return
        }
        let parameters = ["email": txtFldEmail.text ?? "", "password": txtFldPassword.text ?? ""]
        let url = "https://hoodwink.medkomtek.net/api/\(forSignUp ? "register" : "/auth/login")"
        NetworkManager.shared.postAPI(forSignInUp: true, urlString: url, param: parameters) { response in
            if let userData = response["data"] as? [String: Any] {
               let userID = userData["id"] as? String  ?? String(userData["id"] as? Int ?? 001)
                NetworkManager.shared.userID = userID
            }
            self.moveToCartVC()
        }
    }
    
    func moveToCartVC() {
        guard let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else { return }
        pushVC(cartVC)
    }
}

extension SignInUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == txtFldEmail {
            txtFldPassword.becomeFirstResponder()
        } else {
            actionSignInUp(btnRegSignIn)
        }
        return true
    }
}
