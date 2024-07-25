FROM ubuntu:20.04

RUN apt-get update && apt-get install -y git python3 python3-pip

RUN pip install --no-cache-dir \
    pandas numpy matplotlib

CMD ["python3", "main.py"]
