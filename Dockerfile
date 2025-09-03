FROM ubuntu:22.04
RUN npm install

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY .. /src/

EXPOSE 8080
