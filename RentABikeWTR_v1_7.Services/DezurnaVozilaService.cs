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
    public class DezurnaVozilaService : BaseCRUDService<Model.DezurnaVozila, DezurnaVozilaSearchRequest, DezurnaVozilaUpsertRequest, DezurnaVozilaUpsertRequest, Database.DezurnaVozila>
    {
        public DezurnaVozilaService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
