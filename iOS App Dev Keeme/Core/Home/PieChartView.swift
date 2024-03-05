import SwiftUI
import Charts

struct PieChartView: View {
    var meetTimes = PieData.all
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        HStack {
            ZStack {
                Chart(meetTimes) { meetTime in
                    SectorMark(
                        angle: .value(" ", meetTime.time),
                        innerRadius: .ratio(0.8),
                        angularInset: 1)
                        .annotation(position: .overlay) {}
                        .foregroundStyle(meetTime.color)
                }
                VStack {
                    Text("63%")
                        .font(.system(size: sizeClass == .compact ? 30 : 40, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
            }
            .frame(width: sizeClass == .compact ? 130 : 300, height: sizeClass == .compact ? 130 : 300)
            .padding()
            
            VStack(alignment: .leading) {
                
                Text("TargetTime : 60 mins")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .padding()
                    .font(.system(size: 13))
                
                Text("TimeFocused : 38 mins")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .padding()
                    .font(.system(size: 13))
                
                
                    
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.blue2)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 10)
        .padding()
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}

