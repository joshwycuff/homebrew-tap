# Homebrew Tap

This repository contains a curated collection of Homebrew **Brewfiles**, custom formulae, and utilities for managing my development environment.

---

## Features

- **Brewfile Bundles**: Easily manage and install collections of Homebrew formulae and casks tailored to different use cases (e.g., development, design, etc.).
- **Custom Formulae**: Access unique formulae not available in the main Homebrew repositories.
- **Helper CLI**: Use the `jw-tap` command-line tool to simplify working with the tap.

---

## Getting Started

### 1. Add the Tap

To access the contents of this tap, add it to your Homebrew installation:

```bash
brew tap joshwycuff/tap
```

---

### 2. Install Brewfiles

This tap may include several **Brewfiles** for different setups:

#### Available Brewfiles

- `main`: Essential tools for any system.

---

### 3. Use the `jw-tap` CLI

The `jw-tap` CLI is a helper tool for managing this tap. With `jw-tap`.

#### Install `jw-tap`

```bash
brew install jw-tap
```

#### Commands

- **Install a Brewfile**:
  ```bash
  jw-tap bundle <Brewfile>
  ```
