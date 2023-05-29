FROM python:3.11

WORKDIR /fastapi

ENV http_proxy "http://proxy-dmz.intel.com:911"
ENV https_proxy "http://proxy-dmz.intel.com:912"
ENV no_proxy "*.intel.com,intel.com,localhost,127.0.0.1"

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip3 install cython==0.29.33

COPY requirements.txt requirements-gunicorn.txt requirements-uvicorn.txt ./

RUN pip3 install -r requirements.txt -r requirements-gunicorn.txt -r requirements-uvicorn.txt

COPY . ./

EXPOSE 8080

CMD gunicorn app:app -k uvicorn.workers.UvicornWorker -c fastapi_conf.py
