//
//  LoginViewController.swift
//  World Movies
//
//  Created by mino on 6/30/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var Email: UITextField!
    
   // @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var Password: UITextField!
    
    
   
   // @IBOutlet weak var SignupBtn: UIButton!
    
    let DataRef =  Database.database().reference(fromURL:"https://topmovies-fda32.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func LOG(_ sender: UIButton) {
//        guard let email = Email.text
//            else{
//                print("Email issue")
//                return
//        }
//        
//        guard let pass = Password.text else {
//            print("Password Issue")
//            return
//        }
//        
//        Auth.auth().signIn(withEmail: email, password: pass, completion: {
//            (user , error) in if error != nil{
//                print(error!)
//                return
//            }
//            self.dismiss(animated: true, completion: nil)
//        })
//        //
//
//        
//    }
    
    
  //  @IBAction func CheckLogin(_ sender: AnyObject) {
        
      // self.performSegue(withIdentifier: "ShowListOfMovies", sender: self)
        
        
 //   }

    
 //   @IBAction func Signup(_ sender: AnyObject) {
        
//        guard let email = Email.text
//            else{
//                print("Email issue")
//                return
//        }
//        
//        guard let pass = Password.text else {
//            print("Password Issue")
//            return
//        }
//        
//        Auth.auth().createUser(withEmail: email, password: pass, completion: {
//            (user , error) in if error != nil{
//                print(error!)
//                return
//            }
//            guard  let uid = user?.user.uid else{
//                return
//            }
//            
//            let userReference = self.DataRef.child(uid)
//            self.dismiss(animated: true, completion: nil)
//            
//        })

        
   // }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
