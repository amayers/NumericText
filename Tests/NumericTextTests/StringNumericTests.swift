import NumericText
import XCTest

final class StringNumericTests: XCTestCase {
    func testDoubleDecimal() {
        XCTAssertEqual("12.3.4".numericValue(allowDecimalSeparator: true), "12.34")
        XCTAssertEqual("12..34".numericValue(allowDecimalSeparator: true), "12.34")
        XCTAssertEqual(".1234.".numericValue(allowDecimalSeparator: true), ".1234")
    }

    func testObscureNumericCharacters() throws {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        // DEVANAGARI 5
        let fiveString = "५"
        XCTAssertEqual(fiveString.numericValue(allowDecimalSeparator: false), fiveString)
        let five = try XCTUnwrap(formatter.number(from: fiveString))
        XCTAssertEqual(five, 5)
    }

    func testAlphaNumeric() {
        XCTAssertEqual("12a.3b4".numericValue(allowDecimalSeparator: true), "12.34")
        XCTAssertEqual("12abc34".numericValue(allowDecimalSeparator: true), "1234")
        XCTAssertEqual("a.1234.".numericValue(allowDecimalSeparator: true), ".1234")
    }
}
