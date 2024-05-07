helm upgrade -i fluent-bit fluent/fluent-bit -n observability --create-namespace -f fluent-bit.yaml
## Elasticsearch
- Step 1: git clone https://github.com/elastic/helm-charts.git
- Step 2: edit cd helm-charts/elasticsearch/
- Step 3: edit templates/statefulset.yaml
```
- name: xpack.security.http.ssl.enabled
  value: "false"
```
- Step 4: helm upgrade --install elasticsearch -n observability . --create-namespace -f elasticsearch.yaml
## Kibana
- Step 1:  git clone https://github.com/elastic/helm-charts.git
- Step 2: edit cd helm-charts/elasticsearch
- Step 3: vi templates/pre-install-job.yaml
```
- name: ELASTICSEARCH_SSL_CERTIFICATEAUTHORITIES
  value: "{{ template "kibana.home_dir" . }}/config/certs/{{ .Values.elasticsearchCertificateAuthoritiesFile }}"
```
- Step 4: vi templates/deployment.yaml
```
- name: ELASTICSEARCH_SSL_CERTIFICATEAUTHORITIES
  value: "{{ template "kibana.home_dir" . }}/config/certs/{{ .Values.elasticsearchCertificateAuthoritiesFile }}"
```
- Step 5: vi templates/configmap-helm-scripts.yaml
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ template "kibana.fullname" . }}-helm-scripts
  labels: {{ include "kibana.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": pre-install,pre-upgrade,post-delete
    "helm.sh/hook-delete-policy": hook-succeeded
    {{- if .Values.annotations }}
    {{- range $key, $value := .Values.annotations }}
    {{ $key }}: {{ $value | quote }}
    {{- end }}
    {{- end }}
data:
  manage-es-token.js: |
    const http = require('http');
    const https = require('https');
    const fs = require('fs');
 
    // Read environment variables
    function getEnvVar(name) {
      if (!process.env[name]) {
        throw new Error(name + ' environment variable is missing')
      }
      return process.env[name]
    }
 
    // Elasticsearch API
    const esPath = '_security/service/elastic/kibana/credential/token/{{ template "kibana.fullname" . }}';
    const esUrl = '{{ .Values.elasticsearchHosts }}' + '/' + esPath
    const esUsername = getEnvVar('ELASTICSEARCH_USERNAME');
    const esPassword = getEnvVar('ELASTICSEARCH_PASSWORD');
    const esAuth = esUsername + ':' + esPassword;
 
    // Kubernetes API
    const k8sHostname = getEnvVar('KUBERNETES_SERVICE_HOST');
    const k8sPort = getEnvVar('KUBERNETES_SERVICE_PORT_HTTPS');
    const k8sPostSecretPath = 'api/v1/namespaces/{{ .Release.Namespace }}/secrets';
    const k8sDeleteSecretPath = 'api/v1/namespaces/{{ .Release.Namespace }}/secrets/{{ template "kibana.fullname" . }}-es-token';
    const k8sPostSecretUrl = `https://${k8sHostname}:${k8sPort}/${k8sPostSecretPath}`;
    const k8sDeleteSecretUrl = `https://${k8sHostname}:${k8sPort}/${k8sDeleteSecretPath}`;
    const k8sBearer = fs.readFileSync('/run/secrets/kubernetes.io/serviceaccount/token');
    const k8sCa = fs.readFileSync('/run/secrets/kubernetes.io/serviceaccount/ca.crt');
 
    // Post Data
    const esTokenDeleteOptions = {
      method: 'DELETE',
      auth: esAuth
    };
    const esTokenCreateOptions = {
      method: 'POST',
      auth: esAuth
    };
    const secretCreateOptions = {
      method: 'POST',
      ca: k8sCa,
      headers: {
        'Authorization': 'Bearer ' + k8sBearer,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }
    };
    const secretDeleteOptions = {
      method: 'DELETE',
      ca: k8sCa,
      headers: {
        'Authorization': 'Bearer ' + k8sBearer,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }
    };
 
    // With thanks to https://stackoverflow.com/questions/57332374/how-to-chain-http-request
    function requestPromise(url, httpsOptions, extraOptions = {}) {
      return new Promise((resolve, reject) => {
        const request = http.request(url, httpsOptions, response => {
 
          console.log('statusCode:', response.statusCode);
 
          let isSuccess = undefined;
 
          if (typeof(extraOptions.extraStatusCode) != "undefined" && extraOptions.extraStatusCode != null) {
            isSuccess = response.statusCode >= 200 && response.statusCode < 300 || response.statusCode == extraOptions.extraStatusCode;
          } else {
            isSuccess = response.statusCode >= 200 && response.statusCode < 300;
          }
 
          let data = '';
          response.on('data', chunk => data += chunk); // accumulate data
          response.once('end', () => isSuccess ? resolve(data) : reject(data));  // resolve promise here
        });
 
        request.once('error', err => {
          // This won't log anything for e.g. an HTTP 404 or 500 response,
          // since from HTTP's point-of-view we successfully received a
          // response.
          console.log(`${httpsOptions.method} ${httpsOptions.path} failed: `, err.message || err);
          reject(err);  // if promise is not already resolved, then we can reject it here
        });
 
        if (typeof(extraOptions.payload) != "undefined") {
          request.write(extraOptions.payload);
        }
        request.end();
      });
    }
 
    function requestPromiseHttps(url, httpsOptions, extraOptions = {}) {
      return new Promise((resolve, reject) => {
        const request = https.request(url, httpsOptions, response => {
 
          console.log('statusCode:', response.statusCode);
 
          let isSuccess = undefined;
 
          if (typeof(extraOptions.extraStatusCode) != "undefined" && extraOptions.extraStatusCode != null) {
            isSuccess = response.statusCode >= 200 && response.statusCode < 300 || response.statusCode == extraOptions.extraStatusCode;
          } else {
            isSuccess = response.statusCode >= 200 && response.statusCode < 300;
          }
 
          let data = '';
          response.on('data', chunk => data += chunk); // accumulate data
          response.once('end', () => isSuccess ? resolve(data) : reject(data));  // resolve promise here
        });
 
        request.once('error', err => {
          // This won't log anything for e.g. an HTTP 404 or 500 response,
          // since from HTTP's point-of-view we successfully received a
          // response.
          console.log(`${httpsOptions.method} ${httpsOptions.path} failed: `, err.message || err);
          reject(err);  // if promise is not already resolved, then we can reject it here
        });
 
        if (typeof(extraOptions.payload) != "undefined") {
          request.write(extraOptions.payload);
        }
        request.end();
      });
    }
 
    function createEsToken() {
      // Chaining requests
      console.log('Cleaning previous token');
      // 404 status code is accepted if there is no previous token to clean
      return requestPromise(esUrl, esTokenDeleteOptions, {extraStatusCode: 404}).then(() => {
        console.log('Creating new token');
        return requestPromise(esUrl, esTokenCreateOptions).then(response => {
          const body = JSON.parse(response);
          const token = body.token.value
 
          // Encode the token in base64
          const base64Token = Buffer.from(token, 'utf8').toString('base64');
 
          // Prepare the k8s secret
          const secretData = JSON.stringify({
            "apiVersion": "v1",
            "kind": "Secret",
            "metadata": {
              "namespace": "{{ .Release.Namespace }}",
              "name": "{{ template "kibana.fullname" . }}-es-token",
            },
            "type": "Opaque",
            "data": {
              "token": base64Token,
            }
          })
 
          // Create the k8s secret
          console.log('Creating K8S secret');
          return requestPromiseHttps(k8sPostSecretUrl, secretCreateOptions, {payload: secretData})
        });
      });
    }
 
    function cleanEsToken() {
      // Chaining requests
      console.log('Cleaning token');
      return requestPromise(esUrl, esTokenDeleteOptions).then(() => {
        // Create the k8s secret
        console.log('Delete K8S secret');
        return requestPromiseHttps(k8sDeleteSecretUrl, secretDeleteOptions)
      });
    }
 
    const command = process.argv[2];
    switch (command) {
      case 'create':
        console.log('Creating a new Elasticsearch token for Kibana')
        createEsToken().catch(err => {
          console.error(err);
          process.exit(1);
        });
        break;
      case 'clean':
        console.log('Cleaning the Kibana Elasticsearch token')
        cleanEsToken().catch(err => {
          console.error(err);
          process.exit(1);
        });
        break;
      default:
        console.log('Unknown command');
        process.exit(1);
    }
```
- Step 6: helm upgrade --install kibana -n observability  . --create-namespace -f kibana.yaml
## Apm
helm install apm-server elastic/apm-server -n observability --set imageTag=8.5.1 -f apm.yaml
## ELASTICSEARCH STADARDLONE
- install elasticseach
```
helm upgrade --install elasticsearch oci://registry-1.docker.io/bitnamicharts/elasticsearch -n devops -f elasticsearch-values-standardlone.yaml

```
- install kibana
```
helm upgrade  --install kibana oci://registry-1.docker.io/bitnamicharts/kibana  -n devops -f kibana-values-sd.yaml
```

## Schedule crontab
```
# Every fifteen minutes (perhaps at :07, :22, :37, :52):
H/15 * * * *
# Every ten minutes in the first half of every hour (three times, perhaps at :04, :14, :24):
H(0-29)/10 * * * *
# Once every two hours at 45 minutes past the hour starting at 9:45 AM and finishing at 3:45 PM every weekday:
45 9-16/2 * * 1-5
# Once in every two hour slot between 8 AM and 4 PM every weekday (perhaps at 9:38 AM, 11:38 AM, 1:38 PM, 3:38 PM):
H H(8-15)/2 * * 1-5
# Once a day on the 1st and 15th of every month except December:
H H 1,15 1-11 *
```
