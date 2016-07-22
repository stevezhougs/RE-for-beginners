.LC0:
	.string	"f(%d)\n"
printing_function:
; §сохранить FP и LR в локальном стеке§:
	stp	x29, x30, [sp, -32]!
; §установить стековый фрейм§:
	add	x29, sp, 0
; §сохранить содержимое регистра W0§:
	str	w0, [x29,28]
; §загрузить адрес строки "f(\%d)\textbackslash{}n"§
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
; §перезагрузить входное значение из локального стека в регистр W1§:
	ldr	w1, [x29,28]
; §вызвать§ printf()
	bl	printf
; §восстановить значения FP и LR§:
	ldp	x29, x30, [sp], 32
	ret
main:
; §сохранить FP и LR в локальном стеке§:
	stp	x29, x30, [sp, -32]!
; §установить стековый фрейм§:
	add	x29, sp, 0
; §инициализировать счетчик§
	mov	w0, 2
; §сохранить его в месте, выделенном для него в локальном стеке§:
	str	w0, [x29,28]
; §пропустить тело цикла, и перейти на инструкции проверки условия цикла§:
	b	.L3
.L4:
; §загрузить значение счетчика в§ W0.
; §это будет первый аргумент ф-ции§ printing_function():
	ldr	w0, [x29,28]
; §вызвать§ printing_function():
	bl	printing_function
; §инкремент значения счетчика§:
	ldr	w0, [x29,28]
	add	w0, w0, 1
	str	w0, [x29,28]
.L3:
; §проверка условия цикла§.
; §загрузить значение счетчика§:
	ldr	w0, [x29,28]
; §это§ 9?
	cmp	w0, 9
; §меньше или равно? тогда перейти на начало тела цикла:§
; §иначе ничего не делаем§.
	ble	.L4
; §возврат§ 0
	mov	w0, 0
; §восстановить значения FP и LR§:
	ldp	x29, x30, [sp], 32
	ret
