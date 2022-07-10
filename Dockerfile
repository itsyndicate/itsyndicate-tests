FROM python:3.8-alpine

RUN pip install --upgrade pip

COPY ./requirements.txt .

RUN apk add --no-cache postgresql-libs
RUN apk --update add libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc openssl-dev curl
RUN apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev
RUN apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev
RUN python3 -m pip install -r requirements.txt --no-cache-dir
RUN apk --purge del .build-deps
#RUN pip install Pillow

COPY . /app

WORKDIR /app

COPY ./entrypoint.sh /
ENTRYPOINT ["sh", "/entrypoint.sh"]