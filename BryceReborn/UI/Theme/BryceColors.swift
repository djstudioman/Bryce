import AppKit

/// The Sacred Color Palette of Bryce
/// Every hex value here is archaeological truth
struct BryceColors {

    // MARK: - Core Interface Colors

    /// Main palette background - that iconic gunmetal
    static let paletteDark = NSColor(hex: "#2E2E2E")
    static let paletteMid = NSColor(hex: "#3D3D3D")
    static let paletteLight = NSColor(hex: "#4A4A4A")

    /// Beveled button colors
    static let buttonFace = NSColor(hex: "#505050")
    static let buttonHighlight = NSColor(hex: "#6A6A6A")
    static let buttonShadow = NSColor(hex: "#1A1A1A")
    static let buttonPressed = NSColor(hex: "#3A3A3A")

    /// Working window (viewport) background
    static let viewportBackground = NSColor(hex: "#1E1E1E")
    static let viewportGrid = NSColor(hex: "#3A3A3A")

    /// Accent colors (selection, highlights)
    static let selectionBlue = NSColor(hex: "#5B7AA9")
    static let activeOrange = NSColor(hex: "#C17F3A")

    /// Text colors
    static let textPrimary = NSColor(hex: "#D0D0D0")
    static let textSecondary = NSColor(hex: "#888888")
    static let textDisabled = NSColor(hex: "#555555")

    // MARK: - Palette Borders

    static let borderLight = NSColor(hex: "#5A5A5A")
    static let borderDark = NSColor(hex: "#1A1A1A")
}

// MARK: - NSColor Hex Extension

extension NSColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        self.init(
            sRGBRed: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: 1
        )
    }
}
