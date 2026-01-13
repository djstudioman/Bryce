import AppKit

/// A horizontal or vertical group of Bryce buttons with proper spacing
class BryceButtonGroup: NSStackView {

    init(buttons: [BryceButton], orientation: NSUserInterfaceLayoutOrientation = .horizontal) {
        super.init(frame: .zero)

        self.orientation = orientation
        self.spacing = BryceMetrics.buttonSpacing
        self.distribution = .fill
        self.alignment = orientation == .horizontal ? .centerY : .centerX

        buttons.forEach { addArrangedSubview($0) }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// A labeled section of buttons (common in Bryce palettes)
class BryceButtonSection: NSView {

    private let label: NSTextField
    private let buttonGroup: BryceButtonGroup

    init(title: String, buttons: [BryceButton], orientation: NSUserInterfaceLayoutOrientation = .horizontal) {
        label = NSTextField(labelWithString: title)
        buttonGroup = BryceButtonGroup(buttons: buttons, orientation: orientation)

        super.init(frame: .zero)

        setupSection()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSection() {
        // Style the label
        label.font = BryceFonts.label
        label.textColor = BryceColors.textSecondary
        label.alignment = .center

        // Layout
        label.translatesAutoresizingMaskIntoConstraints = false
        buttonGroup.translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        addSubview(buttonGroup)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),

            buttonGroup.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2),
            buttonGroup.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonGroup.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
