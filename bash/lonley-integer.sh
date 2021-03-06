
#!/bin/bash

# https://www.hackerrank.com/challenges/awk-3/problem

# There are N integers in an array . All but one integer occur in pairs. Your task is to find the number that occurs only once.

# Input Format

# The first line of the input contains an integer , indicating the number of integers.
# The next line contains  space-separated integers that form the array .

# Constraints

# Output Format

# Output , the number that occurs only once.

# Sample Input:1
# 1
# 1

# Sample Output:1
# 1

# Sample Input:2
# 3
# 1 1 2
# Sample Output:2
# 2

# Sample Input:3
# 5
# 0 0 1 2 1
# Sample Output:3
# 2

# Explanation
# In the first input, we see only one element (1) and that element is the answer.
# In the second input, we see three elements; 1 occurs at two places and 2 only once. Thus, the answer is 2.
# In the third input, we see five elements. 1 and 0 occur twice. The element that occurs only once is 2.

read -r n
read -r numbers
counter=(0 0 0 0 0 0 0 0 0 0)
for number in $numbers; do
  if ((counter[$number] > 0)); then
    counter[$number]=$((counter[$number] + 1))
  else
    counter[$number]=1
  fi
done

for index in "${!counter[@]}"; do
  if ((counter[$index] == 1)); then
    echo $index
  fi
done
