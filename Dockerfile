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

WORKDIR /app

COPY --from=build /app/release/ /app/

# Debug: prove the runtime stage received files
RUN echo "RUNTIME STAGE: /app contents:" \
 && ls -la /app \
 && echo "RUNTIME STAGE: any DLLs under /app?" \
 && find /app -maxdepth 1 -type f -name "*.dll" -print

ENTRYPOINT ["dotnet", "MudBlazorTemplate.dll"]

EXPOSE 8080


