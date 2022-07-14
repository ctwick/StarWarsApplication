//
//  PlanetService.swift
//  swapp
//
//  Created by Chamini Wickramanayake on 2022-07-05.
//

import Foundation
import SwiftUI
import RxSwift
import RxAlamofire

protocol PlanetApiServiceProtocol {
    func fetchPlanets(completion: @escaping (Array<Planet>) -> Void)
}

final class PlanetApiService: PlanetApiServiceProtocol {
    static let pageSize = 10
    
    private let disposeBag = DisposeBag()
    
    private let starWarsApiStub: StarWarsApiStub
    
    private var pageCount = 1
    
    init(starWarsApiStub: StarWarsApiStub = StarWarsApiStub()) {
        self.starWarsApiStub = starWarsApiStub
    }
    
    func fetchPlanets(completion: @escaping (Array<Planet>) -> Void) {
        if (pageCount == -1) {
            return
        }
        let url = URL(string: self.starWarsApiStub.getPlanetApiPathForPage(pageNumber: self.pageCount))
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
              print("Error with fetching films: \(error)")
              return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(String(describing: response))")
              return
            }

            if let data = data, let planets = try? JSONDecoder().decode(Planets.self, from: data) {
                if (self.pageCount * PlanetApiService.pageSize >= planets.count) {
                    self.pageCount = -1
                } else {
                    self.pageCount+=1
                }
                completion(.init(planets.all))
            }
        })
        task.resume()
        
//        completion(.init([
//            Planet(name: "Tatooine", climate: "Arid", orbitalPeriod: "304", gravity: "1", diameter: "10465", population: "120000", rotationPeriod: "23", surfaceWater: "1", terrain: "Dessert", films: ["https://swapi.dev/api/films/1/"], residents: ["https://swapi.dev/api/people/1/"], url: "https://swapi.dev/api/planets/1/", created: "2014-12-09T13:50:49.641000Z", edited: "2014-12-15T13:48:16.167217Z"),
//            Planet(name: "Alderaan", climate: "temperate", orbitalPeriod: "364", gravity: "1 standard", diameter: "12500", population: "2000000000", rotationPeriod: "24", surfaceWater: "40", terrain: "grasslands, mountains", films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/6/"], residents: ["https://swapi.dev/api/people/5/", "https://swapi.dev/api/people/68/", "https://swapi.dev/api/people/81/"], url: "https://swapi.dev/api/planets/2/", created: "2014-12-10T11:35:48.479000Z", edited: "2014-12-20T20:58:18.420000Z"),
//            Planet(name: "Yavin IV", climate: "temperate, tropical", orbitalPeriod: "4818", gravity: "1 standard", diameter: "10200", population: "1000", rotationPeriod: "24", surfaceWater: "8", terrain: "jungle, rainforests", films: ["https://swapi.dev/api/films/1/"], residents: [], url: "https://swapi.dev/api/planets/3/", created: "2014-12-10T11:37:19.144000Z", edited: "2014-12-20T20:58:18.421000Z")
//        ]))
    }
}
