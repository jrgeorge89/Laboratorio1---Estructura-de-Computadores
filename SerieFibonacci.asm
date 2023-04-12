.data
prompt: .asciiz "Este Script Calcula la Secuencia de Fibonacci\n\nIngrese un Numero Positivo: "
result: .asciiz "F_"
result2: .asciiz " = "
endl: .asciiz "\n"

.text
.globl main

main:
# Imprime el Mensaje que Ingrese un Numero +
la $a0, prompt   
li $v0, 4
syscall

li $v0, 5  # Lee el número (n)
syscall

move $t2, $v0   # n a $t2

# Función de llamada para obtener fibonnacci #n
move $a0, $t2
move $v0, $t2
jal fib     	# Llama fib (n)
move $t3, $v0   # result es en $t3

# Mensaje de Salida y n
la $a0, result  # Imprime F_
li $v0, 4
syscall

move $a0, $t2   # Imprime n
li $v0, 1
syscall

la $a0, result2 # Imprime =
li $v0, 4
syscall

move $a0, $t3   # Imprime la respuesta
li $v0, 1
syscall

la $a0, endl 	# Imprime '\n'
li $v0, 4
syscall

# Fin del programa
li $v0, 10
syscall

fib:
# Calcula y devolve el número de Fibonacci
beqz $a0, zero   	# si n=0 devuelve 0
beq $a0, 1, one   	# si n=1 devuelve 1

# Llamando fib(n-1)
sub $sp, $sp, 4   	# Almacena la dirección de retorno en la pila
sw $ra, 0($sp)

sub $a0, $a0, 1   	# n-1
jal fib     		# fib(n-1)
add $a0, $a0, 1

lw $ra, 0($sp)   	# Restaura la dirección de retorno de la pila
add $sp, $sp, 4

sub $sp, $sp, 4   	# Empuja el valor de retorno para apilar
sw $v0, 0($sp)

# Llamando fib(n-2)
sub $sp, $sp, 4   	# Almacena la dirección de retorno en la pila
sw $ra, 0($sp)

sub $a0, $a0, 2   	# n-2
jal fib     		# fib(n-2)
add $a0, $a0, 2

lw $ra, 0($sp)   	# Restaura la dirección de retorno de la pila
add $sp, $sp, 4

lw $s7, 0($sp)   	# Extrae el valor de retorno de la pila
add $sp, $sp, 4

add $v0, $v0, $s7 	# f(n - 2)+fib(n-1)
jr $ra 				# Disminuir/Siguiente en la pila

zero:
li $v0, 0
jr $ra
one:
li $v0, 1
jr $ra
