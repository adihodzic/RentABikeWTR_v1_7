#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Use the official .NET SDK (for building the app)
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy the solution and project files
COPY ["RentABikeWTR.Subscriber/RentABikeWTR.Subscriber.csproj", "RentABikeWTR.Subscriber/"]
RUN dotnet restore "RentABikeWTR.Subscriber/RentABikeWTR.Subscriber.csproj"

# Copy the remaining source code and build the application
COPY . .
WORKDIR "/src/RentABikeWTR.Subscriber"
RUN dotnet publish -c Release -o /app/publish

# Use the official .NET runtime (for running the app)
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Set the entry point for the console app
ENTRYPOINT ["dotnet", "RentABikeWTR.Subscriber.dll"]