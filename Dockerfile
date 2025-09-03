FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY .. /src/

RUN #code just got copied into /src, app needs to get started up - get app running and listening.  so dotnet command that starts the app

EXPOSE 8080
