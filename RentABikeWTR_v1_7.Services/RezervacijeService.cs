using Azure.Core;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using RentABikeWTR_v1_7.Model;
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

        public List<Model.RezervacijePregled> Get(RezervacijeSearchRequest? request)
        {


            var ListaModel = new List<Model.RezervacijePregled>();
            var query = _context.Rezervacije
                .Include(a => a.Bicikl)
                .Include(b => b.Kupac)
                .Include(c => c.Korisnik)
                .AsQueryable();
            if (request.BiciklID != null)
            {
                query = _context.Rezervacije
                     .Include(a => a.Bicikl)
                .Include(b => b.Kupac)
                .Include(c => c.Korisnik)
                    .Where(x => x.BiciklID == request.BiciklID);
                var lista = query.ToList();
                foreach (var item in lista)
                {

                    ListaModel.Add(new Model.RezervacijePregled
                    {
                        RezervacijaId = item.RezervacijaId,
                        BiciklID = request.BiciklID,
                        KupacID = item.KupacID,
                        DatumIzdavanja = item.DatumIzdavanja,
                        NazivBicikla = item.Bicikl.NazivBicikla,
                        KorisnickoIme = _context.Korisnici.Where(k => k.KorisnikId == item.KupacID)
                        .Select(k => k.KorisnickoIme).FirstOrDefault(),
                        Ime = _context.Korisnici.Where(k => k.KorisnikId == item.KupacID)
                        .Select(k => k.Ime).FirstOrDefault(),
                        Prezime = _context.Korisnici.Where(k => k.KorisnikId == item.KupacID)
                        .Select(k => k.Prezime).FirstOrDefault(),
                    });

                }

                return ListaModel;
            }
            else
            {
                query = _context.Rezervacije
                .Include(a => a.Bicikl)
                .Include(b => b.Kupac)
                .Include(c => c.Korisnik)
                .AsQueryable();

                query = _context.Rezervacije
                     .Include(a => a.Bicikl)
                .Include(b => b.Kupac)
                .Include(c => c.Korisnik);

                var lista2 = query.ToList();
                foreach (var item in lista2)
                {
                    ListaModel.Add(new Model.RezervacijePregled
                    {
                        RezervacijaId = item.RezervacijaId,
                        BiciklID = request.BiciklID,
                        KupacID = item.KupacID,
                        DatumIzdavanja = item.DatumIzdavanja,
                        NazivBicikla = item.Bicikl.NazivBicikla,
                        KorisnickoIme = _context.Korisnici.Where(k => k.KorisnikId == item.KupacID)
                        .Select(k => k.KorisnickoIme).FirstOrDefault(),
                        Ime = _context.Korisnici.Where(k => k.KorisnikId == item.KupacID)
                        .Select(k => k.Ime).FirstOrDefault(),
                        Prezime = _context.Korisnici.Where(k => k.KorisnikId == item.KupacID)
                        .Select(k => k.Prezime).FirstOrDefault(),
                    });

                }

                return ListaModel;
            }
        }

        //var query = _context.Rezervacije.Where(x => x.BiciklID == request.BiciklID);
        public List<Model.Rezervacije> GetRezervacijeKupac(int id)
        {

            //var ide = int.Parse(id);
            //var query = _context.Rezervacije.AsQueryable();
            var query = _context.Rezervacije.Where(x => x.KupacID == id);
            var lista = query.ToList();
            return _mapper.Map<List<Model.Rezervacije>>(lista);


        }




        public List<Model.BicikliDostupni> GetRezervacijeDostupni(RezervacijeDostupniSearchRequest request)
        {
            DateTime? Datum = null;
            var ListaModel = new List<Model.BicikliDostupni>();
            var query = _context.Rezervacije
                .Include(a => a.Bicikl)
                .Include(b => b.Bicikl.VelicinaBicikla)
                .Include(c => c.Bicikl.TipBicikla)
                .Include(d => d.Bicikl.ModelBicikla)
                .Include(e => e.Bicikl.ProizvodjacBicikla)
                .Include(f => f.Bicikl.Poslovnica)
                .Where(g => g.DatumIzdavanja.Date == request.DatumIzdavanja);

            var ListaZauzeti = query.Select(r => r.BiciklID).ToList();  //samo ID-evi zauzetih
            var svi = _context.Bicikli
                .Include(b => b.VelicinaBicikla)
                .Include(c => c.TipBicikla)
                .Include(d => d.ModelBicikla)
                .Include(e => e.ProizvodjacBicikla)
                .Include(f => f.Poslovnica)
                .Include(g => g.Drzava)
                .ToList();

            foreach (var item in svi)
            {
                if (!ListaZauzeti.Contains(item.BiciklId))
                {
                    ListaModel.Add(new Model.BicikliDostupni
                    {
                        BiciklID = item.BiciklId,
                        NazivBicikla = item.NazivBicikla,
                        CijenaBicikla = item.CijenaBicikla,
                        NazivModela = item.ModelBicikla.NazivModela,
                        NazivTipa = item.TipBicikla.NazivTipa,
                        NazivProizvodjaca = item.ProizvodjacBicikla.NazivProizvodjaca,
                        NazivPoslovnice = item.Poslovnica.NazivPoslovnice,
                        NazivDrzave = item.Drzava.NazivDrzave,
                        Boja = item.Boja,
                        Slika = item.Slika,
                        DrzavaID = item.DrzavaID,
                        ModelBiciklaID = item.ModelBiciklaID,
                        PoslovnicaID = item.PoslovnicaID,
                        ProizvodjacBiciklaID = item.ProizvodjacBiciklaID,
                        TipBiciklaID = item.TipBiciklaID
                    });
                }

            }
            return ListaModel;



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

        

    }
}
