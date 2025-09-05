FROM mcr.microsoft.com/dotnet/sdk:8.0 AS codebase
#Fetch code from repo#
RUN apt-get update && apt-get install -y git
WORKDIR /code
RUN git clone https://github.com/tysongibby/MudBlazorTemplateApp .
RUN ls -la /code
