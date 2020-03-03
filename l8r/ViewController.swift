//
//  ViewController.swift
//  l8r
//
//  Created by Sabrina Sturtevant on 2/10/20.
//  Copyright © 2020 Sabrina Sturtevant. All rights reserved.
//


import UIKit
import MessageUI
import Contacts
import ContactsUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate, CNContactPickerDelegate {
    
    var contacts = [CNContact]()
    
    var contactName: [String] = []

     
     let store = CNContactStore()
     let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    }
    
    @IBAction func show(_ sender: Any) {
        let contacVC = CNContactPickerViewController()
        contacVC.delegate = self
        self.present(contacVC, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print(contact.phoneNumbers)
        print(contact.givenName)
        let numbers = contact.phoneNumbers //.first
//        print((numbers?.value)?.stringValue ?? "")
        
        
        contactName.append(contact.givenName)
        print(contactName)
        
//having a hard time getting the phone numbers as a string to put into the message view
//i think i wamt to take a break and start getting my exact buttons nd text fields in here
        
//        self.lblNumber.text = " Contact No. \((numbers?.value)?.stringValue ?? "")"
          
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = ["3142026521"]
        composeVC.body = "I love Swift!"
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }
    
    
    @IBAction func sendMessageButtonAction(_ sender: Any) {
        displayMessageInterface()
    }
    
    
}




/*
import UIKit
import Contacts

class ViewController: UIViewController {
    
    var contacts = [CNContact]()
    
    let store = CNContactStore()
    let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
    
    @IBOutlet var tableView: UITableView!
    


  override func viewDidLoad() {
    super.viewDidLoad()

    

    
    if authorizationStatus == .notDetermined {
      
      store.requestAccess(for: .contacts) { [weak self] didAuthorize,
      error in
        if didAuthorize {
            self?.retrieveContacts(from: self!.store)
        }
      }
    } else if authorizationStatus == .authorized {
        retrieveContacts(from: store)
    }
    tableView.delegate = self as? UITableViewDelegate
    tableView.dataSource = self as? UITableViewDataSource
  }
 
/////////cant really read this code. need help understanding
  func retrieveContacts(from store: CNContactStore) {
    let containerId = store.defaultContainerIdentifier()
    let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
    
    let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,
                       CNContactFamilyNameKey as CNKeyDescriptor,
                       CNContactImageDataAvailableKey as
                       CNKeyDescriptor,
                       CNContactImageDataKey as CNKeyDescriptor]

    contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }

    
    print(contacts)
  }
    
    @IBAction func contactsTapped(_ sender: Any) {
        retrieveContacts(from: store)
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contacts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as! ContactTableViewCell
            let contact = contacts[indexPath.row]

            cell.nameLabel.text = "\(contact.givenName) \(contact.familyName)"

            
            if contact.imageDataAvailable == true, let imageData = contact.imageData {
              cell.contactImage.image = UIImage(data: imageData)
            }

            return cell
        }
    }
    
    
}

/*
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as! ContactTableViewCell
        let contact = contacts[indexPath.row]

        cell.nameLabel.text = "\(contact.givenName) \(contact.familyName)"

        // 4
        if contact.imageDataAvailable == true, let imageData = contact.imageData {
          cell.contactImage.image = UIImage(data: imageData)
        }

        return cell
    }
    
  // extension implementation
}
extension ViewController: UITableViewDelegate {
  // extension implementation
}

 */
*/
