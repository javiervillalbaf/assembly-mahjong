.data

mapa: .asciz "   1    2    3 \n  +---+---+---+\n1 | A | B | C |\n  +---+---+---+\n2 | D | E | F |\n  +---+---+---+\n3 | G | H | I |\n  +---+---+---+\n"
longitud = . - mapa

fila: .byte 2
columna: .byte 2
mensajeFila: .asciz "ingrese fila (1-3): "
longMensajeFila = .-mensajeFila
mensajeColumna: .asciz "ingrese columna (1-3): "
longMensajeColumna = .-mensajeColumna

entrada: .byte 0,0

.text

mostrar:
.fnstart
push {lr}

mov r7, #4
mov r0, #1
swi 0

pop {lr}
bx lr
.fnend

seleccionar:
.fnstart
push {lr}

ldr r1, =mapa

mov r4, #32
mul r6, r2, r4

mov r4, #4
mul r7, r3, r4

add r6, r6, r7
add r6, r6, #36

mov r5, #'X'
strb r5, [r1, r6]

pop {lr}
bx lr
.fnend

leerFila:
.fnstart
push {lr}

pedirFila:
ldr r1, =mensajeFila
ldr r2, =longMensajeFila
bl mostrar

mov r7, #3
mov r0, #0
ldr r1, =entrada
mov r2, #2
swi 0

ldr r1, =entrada
ldrb r2, [r1]

mov r4, #48
sub r2,r2,r4
cmp r2,#1
blt pedirFila
cmp r2,#3
bgt pedirFila

sub r2,r2,#1

ldr r1, =fila
strb r2, [r1]

pop {lr}
bx lr
.fnend

leerColumna:
.fnstart
push {lr}

pedirColumna:
ldr r1, =mensajeColumna
ldr r2, =longMensajeColumna
bl mostrar

mov r7, #3
mov r0, #0
ldr r1, =entrada
mov r2, #2
swi 0

ldr r1, =entrada
ldrb r2, [r1]

mov r4, #48
sub r2,r2,r4

cmp r2,#1
blt pedirColumna

cmp r2,#3
bgt pedirColumna

sub r2,r2,#1

ldr r1, =columna
strb r2, [r1]

pop {lr}
bx lr
.fnend

.global main

main:
ldr r1, =mapa
ldr r2, =longitud
bl mostrar

ldr r1, =mapa

bl leerFila
bl leerColumna

ldr r2, =fila
ldrb r2, [r2]

ldr r3, =columna
ldrb r3, [r3]

bl seleccionar

ldr r1, =mapa
ldr r2, =longitud
bl mostrar

fin:
mov r7,#1
swi 0
