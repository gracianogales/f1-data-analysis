Ahora implementa el proyecto completo a partir de la arquitectura y diseño definidos anteriormente.

Quiero que desarrolles una aplicación web funcional, modular y visualmente espectacular para visualización de telemetría de Fórmula 1.

OBJETIVO
Construir un dashboard premium de análisis de telemetría para una masterclass, con estética de ingeniería de carrera y con una experiencia visual de alto impacto.

INSTRUCCIONES GENERALES
- Implementa la solución completa usando el stack elegido en la fase anterior.
- Genera todos los archivos necesarios.
- Usa una estructura de proyecto limpia y profesional.
- El código debe ser claro, modular y mantenible.
- Añade comentarios solo donde aporten valor real.
- Incluye un README con pasos exactos para ejecutar el proyecto en local.
- Si no hay datos reales, genera un dataset simulado creíble y bien estructurado.

REQUISITOS DE CALIDAD
No quiero un prototipo básico.
Quiero una demo muy pulida, con sensación premium, apta para proyectarse en una masterclass y causar impacto visual.

REQUISITOS FUNCIONALES OBLIGATORIOS

1. HEADER / CONTROL BAR
Implementa una barra superior elegante con:
- título potente
- subtítulo técnico
- selectores de circuito
- sesión
- piloto 1
- piloto 2
- vuelta
- selector de métrica para el circuito

2. KPI CARDS
Incluye tarjetas visuales premium para:
- lap time piloto 1
- lap time piloto 2
- delta total
- max speed
- average speed
- throttle %
- brake %
- sector winner summary

3. TRACK MAP / CIRCUITO
Implementa una visualización del circuito que sea una de las piezas centrales del dashboard.
Debe incluir:
- trazado de la vuelta
- color dinámico según métrica seleccionada:
  - speed
  - throttle
  - brake
  - gear
  - delta
- aspecto visual muy cuidado
- leyenda clara
- si es posible, marcas de sectores y curvas
- tooltips elegantes

4. TELEMETRY STACK
Implementa una vista de telemetría tipo ingeniería con gráficas sincronizadas por distancia.
Debe incluir:
- speed
- throttle
- brake
- gear
- delta time

Estas gráficas deben:
- compartir eje X
- tener buena separación visual
- permitir hover claro
- facilitar comparación entre dos pilotos

5. SECTOR ANALYSIS
Implementa una sección visual para comparar:
- sector 1
- sector 2
- sector 3
Debe indicar quién gana cada uno y por cuánto.

6. CORNER ANALYSIS
Implementa una sección con curvas o segmentos destacados:
- nombre o identificador de curva
- velocidad de entrada
- velocidad mínima
- velocidad de salida
- diferencia entre pilotos
- observación breve

7. INSIGHTS AUTOMÁTICOS
Añade una sección textual premium con conclusiones automáticas, por ejemplo:
- dónde gana tiempo un piloto
- si frena más tarde
- si acelera antes
- si mantiene mayor velocidad en curva
- en qué sector se concentra la diferencia

8. STORY MODE / EXPLANATION PANEL
Añade un bloque de narrativa visual tipo:
- “Piloto A gana tiempo en curvas rápidas”
- “Piloto B recupera en recta”
- “La mayor diferencia aparece en el sector 2”
Debe ayudarme a explicar la vuelta durante la charla.

DATOS
Si no usas datos reales, genera mock data realista con columnas como:
- distance
- time
- speed
- throttle
- brake
- gear
- rpm
- x
- y
- sector
- corner
- driver
- lap
- session
- circuit

Los datos deben simular una comparación creíble entre dos pilotos con estilos distintos:
- uno ligeramente mejor en recta
- otro ligeramente mejor en curva
- diferencias realistas en aceleración, frenada y velocidad mínima

DISEÑO VISUAL
Quiero un acabado muy cuidado:
- dark mode premium
- estética motorsport / ingeniería avanzada
- tipografía clara
- paneles elegantes
- espacio visual bien gestionado
- sensación de software técnico de alto valor
- evitar look genérico
- transiciones suaves si el stack lo permite

REGLAS IMPORTANTES
- Prioriza el impacto visual
- Prioriza la legibilidad en pantalla grande
- Prioriza una narrativa clara para una masterclass
- No conviertas esto en un dashboard BI clásico
- Quiero una herramienta que parezca casi producto real

ENTREGABLES
Genera:
1. estructura completa de archivos
2. todo el código fuente
3. dataset mock si hace falta
4. README.md
5. breve explicación de cómo personalizar circuitos, pilotos y sesiones

FORMA DE TRABAJO
Quiero que construyas el proyecto archivo por archivo, con estructura clara.
Si lo consideras útil:
- empieza mostrando el árbol de directorios
- luego implementa los ficheros principales
- después los secundarios
- y termina con README e instrucciones

Acabado final:
añade detalles premium que eleven la demo, como por ejemplo:
- estado inicial elegante
- etiquetas técnicas
- badges sutiles
- microtextos de contexto
- sensación de “race engineering workstation”

Empieza ya con la implementación completa.

