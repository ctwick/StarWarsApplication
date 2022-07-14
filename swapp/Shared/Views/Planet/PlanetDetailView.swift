//
//  PlanetDetailView.swift
//  swapp
//
//  Created by Chamini Wickramanayake on 2022-07-05.
//

import Foundation
import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet
    
    var body: some View {
        VStack {
            Text("Name: \(planet.name)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Orbital Period: \(planet.orbitalPeriod)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Gravity: \(planet.gravity)")
                .frame(maxWidth: .infinity, alignment: .leading)
            AsyncImage(url: URL(string: "https://picsum.photos/150")) { image in
                image.resizable()
            } placeholder: {
                Color.clear
            }
            .frame(width: 150, height: 150, alignment: .leading)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            Spacer()
        }
        .padding(20)
        .navigationTitle("\(planet.name)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(.stack)
    }
}

struct PlanetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetDetailView(planet: Planet(name: "Tatooine", climate: "Arid", orbitalPeriod: "304", gravity: "1", diameter: "10465", population: "120000", rotationPeriod: "23", surfaceWater: "1", terrain: "Dessert", films: ["https://swapi.dev/api/films/1/"], residents: ["https://swapi.dev/api/people/1/"], url: "https://swapi.dev/api/planets/1/", created: "2014-12-09T13:50:49.641000Z", edited: "2014-12-15T13:48:16.167217Z"))
    }
}
