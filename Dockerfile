FROM jenkins/jenkins:lts

# Instalar Python, pip y Behave
USER root
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install behave

# Cambiar de nuevo al usuario Jenkins
USER jenkins