FROM python:3.9.12-buster

ENV FLASH_APP='app.py'
ENV FLASK_ENV='development'

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

CMD ["python","-m","flask","run", "--host=0.0.0.0"]