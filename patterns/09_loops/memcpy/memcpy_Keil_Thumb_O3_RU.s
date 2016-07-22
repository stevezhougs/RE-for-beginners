my_memcpy PROC
; R0 = §целевой адрес§
; R1 = §исходный адрес§
; R2 = §размер блока§

        PUSH     {r4,lr}
; §инициализировать счетчик (i) в 0§
        MOVS     r3,#0
; §условие проверяется в конце ф-ции, так что переходим туда:§
        B        |L0.12|
|L0.6|
; §загружаем байт по адресу§ R1+i:
        LDRB     r4,[r1,r3]
; §записываем байт по адресу§ R1+i:
        STRB     r4,[r0,r3]
; i++
        ADDS     r3,r3,#1
|L0.12|
; i<size?
        CMP      r3,r2
; §перейти на начало цикла, если это так§
        BCC      |L0.6|
        POP      {r4,pc}
        ENDP
