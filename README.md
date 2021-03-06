![Swift](https://github.com/amayers/NumericText/workflows/Swift/badge.svg)

# NumericText

A simple SwiftUI `TextField` that limits user input to numbers.

The most common response in https://stackoverflow.com/questions/58733003/swiftui-how-to-create-textfield-that-only-accepts-numbers (the top search result), advocates just setting a numeric keyboard. But that totally misses cases when used with hardware keyboards. Many of the suggested  

This `NumericTextModifier` observes a `String` value for changes, and when it is changed, it filters out any non-numeric characters and updates the string. Then it converts that string to a `NSNumber` for easier use. You can choose to allow integers or floating point. 

`NumericTextField` uses `NumbericTextModifier` and exposes only the `NSNumber` in the text. It prevents any non-numeric text input, no matter the source (paste, external keyboard). It also manages the keyboard type to match the type of numbers you said to allow.

Standard `TextFields` have a `Formatter` that you can pass in, that will be used to format/validate input. However this only occurs when the user finishes editing, not for every keystroke. So a user can type `123abc4` and see that in the text field, then when they hit return it will change to `1234`. That's really not ideal. With `NumericTextField` when they type a non-numeric character it is ignored and never shows up in the text field.


## Usage:

### NumericTextField

It works just like `TextField` but you are binding it to `NSNumber?` instead of a `String`.

```
// Inside your view
@State private var int: NSNumber?
@State private var double: NSNumber?

var body: Some View {
    VStack {
        NumericTextField("Int", number: $int, isDecimalAllowed: false)
        NumericTextField("Double", number: $double, isDecimalAllowed: true)
    }
}

```

### NumericTextModifier

```
// Inside your view
@State private var int: NSNumber?
@State private var intString = ""
@State private var double: NSNumber?
@State private var doubleString = ""

var body: Some View {
    VStack {
        TextField("Int", text: $intString)
            .numericText(text: $intString, number: $int, isDecimalAllowed: false)
        TextField("Double", text: $doubleString)
            .numericText(text: $doubleString, number: $double, isDecimalAllowed: true)
    }
}

```

## Installation

Use Swift Package Manager or just drag and drop the two source files into your project. It supports iOS 14, macOS 10.16/11, tvOS 14, watchOS 7.

## Improvement ideas
* Ditch `NSNumber?` as the bound value, and allow binding either `Int?` or `Double?`. I took a quick shot at this, but my generics skills weren't sufficient to figure it out.
* Support the other initializers that `TextField` supports.

Pull requests are welcome to help with these or any other things you may find or think of.
