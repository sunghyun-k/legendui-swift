import SwiftUI

// MARK: - LegendColors

/// The complete color palette configuration for the theme.
///
/// Contains organized color groups for backgrounds, surfaces, foregrounds,
/// semantic colors, and utility colors like borders and dividers.
public struct LegendColors: Sendable {
    /// Background colors for page-level backgrounds.
    public let background: BackgroundColors

    /// Surface colors for component backgrounds (cards, buttons, etc.).
    public let surface: SurfaceColors

    /// Foreground colors for text and icons.
    public let foreground: ForegroundColors

    /// Accent semantic colors for primary actions and highlights.
    public let accent: SemanticColors

    /// Danger semantic colors for destructive actions and errors.
    public let danger: SemanticColors

    /// Success semantic colors for positive feedback and confirmations.
    public let success: SemanticColors

    /// Warning semantic colors for cautionary messages.
    public let warning: SemanticColors

    /// Default border color for component outlines.
    public let border: Color

    /// Default divider color for separators.
    public let divider: Color

    /// Colors for disabled state styling.
    public let disabled: DisabledColors

    /// Creates a new color palette with all color groups.
    ///
    /// - Parameters:
    ///   - background: Background color group.
    ///   - surface: Surface color group.
    ///   - foreground: Foreground color group.
    ///   - accent: Accent semantic colors.
    ///   - danger: Danger semantic colors.
    ///   - success: Success semantic colors.
    ///   - warning: Warning semantic colors.
    ///   - border: Border color.
    ///   - divider: Divider color.
    ///   - disabled: Disabled state colors.
    public init(
        background: BackgroundColors,
        surface: SurfaceColors,
        foreground: ForegroundColors,
        accent: SemanticColors,
        danger: SemanticColors,
        success: SemanticColors,
        warning: SemanticColors,
        border: Color,
        divider: Color,
        disabled: DisabledColors,
    ) {
        self.background = background
        self.surface = surface
        self.foreground = foreground
        self.accent = accent
        self.danger = danger
        self.success = success
        self.warning = warning
        self.border = border
        self.divider = divider
        self.disabled = disabled
    }
}

// MARK: - Background Colors

extension LegendColors {
    /// Background colors for page-level backgrounds with hierarchy levels.
    public struct BackgroundColors: Sendable {
        /// The main background color for primary content areas.
        public let primary: Color

        /// Secondary background for nested or alternate sections.
        public let secondary: Color

        /// Tertiary background for deeply nested content.
        public let tertiary: Color

        /// Creates a background color group.
        public init(
            primary: Color,
            secondary: Color,
            tertiary: Color,
        ) {
            self.primary = primary
            self.secondary = secondary
            self.tertiary = tertiary
        }
    }
}

// MARK: - Surface Colors

extension LegendColors {
    /// Surface colors for component backgrounds (cards, buttons, modals, etc.).
    public struct SurfaceColors: Sendable {
        /// Primary surface color for main components.
        public let primary: Color

        /// Secondary surface for nested or alternate components.
        public let secondary: Color

        /// Tertiary surface for deeply nested components.
        public let tertiary: Color

        /// Quaternary surface for the deepest level of nesting.
        public let quaternary: Color

        /// Default text color on surfaces.
        public let foreground: Color

        /// Creates a surface color group.
        public init(
            primary: Color,
            secondary: Color,
            tertiary: Color,
            quaternary: Color,
            foreground: Color,
        ) {
            self.primary = primary
            self.secondary = secondary
            self.tertiary = tertiary
            self.quaternary = quaternary
            self.foreground = foreground
        }
    }
}

// MARK: - Foreground Colors

extension LegendColors {
    /// Foreground colors for text and icons.
    public struct ForegroundColors: Sendable {
        /// Primary text/icon color for main content.
        public let primary: Color

        /// Secondary text/icon color for supporting content.
        public let secondary: Color

        /// Muted text/icon color for de-emphasized content.
        public let muted: Color

        /// Creates a foreground color group.
        public init(
            primary: Color,
            secondary: Color,
            muted: Color,
        ) {
            self.primary = primary
            self.secondary = secondary
            self.muted = muted
        }
    }
}

// MARK: - Semantic Colors (Accent, Danger, Success, Warning)

extension LegendColors {
    /// Semantic colors with default and soft variants, used for accent, danger, success, and
    /// warning.
    public struct SemanticColors: Sendable {
        /// The solid/default color (e.g., solid button background).
        public let `default`: Color

        /// Text/icon color on the default background.
        public let foreground: Color

        /// Soft/muted variant of the color (e.g., soft button background).
        public let soft: Color

        /// Text/icon color on the soft background.
        public let softForeground: Color

        /// Creates a semantic color group with default and soft variants.
        public init(
            default: Color,
            foreground: Color,
            soft: Color,
            softForeground: Color,
        ) {
            self.default = `default`
            self.foreground = foreground
            self.soft = soft
            self.softForeground = softForeground
        }
    }
}

// MARK: - Disabled Colors

extension LegendColors {
    /// Colors for disabled state styling.
    public struct DisabledColors: Sendable {
        /// Background color for disabled components.
        public let background: Color

        /// Text/icon color for disabled components.
        public let foreground: Color

        /// Creates a disabled color group.
        public init(
            background: Color,
            foreground: Color,
        ) {
            self.background = background
            self.foreground = foreground
        }
    }
}

// MARK: - Default Colors

extension LegendColors {
    /// The default color palette with dynamic colors from the asset catalog.
    ///
    /// Colors automatically adapt to light and dark modes.
    public static let `default` = LegendColors(
        background: BackgroundColors(
            primary: Color("background", bundle: .module),
            secondary: Color("backgroundSecondary", bundle: .module),
            tertiary: Color("backgroundTertiary", bundle: .module),
        ),
        surface: SurfaceColors(
            primary: Color("surface", bundle: .module),
            secondary: Color("surfaceSecondary", bundle: .module),
            tertiary: Color("surfaceTertiary", bundle: .module),
            quaternary: Color("surfaceQuaternary", bundle: .module),
            foreground: Color("surfaceForeground", bundle: .module),
        ),
        foreground: ForegroundColors(
            primary: Color("foreground", bundle: .module),
            secondary: Color("foregroundSecondary", bundle: .module),
            muted: Color("foregroundMuted", bundle: .module),
        ),
        accent: SemanticColors(
            default: Color("accent", bundle: .module),
            foreground: Color("accentForeground", bundle: .module),
            soft: Color("accentSoft", bundle: .module),
            softForeground: Color("accentSoftForeground", bundle: .module),
        ),
        danger: SemanticColors(
            default: Color("danger", bundle: .module),
            foreground: Color("dangerForeground", bundle: .module),
            soft: Color("dangerSoft", bundle: .module),
            softForeground: Color("dangerSoftForeground", bundle: .module),
        ),
        success: SemanticColors(
            default: Color("success", bundle: .module),
            foreground: Color("successForeground", bundle: .module),
            soft: Color("successSoft", bundle: .module),
            softForeground: Color("successSoftForeground", bundle: .module),
        ),
        warning: SemanticColors(
            default: Color("warning", bundle: .module),
            foreground: Color("warningForeground", bundle: .module),
            soft: Color("warningSoft", bundle: .module),
            softForeground: Color("warningSoftForeground", bundle: .module),
        ),
        border: Color("border", bundle: .module),
        divider: Color("divider", bundle: .module),
        disabled: DisabledColors(
            background: Color("disabled", bundle: .module),
            foreground: Color("disabledForeground", bundle: .module),
        ),
    )
}
