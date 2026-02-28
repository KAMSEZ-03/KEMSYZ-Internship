<!-- Portfolio App Architecture Documentation -->

# Portfolio App - Clean Architecture Structure

## 📁 Project Structure

```
lib/
├── main.dart                          # App Entry Point
├── app.dart                           # App Configuration & Root Widget
│
├── core/                              # Business Logic & Configuration
│   └── theme/                         # Theme Configuration
│       ├── app_colors.dart            # Color Palette
│       ├── app_text.dart              # Text Styles & Typography
│       └── app_theme.dart             # Global Theme Configuration
│
├── presentation/                      # UI & User Interface Layer
│   ├── screens/                       # Full Page Screens
│   │   └── home_screen.dart           # Main Portfolio Page (Screen Container)
│   │
│   ├── sections/                      # Page Sections / Components
│   │   ├── hero.dart                  # Hero/Banner Section
│   │   ├── about.dart                 # About Me Section
│   │   ├── services.dart              # Services Section
│   │   ├── workflow.dart              # Workflow/Process Section
│   │   ├── projects.dart              # Projects Showcase Section
│   │   ├── contact.dart               # Contact Form Section
│   │   └── footer.dart                # Footer Section
│   │
│   └── widgets/                       # Reusable UI Widgets
│       └── navbar.dart                # Navigation Bar Widget
│
└── assets/                            # Static Assets
    └── img/                           # Images & Graphics

```

## 🏗️ Architecture Layers

### **1. Core Layer** (`core/`)
Contains business logic, configuration, and constants that are not directly UI-related.

- **theme/**: All theming, colors, typography, and global styles
  - `app_colors.dart`: Centralized color constants
  - `app_text.dart`: Text styles and typography configuration
  - `app_theme.dart`: Material theme setup

### **2. Presentation Layer** (`presentation/`)
All UI-related code organized by functionality.

#### **Screens** (`presentation/screens/`)
- Full-page screens that act as containers
- Handle state management and navigation
- Aggregate multiple sections
- **Example**: `home_screen.dart` - Main portfolio page that brings all sections together

#### **Sections** (`presentation/sections/`)
- Major content sections of the app
- Self-contained features
- Can be reused across different screens
- **Examples**: Hero, About, Services, Workflow, Projects, Contact, Footer

#### **Widgets** (`presentation/widgets/`)
- Small, reusable UI components
- Shared across sections
- Highly focused on single responsibility
- **Examples**: Navigation Bar

## 📊 File Organization & Import Pattern

### Correct Import Usage

**From Presentation Files to Core:**
```dart
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
```

**From Home Screen to Sections:**
```dart
import '../sections/hero.dart';
import '../sections/about.dart';
```

**From Home Screen to Widgets:**
```dart
import '../widgets/navbar.dart';
```

## 🎯 Design Principles

### 1. **Separation of Concerns**
- Core logic separate from presentation
- Each component has a single responsibility

### 2. **Modularity**
- Sections are independent and can be modified without affecting others
- Widgets are small and focused

### 3. **Scalability**
- Easy to add new sections or widgets
- Clear directory structure for growth
- Simple navigation between screens

### 4. **Reusability**
- Widgets can be used across multiple sections
- Theme configuration is centralized
- No code duplication

## 🔄 Data Flow

```
main.dart (Entry)
    ↓
app.dart (Config)
    ↓
presentation/screens/home_screen.dart (Navigation / State)
    ↓
presentation/sections/* (Content Sections)
    ↓
presentation/widgets/* (UI Components)
    ↓
core/theme/* (Styling & Configuration)
```

## 📍 Adding New Features

### Adding a New Section
1. Create file in `lib/presentation/sections/new_section.dart`
2. Create StatelessWidget extending section functionality
3. Import in `home_screen.dart`
4. Add to Column in HomeScreen's build method
5. Set up navigation key if needed

### Adding a New Widget
1. Create file in `lib/presentation/widgets/new_widget.dart`
2. Create reusable StatelessWidget
3. Import in relevant sections

### Updating Theme
1. Update color in `lib/core/theme/app_colors.dart`
2. Update typography in `lib/core/theme/app_text.dart`
3. All app components automatically reflect changes

## ✅ Best Practices

- ✅ Keep theme configuration centralized
- ✅ Use relative imports for better refactoring
- ✅ One component per file
- ✅ Use const constructors where possible
- ✅ Keep widget tree simple and readable
- ❌ Don't import from presentation in core
- ❌ Don't mix business logic with UI
- ❌ Don't create deeply nested folder structures

## 🚀 Next Steps for Scaling

If you expand the app:

- Add `data/` layer for API calls and data management
- Add `domain/` layer for business logic and models
- Create `constants/` folder for app-wide strings
- Add `utils/` folder for helper functions
- Consider state management (Provider, Riverpod, Bloc)

