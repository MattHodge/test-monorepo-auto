import urllib.request
import time
import json

# cluster
host = "intake"
port = 9998

url = "http://{}:{}".format(host, port)
print("Emitter starting and sending metrics to 1: {}\n".format(url))
while True:
    newConditions = {"Host":"emitter", "MetricName":"emitter.hit.count", "Value": 4}
    params = json.dumps(newConditions).encode('utf8')
    req = urllib.request.Request(url, data=params, headers={'content-type': 'application/json'})
    with urllib.request.urlopen(req) as f:
        print(f.read().decode('utf-8'))
    time.sleep(5)
#
