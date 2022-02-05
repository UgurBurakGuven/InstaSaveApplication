//
//  RealmData.swift
//  InstaSaveApplication
//
//  Created by Uğur burak Güven on 2.02.2022.
//

import Foundation
import RealmSwift

class UserData : Object, Identifiable {
    @objc dynamic var id : String?
    @objc dynamic var image : NSData?
    @objc dynamic var name : String?
    @objc dynamic var caption : String?
    @objc dynamic var date : String?
}
