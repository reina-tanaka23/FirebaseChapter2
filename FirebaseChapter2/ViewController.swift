//
//  ViewController.swift
//  FirebaseChapter2
//
//  Created by reina.tanaka on 2021/09/26.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    var changed: AuthStateDidChangeListenerHandle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "email & pass."
        pass.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changed = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.label.text = user?.email
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        Auth.auth().removeStateDidChangeListener(changed)
    }

    @IBAction func doAction(_ sender: Any) {
        let email = self.email.text
        let password = self.pass.text
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { (user, error) in
            if error != nil {
                self.label.text = error?.localizedDescription
                return
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

