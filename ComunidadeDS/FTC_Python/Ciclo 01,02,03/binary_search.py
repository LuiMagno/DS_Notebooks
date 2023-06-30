
# busca binaria

import math
def busca_binaria(lista, item):
    inicio = 0;
    fim = len(lista) - 1;

    while inicio <= fim :
        meio = math.floor((inicio + fim) / 2);
        chute = lista[meio];
        
        if chute == item:
            return item
        if chute < item:
            inicio = meio + 1
        else:
            fim = meio - 1
        
numbers = [0,1,2,3,4,5,6,7,8,9,11];
print(busca_binaria(numbers, 10));