//
//  SetupViewController.swift
//  PC_RemoteClientSide
//
//  Created by Pedro Vargas on 22/12/19.
//  Copyright © 2019 Pedro Vargas. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didEndEditing(_ sender: UITextField) {
        //192.168.0.14
        if sender.text?.count == 12 {
            ModelClient.shared.ip_adress = sender.text!
            print(ModelClient.shared.ip_adress)
        }
        
    }
    
    @IBAction func okTapped(_ sender: Any) {
        if ModelClient.shared.ip_adress != nil {
            print("mostrou tela nova")
            self.performSegue(withIdentifier: "showButtons", sender: self)
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
