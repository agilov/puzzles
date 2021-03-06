#!/bin/bash

# https://www.hackerrank.com/challenges/fractal-trees-all/problem

# Creating a Fractal Tree from Y-shaped branches

# This challenge involves the construction of trees, in the form of ASCII Art.

# We have to deal with real world constraints, so we cannot keep repeating the pattern infinitely.
# So, we will provide you a number of iterations, and you need to generate the ASCII version of the
# Fractal Tree for only those many iterations (or, levels of recursion). A few samples are provided below.

# Iteration #1

# In the beginning, we simply create a Y.
# There are 63 rows and 100 columns in the grid below.
# The triangle is composed of underscores and ones as shown below.
# The vertical segment and the slanting segments are both 16 characters in length.

#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#_________________________________1_______________________________1__________________________________
#__________________________________1_____________________________1___________________________________
#___________________________________1___________________________1____________________________________
#____________________________________1_________________________1_____________________________________
#_____________________________________1_______________________1______________________________________
#______________________________________1_____________________1_______________________________________
#_______________________________________1___________________1________________________________________
#________________________________________1_________________1_________________________________________
#_________________________________________1_______________1__________________________________________
#__________________________________________1_____________1___________________________________________
#___________________________________________1___________1____________________________________________
#____________________________________________1_________1_____________________________________________
#_____________________________________________1_______1______________________________________________
#______________________________________________1_____1_______________________________________________
#_______________________________________________1___1________________________________________________
#________________________________________________1_1_________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________


# Iteration #2

# At the top of the left and right branches of the first Y, we now add a pair of Y-shapes, which are half the size of the original Y.

#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#____________________________________________________________________________________________________
#_________________________1_______________1_______________1_______________1__________________________
#__________________________1_____________1_________________1_____________1___________________________
#___________________________1___________1___________________1___________1____________________________
#____________________________1_________1_____________________1_________1_____________________________
#_____________________________1_______1_______________________1_______1______________________________
#______________________________1_____1_________________________1_____1_______________________________
#_______________________________1___1___________________________1___1________________________________
#________________________________1_1_____________________________1_1_________________________________
#_________________________________1_______________________________1__________________________________
#_________________________________1_______________________________1__________________________________
#_________________________________1_______________________________1__________________________________
#_________________________________1_______________________________1__________________________________
#_________________________________1_______________________________1__________________________________
#_________________________________1_______________________________1__________________________________
#_________________________________1_______________________________1__________________________________
#_________________________________1_______________________________1__________________________________
#_________________________________1_______________________________1__________________________________
#__________________________________1_____________________________1___________________________________
#___________________________________1___________________________1____________________________________
#____________________________________1_________________________1_____________________________________
#_____________________________________1_______________________1______________________________________
#______________________________________1_____________________1_______________________________________
#_______________________________________1___________________1________________________________________
#________________________________________1_________________1_________________________________________
#_________________________________________1_______________1__________________________________________
#__________________________________________1_____________1___________________________________________
#___________________________________________1___________1____________________________________________
#____________________________________________1_________1_____________________________________________
#_____________________________________________1_______1______________________________________________
#______________________________________________1_____1_______________________________________________
#_______________________________________________1___1________________________________________________
#________________________________________________1_1_________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________
#_________________________________________________1__________________________________________________

# Input Format
# A single integer, N.

# Constraints
# N <= 5

# Output Format
# The Nth iteration of the Fractal Tree, as shown above.
# It should be a matrix of 63 rows and 100 columns. (i.e. 6300 printable characters)
# It should be composed entirely of underscores and ones, in a manner similar to the examples provided.
# Do not include any extra leading or trailing spaces.

# Getting iterations count from stdin
read -r iterations

# Initial params (matrix size and initial Y size)
rows=63
cols=100
size=16

# Initial branch position (in the middle of the cols)
line=(cols/2)

# This variable will contain all the lines that will be printed
output=()

# Once generated blank line
blankLine=$(printf "%${cols}s" | tr " " "_")

# Writes the line to the output
writeLine() {
  local out=$blankLine
  for n in "${line[@]}"; do
    out=${out:0:$n-1}1${out:$n}
  done
  output+=("$out")
}

# Forks current branches in line
# Every branch forks to 2 one less and one greater
forkBranches() {
  local result=()
  for n in "${line[@]}"; do
    result+=("$((n - 1))")
    result+=("$((n + 1))")
  done

  line=("${result[@]}")
}

# Widen all branches in current line
widenBranches() {
  local result=()
  for n in "${!line[@]}"; do
    local val="${line[$n]}"
    [[ $n%2 -gt 0 ]] && line[$n]=$val+1 || line[$n]=$val-1
  done
}

# Writing first line
writeLine

# Building the output from the root to the leaves
while ((iterations--)); do
  for ((j = 0; j < size; j++)); do
    writeLine
  done

  forkBranches
  writeLine

  for ((j = 1; j < size; j++)); do
    widenBranches
    writeLine
  done

  size=$size/2
done

# Print the output in reverse order
for ((i = rows; i > 0; i--)); do
  [ "${output[$i]}" ] && echo "${output[$i]}" || echo "$blankLine"
done
