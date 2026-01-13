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
        setupButtons()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    private func setupButtons() {
        // Create primitive buttons with icons
        let sphereBtn = BryceButton(style: .standard, icon: BryceIcons.sphere)
        sphereBtn.toolTip = "Create Sphere"
        sphereBtn.action = { print("Create Sphere") }

        let cubeBtn = BryceButton(style: .standard, icon: BryceIcons.cube)
        cubeBtn.toolTip = "Create Cube"
        cubeBtn.action = { print("Create Cube") }

        let cylinderBtn = BryceButton(style: .standard, icon: BryceIcons.cylinder)
        cylinderBtn.toolTip = "Create Cylinder"
        cylinderBtn.action = { print("Create Cylinder") }

        let terrainBtn = BryceButton(style: .standard, icon: BryceIcons.terrain)
        terrainBtn.toolTip = "Create Terrain"
        terrainBtn.action = { print("Create Terrain") }

        let treeBtn = BryceButton(style: .standard, icon: BryceIcons.tree)
        treeBtn.toolTip = "Create Tree"
        treeBtn.action = { print("Create Tree") }

        // Stack them vertically with proper spacing
        let stack = NSStackView(views: [sphereBtn, cubeBtn, cylinderBtn, terrainBtn, treeBtn])
        stack.orientation = .vertical
        stack.spacing = BryceMetrics.buttonSpacing
        stack.alignment = .centerX
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: BryceMetrics.paletteInnerPadding),
        ])
    }
}

class EditPaletteView: BrycePaletteView {
    // Right side - transform tools

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupButtons()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    private func setupButtons() {
        // Create transform tool buttons
        let moveBtn = BryceButton(style: .standard, icon: BryceIcons.move)
        moveBtn.toolTip = "Move Tool"
        moveBtn.isToggle = true
        moveBtn.action = { print("Move Tool") }

        let rotateBtn = BryceButton(style: .standard, icon: BryceIcons.rotate)
        rotateBtn.toolTip = "Rotate Tool"
        rotateBtn.isToggle = true
        rotateBtn.action = { print("Rotate Tool") }

        let scaleBtn = BryceButton(style: .standard, icon: BryceIcons.scale)
        scaleBtn.toolTip = "Scale Tool"
        scaleBtn.isToggle = true
        scaleBtn.action = { print("Scale Tool") }

        // Stack them vertically with proper spacing
        let stack = NSStackView(views: [moveBtn, rotateBtn, scaleBtn])
        stack.orientation = .vertical
        stack.spacing = BryceMetrics.buttonSpacing
        stack.alignment = .centerX
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: BryceMetrics.paletteInnerPadding),
        ])
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
