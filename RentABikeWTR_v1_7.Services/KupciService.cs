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
    public class KupciService : BaseCRUDService<Model.Kupci, KupciSearchRequest, KupciUpsertRequest, KupciUpsertRequest, Database.Kupci>
    {
        public KupciService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public List<Model.Kupci> GetByIds(List<int> ids)
        {
            var query = _context.Kupci.AsQueryable();
            foreach (var itemid in ids)
            {
                query = query.Where(x => x.KupacId == itemid);
            }
            var lista = query.ToList();
            return _mapper.Map<List<Model.Kupci>>(lista);

        }




    }
}
