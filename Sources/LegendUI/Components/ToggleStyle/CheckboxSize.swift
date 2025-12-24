import SwiftUI

// MARK: - CheckboxSize

// MARK: - CheckboxSizeType

/// The available size presets for checkbox components.
public enum CheckboxSizeType: String, Sendable, CaseIterable {
    case sm
    case md
    case lg
}

// MARK: - CheckboxSize

/// A structure that defines the dimensions and styling for a checkbox at a specific size.
///
/// Use this struct to customize checkbox appearance or use the `resolved(_:layout:typography:)`
/// factory method to get pre-configured sizes.
public struct CheckboxSize: Sendable {
    /// The width and height of the checkbox box.
    public let boxSize: CGFloat

    /// The corner radius of the checkbox box.
    public let cornerRadius: CGFloat

    /// The size of the checkmark icon inside the box.
    public let iconSize: CGFloat

    /// The stroke width used to draw the checkmark.
    public let iconStrokeWidth: CGFloat

    /// The spacing between the checkbox box and its label.
    public let spacing: CGFloat

    /// The font style applied to the label text.
    public let fontStyle: FontStyle

    /// Creates a new checkbox size configuration.
    ///
    /// - Parameters:
    ///   - boxSize: The width and height of the checkbox box.
    ///   - cornerRadius: The corner radius of the checkbox box.
    ///   - iconSize: The size of the checkmark icon.
    ///   - iconStrokeWidth: The stroke width for the checkmark.
    ///   - spacing: The spacing between box and label.
    ///   - fontStyle: The font style for the label.
    public init(
        boxSize: CGFloat,
        cornerRadius: CGFloat,
        iconSize: CGFloat,
        iconStrokeWidth: CGFloat,
        spacing: CGFloat,
        fontStyle: FontStyle,
    ) {
        self.boxSize = boxSize
        self.cornerRadius = cornerRadius
        self.iconSize = iconSize
        self.iconStrokeWidth = iconStrokeWidth
        self.spacing = spacing
        self.fontStyle = fontStyle
    }

    // MARK: - Layout-based Factory

    /// Returns a pre-configured checkbox size for the given size type.
    ///
    /// - Parameters:
    ///   - type: The size preset (sm, md, or lg).
    ///   - layout: The layout configuration from the theme.
    ///   - typography: The typography configuration from the theme.
    /// - Returns: A `CheckboxSize` configured for the specified size type.
    public static func resolved(
        _ type: CheckboxSizeType,
        layout: LegendLayout,
        typography: LegendTypography,
    ) -> CheckboxSize {
        switch type {
        case .sm:
            CheckboxSize(
                boxSize: 18,
                cornerRadius: layout.radius.small - 2,
                iconSize: 12,
                iconStrokeWidth: 2.5,
                spacing: layout.spacing.small,
                fontStyle: typography.sm,
            )
        case .md:
            CheckboxSize(
                boxSize: 22,
                cornerRadius: layout.radius.small,
                iconSize: 14,
                iconStrokeWidth: 2.5,
                spacing: layout.spacing.small,
                fontStyle: typography.base,
            )
        case .lg:
            CheckboxSize(
                boxSize: 26,
                cornerRadius: layout.radius.small + 2,
                iconSize: 16,
                iconStrokeWidth: 3,
                spacing: layout.spacing.medium,
                fontStyle: typography.base,
            )
        }
    }
}
