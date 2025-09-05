FROM mcr.microsoft.com/dotnet/sdk:8.0 AS codebase
#Fetch code from repo#
RUN apt-get update && apt-get install -y git
WORKDIR /code
RUN git clone https://github.com/tysongibby/MudBlazorTemplateApp .
RUN ls -la /code

# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
COPY --from=codebase /code .  
EXPOSE 8080
EXPOSE 8081
