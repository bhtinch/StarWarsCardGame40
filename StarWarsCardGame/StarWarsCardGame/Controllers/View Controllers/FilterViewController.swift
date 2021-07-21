//
//  FilterViewController.swift
//  StarWarsCardGame
//
//  Created by Benjamin Tincher on 7/21/21.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func setFaction(isJedi: Bool)
}

class FilterViewController: UIViewController {
    
    //  MARK: - PROPERTIES
    weak var delegate: FilterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //  MARK: - ACTIONS
    @IBAction func jediButtonTapped(_ sender: Any) {
        delegate?.setFaction(isJedi: true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sithButtonTapped(_ sender: Any) {
        delegate?.setFaction(isJedi: false)
        navigationController?.popViewController(animated: true)
    }
    
}
