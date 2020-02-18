//
//  ViewController.swift
//  l8r
//
//  Created by Sabrina Sturtevant on 2/10/20.
//  Copyright © 2020 Sabrina Sturtevant. All rights reserved.
//

import UIKit
// 1
import Contacts

class ViewController: UIViewController {
    
     var contacts = [CNContact]()
    
    
    let store = CNContactStore()
    let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
    
    @IBOutlet var tableView: UITableView!
    


  override func viewDidLoad() {
    super.viewDidLoad()

    

    // 2
    if authorizationStatus == .notDetermined {
      // 3
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

  func retrieveContacts(from store: CNContactStore) {
    let containerId = store.defaultContainerIdentifier()
    let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
    // 4
    let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,
                       CNContactFamilyNameKey as CNKeyDescriptor,
                       CNContactImageDataAvailableKey as
                       CNKeyDescriptor,
                       CNContactImageDataKey as CNKeyDescriptor]

    contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }

    // 5
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

            // 4
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

