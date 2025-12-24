import SwiftUI

// MARK: - ChipVariant

// MARK: - ChipVariantType

/// The predefined visual style options for a chip.
public enum ChipVariantType: String, Sendable, CaseIterable {
    case solid
    case bordered
    case light
    case flat
    case faded
    case shadow
    case dot
}

// MARK: - ChipColorType

/// The predefined semantic color options for a chip.
public enum ChipColorType: String, Sendable, CaseIterable {
    case `default`
    case primary
    case secondary
    case success
    case warning
    case danger
}

// MARK: - ChipVariant

/// Resolved color values for a chip, derived from the theme's color palette.
///
/// This struct contains all the color values needed to render a chip in various states
/// (normal, hover, pressed, disabled). Use the `resolved(variant:color:theme:)` factory
/// method to create instances based on the current theme.
public struct ChipVariant: Sendable {
    // MARK: - Normal State

    /// Text and icon color in normal state.
    public let foregroundColor: Color
    /// Background color in normal state.
    public let backgroundColor: Color
    /// Border color (used with `.bordered` and `.faded` variants).
    public let borderColor: Color?
    /// Dot indicator color (used with `.dot` variant).
    public let dotColor: Color?
    /// Shadow color (used with `.shadow` variant).
    public let shadowColor: Color?
    /// Shadow blur radius.
    public let shadowRadius: CGFloat

    // MARK: - Hover State

    /// Background color when the chip is hovered (macOS).
    public let hoverBackgroundColor: Color?

    // MARK: - Pressed State

    /// Background color when the chip is pressed.
    public let pressedBackgroundColor: Color?

    // MARK: - Disabled State

    /// Foreground color when the chip is disabled.
    public let disabledForegroundColor: Color
    /// Background color when the chip is disabled.
    public let disabledBackgroundColor: Color

    /// Creates a chip variant with explicit color values.
    public init(
        foregroundColor: Color,
        backgroundColor: Color,
        borderColor: Color? = nil,
        dotColor: Color? = nil,
        shadowColor: Color? = nil,
        shadowRadius: CGFloat = 0,
        hoverBackgroundColor: Color? = nil,
        pressedBackgroundColor: Color? = nil,
        disabledForegroundColor: Color,
        disabledBackgroundColor: Color,
    ) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.dotColor = dotColor
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.hoverBackgroundColor = hoverBackgroundColor
        self.pressedBackgroundColor = pressedBackgroundColor
        self.disabledForegroundColor = disabledForegroundColor
        self.disabledBackgroundColor = disabledBackgroundColor
    }

    // MARK: - Theme-based Factory

    /// Resolves chip colors from the given variant, color type, and theme.
    ///
    /// - Parameters:
    ///   - variant: The visual style (solid, bordered, flat, etc.).
    ///   - color: The semantic color (primary, success, danger, etc.).
    ///   - theme: The current legend theme.
    /// - Returns: A fully resolved `ChipVariant` with all color values.
    public static func resolved(
        variant: ChipVariantType,
        color: ChipColorType,
        theme: LegendTheme,
    ) -> ChipVariant {
        let semanticColors = resolveSemanticColors(color, theme: theme)
        let disabledForeground = theme.colors.disabled.foreground
        let disabledBackground = theme.colors.disabled.background

        switch variant {
        case .solid:
            return ChipVariant(
                foregroundColor: semanticColors.foreground,
                backgroundColor: semanticColors.default,
                hoverBackgroundColor: semanticColors.default.opacity(0.9),
                pressedBackgroundColor: semanticColors.default.opacity(0.8),
                disabledForegroundColor: disabledForeground,
                disabledBackgroundColor: disabledBackground,
            )

        case .bordered:
            return ChipVariant(
                foregroundColor: semanticColors.default,
                backgroundColor: .clear,
                borderColor: semanticColors.default,
                hoverBackgroundColor: semanticColors.default.opacity(0.1),
                pressedBackgroundColor: semanticColors.default.opacity(0.15),
                disabledForegroundColor: disabledForeground,
                disabledBackgroundColor: .clear,
            )

        case .light:
            return ChipVariant(
                foregroundColor: semanticColors.default,
                backgroundColor: .clear,
                hoverBackgroundColor: semanticColors.soft.opacity(0.5),
                pressedBackgroundColor: semanticColors.soft,
                disabledForegroundColor: disabledForeground,
                disabledBackgroundColor: .clear,
            )

        case .flat:
            return ChipVariant(
                foregroundColor: semanticColors.softForeground,
                backgroundColor: semanticColors.soft,
                hoverBackgroundColor: semanticColors.soft.opacity(0.8),
                pressedBackgroundColor: semanticColors.soft.opacity(0.6),
                disabledForegroundColor: disabledForeground,
                disabledBackgroundColor: disabledBackground,
            )

        case .faded:
            return ChipVariant(
                foregroundColor: semanticColors.default,
                backgroundColor: theme.colors.background.secondary,
                borderColor: theme.colors.border,
                hoverBackgroundColor: theme.colors.background.tertiary,
                pressedBackgroundColor: theme.colors.background.tertiary.opacity(0.8),
                disabledForegroundColor: disabledForeground,
                disabledBackgroundColor: disabledBackground,
            )

        case .shadow:
            return ChipVariant(
                foregroundColor: semanticColors.foreground,
                backgroundColor: semanticColors.default,
                shadowColor: semanticColors.default.opacity(0.4),
                shadowRadius: 8,
                hoverBackgroundColor: semanticColors.default.opacity(0.9),
                pressedBackgroundColor: semanticColors.default.opacity(0.8),
                disabledForegroundColor: disabledForeground,
                disabledBackgroundColor: disabledBackground,
            )

        case .dot:
            return ChipVariant(
                foregroundColor: theme.colors.foreground.primary,
                backgroundColor: theme.colors.background.secondary,
                borderColor: theme.colors.border,
                dotColor: semanticColors.default,
                hoverBackgroundColor: theme.colors.background.tertiary,
                pressedBackgroundColor: theme.colors.background.tertiary.opacity(0.8),
                disabledForegroundColor: disabledForeground,
                disabledBackgroundColor: disabledBackground,
            )
        }
    }

    private static func resolveSemanticColors(
        _ color: ChipColorType,
        theme: LegendTheme,
    ) -> LegendColors.SemanticColors {
        switch color {
        case .default:
            LegendColors.SemanticColors(
                default: theme.colors.foreground.secondary,
                foreground: theme.colors.background.primary,
                soft: theme.colors.background.secondary,
                softForeground: theme.colors.foreground.primary,
            )
        case .primary:
            theme.colors.accent
        case .secondary:
            LegendColors.SemanticColors(
                default: theme.colors.foreground.secondary,
                foreground: theme.colors.background.primary,
                soft: theme.colors.background.tertiary,
                softForeground: theme.colors.foreground.secondary,
            )
        case .success:
            theme.colors.success
        case .warning:
            theme.colors.warning
        case .danger:
            theme.colors.danger
        }
    }
}
