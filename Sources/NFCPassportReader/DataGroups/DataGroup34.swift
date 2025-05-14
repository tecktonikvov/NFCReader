//
//  DataGroup34.swift
//  NFCPassportReader
//
//  Created by Volodymyr Kotsiubenko on 13/5/25.
//


public class DataGroup34: DataGroup {
    public var rnokpp: String? {
        guard !rnokppData.isEmpty else { return nil }
        return rnokppData.map { String(UnicodeScalar($0)) }.joined()
    }

    public private(set) var rnokppData = [UInt8]()
    public private(set) var clearData = [UInt8]()
    public private(set) var signature = [UInt8]()

    public override var datagroupType: DataGroupId { .DG34 }

    required init(_ data: [UInt8]) throws {
        try super.init(data, headerBytesCount: 2)
    }

    override func parse(_ data: [UInt8]) throws {
        let rnokppData = Array(data[8...18])

        guard data.count > 84, allBytesAreDigits(rnokppData) else {
            throw NFCPassportReaderError.UnsupportedDataGroup
        }

        self.clearData = Array(data[4...85])
        self.rnokppData = rnokppData
    }

    private func allBytesAreDigits(_ bytes: [UInt8]) -> Bool {
        return bytes.allSatisfy { $0 >= 0x30 && $0 <= 0x39 }
    }
}
