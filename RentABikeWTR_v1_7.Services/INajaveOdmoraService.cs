using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface INajaveOdmoraService
    {


        List<Model.NajaveOdmora> Get(NajaveOdmoraSearchRequest? request);
        List<Model.NajaveOdmoraPregled> GetNajavePregled(DateTime? DatumOd, DateTime? DatumDo);
        Model.NajaveOdmora GetById(int id);
        Model.NajaveOdmora Insert(NajaveOdmoraUpsertRequest request);
        Model.NajaveOdmora Update(int id, NajaveOdmoraUpsertRequest request);
       // Model.NajaveOdmora Patch(int id, PoslovniceUpsertRequest request);

    }
}
