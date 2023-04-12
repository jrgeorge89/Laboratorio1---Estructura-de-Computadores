.data
prompt1: .asciiz "Ingrese el 1er Numero: "
prompt2: .asciiz "Ingrese el 2do Numero: "
prompt3: .asciiz "Ingrese el 3er Numero: "
result: .asciiz "El Numero Menor Es: "

.text
.globl main

main:
# Imprime el Primer Mensaje
li $v0, 4
la $a0, prompt1
syscall

# Lee el Primer Numero
li $v0, 5
syscall
move $t0, $v0

# Imprime el Segundo Mensaje
li $v0, 4
la $a0, prompt2
syscall

# Lee el Segundo Numero
li $v0, 5
syscall
move $t1, $v0

# Imprime el Tercer Numero
li $v0, 4
la $a0, prompt3
syscall

# Lee el Tercer Numero
li $v0, 5
syscall
move $t2, $v0

# Busca el Numero Mayor
move $t3, $t0   # Inicialmente Asigna el Primer Numero como el Menor
bge $t1, $t3, check_t1
move $t3, $t1   # Si el Segundo Numero es Menor, Actualiza la Variable
check_t1:
bge $t2, $t3, check_t2
move $t3, $t2   # Si el Tercer Numero es Menor, Actualiza la Variable
check_t2:

# Imprime el Resultado
li $v0, 4
la $a0, result
syscall

li $v0, 1
move $a0, $t3
syscall

# Fin del programa
li $v0, 10
syscall
