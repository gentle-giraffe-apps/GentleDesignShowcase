<video
  align="right"
  src="https://raw.githubusercontent.com/gentle-giraffe-apps/GentleDesignShowcase/main/documentation/videos/readme_animation_preview.mp4"
  autoplay
  loop
  muted
  playsinline
  width="360">
</video>

### Gentle Design Showcase

<p>
  A showcase app for the
  <a href="https://github.com/gentle-giraffe-apps/GentleDesignSystem">GentleDesignSystem</a>
  iOS design system library.
</p>

[![CI](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/actions/workflows/ci.yml)
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/ios/)
![Swift](https://img.shields.io/badge/Swift-6.0–6.2-orange.svg)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-first-blue.svg)](https://developer.apple.com/xcode/swiftui/)
[![Tuist](https://img.shields.io/badge/Generated%20with-Tuist-blueviolet?logo=swift&logoColor=white)](https://tuist.io)
![Commit activity](https://img.shields.io/github/commit-activity/y/gentle-giraffe-apps/GentleDesignShowcase)
![Last commit](https://img.shields.io/github/last-commit/gentle-giraffe-apps/GentleDesignShowcase)

#### Features
- Showcase Gallery
  - Screen Previews
    - Browse a curated collection of common iOS UI patterns and templates
  - Pre-rendered Caching
    - Each screen is pre-rendered ahead of time and cached, enabling smooth scrolling through the showcase gallery
- Design Editor
  - Live Design Editing
    - Open the Design tab to customize design tokens including colors, typography, spacing, and surface treatments

#### Getting Started

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

#### Workflow
1. Browse the **Showcase** tab to see templates styled with the current design
2. Switch to the **Design** tab to customize colors, typography, and other tokens
3. Return to the **Showcase** tab - all previews automatically refresh to reflect your changes
4. Iterate on your design until you achieve the look you want

#### Included Templates
- **Sign-In Flow**: Login form with email/password fields and validation
- **Charts & Stats**: Data visualization with metrics and charts
- **Storefront Grid**: Product grid layout for e-commerce
- **Onboarding Pager**: Paginated onboarding experience
- **Medical Intake Form**: Complex multi-section form
- **Profile Header**: User profile with avatar and action buttons

💬 **[Join the discussion. Feedback and questions welcome](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/discussions)**

#### Requirements

- iOS 26.0+
- Xcode 26.0+
- Swift 6.0+

#### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fgentle-giraffe-apps%2FGentleDesignShowcase)

