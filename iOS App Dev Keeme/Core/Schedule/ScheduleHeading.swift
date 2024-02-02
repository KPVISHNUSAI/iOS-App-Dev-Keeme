import SwiftUI

struct ScheduleHeading: View {
    var body: some View {
        VStack(){
            HStack{
                Text("Schedule")
                    .font(.system(size:25,weight: .medium,design: .default))
                    .padding()
                Spacer()
                Image("lauren")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                    .padding()
            }
            VStack{
                HStack{
                    Image("rita")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                        .padding(.trailing,20)
                    VStack{
                        Text("Rita")
                            .font(.headline)
                            .frame(width: 280,alignment: .leading)
                        Text("Today I am starting to organize my notes in notion ")
                            .font(.caption)
                            .frame(width: 280,alignment: .leading)
                        Text("11:40pm - 12:40am")
                            .font(.headline)
                            .frame(width: 280,alignment: .leading)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .frame(height: 60)
                .chartXAxis(.hidden)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 10)
                
            }
            VStack{
                HStack{
                    Image("shelly")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                        .padding(.trailing,20)
                    VStack{
                        Text("Shelly")
                            .font(.headline)
                            .frame(width: 280,alignment: .leading)
                        Text("I am going to learn a new skill or language by enrolling in an online course.")
                            .font(.caption)
                            .frame(width: 280,alignment: .leading)
                        Text("7:00am - 7:30am")
                            .font(.headline)
                            .frame(width: 280,alignment: .leading)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .frame(height: 60)
                .chartXAxis(.hidden)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 10)
                
            }
            VStack{
                HStack{
                    Image("kyle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                        .padding(.trailing,20)
                    VStack{
                        Text("Kyle")
                            .font(.headline)
                            .frame(width: 280,alignment: .leading)
                        Text("My Today’s goal is to find a bugs in my project and to go through my mails")
                            .font(.caption)
                            .frame(width: 280,alignment: .leading)
                        Text("2:40pm - 3:40pm")
                            .font(.headline)
                            .frame(width: 280,alignment: .leading)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .frame(height: 60)
                .chartXAxis(.hidden)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 10)
                
            }
        }
        Spacer()
    }
}

#Preview {
    ScheduleHeading()
}
