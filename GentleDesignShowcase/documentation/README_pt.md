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

[English](../../README.md) | [Español](README_es.md) | Português | [日本語](README_ja.md) | [简体中文](README_zh-CN.md) | [한국어](README_ko.md) | [Русский](README_ru.md)

<p>
  Explore padrões de UI do iOS e edite em tempo real tokens de design (tipografia, cor, espaçamento e superfícies) com
  <a href="https://github.com/gentle-giraffe-apps/GentleDesignSystem">GentleDesignSystem</a>.
</p>

### Funcionalidades

- **Galeria de Exemplos** — Explore padrões comuns de UI do iOS com pré-visualizações rápidas e pré-renderizadas _(sem necessidade de recompilar)_
- **Editor de Design** — Edição em tempo real de tokens de design incluindo cores, tipografia, espaçamento e superfícies _(veja as alterações instantaneamente)_
- **Especificações Compartilháveis** — Exporte pré-visualizações de tipografia como PDF e tokens de design como JSON

### Primeiros Passos

```bash
# Instalar mise (se ainda não estiver instalado)
curl https://mise.run | sh

# Navegar até o diretório do projeto
cd GentleDesignShowcase

# Instalar Tuist (mise usará a versão do mise.toml)
mise install

# Gerar o projeto Xcode
tuist generate
```

### Fluxo de Trabalho
1. Navegue pela aba **Showcase** para ver os templates estilizados com o design atual
2. Mude para a aba **Design** para personalizar cores, tipografia e outros tokens
3. Retorne à aba **Showcase** - todas as pré-visualizações são atualizadas automaticamente para refletir suas alterações
4. Itere no seu design até alcançar o visual desejado

### Templates Incluídos
- **Fluxo de Login**: Formulário de login com campos de email/senha e validação
- **Gráficos e Estatísticas**: Visualização de dados com métricas e gráficos
- **Grade de Loja**: Layout de grade de produtos para e-commerce
- **Paginador de Onboarding**: Experiência de integração paginada
- **Formulário de Admissão Médica**: Formulário complexo com múltiplas seções
- **Cabeçalho de Perfil**: Perfil do usuário com avatar e botões de ação

💬 **[Participe da discussão. Comentários e perguntas são bem-vindos](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/discussions)**

### Requisitos

- iOS 26.0+
- Xcode 26.0+
- Swift 6.1+

### Licença

Este projeto está licenciado sob a Licença MIT - consulte o arquivo [LICENSE](../../LICENSE) para mais detalhes.

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fgentle-giraffe-apps%2FGentleDesignShowcase)
