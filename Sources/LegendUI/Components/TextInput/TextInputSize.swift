import SwiftUI

// MARK: - TextInputSize

/// The available size variants for text inputs.
public enum TextInputSizeType: String, Sendable, CaseIterable {
    /// Small size variant with compact dimensions.
    case sm

    /// Medium size variant (default).
    case md

    /// Large size variant with more spacious dimensions.
    case lg
}

// MARK: - TextInputSize

/// A configuration struct containing all size-related properties for a text input.
///
/// Use `TextInputSize.resolved(_:layout:typography:)` to create a size configuration
/// that is properly integrated with your theme.
public struct TextInputSize: Sendable {
    /// The height of the input container (for single-line inputs).
    public let height: CGFloat

    /// Horizontal padding inside the input container.
    public let horizontalPadding: CGFloat

    /// Vertical padding inside the input container.
    public let verticalPadding: CGFloat

    /// Corner radius of the input container.
    public let cornerRadius: CGFloat

    /// Border width of the input container.
    public let borderWidth: CGFloat

    /// Spacing between elements (label, input, description).
    public let spacing: CGFloat

    /// Font style for the label text.
    public let labelFontStyle: FontStyle

    /// Font style for the input text.
    public let inputFontStyle: FontStyle

    /// Font style for the description and error message text.
    public let descriptionFontStyle: FontStyle

    /// Creates a custom text input size configuration.
    public init(
        height: CGFloat,
        horizontalPadding: CGFloat,
        verticalPadding: CGFloat,
        cornerRadius: CGFloat,
        borderWidth: CGFloat,
        spacing: CGFloat,
        labelFontStyle: FontStyle,
        inputFontStyle: FontStyle,
        descriptionFontStyle: FontStyle,
    ) {
        self.height = height
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.spacing = spacing
        self.labelFontStyle = labelFontStyle
        self.inputFontStyle = inputFontStyle
        self.descriptionFontStyle = descriptionFontStyle
    }

    // MARK: - Layout-based Factory

    /// Creates a size configuration resolved against the provided layout and typography settings.
    ///
    /// - Parameters:
    ///   - type: The size variant to resolve.
    ///   - layout: The layout configuration from your theme.
    ///   - typography: The typography configuration from your theme.
    /// - Returns: A fully configured `TextInputSize` instance.
    public static func resolved(
        _ type: TextInputSizeType,
        layout: LegendLayout,
        typography: LegendTypography,
    ) -> TextInputSize {
        switch type {
        case .sm:
            TextInputSize(
                height: 40,
                horizontalPadding: layout.spacing.small,
                verticalPadding: layout.spacing.small,
                cornerRadius: layout.radius.medium,
                borderWidth: layout.borderWidth.small,
                spacing: layout.spacing.small,
                labelFontStyle: typography.sm,
                inputFontStyle: typography.sm,
                descriptionFontStyle: typography.xs,
            )
        case .md:
            TextInputSize(
                height: 48,
                horizontalPadding: layout.spacing.medium,
                verticalPadding: layout.spacing.small,
                cornerRadius: layout.radius.large,
                borderWidth: layout.borderWidth.small,
                spacing: layout.spacing.small,
                labelFontStyle: typography.base,
                inputFontStyle: typography.base,
                descriptionFontStyle: typography.sm,
            )
        case .lg:
            TextInputSize(
                height: 56,
                horizontalPadding: layout.spacing.medium,
                verticalPadding: layout.spacing.medium,
                cornerRadius: layout.radius.large,
                borderWidth: layout.borderWidth.medium,
                spacing: layout.spacing.medium,
                labelFontStyle: typography.base,
                inputFontStyle: typography.base,
                descriptionFontStyle: typography.sm,
            )
        }
    }
}
