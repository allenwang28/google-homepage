#If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#Find the sum of all the multiples of 3 or 5 below 1000.
def mult_of_sum(num1 = 3, num2 = 5, max = 1000)
   (0..max-1).inject(0) { |sum, next_num| (next_num % num1 == 0 || next_num % num2 == 0) ? sum = sum + next_num : sum }
end

puts mult_of_sum(3, 5, 1000)
    

