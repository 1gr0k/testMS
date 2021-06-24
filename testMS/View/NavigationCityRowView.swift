//
//  NavigationCityRowView.swift
//  testMS
//
//  Created by Андрей Калямин on 21.06.2021.
//

import SwiftUI

struct NavigationCityRowView: View {
    
    @ObservedObject var model: WeatherViewModel
    
    var body: some View {
        HStack{
            Text(model.weather.city?.name ?? "--")
                .font(.subheadline).bold()
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            Text("\(Int(model.weather.list?.first?.main?.temp ?? 0.0))")
                .foregroundColor(.white)
                .padding(.horizontal, 16)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.gray)
        .cornerRadius(12)
    }
}

struct NavigationCityRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationCityRowView(model: WeatherViewModel(for: "Moscow"))
    }
}
