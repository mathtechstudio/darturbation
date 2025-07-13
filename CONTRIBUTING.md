# Contributing to Darturbation

We welcome and appreciate contributions to the Darturbation project! Whether you're fixing a bug, adding a new feature, improving documentation, or suggesting an enhancement, your help is valuable.

Please take a moment to review this document to make the contribution process as smooth as possible for everyone.

## Table of Contents

- [Contributing to Darturbation](#contributing-to-darturbation)
  - [Table of Contents](#table-of-contents)
  - [Code of Conduct](#code-of-conduct)
  - [How to Contribute](#how-to-contribute)
    - [Reporting Bugs](#reporting-bugs)
    - [Suggesting Enhancements](#suggesting-enhancements)
    - [Contributing Code](#contributing-code)
  - [Local Development Setup](#local-development-setup)
  - [Code Style and Standards](#code-style-and-standards)
  - [Testing](#testing)
  - [Commit Messages](#commit-messages)
  - [Pull Request Process](#pull-request-process)
  - [Project-Specific Guidelines](#project-specific-guidelines)

## Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct.html). By participating, you are expected to uphold this code.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue on our [GitHub Issue Tracker](https://github.com/mathtechstudio/darturbation/issues) and provide the following information:

- **Clear and concise description** of the bug.
- **Steps to reproduce** the behavior.
- **Expected behavior** vs. actual behavior.
- **Screenshots or code snippets** if applicable.
- Your **Dart/Flutter version** and operating system.

### Suggesting Enhancements

Have an idea for a new feature or an improvement? We'd love to hear it! Please open an issue on the [GitHub Issue Tracker](https://github.com/mathtechstudio/darturbation/issues) and describe:

- **The problem** you're trying to solve.
- **Your proposed solution** or idea.
- **Why this enhancement** would be beneficial to the project.

### Contributing Code

1. **Fork the repository** on GitHub.
2. **Clone your forked repository** to your local machine.

    ```bash
    git clone https://github.com/your-username/darturbation.git
    cd darturbation
    ```

3. **Create a new branch** for your feature or bug fix.

    ```bash
    git checkout -b feature/your-feature-name
    # or
    git checkout -b bugfix/issue-description
    ```

4. **Make your changes** (see [Code Style and Standards](#code-style-and-standards) and [Testing](#testing)).
5. **Commit your changes** (see [Commit Messages](#commit-messages)).
6. **Push your branch** to your forked repository.

    ```bash
    git push origin feature/your-feature-name
    ```

7. **Open a Pull Request** (PR) to the `main` branch of the original `darturbation` repository.

## Local Development Setup

1. **Install Dart SDK** (or Flutter SDK, which includes Dart).
2. **Clone the repository** (if you haven't already).
3. **Get dependencies**:

    ```bash
    dart pub get
    ```

## Code Style and Standards

- **Adhere to existing conventions:** When modifying code, always analyze the surrounding code, tests, and configuration to mimic the existing style (formatting, naming), structure, framework choices, typing, and architectural patterns.
- **Formatting:** Ensure your code is formatted using `dart format`.

    ```bash
    dart format .
    ```

- **Analysis:** Run `dart analyze` to catch any linting or analysis issues before committing.

    ```bash
    dart analyze .
    ```

- **Comments:** Add code comments sparingly. Focus on *why* something is done, especially for complex logic, rather than *what* is done.

## Testing

- **Run existing tests:** Before submitting a PR, ensure all existing tests pass.

    ```bash
    dart test
    ```

- **Add new tests:** For new features, add unit tests to cover the new functionality. For bug fixes, add a test that reproduces the bug and then verifies the fix.
- **Test coverage:** Aim for high test coverage, especially for core logic.

## Commit Messages

We follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification for our commit messages. This helps with automated changelog generation and understanding the purpose of each commit.

Examples:

- `feat: Add streaming support for user generation`
- `fix: Correct order item count in OrderGenerator`
- `docs: Update README with streaming examples`
- `ci: Configure GitHub Actions for pub.dev publishing`
- `refactor: Consolidate model definitions`

## Pull Request Process

1. **Ensure your branch is up-to-date** with the `main` branch of the original repository.
2. **Provide a clear and concise description** of your changes in the PR description.
3. **Reference any related issues** (e.g., `Fixes #123`, `Closes #456`).
4. **Ensure all tests pass** and `dart analyze` reports no issues.
5. **Be responsive** to feedback during the review process.

## Project-Specific Guidelines

Darturbation has some unique aspects to keep in mind:

- **Indonesian-First Approach:** When contributing data or features related to localization, prioritize and maintain the authenticity of Indonesian cultural context (names, addresses, patterns).
- **Context-Aware Generation:** New generators or features should aim to maintain and enhance the logical relationships and consistency between generated data entities.
- **Behavioral Pattern Simulation:** Contributions that deepen the realism of behavioral patterns (e.g., new user types, more complex seasonal trends) are highly valued.
- **Performance and Memory Efficiency:** For large dataset generation, always consider the performance and memory footprint of your changes, especially when working with streaming features.
- **Documentation:** Clear and comprehensive documentation for new features or changes is crucial. Update relevant sections of the `README.md` and add comments where necessary.
