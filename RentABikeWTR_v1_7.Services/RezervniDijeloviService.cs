using MapsterMapper;
using Microsoft.Identity.Client;
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
    public class RezervniDijeloviService : IRezervniDijeloviService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public RezervniDijeloviService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public List<Model.RezervniDijelovi> Get(RezervniDijeloviSearchRequest request)
        {
            var query = _context.RezervniDijelovi.AsQueryable();
            if (!string.IsNullOrWhiteSpace(request?.NazivRezervnogDijela))
            {
                query = query.Where(x => x.NazivRezervnogDijela.StartsWith(request.NazivRezervnogDijela));
            }


            var list = query.ToList();
            return _mapper.Map<List<Model.RezervniDijelovi>>(list);
        }
        public Model.RezervniDijelovi GetById(int id)
        {
            var entity = _context.RezervniDijelovi.Where(x => x.RezervniDijeloviId == id).FirstOrDefault();
            return _mapper.Map<Model.RezervniDijelovi>(entity);
        }
        public Model.RezervniDijelovi Update(int id, RezervniDijeloviUpsertRequest request)
        {
            var entity = _context.RezervniDijelovi.Where(x => x.RezervniDijeloviId == id).FirstOrDefault();
            _context.RezervniDijelovi.Attach(entity);
            _context.RezervniDijelovi.Update(entity);

            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.RezervniDijelovi>(entity);
        }

        public Model.RezervniDijelovi Insert(RezervniDijeloviUpsertRequest request)
        {
            var entity = _mapper.Map<Database.RezervniDijelovi>(request);

            _context.RezervniDijelovi.Add(entity);
            _context.SaveChanges();


            return _mapper.Map<Model.RezervniDijelovi>(entity);

        }


        

        public List<RezervniDijeloviPregled> GetDijeloviPregled()
        {
            {


                var query = _context.RezervniDijelovi.AsQueryable() //ako bude trazena forma detalji ukljucicu ID-eve za vanjske tabele.
                   
                    .Select(p => new
                    {
                        RezervniDijeloviId = p.RezervniDijeloviId,
                        NazivRezervnogDijela = p.NazivRezervnogDijela,
                        SifraArtikla = p.SifraArtikla,
                        NaStanju = p.NaStanju,
                        NazivKategorije = p.KategorijaDijelova.NazivKategorije,
                        
                    }).ToList();

                return _mapper.Map<List<Model.RezervniDijeloviPregled>>(query);
            }
           
        }
        public Model.RezervniDijelovi Patch(int id, RezervniDijeloviUpsertRequest request)
        {
            var entity = _context.RezervniDijelovi.Where(x => x.RezervniDijeloviId == id).FirstOrDefault();
            _context.RezervniDijelovi.Attach(entity);
            //_context.Korisnici.Patch(entity);
            entity.RezervniDijeloviId = id;
            entity.NaStanju = (int)request.NaStanju;
            
            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.RezervniDijelovi>(entity);
        }
    }
}
