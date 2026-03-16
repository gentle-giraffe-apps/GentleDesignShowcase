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

[English](../../README.md) | [Español](README_es.md) | [Português](README_pt.md) | 日本語 | [简体中文](README_zh-CN.md) | [한국어](README_ko.md) | [Русский](README_ru.md)

<p>
  iOSのUIパターンを探索し、デザイントークン（タイポグラフィ、カラー、スペーシング、サーフェス）を
  <a href="https://github.com/gentle-giraffe-apps/GentleDesignSystem">GentleDesignSystem</a>
  でリアルタイム編集できます。
</p>

### 機能

- **ショーケースギャラリー** — 高速なプリレンダリングプレビューでiOSの一般的なUIパターンを探索 _（リビルド不要）_
- **デザインエディター** — カラー、タイポグラフィ、スペーシング、サーフェスなどのデザイントークンをリアルタイム編集 _（変更を即座に確認）_
- **共有可能なスペック** — タイポグラフィプレビューをPDFとして、デザイントークンをJSONとしてエクスポート

### はじめに

```bash
# miseをインストール（未インストールの場合）
curl https://mise.run | sh

# プロジェクトディレクトリに移動
cd GentleDesignShowcase

# Tuistをインストール（miseがmise.tomlのバージョンを使用します）
mise install

# Xcodeプロジェクトを生成
tuist generate
```

### ワークフロー
1. **Showcase**タブを閲覧して、現在のデザインでスタイリングされたテンプレートを確認
2. **Design**タブに切り替えて、カラー、タイポグラフィ、その他のトークンをカスタマイズ
3. **Showcase**タブに戻る - すべてのプレビューが自動的に更新され、変更が反映されます
4. 理想の見た目になるまでデザインを繰り返し調整

### 含まれるテンプレート
- **サインインフロー**: メール/パスワードフィールドとバリデーション付きログインフォーム
- **チャートと統計**: メトリクスとチャートによるデータビジュアライゼーション
- **ストアフロントグリッド**: ECサイト向け商品グリッドレイアウト
- **オンボーディングページャー**: ページ送り式オンボーディング体験
- **医療問診フォーム**: 複数セクションの複雑なフォーム
- **プロフィールヘッダー**: アバターとアクションボタン付きユーザープロフィール

💬 **[ディスカッションに参加する。フィードバックや質問を歓迎します](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/discussions)**

### 要件

- iOS 26.0+
- Xcode 26.0+
- Swift 6.1+

### ライセンス

このプロジェクトはMITライセンスの下で提供されています。詳細は[LICENSE](../../LICENSE)ファイルをご覧ください。

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fgentle-giraffe-apps%2FGentleDesignShowcase)
