num = int(input("input your number: "))


def makeTermString(start, end):
    termString = ""
    for num in range(start, end+1):
        if num != end:
            termString += str(num) + "+"
        else:
            termString += str(num)
    return termString


def summable(number):
    oddDivisor = number
    while oddDivisor % 2 == 0:
        oddDivisor = oddDivisor // 2

    if oddDivisor == 1:
        return("Summation not possible")

    pivot = number // oddDivisor
    start = number - pivot
    if start <= 0:
        start = -start + 1
    end = pivot + oddDivisor // 2
    return(makeTermString(start, end))


print(summable(num))
