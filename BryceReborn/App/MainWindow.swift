import AppKit

class BryceMainWindow: NSWindow {

    override init(
        contentRect: NSRect,
        styleMask style: NSWindow.StyleMask,
        backing backingStoreType: NSWindow.BackingStoreType,
        defer flag: Bool
    ) {
        super.init(
            contentRect: contentRect,
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )

        setupWindow()
    }

    private func setupWindow() {
        title = "Bryce Reborn"
        minSize = BryceMetrics.minimumWindowSize
        backgroundColor = BryceColors.paletteDark

        // That distinctive Bryce dark title bar
        titlebarAppearsTransparent = false
        titleVisibility = .visible

        // Set up the main content view
        contentView = BryceMainView()
    }
}

// MARK: - Main View (Layout Container)

class BryceMainView: NSView {

    private let controlPalette = ControlPaletteView()
    private let createPalette = CreatePaletteView()
    private let editPalette = EditPaletteView()
    private let viewport = ViewportView()
    private let timeline = TimelineView()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        wantsLayer = true
        layer?.backgroundColor = BryceColors.paletteDark.cgColor

        // Add all palette views
        [controlPalette, createPalette, editPalette, viewport, timeline].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            // Control Palette - Top
            controlPalette.topAnchor.constraint(equalTo: topAnchor),
            controlPalette.leadingAnchor.constraint(equalTo: leadingAnchor),
            controlPalette.trailingAnchor.constraint(equalTo: trailingAnchor),
            controlPalette.heightAnchor.constraint(equalToConstant: BryceMetrics.controlPaletteHeight),

            // Create Palette - Left
            createPalette.topAnchor.constraint(equalTo: controlPalette.bottomAnchor),
            createPalette.leadingAnchor.constraint(equalTo: leadingAnchor),
            createPalette.widthAnchor.constraint(equalToConstant: BryceMetrics.sidePaletteWidth),
            createPalette.bottomAnchor.constraint(equalTo: timeline.topAnchor),

            // Edit Palette - Right
            editPalette.topAnchor.constraint(equalTo: controlPalette.bottomAnchor),
            editPalette.trailingAnchor.constraint(equalTo: trailingAnchor),
            editPalette.widthAnchor.constraint(equalToConstant: BryceMetrics.sidePaletteWidth),
            editPalette.bottomAnchor.constraint(equalTo: timeline.topAnchor),

            // Viewport - Center
            viewport.topAnchor.constraint(equalTo: controlPalette.bottomAnchor),
            viewport.leadingAnchor.constraint(equalTo: createPalette.trailingAnchor),
            viewport.trailingAnchor.constraint(equalTo: editPalette.leadingAnchor),
            viewport.bottomAnchor.constraint(equalTo: timeline.topAnchor),

            // Timeline - Bottom
            timeline.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeline.trailingAnchor.constraint(equalTo: trailingAnchor),
            timeline.bottomAnchor.constraint(equalTo: bottomAnchor),
            timeline.heightAnchor.constraint(equalToConstant: BryceMetrics.timelineHeight),
        ])
    }
}
