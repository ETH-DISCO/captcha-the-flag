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
        request = urllib.request.Request(url)
        request.add_header('Host', host_header)
        contents = urllib.request.urlopen(request).read()

        if contents.decode('utf-8').find('captcha') != -1:
            GREEN = '\033[92m'
            RESET = '\033[0m'
            print(f'{GREEN}success:{RESET}\n{contents.decode("utf-8")}')

    except Exception as e:
        print(f'error: {e}')
    time.sleep(3)
