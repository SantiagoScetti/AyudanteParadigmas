Ejercicio N° 2:
a) Definir una función que solicite al operador la cantidad total de personas invitadas a la fiesta y
devuelva una lista formada por sublistas, donde cada sublista tendrá.
        * Como primer elemento, el tipo de lugar donde se sentarán.
        * Como segundo elemento, la cantidad de ese tipo de lugar que se necesitarán para que se
sienten todos los invitados.
Por ejemplo, si el operador ingresa 150, la función deberá devolver una lista de la siguiente
forma: ((MESA 18) (SILLONES 37) (PUFF 75))

b) Definir una función predicado que recibe como parámetro la cantidad total de personas y la
cantidad de sillones. La misma deberá determinar si es posible que la cantidad de personas
ingresadas como parámetro puedan acomodarse en la cantidad de sillones ingresados también
como parámetro. Recordar que en cada sillón pueden sentarse 4 personas.

c) Se necesita también saber el importe que se deberá pagar por la comida. El valor del cubierto para las personas mayores es de $2500 y para los menores es de $1500. A partir de la cantidad de personas mayores y de la cantidad de personas menores que son ingresadas como parámetro
    * determinar el total que se debe abonar teniendo en cuenta que:
        Si la cantidad de personas mayores es <= 150, no habrá descuento.
        Si la cantidad de personas mayores es > 150 y <= 200, al total a abonar se le descuenta un 8%.
        Si la cantidad de personas mayores es > a 200, al total a abonar se le descuenta un 12%.