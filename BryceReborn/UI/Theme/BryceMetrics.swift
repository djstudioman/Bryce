import Foundation

/// Spacing, sizes, and proportions faithful to the original
struct BryceMetrics {

    // MARK: - Window

    static let defaultWindowSize = CGSize(width: 1024, height: 768)
    static let minimumWindowSize = CGSize(width: 800, height: 600)

    // MARK: - Palettes

    static let controlPaletteHeight: CGFloat = 64
    static let sidePaletteWidth: CGFloat = 72
    static let timelineHeight: CGFloat = 48

    // MARK: - Buttons

    static let buttonCornerRadius: CGFloat = 3
    static let smallButtonSize = CGSize(width: 28, height: 28)
    static let largeButtonSize = CGSize(width: 36, height: 36)

    // MARK: - Spacing

    static let paletteInnerPadding: CGFloat = 6
    static let buttonSpacing: CGFloat = 2
    static let sectionSpacing: CGFloat = 8

    // MARK: - Nano Preview

    static let nanoPreviewSize = CGSize(width: 80, height: 60)

    // MARK: - Borders

    static let borderWidth: CGFloat = 1
    static let bezelDepth: CGFloat = 2
}
