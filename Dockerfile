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
EXPOSE 8080
EXPOSE 8081

# This stage is used to build the service project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY --from=codebase /code .  
RUN ls -la /src
COPY ["MudBlazorTemplate/MudBlazorTemplate/MudBlazorTemplate.csproj", "MudBlazorTemplate/MudBlazorTemplate/"]
COPY ["MudBlazorTemplate/MudBlazorTemplate.Client/MudBlazorTemplate.Client.csproj", "MudBlazorTemplate/MudBlazorTemplate.Client/"]
RUN dotnet restore "./MudBlazorTemplate/MudBlazorTemplate/MudBlazorTemplate.csproj"
COPY . .
WORKDIR "/src/MudBlazorTemplate/MudBlazorTemplate"
RUN dotnet build "./MudBlazorTemplate.csproj" -c $BUILD_CONFIGURATION -o /app/build

# This stage is used to publish the service project to be copied to the final stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./MudBlazorTemplate.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
