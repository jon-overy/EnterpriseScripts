FROM ubuntu:22.04

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY .. /src/
RUN npm install
EXPOSE 8080
