import SwiftUI

// MARK: - ButtonVariant

// MARK: - ButtonVariantType

/// Predefined button visual style variants.
public enum ButtonVariantType: String, Sendable, CaseIterable {
    case primary
    case secondary
    case tertiary
    case ghost
    case danger
    case dangerSoft
}

// MARK: - ButtonVariant

/// A configuration that defines the visual appearance of a button across all states.
///
/// Use this struct to create custom button styles with specific colors for normal,
/// hover, pressed, and disabled states. For standard styles, use `ButtonVariantType` instead.
public struct ButtonVariant: Sendable {
    // MARK: - Normal State

    /// Text and icon color in normal state.
    public let foregroundColor: Color

    /// Background color in normal state. Set to `nil` for transparent background.
    public let backgroundColor: Color?

    /// Border color in normal state. Set to `nil` for no border.
    public let borderColor: Color?

    // MARK: - Hover State (macOS)

    /// Foreground color when hovering (macOS only). Falls back to `foregroundColor` if `nil`.
    public let hoverForegroundColor: Color?

    /// Background color when hovering (macOS only). Falls back to `backgroundColor` if `nil`.
    public let hoverBackgroundColor: Color?

    /// Border color when hovering (macOS only). Falls back to `borderColor` if `nil`.
    public let hoverBorderColor: Color?

    // MARK: - Pressed State (iOS & macOS)

    /// Foreground color when pressed. Falls back to `foregroundColor` if `nil`.
    public let pressedForegroundColor: Color?

    /// Background color when pressed. Falls back to `backgroundColor` if `nil`.
    public let pressedBackgroundColor: Color?

    /// Border color when pressed. Falls back to `borderColor` if `nil`.
    public let pressedBorderColor: Color?

    // MARK: - Disabled State

    /// Foreground color when disabled.
    public let disabledForegroundColor: Color

    /// Background color when disabled. Falls back to clear if `nil`.
    public let disabledBackgroundColor: Color?

    /// Border color when disabled. Falls back to no border if `nil`.
    public let disabledBorderColor: Color?

    /// Creates a new button variant configuration.
    ///
    /// - Parameters:
    ///   - foregroundColor: Text and icon color in normal state.
    ///   - backgroundColor: Background color in normal state.
    ///   - borderColor: Border color in normal state.
    ///   - hoverForegroundColor: Foreground color when hovering (macOS).
    ///   - hoverBackgroundColor: Background color when hovering (macOS).
    ///   - hoverBorderColor: Border color when hovering (macOS).
    ///   - pressedForegroundColor: Foreground color when pressed.
    ///   - pressedBackgroundColor: Background color when pressed.
    ///   - pressedBorderColor: Border color when pressed.
    ///   - disabledForegroundColor: Foreground color when disabled.
    ///   - disabledBackgroundColor: Background color when disabled.
    ///   - disabledBorderColor: Border color when disabled.
    public init(
        foregroundColor: Color,
        backgroundColor: Color? = nil,
        borderColor: Color? = nil,
        hoverForegroundColor: Color? = nil,
        hoverBackgroundColor: Color? = nil,
        hoverBorderColor: Color? = nil,
        pressedForegroundColor: Color? = nil,
        pressedBackgroundColor: Color? = nil,
        pressedBorderColor: Color? = nil,
        disabledForegroundColor: Color,
        disabledBackgroundColor: Color? = nil,
        disabledBorderColor: Color? = nil,
    ) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.hoverForegroundColor = hoverForegroundColor
        self.hoverBackgroundColor = hoverBackgroundColor
        self.hoverBorderColor = hoverBorderColor
        self.pressedForegroundColor = pressedForegroundColor
        self.pressedBackgroundColor = pressedBackgroundColor
        self.pressedBorderColor = pressedBorderColor
        self.disabledForegroundColor = disabledForegroundColor
        self.disabledBackgroundColor = disabledBackgroundColor
        self.disabledBorderColor = disabledBorderColor
    }

    // MARK: - Theme-based Factory

    /// Resolves a button variant type to concrete colors using the provided theme.
    ///
    /// - Parameters:
    ///   - type: The predefined variant type to resolve.
    ///   - theme: The theme configuration providing color values.
    /// - Returns: A `ButtonVariant` instance with resolved color values.
    public static func resolved(
        _ type: ButtonVariantType,
        theme: LegendTheme,
    ) -> ButtonVariant {
        switch type {
        case .primary:
            ButtonVariant(
                foregroundColor: theme.colors.accent.foreground,
                backgroundColor: theme.colors.accent.default,
                hoverBackgroundColor: theme.colors.accent.default.opacity(0.9),
                pressedBackgroundColor: theme.colors.accent.default.opacity(0.75),
                disabledForegroundColor: theme.colors.disabled.foreground,
                disabledBackgroundColor: theme.colors.disabled.background,
            )
        case .secondary:
            ButtonVariant(
                foregroundColor: theme.colors.foreground.primary,
                backgroundColor: theme.colors.background.secondary,
                hoverBackgroundColor: theme.colors.background.tertiary,
                pressedBackgroundColor: theme.colors.background.tertiary.opacity(0.8),
                disabledForegroundColor: theme.colors.disabled.foreground,
                disabledBackgroundColor: theme.colors.disabled.background,
            )
        case .tertiary:
            ButtonVariant(
                foregroundColor: theme.colors.foreground.primary,
                borderColor: theme.colors.border,
                hoverBackgroundColor: theme.colors.background.secondary.opacity(0.5),
                pressedBackgroundColor: theme.colors.background.secondary,
                disabledForegroundColor: theme.colors.disabled.foreground,
                disabledBorderColor: theme.colors.disabled.background,
            )
        case .ghost:
            ButtonVariant(
                foregroundColor: theme.colors.foreground.primary,
                hoverBackgroundColor: theme.colors.background.secondary.opacity(0.5),
                pressedBackgroundColor: theme.colors.background.secondary,
                disabledForegroundColor: theme.colors.disabled.foreground,
            )
        case .danger:
            ButtonVariant(
                foregroundColor: theme.colors.danger.foreground,
                backgroundColor: theme.colors.danger.default,
                hoverBackgroundColor: theme.colors.danger.default.opacity(0.9),
                pressedBackgroundColor: theme.colors.danger.default.opacity(0.75),
                disabledForegroundColor: theme.colors.disabled.foreground,
                disabledBackgroundColor: theme.colors.disabled.background,
            )
        case .dangerSoft:
            ButtonVariant(
                foregroundColor: theme.colors.danger.softForeground,
                backgroundColor: theme.colors.danger.soft,
                hoverBackgroundColor: theme.colors.danger.soft.opacity(0.8),
                pressedBackgroundColor: theme.colors.danger.default.opacity(0.25),
                disabledForegroundColor: theme.colors.disabled.foreground,
                disabledBackgroundColor: theme.colors.disabled.background,
            )
        }
    }
}
