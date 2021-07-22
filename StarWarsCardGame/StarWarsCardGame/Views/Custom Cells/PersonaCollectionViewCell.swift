//
//  PersonaCollectionViewCell.swift
//  StarWarsCardGame
//
//  Created by Benjamin Tincher on 7/22/21.
//

import UIKit

class PersonaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var personaImageView: UIImageView!
    
    func displayImageFor(persona: Persona) {
        personaImageView.image = persona.photo
        personaImageView.contentMode = .scaleAspectFill
    }
}
