//
//  IntroductionViewController.swift
//  KDTechTest
//
//  Created by Sekhar Simhadri on 04/02/22.
//

import UIKit

class IntroductionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - IBActions
    @IBAction func actionSignIn(_ sender: UIButton) {
        moveToNext()
    }
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        moveToNext(forSignUp: true)
    }
    
    func moveToNext(forSignUp: Bool = false) {
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInUpViewController") as? SignInUpViewController else { return }
        signUpVC.forSignUp = forSignUp
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
