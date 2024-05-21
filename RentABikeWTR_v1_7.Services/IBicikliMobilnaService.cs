using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IBicikliMobilnaService
    {
        public List<Model.Bicikli> Get(BicikliSearchRequest search);
        public Model.Bicikli GetById(int id);
        public List<Model.Bicikli> Recommend(int biciklid);

    }
}
