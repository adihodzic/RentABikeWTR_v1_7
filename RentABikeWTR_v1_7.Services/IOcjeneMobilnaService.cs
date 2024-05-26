using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IOcjeneMobilnaService
    {
        public List<Model.Ocjene> Get(OcjeneSearchRequest? search);
        public Model.Ocjene GetById(int id);
        public Model.Ocjene Insert(OcjeneUpsertRequest request);

    }
}
