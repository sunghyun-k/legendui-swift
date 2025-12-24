import SwiftUI

// MARK: - LegendLayout

/// Layout constants including radius, spacing, border width, and opacity values.
///
/// Use these constants to maintain visual consistency across all components.
public struct LegendLayout: Sendable {
    /// Corner radius values for rounded shapes.
    public let radius: Radius

    /// Spacing values for padding and gaps.
    public let spacing: Spacing

    /// Border width values for outlines and strokes.
    public let borderWidth: BorderWidth

    /// Opacity values for various states.
    public let opacity: Opacity

    /// Creates a layout configuration with the specified constants.
    ///
    /// - Parameters:
    ///   - radius: Corner radius values.
    ///   - spacing: Spacing values.
    ///   - borderWidth: Border width values.
    ///   - opacity: Opacity values.
    public init(
        radius: Radius,
        spacing: Spacing,
        borderWidth: BorderWidth,
        opacity: Opacity,
    ) {
        self.radius = radius
        self.spacing = spacing
        self.borderWidth = borderWidth
        self.opacity = opacity
    }
}

// MARK: - Radius

extension LegendLayout {
    /// Corner radius values for rounded shapes, from small to full (pill shape).
    public struct Radius: Sendable {
        /// Small corner radius (8pt by default).
        public let small: CGFloat

        /// Medium corner radius (12pt by default).
        public let medium: CGFloat

        /// Large corner radius (16pt by default).
        public let large: CGFloat

        /// Extra large corner radius (24pt by default).
        public let xLarge: CGFloat

        /// Full radius for pill/capsule shapes (9999pt by default).
        public let full: CGFloat

        /// Creates a radius configuration.
        public init(
            small: CGFloat,
            medium: CGFloat,
            large: CGFloat,
            xLarge: CGFloat,
            full: CGFloat,
        ) {
            self.small = small
            self.medium = medium
            self.large = large
            self.xLarge = xLarge
            self.full = full
        }
    }
}

// MARK: - Spacing

extension LegendLayout {
    /// Spacing values for padding, margins, and gaps.
    public struct Spacing: Sendable {
        /// Extra small spacing (4pt by default).
        public let xSmall: CGFloat

        /// Small spacing (8pt by default).
        public let small: CGFloat

        /// Medium spacing (16pt by default).
        public let medium: CGFloat

        /// Large spacing (24pt by default).
        public let large: CGFloat

        /// Extra large spacing (32pt by default).
        public let xLarge: CGFloat

        /// Creates a spacing configuration.
        public init(
            xSmall: CGFloat,
            small: CGFloat,
            medium: CGFloat,
            large: CGFloat,
            xLarge: CGFloat,
        ) {
            self.xSmall = xSmall
            self.small = small
            self.medium = medium
            self.large = large
            self.xLarge = xLarge
        }
    }
}

// MARK: - Border Width

extension LegendLayout {
    /// Border width values for outlines and strokes.
    public struct BorderWidth: Sendable {
        /// Small border width (1.5pt by default).
        public let small: CGFloat

        /// Medium border width (2pt by default).
        public let medium: CGFloat

        /// Large border width (3pt by default).
        public let large: CGFloat

        /// Creates a border width configuration.
        public init(
            small: CGFloat,
            medium: CGFloat,
            large: CGFloat,
        ) {
            self.small = small
            self.medium = medium
            self.large = large
        }
    }
}

// MARK: - Opacity

extension LegendLayout {
    /// Opacity values for various states.
    public struct Opacity: Sendable {
        /// Opacity for disabled state (0.5 by default).
        public let disabled: CGFloat

        /// Creates an opacity configuration.
        public init(
            disabled: CGFloat,
        ) {
            self.disabled = disabled
        }
    }
}

// MARK: - Default Layout

extension LegendLayout {
    /// The default layout configuration with standard values.
    public static let `default` = LegendLayout(
        radius: Radius(
            small: 8,
            medium: 12,
            large: 16,
            xLarge: 24,
            full: 9999,
        ),
        spacing: Spacing(
            xSmall: 4,
            small: 8,
            medium: 16,
            large: 24,
            xLarge: 32,
        ),
        borderWidth: BorderWidth(
            small: 1.5,
            medium: 2,
            large: 3,
        ),
        opacity: Opacity(
            disabled: 0.5,
        ),
    )
}
