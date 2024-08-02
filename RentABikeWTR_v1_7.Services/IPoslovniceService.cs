using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IPoslovniceService
    {


        List<Model.Poslovnice> Get(PoslovniceSearchRequest? request);
        Model.Poslovnice GetById(int id);
        Model.Poslovnice Insert(PoslovniceUpsertRequest request);
        Model.Poslovnice Update(int id, PoslovniceUpsertRequest request);
        Model.Poslovnice Patch(int id, PoslovniceUpsertRequest request);

    }
}
