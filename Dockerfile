FROM python:3.8-slim

WORKDIR /app1

COPY . /app1

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "/app1/app.py"]
