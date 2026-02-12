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

[English](../../README.md) | Español | [Português](README_pt.md) | [日本語](README_ja.md) | [简体中文](README_zh-CN.md) | [한국어](README_ko.md) | [Русский](README_ru.md)

<p>
  Explora patrones de interfaz de usuario de iOS y edita en vivo tokens de diseño (tipografía, color, espaciado y superficies) con
  <a href="https://github.com/gentle-giraffe-apps/GentleDesignSystem">GentleDesignSystem</a>.
</p>

### Características

- **Galería de Ejemplos** — Explora patrones comunes de UI de iOS con vistas previas pre-renderizadas y rápidas _(sin necesidad de recompilar)_
- **Editor de Diseño** — Edición en vivo de tokens de diseño incluyendo colores, tipografía, espaciado y superficies _(ve los cambios al instante)_
- **Especificaciones Compartibles** — Exporta vistas previas de tipografía como PDF y tokens de diseño como JSON

### Primeros Pasos

```bash
# Instalar mise (si no está instalado)
curl https://mise.run | sh

# Navegar al directorio del proyecto
cd GentleDesignShowcase

# Instalar Tuist (mise usará la versión de mise.toml)
mise install

# Generar el proyecto de Xcode
tuist generate
```

### Flujo de Trabajo
1. Navega por la pestaña **Showcase** para ver las plantillas estilizadas con el diseño actual
2. Cambia a la pestaña **Design** para personalizar colores, tipografía y otros tokens
3. Regresa a la pestaña **Showcase** - todas las vistas previas se actualizan automáticamente para reflejar tus cambios
4. Itera en tu diseño hasta lograr el aspecto que deseas

### Plantillas Incluidas
- **Flujo de Inicio de Sesión**: Formulario de login con campos de email/contraseña y validación
- **Gráficos y Estadísticas**: Visualización de datos con métricas y gráficos
- **Tienda en Cuadrícula**: Diseño de cuadrícula de productos para comercio electrónico
- **Paginador de Onboarding**: Experiencia de incorporación paginada
- **Formulario de Admisión Médica**: Formulario complejo de múltiples secciones
- **Encabezado de Perfil**: Perfil de usuario con avatar y botones de acción

💬 **[Únete a la discusión. Comentarios y preguntas son bienvenidos](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/discussions)**

### Requisitos

- iOS 26.0+
- Xcode 26.0+
- Swift 6.1+

### Licencia

Este proyecto está licenciado bajo la Licencia MIT - consulta el archivo [LICENSE](../../LICENSE) para más detalles.

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fgentle-giraffe-apps%2FGentleDesignShowcase)
