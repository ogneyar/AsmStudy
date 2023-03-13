@GNU AS

.syntax unified     @ синтаксис исходного кода
.thumb              @ тип используемых инструкций Thumb
.cpu cortex-m4      @ процессор
.fpu fpv4-sp-d16    @ сопроцессор

.include "src/stm32f40x_def.inc"
