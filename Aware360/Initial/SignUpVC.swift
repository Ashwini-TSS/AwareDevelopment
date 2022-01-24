//
//  SignUpVC.swift
//  Aware360
//
//  Created by mac on 10/02/21.
//

import UIKit
import ACFloatingTextfield_Swift

class SignUpVC: UIViewController {
    @IBOutlet weak var addresstxtfld: ACFloatingTextfield!
    @IBOutlet weak var nametxtfld: ACFloatingTextfield!
    @IBOutlet weak var passwordtxtfld: ACFloatingTextfield!
    @IBOutlet weak var emailtxtfld: ACFloatingTextfield!
    @IBOutlet weak var mobiletxtfld: ACFloatingTextfield!
    @IBOutlet weak var ssntextfld: ACFloatingTextfield!
    @IBOutlet weak var addressview: DropShadow!
    @IBOutlet weak var edgeview: UIView!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var passwordview: DropShadow!
    @IBOutlet weak var emailview: DropShadow!
    @IBOutlet weak var mobileview: DropShadow!
    @IBOutlet weak var ssnview: DropShadow!
    @IBOutlet weak var nameview: DropShadow!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.registerbtn.layer.cornerRadius = 10
        self.registerbtn.layer.masksToBounds = false
        edgeview.roundCorners(corners: [.topLeft, .topRight], radius: 128)
        self.shadowToButton()
    }
    func shadowToButton()
    {
        self.registerbtn.layer.shadowColor = UIColor.lightGray.cgColor
        self.registerbtn.layer.shadowOpacity = 1
        self.registerbtn.layer.shadowOffset = .zero
        self.registerbtn.layer.shadowRadius = 10
        self.registerbtn.layer.shadowPath = UIBezierPath(rect: self.registerbtn.bounds).cgPath
        self.registerbtn.layer.shouldRasterize = true
    }
    @IBAction func LoginAction(_ sender: UIButton) {
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        if(nametxtfld.text == "")
        {
            self.nametxtfld.showErrorWithText(errorText: "Fill your name")
            self.shakeAnimation(myview: nameview)
        }
        else if(addresstxtfld.text == "")
        {
            self.addresstxtfld.showErrorWithText(errorText: "Fill your address")
            self.shakeAnimation(myview: addressview)
        }
        else if(ssntextfld.text == "")
        {
            self.ssntextfld.showErrorWithText(errorText: "Fill your SSN number")
            self.shakeAnimation(myview: ssnview)
        }
        else if(mobiletxtfld.text == "")
        {
            self.mobiletxtfld.showErrorWithText(errorText: "Fill your mobile number")
            self.shakeAnimation(myview: mobileview)
        }
        else if(emailtxtfld.text == "")
        {
            self.emailtxtfld.showErrorWithText(errorText: "Fill your email")
            self.shakeAnimation(myview: emailview)
        }
        else if(!isValidEmail(emailtxtfld.text!))
        {
            self.emailtxtfld.showErrorWithText(errorText: "Entered email is not valid")
            self.shakeAnimation(myview: emailview)
        }
        else if(passwordtxtfld.text == "")
        {
            self.passwordtxtfld.showErrorWithText(errorText: "Fill your password")
            self.shakeAnimation(myview: passwordview)
        }
        else if(passwordtxtfld.text!.count < 6)
        {
            self.passwordtxtfld.showErrorWithText(errorText: "Password must be atleast 6 digit characters")
            self.shakeAnimation(myview: passwordview)
        }else
        {
            
        }
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func shakeAnimation(myview : UIView)
    {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: myview.center.x - 10, y: myview.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: myview.center.x + 10, y: myview.center.y))

        myview.layer.add(animation, forKey: "position")
    }
}
