import SwiftUI

// MARK: - SelectStyle Protocol

/// A protocol for defining custom visual styles for the Select component.
///
/// Conform to this protocol to create custom selection appearances. The `makeBody` method
/// receives a configuration containing all items and their states.
@MainActor
public protocol SelectStyle {
    associatedtype Body: View

    /// Creates the view representing the body of the select component.
    ///
    /// - Parameter configuration: The properties and items of the select component.
    /// - Returns: A view that represents the styled select component.
    @ViewBuilder
    func makeBody(configuration: SelectStyleConfiguration) -> Body
}

// MARK: - SelectStyleConfiguration

/// Configuration data passed to a SelectStyle's `makeBody` method.
///
/// Contains all the information needed to render a select component, including
/// the list of items, their selection states, and validation/disabled states.
public struct SelectStyleConfiguration {
    /// Represents a single item within the select configuration.
    public struct Item: Identifiable {
        public let id: AnyHashable
        public let label: AnyView
        public let description: AnyView?
        public let isSelected: Bool
        public let isDisabled: Bool
        public let select: () -> Void

        public init(
            id: some Hashable,
            label: some View,
            description: (some View)?,
            isSelected: Bool,
            isDisabled: Bool,
            select: @escaping () -> Void,
        ) {
            self.id = AnyHashable(id)
            self.label = AnyView(label)
            self.description = description.map { AnyView($0) }
            self.isSelected = isSelected
            self.isDisabled = isDisabled
            self.select = select
        }
    }

    public let items: [Item]
    public let selectedItem: Item?
    public let isInvalid: Bool
    public let isDisabled: Bool
    public let axis: Axis
    public let dismiss: () -> Void

    public init(
        items: [Item],
        selectedItem: Item?,
        isInvalid: Bool,
        isDisabled: Bool,
        axis: Axis,
        dismiss: @escaping () -> Void,
    ) {
        self.items = items
        self.selectedItem = selectedItem
        self.isInvalid = isInvalid
        self.isDisabled = isDisabled
        self.axis = axis
        self.dismiss = dismiss
    }
}

// MARK: - AnySelectStyle (Type Eraser)

/// A type-erased wrapper for any SelectStyle.
///
/// Use `AnySelectStyle` when you need to store or pass around select styles
/// without exposing the concrete type.
@MainActor
public struct AnySelectStyle: SelectStyle {
    private let _makeBody: (SelectStyleConfiguration) -> AnyView

    public init(_ style: some SelectStyle) {
        self._makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    public func makeBody(configuration: SelectStyleConfiguration) -> some View {
        _makeBody(configuration)
    }
}
