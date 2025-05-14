//
//  Logger.swift
//  NFCPassportReader
//
//  Created by Volodymyr Kotsiubenko on 14/5/25.
//

import Foundation

final class Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    private let category: String

    private init(subsystem: String, category: String) {
        self.category = category
    }

    func error(_ message: String) {
        print(message)
    }

    func info(_ message: String) {
        print(message)
    }

    func warning(_ message: String) {
        print(message)
    }

    func debug(_ message: String) {
        print(message)
    }

    /// Tag Reader logs
    static let passportReader = Logger(subsystem: subsystem, category: "passportReader")

    /// Tag Reader logs
    static let tagReader = Logger(subsystem: subsystem, category: "tagReader")

    /// SecureMessaging logs
    static let secureMessaging = Logger(subsystem: subsystem, category: "secureMessaging")

    static let openSSL = Logger(subsystem: subsystem, category: "openSSL")

    static let bac = Logger(subsystem: subsystem, category: "BAC")
    static let chipAuth = Logger(subsystem: subsystem, category: "chipAuthentication")
    static let pace = Logger(subsystem: subsystem, category: "PACE")
}
