d
#Fetch code from repo
#FROM mcr.microsoft.com/dotnet/aspnet:8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update && apt-get install -y git

WORKDIR /app

RUN git clone https://github.com/tysongibby/MudBlazorTemplateApp .

#Publish code
WORKDIR "MudBlazorTemplate/MudBlazorTemplate"
RUN dotnet publish "MyDotNetApp.csproj" MudBlazorTemplate.csproj -c Release


FROM mcr.microsoft.com/dotnet/aspnet:8.0
COPY . .
ENTRYPOINT ["dotnet", "MudBlazor.dll"]

EXPOSE 8080


