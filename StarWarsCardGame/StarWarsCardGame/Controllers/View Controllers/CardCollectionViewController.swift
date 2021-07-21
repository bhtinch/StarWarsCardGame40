//
//  CardCollectionViewController.swift
//  StarWarsCardGame
//
//  Created by Benjamin Tincher on 7/21/21.
//

import UIKit

class CardCollectionViewController: UICollectionViewController {
    
    //  MARK: - PROPERTIES
    var factionIsJedi = true
    var personaCards: [Persona] = []
    var targetPersona: Persona?

    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCards()
        updateView()
    }
    
    func shuffleCards() {
        // pass 4 personas into personaCards - 3 of one faction, 1 of the other
        // set target
        // shuffle cards
        personaCards = []
        
        var targetFactionCards: [Persona] = []
        var otherFactionPersona: Persona?
        
        if factionIsJedi {
            targetFactionCards = Array(PersonaController.jedi.shuffled().prefix(3))
            otherFactionPersona = PersonaController.sith.randomElement()
        } else {
            targetFactionCards = Array(PersonaController.sith.shuffled().prefix(3))
            otherFactionPersona = PersonaController.jedi.randomElement()
        }
        
        personaCards.append(contentsOf: targetFactionCards)
        
        targetPersona = personaCards.randomElement()
        
        if let otherPersona = otherFactionPersona { personaCards.append(otherPersona) }
    }
    
    func updateView() {
        title = "Find \(targetPersona?.name ?? "unknown")"
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? PersonaCardCollectionViewCell else { return UICollectionViewCell() }
        
        let persona = personaCards[indexPath.row]
        
        cell.displayImageFor(persona: persona)
                
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let persona = personaCards[indexPath.row]
        let isCorrect = persona == targetPersona
        presentResultAlert(isCorrect: isCorrect)
    }
}   //  End of Class

//  COLLECTION VIEW FLOW LAYOUT DELEGATE METHODS
extension CardCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width * 0.45
        return CGSize(width: width, height: width * 4 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = collectionView.frame.width * 0.1 / 3
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let width = collectionView.frame.width
        return width * 0.1 / 3
    }
}

//  MARK: - ALERT
extension CardCollectionViewController {
    func presentResultAlert(isCorrect: Bool) {
        var title = ""
        if isCorrect {
            title = "The force is strong with this one."
        } else {
            title = "So certain were you. Go back and closer you must look."
        }
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default)
        
        let shuffleAction = UIAlertAction(title: "Shuffle!", style: .default) { _ in
            self.shuffleCards()
            self.updateView()
        }
        
        if isCorrect {
            alert.addAction(shuffleAction)
        } else {
            alert.addAction(tryAgainAction)
        }
        
        present(alert, animated: true, completion: nil)
    }
}
