//
//  LoginPageModel.swift
//  KeemeV2
//
//  Created by Gunna Rahul on 17/01/24.
//
import SwiftUI

class LoginPageModel: ObservableObject {
   //Login Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    //Register
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    @Published var full_Name: String = ""
    @Published var showFullName: Bool = false
    // log status
    @AppStorage("log_Status") var log_Status: Bool =  false
    
    //Login call
    func Login(){
        withAnimation{
            log_Status = true
        }
    }
    func Register(){
        withAnimation{
            log_Status = true
        }
        
    }
    func ForgotPassword(){
        
    }
}
