using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IPorukeService
    {
        List<Model.Poruke> Get(PorukeSearchRequest? request);
        
        //Model.NajaveOdmora GetById(int id);
        Model.Poruke Insert(PorukeUpsertRequest request);
        //Model.NajaveOdmora Update(int id, NajaveOdmoraUpsertRequest request);
        // Model.NajaveOdmora Patch(int id, PoslovniceUpsertRequest request);
    }
}
