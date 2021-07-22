//
//  CardsCollectionViewController.swift
//  StarWarsCardGame
//
//  Created by Benjamin Tincher on 7/22/21.
//

import UIKit

class CardsCollectionViewController: UICollectionViewController {
    
    //  MARK: - PROPERTIES
    var personaCards: [Persona] = []
    var factionIsJedi: Bool = true
    var targetPersona: Persona?

    //  MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCards()
        updateView()
    }
    
    //  MARK: - METHODS
    func shuffleCards() {
        //  grab 3 of one faction and 1 of the other (random)
        //  append those to personaCards
        //  set the targetPersona
        
        personaCards = []
        
        var targetFaction: [Persona] = []
        var offTargetPersona: Persona?
        
        if factionIsJedi {
            targetFaction = Array(PersonaController.jedi.shuffled().prefix(3))
            offTargetPersona = PersonaController.sith.randomElement()
        } else {
            targetFaction = Array(PersonaController.sith.shuffled().prefix(3))
            offTargetPersona = PersonaController.jedi.randomElement()
        }
        
        personaCards.append(contentsOf: targetFaction)
        
        targetPersona = personaCards.randomElement()
        
        if let offTargetPersona = offTargetPersona {
            personaCards.append(offTargetPersona)
        }
        
        personaCards.shuffle()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personaCell", for: indexPath) as? PersonaCollectionViewCell else { return UICollectionViewCell() }
        
        let persona = personaCards[indexPath.row]
        
        cell.displayImageFor(persona: persona)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //  check whether selected persona in this cell == targetPersona
        let selectedPersona = personaCards[indexPath.row]
        
        let isCorrect = selectedPersona == targetPersona
        
        presentResultAlert(isCorrect: isCorrect)
    }
}   //  End of Class

//  MARK: - COLLECTION VIEW FLOW LAYOUT DELEGATE METHODS
extension CardsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width * 0.45
        
        return CGSize(width: width, height: width * 4 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let oneCellWidth = view.frame.width * 0.45
        
        let cellsTotalWidth = oneCellWidth * 2
        
        let leftoverWidth = view.frame.width - cellsTotalWidth
        
        //  same as leftoverWidth = view.frame.width * 0.1
        
        let inset = leftoverWidth / 3
        
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
}

//  MARK: - ALERTS
extension CardsCollectionViewController {
    func presentResultAlert(isCorrect: Bool) {
        var title: String = ""
        
        if isCorrect {
            title = "Hooray! Good Job!"
        } else {
            title = "Booooooooooo."
        }
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done", style: .default)
        
        let shuffeAction = UIAlertAction(title: "Shuffle!", style: .default) { _ in
            self.shuffleCards()
            self.updateView()
        }
        
        if isCorrect {
            alert.addAction(shuffeAction)
        } else {
            alert.addAction(doneAction)
        }
        
        present(alert, animated: true)
    }
}

//  MARK: - filter view controller delegate methods
extension CardsCollectionViewController: FilterViewControllerDelegate {
    func updateFaction(isJedi: Bool) {
        factionIsJedi = isJedi
        shuffleCards()
        updateView()
    }
}

//  MARK: - NAVIGATION
extension CardsCollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilterVC" {
            let destination = segue.destination as? FilterViewController
            destination?.delegate = self
        }
    }
}
