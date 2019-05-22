//
//  OptionsViewController.swift
//  citizen
//
//  Created by Артем Жорницкий on 22/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class OptionsViewController : UIViewController {
    
    var winAlert: UIAlertController!
    var yes: UIAlertAction!
    var no: UIAlertAction!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func changeUserTapped(_ sender: Any) {
        createAlert()
        present(winAlert, animated: true)
    }
    
    func createAlert() {
        winAlert = UIAlertController(title: "Выход", message: "Вы точно хотите выйти из аккаунта?", preferredStyle: .alert)
        yes = UIAlertAction(title: "Да", style: .default) { _ in self.logOut() }
        no = UIAlertAction(title: "Нет", style: .default) { _ in self.noLogOut() }
        winAlert.addAction(yes)
        winAlert.addAction(no)
    }
    
    func logOut() {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func noLogOut() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func goHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "home")
        let navigationController = UINavigationController(rootViewController: initialViewController)
        present(navigationController, animated: true, completion: nil)
    }
}
