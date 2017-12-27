//
//  CloudController.swift
//  ToDoListApp
//
//  Created by Sheeja  on 11/2/17.
//  Copyright © 2017 Khaleesi. All rights reserved.
//

import Foundation

// Class to implement the logic for reading/ writing data to the Cloud at the lists or a certain list level.
class CloudController: NSObject {
    
    // MARK: - Read operations
    
    // Read user data.
//    static func readUser(_ completion: @escaping (User?) -> ()) {
//        return FirebaseController.readUser(completion)
//    }
    
    // Read all lists from the Cloud.
//    static func readListsFromCloud(_ completion: @escaping ([List]?) -> ()) {
//        FirebaseController.readListsFromFirebase(completion)
//    }
    
    // Read a specific list from the Cloud.
//    static func readListFromCloud(_ index: Int, completion: @escaping (List?) -> ()) {
//        FirebaseController.readListFromFirebase(index, completion: completion)
//    }
    
    // MARK: - Write operations
    
    // Write user data.
    static func writeUser(user: UserInfo, completion: @escaping (Bool) -> ()) {
        FirebaseController.writeUser(user, completion: completion)
    }
    
    // Write all lists to the Cloud.
//    static func writeListsToCloud(_ lists: [List]) {
//        FirebaseController.writeListsToFirebase(lists)
//    }
    
    // Write a specific list at a given index to the Cloud.
//    static func writeListToCloud(_ list: List, index: Int) {
//        FirebaseController.writeListToFirebase(list, index: index)
//    }
}

