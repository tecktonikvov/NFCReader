//
//  DataGroup34.swift
//  NFCPassportReader
//
//  Created by Volodymyr Kotsiubenko on 13/5/25.
//


public class DataGroup34: DataGroup {
    public private(set) var rnokpp: String?

    public override var datagroupType: DataGroupId { .DG34 }

    required init(_ data: [UInt8]) throws {
        try super.init(data)
    }

    override func parse(_ data: [UInt8]) throws {
        //guard data.count > 8 else { return }

        let payload = Array(data[8...])
        var digits = ""
        var all = ""

        //for byte in payload {
            for byte in data {
            all.append(String(UnicodeScalar(byte)))

            //if byte == 0x40 { break } // Stop when @ detected
            if byte >= 0x30 && byte <= 0x39 { // Only digits 0-9
                digits.append(String(UnicodeScalar(byte)))
            }
        }

        if digits.count == 10 {
            rnokpp = digits
        }
    }
}