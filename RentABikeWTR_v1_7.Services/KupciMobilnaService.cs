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
    public class KupciMobilnaService : IKupciMobilnaService
    {
        private readonly IMapper _mapper;
        private readonly RentABikeWTR_v1_7Context _context;

        public KupciMobilnaService(IMapper mapper, RentABikeWTR_v1_7Context context)
        {
            _mapper = mapper;
            _context = context;
        }

        public List<Model.Kupci> Get(KupciSearchRequest search)
        {
                        
            if (!string.IsNullOrWhiteSpace(search.Grad))
            {
                var lis = _context.Set<Database.Bicikli>()
                    .Where(a => a.NazivBicikla.StartsWith(search.Grad))
                    .ToList();
                return _mapper.Map<List<Model.Kupci>>(lis);
            }
            else
            {
                var lis = _context.Kupci.ToList();
                return _mapper.Map<List<Model.Kupci>>(lis);
            }
        }
        public Model.Kupci GetById(int? id)
        {
            
            var entity = _context.Kupci.Where(x => x.KupacId == id).FirstOrDefault();
                       

            return _mapper.Map<Model.Kupci>(entity);
            
        }
        public Model.Kupci Update(int? id, KupciUpdateRequest? request)
        {

            var entity = _context.Kupci.Where(x => x.KupacId == id).FirstOrDefault();
            _context.Kupci.Attach(entity);
            _context.Kupci.Update(entity);

            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Kupci>(entity);

        }
    }
}
