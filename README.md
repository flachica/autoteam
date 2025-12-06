# Proyecto Autoteam

Herramienta para la gestión de reservas de pistas de pádel. Los usuarios pueden registrarse con su teléfono o cuenta de correo y apuntarse a las pistas "abiertas" de la semana. Es una alternativa a la gestión mediante mensajería instantánea y que permite automatizar el cierre de partidos. Además, lleva un riguroso control del saldo

Este proyecto contiene tanto el frontend como el backend para una experiencia de desarrollo más cómoda. Utiliza un contenedor de desarrollo (`devcontainer`) y un espacio de trabajo de Visual Studio Code.

## Requisitos

- Docker
- Visual Studio Code
- Extensión de Dev Containers para Visual Studio Code

## Configuración del Dev Container

1. Despliega el devcontainer y espera que termine de clonarse los repositorios

2. Abre el espacio de trabajo de Visual Studio Code (`.code-workspace`).

## Estructura del Proyecto

- **Backend**: [autoteam-back](https://github.com/flachica/autoteam-back)
- **Frontend**: [autoteam-front](https://github.com/flachica/autoteam-front)

## Scripts de Desarrollo

Incluyo alias y carpeta .vscode

# Despliegue en producción

## Project Setup from Scratch

In case of a disaster, follow these steps to redeploy the entire project.

### 1. Prerequisites

-   Node.js (version >= 16.0.0)
-   npm

### 2. Source Code

It is assumed that you have a backup of the source code. If the project is versioned with git, clone the repository. Otherwise, copy the project files to the `/root/proyectos` directory.

### 3. Environment Variables

Each sub-project uses a `.env` file for configuration. These files are not included in the source code and must be created manually.

-   `autoteam-back/.env`
-   `autoteam-front/.env`

Create these files and populate them with the necessary environment variables.

### 4. Install Dependencies and Build

The `build.sh` script installs dependencies for all services and creates production builds.

```bash
/root/proyectos/build.sh
```

### 5. Configure Autostart on Reboot

To ensure the services are started automatically on system reboot, add the `reboot-startup.sh` script to your crontab.

```bash
(crontab -l 2>/dev/null; echo "@reboot /root/proyectos/reboot-startup.sh") | crontab -
```

## Scripts

This section details the scripts used to manage the project's services.

### `build.sh`

Builds all applications (backend, frontend). This includes installing npm dependencies and running the build command for each.

**Source Code:**
```bash
#!/bin/bash
echo "Building backend..."
cd /root/proyectos/autoteam-back
npm install
npm run build

echo "Building frontend..."
cd /root/proyectos/autoteam-front
npm install
npm run build

echo "Build finished."
```

### `start-all.sh`

Starts all services (backend, frontend, and SQL GUI) in the background.

**Source Code:**
```bash
#!/bin/bash
echo "Starting all services..."
/root/proyectos/start.back.sh
/root/proyectos/start.front.sh
/root/proyectos/start.sqlgui.sh
echo "Services started."
```

### `stop-all.sh`

Stops all running services.

**Source Code:**
```bash
#!/bin/bash
echo "Stopping all services..."

if [ -f /root/proyectos/autoteam-back.pid ]; then
    kill $(cat /root/proyectos/autoteam-back.pid)
    rm /root/proyectos/autoteam-back.pid
fi

if [ -f /root/proyectos/autoteam-front.pid ]; then
    kill $(cat /root/proyectos/autoteam-front.pid)
    rm /root/proyectos/autoteam-front.pid
fi

if [ -f /root/proyectos/sqlite-gui.pid ]; then
    kill $(cat /root/proyectos/sqlite-gui.pid)
    rm /root/proyectos/sqlite-gui.pid
fi

echo "Services stopped."
```

### `reboot-startup.sh`

This script is intended to be run on system reboot. It builds and starts all services.

**Source Code:**
```bash
#!/bin/bash
echo "Running reboot startup script..."
/root/proyectos/build.sh
/root/proyectos/start-all.sh
echo "Reboot startup script finished."
```

### `start.back.sh`

Starts the backend service in production mode.

**Source Code:**
```bash
#!/bin/bash

# Crear las carpetas necesarias si no existen
mkdir -p "$HOME/logs"
cd $HOME/proyectos/autoteam-back
# Ejecutar el comando y redirigir los logs
nohup npm run start:prod > "$HOME/logs/back.log" 2>&1 & echo $! > /root/proyectos/autoteam-back.pid
```

### `start.front.sh`

Starts the frontend service in production mode.

**Source Code:**
```bash
#!/bin/bash

# Crear las carpetas necesarias si no existen
mkdir -p "$HOME/logs"
cd $HOME/proyectos/autoteam-front
# Ejecutar el comando y redirigir los logs
nohup npm run start -- --max-old-space-size=400 > "$HOME/logs/front.log" 2>&1 & echo $! > /root/proyectos/autoteam-front.pid
```

### `start.sqlgui.sh`

Starts the SQL GUI service.

**Source Code:**
```bash
#!/bin/bash

# Crear las carpetas necesarias si no existen
mkdir -p "$HOME/logs"
cd $HOME/proyectos/sqlite-gui
# Ejecutar el comando y redirigir los logs
nohup npm --max-old-space-size=400 run start > "$HOME/logs/sqlgui.log" 2>&1 & echo $! > /root/proyectos/sqlite-gui.pid
```
