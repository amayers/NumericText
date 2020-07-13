import SwiftUI

/// A modifier that observes any changes to a string, and updates that string to remove any non-numeric characters.
/// It also will convert that string to a `NSNumber` for easy use.
public struct NumericTextModifier: ViewModifier {
    /// Should the user be allowed to enter a decimal number, or an integer
    public let isDecimalAllowed: Bool
    /// The string that the text field is bound to
    @Binding public var text: String
    /// A number that will be updated when the `text` is updated.
    @Binding public var number: NSNumber?

    /// A modifier that observes any changes to a string, and updates that string to remove any non-numeric characters.
    /// It also will convert that string to a `NSNumber` for easy use.
    ///
    /// - Parameters:
    ///   - text: The string that this should observe and filter
    ///   - number: A number that should be updated whenever the `text` is updated
    ///   - isDecimalAllowed: Should the user be allowed to enter a decimal number, or an integer
    public init(text: Binding<String>, number: Binding<NSNumber?>, isDecimalAllowed: Bool) {
        _text = text
        _number = number
        self.isDecimalAllowed = isDecimalAllowed
    }

    public func body(content: Content) -> some View {
        content
            .onChange(of: text) { newValue in
                let numeric = newValue.numericValue(allowDecimalSeparator: isDecimalAllowed)
                if newValue != numeric {
                    text = numeric
                }
                number = decimalNumberFormatter.number(from: numeric)
            }
    }
}

public extension View {
    /// A modifier that observes any changes to a string, and updates that string to remove any non-numeric characters.
    /// It also will convert that string to a `NSNumber` for easy use.
    func numericText(text: Binding<String>, number: Binding<NSNumber?>, isDecimalAllowed: Bool) -> some View {
        modifier(NumericTextModifier(text: text, number: number, isDecimalAllowed: isDecimalAllowed))
    }
}
