using Microsoft.AspNetCore.Authentication;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using RentABikeWTR_v1_7.API;
//using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;
using RentABikeWTR_v1_7.Services.Database;
//using RentABikeWTR_v1_7.API.Security;
using Microsoft.OpenApi.Models;
using Mapster;
using RentABikeWTR_v1_7.API.Security;
using RentABikeWTR_v1_7.Model.Requests;
using Stripe;
using RentABikeWTR_v1_7.Model;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddAuthentication("BasicAuthentication")
               .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);
//services.AddControllers().AddNewtonsoftJson(options=>options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);
//var environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
//string connectionString = "";

      var  connectionString = builder.Configuration.GetConnectionString("konekcija");
      builder.Services.AddDbContext<RentABikeWTR_v1_7Context>(o => o.UseSqlServer(connectionString));

//builder.Services.Configure<EmailSettings>(builder.Configuration.GetSection("EmailSettings"));




////builder.Services.AddAutoMapper(typeof(RentABikeWTR_v1_6.WebAPI.Mappers.Mapper));
////services.AddScoped<ICRUDService<Model.Drzave, DrzaveSearchRequest, DrzaveUpsertRequest, DrzaveUpsertRequest>, BaseCRUDService<Model.Drzave, object, Database.Drzave, DrzaveUpsertRequest, DrzaveUpsertRequest>>();
builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_7.Model.Drzave, DrzaveSearchRequest, DrzaveUpsertRequest, DrzaveUpsertRequest>, DrzaveService>();
////VAZNO Morao sam dodati Ime aplikacije ispred Model.Drzave da ne bi javljao gresku

////services.AddScoped<BicikliService,IBicikliService<Model.Bicikli, BicikliSearchRequest, BicikliUpsertRequest, BicikliUpsertRequest>, BicikliService>();
builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_7.Model.DezurnaVozila, DezurnaVozilaSearchRequest, DezurnaVozilaUpsertRequest, DezurnaVozilaUpsertRequest>, DezurnaVozilaService>();
////services.AddScoped<IModeliBiciklaService, ModeliBiciklaService>();
builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_7.Model.ModeliBicikla, ModeliSearchRequest, ModeliUpsertRequest, ModeliUpsertRequest>, ModeliBiciklaService>();



builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_7.Model.TipoviBicikla, TipoviBiciklaSearchRequest, TipoviBiciklaUpsertRequest, TipoviBiciklaUpsertRequest>, TipoviBiciklaService>();
////services.AddScoped<ICRUDService<Model.Proizvodjaci, object, ProizvodjaciUpsertRequest, ProizvodjaciUpsertRequest>, BaseCRUDService<Model.Proizvodjaci, object, Database.Proizvodjaci, ProizvodjaciUpsertRequest, ProizvodjaciUpsertRequest>>();
////builder.Services.AddScoped<ICRUDService<RentABikeWTR_v1_7.Model.Ocjene, object, OcjeneUpsertRequest, OcjeneUpsertRequest>, BaseCRUDService<Model.Ocjene, object, Database.Ocjene, OcjeneUpsertRequest, OcjeneUpsertRequest>>();
builder.Services.AddTransient<IService<RentABikeWTR_v1_7.Model.KategorijeDijelova, object>, BaseService<RentABikeWTR_v1_7.Model.KategorijeDijelova, object, RentABikeWTR_v1_7.Services.Database.KategorijeDijelova>>();
builder.Services.AddTransient<IService<RentABikeWTR_v1_7.Model.LokacijeOdmora, object>, BaseService<RentABikeWTR_v1_7.Model.LokacijeOdmora, object, RentABikeWTR_v1_7.Services.Database.LokacijeOdmora>>();
builder.Services.AddTransient<IService<RentABikeWTR_v1_7.Model.Uloge, object>, BaseService<RentABikeWTR_v1_7.Model.Uloge, object, RentABikeWTR_v1_7.Services.Database.Uloge>>();

builder.Services.AddTransient<IService<RentABikeWTR_v1_7.Model.VelicineBicikla, object>, BaseService<RentABikeWTR_v1_7.Model.VelicineBicikla, object, RentABikeWTR_v1_7.Services.Database.VelicineBicikla>>();
builder.Services.AddTransient<IService<RentABikeWTR_v1_7.Model.GodineKupci, object>, BaseService<RentABikeWTR_v1_7.Model.GodineKupci, object, RentABikeWTR_v1_7.Services.Database.GodineKupci>>();
builder.Services.AddTransient<IService<RentABikeWTR_v1_7.Model.Genderi, object>, BaseService<RentABikeWTR_v1_7.Model.Genderi, object, RentABikeWTR_v1_7.Services.Database.Genderi>>();
builder.Services.AddTransient<IService<RentABikeWTR_v1_7.Model.Statusi, object>, BaseService<RentABikeWTR_v1_7.Model.Statusi, object, RentABikeWTR_v1_7.Services.Database.Statusi>>();
////greska services.AddScoped<IService<Model.PoziviDezurnomVozilu, object>, BaseService<Model.KategorijeVozila, object, Database.KategorijeVozila>>();

builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_7.Model.ProizvodjaciBicikla, ProizvodjaciBiciklaSearchRequest, ProizvodjaciBiciklaUpsertRequest, ProizvodjaciBiciklaUpsertRequest>, ProizvodjaciBiciklaService>();
////builder.Services.AddTransient<ICRUDService< RentABikeWTR_v1_6.Model.Rezervacije, RezervacijeSearchRequest, RezervacijeUpsertRequest, RezervacijeUpsertRequest>, RezervacijeService>();

builder.Services.AddTransient<IRezervacijeService, RezervacijeService>();
builder.Services.AddTransient<IRezervniDijeloviService, RezervniDijeloviService>();
builder.Services.AddTransient<IServisiranjaService, ServisiranjaService>();
builder.Services.AddTransient<IPoslovniceService, PoslovniceService>();
builder.Services.AddTransient<INajaveOdmoraService, NajaveOdmoraService>();

builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_7.Model.Kupci, KupciSearchRequest, KupciUpsertRequest, KupciUpsertRequest>, KupciService>();
////Model.Statusi
////Model.TipoviBicikla
builder.Services.AddTransient<IKupciMobilnaService, KupciMobilnaService>();
builder.Services.AddTransient<ILoginService, LoginService>();
builder.Services.AddTransient<IXRezervacijeService, XRezervacijeService>();
builder.Services.AddTransient<ITuristickiVodiciService, TuristickiVodiciService>();

builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_7.Model.TuristRute, TuristRuteSearchRequest, TuristRuteUpsertRequest, TuristRuteUpsertRequest>, TuristRuteService>();
builder.Services.AddTransient<IPorukeService, PorukeService>();
//services.AddScoped<IPreporukeService, PreporukeService>();
builder.Services.AddTransient<IBicikliService, BicikliService>();
builder.Services.AddTransient<IBicikliMobilnaService, BicikliMobilnaService>();
builder.Services.AddTransient<IDrzaveMobilnaService, DrzaveMobilnaService>();
builder.Services.AddTransient<IOcjeneMobilnaService, OcjeneMobilnaService>();
builder.Services.AddTransient<ISesijaService, SesijaService>();
builder.Services.AddTransient<IPoziviDezurnomVoziluService, PoziviDezurnomVoziluService>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
    {
        c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
        {
            Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
            Scheme = "basic"
        });

        c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "basicAuth" }
            },
            new string[]{}
        }
    });
    });
builder.Services.AddMapster();

var app = builder.Build();


StripeConfiguration.ApiKey = builder.Configuration.GetSection("Stripe")["SecretKey"];
//rijeseno je i sada cita iz appsettings.json-a
// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
app.UseSwagger();
    app.UseSwaggerUI();
//}

app.UseHttpsRedirection();
app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();
using (var scope = app.Services.CreateScope())
{
        var dataContext = scope.ServiceProvider.GetRequiredService<RentABikeWTR_v1_7Context>();

        dataContext.Database.Migrate(); //koristicu ovo naredbu, a ne EnsureCreated();
    
 }

    app.Run();
