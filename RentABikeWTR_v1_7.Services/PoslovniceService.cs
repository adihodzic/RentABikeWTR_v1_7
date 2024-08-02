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
    public class PoslovniceService : IPoslovniceService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public PoslovniceService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public List<Model.Poslovnice> Get(PoslovniceSearchRequest? request)
        {
            var query = _context.Poslovnice.AsQueryable();
            //if (!string.IsNullOrWhiteSpace(request?.Naziv))
            //{
            //    query = query.Where(x => x.Naziv.StartsWith(request.Naziv));
            //}

            if (!string.IsNullOrWhiteSpace(request?.NazivPoslovnice))
            {
                query = query.Where(x => x.NazivPoslovnice.StartsWith(request.NazivPoslovnice));
            }
            var list = query.ToList();
            return _mapper.Map<List<Model.Poslovnice>>(list);
        }
        public Model.Poslovnice GetById(int id)
        {
            var entity = _context.Poslovnice.Where(x => x.PoslovnicaId == id).FirstOrDefault();
            return _mapper.Map<Model.Poslovnice>(entity);
        }

        public Model.Poslovnice Update(int id, PoslovniceUpsertRequest request)
        {
            var entity = _context.Poslovnice.Where(x => x.PoslovnicaId == id).FirstOrDefault();
            _context.Poslovnice.Attach(entity);
            _context.Poslovnice.Update(entity);

            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Poslovnice>(entity);
        }
        public Model.Poslovnice Insert(PoslovniceUpsertRequest request)
        {

            var entity = _mapper.Map<Database.Poslovnice>(request);
            _context.Poslovnice.Add(entity);
            _context.SaveChanges();

            return _mapper.Map<Model.Poslovnice>(entity);
        }
        public Model.Poslovnice Patch(int id, PoslovniceUpsertRequest request)
        {
            var entity = _context.Poslovnice.Where(x => x.PoslovnicaId == id).FirstOrDefault();
            _context.Poslovnice.Attach(entity);
            
            entity.NazivPoslovnice = request.NazivPoslovnice ?? entity.NazivPoslovnice;
            entity.EmailKontakt = request.EmailKontakt ?? entity.EmailKontakt;
            entity.Adresa = request.Adresa?? entity.Adresa;
            entity.BrojTelefona = request.BrojTelefona?? entity.BrojTelefona;

            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Poslovnice>(entity);
        }
    }
}
