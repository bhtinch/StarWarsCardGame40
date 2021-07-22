//
//  FilterViewController.swift
//  StarWarsCardGame
//
//  Created by Benjamin Tincher on 7/22/21.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func updateFaction(isJedi: Bool)
}

class FilterViewController: UIViewController {
    
    //  MARK: - PROPERTIES
    weak var delegate: FilterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //  MARK: - ACTIONS
    @IBAction func sithButtonTapped(_ sender: Any) {
        delegate?.updateFaction(isJedi: false)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func jediButtonTapped(_ sender: Any) {
        delegate?.updateFaction(isJedi: true)
        dismiss(animated: true, completion: nil)
    }
}
