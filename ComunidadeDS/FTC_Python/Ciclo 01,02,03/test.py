# numero01 = input()
# numero02 = input()

# soma = numero01 + numero02

# print("O resultado da soma é: ", soma)

# nome = input()

# if nome == "pedro":
#     print("Bem-vindo Pedro")
# else:
#     print("Bem-vindo Meigarom")

# valor = int(input())
# resultado = 0;
# if valor > 10:
#     resultado = valor * 100
# else:
#     resultado = valor + 10

# print("O resultado é igual a: ", resultado)

numero1 = int(input())
numero2 = int(input())
numero3 = int(input())

if numero1 > numero2:
    if numero1 > numero3:
        print("Numero 1: ", numero1, " é o maior.")
    else:
        print("Numero 3: ", numero3, " é o maior.")
elif numero2 > numero3:
    print("Numero 2: ", numero2, " é o maior.")
else:
    print("Numero 3: ", numero3, " é o maior.")

