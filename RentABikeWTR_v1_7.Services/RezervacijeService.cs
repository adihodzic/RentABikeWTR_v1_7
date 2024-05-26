using MapsterMapper;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class RezervacijeService : IRezervacijeService
    {
        private readonly IMapper _mapper;
        private readonly RentABikeWTR_v1_7Context _context;

        public RezervacijeService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }

        public List<Model.Rezervacije> Get(RezervacijeSearchRequest? request)
        {


            //var query = _context.Rezervacije.AsQueryable();
            var query = _context.Rezervacije.Where(x => x.BiciklID == request.BiciklID);
            var lista = query.ToList();
            return _mapper.Map<List<Model.Rezervacije>>(lista);


        }
        public List<Model.Rezervacije> GetRezervacijeKupac(int id)
        {

            //var ide = int.Parse(id);
            //var query = _context.Rezervacije.AsQueryable();
            var query = _context.Rezervacije.Where(x => x.KupacID == id);
            var lista = query.ToList();
            return _mapper.Map<List<Model.Rezervacije>>(lista);


        }
        public Model.Rezervacije GetById(int id)
        {
            var entity = _context.Set<Database.Rezervacije>().Find(id);
            return _mapper.Map<Model.Rezervacije>(entity);
        }


        public Model.Rezervacije Insert(RezervacijeUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Rezervacije>(request);
            _context.Set<Database.Rezervacije>().Add(entity);
            _context.SaveChanges();
            //_context.SaveChanges();
            return _mapper.Map<Model.Rezervacije>(entity);
        }
        public Model.Rezervacije InsertMobilna(RezervacijeMobilnaUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Rezervacije>(request);
            _context.Set<Database.Rezervacije>().Add(entity);
            _context.SaveChanges();
            //_context.SaveChanges();
            return _mapper.Map<Model.Rezervacije>(entity);
        }
        public Model.Rezervacije Update(int id, RezervacijeUpsertRequest request)
        {
            var entity = _context.Set<Database.Rezervacije>().Find(id);
            _context.Set<Database.Rezervacije>().Attach(entity);
            _context.Rezervacije.Update(entity);
            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Rezervacije>(entity);
        }

        //public override List<Model.Rezervacije> Get(string pocetnidatum, string krajnjidatum, string nazivbicikla)
        //{
        //    var query = _context.Rezervacije.AsQueryable();
        //    //var query2 = _context.Rezervacije.ToList();
        //    if (!string.IsNullOrWhiteSpace(request?.KorisnickoImeKorisnik))
        //    {
        //        query = query.Where(x => x.Korisnik.KorisnickoIme.StartsWith(request.KorisnickoImeKorisnik));

        //    }
        //    if (!string.IsNullOrWhiteSpace(request?.NazivBicikla)) 
        //    {
        //        query=query.Where(x=>x.Bicikl.NazivBicikla.StartsWith(request.NazivBicikla));
        //    }
        //    if (!string.IsNullOrWhiteSpace(request?.KorisnickoImeKupac))
        //    {
        //        query = query.Where(x => x.Kupac.Korisnik.KorisnickoIme.StartsWith(request.KorisnickoImeKupac));
        //    }
        //    if (request.ModelBiciklaID != 0 && request.ModelBiciklaID.HasValue)
        //    {
        //        query = query.Where(x => x.Bicikl.ModelBiciklaID==request.ModelBiciklaID);
        //    }
        //    if (request.PoslovnicaID !=0 && request.PoslovnicaID.HasValue)
        //    {
        //        query = query.Where(x => x.Bicikl.PoslovnicaID == request.PoslovnicaID);
        //    }
        //    if (request.TuristRutaID != 0 && request.TuristRutaID.HasValue)
        //    {
        //        query = query.Where(x => x.TuristRutaID == request.TuristRutaID);
        //    }
        //    if (request.PocetniDatumPretrage != null && request.KrajnjiDatumPretrage != null)
        //    {
        //        var datumPretraga = DateTime.ParseExact(pocetnidatum, "ddMMyyyy", new CultureInfo("de-DE"));
        //        var datumKraj = DateTime.ParseExact(request.KrajnjiDatumPretrage, "ddMMyyyy", new CultureInfo("de-DE"));
        //        //var rep=request.PocetniDatumPretrage.ToString("dd.MM.yyyy");
        //        //request.KrajnjiDatumPretrage = FormattableString("##.##.####");
        //        //DateTime datumPretraga = DateTime.ParseExact(request.PocetniDatumPretrage,"d");
        //        //DateTime datumKraj = DateTime.Parse(request.KrajnjiDatumPretrage);
        //        query = query.Where(x => x.DatumIzdavanja >= (datumPretraga)  && (x.DatumIzdavanja <= datumKraj));
        //    }


        //    var list = query.ToList();
        //    if (list != null)
        //    {
        //        return _mapper.Map<List<Model.Rezervacije>>(list);

        //    }
        //    else 
        //    {
        //        var list2 = _context.Rezervacije.ToList();
        //        return _mapper.Map<List<Model.Rezervacije>>(list2);
        //    }
        //}

    }
}
