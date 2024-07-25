# install playwright, find vpn rotation tools

import urllib.request
import os
import time


def is_docker():
    return os.path.exists('/.dockerenv')

if is_docker():
    print('running in docker')
    url = 'http://captcha:8080/'
    host_header = 'captcha'
else:
    print('running locally')
    url = 'http://localhost:8080/'
    host_header = 'localhost'

while True:
    try:
        GREEN = '\033[92m'
        RESET = '\033[0m'
        
        request = urllib.request.Request(url)
        request.add_header('Host', host_header)
        
        # Debugging output
        print(f'Sending request to URL: {url} with Host header: {host_header}')
        
        contents = urllib.request.urlopen(request).read()

        print(f'{GREEN}Response:{RESET}')
        print(contents)
        print('\n\n\n\n')
    except Exception as e:
        print(f'Error: {e}')
    time.sleep(1)
