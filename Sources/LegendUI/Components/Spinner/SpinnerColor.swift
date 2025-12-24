import SwiftUI

// MARK: - SpinnerColor

// MARK: - SpinnerColorType

/// The color style options for a spinner.
///
/// Use preset values for semantic colors that adapt to the current theme,
/// or use `.custom(_:)` for a specific color.
public enum SpinnerColorType: Sendable {
    case `default`
    case success
    case warning
    case danger
    case custom(Color)
}

// MARK: - SpinnerColor

/// A resolved color configuration for a spinner.
///
/// Use `SpinnerColor.resolved(_:theme:)` to create a color configuration
/// from a `SpinnerColorType` and the current theme.
public struct SpinnerColor: Sendable {
    /// The resolved color value.
    public let color: Color

    /// Creates a spinner color with a specific color value.
    ///
    /// - Parameter color: The color to use for the spinner.
    public init(color: Color) {
        self.color = color
    }

    // MARK: - Theme-based Factory

    /// Resolves a spinner color type to a concrete color using the provided theme.
    ///
    /// - Parameters:
    ///   - type: The color type to resolve.
    ///   - theme: The theme providing color definitions.
    /// - Returns: A `SpinnerColor` with the resolved color value.
    public static func resolved(
        _ type: SpinnerColorType,
        theme: LegendTheme,
    ) -> SpinnerColor {
        let color: Color = switch type {
        case .default:
            theme.colors.accent.default
        case .success:
            theme.colors.success.default
        case .warning:
            theme.colors.warning.default
        case .danger:
            theme.colors.danger.default
        case .custom(let customColor):
            customColor
        }

        return SpinnerColor(color: color)
    }
}
