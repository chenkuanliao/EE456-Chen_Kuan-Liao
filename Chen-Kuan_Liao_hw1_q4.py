arr = [0.6, 0.3, 1.2, 0.9]

t = 0

def func(target, in1, in2, in3):
    out = target - 0.2*(in1 + in2 + in3)
    if out > 0:
        return out
    # otherwise
    return 0

while(True):
    a1 = arr[0]
    a2 = arr[1]
    a3 = arr[2]
    a4 = arr[3]

    arr[0] = func(a1, a2, a3, a4)
    arr[1] = func(a2, a1, a3, a4)
    arr[2] = func(a3, a1, a2, a4)
    arr[3] = func(a4, a1, a2, a3)

    print(f"t: {t}")
    print(f"a1: {arr[0]}")
    print(f"a2: {arr[1]}")
    print(f"a3: {arr[2]}")
    print(f"a4: {arr[3]}")
    
    if((arr[0]>0 and arr[1]==0 and arr[2]==0 and arr[3]==0) or (arr[0]==0 and arr[1]>0 and arr[2]==0 and arr[3]==0) or (arr[0]==0 and arr[1]==0 and arr[2]>0 and arr[3]==0) or (arr[0]==0 and arr[1]==0 and arr[2]==0 and arr[3]>0)):
        break

    t = t + 1