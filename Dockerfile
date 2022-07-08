FROM python:3.9.4

WORKDIR /
COPY requirements.txt /
RUN pip install -r application/requirements.txt
RUN python manage.py makemigrations