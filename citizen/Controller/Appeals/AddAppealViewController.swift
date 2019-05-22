//
//  AddAppeal.swift
//  citizen
//
//  Created by Артем Жорницкий on 06/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import RealmSwift

class AddAppealViewController : UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    let realm = try! Realm()
    
    let typeOfAppeal = ["type 1", "type 2", "type 3", "type 4", "type 5", "type 6"]
    let newTypes = [ "Неухоженный двор", "Мусор в лесу", "Брошеная машина", "Выбросы в атмосферу", "Грязь на улице", "Яма на дороге", "Неисправное освещение", "Незаконная реклама", "Заполненная мусорка"]
    var appealType : Int?
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var addButton: UIButton!
    

    @IBAction func addButtonTapped(_ sender: Any) {
        
        textView.endEditing(true)
        let appealDB = Database.database().reference().child("appeals")
        if let text = textView.text {
            let appeal = Appeal()
            fillAppeal(appeal : appeal)
//            appeal.message = text
//            appeal.sender = (Auth.auth().currentUser?.email)!
//            appeal.type = "\(appealType!)"
//            appeal.dateCreated = Date()
            try! realm.write {
                realm.add(appeal)
            }
            print(realm.objects(Appeal.self))
            let appealDictionary : [String:Any] = ["Sender" : Auth.auth().currentUser?.email,"text" : text, "type" : "\(appealType!)"]
            appealDB.childByAutoId().setValue(appealDictionary) {
                (error, reference) in
                
                if error != nil {
                    print(error!)
                }
                else {
                    print("uploaded")
                    self.addButton.titleLabel?.text = "gotovo"
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        //HideKeyobard()
    }
    
    func fillAppeal(appeal : Appeal) {
        appeal.message = textView.text
        appeal.sender = (Auth.auth().currentUser?.email)!
        appeal.type = "\(appealType!)"
        appeal.dateCreated = Date()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func HideKeyobard() {
        let Tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}

