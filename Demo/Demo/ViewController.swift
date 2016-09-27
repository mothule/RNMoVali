//
//  ViewController.swift
//  Demo
//
//  Created by mothule on 2016/08/23.
//  Copyright © 2016年 mothule. All rights reserved.
//

import UIKit


class ProfileEntity : RNValidatable {
    var firstName:String
    var lastName:String
    var fullName:String{ return firstName + " " + lastName }
    
    init(firstName:String, lastName:String){
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func bindConstraint(binder: RNConstraintBinder) {
        binder.bind(field: firstName, accessTag: "firstName")
            .add(constraint: RNConstraintLength(min: 1, max: 10, errorMessage: "名前は1文字以上, 10文字以下にしてください."))
            .add(constraint: RNConstraintAlphabet(errorMessage: "半角英字以外は入力しないでください."))
        binder.bind(field: lastName, accessTag: "lastName")
            .add(constraint: RNConstraintLength(min: 1, max: 10, errorMessage: "名前は1文字以上, 10文字以下にしてください."))
            .add(constraint: RNConstraintAlphabet(errorMessage: "半角英字以外は入力しないでください."))
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameMessageLabel: UILabel!
    @IBOutlet weak var lastNameMessageLabel: UILabel!

    private var model:ProfileEntity = ProfileEntity(firstName: "", lastName: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateName()
    }
    
    private func validateName(){
        
        updateModelFromUI()
        clearMessageLabel()
        
        let results = RNValidator.sharedInstance.validate(model)
        if results.isInvalid {
            if let firstNameErrorMessages = results.fields["firstName"] {
                firstNameMessageLabel.text = firstNameErrorMessages.messages.joined(separator: "\n")
            }
            if let lastNameErrorMessages = results.fields["lastName"] {
                lastNameMessageLabel.text = lastNameErrorMessages.messages.joined(separator: "\n")
            }
        }
        
    }
    private func updateModelFromUI(){
        model.firstName = firstNameTextField.text!
        model.lastName = lastNameTextField.text!
    }
    private func clearMessageLabel() {
        firstNameMessageLabel.text = nil
        lastNameMessageLabel.text = nil
    }
    
    @IBAction func onTouchedRegisterButton(_ sender: UIButton) {
        validateName()
    }
    
}

