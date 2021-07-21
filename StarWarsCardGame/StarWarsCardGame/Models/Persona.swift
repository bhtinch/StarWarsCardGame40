//
//  Personas.swift
//  StarWarsCardGame
//
//  Created by Benjamin Tincher on 7/21/21.
//

import Foundation
import UIKit

class Persona {
    let name: String
    let photo: UIImage?
    let faction: String
    
    init(name: String, photo: UIImage?, faction: String) {
        self.name = name
        self.photo = photo
        self.faction = faction
    }
}
