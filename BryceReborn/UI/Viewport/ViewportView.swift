import AppKit

// MARK: - Viewport (Metal-backed, placeholder for now)

class ViewportView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = BryceColors.viewportBackground.cgColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.backgroundColor = BryceColors.viewportBackground.cgColor
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Draw placeholder grid (will be replaced by Metal)
        BryceColors.viewportGrid.setStroke()

        let gridSpacing: CGFloat = 40
        let path = NSBezierPath()
        path.lineWidth = 0.5

        // Vertical lines
        var x: CGFloat = 0
        while x < bounds.width {
            path.move(to: NSPoint(x: x, y: 0))
            path.line(to: NSPoint(x: x, y: bounds.height))
            x += gridSpacing
        }

        // Horizontal lines
        var y: CGFloat = 0
        while y < bounds.height {
            path.move(to: NSPoint(x: 0, y: y))
            path.line(to: NSPoint(x: bounds.width, y: y))
            y += gridSpacing
        }

        path.stroke()

        // Add center label
        let label = "3D Viewport\n(Metal rendering will go here)"
        let attrs: [NSAttributedString.Key: Any] = [
            .font: BryceFonts.regular,
            .foregroundColor: BryceColors.textSecondary
        ]
        let size = label.size(withAttributes: attrs)
        let rect = NSRect(
            x: (bounds.width - size.width) / 2,
            y: (bounds.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
        label.draw(in: rect, withAttributes: attrs)
    }
}
