//
//  renameViewController.swift
//  New App
//
//  Created by Saman on 19/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

protocol RenameDelegate: class {
    func didRename(newName: String)
}

class RenameViewController: UIViewController {

    weak var renameDelegate: RenameDelegate?
    var passedOnName: String!
    
    @IBOutlet var renameTextfield: UITextField!
    
    @IBAction func doneButton(_ sender: Any) {
        renameDelegate?.didRename(newName: renameTextfield.text ?? passedOnName)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renameTextfield.text = passedOnName
        renameTextfield.becomeFirstResponder()
    }
}

extension RenameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        renameTextfield.resignFirstResponder()
        return false
    }
}
