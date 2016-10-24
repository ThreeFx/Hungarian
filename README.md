# Hungarian
A wrapper for Haskell's Hungarian Library for project assignment.

This is really hacky and not at all a well-programmed and safe approach. (But it works.)

Do **not** use this if you expect well-defined behaviour and error handling.

## Usage

### 1. Create data

**ALL INDICES ARE 1-BASED!**

Create a file people with newline separated names.
Create a file assignments with newline separated assignment titles.
Create a file wishes with each line l holding *exactly* 3 values:
 - The line number of the first wish of student `l`
 - The line number of the second wish of student `l`
 - The line number of the third wish of student `l`

### 2. Run program

Call the program as `stack exec hungarian-exe <people> <assignments> <wishes>`.

### 3. ????

????

### 4. Profit

$$$$
