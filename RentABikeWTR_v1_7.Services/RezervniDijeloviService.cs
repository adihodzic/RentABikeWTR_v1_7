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
    public class RezervniDijeloviService : BaseCRUDService<Model.RezervniDijelovi, RezervniDijeloviSearchRequest, RezervniDijeloviUpsertRequest, RezervniDijeloviUpsertRequest, Database.RezervniDijelovi>
    {
        public RezervniDijeloviService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override List<Model.RezervniDijelovi> Get(RezervniDijeloviSearchRequest request)
        {
            var query = _context.RezervniDijelovi.AsQueryable();
            if (!string.IsNullOrWhiteSpace(request?.NazivRezervnogDijela))
            {
                query = query.Where(x => x.NazivRezervnogDijela.StartsWith(request.NazivRezervnogDijela));
            }


            var list = query.ToList();
            return _mapper.Map<List<Model.RezervniDijelovi>>(list);
        }
        public override Model.RezervniDijelovi Insert(RezervniDijeloviUpsertRequest request)
        {
            var entity = _mapper.Map<Database.RezervniDijelovi>(request);
            _context.RezervniDijelovi.Add(entity);
            _context.SaveChanges();
            return _mapper.Map<Model.RezervniDijelovi>(entity);
        }
    }
}
