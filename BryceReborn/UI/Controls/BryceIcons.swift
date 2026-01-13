import AppKit

/// Programmatically generated icons in the Bryce style
/// These match the original aesthetic until we can import actual assets
struct BryceIcons {

    static let size = NSSize(width: 16, height: 16)

    // MARK: - Primitive Icons

    static var sphere: NSImage {
        return createIcon { context, rect in
            let inset = rect.insetBy(dx: 2, dy: 2)

            // Draw sphere with highlight
            let gradient = CGGradient(
                colorsSpace: CGColorSpaceCreateDeviceRGB(),
                colors: [
                    BryceColors.textPrimary.cgColor,
                    BryceColors.textSecondary.cgColor
                ] as CFArray,
                locations: [0.3, 1.0]
            )!

            context.addEllipse(in: inset)
            context.clip()
            context.drawRadialGradient(
                gradient,
                startCenter: CGPoint(x: inset.midX - 2, y: inset.midY + 2),
                startRadius: 0,
                endCenter: CGPoint(x: inset.midX, y: inset.midY),
                endRadius: inset.width / 2,
                options: []
            )
        }
    }

    static var cube: NSImage {
        return createIcon { context, rect in
            let inset = rect.insetBy(dx: 2, dy: 2)

            // Isometric cube
            context.setStrokeColor(BryceColors.textPrimary.cgColor)
            context.setLineWidth(1.5)

            // Front face
            let front = CGRect(x: inset.minX, y: inset.minY, width: inset.width * 0.7, height: inset.height * 0.7)
            context.stroke(front)

            // Top lines
            context.move(to: CGPoint(x: front.minX, y: front.maxY))
            context.addLine(to: CGPoint(x: front.minX + 4, y: front.maxY + 3))
            context.addLine(to: CGPoint(x: front.maxX + 4, y: front.maxY + 3))
            context.addLine(to: CGPoint(x: front.maxX, y: front.maxY))

            // Right lines
            context.move(to: CGPoint(x: front.maxX, y: front.maxY))
            context.addLine(to: CGPoint(x: front.maxX + 4, y: front.maxY + 3))
            context.addLine(to: CGPoint(x: front.maxX + 4, y: front.minY + 3))
            context.addLine(to: CGPoint(x: front.maxX, y: front.minY))

            context.strokePath()
        }
    }

    static var cylinder: NSImage {
        return createIcon { context, rect in
            let inset = rect.insetBy(dx: 3, dy: 2)

            context.setStrokeColor(BryceColors.textPrimary.cgColor)
            context.setLineWidth(1.5)

            // Top ellipse
            let topEllipse = CGRect(x: inset.minX, y: inset.maxY - 4, width: inset.width, height: 4)
            context.strokeEllipse(in: topEllipse)

            // Sides
            context.move(to: CGPoint(x: inset.minX, y: inset.maxY - 2))
            context.addLine(to: CGPoint(x: inset.minX, y: inset.minY + 2))
            context.move(to: CGPoint(x: inset.maxX, y: inset.maxY - 2))
            context.addLine(to: CGPoint(x: inset.maxX, y: inset.minY + 2))

            // Bottom ellipse (half)
            context.addArc(
                center: CGPoint(x: inset.midX, y: inset.minY + 2),
                radius: inset.width / 2,
                startAngle: 0,
                endAngle: .pi,
                clockwise: false
            )

            context.strokePath()
        }
    }

    static var terrain: NSImage {
        return createIcon { context, rect in
            let inset = rect.insetBy(dx: 1, dy: 2)

            context.setStrokeColor(BryceColors.textPrimary.cgColor)
            context.setFillColor(BryceColors.textSecondary.cgColor)
            context.setLineWidth(1.5)

            // Mountain silhouette
            context.move(to: CGPoint(x: inset.minX, y: inset.minY))
            context.addLine(to: CGPoint(x: inset.minX + 3, y: inset.midY))
            context.addLine(to: CGPoint(x: inset.midX - 1, y: inset.minY + 2))
            context.addLine(to: CGPoint(x: inset.midX + 2, y: inset.maxY - 2))  // Peak
            context.addLine(to: CGPoint(x: inset.maxX - 3, y: inset.midY - 1))
            context.addLine(to: CGPoint(x: inset.maxX, y: inset.minY))
            context.closePath()

            context.drawPath(using: .fillStroke)
        }
    }

    static var tree: NSImage {
        return createIcon { context, rect in
            let inset = rect.insetBy(dx: 3, dy: 1)

            context.setStrokeColor(BryceColors.textPrimary.cgColor)
            context.setLineWidth(1.5)

            // Trunk
            context.move(to: CGPoint(x: inset.midX, y: inset.minY))
            context.addLine(to: CGPoint(x: inset.midX, y: inset.minY + 4))

            // Foliage (triangle)
            context.move(to: CGPoint(x: inset.minX, y: inset.minY + 4))
            context.addLine(to: CGPoint(x: inset.midX, y: inset.maxY))
            context.addLine(to: CGPoint(x: inset.maxX, y: inset.minY + 4))
            context.closePath()

            context.strokePath()
        }
    }

    // MARK: - Tool Icons

    static var move: NSImage {
        return createIcon { context, rect in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let armLength: CGFloat = 5

            context.setStrokeColor(BryceColors.textPrimary.cgColor)
            context.setLineWidth(1.5)

            // Four arrows
            for angle in [0, CGFloat.pi/2, CGFloat.pi, CGFloat.pi * 1.5] {
                let dx = cos(angle) * armLength
                let dy = sin(angle) * armLength

                context.move(to: center)
                context.addLine(to: CGPoint(x: center.x + dx, y: center.y + dy))

                // Arrow head
                let headAngle1 = angle + 2.5
                let headAngle2 = angle - 2.5
                let headLength: CGFloat = 3

                context.move(to: CGPoint(x: center.x + dx, y: center.y + dy))
                context.addLine(to: CGPoint(
                    x: center.x + dx - cos(headAngle1) * headLength,
                    y: center.y + dy - sin(headAngle1) * headLength
                ))
                context.move(to: CGPoint(x: center.x + dx, y: center.y + dy))
                context.addLine(to: CGPoint(
                    x: center.x + dx - cos(headAngle2) * headLength,
                    y: center.y + dy - sin(headAngle2) * headLength
                ))
            }

            context.strokePath()
        }
    }

    static var rotate: NSImage {
        return createIcon { context, rect in
            let inset = rect.insetBy(dx: 2, dy: 2)

            context.setStrokeColor(BryceColors.textPrimary.cgColor)
            context.setLineWidth(1.5)

            // Circular arrow
            context.addArc(
                center: CGPoint(x: inset.midX, y: inset.midY),
                radius: inset.width / 2 - 1,
                startAngle: .pi / 4,
                endAngle: .pi * 1.75,
                clockwise: false
            )
            context.strokePath()

            // Arrow head
            context.move(to: CGPoint(x: inset.maxX - 2, y: inset.midY + 3))
            context.addLine(to: CGPoint(x: inset.maxX - 1, y: inset.midY - 1))
            context.addLine(to: CGPoint(x: inset.maxX - 5, y: inset.midY))
            context.strokePath()
        }
    }

    static var scale: NSImage {
        return createIcon { context, rect in
            let inset = rect.insetBy(dx: 2, dy: 2)

            context.setStrokeColor(BryceColors.textPrimary.cgColor)
            context.setLineWidth(1.5)

            // Diagonal arrow (scale indicator)
            context.move(to: CGPoint(x: inset.minX, y: inset.minY))
            context.addLine(to: CGPoint(x: inset.maxX, y: inset.maxY))

            // Small square at origin
            context.stroke(CGRect(x: inset.minX, y: inset.minY, width: 4, height: 4))

            // Larger square at end
            context.stroke(CGRect(x: inset.maxX - 5, y: inset.maxY - 5, width: 5, height: 5))

            context.strokePath()
        }
    }

    // MARK: - Helper

    private static func createIcon(_ draw: (CGContext, CGRect) -> Void) -> NSImage {
        let image = NSImage(size: size)
        image.lockFocus()

        if let context = NSGraphicsContext.current?.cgContext {
            let rect = CGRect(origin: .zero, size: size)
            draw(context, rect)
        }

        image.unlockFocus()
        image.isTemplate = true
        return image
    }
}
