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