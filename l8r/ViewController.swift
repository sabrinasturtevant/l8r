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
    
    var phoneNumber = [""]
    var messageText = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
    
    @IBAction func messageFieldAction(_ sender: Any) {

    }
    
    @IBAction func sendToPlusTapped(_ sender: Any) {
        let contacVC = CNContactPickerViewController()
        contacVC.delegate = self
        self.present(contacVC, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            print(contact.phoneNumbers)
            print(contact.givenName)
            let numbers = contact.phoneNumbers.first
        print((numbers?.value)?.stringValue ?? "")

        phoneNumber.append((numbers?.value)?.stringValue ?? "")
        

    //        self.lblNumber.text = " Contact No. \((numbers?.value)?.stringValue ?? "")"
        
        sendToLabelOutlet.text = contact.givenName
              
        }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayMessageInterface() {
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = phoneNumber
        composeVC.body = messageFieldOutlet.text
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }

    
    @IBAction func sendButtonTapped(_ sender: Any) {
        displayMessageInterface()
    }
    
}

