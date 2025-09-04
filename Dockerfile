#Install Dependencies#
#FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

RUN apt-get update && apt-get install -y git

#Fetch code from repo#
WORKDIR /app

RUN git clone https://github.com/tysongibby/MudBlazorTemplateApp .

#Publish code#
WORKDIR "/app/MudBlazorTemplate/MudBlazorTemplate"
RUN dotnet publish MudBlazorTemplate.csproj -c Release -o /app/release

#FROM mcr.microsoft.com/dotnet/aspnet:8.0
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
COPY --from=build /app/release ./

RUN echo "Files in /app/release:" && ls -l /app/release

WORKDIR /app/release

ENTRYPOINT ["dotnet", "MudBlazorTemplate.dll"]

EXPOSE 8080


