#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 44335
ENV ASPNETCORE_URLS=http://+:44335

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY . .
#COPY ./RentABikeWTR_v1_7.API.csproj /app/
#RUN dotnet restore "./RentABikeWTR_v1_7.API.csproj"


FROM build AS publish
RUN dotnet publish "RentABikeWTR_v1_7.API/RentABikeWTR_v1_7.API.csproj" -c Release -o /app
FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "RentABikeWTR_v1_7.API.dll"]