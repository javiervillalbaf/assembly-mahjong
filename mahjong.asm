.data

mapa: .asciz "+---+---+---+\n| A | B | C |\n+---+---+---+\n| D | E | F |\n+---+---+---+\n| G | H | I |\n+---+---+---+\n "
longitud = . - mapa

fila: .byte 2
columna: .byte 0
mensajeFila: .asciz "ingrese fila: "
longMensajeFila = . - mensajeFila

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

mov r4, #28
mul r6, r2, r4

mov r4, #4
mul r7, r3, r4

add r6, r6, r7
add r6, r6, #16

mov r5, #'X'
strb r5, [r1, r6]

pop {lr}
bx lr
.fnend

leerFila:
.fnstart
push {lr}

ldr r1, =mensajeFila
ldr r2, =longMensajeFila
bl mostrar

mov r7, #3
