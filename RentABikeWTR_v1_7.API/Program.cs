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
//using Stripe;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
//builder.Services.AddAuthentication("BasicAuthentication")
//               .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);
//services.AddControllers().AddNewtonsoftJson(options=>options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);
var connectionString = builder.Configuration.GetConnectionString("konekcija");
builder.Services.AddDbContext<RentABikeWTR_v1_7Context>(o => o.UseSqlServer(connectionString));
////builder.Services.AddAutoMapper(typeof(RentABikeWTR_v1_6.WebAPI.Mappers.Mapper));

////services.AddScoped<ICRUDService<Model.Drzave, DrzaveSearchRequest, DrzaveUpsertRequest, DrzaveUpsertRequest>, BaseCRUDService<Model.Drzave, object, Database.Drzave, DrzaveUpsertRequest, DrzaveUpsertRequest>>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.Drzave, DrzaveSearchRequest, DrzaveUpsertRequest, DrzaveUpsertRequest>, DrzaveService>();
////VAZNO Morao sam dodati Ime aplikacije ispred Model.Drzave da ne bi javljao gresku
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.Bicikli, BicikliSearchRequest, BicikliUpsertRequest, BicikliUpsertRequest>, BicikliService>();
////services.AddScoped<BicikliService,IBicikliService<Model.Bicikli, BicikliSearchRequest, BicikliUpsertRequest, BicikliUpsertRequest>, BicikliService>();

//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.DezurnaVozila, DezurnaVozilaSearchRequest, DezurnaVozilaUpsertRequest, DezurnaVozilaUpsertRequest>, DezurnaVozilaService>();
////services.AddScoped<IModeliBiciklaService, ModeliBiciklaService>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.ModeliBicikla, ModeliSearchRequest, ModeliUpsertRequest, ModeliUpsertRequest>, ModeliBiciklaService>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.NajavaOdmora, NajavaOdmoraSearchRequest, NajavaOdmoraUpsertRequest, NajavaOdmoraUpsertRequest>, NajavaOdmoraService>();
////services.AddScoped<ICRUDService<Model.Proizvodjaci, object, ProizvodjaciUpsertRequest, ProizvodjaciUpsertRequest>, BaseCRUDService<Model.Proizvodjaci, object, Database.Proizvodjaci, ProizvodjaciUpsertRequest, ProizvodjaciUpsertRequest>>();
////services.AddScoped<ICRUDService<Model.Ocjene, object, OcjeneUpsertRequest, OcjeneUpsertRequest>, BaseCRUDService<Model.Ocjene, object, Database.Ocjene, OcjeneUpsertRequest, OcjeneUpsertRequest>>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.Poslovnice, PoslovniceSearchRequest, PoslovniceUpsertRequest, PoslovniceUpsertRequest>, PoslovniceService>();
//builder.Services.AddTransient<IService<RentABikeWTR_v1_6.Model.KategorijeDijelova, object>, BaseService<RentABikeWTR_v1_6.Model.KategorijeDijelova, object, RentABikeWTR_v1_6.WebAPI.Database.KategorijeDijelova>>();
//builder.Services.AddTransient<IService<RentABikeWTR_v1_6.Model.LokacijeOdmora, object>, BaseService<RentABikeWTR_v1_6.Model.LokacijeOdmora, object, RentABikeWTR_v1_6.WebAPI.Database.LokacijeOdmora>>();
//builder.Services.AddTransient<IService<RentABikeWTR_v1_6.Model.Uloge, object>, BaseService<RentABikeWTR_v1_6.Model.Uloge, object, RentABikeWTR_v1_6.WebAPI.Database.Uloge>>();
//builder.Services.AddTransient<IService<RentABikeWTR_v1_6.Model.TipoviBicikla, object>, BaseService<RentABikeWTR_v1_6.Model.TipoviBicikla, object, RentABikeWTR_v1_6.WebAPI.Database.TipoviBicikla>>();
//builder.Services.AddTransient<IService<RentABikeWTR_v1_6.Model.VelicineBicikla, object>, BaseService<RentABikeWTR_v1_6.Model.VelicineBicikla, object, RentABikeWTR_v1_6.WebAPI.Database.VelicineBicikla>>();
//builder.Services.AddTransient<IService<RentABikeWTR_v1_6.Model.GodineKupci, object>, BaseService<RentABikeWTR_v1_6.Model.GodineKupci, object, RentABikeWTR_v1_6.WebAPI.Database.GodineKupci>>();
//builder.Services.AddTransient<IService<RentABikeWTR_v1_6.Model.Genderi, object>, BaseService<RentABikeWTR_v1_6.Model.Genderi, object, RentABikeWTR_v1_6.WebAPI.Database.Genderi>>();
//builder.Services.AddTransient<IService<RentABikeWTR_v1_6.Model.Statusi, object>, BaseService<RentABikeWTR_v1_6.Model.Statusi, object, RentABikeWTR_v1_6.WebAPI.Database.Statusi>>();
////greska services.AddScoped<IService<Model.PoziviDezurnomVozilu, object>, BaseService<Model.KategorijeVozila, object, Database.KategorijeVozila>>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.PoziviDezurnomVozilu, PoziviDezurnomVoziluSearchRequest, PoziviDezurnomVoziluUpsertRequest, PoziviDezurnomVoziluUpsertRequest>, PoziviDezurnomVoziluService>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.ProizvodjaciBicikla, ProizvodjaciBiciklaSearchRequest, ProizvodjaciBiciklaUpsertRequest, ProizvodjaciBiciklaUpsertRequest>, ProizvodjaciBiciklaService>();
////builder.Services.AddTransient<ICRUDService< RentABikeWTR_v1_6.Model.Rezervacije, RezervacijeSearchRequest, RezervacijeUpsertRequest, RezervacijeUpsertRequest>, RezervacijeService>();
//builder.Services.AddTransient<IRezervacijeService, RezervacijeService>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.RezervniDijelovi, RezervniDijeloviSearchRequest, RezervniDijeloviUpsertRequest, RezervniDijeloviUpsertRequest>, RezervniDijeloviService>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.Servisi, ServisiSearchRequest, ServisiUpsertRequest, ServisiUpsertRequest>, ServisiService>();
//builder.Services.AddTransient<IKorisniciService, KorisniciService>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.Kupci, KupciSearchRequest, KupciUpsertRequest, KupciUpsertRequest>, KupciService>();
////Model.Statusi
////Model.TipoviBicikla
//builder.Services.AddTransient<IKupciMobilnaService, KupciMobilnaService>();
//builder.Services.AddTransient<ILoginService, LoginService>();
//builder.Services.AddTransient<IXRezervacijeService, XRezervacijeService>();
////builder.Services.AddTransient<ITuristickiVodiciService, TuristickiVodiciService>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.TuristickiVodici, TuristickiVodiciSearchRequest, TuristickiVodiciUpsertRequest, TuristickiVodiciUpsertRequest>, TuristickiVodiciService>();
//builder.Services.AddTransient<ICRUDService<RentABikeWTR_v1_6.Model.TuristRute, TuristRuteSearchRequest, TuristRuteUpsertRequest, TuristRuteUpsertRequest>, TuristRuteService>();
////services.AddScoped<IPreporukeService, PreporukeService>();
//builder.Services.AddTransient<IBicikliMobilnaService, BicikliMobilnaService>();
//builder.Services.AddTransient<IDrzaveMobilnaService, DrzaveMobilnaService>();
//builder.Services.AddTransient<IOcjeneMobilnaService, OcjeneMobilnaService>();
//builder.Services.AddTransient<ISesijaService, SesijaService>();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddMapster();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
using (var scope = app.Services.CreateScope())
{
        var dataContext = scope.ServiceProvider.GetRequiredService<RentABikeWTR_v1_7Context>();

        dataContext.Database.Migrate(); //koristicu ovo naredbu, a ne EnsureCreated();
    //    
    //    //ovo cu ja ukucati umjesto ovog koda gore zato sto sam vec uradio backup baze
    //    dataContext.Database.EnsureCreated();
 }

    app.Run();
