//
//  DailyWeatherView.swift
//  testMS
//
//  Created by Андрей Калямин on 24.06.2021.
//

import SwiftUI

struct DailyWeatherView: View {
    
    @State var day: String
    @State var temp: Double
    
    var body: some View {
        HStack{
            Text(day)
            Spacer()
            Text("\(Int(temp))ºC")
        }
    }
}

//struct DailyWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyWeatherView()
//    }
//}
