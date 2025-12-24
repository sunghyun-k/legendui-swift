import SwiftUI

// MARK: - Select

/// A single-selection component that displays a list of selectable items with customizable styles.
///
/// - Note: The default style is `RadioSelectStyle` with trailing indicator placement.
public struct Select<SelectionValue: Hashable, Style: SelectStyle>: View {
    @Environment(\.isEnabled) private var isEnabled

    @Binding private var selection: SelectionValue
    private let items: [SelectItem<SelectionValue>]
    private let axis: Axis
    private let isInvalid: Bool
    private let style: Style
    @State private var isPresented = false

    /// Creates a Select component with a custom style.
    ///
    /// - Parameters:
    ///   - selection: A binding to the currently selected value.
    ///   - items: An array of selectable items to display.
    ///   - axis: The layout direction for items (`.vertical` or `.horizontal`). Defaults to
    /// `.vertical`.
    ///   - isInvalid: Whether to display the component in an invalid/error state. Defaults to
    /// `false`.
    ///   - style: The visual style to apply (e.g., `.radio`, `.card`, `.dropdown`, `.segmented`).
    public init(
        selection: Binding<SelectionValue>,
        items: [SelectItem<SelectionValue>],
        axis: Axis = .vertical,
        isInvalid: Bool = false,
        style: Style,
    ) {
        _selection = selection
        self.items = items
        self.axis = axis
        self.isInvalid = isInvalid
        self.style = style
    }

    public var body: some View {
        let configItems = items.map { item in
            SelectStyleConfiguration.Item(
                id: item.value,
                label: item.label,
                description: item.description,
                isSelected: selection == item.value,
                isDisabled: item.isDisabled,
            ) {
                selection = item.value
            }
        }

        let selectedItem = configItems.first { $0.isSelected }

        let configuration = SelectStyleConfiguration(
            items: configItems,
            selectedItem: selectedItem,
            isInvalid: isInvalid,
            isDisabled: !isEnabled,
            axis: axis,
            dismiss: { isPresented = false },
        )

        style.makeBody(configuration: configuration)
    }
}

// MARK: - Convenience init with default style

extension Select where Style == RadioSelectStyle {
    /// Creates a Select component with the default radio style.
    ///
    /// - Parameters:
    ///   - selection: A binding to the currently selected value.
    ///   - items: An array of selectable items to display.
    ///   - axis: The layout direction for items. Defaults to `.vertical`.
    ///   - isInvalid: Whether to display the component in an invalid/error state.
    ///   - size: The size preset (`.sm`, `.md`, `.lg`). Defaults to `.md`.
    public init(
        selection: Binding<SelectionValue>,
        items: [SelectItem<SelectionValue>],
        axis: Axis = .vertical,
        isInvalid: Bool = false,
        size: SelectSizeType = .md,
    ) {
        self.init(
            selection: selection,
            items: items,
            axis: axis,
            isInvalid: isInvalid,
            style: RadioSelectStyle(size: size),
        )
    }
}

// MARK: - SelectItem

/// A data model representing a single selectable option within a Select component.
///
/// Use `SelectItem` to define the options displayed in a Select. Each item has a value,
/// a label view, an optional description, and can be individually disabled.
public struct SelectItem<SelectionValue: Hashable> {
    let value: SelectionValue
    let label: AnyView
    let description: AnyView?
    let isDisabled: Bool

    /// Creates a SelectItem with a custom label view.
    ///
    /// - Parameters:
    ///   - value: The value associated with this item.
    ///   - isDisabled: Whether this item is disabled. Defaults to `false`.
    ///   - label: A view builder that creates the label content.
    public init(
        value: SelectionValue,
        isDisabled: Bool = false,
        @ViewBuilder label: () -> some View,
    ) {
        self.value = value
        self.label = AnyView(label())
        self.description = nil
        self.isDisabled = isDisabled
    }

    /// Creates a SelectItem with custom label and description views.
    ///
    /// - Parameters:
    ///   - value: The value associated with this item.
    ///   - isDisabled: Whether this item is disabled. Defaults to `false`.
    ///   - label: A view builder that creates the label content.
    ///   - description: A view builder that creates the description content.
    public init(
        value: SelectionValue,
        isDisabled: Bool = false,
        @ViewBuilder label: () -> some View,
        @ViewBuilder description: () -> some View,
    ) {
        self.value = value
        self.label = AnyView(label())
        self.description = AnyView(description())
        self.isDisabled = isDisabled
    }
}

extension SelectItem {
    /// Creates a SelectItem with a text label.
    ///
    /// - Parameters:
    ///   - title: The text to display as the label.
    ///   - value: The value associated with this item.
    ///   - isDisabled: Whether this item is disabled. Defaults to `false`.
    public init(
        _ title: String,
        value: SelectionValue,
        isDisabled: Bool = false,
    ) {
        self.value = value
        self.label = AnyView(Text(title))
        self.description = nil
        self.isDisabled = isDisabled
    }

    /// Creates a SelectItem with text label and description.
    ///
    /// - Parameters:
    ///   - title: The text to display as the label.
    ///   - description: The text to display as the description.
    ///   - value: The value associated with this item.
    ///   - isDisabled: Whether this item is disabled. Defaults to `false`.
    public init(
        _ title: String,
        description: String,
        value: SelectionValue,
        isDisabled: Bool = false,
    ) {
        self.value = value
        self.label = AnyView(Text(title))
        self.description = AnyView(Text(description))
        self.isDisabled = isDisabled
    }
}

// MARK: - Preview

#if DEBUG
    private enum Fruit: String, CaseIterable {
        case apple = "Apple"
        case banana = "Banana"
        case orange = "Orange"
        case grape = "Grape"
    }

    #Preview("All Styles Comparison") {
        struct PreviewContainer: View {
            @State private var radio: Fruit = .apple
            @State private var leading: Fruit = .apple
            @State private var card: Fruit = .apple
            @State private var dropdown: Fruit = .apple

            var body: some View {
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Radio (Trailing Indicator)")
                                .font(.caption).foregroundStyle(.secondary)
                            Select(selection: $radio, items: [
                                SelectItem("Apple", value: .apple),
                                SelectItem("Banana", value: .banana),
                            ])
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Leading Indicator")
                                .font(.caption).foregroundStyle(.secondary)
                            Select(
                                selection: $leading,
                                items: [
                                    SelectItem("Apple", value: .apple),
                                    SelectItem("Banana", value: .banana),
                                ],
                                style: .leadingIndicator,
                            )
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Card")
                                .font(.caption).foregroundStyle(.secondary)
                            Select(
                                selection: $card,
                                items: [
                                    SelectItem("Apple", value: .apple),
                                    SelectItem("Banana", value: .banana),
                                ],
                                style: .card,
                            )
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Dropdown")
                                .font(.caption).foregroundStyle(.secondary)
                            Select(
                                selection: $dropdown,
                                items: [
                                    SelectItem("Apple", value: .apple),
                                    SelectItem("Banana", value: .banana),
                                ],
                                style: .dropdown(placeholder: "Select"),
                            )
                        }
                    }
                    .padding()
                }
            }
        }

        return PreviewContainer()
    }
#endif
