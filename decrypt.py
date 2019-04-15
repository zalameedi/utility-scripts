# Script for Cpts350 Algorithm project that will decrypt my baby ascii table
# Because i don't want to do it byhand ;)
import math
from fractions import gcd

n = 10539750919
e = 49
d = 3226366849 #wolfram alpha

def decrypt(data):
    decrypted_txt = []
    for i in data.upper():
        if i == 'A':
            decrypted_txt.append('1')
        if i == 'E':
            decrypted_txt.append('2')
        if i == 'G':
            decrypted_txt.append('3')
        if i == 'I':
            decrypted_txt.append('4')
        if i == 'O':
            decrypted_txt.append('5')
        if i == 'R':
            decrypted_txt.append('6')
        if i == 'T':
            decrypted_txt.append('7')
        if i == 'X':
            decrypted_txt.append('8')
        if i == '!':
            decrypted_txt.append('9')
        if i == '0':
            decrypted_txt.append('0')
    return decrypted_txt

def decipher(data):
    decrypted_txt = []
    ls = str(data)
    for i in ls:
        if int(i) == 1:
            decrypted_txt.append('A')
        if int(i) == 2:
            decrypted_txt.append('E')
        if int(i) == 3:
            decrypted_txt.append('G')
        if int(i) == 4:
            decrypted_txt.append('I')
        if int(i) == 5:
            decrypted_txt.append('O')
        if int(i) == 6:
            decrypted_txt.append('R')
        if int(i) == 7:
            decrypted_txt.append('T')
        if int(i) == 8:
            decrypted_txt.append('X')
        if int(i) == 9:
            decrypted_txt.append('!')
        if int(i) == 0:
            decrypted_txt.append('0')
    return decrypted_txt

def do_calc(list_text):
    ls = []
    global d
    global e
    global n
    for i in range(0,5):
        sub = int(''.join(list_text[:10]))
        list_text = (list_text[10:])
        soln = ((sub)**e) % n
        print(soln)
        ls.append(soln)
        print(". . .")
        print("\n")
        print(decipher(soln))
        
def get_p():
    global n
    return math.floor(math.sqrt(n))

def crack_pq():
    global n
    global e
    for p in range(1, n):
        q = n/p 
        if n == (p*q):
            t = (p-1)*(q-1)
            if(gcd(e,t) == 1):
                print("P: {0} Q: {1}".format(p, q))
                return (p, q)

# Use wolfram alpha instead, plug in the formula down there
def crack_d(p, q):
    d = 1
    global e
    while True:
        if (d * e) == 1%((p-1)*(q-1)):
            break
        d += 1
    print("D: ", d)
    return d
     #(d * 49) = 1 mod ((43481 - 1)(242399 - 1))

def solve_m(c, d): #use wolfram alpha as well
    global n
    print("Solving for M-----")
    x = ((c**d) % n) 
    print(x)

def decipher_helper(L):
    for i in L:
        print(decipher(i))
        


# list_text = decrypt("ITG!AAEXEX IRRG!IGRXI OIXGEREAGO")
# data = ''.join(list_text)
# print(data)
# do_calc(list_text)
# p, q = crack_pq()
# # solve_m(3656516678,3226366849)
# #crack_d(p, q)
L = [36217, 98483, 57847]
decipher_helper(L)


