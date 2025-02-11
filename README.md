# ParkingWebApp - BackEnd

## Description
This repository demonstrates backend development using different technologies, by following the setup you will be able to containerize the application and run it with Docker Compose.

## Table of Contents
- [Technologies-Showcased](#technologies-showcased)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Cleaning-Up](#cleaning-up)

  
## Technologies Showcased

- **Docker** - Containerization
- **Jakarta EE** - Enterprise Java
- **Payara** - Application Server
- **PostgreSQL** - Database
- **REST API** - Web Services  


## Prerequisites
- **Git**
- **Docker**
- **Linux OS**

## Installation
**STEP 1 - Git clone the repository**

~~~sh
git clone https://github.com/daniloues/ParkingWebApp.git
cd ParkingWebApp
~~~

**STEP 2 - Build the application docker image using the Dockerfile in the 'app' folder**
Navigate to the app folder and build the Docker image:
~~~sh
cd app
docker build -t parkingapp2025 .
~~~

**STEP 3 - Run the application and preconfigured database using Docker Compose**
Make sure ports 5432, 9090, and 4848 are free before starting.
~~~sh
cd ../db
sudo docker compose up
~~~
Note: On some systems, you might not need sudo.

## Usage

## Cleaning-Up

## Last Updated
This README was last updated on Feb 11 2025.
