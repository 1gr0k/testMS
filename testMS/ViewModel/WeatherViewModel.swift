//
//  WeatherViewModel.swift
//  testMS
//
//  Created by Андрей Калямин on 21.06.2021.
//

import Foundation

private let weekday = [
    "1" : "Понедельник",
    "2" : "Вторник",
    "3" : "Среда",
    "4" : "Четверг",
    "5" : "Пятница",
    "6" : "Суббота",
    "7" : "Воскресенье"
]

private let iconMap = [
    "Rain" : "🌧",
    "Clouds" : "☁️",
    "Clear" : "☀️",
    "error" : " 🌚"
]

public class WeatherViewModel: ObservableObject {
    
    @Published var city: String
    
    @Published var weather = Weather.placeholder
    
    init(for city: String) {
        self.city = city
        weather = Weather.placeholder
    }
    
    func refresh() async {
        do{
            weather = try await WeatherAPI.shared.fetchWeather(for: city)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getWeatherIcon(desc: String) -> String{
        return iconMap[desc] ?? "😵"
    }
    
    func extractDay(date: String) -> String{
        let days = extractDate(date: date)
        let calendar = Calendar.current
        let day = calendar.component(.weekday, from: days)
        return "\(weekday["\(day)"]!)"
    }

    func extractHour(date: String) -> String{
        let days = extractDate(date: date)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: days)
        return "\(hour)"
    }

    func extractDate(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")!
        return formatter.date(from: date)!
    }
    
}
