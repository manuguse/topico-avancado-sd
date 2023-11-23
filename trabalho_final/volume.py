entries = [
    '0001', '0010', '0011', '0100', '0101', '0110', '0111',
    '1000', '1001', '1010', '1011', '1100', '1101', '1110', '1111',
]

def mult_not(x,y):
    notY = {0:1, 1:0}[int(y)]
    return str(int(x)*notY)

def mult(x, y):
    return str(int(x)*int(y)) 

def calculate_volume(entry):

    answer = bin(int(int(entry, 2)**3 * 4.25))[2:]
    expected = bin(int(int(entry, 2)**3 * 4*3.1415/3))[2:]

    a = entry[3]
    b = entry[2]
    c = entry[1]
    d = entry[0]

    cd = mult(c,d)
    bd = mult(b,d)
    ad = mult(a,d)
    bc = mult(b,c)
    ac = mult(a,c)
    ab = mult(a,b)
    
    bcd = mult(b,cd)
    abd = mult(a,bd)
    acd = mult(a,cd)
    abc = mult(a,bc)
    
    Ncd = mult_not(d,c)
    Nbc = mult_not(c,b)
    Nad = mult_not(d,a)
    Nab = mult_not(b,a)
    Nac = mult_not(c,a)
    Nbd = mult_not(d,b)
    
    aNd = mult_not(a,d)
    bNc = mult_not(b,c)
    cNd = mult_not(c,d)
    
    abNc = mult_not(ab,c)
    
    v1 = cd + d + bcd + bc + ac + Nbd + abd + bNc + ac + abd + ad + ad + ac + ab + a
    v2 = '0' + bd + bd + acd + cNd + abc + bcd + acd + abd + abd +abc + abNc + b + '0' + '0' + '0'
    v3 = '0' + '0' +
    v4 = '0' + '0' + '0' +
    v5 = '0' + '0' + '0' + '0' + '0' +
    v6 =  '0' + 
    
    sum = bin(int(v1, 2) + int(v2, 2) + int(v3, 2) + int(v4, 2) + int(v5, 2) + int(v6,2))[2:-3]

    print(f'resposta esperada: {expected}')
    print(f'resposta obtida:   {sum}')
    print('certo') if expected == sum else print('errado')

    #print(f'diferenca: {(int(expected, 2) - int(sum, 2))}')
    
for entry in entries: 
    calculate_volume(entry)
    print()
