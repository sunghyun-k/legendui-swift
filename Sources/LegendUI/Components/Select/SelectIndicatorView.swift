import SwiftUI

// MARK: - SelectIndicatorView

/// A shared radio indicator view used internally by select styles.
///
/// Displays a circular indicator with animated fill and border states based on
/// selection, hover, press, and validation states.
struct SelectIndicatorView: View {
    let isSelected: Bool
    let isInvalid: Bool
    let isHovered: Bool
    let isPressed: Bool
    let size: SelectSize
    let theme: LegendTheme

    var body: some View {
        ZStack {
            Circle()
                .fill(indicatorBackgroundColor)

            Circle()
                .stroke(indicatorBorderColor, lineWidth: isSelected ? 0 : 1.5)

            if isSelected {
                Circle()
                    .fill(thumbColor)
                    .frame(width: size.thumbSize, height: size.thumbSize)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .frame(width: size.indicatorSize, height: size.indicatorSize)
        .scaleEffect(isPressed ? 0.92 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .animation(.easeInOut(duration: 0.15), value: isHovered)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }

    // MARK: - Colors

    private var indicatorBackgroundColor: Color {
        if isSelected {
            if isInvalid {
                return theme.colors.danger.default
            }
            if isHovered {
                return theme.colors.accent.default.opacity(0.9)
            }
            return theme.colors.accent.default
        } else {
            if isHovered {
                return theme.colors.surface.secondary
            }
            return theme.colors.surface.primary
        }
    }

    private var indicatorBorderColor: Color {
        if isInvalid {
            return theme.colors.danger.default
        }
        if isHovered {
            return theme.colors.foreground.muted
        }
        return theme.colors.border
    }

    private var thumbColor: Color {
        if isInvalid {
            return theme.colors.danger.foreground
        }
        return theme.colors.accent.foreground
    }
}
