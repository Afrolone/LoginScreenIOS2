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
    
    var allFieldsHaveInput = false
    
    @IBAction func registerClicked(_ sender: Any) {
        checkForEmptyTextFields()
        if !allFieldsHaveInput {
            sendAlert(title: "Bad Input!",message: "All fields must have input")
            return
        }
        
        if !areTextFieldTextsSame(firstTVIndex: 2, secondTVIndex: 3) {
            sendAlert(message: "Emails are not the same!")
            return
        }
        
        if !areTextFieldTextsSame(firstTVIndex: 4, secondTVIndex: 5) {
            sendAlert(message: "Passwords are not the same!")
            return
        }
        
        sendAlert(title: "Success",message: "")
            
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
        setButton()
        setTextViews()
        configureTapGesture()
        configureKeyboard()

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
            textField.setLeftPaddingPoints(5)
            textField.setRightPaddingPoints(5)
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.gray.cgColor
        }
        formTextfields[4].isSecureTextEntry = true
        formTextfields[5].isSecureTextEntry = true
    }
    
    fileprivate func checkForEmptyTextFields() {
        for (tvf, labf) in zip(formTextfields, requiredLabels) {
            allFieldsHaveInput = true
            if tvf.text!.isEmpty {
                allFieldsHaveInput = false
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
                self.view.frame.origin.y -= 1.0*(keyboardSize.height)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func sendAlert(title: String = "Invalid Credentials", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action
            in
        })
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    fileprivate func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func areTextFieldTextsSame(firstTVIndex: Int, secondTVIndex: Int) -> Bool {
        let text1 = formTextfields[firstTVIndex].text ?? ""
        let text2 = formTextfields[secondTVIndex].text ?? ""
        
        return text1 == text2
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tagBasedTextField(textField)
        return true
    }
    
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

