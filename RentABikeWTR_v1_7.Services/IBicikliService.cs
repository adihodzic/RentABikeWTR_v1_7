using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IBicikliService
    {
        List<Model.Bicikli> Get(BicikliSearchRequest request);
        Model.Bicikli GetById(int id);
        Model.Bicikli Insert(BicikliUpsertRequest request);
        Model.Bicikli Update(int id, BicikliUpsertRequest request);
        Model.Bicikli Patch(int id, BicikliUpsertRequest request);


    }
}
