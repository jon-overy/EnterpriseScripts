FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY .. /src/

#Add run command: CMD, and we'd point it at the .dll
#CMD YourProject.dll

EXPOSE 8080
