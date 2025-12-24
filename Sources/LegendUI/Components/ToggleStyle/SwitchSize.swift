import SwiftUI

// MARK: - SwitchSize

// MARK: - SwitchSizeType

/// The available size presets for switch components.
public enum SwitchSizeType: String, Sendable, CaseIterable {
    case sm
    case md
    case lg
}

// MARK: - SwitchSize

/// A structure that defines the dimensions and styling for a switch at a specific size.
///
/// Use this struct to customize switch appearance or use the `resolved(_:layout:typography:)`
/// factory method to get pre-configured sizes.
public struct SwitchSize: Sendable {
    /// The width of the switch track.
    public let trackWidth: CGFloat

    /// The height of the switch track.
    public let trackHeight: CGFloat

    /// The diameter of the circular thumb.
    public let thumbSize: CGFloat

    /// The padding between the thumb and the track edges.
    public let thumbPadding: CGFloat

    /// The spacing between the switch track and its label.
    public let spacing: CGFloat

    /// The font style applied to the label text.
    public let fontStyle: FontStyle

    /// Creates a new switch size configuration.
    ///
    /// - Parameters:
    ///   - trackWidth: The width of the switch track.
    ///   - trackHeight: The height of the switch track.
    ///   - thumbSize: The diameter of the circular thumb.
    ///   - thumbPadding: The padding between thumb and track edges.
    ///   - spacing: The spacing between track and label.
    ///   - fontStyle: The font style for the label.
    public init(
        trackWidth: CGFloat,
        trackHeight: CGFloat,
        thumbSize: CGFloat,
        thumbPadding: CGFloat,
        spacing: CGFloat,
        fontStyle: FontStyle,
    ) {
        self.trackWidth = trackWidth
        self.trackHeight = trackHeight
        self.thumbSize = thumbSize
        self.thumbPadding = thumbPadding
        self.spacing = spacing
        self.fontStyle = fontStyle
    }

    // MARK: - Layout-based Factory

    /// Returns a pre-configured switch size for the given size type.
    ///
    /// - Parameters:
    ///   - type: The size preset (sm, md, or lg).
    ///   - layout: The layout configuration from the theme.
    ///   - typography: The typography configuration from the theme.
    /// - Returns: A `SwitchSize` configured for the specified size type.
    public static func resolved(
        _ type: SwitchSizeType,
        layout: LegendLayout,
        typography: LegendTypography,
    ) -> SwitchSize {
        switch type {
        case .sm:
            SwitchSize(
                trackWidth: 36,
                trackHeight: 20,
                thumbSize: 16,
                thumbPadding: 2,
                spacing: layout.spacing.small,
                fontStyle: typography.sm,
            )
        case .md:
            SwitchSize(
                trackWidth: 44,
                trackHeight: 24,
                thumbSize: 20,
                thumbPadding: 2,
                spacing: layout.spacing.small,
                fontStyle: typography.base,
            )
        case .lg:
            SwitchSize(
                trackWidth: 52,
                trackHeight: 28,
                thumbSize: 24,
                thumbPadding: 2,
                spacing: layout.spacing.medium,
                fontStyle: typography.base,
            )
        }
    }

    /// Calculates the horizontal offset for thumb animation.
    var thumbOffset: CGFloat {
        (trackWidth - thumbSize) / 2 - thumbPadding
    }
}
