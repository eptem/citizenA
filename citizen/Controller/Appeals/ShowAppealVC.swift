//
//  ShowAppealVC.swift
//  citizen
//
//  Created by Артем Жорницкий on 22/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class ShowAppealVC : UIViewController {
    
    var imgArray = ["dvor", "les", "car", "vibros", "gorod", "road", "svet", "reklama", "trash"]
    let newTypes = [ "Неухоженный двор", "Мусор в лесу", "Брошеная машина", "Выбросы в атмосферу", "Грязь на улице", "Яма на дороге", "Неисправное освещение", "Незаконная реклама", "Заполненная мусорка"]
    
    var appeals : Results<Appeal>!
    
    let realm  = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        appeals = realm.objects(Appeal.self)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        appeals = realm.objects(Appeal.self)
        tableView.reloadData()
    }
}

extension ShowAppealVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appeals.count == 0 {
            return 1
        }
        else {
            return appeals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myCell
        if appeals.count == 0 {
            cell.typeLabel.text = "Запишите первое обращение"
            cell.imageView?.isHidden = true
            cell.dateLabel.isHidden = true
        }
        else {
            cell.imageView?.isHidden = false
            cell.dateLabel.isHidden = false
            var type = appeals[indexPath.row].type
            cell.typeLabel.text = newTypes[Int(type)!]
            cell.img.image = UIImage(named: imgArray[Int(type)!])
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm   dd.MM.yy"
            cell.dateLabel.text = "Отправлено в \(formatter.string(from: (appeals[indexPath.row].dateCreated!)))"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let vc =  AppealViewController.instance() as! AppealViewController
        vc.texLabel.text = appeals[indexPath.row].message
        present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

