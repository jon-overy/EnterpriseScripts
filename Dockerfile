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

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app

COPY --from=build /app/release/ /app/
#COPY /app/release/ /app/

# Debug: prove the runtime stage received files
RUN ls -la /app

ENTRYPOINT ["dotnet", "MudBlazor.dll"]

EXPOSE 8080


