//
//  Logo1.swift
//  KeemeV2
//
//  Created by Gunna Rahul on 17/01/24.
//
import SwiftUI
struct Logo1: View {
    // show login page
    @State var showLoginPage: Bool = false
    var body: some View {
        VStack(alignment:.center){
            Image("keeme")
                .resizable()
                .scaledToFill()
                .frame(width: 207,height: 170)
                .clipShape(Rectangle())
            Text("Keeme")
                .font(.system(size:52,weight: .medium,design: .default))
                .padding()
            
            Button{
                withAnimation{
                    showLoginPage = true
                }
            } label:{
                Text("Get Started")
                    .font(.system(size:22,weight: .medium,design: .default))
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5,x:5,y:5)
                    .foregroundColor(.black)
            }
            .padding(.horizontal,70)
            .offset(y:getRect().height < 750 ? 20 : 0)
        }
        .padding(.top,getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(
        Color("blue2")
        )
        .overlay(
            Group{
                if showLoginPage{
                    LoginPage1()
                        .transition(.move(edge: .bottom))
                }
            }
        )
        
    }
}

#Preview {
    Logo1()
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
