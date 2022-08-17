//
//  ViewController.swift
//  CustomDropDown
//
//  Created by Duy Tran on 17/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lastName: DropDown!
    @IBOutlet weak var firstName: DropDown!
    var newdd: DropDown!
    let arrItem : [String] = ["Vietnam", "Thai", "China", "Hongkong", "Singapor"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newdd = DropDown()
        newdd.setupDropDown(inputTitle: "Country", isRequired: false, isDropDown: true, option: arrItem)
        view.addSubview(newdd)
        
        newdd.translatesAutoresizingMaskIntoConstraints = false
        newdd.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        newdd.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        newdd.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        newdd.heightAnchor.constraint(equalToConstant: 59).isActive = true
        
        firstName.setupDropDown(inputTitle: "Họ", isRequired: true, isDropDown: false, option: [""])
        lastName.setupDropDown(inputTitle: "Tên đệm và tên", isRequired: true, isDropDown: false, option: [""])
    }
    
}

