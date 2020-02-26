#SETTING UP THE SCREEN
from tkinter import *
from math import *
from random import *
root = Tk()
screen = Canvas( root, width=1200, height=800, background = "black" )
screen.pack()


#GLOBAL VARIABLES
n = 800   #number of dots
R = 300  #radius of the main ring
r = 10   #radius of a dot

xC = 300 #(x,y) coordinates of the centre of the ring
yC = 300

radiusValues = []  
thetaValues = []


def main():
    for i in range( n ):
        r = randint(1, R)
        theta = randint(0, 359)
        thetaRadians = radians(theta)

        radiusValues.append( r )
        thetaValues.append( thetaRadians )


    print("Setup is complete. Drawing can now begin.")
    makeTheDrawing()


def makeTheDrawing():
    
    for i in range( 0, n ):
        xVal = xC + radiusValues[i]*cos(thetaValues[i]) 
        yVal = yC - radiusValues[i]*sin(thetaValues[i])
        
        if thetaValues[i] < pi/2:
            color = "red"

        elif pi/2 <= thetaValues[i] < pi:
            color = "white"

        elif pi <= thetaValues[i] < 3*pi/2:
            color = "purple"

        else:
            color = "cyan"

        screen.create_oval( xVal, yVal, xVal+5, yVal+5, fill = color )



main()
