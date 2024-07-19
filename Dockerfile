FROM ubuntu:20.04

RUN apt-get update && apt-get install -y git npm
RUN npm install -g n
RUN n stable
RUN apt-get purge -y nodejs npm

# RUN pip install --no-cache-dir --break-system-packages \
#     numpy pandas \
#     torch torchvision torchaudio

CMD ["tail", "-f", "/dev/null"]
