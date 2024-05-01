FROM mcr.microsoft.com/dotnet/aspnet:7.0-bullseye-slim-amd64 AS base

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish docker-error-prj.csproj -c Release -o /app/publish -r linux-amd64

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "docker-error-prj.dll"]
