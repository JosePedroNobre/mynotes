# Notes Application

## Overview

This project is a Flutter-based Notes Application that includes features for searching, sorting, and filtering notes, as well as tagging and grouping notes. Additionally, it supports saving notes as PDF files and integrates with a simple REST backend for persistent storage alongside a mocked database.

## Features

- **Search Notes**: Allows users to search notes by title or content.
- **Sort Notes**: Provides options to sort notes in the list view.
- **Filter Notes**: Enables filtering of notes based on tags.
- **Save Note as PDF**: Users can save individual notes as PDF files.
- **Tagging or Grouping**: Notes can be tagged or grouped for better organization.
- **Encryption**: Notes can be encrypted, logic was done and can be tested under notes_encryption_test.dart
- **Themes**: Used custom themes for the text and buttons
- **Backend Integration**: Includes a simple REST backend to store notes in an external source alongside a mocked database.

## Running the Tests

### Unit Tests

To run the unit tests for the project, follow these steps:

1. **Open Terminal**: Navigate to the root directory of your Flutter project.

2. **Run Unit Tests**: Use the following command to execute the unit tests:
   ```bash
   flutter test
