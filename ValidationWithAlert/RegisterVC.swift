//
//  RegisterVC.swift
//  ValidationWithAlert
//
//  Created by Deep Mahajan.
//

import UIKit

class RegisterVC: UIViewController,UITextFieldDelegate {
    
    //MARK:- Outlet
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfMobileNumber: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Supporting methods
    
    //TextField Delegate
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == tfName{
                tfMobileNumber.becomeFirstResponder()
            }else if textField == tfMobileNumber{
                tfEmail.becomeFirstResponder()
            }else if textField == tfEmail{
                tfAddress.becomeFirstResponder()
            }else if textField == tfAddress{
                tfPassword.becomeFirstResponder()
            }else if textField == tfPassword{
                tfConfirmPassword.becomeFirstResponder()
            }else if textField == tfConfirmPassword{
                textField.resignFirstResponder()
            }
            return true
        }
    
    //Show Alert
    func showAlert(message: String){
     let alert = UIAlertController(title: "ALERT", message: message, preferredStyle: .alert)
     
     alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
     self.present(alert, animated: true, completion: nil)
     
    }
    
    //Check Validation
    func checkValidation(){
        if tfName.text!.isEmpty || tfMobileNumber.text!.isEmpty || tfEmail.text!.isEmpty || tfAddress.text!.isEmpty{
            showAlert(message: "Please fill all the texts")
        }
        else if tfMobileNumber.text!.count < 10 || tfMobileNumber.text!.count > 12{
            showAlert(message: "Please Enter Valid Phone Number")
        }
        else if tfEmail.text!.isEmail == false{
            showAlert(message: "Please Enter Valid Email")
        }
        else if tfPassword.text!.isPassword == false{
            showAlert(message: "Please Enter Valid Password")
        }
        else if tfPassword.text != tfConfirmPassword.text{
            showAlert(message: "Please make sure your Password match")
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK:- Actions
    @IBAction func btnSubmit(_ sender: Any) {
        checkValidation()
    }
    
}

//Using for email validation
extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isPassword: Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
}


