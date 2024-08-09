//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by NJ Development on 01/06/24.
//

import Foundation
import SwiftUI

final class LocalFileManager {
    static let shared = LocalFileManager()
    private init() {}

    func saveImage(_ image: UIImage, imageName: String, folderName: String) {
        // create folder
        createFolderIfNeeded(folderName: folderName)

        // get path for image
        guard let data = image.pngData(),
              let url = getURLforImage(imageName: imageName, folderName: folderName)
        else { return }

        // save path to image
        do {
            try data.write(to: url)
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }

    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLforImage(imageName: imageName, folderName: folderName),
                FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }

    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLforFolder(folderName: folderName) else { return }

        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print("Error creating directory \(error.localizedDescription)")
            }
        }
    }

    private func getURLforFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }

    private func getURLforImage(imageName: String, folderName: String) -> URL? {
        guard let url = getURLforFolder(folderName: folderName) else {
            return nil
        }
        return url.appendingPathComponent(imageName + ".png")
    }
}
