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

[English](../../README.md) | [Español](README_es.md) | [Português](README_pt.md) | [日本語](README_ja.md) | [简体中文](README_zh-CN.md) | [한국어](README_ko.md) | Русский

<p>
  Исследуйте паттерны UI для iOS и редактируйте в реальном времени токены дизайна (типографика, цвет, отступы и поверхности) с помощью
  <a href="https://github.com/gentle-giraffe-apps/GentleDesignSystem">GentleDesignSystem</a>.
</p>

### Возможности

- **Галерея примеров** — Исследуйте распространённые паттерны UI для iOS с быстрыми предварительно отрендеренными превью _(без перекомпиляции)_
- **Редактор дизайна** — Редактирование токенов дизайна в реальном времени, включая цвета, типографику, отступы и поверхности _(мгновенное отображение изменений)_
- **Экспортируемые спецификации** — Экспорт превью типографики в PDF и токенов дизайна в JSON

### Начало работы

```bash
# Установить mise (если ещё не установлен)
curl https://mise.run | sh

# Перейти в директорию проекта
cd GentleDesignShowcase

# Установить Tuist (mise использует версию из mise.toml)
mise install

# Сгенерировать проект Xcode
tuist generate
```

### Рабочий процесс
1. Просматривайте вкладку **Showcase**, чтобы увидеть шаблоны, оформленные текущим дизайном
2. Переключитесь на вкладку **Design**, чтобы настроить цвета, типографику и другие токены
3. Вернитесь на вкладку **Showcase** — все превью автоматически обновятся, отражая ваши изменения
4. Повторяйте итерации, пока не достигнете желаемого результата

### Включённые шаблоны
- **Поток авторизации**: Форма входа с полями email/пароль и валидацией
- **Графики и статистика**: Визуализация данных с метриками и графиками
- **Сетка магазина**: Сеточная раскладка товаров для электронной коммерции
- **Пагинатор онбординга**: Постраничный процесс первоначальной настройки
- **Форма медицинского приёма**: Сложная форма с несколькими разделами
- **Заголовок профиля**: Профиль пользователя с аватаром и кнопками действий

💬 **[Присоединяйтесь к обсуждению. Обратная связь и вопросы приветствуются](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/discussions)**

### Требования

- iOS 26.0+
- Xcode 26.0+
- Swift 6.1+

### Лицензия

Этот проект лицензирован по лицензии MIT — подробности в файле [LICENSE](../../LICENSE).

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fgentle-giraffe-apps%2FGentleDesignShowcase)
