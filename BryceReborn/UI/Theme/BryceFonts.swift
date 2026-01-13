import AppKit

/// Typography faithful to the original Bryce aesthetic
struct BryceFonts {

    // MARK: - UI Fonts

    /// Tiny labels on palettes
    static let label = NSFont.systemFont(ofSize: 9, weight: .medium)

    /// Button text (rarely used - most are icons)
    static let button = NSFont.systemFont(ofSize: 10, weight: .semibold)

    /// Value readouts on sliders
    static let value = NSFont.monospacedDigitSystemFont(ofSize: 10, weight: .regular)

    /// Section headers
    static let sectionHeader = NSFont.systemFont(ofSize: 11, weight: .semibold)

    /// Dialog text
    static let body = NSFont.systemFont(ofSize: 12, weight: .regular)

    /// Window titles
    static let title = NSFont.systemFont(ofSize: 13, weight: .semibold)

    // MARK: - Legacy Aliases (for compatibility)

    /// Small condensed font for labels and buttons
    static let smallCondensed = NSFont.systemFont(ofSize: 10, weight: .medium)

    /// Regular UI font
    static let regular = NSFont.systemFont(ofSize: 11, weight: .regular)

    /// Bold UI font for emphasis
    static let bold = NSFont.systemFont(ofSize: 11, weight: .semibold)

    /// Tiny font for secondary info
    static let tiny = NSFont.systemFont(ofSize: 9, weight: .regular)
}
