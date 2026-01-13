# 🏔️ Bryce Reborn

A faithful recreation of the legendary Bryce 7 3D modeling software interface using modern macOS technologies (AppKit + Metal).

## 🎨 Project Overview

This project resurrects the iconic UI of Bryce 7, the beloved 3D landscape modeling tool from the late 90s/early 2000s. We're building a "digital cathedral" - a native macOS experience that honors the original's distinctive aesthetic while leveraging modern rendering capabilities.

### Current Phase: Controls & Interaction 🎯

**Status**: Phase 2 In Progress - The sacred buttons have been resurrected!

## 🛠️ Tech Stack

- **Language**: Swift
- **UI Framework**: AppKit (native macOS)
- **Rendering**: Metal (Phase 2)
- **Target**: macOS 12.0+

## 📐 Architecture

```
BryceReborn/
├── App/
│   ├── AppDelegate.swift          # Main application entry point
│   └── MainWindow.swift            # Window controller & layout system
├── UI/
│   ├── Theme/
│   │   ├── BryceColors.swift      # Archaeological color palette
│   │   ├── BryceMetrics.swift     # Spacing, sizes, radii
│   │   └── BryceFonts.swift       # Typography system
│   ├── Controls/
│   │   ├── BryceButton.swift      # Iconic beveled buttons
│   │   ├── BryceButtonGroup.swift # Button layout helpers
│   │   └── BryceIcons.swift       # Programmatic icon generation
│   ├── Palettes/
│   │   └── PaletteViews.swift     # All palette UI components
│   └── Viewport/
│       └── ViewportView.swift     # 3D viewport (grid placeholder)
└── Resources/
```

## 🎯 UI Layout

The interface recreates Bryce 7's distinctive 5-region layout:

```
┌─────────────────────────────────────────────────────────────┐
│  CONTROL PALETTE (Top - 64px)                               │
│  View Controls | Render | Display | Selection | Nano-Preview│
├────┬──────────────────────────────────────────────────┬─────┤
│ C  │                                                   │  E  │
│ R  │           WORKING WINDOW                          │  D  │
│ E  │           (3D Viewport)                           │  I  │
│ A  │           Metal-backed with grid                  │  T  │
│ T  │                                                   │     │
│ E  │           ○ ▢ △ ◇                Move Rotate Scale│     │
│    │           ⛰️ 🌲                                    │     │
│ 72 │                                                   │ 72  │
│ px │                                                   │ px  │
├────┴──────────────────────────────────────────────────┴─────┤
│  TIMELINE (Bottom - 48px) - Animation controls              │
└─────────────────────────────────────────────────────────────┘
```

## 🎨 The Bryce Aesthetic

### Color Palette (Archaeologically Accurate)

- **Palette Background**: Gunmetal gray (#2E2E2E → #4A4A4A)
- **Viewport**: Deep black (#1E1E1E) with subtle grid
- **Buttons**: Beveled metallic with highlights
- **Text**: Light gray (#D0D0D0) on dark surfaces
- **Accents**: Selection blue (#5B7AA9), Active orange (#C17F3A)

### Key Visual Elements

- ✅ Beveled borders with light/shadow edges
- ✅ Metallic button surfaces
- ✅ Dark, focused viewport
- ✅ Compact spacing (2-8px)
- ✅ Small, condensed fonts

## 🚀 Building the Project

### Using Xcode

1. Create a new macOS App project in Xcode
2. Replace the default files with the contents of `BryceReborn/`
3. Set deployment target to macOS 12.0+
4. Build and run (⌘R)

### Manual Build

```bash
# Navigate to project
cd Bryce/BryceReborn

# Compile all Swift files
swiftc -o BryceReborn \
  App/AppDelegate.swift \
  App/MainWindow.swift \
  UI/Theme/BryceColors.swift \
  UI/Theme/BryceMetrics.swift \
  UI/Theme/BryceFonts.swift \
  UI/Controls/BryceButton.swift \
  UI/Controls/BryceButtonGroup.swift \
  UI/Controls/BryceIcons.swift \
  UI/Palettes/PaletteViews.swift \
  UI/Viewport/ViewportView.swift \
  -framework AppKit

# Run
./BryceReborn
```

## ✨ What's Implemented

| Component | Status | Description |
|-----------|--------|-------------|
| 🎨 **Color System** | ✅ Complete | Archaeological color palette from original |
| 📏 **Metrics System** | ✅ Complete | Spacing, sizing, and proportions |
| 🪟 **Main Window** | ✅ Complete | Dark themed window with proper styling |
| 📐 **Layout System** | ✅ Complete | 5-region layout matching original |
| 🎛️ **Palette Base** | ✅ Complete | Beveled borders, authentic styling |
| 🔲 **Viewport** | ✅ Grid | Placeholder with grid (Metal coming Phase 3) |
| 🔘 **BryceButton** | ✅ Complete | Beveled metallic buttons with all states |
| 🖼️ **Icon System** | ✅ Complete | Programmatic primitive & tool icons |
| ✍️ **Typography** | ✅ Complete | Complete font system |
| ⚙️ **Control Palette** | 🏗️ Shell | Top bar framework ready |
| 🎨 **Create Palette** | ✅ Complete | 5 primitive creation buttons with icons |
| ✏️ **Edit Palette** | ✅ Complete | 3 transform tool buttons (Move/Rotate/Scale) |
| ⏱️ **Timeline** | 🏗️ Shell | Animation bar framework |

## 🗺️ Roadmap

### Phase 1: UI Shell ✅
- [x] Color palette system
- [x] Layout architecture
- [x] Palette borders and styling
- [x] Viewport grid placeholder

### Phase 2: Controls & Interaction 🎯 (CURRENT)
- [x] **BryceButton** - The iconic beveled metallic buttons
- [x] Create palette primitive buttons (sphere, cube, cylinder, terrain, tree)
- [x] Edit palette transform tools (move, rotate, scale)
- [x] Icon generation system (programmatic drawing)
- [x] Complete typography system
- [ ] Control palette view/render controls
- [ ] Nano preview thumbnail
- [ ] BryceSlider - Pill-shaped value sliders

### Phase 3: Metal Rendering 🔮
- [ ] Metal pipeline setup
- [ ] Basic 3D camera
- [ ] Wireframe primitive rendering
- [ ] Grid rendering in Metal
- [ ] Simple lighting

### Phase 4: Scene Graph 🌲
- [ ] Object management
- [ ] Transform system
- [ ] Selection framework
- [ ] Hierarchy

### Phase 5: The Sacred Terrain 🏔️
- [ ] Procedural terrain generation
- [ ] Heightmap editing
- [ ] Erosion algorithms
- [ ] Bryce-style material system

## 🎭 Design Philosophy

> "We're building a digital cathedral, not a web app."

**Principles:**
1. **Authenticity First** - Honor the original's distinctive aesthetic
2. **Native macOS** - Leverage AppKit and Metal for true Mac feel
3. **No Over-Engineering** - Build what's needed, when it's needed
4. **Archaeological Accuracy** - Every color, size, and bevel matters

## 📖 Reference Materials

This project is based on careful analysis of:
- Bryce 7 Pro User Manual
- Original UI screenshots
- Community documentation
- Archaeological color sampling

## 🤝 Contributing

This is currently a solo archaeological expedition, but suggestions and historical UI insights are welcome!

## 📜 License

This is a fan recreation for educational purposes. Bryce is a trademark of DAZ 3D.

## 🏔️ Next Steps

**Recommended path forward:**

1. **🔘 Implement BryceButton** - The soul of the interface lives in those beveled buttons
2. **🎨 Flesh out Create Palette** - Add proper primitive creation buttons
3. **⬛ Set up Metal** - Get the rendering pipeline ready

The buttons are where the magic happens. Once we nail that metallic, beveled aesthetic, everything else flows naturally.

---

**Built with reverence for the digital landscapes of yesteryear.** 🏔️✨
