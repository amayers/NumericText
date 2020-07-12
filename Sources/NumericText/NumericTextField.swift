import SwiftUI

/// A `TextField` replacement that limits user input to numbers.
public struct NumericTextField: View {

    /// This is what consumers of the text field will access
    @Binding private var number: NSNumber?
    @State private var string: String
    private let isDecimalAllowed: Bool
    private let formatter: NumberFormatter = NumberFormatter()

    private let title: LocalizedStringKey
    private let onEditingChanged: (Bool) -> Void
    private let onCommit: () -> Void

    /// Creates a text field with a text label generated from a localized title string.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of the text field,
    ///     describing its purpose.
    ///   - number: The number to be displayed and edited.
    ///   - isDecimalAllowed: Should the user be allowed to enter a decimal number, or an integer
    ///   - onEditingChanged: An action thats called when the user begins editing `text` and after the user finishes editing `text`.
    ///     The closure receives a Boolean indicating whether the text field is currently being edited.
    ///   - onCommit: An action to perform when the user performs an action (for example, when the user hits the return key) while the text field has focus.
    public init(_ titleKey: LocalizedStringKey, number: Binding<NSNumber?>, isDecimalAllowed: Bool, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {}) {
        formatter.numberStyle = .decimal
        _number = number
        if let number = number.wrappedValue, let string = formatter.string(from: number) {
        _string = State(initialValue: string)
        } else {
            _string = State(initialValue: "")
        }
        self.isDecimalAllowed = isDecimalAllowed
        title = titleKey
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
    }

    public var body: some View {
        return TextField(title, text: $string, onEditingChanged: onEditingChanged, onCommit: onCommit)
            .onChange(of: string, perform: numberChanged(newValue:))
            .modifier(KeyboardModifier(isDecimalAllowed: isDecimalAllowed))
    }

    private func numberChanged(newValue: String) {
        let numeric = newValue.numericValue(allowDecimalSeparator: isDecimalAllowed)
        if newValue != numeric {
            string = numeric
        }
        number = formatter.number(from: string)
    }
}

private struct KeyboardModifier: ViewModifier {
    let isDecimalAllowed: Bool

    func body(content: Content) -> some View {
        #if os(iOS)
        return content
            .keyboardType(isDecimalAllowed ? .decimalPad : .numberPad)
        #else
        return content
        #endif
    }
}

struct NumericTextField_Previews: PreviewProvider {
    @State private static var int: NSNumber?
    @State private static var double: NSNumber?

    static var previews: some View {
        VStack {
            NumericTextField("Int", number: $int, isDecimalAllowed: false)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .padding()
            NumericTextField("Double", number: $double, isDecimalAllowed: true)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .padding()
        }
    }
}
