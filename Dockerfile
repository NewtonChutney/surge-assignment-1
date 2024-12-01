FROM python:alpine

WORKDIR /python-docker

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .
# ADD ./tools /python-docker/tools

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=8080"]
