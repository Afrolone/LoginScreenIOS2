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
    
    
    @IBOutlet var formTextfields: [UITextField]!
    
    @IBOutlet var requiredLabels: [UILabel]!
    
    
    @IBAction func registerClicked(_ sender: Any) {
        checkForEmptyTextFields()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
        setButton()
        setTextViews()
        configureTapGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
    
    private func setTextViews() {
        print("TAGS")
        for textField in formTextfields {
            textField.tag = formTextfields.firstIndex(of: textField)!
            print(textField.tag)
            textField.delegate = self
            textField.layer.cornerRadius = 10
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.black.cgColor
        }
        formTextfields[4].isSecureTextEntry = true
        formTextfields[5].isSecureTextEntry = true
    }
    
    fileprivate func checkForEmptyTextFields() {
        for (tvf, labf) in zip(formTextfields, requiredLabels) {
            if tvf.text!.isEmpty {
                labf.isHidden = false
            } else {
                labf.isHidden = true
            }
        }
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    private func tagBasedTextField(_ textField: UITextField) {
        if textField.tag != 5 {
            let nextTextField: UITextField? = formTextfields[textField.tag + 1]
            nextTextField!.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 0.8*(keyboardSize.height)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func sendAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Credentials", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action
            in
        })
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidEmail() {
        //email = formTextfields[3].text
        //confirmEmail = formTextfields[4].text
        
        //confirmEmail.
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tagBasedTextField(textField)
        return true
    }
    
    
}

