FROM python:3.9-alpine3.13
# This is the base image for the container. It is a lightweight version of Python 3.9 for Alpine Linux.
LABEL maintainer="umairiqbal9889@gmail.com" 
# This is the metadata for the image.

ENV PYTHONUNBUFFERED=1 
# This is to prevent Python from buffering stdout and stderr. It is useful for logging.

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
# This is the command to install the required packages and create a virtual environment and user.
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    apk del .tmp-build-deps && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"
USER django-user
 