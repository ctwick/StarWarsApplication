//
//  PlanetViewModel.swift
//  swapp
//
//  Created by Chamini Wickramanayake on 2022-07-05.
//

import Foundation
import RxSwift

final class PlanetViewModel: ObservableObject {

    private let planetRepository: PlanetRepositoryProtocol

    var viewUpdate: PlanetViewUpdateProtocol? = nil

    let disposeBag = DisposeBag()

    
    init(planetRepository: PlanetRepositoryProtocol = PlanetRepository()) {
        self.planetRepository = planetRepository
        
        self.planetRepository.getplanetObservable().subscribe({ [weak self] newList in
              self?.updateListItems(newList: newList.element)
            }
        ).disposed(by: disposeBag)
    }
    
    func onAppear() {
        self.planetRepository.fetchPlanets()
    }
    
    func fetchPlanets(currentListSize: Int){
        self.planetRepository.fetchPlanets()
    }
    
    func updateListItems(newList: [Planet]?){
        if (newList != nil && !newList!.isEmpty) {
            self.viewUpdate?.appendData(list: newList)
        }
    }
}
