import SwiftUI

// MARK: - LegendTypography

/// Typography configuration containing font styles for different text sizes.
///
/// Use these styles to maintain consistent text styling throughout your app.
public struct LegendTypography: Sendable {
    /// Extra small font style (12pt, regular weight).
    public let xs: FontStyle

    /// Small font style (14pt, regular weight).
    public let sm: FontStyle

    /// Base font style (16pt, regular weight).
    public let base: FontStyle

    /// Large font style (18pt, medium weight).
    public let lg: FontStyle

    /// Extra large font style (20pt, medium weight).
    public let xl: FontStyle

    /// 2x extra large font style (24pt, semibold weight).
    public let xl2: FontStyle

    /// 3x extra large font style (30pt, semibold weight).
    public let xl3: FontStyle

    /// Creates a typography configuration with font styles for each size.
    ///
    /// - Parameters:
    ///   - xs: Extra small font style.
    ///   - sm: Small font style.
    ///   - base: Base font style.
    ///   - lg: Large font style.
    ///   - xl: Extra large font style.
    ///   - xl2: 2x extra large font style.
    ///   - xl3: 3x extra large font style.
    public init(
        xs: FontStyle,
        sm: FontStyle,
        base: FontStyle,
        lg: FontStyle,
        xl: FontStyle,
        xl2: FontStyle,
        xl3: FontStyle,
    ) {
        self.xs = xs
        self.sm = sm
        self.base = base
        self.lg = lg
        self.xl = xl
        self.xl2 = xl2
        self.xl3 = xl3
    }
}

// MARK: - Default Typography

extension LegendTypography {
    /// The default typography configuration using system fonts.
    public static let `default` = LegendTypography(
        xs: FontStyle(
            font: .systemFont(ofSize: 11, weight: .regular),
            lineHeight: .exact(points: 14),
        ),
        sm: FontStyle(
            font: .systemFont(ofSize: 13, weight: .regular),
            lineHeight: .exact(points: 18),
        ),
        base: FontStyle(
            font: .systemFont(ofSize: 15, weight: .regular),
            lineHeight: .exact(points: 21),
        ),
        lg: FontStyle(
            font: .systemFont(ofSize: 17, weight: .medium),
            lineHeight: .exact(points: 24),
        ),
        xl: FontStyle(
            font: .systemFont(ofSize: 19, weight: .medium),
            lineHeight: .exact(points: 26),
        ),
        xl2: FontStyle(
            font: .systemFont(ofSize: 22, weight: .semibold),
            lineHeight: .exact(points: 28),
        ),
        xl3: FontStyle(
            font: .systemFont(ofSize: 28, weight: .semibold),
            lineHeight: .exact(points: 34),
        ),
    )
}
