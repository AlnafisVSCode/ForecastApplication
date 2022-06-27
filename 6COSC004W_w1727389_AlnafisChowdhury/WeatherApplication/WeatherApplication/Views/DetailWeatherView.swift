//
//  DetailWeatherView.swift
//  WeatherApplication
//
//  Created by Alnafis Chowdhury on 5/12/22.
//

import SwiftUI

struct DetailWeatherView: View {
    
    @State var location : String
    @State var weatherForView : Weather?
    @State var presentAlert = false
    
    var body: some View {
        Image("pexel2").resizable().ignoresSafeArea()
        //Horizontal Stacking to stack the search bar and icon button
        HStack {
            TextField("Enter Location", text: $location).textFieldStyle(RoundedBorderTextFieldStyle()).shadow(radius: 15).padding(.leading)
            Button {
                getWeather()
            } label: {Image (systemName:
                                "magnifyingglass.circle.fill").font(.system(size: 50)).foregroundColor(.blue)
            }
        }
        
        //Stack to display all the weather information properly one after another
        VStack{
            Image("px1").resizable()
            Text("\(location)").fontWeight(.heavy).textCase(.uppercase)
            Text("Weather Information:").font(.subheadline).multilineTextAlignment(.center)
            
            //The summary Image for the overall Weather
            HStack {
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherForView?.weather.last?.icon ?? "04n")@2x.png")) {image in
                image
                    .resizable()
            } placeholder: {
                Color.clear
            }.frame(width: 190, height: 180)
                .padding(-20)
                
            }
            
            HStack {
                Image("temp").resizable().scaledToFit().frame(width: 60, height: 60)
                Text(weatherForView?.main.temp.description ?? "   0")
                Text("°C")
            }.font(.system(size: 50))
            
            HStack {
                Image("humidity").resizable().scaledToFit().frame(width: 60, height: 60)
                Text(weatherForView?.main.humidity.description ?? "   0")
                Text("%")
            }.font(.system(size: 50))
            
            HStack {
                Image("pressure").resizable().scaledToFit().frame(width: 60, height: 60)
                Text(weatherForView?.main.pressure.description ?? "0")
                Text("mb")
            }.font(.system(size: 50))
            
            HStack {
                Image("windSpeed").resizable().scaledToFit().frame(width: 60, height: 60)
                Text(weatherForView?.wind.speed.description ?? "0")
                Text("mph")
            }.font(.system(size: 50))
            
        }
        .navigationBarTitle("Weather Details").font(.system(.title, design: .rounded)).foregroundColor(.blue).padding().background(.ultraThickMaterial).shadow(radius: 25)
        .onAppear {
            getWeather()
        }
//        .alert("An error has occured", isPresented: $presentAlert) {
//            Button("OK", role: .cancel) {}
//        }
    }
    
    //Get the location searched from previous page or search location while detecting for empty spaces
    func getWeather() {
        presentAlert = viewWeatherAlert
        let url = setLocationURLString(location: "\(location.replacingOccurrences(of: " ", with: "+"))")
        getCurrentWeather(url: url, completion: {_ in weatherForView = weather})
    }
    
}

struct DetailWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailWeatherView(location : "London")
    }
}

