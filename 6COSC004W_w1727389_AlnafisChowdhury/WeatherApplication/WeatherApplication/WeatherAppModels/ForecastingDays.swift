//
//  ForecastingDays.swift
//  WeatherApplication

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecastingWeather = try? newJSONDecoder().decode(ForecastingWeather.self, from: jsonData)

import Foundation

// MARK: - ForecastingWeather
struct ForecastingWeather: Codable {
    let cod: String
    let message, cnt: Int
    let list: [ForecastingList]
    let city: ForecastingCity
}

// MARK: - ForecastingCity
struct ForecastingCity: Codable {
    let id: Int
    let name: String
    let coord: ForecastingCoord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - ForecastingCoord
struct ForecastingCoord: Codable {
    let lat, lon: Double
}

// MARK: - ForecastingList
struct ForecastingList: Codable, Identifiable {
    let id = UUID()
    let dt: Int
    let main: ForecastingMainClass
    let weather: [ForecastingWeatherElement]
    let clouds: ForecastingClouds
    let wind: ForecastingWind
    let visibility: Int
    let pop: Double
    let sys: ForecastingSys
    let dtTxt: String
    let rain: ForecastingRain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - ForecastingClouds
struct ForecastingClouds: Codable {
    let all: Int
}

// MARK: - ForecastingMainClass
struct ForecastingMainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - ForecastingRain
struct ForecastingRain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - ForecastingSys
struct ForecastingSys: Codable {
    let pod: ForecastingPod
}

enum ForecastingPod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - ForecastingWeatherElement
struct ForecastingWeatherElement: Codable {
    let id: Int
    let main: ForecastingMainEnum
    let weatherDescription: ForecastingDescription
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum ForecastingMainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum ForecastingDescription: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

// MARK: - ForecastingWind
struct ForecastingWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}



var forecastingHours: ForecastingWeather?

func getForecastDayData(url: String, completion: @escaping ([ForecastingList])->()) {

    let session = URLSession(configuration: .default)
    session.dataTask(with: URL(string: url)!) {(data, _, err) in
        if err != nil {
            print(err!.localizedDescription)
            return
        }

        DispatchQueue.main.async {
            do {
                forecastingHours = try JSONDecoder().decode(ForecastingWeather.self, from: data!)
                completion(forecastingHours?.list ?? [])
                print(forecastingHours?.list)

            }
            catch {
            //Alert = true
                print("There is an Error")
                print(error)
            }
            //Alert = false
        }
    }.resume()
}

func weatherForecastSetLocationURLString(location: String) -> String {
    return
    "https://api.openweathermap.org/data/2.5/forecast?q=\(location)&appid=\(apiKey)&units=metric"
}


