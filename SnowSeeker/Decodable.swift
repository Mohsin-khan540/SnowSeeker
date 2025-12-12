//
//  Decodable.swift
//  SnowSeeker
//
//  Created by Mohsin khan on 08/12/2025.
//

import Foundation

extension Bundle{
    
    func decode<T : Decodable>(_ file : String)->T{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("File to locate \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("File to load \(file) from bundle")
        }
        let decoder = JSONDecoder()
        do{
            return try decoder.decode(T.self, from: data)
        }catch DecodingError.keyNotFound(let key, let context){
            fatalError("fail to decode \(file) from bundle due to missing key \(key.stringValue)-\(context.debugDescription) ")
        }catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let value, let context){
            fatalError("fail to decode \(file) from bundle due to missing \(value) type \(context.debugDescription)")
        }catch DecodingError.dataCorrupted(_){
            fatalError("fail to decode \(file) from bundle becaude its appear to be invalid json")
        }catch{
            fatalError("fail to decode file from bundle due to \(error.localizedDescription)")
        }
    }
    
}
