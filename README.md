# RNMoVali
This is a model validator for Swift

# Features
- Not dependency external frameworks.
- Light weight.


# How to use

Model class realize RNValidatable protocol.

~~~swift
class ProfileEntity : RNValidatable {
    var firstName:String
    var lastName:String

    init(firstName:String, lastName:String){
        self.firstName = firstName
        self.lastName = lastName
    }

    func bindConstraint(binder: RNConstraintBinder) {
        binder.bind(firstName, accessTag: "firstName")
            .addConstraint(RNConstraintLength(max: 10, errorMessage: "Invalid range"))
            .addConstraint(RNConstraintAlphabet(errorMessage: "Only alphabets."))
        binder.bind(lastName, accessTag: "lastName")
            .addConstraint(RNConstraintLength(max: 10, errorMessage: "Invalid range"))
            .addConstraint(RNConstraintAlphabet(errorMessage: "Only alphabets."))
    }
}
~~~


RNValidator call validate method.
parameter is model realized RNValidatable protocol.

~~~swift
let results = RNValidator.sharedInstance.validate(model)
if results.isInvalid {
    if let firstNameErrorMessage = results.fields["firstName"] {
        firstNameMessageLabel.text = firstNameErrorMessage
    }
    if let lastNameErrorMessage = results.fields["lastName"] {
        lastNameMessageLabel.text = lastNameErrorMessage
    }
}
~~~


# Runtime Requirements

- iOS 9.3
- Swift 2.2

# Installation and Setup

To be prepared.
