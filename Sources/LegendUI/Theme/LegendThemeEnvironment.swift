import SwiftUI

// MARK: - LegendThemeKey

private struct LegendThemeKey: EnvironmentKey {
    static let defaultValue = LegendTheme.default
}

// MARK: - EnvironmentValues Extension

extension EnvironmentValues {
    /// The current LegendUI theme in the environment.
    ///
    /// Access this value using `@Environment(\.legendTheme)` in your views.
    public var legendTheme: LegendTheme {
        get { self[LegendThemeKey.self] }
        set { self[LegendThemeKey.self] = newValue }
    }
}

// MARK: - View Extension

extension View {
    /// Applies a LegendUI theme to the view hierarchy.
    ///
    /// If not called, the default theme (with xcassets dynamic colors) is applied.
    ///
    /// - Parameter theme: The theme to apply to this view and its descendants.
    /// - Returns: A view with the specified theme applied.
    public func legendTheme(_ theme: LegendTheme) -> some View {
        environment(\.legendTheme, theme)
    }
}
