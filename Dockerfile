# Usa la imagen base de Jenkins
FROM jenkins/jenkins:lts

# Cambia a usuario root para instalar dependencias
USER root

# Instala Python, pip, git y las dependencias para mysqlclient
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    default-libmysqlclient-dev \
    build-essential

# Crea un entorno virtual y activa
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copia el archivo requirements.txt al contenedor
COPY requirements.txt /app/requirements.txt

# Instala las dependencias desde requirements.txt
RUN pip install -r /app/requirements.txt

# Cambia de nuevo a usuario Jenkins
USER jenkins