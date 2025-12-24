// MARK: - PassthroughWindowOverlay

import SwiftUI

#if canImport(UIKit)
    import UIKit

    // MARK: - Hittable Preference

    private struct HittableFramesPreferenceKey: PreferenceKey {
        static let defaultValue: [CGRect] = []

        static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
            value.append(contentsOf: nextValue())
        }
    }

    // MARK: - View Extension

    extension View {
        /// Marks this view as a touch-hittable region within a passthrough overlay.
        ///
        /// When used inside `passthroughWindowOverlay`, only areas marked with this modifier
        /// will receive touch events. Touches outside these areas pass through to the
        /// underlying window.
        ///
        /// - Returns: A view that registers its frame as a hittable region.
        public func hittableInWindowOverlay() -> some View {
            background {
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: HittableFramesPreferenceKey.self,
                            value: [geometry.frame(in: .global)],
                        )
                }
            }
        }

        /// Presents a window-level overlay with touch passthrough capability.
        ///
        /// The overlay is displayed in a separate window above the current content.
        /// Touches are only received by areas marked with `.hittableInWindowOverlay()`;
        /// all other touches pass through to the underlying window.
        ///
        /// - Parameters:
        ///   - isPresented: A Boolean value indicating whether the overlay should be displayed.
        ///   - content: A view builder that creates the overlay content.
        /// - Returns: A view with the passthrough overlay capability attached.
        ///
        /// - Important: Use `.hittableInWindowOverlay()` on interactive elements within
        ///   the overlay content to ensure they receive touch events.
        public func passthroughWindowOverlay(
            isPresented: Bool,
            @ViewBuilder content: @escaping () -> some View,
        ) -> some View {
            background {
                PassthroughWindowBridgingView(
                    isPresented: isPresented,
                    content: content(),
                )
                .allowsHitTesting(false)
            }
        }
    }

    // MARK: - Passthrough Window

    private final class PassthroughWindow: UIWindow {
        var hittableFrames: [CGRect] = []

        override init(windowScene: UIWindowScene) {
            super.init(windowScene: windowScene)
            windowLevel = .alert
            backgroundColor = .clear
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            guard let rootViewController,
                  let hitView = super.hitTest(point, with: event)
            else { return nil }

            // rootViewController.view를 터치한 경우 (배경)
            if hitView === rootViewController.view {
                // hittable 영역에 포함되는지 확인
                let globalPoint = convert(point, to: nil)
                for frame in hittableFrames {
                    if frame.contains(globalPoint) {
                        return hitView
                    }
                }
                // hittable 영역이 아니면 nil 반환 → 아래 window로 전달
                return nil
            }

            // 다른 뷰 (버튼 등)를 터치한 경우 그대로 반환
            return hitView
        }
    }

    // MARK: - Window Bridging View

    private struct PassthroughWindowBridgingView<Content: View>: UIViewRepresentable {
        var isPresented: Bool
        var content: Content

        func makeUIView(context: Context) -> HelperView<Content> {
            HelperView(
                isPresented: isPresented,
                content: EnvironmentPassingView(content: content, environment: context.environment),
            )
        }

        func updateUIView(_ helperView: HelperView<Content>, context: Context) {
            helperView.update(
                isPresented: isPresented,
                content: EnvironmentPassingView(content: content, environment: context.environment),
            )
        }

        struct EnvironmentPassingView: View {
            var content: Content
            var environment: EnvironmentValues

            var body: some View {
                content.environment(\.self, environment)
            }
        }
    }

    // MARK: - Helper View

    private final class HelperView<Content: View>: UIView {
        private var isPresented: Bool
        private var content: PassthroughWindowBridgingView<Content>.EnvironmentPassingView

        private var overlayWindow: PassthroughWindow?
        private var hostingController: UIHostingController<HittableCollectorView<Content>>?

        init(
            isPresented: Bool,
            content: PassthroughWindowBridgingView<Content>.EnvironmentPassingView,
        ) {
            self.isPresented = isPresented
            self.content = content
            super.init(frame: .zero)
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func willMove(toWindow newWindow: UIWindow?) {
            super.willMove(toWindow: newWindow)
            if let windowScene = newWindow?.windowScene {
                overlayWindow = PassthroughWindow(windowScene: windowScene)
                updateView()
            }
        }

        override func didMoveToWindow() {
            super.didMoveToWindow()
            if window == nil {
                // 뷰가 윈도우에서 제거되면 오버레이도 제거
                overlayWindow?.isHidden = true
                overlayWindow?.rootViewController = nil
                overlayWindow = nil
            }
        }

        func update(
            isPresented: Bool,
            content: PassthroughWindowBridgingView<Content>.EnvironmentPassingView,
        ) {
            self.isPresented = isPresented
            self.content = content
            updateView()
        }

        private func updateView() {
            guard let overlayWindow else { return }

            if isPresented {
                let collectorView = HittableCollectorView(content: content
                    .content)
                { [weak overlayWindow] frames in
                    overlayWindow?.hittableFrames = frames
                }

                if hostingController == nil {
                    hostingController = UIHostingController(rootView: collectorView)
                    hostingController?.view.backgroundColor = .clear
                    overlayWindow.rootViewController = hostingController
                } else {
                    hostingController?.rootView = collectorView
                }
                overlayWindow.isHidden = false
            } else {
                overlayWindow.isHidden = true
                overlayWindow.rootViewController = nil
                hostingController = nil
            }
        }
    }

    // MARK: - Hittable Collector View

    private struct HittableCollectorView<Content: View>: View {
        var content: Content
        var onFramesChanged: ([CGRect]) -> Void

        var body: some View {
            content
                .onPreferenceChange(HittableFramesPreferenceKey.self) { frames in
                    onFramesChanged(frames)
                }
        }
    }

    // MARK: - Preview

    #Preview {
        PassthroughWindowOverlayPreview()
    }

    private struct PassthroughWindowOverlayPreview: View {
        @State private var showOverlay = false
        @State private var counter = 0

        var body: some View {
            ZStack {
                Color.blue.opacity(0.3)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Counter: \(counter)")
                        .font(.largeTitle)

                    Button("Increment") {
                        counter += 1
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Show Overlay") {
                        showOverlay = true
                    }
                    .buttonStyle(.bordered)

                    Button("Hide Overlay") {
                        showOverlay = false
                    }
                    .buttonStyle(.bordered)
                }
            }
            .passthroughWindowOverlay(isPresented: showOverlay) {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Overlay Content")
                            .font(.title)
                            .foregroundStyle(.white)

                        Button("Close Overlay") {
                            showOverlay = false
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(40)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .hittableInWindowOverlay()
                }
            }
        }
    }

#else

    // MARK: - macOS Fallback

    extension View {
        /// No-op on macOS. Passthrough hit-testing is not supported.
        ///
        /// On macOS, this modifier has no effect. It exists for API compatibility with iOS.
        public func hittableInWindowOverlay() -> some View {
            self
        }

        /// Presents a simple overlay on macOS. Passthrough is not supported.
        ///
        /// On macOS, this falls back to a standard overlay without touch passthrough capability.
        /// All touches are received by the overlay content.
        ///
        /// - Parameters:
        ///   - isPresented: A Boolean value indicating whether the overlay should be displayed.
        ///   - content: A view builder that creates the overlay content.
        /// - Returns: A view with the overlay capability attached.
        public func passthroughWindowOverlay(
            isPresented: Bool,
            @ViewBuilder content: @escaping () -> some View,
        ) -> some View {
            overlay {
                if isPresented {
                    content()
                }
            }
        }
    }

#endif
