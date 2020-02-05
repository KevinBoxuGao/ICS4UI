num = int(input("input your number: "))

def powerOf2(number):
    return number && (!(number&(number-1)))

def makeTermString(start,end):
    termString = ""
    for num in range(start, end+1):
        if num != end:
            termString += str(num) + "+"
        else: 
            termString += str(num)

    return termString

def summable(number):
    if number > 0:
        if number == 1:
            return("Not Summable")
        elif number % 2 == 1:
            start = number // 2
            end = start + 1
            return(str(smaller) + " " + str(smaller+1)) 
        else:
            if powerOf2(number):
                return("Not Summable")
            else:

    else:
        return("Not Summable")

print(summable(num))