//
//  PersonaCardCollectionViewCell.swift
//  StarWarsCardGame
//
//  Created by Benjamin Tincher on 7/21/21.
//

import UIKit

class PersonaCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var personaImageView: UIImageView!
    
    func displayImageFor(persona: Persona) {
        personaImageView.image = persona.photo
        personaImageView.contentMode = .scaleAspectFill
    }
}
