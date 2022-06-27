//
//  FiveDayView.swift
//  WeatherApplication
//
//  Created by Alnafis Chowdhury on 5/12/22.
//

import SwiftUI

struct FiveDayView: View {
    @State var days : ForecastingWeather?
    @State var location: String
    @State var dateFormat : Date = Date()
    
    
    var body: some View {
        
        VStack {
            Text("\(location)").fontWeight(.bold).textCase(.uppercase).multilineTextAlignment(.center)
                .font(.system(.title, design: .rounded))
            
            List(days?.list ?? []) { day in
                HStack (alignment: .center) {
                
                    Text(formatDate(date: day.dt)).padding(.leading)
                    Text(day.main.temp.description)
                    
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.weather.last?.icon ?? "04n")@2x.png")) {image in
                        image
                            .resizable()
                    } placeholder: {
                        Color.clear
                    }.frame(width: 65, height: 65)
                }

            }.onAppear {getWeatherForecast()}
        }
    }


//Weather for 3 hours
func getWeatherForecast() {
    let url = weatherForecastSetLocationURLString(location: "\(location.replacingOccurrences(of: " ", with: "+"))")
    getForecastDayData(url: url) {_ in
        //days = decoded array
        days = forecastingHours
        
    }
    
}
//the format of the date
func formatDate(date: Int) -> String {
    let utcDateFormatter = DateFormatter()
    utcDateFormatter.dateFormat = "E MMM d, h a"
    let date = Date(timeIntervalSince1970: Double(date))
    let dateFormat = (utcDateFormatter.string(from: date))
    return ("\(dateFormat)")
    }
}
    
//
//
//struct FiveDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        FiveDayView(location: .constant("London"))
//    }
//}
