classdef test_fibonacci < matlab.unittest.TestCase
    % TEST_FIBONACCI Unit tests for the fibonacci function
    %
    % This test class contains comprehensive tests for the fibonacci function
    % including base cases, known values, edge cases, and error conditions.
    
    methods(Test)
        
        function testBaseCases(testCase)
            % Test the base cases F(0) = 0 and F(1) = 1
            testCase.verifyEqual(fibonacci(0), 0, 'F(0) should equal 0');
            testCase.verifyEqual(fibonacci(1), 1, 'F(1) should equal 1');
        end
        
        function testKnownValues(testCase)
            % Test several known Fibonacci numbers
            expected_values = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144];
            
            for i = 1:length(expected_values)
                n = i - 1;  % Convert to 0-based indexing
                actual = fibonacci(n);
                expected = expected_values(i);
                testCase.verifyEqual(actual, expected, ...
                    sprintf('F(%d) should equal %d', n, expected));
            end
        end
        
        function testLargerValues(testCase)
            % Test some larger Fibonacci numbers
            testCase.verifyEqual(fibonacci(15), 610, 'F(15) should equal 610');
            testCase.verifyEqual(fibonacci(20), 6765, 'F(20) should equal 6765');
            testCase.verifyEqual(fibonacci(25), 75025, 'F(25) should equal 75025');
        end
        
        function testFibonacciProperty(testCase)
            % Test the Fibonacci recurrence relation: F(n) = F(n-1) + F(n-2)
            for n = 2:15
                fn = fibonacci(n);
                fn_minus_1 = fibonacci(n-1);
                fn_minus_2 = fibonacci(n-2);
                testCase.verifyEqual(fn, fn_minus_1 + fn_minus_2, ...
                    sprintf('F(%d) should equal F(%d) + F(%d)', n, n-1, n-2));
            end
        end
        
        function testNegativeInput(testCase)
            % Test that negative inputs throw an error
            testCase.verifyError(@() fibonacci(-1), 'MATLAB:error', ...
                'Negative input should throw an error');
            testCase.verifyError(@() fibonacci(-5), 'MATLAB:error', ...
                'Negative input should throw an error');
        end
        
        function testNonIntegerInput(testCase)
            % Test that non-integer inputs throw an error
            testCase.verifyError(@() fibonacci(2.5), 'MATLAB:error', ...
                'Non-integer input should throw an error');
            testCase.verifyError(@() fibonacci(pi), 'MATLAB:error', ...
                'Non-integer input should throw an error');
        end
        
        function testNonScalarInput(testCase)
            % Test that non-scalar inputs throw an error
            testCase.verifyError(@() fibonacci([1, 2, 3]), 'MATLAB:error', ...
                'Array input should throw an error');
            testCase.verifyError(@() fibonacci([5]), 'MATLAB:error', ...
                'Array input should throw an error');
        end
        
        function testNonNumericInput(testCase)
            % Test that non-numeric inputs throw an error
            testCase.verifyError(@() fibonacci('5'), 'MATLAB:error', ...
                'String input should throw an error');
            testCase.verifyError(@() fibonacci(true), 'MATLAB:error', ...
                'Logical input should throw an error');
        end
        
        function testPerformance(testCase)
            % Test that the function can handle moderately large inputs efficiently
            tic;
            result = fibonacci(100);
            elapsed_time = toc;
            
            % Verify the result is correct (F(100) is a known value)
            expected_f100 = 354224848179261915075;
            testCase.verifyEqual(result, expected_f100, ...
                'F(100) should equal the known value');
            
            % Verify it completes in reasonable time (should be very fast)
            testCase.verifyLessThan(elapsed_time, 0.1, ...
                'Function should complete quickly for n=100');
        end
        
    end
    
    methods(Static)
        
        function runAllTests()
            % Convenience method to run all tests
            suite = matlab.unittest.TestSuite.fromClass(?test_fibonacci);
            runner = matlab.unittest.TextTestRunner;
            result = runner.run(suite);
            
            % Display summary
            fprintf('\n=== Test Summary ===\n');
            fprintf('Total tests: %d\n', numel(result));
            fprintf('Passed: %d\n', sum([result.Passed]));
            fprintf('Failed: %d\n', sum([result.Failed]));
            fprintf('Incomplete: %d\n', sum([result.Incomplete]));
            
            if all([result.Passed])
                fprintf('All tests PASSED! ✓\n');
            else
                fprintf('Some tests FAILED! ✗\n');
            end
        end
        
    end
    
end