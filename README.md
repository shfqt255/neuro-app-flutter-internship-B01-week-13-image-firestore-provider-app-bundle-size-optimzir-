# Neuro App Flutter Internship — Week 13

![Flutter](https://img.shields.io/badge/Flutter-Framework-blue)
![Dart](https://img.shields.io/badge/Dart-Language-blue)
![Firebase](https://img.shields.io/badge/Firebase-Firestore-orange)
![Provider](https://img.shields.io/badge/State%20Management-Provider-green)
![Optimization](https://img.shields.io/badge/Focus-Performance%20Optimization-red)

## Overview

This repository contains four Flutter applications developed for Week 13 of the Neuro App Flutter Internship program. The projects focus on Flutter performance optimization, efficient state management, Firestore query optimization, image optimization, and app bundle size reduction techniques.

---

# Repository Structure

| Task | Project Name | Description |
|------|------|------|
| Task 13.1 | `image_optimization_app` | Image caching, compression, resizing, and lazy loading |
| Task 13.2 | `optimized_provider_app` | Provider performance optimization and selective rebuilds |
| Task 13.3 | `optimized_firestore_app` | Firestore indexing and efficient query optimization |
| Task 13.4 | `app_bundle_size_optimization` | APK size reduction and performance optimization |

---

# Task 13.1 — Image Optimization & Caching

## Objective

Implement efficient image handling techniques in Flutter applications.

## Features

- Cached image loading using `cached_network_image`
- Image compression before upload
- Image resizing using `image` package
- Thumbnail image generation
- Lazy loading in GridView
- Placeholder widgets during image loading
- Error widgets for failed image loading
- Cache clearing functionality
- Memory optimization for large image collections

## Packages Used

```yaml
cached_network_image
flutter_image_compress
image
provider
```

## Implemented Optimizations

- Reduced image file sizes
- Optimized memory usage
- Dynamic image loading on scroll
- Faster image rendering using thumbnails

---

# Task 13.2 — State Management Optimization

## Objective

Improve Flutter application performance using advanced Provider optimization techniques.

## Features

- Split providers into smaller modules
- `context.select()` implementation
- `Selector` for selective UI rebuilds
- `Consumer2` for multiple providers
- Lazy initialization
- Pagination support
- Performance monitoring
- Optimized rebuild handling

## Packages Used

```yaml
provider
```

## Implemented Optimizations

- Reduced unnecessary rebuilds
- Avoided excessive `notifyListeners()`
- Used `const` widgets where possible
- Improved state management scalability

---

# Task 13.3 — Database Indexing & Queries

## Objective

Optimize Firebase Firestore query performance and database operations.

## Features

- Composite Firestore indexes
- Cursor-based pagination
- Efficient filtering with `array-contains`
- Batched write operations
- Optimized read and write operations
- Reduced real-time listeners

## Technologies Used

```yaml
Firebase Firestore
FlutterFire
```

## Implemented Optimizations

- Added query limits
- Implemented pagination
- Used `FieldValue.increment()`
- Replaced unnecessary realtime listeners with `get()`

---

# Task 13.4 — App Bundle Size Optimization

## Objective

Reduce Flutter APK size and improve build performance.

## Features

- Removed unused dependencies
- Enabled R8 / ProGuard
- Resource shrinking
- Deferred loading
- Asset compression
- APK size analysis

## Tools Used

```yaml
Flutter Analyze Size Tool
R8
ProGuard
```

## Implemented Optimizations

- Tree-shaking friendly imports
- Lazy feature loading
- Compressed assets
- Reduced application bundle size

---

# Technologies Used

- Flutter
- Dart
- Firebase Firestore
- Provider
- Cached Network Image
- Flutter Image Compress

---

# Getting Started

## Clone Repository

```bash
git clone <repository-url>
```

## Navigate to Project

```bash
cd image_optimization_app
```

## Install Dependencies

```bash
flutter pub get
```

## Run Application

```bash
flutter run
```

---

# Internship Module

## Month 4 — Advanced Features & Polish

### Week 13 — Performance & Optimization

- Task 13.1 — Image Optimization & Caching
- Task 13.2 — State Management Optimization
- Task 13.3 — Database Indexing & Queries
- Task 13.4 — App Bundle Size Optimization

---

# Developer

Shafqat Ullah  
Flutter Intern — Neuro App