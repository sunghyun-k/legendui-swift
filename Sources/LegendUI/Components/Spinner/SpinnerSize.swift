import SwiftUI

// MARK: - SpinnerSize

// MARK: - SpinnerSizeType

/// The size options for a spinner.
///
/// Each size provides appropriate dimensions for different contexts.
public enum SpinnerSizeType: String, Sendable, CaseIterable {
    case sm
    case md
    case lg
}

// MARK: - SpinnerSize

/// A resolved size configuration for a spinner.
///
/// Contains the overall diameter and stroke width for rendering the spinner.
public struct SpinnerSize: Sendable {
    /// The diameter of the spinner in points.
    public let size: CGFloat

    /// The stroke width of the spinner arc in points.
    public let lineWidth: CGFloat

    /// Creates a spinner size with custom dimensions.
    ///
    /// - Parameters:
    ///   - size: The diameter of the spinner.
    ///   - lineWidth: The stroke width of the spinner arc.
    public init(
        size: CGFloat,
        lineWidth: CGFloat,
    ) {
        self.size = size
        self.lineWidth = lineWidth
    }

    // MARK: - Layout-based Factory

    /// Resolves a spinner size type to concrete dimensions.
    ///
    /// - Parameter type: The size type to resolve.
    /// - Returns: A `SpinnerSize` with the resolved dimensions.
    public static func resolved(
        _ type: SpinnerSizeType,
    ) -> SpinnerSize {
        switch type {
        case .sm:
            SpinnerSize(
                size: 20,
                lineWidth: 2,
            )
        case .md:
            SpinnerSize(
                size: 32,
                lineWidth: 3,
            )
        case .lg:
            SpinnerSize(
                size: 48,
                lineWidth: 4,
            )
        }
    }
}
