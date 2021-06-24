//
//  FullCityView.swift
//  testMS
//
//  Created by Андрей Калямин on 21.06.2021.
//

import SwiftUI

struct FullCityView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack{
            HStack {
                Text(viewModel.getWeatherIcon(desc: viewModel.weather.list?.first?.weather?.first?.description ?? "error"))
                    .font(.largeTitle)
            }
            HStack {
                Text(viewModel.weather.city?.name ?? "--")
                    .font(.largeTitle)
            }
            HStack {
                Text("\(Int(viewModel.weather.list?.first?.main?.temp ?? 0.0))ºC")
                    .font(.system(size: CGFloat(50)))
            }
            HStack {
                Text("мин: \(Int(viewModel.weather.list?.first?.main?.temp_min ?? 0.0))ºC,")
                Text("макс: \(Int(viewModel.weather.list?.first?.main?.temp_max ?? 0.0))ºC")
            }
            List {
                
                WeatherScrollView(viewModel: viewModel)
                
                ForEach((viewModel.weather.list)!, id: \.id) { hour in
                    if viewModel.extractHour(date: hour.date!)=="16" {
                        DailyWeatherView(day: viewModel.extractDay(date: hour.date!),
                                         icon: viewModel.getWeatherIcon(desc: hour.weather?.first?.description ?? "error"),
                                         temp: hour.main!.temp!)
                    }
                }
                
            }
        }
    }
}

//struct FullCityView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullCityView()
//    }
//}
