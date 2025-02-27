## Dast Scan using ZAP Proxy
Help site: https://docs.checkmarx.com/en/34965-154714-dast-generate-a-zap-configuration-file.html

### scan options: zap-api-scan.py, zap-baseline.py, zap_common.py, zap-full-scan.py
### set the URL to scan
export URL=https://httpbin.org
docker run --rm -v /mnt/c/repository/DevSecLab/zap-dast-scan:/zap/wrk zaproxy/zap-stable zap-full-scan.py -t $URL -r zap_report.html -d -a -j -T 900


docker run --rm -v /mnt/c/repository/DevSecLab/zap-dast-scan:/zap/wrk zaproxy/zap-stable zap-full-scan.py -t https://www.example.com -r zap_report.html
docker run --rm -v /mnt/c/repository/DevSecLab/zap-dast-scan:/zap/wrk zaproxy/zap-stable zap-full-scan.py -t https://www.example.com -r zap_report.html -d -a -j -T 3600

## using mounted config yaml file
docker run --rm -v /mnt/c/repository/DevSecLab/zap-dast-scan:/zap/wrk -v /mnt/c/repository/DevSecLab/zap-dast-scan:/tmp/ zaproxy/zap-stable zap.sh -cmd -autorun /tmp/zap_config.yaml

## get scan help
docker run --rm -v /mnt/c/repository/DevSecLab/zap-dast-scan:/zap/wrk zaproxy/zap-stable zap-full-scan.py -h

## build yaml config file
https://docs.checkmarx.com/en/34965-154714-dast-generate-a-zap-configuration-file.html

## more scripts at https://github.com/zaproxy/zaproxy/tree/main/docker


docker run --rm -v /mnt/c/repository/DevSecLab/zap-dast-scan:/zap/wrk zaproxy/zap-stable zap-full-scan.py -t https://www.example.com -r zap_report.html -d -a -j -T 900
