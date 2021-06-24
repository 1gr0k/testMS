//
//  ContentView.swift
//  testMS
//
//  Created by Андрей Калямин on 21.06.2021.
//

import SwiftUI

//var citiesT = ["Moscow", "Ulyanovsk","Samara", "Penza"]

struct ContentView: View {
    
    @State var citiesT: [String] = UserDefaults.standard.object(forKey: "cities") as? [String] ?? []
    @State private var newCity = ""
    @State var isEditing = false
    @State var adding = false
    @State var wrongCity = false
    
    var body: some View {
        NavigationView {
            List(){
                if adding {
                    TextField("enter new city", text: $newCity)
                }
                
                ForEach(citiesT, id: \.self) { city in
                    
                    if isEditing {
                        Text("\(city)")
                    } else {
                        
                        ZStack {
                            
                            let model = WeatherViewModel(for: city)
                            
                            NavigationCityRowView(model: model)
                            NavigationLink {
                                FullCityView(viewModel: model)
                            } label: {
                                EmptyView()
                            }
                            .onAppear {
                                async {
                                    await model.refresh()
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: removeRows)
                .onMove(perform: move)
                .listRowSeparator(.hidden)
                
            }
            .listStyle(.sidebar)
            
            
            .navigationBarItems(leading: addButton, trailing: Button(action: {
                if !adding{
                    self.isEditing.toggle()
                } else {
                    self.isEditing.toggle()
                    self.adding.toggle()
                    self.newCity = ""
                }
            }) {
                Text(!isEditing ? "edit" : !adding ? "done" : "cancel")
                    .frame(width: 80, height: 40)
            })
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            .animation(.spring(), value: isEditing)
            
            
        }
        .onAppear{
            if citiesT.isEmpty {
                firstStep()
            }
        }
        
    }
    
    func removeRows(at offsets: IndexSet) {
        citiesT.remove(atOffsets: offsets)
        UserDefaults.standard.set(citiesT, forKey: "cities")
        if citiesT.isEmpty {
            firstStep()
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        citiesT.move(fromOffsets: source, toOffset: destination)
        UserDefaults.standard.set(citiesT, forKey: "cities")
    }
    
    private var addButton: some View {
        if isEditing {
            return AnyView(
                Button(action: onAdd) { Image(systemName: !adding ? "plus" : "checkmark") }
                    .alert(isPresented: $wrongCity, content: {
                Alert(title: Text("Некорректное название города"))
            })
            )
        } else {
            return AnyView(EmptyView())
        }
    }
    
    func onAdd() {
        if !adding {
            adding.toggle()
        } else {
            if !newCity.isEmpty{
                async{
                do{
                    let test = try await WeatherAPI.shared.fetchWeather(for: newCity)
                    if test.city != nil {
                        citiesT.append(newCity)
                        UserDefaults.standard.set(citiesT, forKey: "cities")
                        newCity = ""
                        adding.toggle()
                        isEditing.toggle()
                    } else {
                        newCity = ""
                        wrongCity.toggle()
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                }
                
            }
        }
        
    }
    
    func firstStep() {
        isEditing = true
        adding = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
