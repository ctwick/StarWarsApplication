//
//  PlanetRepository.swift
//  swapp
//
//  Created by Chamini Wickramanayake on 2022-07-05.
//

import Foundation
import SwiftUI
import RxSwift

protocol PlanetRepositoryProtocol {
    func getplanetObservable() -> BehaviorSubject<[Planet]>
    func fetchPlanets()
}

final class PlanetRepository: PlanetRepositoryProtocol {
    private let planetApiService: PlanetApiServiceProtocol
    
    init(planetApiService: PlanetApiServiceProtocol = PlanetApiService()) {
        self.planetApiService = planetApiService
    }
    
    private let planetObservable = BehaviorSubject<[Planet]>(value: [])
        
    func getplanetObservable() -> BehaviorSubject<[Planet]>{
        return planetObservable
    }
    
    func fetchPlanets() {
        self.planetApiService.fetchPlanets(completion: { (planets) in
            self.planetObservable.onNext(planets)
        })
                
    }
}
