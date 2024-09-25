FROM jenkins/jenkins:lts

# Instalar Python y pip
USER root
RUN apt-get update && \
    apt-get install -y python3 python3-venv python3-pip

# Crear y activar un entorno virtual
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Instalar dependencias de Python
COPY requirements.txt /tmp/
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt

# Cambiar de nuevo al usuario Jenkins
USER jenkins