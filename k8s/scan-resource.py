
from kubernetes import client, config
import requests
import time

# Load kubeconfig
config.load_kube_config()

v1 = client.CoreV1Api()

# Webhook URL
WEBHOOK_URL = 'YOUR_WEBHOOK_URL'

def send_notification(pod_name):
    message = {
        'text': f'Pod {pod_name} deployed successfully!'
    }
    response = requests.post(WEBHOOK_URL, json=message)
    if response.status_code != 200:
        raise ValueError(
            'Request to webhook returned an error %s, the response is:\n%s'
            % (response.status_code, response.text)
        )

def check_pod_status(namespace='default'):
    pods = v1.list_namespaced_pod(namespace)
    for pod in pods.items:
        if pod.status.phase == 'Running':
            send_notification(pod.metadata.name)

if __name__ == "__main__":
    while True:
        check_pod_status()
        time.sleep(60)  # Kiểm tra mỗi 60 giây
