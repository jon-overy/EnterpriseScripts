
#Fetch code from repo
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

RUN git clone https://github.com/tysongibby/MudBlazorTemplateApp .

#Publish code
WORKDIR "MudBlazorTemplate/MudBlazorTemplate"
RUN dotnet publish "MyDotNetApp.csproj" MudBlazorTemplate.csproj -c Release

EXPOSE 8080
ENTRYPOINT ["dotnet", "MudBlazor.dll"]


