//
//  PlanetListView.swift
//  swapp
//
//  Created by Chamini Wickramanayake on 2022-07-05.
//

import Foundation
import SwiftUI
import RxSwift

struct PlanetRow: View {
    var planet: Planet
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://picsum.photos/100")) { image in
                image.resizable()
            } placeholder: {
                Color.clear
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            VStack(alignment: .leading) {
                Text("\(planet.name)")
                    .fontWeight(.bold)
                Text("\(planet.climate)")
            }
        }
    }
}

struct PlanetListView: View {
    
    @ObservedObject var planetList = ObservableArray<Planet>(array: [])

    let planetViewModel = PlanetViewModel()

    init() {
        self.planetViewModel.viewUpdate = self
    }
    
    var body: some View {
        NavigationView {
            List (self.planetList.array.enumerated().map({ $0 }), id: \.1.self.id) { (index, planet) in
                NavigationLink(destination: PlanetDetailView(planet: planet)) {
                    PlanetRow(planet: planet).onAppear(perform: {
                        let count = self.planetList.array.count
                        print("index: \(index) count: \(count)")
                        if index == count-3 {
                          self.planetViewModel.fetchPlanets(currentListSize: count)
                        }
                    })
                }
            }
            .navigationTitle("Planet List")
            .onAppear(perform: planetViewModel.onAppear)
        }
        .navigationViewStyle(.stack)
    }
}

extension PlanetListView: PlanetViewUpdateProtocol{
    func appendData(list: [Planet]?) {
        self.planetList.array.append(contentsOf: list!)
    }
}

protocol PlanetViewUpdateProtocol{
    func appendData(list: [Planet]?)
}

struct PlanetListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListView()
    }
}
