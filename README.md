# Parque de atracciones
*Ejericio integrador*

**La gente de un pueblo que juntó sus recursos con los cuales construyeron un Parque de atracciones, necesita un sistema para registrar el uso de las atracciones cada día. Está apuntado a toda la familia pero hay ciertas restricciones para atracciones específicas. Se espera extender el sistema a la administración de varios parques.**

## Personas, parques y atracciones

De cada persona, conocemos su edad y altura, aquí van algunos ejemplos:
- Nina es una joven de 22 años y 1.60m.
- Marcos es un niño de 8 años y 1.32m.
- Osvaldo es un adolescente de 13 años y 1.29m.

Cada atracción del parque tiene requisitos para su ingreso, por ejemplo en el Parque de la Costa contamos con las siguientes atracciones:
- Tren Fantasma. Exige que la persona sea mayor o igual a 12 años.
- Montaña Rusa. Exige que la persona tenga más de 1.30 de altura.
- Máquina Tiquetera. No tiene exigencias.

Al mismo tiempo, el Parque Acuático tiene estas atracciones:
- Tobogán Gigante "La Ola Azul"
  - Altura de 22 metros para una bajada emocionante que termina en una piscina de olas.
  - Altura mínima 1.50m
- Río Lento "Corriente Serpenteante"
  - Paseo tranquilo en flotadores a través de un paisaje con cascadas y grutas.
  - Sin requisitos.
- Piscina de Olas "Maremoto"
  - Simula olas del mar con zonas para diferentes niveles de habilidad.
  - Mínimo 5 años

### Requerimientos 
Modelar la base de conocimiento para contener esa información, proveyendo ejemplos, y programar los siguientes predicados:
puedeSubir/2, relaciona una persona con una atracción, si la persona puede subir a la atracción.
esParaElle/2, relaciona un parque con una persona, si la persona puede subir a todos los juegos del parque.
malaIdea/2, relaciona un grupo etario (adolescente/niño/joven/adulto/etc) con un parque, y nos dice que "es mala idea" que las personas de ese grupo vayan juntas a ese parque, si es que no hay ningún juego al que puedan subir todos.

## Programas
Un programa es una lista ordenada de atracciones, que tienen que estar todas en el mismo parque. Por ejemplo, un programa en el parque acuático puede arrancar en el tobogán gigante, continuar en la piscina de olas y finalizar en la corriente serpenteante. Obviamente el programa no tiene por qué incluir todos los juegos del parque, es una selección ordenada.

### Requerimientos 
A partir de esa definición, queremos que programes los siguientes predicados:
- programaLogico/1, me dice si un programa es "bueno", es decir, todos los juegos están en el mismo parque y no hay juegos repetidos.
- hastaAca/3, relaciona a una persona P y un programa Q, con el subprograma S que se compone de las atracciones iniciales de Q hasta la primera a la que P no puede subir (excluida obviamente).  Por ejemplo, si el programa tiene 5 atracciones y P no puede subir a la tercera, pero sí a las dos primeras, el subprograma S deberá incluir a esas dos primeras atracciones.

## Pasaportes
Las tarjetas son el medio por el cual las personas pueden utilizar las atracciones, cada persona debe tener un pasaporte. 

Para lo que sigue, necesitamos más información sobre los juegos, que serán de dos tipos:
- Juegos comunes, que cada uno tiene un costo determinado en créditos.
- Juegos premium, que tienen otros requisitos de ingreso, dependiendo del pasaporte que se describe a continuación.	

Los pasaportes que existen son los siguientes
- Pasaporte básico: 
Incluye una cantidad determinada de créditos, que se gastan al usar cada juego.
Por más que tenga crédito no puede subir a los juegos premium.
(Cabe mencionar que no modelamos el "gastar" los créditos, sólo chequeamos si la persona tiene suficientes créditos o no.)
- Pasaporte flex:
Similar al común, pero habilita el ingreso a un único juego premium, predeterminado en el pasaporte.
- Pasaporte premium:
Habilita el ingreso a todos los juegos, sin restricciones.

###Requerimientos 
Actualizar el predicado puedeSubir/2 incluyendo los requisitos de los pasaportes.



