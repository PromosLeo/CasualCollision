//
//  JSONParser.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 03.02.21.
//

import Foundation

protocol JsonDecodeDelegate: class {
    func decoded<T: Decodable>(data: [T]?)
    func startDecode()
}

class JSONDecode {
    weak var delegate: JsonDecodeDelegate!
    var data: Data! {
        didSet {
            delegate.startDecode()
        }
    }
    func decode<T: Decodable>(type: T.Type) {
        do {
            // make sure this JSON is in the format we expect
            let decoder = JSONDecoder()
            if let data = data {
                let decoded = try decoder.decode([T].self, from: data)
                delegate.decoded(data: decoded)
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}
