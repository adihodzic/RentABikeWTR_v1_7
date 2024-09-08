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
    public class OcjeneMobilnaService : IOcjeneMobilnaService
    {
        private readonly IMapper _mapper;
        private readonly RentABikeWTR_v1_7Context _context;

        public OcjeneMobilnaService(IMapper mapper, RentABikeWTR_v1_7Context context)
        {
            _mapper = mapper;
            _context = context;
        }

        public List<Model.Ocjene> Get(OcjeneSearchRequest? search)
        {


            var query = _context.Ocjene.AsQueryable();
            var lista = query.ToList();
            return _mapper.Map<List<Model.Ocjene>>(lista);

        }
        public Model.Ocjene GetById(int id)
        {
            var entity = _context.Set<Database.Ocjene>().Find(id);
            return _mapper.Map<Model.Ocjene>(entity);
            //return _mapper.Map<Model.BicikliSearchRequest>(entity);
            //return entity;
        }
        public Model.Ocjene Insert(OcjeneUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Ocjene>(request);
            _context.Set<Database.Ocjene>().Add(entity);
            _context.SaveChanges();
            //_context.SaveChanges();
            return _mapper.Map<Model.Ocjene>(entity);

        }
    }
}
