# install playwright, find vpn rotation tools

import requests
import random
import time
import os

while True:
    # fetch localhost:8080
    GREEN = '\033[92m'
    RESET = '\033[0m'

    # response = requests.get('http://localhost:8080')
    response = requests.get('https://google.com/')
    print(f'{GREEN}Response:{RESET}\n{response.text}\n\n\n')
    time.sleep(5)
