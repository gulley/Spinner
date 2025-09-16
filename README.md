# Spinner

Simulation of a spinning beam

## Fibonacci Function

This repository contains a MATLAB implementation of the Fibonacci sequence calculator along with comprehensive unit tests.

### Files

- `fibonacci.m` - Main function that calculates the nth Fibonacci number
- `test_fibonacci.m` - Comprehensive unit test suite
- `README.md` - This documentation file

### Usage

#### Basic Usage
```matlab
% Calculate the 10th Fibonacci number
result = fibonacci(10);  % Returns 55

% Calculate the first few Fibonacci numbers
for i = 0:10
    fprintf('F(%d) = %d\n', i, fibonacci(i));
end
```

#### Running Tests
```matlab
% Run all tests using the test class
test_fibonacci.runAllTests();

% Or run tests using MATLAB's test runner
runtests('test_fibonacci');
```

### Function Details

The `fibonacci` function:
- Uses an efficient iterative algorithm (O(n) time complexity)
- Includes comprehensive input validation
- Handles edge cases (F(0) = 0, F(1) = 1)
- Supports large Fibonacci numbers

### Test Coverage

The test suite includes:
- **Base cases**: F(0) = 0, F(1) = 1
- **Known values**: Tests against the first 13 Fibonacci numbers
- **Larger values**: Tests F(15), F(20), F(25)
- **Recurrence relation**: Verifies F(n) = F(n-1) + F(n-2)
- **Error handling**: Tests for invalid inputs (negative, non-integer, non-scalar, non-numeric)
- **Performance**: Ensures efficient computation for large inputs

### Requirements

- MATLAB R2013a or later (for the unittest framework)

### Examples

```matlab
fibonacci(0)   % Returns 0
fibonacci(1)   % Returns 1
fibonacci(5)   % Returns 5
fibonacci(10)  % Returns 55
fibonacci(20)  % Returns 6765
```

### Error Handling

The function validates inputs and throws errors for:
- Negative numbers
- Non-integer values
- Non-scalar inputs
- Non-numeric inputs

```matlab
fibonacci(-1)    % Error: Input must be a non-negative integer
fibonacci(2.5)   % Error: Input must be a non-negative integer
fibonacci([1,2]) % Error: Input must be a non-negative integer
```