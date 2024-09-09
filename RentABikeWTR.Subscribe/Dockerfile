#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:7.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["RentABikeWTR.Subscribe/RentABikeWTR.Subscribe.csproj", "RentABikeWTR.Subscribe/"]
RUN dotnet restore "RentABikeWTR.Subscribe/RentABikeWTR.Subscribe.csproj"
COPY . .
WORKDIR "/src/RentABikeWTR.Subscribe"
RUN dotnet build "RentABikeWTR.Subscribe.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "RentABikeWTR.Subscribe.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "RentABikeWTR.Subscribe.dll"]