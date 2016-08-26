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
    if let firstNameErrorMessages = results.fields["firstName"] {
        firstNameMessageLabel.text = firstNameErrorMessages.messages.joinWithSeparator("\n")
    }
    if let lastNameErrorMessages = results.fields["lastName"] {
        lastNameMessageLabel.text = lastNameErrorMessages.messages.joinWithSeparator("\n")
    }
}
~~~


# Runtime Requirements

- iOS 9.3
- Swift 2.2

# Installation and Setup

Support CocoaPods

~~~podfile
pod 'RNMoVali', '~> 1.0'
~~~

# Attention

I am Japanese. English does not speak only a little. and write too.
Often you will find a typo. At that time, close your eyes. And may you send kindness pull-requests.

Thank you for reading to the end.
