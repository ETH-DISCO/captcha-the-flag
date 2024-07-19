FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git npm curl wget python3 python3-pip
RUN npm install -g n
RUN n stable
RUN apt-get purge -y nodejs npm


RUN git config --global user.email "hello@world.com"
RUN git config --global user.name "docker alias"

# RUN pip install --no-cache-dir --break-system-packages \
#     numpy pandas \
#     torch torchvision torchaudio

CMD ["tail", "-f", "/dev/null"]
