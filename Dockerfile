# set base image (host OS)
FROM python:3.8

# set the working directory in the container
WORKDIR /app

# copy the dependencies file to the working directory
COPY requirements.txt .

# install dependencies
RUN pip install -r requirements.txt

# copy source code and definition file
COPY src/ .

#Install graphviz
RUN apt-get update
RUN apt-get install -y graphviz

#Check graphviz version
RUN dot -V

# command to run on container start
CMD [ "python", "./builder.py"]