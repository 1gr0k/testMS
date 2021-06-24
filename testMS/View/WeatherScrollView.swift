//
//  WeatherScrollView.swift
//  testMS
//
//  Created by Андрей Калямин on 23.06.2021.
//

import SwiftUI

struct WeatherScrollView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach((viewModel.weather.list)!, id: \.id) { hour in
                    let hourTime = viewModel.extractHour(date: hour.date!)
                    if hourTime == "1" {
                        VStack{
                            Text("🌅")
                                .font(.system(size: CGFloat(45)))
                        }
                    }
                    VStack{
                        Text("\(hourTime)")
                        Text("\(viewModel.getWeatherIcon(desc: hour.weather?.first?.description ?? "error"))")
                        Text("\(Int(hour.main?.temp ?? 0.0))ºC")
                    }
                }
            }
        }
    }
}
