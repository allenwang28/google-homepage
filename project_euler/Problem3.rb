#The prime factors of 13195 are 5, 7, 13 and 29.
#
#What is the largest prime factor of the number 600851475143 ?
def largest_prime_factor(max = 600851475143)
    i = 2
    while i < max do
        while max % i == 0 do
            max = max/i
        end
    i += 1
    end
    max
end

puts largest_prime_factor()

# need to really get better at righting more concise code. looks too much like C/C++
