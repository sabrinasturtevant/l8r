//
//  ViewController.swift
//  l8r
//
//  Created by Sabrina Sturtevant on 2/10/20.
//  Copyright © 2020 Sabrina Sturtevant. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate, CNContactPickerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func textButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "textButtonSegue", sender: nil)
    }
    
    @IBAction func pictureButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "pictureButtonSegue", sender: nil)
    }
    
    
    @IBAction func videoButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "videoButtonSegue", sender: nil)
    }
    
    @IBAction func textBackTapped(_ sender: Any) {
        performSegue(withIdentifier: "textBackButtonSegue", sender: nil)
    }
    
    @IBAction func pictureBackTapped(_ sender: Any) {
        performSegue(withIdentifier: "pictureBackButtonSegue", sender: nil)
    }
    
    @IBAction func videoBackTapped(_ sender: Any) {
        performSegue(withIdentifier: "videoBackButtonSegue", sender: nil)
    }
    
    
    //////////////texting screen
    @IBOutlet weak var sendToLabelOutlet: UILabel!
    
    @IBOutlet weak var messageFieldOutlet: UITextField!
    
    
    @IBAction func sendToPlusTapped(_ sender: Any) {
        let contacVC = CNContactPickerViewController()
        contacVC.delegate = self
        self.present(contacVC, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            print(contact.phoneNumbers)
            print(contact.givenName)
            let numbers = contact.phoneNumbers //.first
    //        print((numbers?.value)?.stringValue ?? "")
            print(numbers)

    //        self.lblNumber.text = " Contact No. \((numbers?.value)?.stringValue ?? "")"
        
        sendToLabelOutlet.text = contact.givenName
              
        }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    
    
    
    
}

