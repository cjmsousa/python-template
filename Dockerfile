##################################################################################################################
# Release stage
##################################################################################################################
FROM python:3.8 AS release  

# Set the working directory in the container
WORKDIR /app

# Install requirements
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy source code
COPY src/ .

#Install graphviz
RUN apt-get update
RUN apt-get install -y graphviz

# Start the app
CMD ["python", "./app.py"] 

##################################################################################################################
# Development stage
##################################################################################################################
FROM python:3.8 AS development

#Copy the content of the relase image
COPY --from=release / /

# Install requirements
COPY requirements-dev.txt .
RUN pip install -r requirements-dev.txt

# Start the app
CMD ["python", "./app.py"]

##################################################################################################################
# Unit tests stage
##################################################################################################################
FROM python:3.8 AS unit-tests

#Copy the content of the relase image
COPY --from=development / /

# Start the app
CMD ["python", "./app.py"]