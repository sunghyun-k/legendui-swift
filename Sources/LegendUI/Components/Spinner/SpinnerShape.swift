import SwiftUI

// MARK: - SpinnerShape

/// A shape that draws an arc between two angles.
///
/// Used internally to create the highlighted portion of the spinner.
struct SpinnerShape: Shape {
    let lineWidth: CGFloat
    let startAngle: Angle
    let endAngle: Angle

    init(
        lineWidth: CGFloat,
        startAngle: Angle = .degrees(0),
        endAngle: Angle = .degrees(270),
    ) {
        self.lineWidth = lineWidth
        self.startAngle = startAngle
        self.endAngle = endAngle
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false,
        )

        return path
    }
}

// MARK: - SpinnerGradientView

/// A view that draws a circular spinner with a background track and highlighted arc.
///
/// The view consists of a semi-transparent circular track and a 90-degree arc
/// in the foreground color. When rotated, this creates the spinning effect.
struct SpinnerGradientView: View {
    let color: Color
    let size: CGFloat
    let lineWidth: CGFloat

    var body: some View {
        ZStack {
            // Background circle (full track)
            Circle()
                .stroke(
                    color.opacity(0.2),
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round,
                    ),
                )

            // Highlight arc (1/4 of the circle = 90 degrees)
            SpinnerShape(
                lineWidth: lineWidth,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
            )
            .stroke(
                color,
                style: StrokeStyle(
                    lineWidth: lineWidth,
                    lineCap: .round,
                ),
            )
        }
        .frame(width: size, height: size)
    }
}
