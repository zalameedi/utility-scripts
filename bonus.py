#Zeid Al-Ameedi
#350 Bonus portion excluded

# Insert formula to bonus and run it

def Bonus(R):
	H = R
	y = 1
	while(1):
		for i in range(32):
			if i % 2 == 0:
				if pathExists(i, i, H):
					print("The value of K is: ")
					print(y)
					return y
		y += 1
		H = Compose(H, R)


