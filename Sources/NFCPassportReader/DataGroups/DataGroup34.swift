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
    public private(set) var requiredData: Data!
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
        var (len, lenOffset) = try asn1Length([UInt8](data[pos...pos]))
        pos += lenOffset
        self.requiredData = Data(data[(pos-lenOffset-1) ..< pos+len])

        // reading all data and moving position
        let dataBlock = [UInt8](data[pos ..< pos+len])
        pos += len

        // checking if first byte in data is rnokpp tag
        var internalPos = 0
        guard dataBlock.count > 0, dataBlock[internalPos] == 0x81 else {
            return
        }
        internalPos += 1

        // next byte is the data length, we should read it and move position
        (len, lenOffset) = try asn1Length([UInt8](dataBlock[internalPos...internalPos]))
        internalPos += lenOffset

        // reading rnokpp
        rnokppData = Data(dataBlock[internalPos ..< internalPos+len])

        let signatureData = Data(data[pos...])
        var signaturePos = 0
        guard signatureData.count > 0, signatureData[signaturePos] == 0x30 else {
            return
        }
        signaturePos += 1
        (len, lenOffset) = try asn1Length([UInt8](signatureData[signaturePos...signaturePos]))

        // skiping data that we don't need
        signaturePos += lenOffset + len

        // found the signature
        guard signatureData[signaturePos] == 0x03 else {
            return
        }
        signaturePos += 1

        // setting data for server
        (len, lenOffset) = try asn1Length([UInt8](signatureData[signaturePos...signaturePos]))
        signaturePos += lenOffset
        signature = signatureData[signaturePos+1 ..< signaturePos+len]
    }
}
