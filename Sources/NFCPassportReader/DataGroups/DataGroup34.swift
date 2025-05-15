//
//  DataGroup34.swift
//  NFCPassportReader
//
//  Created by Volodymyr Kotsiubenko on 13/5/25.
//

import Foundation

public class DataGroup34: DataGroup {
    public var rnokpp: String? {
        guard !rnokppData.isEmpty else { return nil }
        return rnokppData.map { String(UnicodeScalar($0)) }.joined()
    }

    public private(set) var signature: Data!
    public private(set) var rnokppData: Data!

    public override var datagroupType: DataGroupId { .DG34 }

    required init(_ data: [UInt8]) throws {
        try super.init(data)
    }

    override func parse(_ data: [UInt8]) throws {
        // Moving position to a correct one, first 2 bytes is a tag code, second 2 bytes is the data length
        pos = 4

        // validating that we have correct data tag
        guard try getNextTag() == 0x30 else {
            return
        }

        // next byte is the data length, we should read it and move position
        let (len, lenOffset) = try asn1Length([UInt8](data[pos...pos]))
        pos += lenOffset

        // reading all data and moving position
        let value = [UInt8](data[pos ..< pos+len])
        pos += len

        // checking if first byte in data is rnokpp tag
        var internalPos = 0
        guard value.count > 0, value[internalPos] == 0x81 else {
            return
        }
        internalPos += 1

        // next byte is the data length, we should read it and move position
        let (rnokppLen, rnokppLenOffset) = try asn1Length([UInt8](value[internalPos...internalPos]))
        internalPos += rnokppLenOffset

        // reading rnokpp
        rnokppData = Data(value[internalPos ..< internalPos+rnokppLen])
        signature = Data(data[pos...])
    }
}
