import SwiftUI

// MARK: - ChipSize

// MARK: - ChipSizeType

/// The predefined size options for a chip.
public enum ChipSizeType: String, Sendable, CaseIterable {
    case sm
    case md
    case lg
}

// MARK: - ChipRadiusType

/// The predefined corner radius options for a chip.
public enum ChipRadiusType: String, Sendable, CaseIterable {
    case none
    case sm
    case md
    case lg
    case full
}

// MARK: - ChipSize

/// Resolved size values for a chip, derived from the theme's layout and typography.
///
/// This struct contains all the dimension values needed to render a chip at a specific size.
/// Use the `resolved(_:radius:layout:typography:)` factory method to create instances.
public struct ChipSize: Sendable {
    /// Vertical padding inside the chip.
    public let verticalPadding: CGFloat
    /// Horizontal padding inside the chip.
    public let horizontalPadding: CGFloat
    /// Spacing between internal elements (dot, content, close button).
    public let spacing: CGFloat
    /// Corner radius of the chip background.
    public let cornerRadius: CGFloat
    /// Font style applied to the chip's text content.
    public let fontStyle: FontStyle
    /// Size of the dot indicator (used with `.dot` variant).
    public let dotSize: CGFloat
    /// Size of the avatar image when using avatar initializers.
    public let avatarSize: CGFloat
    /// Size of the close button (when `onClose` is provided).
    public let closeButtonSize: CGFloat

    /// Creates a chip size with explicit values.
    public init(
        verticalPadding: CGFloat,
        horizontalPadding: CGFloat,
        spacing: CGFloat,
        cornerRadius: CGFloat,
        fontStyle: FontStyle,
        dotSize: CGFloat,
        avatarSize: CGFloat,
        closeButtonSize: CGFloat,
    ) {
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.spacing = spacing
        self.cornerRadius = cornerRadius
        self.fontStyle = fontStyle
        self.dotSize = dotSize
        self.avatarSize = avatarSize
        self.closeButtonSize = closeButtonSize
    }

    // MARK: - Layout-based Factory

    /// Resolves a chip size from the given size type and theme values.
    ///
    /// - Parameters:
    ///   - type: The predefined size option (sm, md, lg).
    ///   - radius: The corner radius option.
    ///   - layout: The theme's layout configuration.
    ///   - typography: The theme's typography configuration.
    /// - Returns: A fully resolved `ChipSize` with all dimension values.
    public static func resolved(
        _ type: ChipSizeType,
        radius: ChipRadiusType,
        layout: LegendLayout,
        typography: LegendTypography,
    ) -> ChipSize {
        let cornerRadius = resolveCornerRadius(radius, layout: layout)

        switch type {
        case .sm:
            return ChipSize(
                verticalPadding: layout.spacing.xSmall,
                horizontalPadding: layout.spacing.small,
                spacing: layout.spacing.xSmall,
                cornerRadius: cornerRadius,
                fontStyle: typography.xs,
                dotSize: 6,
                avatarSize: 16,
                closeButtonSize: 12,
            )
        case .md:
            return ChipSize(
                verticalPadding: layout.spacing.xSmall + 2,
                horizontalPadding: layout.spacing.small + 2,
                spacing: layout.spacing.xSmall + 2,
                cornerRadius: cornerRadius,
                fontStyle: typography.sm,
                dotSize: 8,
                avatarSize: 20,
                closeButtonSize: 14,
            )
        case .lg:
            return ChipSize(
                verticalPadding: layout.spacing.small,
                horizontalPadding: layout.spacing.medium - 4,
                spacing: layout.spacing.small,
                cornerRadius: cornerRadius,
                fontStyle: typography.base,
                dotSize: 10,
                avatarSize: 24,
                closeButtonSize: 16,
            )
        }
    }

    private static func resolveCornerRadius(
        _ radius: ChipRadiusType,
        layout: LegendLayout,
    ) -> CGFloat {
        switch radius {
        case .none:
            0
        case .sm:
            layout.radius.small
        case .md:
            layout.radius.medium
        case .lg:
            layout.radius.large
        case .full:
            layout.radius.full
        }
    }
}
