import AppKit

/// Base class for all Bryce palettes with authentic styling
class BrycePaletteView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupPalette()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPalette()
    }

    private func setupPalette() {
        wantsLayer = true
        layer?.backgroundColor = BryceColors.paletteMid.cgColor
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Draw the classic Bryce beveled border
        let borderPath = NSBezierPath(rect: bounds)

        // Top/Left highlight
        BryceColors.borderLight.setStroke()
        NSBezierPath.strokeLine(from: NSPoint(x: 0, y: 0),
                                 to: NSPoint(x: 0, y: bounds.height))
        NSBezierPath.strokeLine(from: NSPoint(x: 0, y: bounds.height),
                                 to: NSPoint(x: bounds.width, y: bounds.height))

        // Bottom/Right shadow
        BryceColors.borderDark.setStroke()
        NSBezierPath.strokeLine(from: NSPoint(x: bounds.width, y: bounds.height),
                                 to: NSPoint(x: bounds.width, y: 0))
        NSBezierPath.strokeLine(from: NSPoint(x: bounds.width, y: 0),
                                 to: NSPoint(x: 0, y: 0))
    }
}

// MARK: - Specific Palettes (Shells for now)

class ControlPaletteView: BrycePaletteView {
    // Top bar - view controls, render, display modes, nano-preview

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupControls()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupControls()
    }

    private func setupControls() {
        // Placeholder for control buttons
        let label = NSTextField(labelWithString: "Control Palette")
        label.textColor = BryceColors.textSecondary
        label.font = BryceFonts.smallCondensed
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

class CreatePaletteView: BrycePaletteView {
    // Left side - primitive creation buttons

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupControls()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupControls()
    }

    private func setupControls() {
        // Placeholder labels for primitives
        let labels = ["○", "▢", "△", "◇", "⛰️", "🌲"]
        var previousView: NSView?

        for (index, symbol) in labels.enumerated() {
            let label = NSTextField(labelWithString: symbol)
            label.textColor = BryceColors.textPrimary
            label.font = NSFont.systemFont(ofSize: 18)
            label.alignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)

            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: centerXAnchor),
                label.widthAnchor.constraint(equalToConstant: 40),
                label.heightAnchor.constraint(equalToConstant: 40)
            ])

            if let previous = previousView {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: BryceMetrics.buttonSpacing).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: topAnchor, constant: BryceMetrics.paletteInnerPadding).isActive = true
            }

            previousView = label
        }
    }
}

class EditPaletteView: BrycePaletteView {
    // Right side - transform tools

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupControls()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupControls()
    }

    private func setupControls() {
        // Placeholder labels for tools
        let tools = ["Move", "Rotate", "Scale"]
        var previousView: NSView?

        for tool in tools {
            let label = NSTextField(labelWithString: tool)
            label.textColor = BryceColors.textPrimary
            label.font = BryceFonts.tiny
            label.alignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)

            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: centerXAnchor),
                label.widthAnchor.constraint(equalToConstant: 60),
                label.heightAnchor.constraint(equalToConstant: 40)
            ])

            if let previous = previousView {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: BryceMetrics.buttonSpacing).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: topAnchor, constant: BryceMetrics.paletteInnerPadding).isActive = true
            }

            previousView = label
        }
    }
}

class TimelineView: BrycePaletteView {
    // Bottom - animation timeline

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupControls()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupControls()
    }

    private func setupControls() {
        // Placeholder for timeline
        let label = NSTextField(labelWithString: "Timeline")
        label.textColor = BryceColors.textSecondary
        label.font = BryceFonts.smallCondensed
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
