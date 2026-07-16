//
//  RevealFilesStorageInFinderMenuItem.swift
//  OpenSim
//
//  Created by Erfan on 16/07/2026.
//  Copyright © 2026 Luo Sheng. All rights reserved.
//

import Cocoa

final class RevealFilesStorageInFinderMenuItem: NSMenuItem {

    private let storageURL: URL?

    init(device: Device) {
        storageURL = FilesStorageLocator().storageURL(for: device)

        super.init(
            title: UIConstants.strings.actionRevealFilesStorageInFinder,
            action: #selector(revealFilesStorage(_:)),
            keyEquivalent: ""
        )

        target = self
        image = templatize(#imageLiteral(resourceName: "reveal"))
        isEnabled = storageURL != nil
    }

    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func revealFilesStorage(_ sender: AnyObject) {
        if let storageURL = storageURL {
            NSWorkspace.shared.open(storageURL)
        }
    }
}
