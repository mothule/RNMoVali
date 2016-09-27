# RNMoVali
This is a model validator for Swift

# Features
- Not dependent on external frameworks.
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
            .add(constraint:RNConstraintLength(max: 10, errorMessage: "Invalid range"))
            .add(constraint:RNConstraintAlphabet(errorMessage: "Only alphabets."))
        binder.bind(lastName, accessTag: "lastName")
            .add(constraint:RNConstraintLength(max: 10, errorMessage: "Invalid range"))
            .add(constraint:RNConstraintAlphabet(errorMessage: "Only alphabets."))
    }
}
~~~


RNValidator call validate method.
parameter is model realized RNValidatable protocol.

~~~swift
let results = RNValidator.sharedInstance.validate(model)
if results.isInvalid {
    if let firstNameErrorMessages = results.fields["firstName"] {
        firstNameMessageLabel.text = firstNameErrorMessages.messages.joined(separator:"\n")
    }
    if let lastNameErrorMessages = results.fields["lastName"] {
        lastNameMessageLabel.text = lastNameErrorMessages.messages.join(separator:"\n")
    }
}
~~~


# Runtime Requirements

- iOS 10 later
- Swift 3.0 later

# Installation and Setup

Support CocoaPods

~~~podfile
pod 'RNMoVali', '~> 2.0'
~~~

# Attention

I am a Japanese programmer, so I have some trouble writing in English.
You may find a typo or mistake but just be nice with your feedback.

Thank you for your support and kindness.
