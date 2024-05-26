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
    public class PoziviDezurnomVoziluService : BaseCRUDService<Model.PoziviDezurnomVozilu, PoziviDezurnomVoziluSearchRequest, PoziviDezurnomVoziluUpsertRequest, PoziviDezurnomVoziluUpsertRequest, Database.PoziviDezurnomVozilu>
    {
        public PoziviDezurnomVoziluService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override List<Model.PoziviDezurnomVozilu> Get(PoziviDezurnomVoziluSearchRequest request)
        {




            var query = _context.PoziviDezurnomVozilu.AsQueryable();
            query = _context.PoziviDezurnomVozilu.Where(x => x.DatumPoziva.Date == request.DatumPoziva.Date);
            var lista = query.ToList();

            return _mapper.Map<List<Model.PoziviDezurnomVozilu>>(lista);
        }
        //public override Model.PoziviDezurnomVozilu Insert(PoziviDezurnomVoziluUpsertRequest request) { 
        //    var entity = _mapper.Map<Database.PoziviDezurnomVozilu>(request);

        //    _context.PoziviDezurnomVozilu.Add(entity);
        //    _context.SaveChanges();


        //    return _mapper.Map<Model.PoziviDezurnomVozilu>(entity);

        //}

    }
}
