Así es, en la función `plot` de Octave (y MATLAB), los parámetros de estilo de línea y color pueden ser personalizados usando un código de formato que combina símbolos para definir el tipo de línea, el color y los marcadores de los puntos. Aquí te explico los más comunes:

### Estilos de Línea
- `'-'`: Línea continua.
- `'--'`: Línea discontinua (guiones).
- `':'`: Línea punteada.
- `'-.'`: Línea de puntos y guiones.

### Marcadores de Puntos
- `'o'`: Círculo.
- `'+'`: Más.
- `'*'`: Asterisco.
- `'.'`: Punto.
- `'x'`: Cruz.
- `'s'`: Cuadrado.
- `'d'`: Diamante.
- `'^'`: Triángulo hacia arriba.
- `'v'`: Triángulo hacia abajo.
- `'>'`: Triángulo hacia la derecha.
- `'<'`: Triángulo hacia la izquierda.
- `'p'`: Pentágono.
- `'h'`: Hexágono.

### Colores
- `'b'`: Azul (blue).
- `'g'`: Verde (green).
- `'r'`: Rojo (red).
- `'c'`: Cian (cyan).
- `'m'`: Magenta.
- `'y'`: Amarillo (yellow).
- `'k'`: Negro (black).
- `'w'`: Blanco (white).

### Ejemplos de Combinaciones
- `'ob'`: Círculos azules.
- `'-r'`: Línea continua roja.
- `'--g'`: Línea discontinua verde.
- `'s:k'`: Cuadrados negros con línea punteada.

### Ejemplo en contexto
```octave
plot(tg, yg, '-or')  % Línea continua roja con marcadores de círculos
```
En este ejemplo, `'-or'` dibuja una línea continua roja y añade círculos en los puntos de datos.

Puedes combinar estos símbolos de distintas formas para personalizar tus gráficos. ¿Hay alguna combinación específica que te gustaría probar o necesitas alguna recomendación para tu gráfico?