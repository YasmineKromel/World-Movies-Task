//
//  AuthViewController.swift
//  World Movies
//
//  Created by mino on 7/1/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase
import FirebaseAuth

class AuthViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var AppPoster: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var Signup: UIButton!
    
    
    //MARK: Variables
    var User_mail : String = " "
    
    
   //MARK: ViewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : Actions
    
    @IBAction func CheckLogin(_ sender: UIButton) {
        
        if self.email.text == "" || self.password.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                    
                    self.User_mail = self.email.text!
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the MovieListViewController if the login is sucessful
                    self.performSegue(withIdentifier: "ShowListOfMovies", sender: self)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func Signup(_ sender: UIButton) {
    
        
        if email.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                
                if error == nil {
                    
                    self.User_mail = self.email.text!
                    
                    let alertLogin = UIAlertController(title: "Signup", message: "You have successfully signed up,Please click login button", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertLogin.addAction(defaultAction)
                    
                   self.present(alertLogin, animated: true, completion: nil)

                    //print("You have successfully signed up")
                }
                
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        
    }
        
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "ShowListOfMovies") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! MoviesViewController
            // your new view controller should have property that will store passed value
            viewController.userN = User_mail
         
        }

    }
    

}
