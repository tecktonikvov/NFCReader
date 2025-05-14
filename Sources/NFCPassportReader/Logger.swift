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
        print("[Error] \(Logger.subsystem), \(category): \(message)")
    }

    func info(_ message: String) {
        print("[Info] \(Logger.subsystem), \(category): \(message)")
    }

    func warning(_ message: String) {
        print("[Warning] \(Logger.subsystem), \(category): \(message)")
    }

    func debug(_ message: String) {
        print("[Debug] \(Logger.subsystem), \(category): \(message)")
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
