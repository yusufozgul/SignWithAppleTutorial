//
//  ViewController.swift
//  Sign in with Apple
//
//  Created by Yusuf Özgül on 12.06.2019.
//  Copyright © 2019 Yusuf. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let authButton = ASAuthorizationAppleIDButton()
        authButton.addTarget(self, action: #selector(authAppleID), for: .touchUpInside)
        view.addSubview(authButton)
        authButton.center = view.center
    }


    @objc func authAppleID()
    {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let authRequest = appleIDProvider.createRequest()
        authRequest.requestedScopes = [.email, .fullName]
        
        let authController = ASAuthorizationController(authorizationRequests: [authRequest])
        authController.presentationContextProvider = self
        authController.delegate = self
        authController.performRequests()
        
    }
}

extension ViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding
{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization)
    {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        print("USER: \(appleIDCredential.user)")
        print("EMAIL: \(appleIDCredential.email!)")
        print("FULL NAME: \(appleIDCredential.fullName!)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor
    {
        return self.view.window!
    }
}
