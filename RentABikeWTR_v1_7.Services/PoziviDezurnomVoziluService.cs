using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using RentABikeWTR_v1_7.Model;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using Stripe;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class PoziviDezurnomVoziluService : IPoziviDezurnomVoziluService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public PoziviDezurnomVoziluService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public List<Model.PoziviDezurnomVozilu> Get(PoziviDezurnomVoziluSearchRequest request)
        {
            var query = _context.PoziviDezurnomVozilu.AsQueryable();
            query = _context.PoziviDezurnomVozilu
                .Where(x => x.DatumPoziva.Date >= request.DatumOd.Date && x.DatumPoziva.Date <= request.DatumDo);
            var lista = query.ToList();

            return _mapper.Map<List<Model.PoziviDezurnomVozilu>>(lista);
        }
        public List<Model.PoziviDezurnomVoziluPregled> GetPoziviPregled(DateTime DatumOd, DateTime DatumDo)
        {
            try
            {

           
            var query = _context.PoziviDezurnomVozilu.AsQueryable() //ako bude trazena forma detalji ukljucicu ID-eve za vanjske tabele.
                .Where(x => x.DatumPoziva >= DatumOd.Date && x.DatumPoziva <= DatumDo)
                .Select(p => new
                {
                    PozivDezurnomVoziluId = p.PozivDezurnomVoziluId,
                    ViseDetalja = p.ViseDetalja,
                    Nesreca = p.Nesreca,
                    ZahtjevKlijenta = p.ZahtjevKlijenta,
                    Kvar = p.Kvar,
                    LosiVremenskiUslovi = p.LosiVremenskiUslovi,
                    DatumPoziva = p.DatumPoziva,
                    VrijemePoziva = p.VrijemePoziva,

                    NazivDezurnogVozila = p.DezurnoVozilo.NazivDezurnogVozila,
                    Naziv = p.TuristickiVodic.Naziv,
                    NazivPoslovnice = p.Poslovnica.NazivPoslovnice

                }).ToList();

            return _mapper.Map<List<Model.PoziviDezurnomVoziluPregled>>(query);
            }
            catch (Exception ex)
            {

                Console.WriteLine(ex.ToString());
                throw;
            }


        }
        public Model.PoziviDezurnomVozilu GetById(int id)
        {
            var entity = _context.PoziviDezurnomVozilu.Where(x => x.PozivDezurnomVoziluId == id).FirstOrDefault();
            return _mapper.Map<Model.PoziviDezurnomVozilu>(entity);
        }
        public Model.PoziviDezurnomVozilu Update(int id, PoziviDezurnomVoziluUpsertRequest request)
        {
            var entity = _context.PoziviDezurnomVozilu.Where(x => x.PozivDezurnomVoziluId == id).FirstOrDefault();
            _context.PoziviDezurnomVozilu.Attach(entity);
            _context.PoziviDezurnomVozilu.Update(entity);

            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.PoziviDezurnomVozilu>(entity);
        }

        public Model.PoziviDezurnomVozilu Insert(PoziviDezurnomVoziluUpsertRequest request)
        {
            var entity = _mapper.Map<Database.PoziviDezurnomVozilu>(request);

            _context.PoziviDezurnomVozilu.Add(entity);
            _context.SaveChanges();


            return _mapper.Map<Model.PoziviDezurnomVozilu>(entity);

        }

    }
}
