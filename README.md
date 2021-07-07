# Biometric-Login-with-Firebase

This application will help you to login using firebase and store the crediential in keychain for biometric login - SwiftUI

In this project i have incorporated Firebase Authentication *email* and *password* type. Once the user created the account. They have to **signin** for first time once they logged in keychain will automatically saved and encrypt your data in keychain and later used for biometric login for users convineance. 

Your data is **100%** safe and secured in apples keychain. 

In this project Biometric option will be automatically detects users device and displays the correct way of authentication process. For example users device such as iPhone X and above will show FaceID. And iPhone 6s to Iphone 8 and some ipad which have fingerprint ID will automatically show Touch ID. And like ipod touch 7 series like device will not show any Biomateric and user need to manually input usernamd and password. 

* Swift package manager for SwiftKeychainWrapper for Apple Keychain.

* Cocoapod installation for Firebase Auth and Firebase Core.

* Proper error handling via alert for user intracation.

   To use **Biometric** you add plist - **[Privacy - Face ID Usage Description]**

  

