# Ajedrez de Odín
#Construye un juego de ajedrez en línea de comandos donde dos jugadores puedan jugar uno contra el otro.

¡Hecho!

#El juego debe estar correctamente restringido: debe evitar que los jugadores realicen movimientos ilegales y declaren jaque o jaque mate en las situaciones correctas.

También hecho. El juego cumple con las reglas básicas establecidas por la Federación Internacional de Ajedrez (FIDE). Además de que las piezas se mueven como debe, el juego implementa:
- Jaque y jaque mate
- Imposibilidad de dejar a tu rey en jaque
- Enroque
- Captura de peones al paso
- Promoción del peón (el jugador puede elegir la pieza entre las cuatro posibles)
En cuanto a las tablas, se implementan estas posibles condiciones de empate:
- Rey ahogado (¡por supuesto!)
- Regla de los 50/75 movimientos consecutivos sin captura ni mover un peón (con 50 movimientos el jugador puede exigir tablas, con 75 las tablas son automáticas)
- Insuficiencia de material. Se producen tablas automáticas si se llega a una de estas situaciones:
 * Rey contra rey
 * Rey contra rey y caballo
 * Rey contra rey y álfil
* Rey y álfil contra rey y álfil, cuando los álfiles están en casillas del mismo color)
(Si un equipo tiene más de un álfil, pero están en casillas del mismo color, cuenta como un único álfil en una casilla de ese color).
- Tablas por mutuo acuerdo

NO están implementadas estas tablas:
- Tablas fotográficas (threefold y fivefold). Sí se podrían implementar en el futuro (en la parte final de este readme explicaremos cómo).
- Situaciones de escasez de material en las que el jaque mate es teóricamente posible, pero que en la práctica supondría que el jugador que pierde debe jugar deliberadamente para perder (por ejemplo, rey y álfil contra rey y caballo, o rey contra rey y dos caballos). La FIDE no reconoce las tablas automáticas en estos casos, sino que invita a que ambos jugadores firmen tablas por mutuo acuerdo.
- Posiciones muertas (en las que es imposible que ninguno de los dos jugadores llegue al jaque mate) en las que no hay escasez de material:

https://en.wikipedia.org/wiki/Rules_of_chess#Dead_position

Este último caso no sólo no está implementado, sino que tampoco hay intención de hacerlo (requeriría de muchos cálculos de IA que exceden el objetivo de este ejercicio).

#Hazlo de modo que puedas guardar el tablero en cualquier momento (¿recuerdas cómo serializar?)

Sí, lo recuerdo. El salvado y cargado de la partida está implementado. Como curiosidad, indicaré que no se guarda el tablero con las fichas, sino el registro de los movimientos. Cuando se carga una partida, lo que se hace es recuperar este registro y, automáticamente, el ordenador comienza una nueva partida de cero y realiza inicialmente los movimientos registrados. Además, este registro es un fichero JSON que es fácil de leer e incluso de modificar; podrías crear tú mismo este registro con unos cuantos movimientos iniciales (una apertura, por ejemplo), y arrancar una nueva partida partiendo de estos movimientos.

Durante la partida podemos consultar el registro del juego; pero no aparece en formato JSON, sino en notación algebraica ajedrecística, para que los humanos lo puedan entender más fácilmente.

He implementado un sistema de 9 slots en cada uno de los cuales puedes tener guardada una partida. Si estos slots se llenan, se pueden sobreescribir (el programa te advierte de esto por si cambias de opinión).

Se pueden guardar partidas acabadas (sea en mate, sea en tablas obligatorias). La partida se puede cargar, pero no se puede continuar; sólo se permite ver el tablero y el registro (en notación algebraica).

Si la partida acaba por renuncia de alguno de los jugadores, por tablas por mutuo acuerdo o por tablas tras 50 movimientos sin capturar pieza ni mover peón (pero menos de 75 movimientos), la partida se puede guardar y, posteriormente, se podría cargar y continuar jugando.

Puedes escribir 'save' durante la partida para grabarla, pero no cargar una nueva (no responde al comando 'load'); para ello tendrías que salir al menú principal, renunciando, proponiendo unas tablas o saliendo del programa al sistema operativo y entrando de nuevo. Antes de comenzar una nueva partida, el sistema te ofrecerá, en vez de empezar un nuevo juego desde cero, cargar una partida guardada (si hay alguna disponible).

Además de poder escribir 'save' durante la partida, el sistema te ofrecerá el poder grabarla voluntariamente cuando:
- Abandonas el programa (comando 'quit').
- Te rindes (comando 'resing').
- Propones o exiges unas tablas (comando 'draw') y el rival o el árbitro (sistema) las acepta.
- La partida acaba por mate o por tablas obligatorias.
...siempre y cuando se haya realizado al menos un movimiento válido desde el último grabado, carga o inicio de partida. Si no es así, no lo ofrece.

Escribe pruebas para las partes importantes. No necesitas TDD (a menos que quieras), pero asegúrate de usar pruebas RSpec para cualquier cosa que escribas en la línea de comandos repetidamente.
Haz lo mejor que puedas para mantener tus clases modulares y limpias y tus métodos haciendo solo una cosa cada uno. Este es el programa más grande que has escrito, por lo que definitivamente comenzarás a ver los beneficios de una buena organización (y pruebas) cuando comiences a encontrarte con errores.

El programa no es TDD, en el sentido de que primero he construído las clases y los métodos, y después he realizado las pruebas. Y sí, he realizado muchas, muchísimas pruebas (muchas más que el código de producción), de las cuales buena parte de ellas se realizan con Rspec (sobre todo las unitarias, o cuando son pocas las clases implicadas). He procurado ir poco a poco, paso a paso, caminando con pies de plomo, para evitar en la medida de lo posible escalar errores.
He hecho tres tipos de pruebas:
1. Pruebas con Rspec
2. Pruebas visuales (dibujando el tablero y viendo cómo se mueven en él las piezas, o qué casillas estaban amenazadas, o qué respuesta textual se muestra por pantalla, ).
3. Pruebas integrales en las que se utilizan partidas jugables.

También he modificado métodos o incluso creado métodos específicos para el testeo, que no se utilizan en el código de producción. Por ejemplo, la clase Board tiene un método, #analize_visual_check, que presenta por pantalla el dibujo del tablero pero sin piezas, marcando con una "x" las casillas amenazadas. O el método Referee#print_log: si le pasas "true" como parámetro opcional, te muestra el hash con el registro de movimientos en vez de en notación algebraica.

#¿No estás familiarizado con el ajedrez? Consulta algunos de los recursos adicionales para ayudarte a orientarte.

Tranquilo: sé jugar desde niño, y eso me ha ayudado mucho.

#¡Diviértete! Consulta los caracteres de ajedrez Unicode de Wikipedia para darle un poco de sabor a tu tablero de juego.

Sí: usé esos caracteres. Muchas gracias.

#Crédito adicional
Construye un jugador informático de IA muy básico (que tal vez haga un movimiento legal aleatorio).

No lo he impementado; tengo ganas de continuar con el Proyecto Odín, y no quiero retrasarme demasiado. Pero he dejado preparado el código para que se pueda hacer en el futuro. Luego veremos cómo se podría llevar a cabo.
-----------
# Descripción de las clases y funcionamiento del programa:

 - Clase Piece: es la clase de la que heredan las piezas concretas (peón, caballo, etc.). Tiene tres métodos "abstractos", que deben ser implementados por dichas piedras: #can_move?, que indica si una pieza puede mover o no a una determinada casilla; #can_capture?, que indica si puede capturar en una determinada casilla (difiere de #can_move? en los peones); y #move, mueve la pieza.
- Clases Peón, Caballo, Álfil, Torre, Dama y Rey: implementan los métodos anteriormente vistos. Las torres y reyes tienen además la propiedad @status, que indica si se han movido anteriormente (para el enroque), y si pueden ser comidos al paso en caso de los peones.
-Clase Board: guarda la posición de las piezas en el tablero, y también el turno del jugador al que le toca mover. Guarda también el verdadero registro (Hash con los movimientos) de la partida. Tiene métodos para retirar piezas del tablero, desplazarlas de una casilla a otra, crear nuevas fichas o hacer copias de las ya existentes.
-Clase Referee: controla que la partida se lleve a cabo según las reglas del ajedrez. Analiza el movimiento que se quiere hacer y lo ejecuta si es válido. Es quien ejecuta los movimientos especiales (enroque, captura al paso y promoción). Prohibe los movimientos que dejen al rey en jaque, y determina si una situación es jaque, jaque mate, ahogado u otro tipo de tablas obligatorias. Lleva el contador de movimentos y el falso registro (los movimientos en notación algebraica).
-Clase UserInterface: gestiona y filtra las entradas del usuario, así como las salidas por pantalla (quitando el dibujo del tablero, que lleva a cabo directamente la clase Board).
-Clase GameManager: controla las partes del programa que no son la partida en sí: el menú principal, la grabación y carga de partidas, etc.

He de reconocer que un punto débil del programa es la comunicación entre clases: podría estar mejor ordenada. A veces la clase referee se comunica directamente con la UserInterface, a veces lo hace a través de GameManager, etc... Aunque el juego funciona, es posible que este pequeño desorden pueda dificultar su escalado.

¡Esperemos que en el curso de Rails aprendamos algo sobre arquitectura de grandes proyectos de software!

-----------------------
# Mejoras a implementar el en futuro:
1. Tablas fotográficas (treefold y fivefold). Para eso se necesita:
- Un método que determine si dos piezas son iguales (si son la misma figura, del mismo color, están en la misma casilla del tablero y tienen el mismo estatus.
-Un método para clonar el tablero
-Un método para determinar si dos tableros son iguales (cuando todas sus piezas son iguales, y su turno de jugador es igual; no debe afectar ni su registro, ni el número de movimiento en el que se encuentren).
-Un registro que guarde un nuevo tablero (una foto del tablero) con cada movimiento válido.
-Un método que compare el tablero con todas las fotos anteriores, y avise cuándo hay tres o cinco tableros repetidos; probablemente sea mucho más eficiente que los que se comparen sean hashes y sólamente cuando coincidan éstos hacer una comparación minuciosa de los tableros.

2. AI básica (elige movimientos aleatorios).
El método Referee#analize_turn está implementado para analizar movimientos automatizados (de hecho, lo hace cuando actualizamos el tablero al cargar un registro grabado). Por lo que puede analizar y ejecutar movimientos generados por una IA.
Para hacer esta IA aleatoria, podríamos hacer que combinase todas las piezas que le quedan en el tablero con todas las casillas del mismo. En el peor de los casos, que es al comienzo de la partida, estos serían los resultados que daría:
16 x 64 = 1024 combinaciones
Después eliminaríamos aquellos movimientos que no estuviesen permitidos.
Entre los movimientos autorizados resultantes, elegiríamos uno al azar. El Referee lo analizaría, y, si no es legal (por ejemplo, deja al rey en jaque), lo eliminaríamos y escogeríamos otro.

¡Y POR FIN HE TERMINADO EL CURSO DE RUBY!