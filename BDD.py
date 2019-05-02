# Zeid Al-Ameedi
# 03-19-2019
# Cpts 350 Design and Algorithm Analysis
# BDD graph that follows the specs found here; projectBDD.pdf

# Collab w/ Dr. Zhe Dang


import pyeda.inter as pyeda

def conjure_formula(i, j):
    index=0
    xF = ""
    yF = ""
    xB = '{0:05b}'.format(i)
    yB ='{0:05b}'.format(j)

    for temp in xB:
        if(int(temp) == 0):
            xF += f"~x[{index}] & "
        elif int(temp)==1:
            xF += f"x[{index}] & "
        index += 1
    index=0

    for temp in yB:
        if(int(temp) == 0):
            yF += f"~y[{index}] & "
        elif int(temp)==1:
            yF += f"y[{index}] & "
        index += 1
    
    newX = xF[:-3]
    newY = yF[:-3]

    final_formula = f"({newX}) & ({newY})"
    return final_formula


def connect_to_edges(ff):
    jF = ""
    index = 0
    j = 1

    for temp in ff:
        jF += f"({temp}) | "
    jF = pyeda.expr(jF[:-3])
    return jF

def transitive_closure(R):
    x0, x1, x2, x3, x4 = pyeda.bddvars('x', 5)
    y0, y1, y2, y3, y4 = pyeda.bddvars('y', 5)
    z0, z1, z2, z3, z4 = pyeda.bddvars('z', 5)
    Temp = R 
    temp_prime = None
    
    while True:
        temp_prime=Temp
        ff1 = Temp.compose({y0:z0, y1:z1, y2:z2, y3:z3, y4:z4 })
        ff2 = R.compose({x0:z0, x1:z1, x2:z2, x3:z3, x4:z4 }) 
        ff3 = ff1 & ff2
        Temp = temp_prime | ff3
        Temp = Temp.smoothing((z0, z1, z2, z3, z4))
        if Temp.equivalent(temp_prime):
            break

    return Temp


def main():
    edgeFormulaList = []
    x0, x1, x2, x3, x4 = pyeda.bddvars('x', 5)
    y0, y1, y2, y3, y4 = pyeda.bddvars('y', 5)
    print("Generating Graph...")
    for i in range(0, 32):

        for j in range(0,32):

            if (((i+3) % 32) == (j % 32)) | (((i+7) % 32) == (j % 32)):
                newFormula = conjure_formula(i, j)
                edgeFormulaList.append(newFormula)
    
    F = connect_to_edges(edgeFormulaList)
    R = pyeda.expr2bdd(F)
    print("Generating transitive closure, R*")
    RStar = transitive_closure(R) 
    print("Negating the transitive closure, R*")
    negRStar = ~RStar
    result = negRStar.smoothing((x0, x1, x2, x3, x4, y0, y1, y2, y3, y4))
    result = ~result
    print("Let x,y be in the set S. Node x can reach node y in one+ steps in a graph G. . .")
    print(f"\n{result.equivalent(True)}\n")


if __name__ == '__main__':
    main()
    print("BDD Project complete.")