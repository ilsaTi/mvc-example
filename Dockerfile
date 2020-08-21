FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build
WORKDIR /app

# copy and restore .csproj
COPY mvc-example/*.csproj ./
RUN dotnet restore

# COPY the remaining files
COPY ./mvc-example ./
RUN dotnet publish -c Release -o out

# build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet","mvc-example.dll"]
