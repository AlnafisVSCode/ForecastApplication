//
//  WeatherView.swift
//  WeatherApplication
//
//  Created by Alnafis Chowdhury on 5/12/22.
//

import SwiftUI

struct WeatherView: View {
    @State var weatherForView : Weather?
    @State var location : String = ""
    @State var presentAlert = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("pexel2").resizable().ignoresSafeArea()
                VStack {
                    HStack {
                        TextField("Enter Location", text: $location).textFieldStyle(RoundedBorderTextFieldStyle()).shadow(radius: 5)
                        Button {
                            getWeather()
                        } label: {Image (systemName:
                                            "magnifyingglass.circle.fill").font(.system(size: 50)).foregroundColor(.orange)
                        }
                    }
                    
                    //https://www.appcoda.com/learnswiftui/swiftui-text.html
                    Spacer()
                    Text("\(location)").fontWeight(.bold).textCase(.uppercase).multilineTextAlignment(.center)
                        .font(.system(.title, design: .rounded))
                    
                    Text("Weather Information:").fontWeight(.bold)
                        .multilineTextAlignment(.center).font(.system(.title, design: .rounded))
                    //2 Types of information to be desplayed
                    HStack {
                        Image("temp").resizable().scaledToFit().frame(width: 120, height: 120)
                        Text(weatherForView?.main.temp.description ?? "0")
                        Text("°C")
                    }.font(.system(size: 50))
                    
                    HStack {
                        Image("humidity").resizable().scaledToFit().frame(width: 120, height: 120)
                        Text(weatherForView?.main.humidity.description ?? "0")
                        Text("%")
                    }.font(.system(size: 50))
                    Spacer()
                    
                    //Navigation Links Between the pages
                    HStack{
                        NavigationLink(destination: DetailWeatherView(location: location))
                        {Text("Detail Weather")
                                .font(.title2.weight(.heavy))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .padding(.horizontal, 1)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(18)
                        }
                        NavigationLink(destination: FiveDayView(location: location))
                        {   Text("5 Day Weather")
                                .font(.title2.weight(.heavy))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .padding(.horizontal, 1)
                                .foregroundColor(.white)
                                .background(Color.orange)
                                .cornerRadius(18)
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Weather App").font(.system(.title, design: .rounded))
                .alert("An error has occured", isPresented: $presentAlert) {
                    Button("OK", role: .cancel) {}
                }
            }
        }
    }
    //How to remove spaces from search Locations Cities
    //https://stackoverflow.com/questions/28570973/how-should-i-remove-all-the-leading-spaces-from-a-string-swift
    func getWeather() {
        presentAlert = viewWeatherAlert
        let url = setLocationURLString(location: "\(location.replacingOccurrences(of: " ", with: "+"))")
        getCurrentWeather(url: url, completion: {_ in weatherForView = weather})
    }
    
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
