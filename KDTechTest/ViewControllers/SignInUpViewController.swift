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
    var forSignUp = true
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleString = forSignUp ? "Register" : "Login"
        btnRegSignIn.setTitle(titleString, for: .normal)
        self.title = titleString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !forSignUp {
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        if UserDefaults.standard.value(forKey: "token") != nil {
            NetworkManager.shared.token = UserDefaults.standard.value(forKey: "token") as? String ?? ""
            NetworkManager.shared.userID = UserDefaults.standard.value(forKey: "userID") as? String ?? ""
            self.moveToCartVC()
        }
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
        let url = "https://hoodwink.medkomtek.net/api/\(forSignUp ? "register" : "auth/login")"
        NetworkManager.shared.postAPI(forSignInUp: true, urlString: url, param: parameters) { response in
            if self.forSignUp {
                if let userData = response["data"] as? [String: Any] {
                    let userID = userData["id"] as? String  ?? String(userData["id"] as? Int ?? 001)
                    NetworkManager.shared.userID = userID
                    UserDefaults.standard.set(userID, forKey: "userID")
                    DispatchQueue.main.async {
                        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInUpViewController") as? SignInUpViewController else { return }
                        signUpVC.forSignUp = false
                        self.navigationController?.pushViewController(signUpVC, animated: true)
                    }
                }
            } else if let token = response["token"] as? String {
                NetworkManager.shared.token = token
                UserDefaults.standard.set(token, forKey: "token")
                self.moveToCartVC()
            }
        }
    }
    
    func moveToCartVC() {
        DispatchQueue.main.async {
            guard let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else { return }
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
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
