FROM ubuntu

RUN apt update

RUN apt install --yes python3 python3-pip
RUN apt clean
RUN apt autoremove
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN ln -s /usr/bin/pip3 /usr/bin/pip
RUN pip install flask
RUN pip install uwsgi
RUN pip install numpy scikit-learn scipy
RUN useradd -r -s /bin/false uwsgi
RUN mkdir /var/www && mkdir /var/www/app
RUN chown -R uwsgi:uwsgi /var/www/app
USER uwsgi
EXPOSE 8080

CMD ["uwsgi","--ini","var/www/app/uwsgi.ini"]
