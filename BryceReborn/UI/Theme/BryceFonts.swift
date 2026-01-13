import AppKit

/// Typography system for the Bryce interface
struct BryceFonts {

    // MARK: - UI Fonts

    /// Small condensed font for labels and buttons
    static let smallCondensed = NSFont.systemFont(ofSize: 10, weight: .medium)

    /// Regular UI font
    static let regular = NSFont.systemFont(ofSize: 11, weight: .regular)

    /// Bold UI font for emphasis
    static let bold = NSFont.systemFont(ofSize: 11, weight: .semibold)

    /// Tiny font for secondary info
    static let tiny = NSFont.systemFont(ofSize: 9, weight: .regular)
}
