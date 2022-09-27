
# Preguntas

## Abstracción de los tests 01 y 02 

En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

Creamos una especie de cronómetro para medir el tiempo que tardan en desarrollarce los métodos mediante una comparación de la diferencia entre el tiempo de antes y después del enviar el mensaje.

## Cómo representar en Smalltalk

¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?

Las instancias de las clases (objetos) pueden usarce para representar entidades físicas (concretas) de la realidad, las clases para representar entidades abstractas (no tangentes), mientras que los mensajes (a través de métodos) se utilizan para representar acciones.

## Teoría de Naur

¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

La relación que encontramos entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur) es el enfoque en crear código pensando en la realidad que tiene ambas. Para sacar el código repetido mediante abstracciones se pienza en los objetos de la realidad para ver como se pueden relacionar unos con otros y entonces repetir menos el código, mientras tanto la teoría del modelo invita a pensar en resolución de problemas de la vida real para resolver los computacionales. Entonces, se podría decir que sacar el código repetido mediante abstracciones es una instancia de la teoría del modelo
