//
//  LocalFileManger.swift
//  Crypto
//
//  Created by Kareem on 24/08/2026.
//

import Foundation
import SwiftUI

class LocalFileManger {
    static let instance = LocalFileManger()
    private init() { }
    
    func saveImage(image: UIImage,imageName: String,folderName: String) {
        
        // create folder
        createFolder(folderName: folderName)
        
        // get path for image
        guard
            let data = image.pngData(),
            let url = getURLImage(imageName: imageName, folderName: folderName)
        else { return }
        
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("error saving image. \(error) imageName: \(image)")
        }
        
    }
    
    func getImage(imageName: String,folderName: String) -> UIImage? {
        
        guard
            let url = getURLImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path()) else {
                return nil
            }
        return UIImage(contentsOfFile: url.path())
    }
    
    private func createFolder(folderName: String) {
        guard let url = getURLFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("error creating directory. \(error). folderName: \(folderName)")
            }
            
        }
    }
    
    private func getURLFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
        
    }
    
    private func getURLImage(imageName: String,folderName: String) -> URL? {
        guard let folderName = getURLFolder(folderName: folderName) else {
            return nil
        }
        return folderName.appendingPathComponent(imageName + "png")
    }
}
