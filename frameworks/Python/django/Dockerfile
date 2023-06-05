# FROM python:3.9-
FROM ubuntu:20.04

# ADD ./ /django
ADD ./ /home/changyan/django

# WORKDIR /django
WORKDIR /home/changyan/django

#---------------------------------- Download corresponding deb ------------------------------------
RUN apt update && \
	apt install -y \
		binutils-dev \
		bison \
		build-essential \
		flex \
		git \
        pip \
        libcap-dev \
		libdw-dev \
		libelf-dev \
		libiberty-dev \
		libnuma-dev \
        libperl-dev \
		libslang2-dev \
		libunwind-dev \
		libzstd-dev \
		python3-dev \
		systemtap-sdt-dev \
        libmysqlclient-dev \
        libpq-dev && \
	rm -rf /var/lib/apt/lists/*

#---------------------------------- Compile perf binary ------------------------------------
# COPY os.linux.intelnext.kernel.tar.gz /app
RUN tar zxf os.linux.intelnext.kernel.tar.gz && \
	cd /home/changyan/django/os.linux.intelnext.kernel/tools/perf && \
	make -j && \
	make install prefix=/usr/local && \
	rm -rf /app/os.linux.intelnext.kernel*

#------------------------------- Install server deb and run server ---------------------------

RUN pip install -r /home/changyan/django/requirements-gunicorn.txt

EXPOSE 8080

RUN chmod +x run_server_and_collect.sh

# CMD gunicorn --pid=gunicorn.pid hello.wsgi:application -c gunicorn_conf.py --env DJANGO_DB=mysql
CMD ["/bin/bash", "run_test.sh" ]

