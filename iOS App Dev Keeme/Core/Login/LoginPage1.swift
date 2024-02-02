//
//  LoginPage1.swift
//  KeemeV2
//
//  Created by Gunna Rahul on 17/01/24.
//
import SwiftUI

struct LoginPage1: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        VStack{
            Image("keeme")
                .resizable()
            //  .scaledToFill()
                .frame(width: 150,height: 120)
                .frame(height: getRect().height / 5)
                .padding()
                .background(
                    ZStack{
                        LinearGradient(colors:[
                        Color("LoginCircle"),
                        Color("LoginCircle").opacity(0.8),
                        Color("pink") ], startPoint: .top, endPoint: .bottom)
                        .frame(width:100,height: 100)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .offset(x:100,y:-25)
                        .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 30,height: 30)
                            .blur(radius: 3)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(25)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 30,height: 30)
                            .blur(radius: 3)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(25)
                            
                    }
                
                )
            ScrollView(.vertical,showsIndicators:false){
                VStack(spacing:15){
                    
                    Text(loginData.registerUser ? "Sign Up" : "Login")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment:.center)
                    // Custom Text Field
                    CustomTextField(icon: "envelope", title: "Email", hint: "keeme@srmist.edu.in", value: $loginData.password, showPassword: .constant(false))
                            .padding(.top,20)
                    CustomTextField(icon: "lock", title: "Password", hint: "123456", value: $loginData.email, showPassword: $loginData.showPassword)
                        .padding(.top,10)
                    // Register Reenter Password
                    if loginData.registerUser{
                        CustomTextField(icon: "lock", title: "Re-Enter Password", hint: "123456", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top,10)
                        CustomTextField(icon: "person", title: "Full Name", hint: "Keeme", value: $loginData.full_Name, showPassword: $loginData.showFullName)
                            .padding(.top,10)
                    }
                    // forgot password button
                    Button {
                        loginData.ForgotPassword()
                    } label: {
                        Text("Forgot Password ?")
                            .font(.system(size:16,weight: .medium,design: .default))
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    // Hide the "Forgot Password?" button when on the sign-up page
                    .opacity(loginData.registerUser ? 0 : 1)
                    // login button
                    Button {
                        if loginData.registerUser {
                            loginData.Register()
                        } else {
                            loginData.Login()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Sign Up" : "Login")
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .font(.system(size:20,weight: .medium,design: .default))
                            .foregroundColor(.black)
                            .background(Color("blue2"),in: .capsule)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5,x:5,y:5)
                    }
                    .padding(.top, loginData.registerUser ? -10 : 25) // Adjusted the top padding for the button
                    
                    // Register user button
                    Button{
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Back to Login" : "Create Account")
                        .font(.system(size:16,weight: .medium,design: .default))
                    }
                    .padding(.top,8)
                    
                }
                .padding(30)
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners:[.topLeft],radius: 35))
                    .ignoresSafeArea()
            )
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(Color("blue2"))
        // clearing data
        .onChange(of: loginData.registerUser) { newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.full_Name = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String,title: String, hint: String, value:Binding<String>, showPassword:Binding<Bool>)->some View{
        VStack(alignment:.leading,spacing: 12){
            Label{
                Text(title)
                    .font(.system(size:16,weight: .medium,design: .default))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top,2)
                
            }
            else {
                TextField(hint, text: value)
                    .padding(.top,2)
            }
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // showing show button for password field
        .overlay(
            Group {
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        if showPassword.wrappedValue {
                            Image(systemName: "eye.slash.fill")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(.purple)
                        } else {
                            Image(systemName: "eye.fill")
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(.purple)
                        }
                    })
                    .offset(y: 8)
                }
            },
            alignment: .trailing
        )
    }
}

#Preview {
    LoginPage1()
}

