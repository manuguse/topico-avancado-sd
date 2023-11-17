## working fine

def mult(x, y):
    return str(int(x)*int(y))

entry = '1100'
missing = 4 - len(entry)
entry = "0"*missing + entry

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

v1 = cd + bd + ac + ac + ab + '0' + a
v2 = d + '0' + bc + '0' + b + "00"
v3 = "00" + c + "0000"

print(bin(int(entry, 2)**2))

sum = bin(int(v1, 2) + int(v2, 2) + int(v3, 2))
print(sum)
