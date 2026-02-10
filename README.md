<img align="right" src="GentleDesignShowcase/documentation/videos/light_preview.gif#gh-light-mode-only" width="360" />
<img align="right" src="GentleDesignShowcase/documentation/videos/dark_preview.gif#gh-dark-mode-only" width="360" />

<img src="GentleDesignShowcase/documentation/images/gentle_design_showcase_light.png#gh-light-mode-only"
     width="400"
     alt="GentleDesignShowcase" />

<img src="GentleDesignShowcase/documentation/images/gentle_design_showcase_dark.png#gh-dark-mode-only"
     width="400"
     alt="GentleDesignShowcase" />

[![CI](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/gentle-giraffe-apps/GentleDesignShowcase/graph/badge.svg)](https://codecov.io/gh/gentle-giraffe-apps/GentleDesignShowcase)
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/ios/)
![Swift](https://img.shields.io/badge/Swift-6.0–6.2-orange.svg)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-first-blue.svg)](https://developer.apple.com/xcode/swiftui/)
[![Tuist](https://img.shields.io/badge/Generated%20with-Tuist-blueviolet?logo=swift&logoColor=white)](https://tuist.io)
![Commit activity](https://img.shields.io/github/commit-activity/y/gentle-giraffe-apps/GentleDesignShowcase)
![Last commit](https://img.shields.io/github/last-commit/gentle-giraffe-apps/GentleDesignShowcase)

<p>
  Explore iOS UI patterns and live-edit design tokens (type, color, spacing, and surfaces) powered by
  <a href="https://github.com/gentle-giraffe-apps/GentleDesignSystem">GentleDesignSystem</a>.
</p>

### Features

- **Showcase Gallery** — Explore common iOS UI patterns with fast, pre-rendered previews _(no rebuilds required)_
- **Design Editor** — Live editing of design tokens including colors, typography, spacing, and surfaces _(see changes instantly)_
- **Shareable Specs** — Export typography previews as PDF and design tokens as JSON

### Getting Started

```bash
# Install mise (if not already installed)
curl https://mise.run | sh

# Navigate to the project directory
cd GentleDesignShowcase

# Install Tuist (mise will use the version from mise.toml)
mise install

# Generate the Xcode project
tuist generate
```

### Workflow
1. Browse the **Showcase** tab to see templates styled with the current design
2. Switch to the **Design** tab to customize colors, typography, and other tokens
3. Return to the **Showcase** tab - all previews automatically refresh to reflect your changes
4. Iterate on your design until you achieve the look you want

### Included Templates
- **Sign-In Flow**: Login form with email/password fields and validation
- **Charts & Stats**: Data visualization with metrics and charts
- **Storefront Grid**: Product grid layout for e-commerce
- **Onboarding Pager**: Paginated onboarding experience
- **Medical Intake Form**: Complex multi-section form
- **Profile Header**: User profile with avatar and action buttons

💬 **[Join the discussion. Feedback and questions welcome](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/discussions)**

### Requirements

- iOS 26.0+
- Xcode 26.0+
- Swift 6.0+

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fgentle-giraffe-apps%2FGentleDesignShowcase)

