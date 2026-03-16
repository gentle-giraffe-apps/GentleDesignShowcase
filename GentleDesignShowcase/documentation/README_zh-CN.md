<img align="right" src="videos/light_preview.gif#gh-light-mode-only" width="360" />
<img align="right" src="videos/dark_preview.gif#gh-dark-mode-only" width="360" />

<img src="images/gentle_design_showcase_light.png#gh-light-mode-only"
     width="400"
     alt="GentleDesignShowcase" />

<img src="images/gentle_design_showcase_dark.png#gh-dark-mode-only"
     width="400"
     alt="GentleDesignShowcase" />

[![CI](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/gentle-giraffe-apps/GentleDesignShowcase/graph/badge.svg)](https://codecov.io/gh/gentle-giraffe-apps/GentleDesignShowcase)
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/ios/)
![Swift](https://img.shields.io/badge/Swift-6.1+-orange.svg)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-first-blue.svg)](https://developer.apple.com/xcode/swiftui/)
[![Tuist](https://img.shields.io/badge/Generated%20with-Tuist-blueviolet?logo=swift&logoColor=white)](https://tuist.io)
![Commit activity](https://img.shields.io/github/commit-activity/y/gentle-giraffe-apps/GentleDesignShowcase)
![Last commit](https://img.shields.io/github/last-commit/gentle-giraffe-apps/GentleDesignShowcase)

[English](../../README.md) | [Español](README_es.md) | [Português](README_pt.md) | [日本語](README_ja.md) | 简体中文 | [한국어](README_ko.md) | [Русский](README_ru.md)

<p>
  探索 iOS UI 模式，并使用
  <a href="https://github.com/gentle-giraffe-apps/GentleDesignSystem">GentleDesignSystem</a>
  实时编辑设计令牌（字体、颜色、间距和表面）。
</p>

### 功能

- **展示画廊** — 通过快速预渲染的预览探索常见的 iOS UI 模式 _（无需重新编译）_
- **设计编辑器** — 实时编辑设计令牌，包括颜色、字体、间距和表面 _（即时查看更改）_
- **可共享规格** — 将字体预览导出为 PDF，将设计令牌导出为 JSON

### 快速开始

```bash
# 安装 mise（如果尚未安装）
curl https://mise.run | sh

# 进入项目目录
cd GentleDesignShowcase

# 安装 Tuist（mise 将使用 mise.toml 中的版本）
mise install

# 生成 Xcode 项目
tuist generate
```

### 工作流程
1. 浏览 **Showcase** 标签页，查看使用当前设计样式化的模板
2. 切换到 **Design** 标签页，自定义颜色、字体和其他令牌
3. 返回 **Showcase** 标签页 - 所有预览会自动刷新以反映您的更改
4. 反复迭代设计，直到达到理想效果

### 包含的模板
- **登录流程**：带有邮箱/密码字段和验证的登录表单
- **图表与统计**：带有指标和图表的数据可视化
- **商店网格**：电子商务产品网格布局
- **引导页**：分页式新手引导体验
- **医疗登记表**：复杂的多部分表单
- **个人资料头部**：带有头像和操作按钮的用户个人资料

💬 **[加入讨论。欢迎反馈和提问](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/discussions)**

### 要求

- iOS 26.0+
- Xcode 26.0+
- Swift 6.1+

### 许可证

本项目基于 MIT 许可证授权 - 详情请参阅 [LICENSE](../../LICENSE) 文件。

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fgentle-giraffe-apps%2FGentleDesignShowcase)
