function fib = fibonacci(n)
% FIBONACCI Calculate the nth Fibonacci number
%
% Syntax:
%   fib = fibonacci(n)
%
% Description:
%   Calculates the nth Fibonacci number using an iterative approach.
%   The Fibonacci sequence is defined as:
%   F(0) = 0, F(1) = 1, F(n) = F(n-1) + F(n-2) for n > 1
%
% Input Arguments:
%   n - Non-negative integer specifying which Fibonacci number to calculate
%
% Output Arguments:
%   fib - The nth Fibonacci number
%
% Examples:
%   fibonacci(0)  % Returns 0
%   fibonacci(1)  % Returns 1
%   fibonacci(10) % Returns 55
%
% See also: factorial, primes

% Input validation
if ~isscalar(n) || ~isnumeric(n) || n < 0 || floor(n) ~= n
    error('Input must be a non-negative integer');
end

% Handle base cases
if n == 0
    fib = 0;
    return;
elseif n == 1
    fib = 1;
    return;
end

% Iterative calculation for efficiency
prev2 = 0;  % F(0)
prev1 = 1;  % F(1)

for i = 2:n
    current = prev1 + prev2;
    prev2 = prev1;
    prev1 = current;
end

fib = prev1;
end