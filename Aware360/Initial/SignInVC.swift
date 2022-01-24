//
//  SignInVC.swift
//  Aware360
//
//  Created by mac on 09/02/21.
//

import UIKit
import ACFloatingTextfield_Swift

class SignInVC: UIViewController {

    @IBOutlet weak var passwordTxtfld: ACFloatingTextfield!
    @IBOutlet weak var emailTxtfld: ACFloatingTextfield!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var edgeview: UIView!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    private var shadowLayer: CAShapeLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loginBtn.layer.cornerRadius = 10
        self.loginBtn.layer.masksToBounds = false
        edgeview.roundCorners(corners: [.topLeft, .topRight], radius: 128)
        self.shadowToButton()
    }
func shadowToButton()
{
    self.loginBtn.layer.shadowColor = UIColor.lightGray.cgColor
    self.loginBtn.layer.shadowOpacity = 1
    self.loginBtn.layer.shadowOffset = .zero
    self.loginBtn.layer.shadowRadius = 10
    self.loginBtn.layer.shadowPath = UIBezierPath(rect: self.loginBtn.bounds).cgPath
    self.loginBtn.layer.shouldRasterize = true
}

    
@IBAction func LoginAction(_ sender: UIButton) {
    if(emailTxtfld.text == "")
    {
        self.emailTxtfld.showErrorWithText(errorText: "Fill your email")
        self.shakeAnimation(myview: emailView)
    }
    else if(!isValidEmail(emailTxtfld.text!))
    {
        self.emailTxtfld.showErrorWithText(errorText: "Entered email is not valid")
        self.shakeAnimation(myview: emailView)
    }
    else if(passwordTxtfld.text == "")
    {
        self.passwordTxtfld.showErrorWithText(errorText: "Fill your password")
        self.shakeAnimation(myview: passwordView)
    }
    else if(passwordTxtfld.text!.count < 6)
    {
        self.passwordTxtfld.showErrorWithText(errorText: "Password must be atleast 6 digit characters")
        self.shakeAnimation(myview: passwordView)
    }else{
        
    }
    }
    @IBAction func signUpApiAction(_ sender: UIButton) {
    }
    
    func loginApiAction()
    {
        
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
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}
