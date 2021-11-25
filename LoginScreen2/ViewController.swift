//
//  ViewController.swift
//  LoginScreen2
//
//  Created by Ant Colony on 24. 11. 2021..
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    @IBOutlet weak var firstNameRequired: UILabel!
    @IBOutlet weak var lastNameRequired: UILabel!
    @IBOutlet weak var emailRequired: UILabel!
    @IBOutlet weak var confirmEmailRequired: UILabel!
    @IBOutlet weak var passwordRequired: UILabel!
    @IBOutlet weak var confirmPasswordRequired: UILabel!
    
    
    @IBAction func registerClicked(_ sender: Any) {
        checkIfFirstNameEmpty()
        checkIfLastNameEmpty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
        setButton()
        firstNameTextField.layer.cornerRadius = 10
        lastNameTextField.layer.cornerRadius = 10
        emailTextField.layer.cornerRadius = 10
        confirmEmailTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        confirmPasswordTextField.layer.cornerRadius = 10
    }

    fileprivate func setImageView() {
        imageView.image = UIImage(named: "niss")!
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = (imageView?.frame.width)!/2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.clipsToBounds = true
    }
    
    fileprivate func setButton() {
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    fileprivate func checkIfFirstNameEmpty() {
        if (firstNameTextField.text!.isEmpty) {
            firstNameRequired.isHidden = false
        } else {
            firstNameRequired.isHidden = true
        }
    }
    
    fileprivate func checkIfLastNameEmpty() {
        if (lastNameTextField.text!.isEmpty) {
            lastNameRequired.isHidden = false
        } else {
            lastNameRequired.isHidden = true
        }
    }
    
    fileprivate func checkIfEmailEmpty() {
        if (emailTextField.text!.isEmpty) {
            emailRequired.isHidden = false
        } else {
            emailRequired.isHidden = true
        }
    }

}

