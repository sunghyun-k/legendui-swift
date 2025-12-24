import SwiftUI

// MARK: - SelectSizeType

/// Predefined size presets for the Select component.
public enum SelectSizeType: String, Sendable, CaseIterable {
    /// Small size with compact spacing and smaller fonts.
    case sm
    /// Medium size with standard spacing (default).
    case md
    /// Large size with generous spacing and larger touch targets.
    case lg
}

// MARK: - SelectSize

/// Resolved size values for the Select component.
///
/// Contains the actual dimension values derived from a `SelectSizeType` and the current theme.
public struct SelectSize: Sendable {
    public let indicatorSize: CGFloat
    public let thumbSize: CGFloat
    public let spacing: CGFloat
    public let itemSpacing: CGFloat
    public let labelFontStyle: FontStyle
    public let descriptionFontStyle: FontStyle

    public init(
        indicatorSize: CGFloat,
        thumbSize: CGFloat,
        spacing: CGFloat,
        itemSpacing: CGFloat,
        labelFontStyle: FontStyle,
        descriptionFontStyle: FontStyle,
    ) {
        self.indicatorSize = indicatorSize
        self.thumbSize = thumbSize
        self.spacing = spacing
        self.itemSpacing = itemSpacing
        self.labelFontStyle = labelFontStyle
        self.descriptionFontStyle = descriptionFontStyle
    }

    // MARK: - Layout-based Factory

    /// Resolves a size type to concrete dimension values using the provided theme settings.
    ///
    /// - Parameters:
    ///   - type: The size preset to resolve.
    ///   - layout: The theme's layout configuration for spacing values.
    ///   - typography: The theme's typography configuration for font styles.
    /// - Returns: A `SelectSize` with resolved dimension values.
    public static func resolved(
        _ type: SelectSizeType,
        layout: LegendLayout,
        typography: LegendTypography,
    ) -> SelectSize {
        switch type {
        case .sm:
            SelectSize(
                indicatorSize: 18,
                thumbSize: 8,
                spacing: layout.spacing.small,
                itemSpacing: layout.spacing.small,
                labelFontStyle: typography.sm,
                descriptionFontStyle: typography.xs,
            )
        case .md:
            SelectSize(
                indicatorSize: 22,
                thumbSize: 10,
                spacing: layout.spacing.small,
                itemSpacing: layout.spacing.medium,
                labelFontStyle: typography.base,
                descriptionFontStyle: typography.sm,
            )
        case .lg:
            SelectSize(
                indicatorSize: 26,
                thumbSize: 12,
                spacing: layout.spacing.medium,
                itemSpacing: layout.spacing.medium,
                labelFontStyle: typography.base,
                descriptionFontStyle: typography.sm,
            )
        }
    }
}
