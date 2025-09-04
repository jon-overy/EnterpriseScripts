#Install Dependencies#
#FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS publish
FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update && apt-get install -y git

#Fetch code from repo#
WORKDIR /app

RUN git clone https://github.com/tysongibby/MudBlazorTemplateApp .

#Publish code#
WORKDIR "MudBlazorTemplate/MudBlazorTemplate"
RUN dotnet publish "MyDotNetApp.csproj" MudBlazorTemplate.csproj -c Release -o /app/build


FROM mcr.microsoft.com/dotnet/aspnet:8.0
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MudBlazor.dll"]

EXPOSE 8080


