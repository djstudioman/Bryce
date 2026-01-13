import AppKit

// MARK: - Button Style Variants

enum BryceButtonStyle {
    case standard           // Rectangular beveled button
    case triangleLeft       // Iconic left-pointing triangle
    case triangleRight      // Right-pointing triangle
    case triangleUp         // Up-pointing triangle
    case triangleDown       // Down-pointing triangle
    case small              // Compact square button
    case toggle             // Button with on/off state
}

enum BryceButtonState {
    case normal
    case hover
    case pressed
    case disabled
}

// MARK: - BryceButton

class BryceButton: NSView {

    // MARK: - Properties

    var style: BryceButtonStyle = .standard {
        didSet { needsDisplay = true }
    }

    var icon: NSImage? {
        didSet { needsDisplay = true }
    }

    var isToggle: Bool = false
    var isOn: Bool = false {
        didSet { needsDisplay = true }
    }

    var isEnabled: Bool = true {
        didSet {
            needsDisplay = true
            alphaValue = isEnabled ? 1.0 : 0.6
        }
    }

    var action: (() -> Void)?
    var toolTip: String? {
        didSet { self.toolTip = toolTip }
    }

    private var currentState: BryceButtonState = .normal {
        didSet { needsDisplay = true }
    }

    private var trackingArea: NSTrackingArea?

    // MARK: - Initialization

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    convenience init(style: BryceButtonStyle, icon: NSImage? = nil) {
        let size: CGSize
        switch style {
        case .small:
            size = BryceMetrics.smallButtonSize
        default:
            size = BryceMetrics.largeButtonSize
        }
        self.init(frame: NSRect(origin: .zero, size: size))
        self.style = style
        self.icon = icon
    }

    private func setupButton() {
        wantsLayer = true
        updateTrackingAreas()
    }

    // MARK: - Tracking Areas (Hover Detection)

    override func updateTrackingAreas() {
        if let existing = trackingArea {
            removeTrackingArea(existing)
        }

        trackingArea = NSTrackingArea(
            rect: bounds,
            options: [.mouseEnteredAndExited, .activeInKeyWindow, .inVisibleRect],
            owner: self,
            userInfo: nil
        )
        addTrackingArea(trackingArea!)
    }

    // MARK: - Mouse Events

    override func mouseEntered(with event: NSEvent) {
        guard isEnabled else { return }
        currentState = .hover
    }

    override func mouseExited(with event: NSEvent) {
        guard isEnabled else { return }
        currentState = .normal
    }

    override func mouseDown(with event: NSEvent) {
        guard isEnabled else { return }
        currentState = .pressed
    }

    override func mouseUp(with event: NSEvent) {
        guard isEnabled else { return }

        let location = convert(event.locationInWindow, from: nil)
        if bounds.contains(location) {
            // Toggle state if it's a toggle button
            if isToggle {
                isOn.toggle()
            }
            action?()
        }

        currentState = bounds.contains(location) ? .hover : .normal
    }

    // MARK: - Drawing

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        guard let context = NSGraphicsContext.current?.cgContext else { return }

        switch style {
        case .triangleLeft, .triangleRight, .triangleUp, .triangleDown:
            drawTriangleButton(context: context)
        default:
            drawStandardButton(context: context)
        }

        // Draw icon if present
        if let icon = icon {
            drawIcon(icon, context: context)
        }
    }

    // MARK: - Standard Button Drawing

    private func drawStandardButton(context: CGContext) {
        let rect = bounds.insetBy(dx: 1, dy: 1)
        let cornerRadius = BryceMetrics.buttonCornerRadius
        let path = CGPath(roundedRect: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)

        let isPressed = currentState == .pressed || (isToggle && isOn)

        // 1. Draw button face with gradient
        context.saveGState()
        context.addPath(path)
        context.clip()

        let faceColors: [CGColor]
        if isPressed {
            faceColors = [
                BryceColors.buttonPressed.cgColor,
                BryceColors.buttonShadow.cgColor
            ]
        } else if currentState == .hover {
            faceColors = [
                BryceColors.buttonHighlight.cgColor,
                BryceColors.buttonFace.cgColor
            ]
        } else {
            faceColors = [
                BryceColors.buttonFace.cgColor,
                BryceColors.buttonPressed.cgColor
            ]
        }

        let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: faceColors as CFArray,
            locations: [0.0, 1.0]
        )!

        context.drawLinearGradient(
            gradient,
            start: CGPoint(x: rect.midX, y: rect.maxY),
            end: CGPoint(x: rect.midX, y: rect.minY),
            options: []
        )
        context.restoreGState()

        // 2. Draw beveled edges
        drawBevel(context: context, rect: rect, cornerRadius: cornerRadius, isPressed: isPressed)

        // 3. Draw toggle indicator if on
        if isToggle && isOn {
            drawToggleIndicator(context: context, rect: rect)
        }
    }

    // MARK: - Bevel Drawing (The Soul of Bryce Buttons)

    private func drawBevel(context: CGContext, rect: CGRect, cornerRadius: CGFloat, isPressed: Bool) {
        let highlightColor = isPressed ? BryceColors.borderDark : BryceColors.borderLight
        let shadowColor = isPressed ? BryceColors.borderLight : BryceColors.borderDark

        context.setLineWidth(1.0)

        // Top edge (highlight or shadow when pressed)
        context.setStrokeColor(highlightColor.cgColor)
        context.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
        context.strokePath()

        // Left edge
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        context.strokePath()

        // Bottom edge (shadow or highlight when pressed)
        context.setStrokeColor(shadowColor.cgColor)
        context.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        context.strokePath()

        // Right edge
        context.move(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius))
        context.strokePath()
    }

    // MARK: - Triangle Button Drawing (Iconic Bryce Shape)

    private func drawTriangleButton(context: CGContext) {
        let inset: CGFloat = 4
        let rect = bounds.insetBy(dx: inset, dy: inset)

        let path = CGMutablePath()

        switch style {
        case .triangleLeft:
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()

        case .triangleRight:
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()

        case .triangleUp:
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.closeSubpath()

        case .triangleDown:
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()

        default:
            break
        }

        let isPressed = currentState == .pressed || (isToggle && isOn)

        // Fill with gradient
        context.saveGState()
        context.addPath(path)
        context.clip()

        let faceColors: [CGColor] = isPressed ? [
            BryceColors.buttonPressed.cgColor,
            BryceColors.buttonShadow.cgColor
        ] : [
            BryceColors.buttonFace.cgColor,
            BryceColors.buttonPressed.cgColor
        ]

        let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: faceColors as CFArray,
            locations: [0.0, 1.0]
        )!

        context.drawLinearGradient(
            gradient,
            start: CGPoint(x: rect.midX, y: rect.maxY),
            end: CGPoint(x: rect.midX, y: rect.minY),
            options: []
        )
        context.restoreGState()

        // Draw triangle bevel
        drawTriangleBevel(context: context, path: path, isPressed: isPressed)
    }

    private func drawTriangleBevel(context: CGContext, path: CGPath, isPressed: Bool) {
        let highlightColor = isPressed ? BryceColors.borderDark : BryceColors.borderLight
        let shadowColor = isPressed ? BryceColors.borderLight : BryceColors.borderDark

        context.setLineWidth(1.5)

        // Stroke with highlight on top edges
        context.addPath(path)
        context.setStrokeColor(highlightColor.cgColor)
        context.strokePath()

        // Inner shadow effect
        context.saveGState()
        context.addPath(path)
        context.clip()

        let shadowOffset = isPressed ? CGSize(width: -1, height: 1) : CGSize(width: 1, height: -1)
        context.setShadow(offset: shadowOffset, blur: 2, color: shadowColor.cgColor)
        context.addPath(path)
        context.setStrokeColor(NSColor.clear.cgColor)
        context.setLineWidth(3)
        context.strokePath()

        context.restoreGState()
    }

    // MARK: - Icon Drawing

    private func drawIcon(_ icon: NSImage, context: CGContext) {
        let isPressed = currentState == .pressed || (isToggle && isOn)

        // Calculate icon rect (centered, with press offset)
        var iconRect = CGRect(
            x: (bounds.width - icon.size.width) / 2,
            y: (bounds.height - icon.size.height) / 2,
            width: icon.size.width,
            height: icon.size.height
        )

        // Shift icon when pressed (tactile feedback)
        if isPressed {
            iconRect = iconRect.offsetBy(dx: 1, dy: -1)
        }

        // Draw icon shadow (embossed effect)
        if !isPressed {
            let shadowRect = iconRect.offsetBy(dx: 1, dy: -1)
            icon.draw(in: shadowRect, from: .zero, operation: .sourceOver, fraction: 0.3)
        }

        // Draw the icon
        let iconAlpha: CGFloat = isEnabled ? 1.0 : 0.5
        icon.draw(in: iconRect, from: .zero, operation: .sourceOver, fraction: iconAlpha)
    }

    // MARK: - Toggle Indicator

    private func drawToggleIndicator(context: CGContext, rect: CGRect) {
        // Small colored dot or highlight to show toggle is active
        let indicatorSize: CGFloat = 4
        let indicatorRect = CGRect(
            x: rect.maxX - indicatorSize - 3,
            y: rect.minY + 3,
            width: indicatorSize,
            height: indicatorSize
        )

        context.setFillColor(BryceColors.activeOrange.cgColor)
        context.fillEllipse(in: indicatorRect)
    }
}
