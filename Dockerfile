FROM python:3.9.4

RUN mkdir -p /home/app
ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN mkdir -p $APP_HOME/staticfiles
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . $APP_HOME
