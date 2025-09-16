# MATLAB Testing with GitHub Actions

This guide explains how to set up automated testing for MATLAB repositories using GitHub Actions.

## Overview

The GitHub Actions workflow automatically runs MATLAB tests whenever code is pushed to the repository or when pull requests are created. This ensures code quality and catches issues early in the development process.

## Prerequisites

- A GitHub repository containing MATLAB code
- MATLAB test files (typically with names like `test_*.m` or `*_test.m`)
- Basic understanding of Git and GitHub

## Setup Instructions

### 1. Create the Workflow Directory

In your repository root, create the following directory structure:
```
.github/
└── workflows/
```

### 2. Create the CI Workflow File

Create a file named `ci.yml` in the `.github/workflows/` directory with the following content:

```yaml
name: CI Script
on: 
  push:
    branches: [ "main" ]
    paths-ignore:
      - 'README.md'
  pull_request:
    branches: [ "main" ]
    
  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

jobs:
  my-job:
    name: Run MATLAB Tests and Generate Artifacts
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository
        uses: actions/checkout@v4
      - name: Set up MATLAB
        uses: matlab-actions/setup-matlab@v2
      - name: Run tests and generate artifacts
        uses: matlab-actions/run-tests@v2
```

### 3. Commit and Push

Add the workflow file to your repository:

```bash
git add .github/workflows/ci.yml
git commit -m "Add GitHub Actions CI workflow for MATLAB tests"
git push
```

## Workflow Configuration Explained

### Triggers (`on` section)

- **`push` to `main` branch**: Runs tests when code is pushed to the main branch
- **`paths-ignore`**: Skips running tests when only README.md is changed
- **`pull_request`**: Runs tests on pull requests targeting the main branch
- **`workflow_dispatch`**: Allows manual triggering from the GitHub Actions tab

### Job Configuration

- **`runs-on: ubuntu-latest`**: Uses the latest Ubuntu runner (free for public repos)
- **`actions/checkout@v4`**: Downloads your repository code
- **`matlab-actions/setup-matlab@v2`**: Installs and configures MATLAB
- **`matlab-actions/run-tests@v2`**: Discovers and runs all MATLAB tests

## MATLAB Test File Requirements

Your MATLAB tests should follow these conventions:

### Test File Naming
- Files should be named with `test_` prefix (e.g., `test_fibonacci.m`)
- Or with `_test` suffix (e.g., `fibonacci_test.m`)

### Test Function Structure
```matlab
function tests = test_fibonacci
    tests = functiontests(localfunctions);
end

function test_basic_fibonacci(testCase)
    % Test basic fibonacci functionality
    result = fibonacci(5);
    expected = 5;
    verifyEqual(testCase, result, expected);
end

function test_edge_cases(testCase)
    % Test edge cases
    verifyEqual(testCase, fibonacci(0), 0);
    verifyEqual(testCase, fibonacci(1), 1);
end
```

## Customization Options

### Different Branch Names
If your main branch has a different name (e.g., `master`, `develop`):

```yaml
on: 
  push:
    branches: [ "master" ]  # Change to your branch name
  pull_request:
    branches: [ "master" ]  # Change to your branch name
```

### Additional File Ignores
To ignore other files that don't affect tests:

```yaml
on: 
  push:
    branches: [ "main" ]
    paths-ignore:
      - 'README.md'
      - 'docs/**'
      - '*.txt'
```

### Multiple MATLAB Versions
To test against multiple MATLAB versions:

```yaml
jobs:
  test:
    name: Run MATLAB Tests
    runs-on: ubuntu-latest
    strategy:
      matrix:
        matlab-version: ['R2023a', 'R2023b', 'R2024a']
    steps:
      - name: Check out repository
        uses: actions/checkout@v4
      - name: Set up MATLAB
        uses: matlab-actions/setup-matlab@v2
        with:
          release: ${{ matrix.matlab-version }}
      - name: Run tests and generate artifacts
        uses: matlab-actions/run-tests@v2
```

### Custom Test Options
To specify test options or generate coverage reports:

```yaml
      - name: Run tests and generate artifacts
        uses: matlab-actions/run-tests@v2
        with:
          test-results-junit: test-results/results.xml
          code-coverage-cobertura: code-coverage/coverage.xml
```

## Viewing Results

1. Go to your repository on GitHub
2. Click the "Actions" tab
3. Select a workflow run to see:
   - Test results
   - Console output
   - Any generated artifacts

## Troubleshooting

### Common Issues

1. **Tests not found**: Ensure test files follow naming conventions (`test_*.m` or `*_test.m`)
2. **MATLAB path issues**: Make sure all required functions are in the repository
3. **Dependency issues**: Add any required toolboxes or external dependencies

### Debugging Tips

- Check the Actions tab for detailed error messages
- Use `workflow_dispatch` to manually trigger tests for debugging
- Add debugging output to your test files if needed

## Benefits

- **Automated Testing**: Tests run automatically on every push and pull request
- **Early Issue Detection**: Catch problems before they reach production
- **Collaboration**: Team members can see test status on pull requests
- **Documentation**: Test results serve as living documentation
- **Free for Public Repos**: GitHub Actions is free for public repositories

## Next Steps

1. Add more comprehensive tests to your MATLAB code
2. Consider adding code coverage reporting
3. Set up branch protection rules requiring passing tests
4. Explore additional MATLAB Actions for deployment or packaging

For more information, visit the [MATLAB Actions documentation](https://github.com/matlab-actions).
