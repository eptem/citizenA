//
//  ChooseTypeVC.swift
//  citizen
//
//  Created by Артем Жорницкий on 22/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit

class ChooseTypeVC : UIViewController {
    
    var currentType = 0
    
    var typeArray = ["type 0", "type 1", "type 2", "type 3", "type 4", "type 5", "type 6","type 7","type 8"]
    @IBOutlet var buttons : [UIButton]!
    
    @IBAction func typeTapped(_ sender: UIButton) {
        print("ZDAROVA")
        currentType = sender.tag
        performSegue(withIdentifier: "goToAdd", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToAdd"){
            let displayVC = segue.destination as! AddAppealViewController
            displayVC.appealType = currentType
        }
    }
    
    func setupButtons() {
        for index in 0...buttons.count - 1 {
            buttons[index].layer.borderWidth = 1
            buttons[index].layer.borderColor = UIColor.lightGray.cgColor
        }
    }

}
