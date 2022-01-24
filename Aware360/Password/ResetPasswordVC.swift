//
//  ResetPasswordVC.swift
//  Aware360
//
//  Created by Sayeed Syed on 2/11/21.
//

import UIKit
import ACFloatingTextfield_Swift

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var resetbtn: UIButton!
    @IBOutlet weak var confirmpasswordtctfld: ACFloatingTextfield!
    @IBOutlet weak var newpasswordtxtfld: ACFloatingTextfield!
    @IBOutlet weak var confirmpaasowrdview: DropShadow!
    @IBOutlet weak var newpasswordview: DropShadow!
    @IBOutlet weak var backbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.resetbtn.layer.cornerRadius = 10
        self.resetbtn.layer.masksToBounds = false
        self.shadowToButton()
    }
    func shadowToButton()
       {
           self.resetbtn.layer.shadowColor = UIColor.lightGray.cgColor
           self.resetbtn.layer.shadowOpacity = 1
           self.resetbtn.layer.shadowOffset = .zero
           self.resetbtn.layer.shadowRadius = 10
           self.resetbtn.layer.shadowPath = UIBezierPath(rect: self.resetbtn.bounds).cgPath
           self.resetbtn.layer.shouldRasterize = true
       }
    @IBAction func resetAction(_ sender: UIButton) {
        if(newpasswordtxtfld.text == "")
               {
                   self.newpasswordtxtfld.showErrorWithText(errorText: "Fill your password")
                   self.shakeAnimation(myview: newpasswordview)
               }
               else if(confirmpasswordtctfld.text == "")
               {
                   self.confirmpasswordtctfld.showErrorWithText(errorText: "Fill your confirm password")
                   self.shakeAnimation(myview: confirmpaasowrdview)
               }
        else if(newpasswordtxtfld.text != confirmpasswordtctfld.text)
        {
            self.confirmpasswordtctfld.showErrorWithText(errorText: "password doesn't match")
            self.shakeAnimation(myview: confirmpaasowrdview)
        }
        else
        {
            
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
