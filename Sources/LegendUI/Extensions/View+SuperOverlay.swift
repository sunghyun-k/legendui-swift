// MARK: - View+SuperOverlay

import SwiftUI

extension View {
    /// Displays a non-animated full-screen global overlay.
    ///
    /// The overlay is presented without any transition animation and covers the entire screen.
    /// On iOS, it uses a full-screen cover presentation. On macOS, it uses a simple overlay.
    ///
    /// - Parameters:
    ///   - isPresented: A Boolean value indicating whether the overlay should be displayed.
    ///   - content: A view builder that creates the overlay content.
    /// - Returns: A view with the overlay capability attached.
    public func superOverlay(
        _ isPresented: Bool,
        @ViewBuilder content: @escaping () -> some View,
    ) -> some View {
        modifier(SuperOverlayModifier(isPresented: isPresented, overlayContent: content))
    }
}

private struct SuperOverlayModifier<C: View>: ViewModifier {
    var isPresented: Bool
    var overlayContent: () -> C
    @State private var internalIsPresented = false
    @State private var bound: CGRect?

    func body(content: Content) -> some View {
        content
            .onGeometryChange(
                for: CGRect.self,
                of: { $0.frame(in: .global) },
                action: { bound = $0 },
            )
            .onChange(of: isPresented) { _, newValue in
                setPresented(newValue)
            }
            .onAppear {
                if isPresented {
                    setPresented(true)
                }
            }
        #if os(iOS)
            .fullScreenCover(isPresented: $internalIsPresented) {
                if let bound {
                    ZStack {
                        overlayContent()
                    }
                    .frame(width: bound.width, height: bound.height)
                    .position(x: bound.midX, y: bound.midY)
                    .ignoresSafeArea()
                    .presentationBackground(.clear)
                }
            }

        #else
            .overlay {
                    if internalIsPresented {
                        overlayContent()
                    }
                }
        #endif
    }

    private func setPresented(_ value: Bool) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            internalIsPresented = value
        }
    }
}

// MARK: - Preview

#Preview {
    SuperOverlayPreview()
}

private struct SuperOverlayPreview: View {
    @State private var showOverlay = false

    var body: some View {
        ZStack {
            Color.blue.opacity(0.3)
                .ignoresSafeArea()

            Button("Show Overlay") {
                showOverlay = true
            }
            .buttonStyle(.borderedProminent)
            .superOverlay(showOverlay) {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showOverlay = false
                        }

                    VStack(spacing: 20) {
                        Text("Global Overlay")
                            .font(.title)
                            .foregroundStyle(.white)

                        Button("Close") {
                            showOverlay = false
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                    }
                }
            }
        }
    }
}
