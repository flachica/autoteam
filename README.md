# Proyecto Autoteam

Herramienta para la gestión de reservas de pistas de pádel.

## Estructura
- **Backend**: `/root/proyectos/autoteam-back` (NestJS)
- **Frontend**: `/root/proyectos/autoteam-front` (Next.js)
- **Database GUI**: `/root/proyectos/sqlite-gui`

## Gestión en Producción (Systemd)

Este proyecto utiliza **Systemd** nativo de Linux para la gestión de servicios, eliminando capas de complejidad como PM2.

### Comandos de Control Rápidos
En el directorio `/root/proyectos/` existen scripts para facilitar las tareas comunes:

- **Reconstruir y Desplegar**:
  ```bash
  /root/proyectos/build.sh
  ```
  *Detiene servicios, actualiza dependencias, construye backend y frontend (con optimización de memoria) y reinicia todo.*

- **Iniciar Servicios**:
  ```bash
  /root/proyectos/start-all.sh
  ```

- **Detener Servicios**:
  ```bash
  /root/proyectos/stop-all.sh
  ```

### Gestión Manual con Systemctl
Puedes controlar cada servicio individualmente usando los comandos estándar de Linux:

```bash
# Estado
systemctl status autoteam-front
systemctl status autoteam-back
systemctl status sqlite-gui

# Reiniciar
systemctl restart autoteam-front

# Ver logs
journalctl -u autoteam-front -f
journalctl -u autoteam-back -f
```

### Configuración de Red (Nginx)
El servidor utiliza Nginx como reverse proxy:
- **Frontend**: https://padeleros.vip (Proxy a localhost:4000)
- **Backend API**: https://padeleros.vip:8443 (Proxy a localhost:3000)

La configuración de Nginx se encuentra en este repositorio en el archivo `nginx.conf` para referencia.

### Optimización de Memoria
El servidor tiene recursos limitados (1GB RAM).
- El script `build.sh` aplica `NODE_OPTIONS="--max-old-space-size=1536"` para aprovechar el SWAP durante la compilación.
- Los servicios en tiempo de ejecución tienen límites de memoria configurados en sus unidades de Systemd.


Revisa el nginx.conf para la configuración de red.