#!bin/bash
docker build -t wisecow-app .
docker run -p 4499:8000 wisecow-app