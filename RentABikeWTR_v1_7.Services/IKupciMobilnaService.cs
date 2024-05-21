using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IKupciMobilnaService
    {
        public List<Model.Kupci> Get(KupciSearchRequest search);
        public Model.Kupci GetById(int? id);
        public Model.Kupci Update(int? id, KupciUpdateRequest? request);

    }
}
