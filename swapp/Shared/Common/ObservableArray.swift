//
//  ObservableArray.swift
//  swapp
//
//  Created by Chamini Wickramanayake on 2022-07-07.
//

import Foundation
import Combine

class ObservableArray<T>: ObservableObject {
    
    var cancellables = [AnyCancellable]()
    
    @Published var array:[T] = []
    
    init(array: [T])  {
        self.array = array
        
    }
    
    func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
        let array2 = array as! [T]
        array2.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })

            // Important: You have to keep the returned value allocated,
            // otherwise the sink subscription gets cancelled
            self.cancellables.append(c)
        })
        return self as! ObservableArray<T>
    }
}
