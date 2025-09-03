#FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS build
#WORKDIR /src
#COPY .. /src/

WORKDIR /src
COPY .. /src/publish/

#Add run command: CMD, and we'd point it at the .dll
#CMD YourProject.dll

EXPOSE 8080
