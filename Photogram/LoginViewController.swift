//
//  LoginViewController.swift
//  Photogram
//
//  Created by Ashwin Gupta on 3/20/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSignin(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        //newUser.email = usernameField.text
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if (success){
                print("created user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
