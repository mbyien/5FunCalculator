# 5FunCalc

**5FunCalc** is a simple calculator app built using SwiftUI. It supports basic arithmetic operations, a clean interface, and responsive layout optimized for iPhone devices.

![screenshot](screenshot.png) <!-- Optional: Add a screenshot if available -->

## 🚀 Features

- Basic operations: `+`, `−`, `×`, `÷`, `%`
- Sign toggle: `+/-`
- Decimal input
- Clear (`AC`) functionality
- Clean, minimal design with dynamic layout
- Result formatting (e.g., `3` instead of `3.0`)

## 🧠 Logic Overview

- Calculator buttons are defined using an `enum` (`CalcButton`) for easy layout and styling.
- The core calculation logic is handled inside the `didTap(button:)` function.
- Operations are represented via an `Operation` enum and executed based on the current state.
- UI is rendered using a grid-like structure of buttons via `ForEach` loops.
- Special formatting is added to display a clean value without unnecessary decimal points.

## 📁 File Structure

5FunCalc/
├── ContentView.swift # Main UI and logic
├── Assets.xcassets/ # App assets and colors
├── 5FunCalcApp.swift # App entry point
└── ...

## 📱 Screens

- Top display shows current input and active operation.
- Calculator buttons are styled and spaced consistently.
- `0` button spans two columns for better UX.

## 🔧 Requirements

- Xcode 14 or later
- iOS 15+
- Swift 5+

## 🛠 How to Build

1. Open `5FunCalc.xcodeproj` in Xcode.
2. Select your target device or simulator.
3. Press **Cmd + R** to build and run the app.

## ✅ To-Do / Improvements

- Add scientific calculator functions (square root, power, etc.)
- Implement haptic feedback
- Add landscape support
- Save recent calculations
- Dark/light mode toggle

## 📄 License

MIT License — feel free to use and modify!

---