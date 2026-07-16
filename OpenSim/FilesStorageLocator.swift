//
//  FilesStorageLocator.swift
//  OpenSim
//
//  Created by Erfan on 16/07/2026.
//  Copyright © 2026 Luo Sheng. All rights reserved.
//

import Foundation

struct FilesStorageLocator {

    private let fileManager: FileManager

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }

    func storageURL(for device: Device) -> URL? {
        let appGroupsURL = URLHelper.deviceURLForUDID(device.UDID)
            .appendingPathComponent("data/Containers/Shared/AppGroup", isDirectory: true)
        guard let appGroupURLs = try? fileManager.contentsOfDirectory(
            at: appGroupsURL,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsSubdirectoryDescendants]
        ) else {
            return nil
        }

        for appGroupURL in appGroupURLs {
            let metadataURL = appGroupURL
                .appendingPathComponent(".com.apple.mobile_container_manager.metadata.plist")
            guard let metadataData = try? Data(contentsOf: metadataURL),
                let propertyList = try? PropertyListSerialization.propertyList(
                    from: metadataData,
                    options: [],
                    format: nil
                ),
                let metadata = propertyList as? [String: Any],
                metadata["MCMMetadataIdentifier"] as? String
                    == "group.com.apple.FileProvider.LocalStorage" else {
                continue
            }

            let storageURL = appGroupURL
                .appendingPathComponent("File Provider Storage", isDirectory: true)
            var isDirectory: ObjCBool = false
            guard fileManager.fileExists(atPath: storageURL.path, isDirectory: &isDirectory),
                isDirectory.boolValue else {
                return nil
            }

            return storageURL
        }

        return nil
    }
}
