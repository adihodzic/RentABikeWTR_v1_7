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
    public class DrzaveMobilnaService : IDrzaveMobilnaService
    {
        private readonly IMapper _mapper;
        private readonly RentABikeWTR_v1_7Context _context;

        public DrzaveMobilnaService(IMapper mapper, RentABikeWTR_v1_7Context context)
        {
            _mapper = mapper;
            _context = context;
        }

        public List<Model.Drzave> Get(DrzaveSearchRequest search)
        {


            if (!string.IsNullOrWhiteSpace(search.Naziv))
            {
                var lis = _context.Set<Database.Drzave>()
                    .Where(a => a.NazivDrzave.StartsWith(search.Naziv))
                    .ToList();
                return _mapper.Map<List<Model.Drzave>>(lis);
            }
            else
            {
                var lis = _context.Drzave.ToList();
                return _mapper.Map<List<Model.Drzave>>(lis);
            }
        }
        public Model.Drzave GetById(int id)
        {
            var entity = _context.Set<Database.Drzave>().Find(id);
            return _mapper.Map<Model.Drzave>(entity);
            
        }
    }
}
