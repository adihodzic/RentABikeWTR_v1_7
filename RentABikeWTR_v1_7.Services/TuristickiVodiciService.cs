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
    public class TuristickiVodiciService : BaseCRUDService<Model.TuristickiVodici, TuristickiVodiciSearchRequest, TuristickiVodiciUpsertRequest, TuristickiVodiciUpsertRequest, Database.TuristickiVodici>
    {
        public TuristickiVodiciService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }





        //}

        public override List<Model.TuristickiVodici> Get(TuristickiVodiciSearchRequest request)
        {
            var query = _context.TuristickiVodici.AsQueryable();
            //if (!string.IsNullOrWhiteSpace(request?.Naziv))
            //{
            //    query = query.Where(x => x.Naziv.StartsWith(request.Naziv));
            //}

            if (!string.IsNullOrWhiteSpace(request?.Naziv))
            {
                query = query.Where(x => x.Naziv.StartsWith(request.Naziv));
            }
            var list = query.ToList();
            return _mapper.Map<List<Model.TuristickiVodici>>(list);
        }

        public override Model.TuristickiVodici GetById(int id)
        {
            var entity = _context.TuristickiVodici.Where(x => x.TuristickiVodicId == id).FirstOrDefault();
            return _mapper.Map<Model.TuristickiVodici>(entity);
        }


    }
}
