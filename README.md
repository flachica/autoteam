# Proyecto Autoteam

Herramienta para la gestión de reservas de pistas de pádel.

## Estructura
- **Backend**: `/root/proyectos/autoteam-back` (NestJS)
- **Frontend**: `/root/proyectos/autoteam-front` (Next.js)
- **Database GUI**: `/root/proyectos/sqlite-gui`

## Gestión en Producción (PM2)

Este proyecto utiliza **PM2** para gestionar los procesos en producción.

### Estado de los servicios
Ver el estado de todos los procesos:
```bash
pm2 list
```

### Logs
Ver logs en tiempo real:
```bash
pm2 logs
```
Ver logs de un servicio específico:
```bash
pm2 logs autoteam-front
pm2 logs autoteam-back
```

### Desplegar cambios
Para actualizar la aplicación después de subir cambios al servidor:

1. **Backend**:
   ```bash
   cd /root/proyectos/autoteam-back
   npm install
   npm run build
   pm2 restart autoteam-back
   ```

2. **Frontend**:
   ```bash
   cd /root/proyectos/autoteam-front
   npm install
   npm run build
   pm2 restart autoteam-front
   ```

### Reiniciar todo
```bash
pm2 restart all
```

### Puertos
- **Frontend**: 4000
- **Backend**: 3000
- **SQLite GUI**: 5000 (interfaz) / 8080 (socket)

## Autoinicio
La persistencia tras reinicios está configurada mediante PM2. Si realizas cambios en la lista de procesos (añadir/quitar), ejecuta:
```bash
pm2 save
```
Esto guardará la configuración actual para que arranque automáticamente al iniciar el servidor.
