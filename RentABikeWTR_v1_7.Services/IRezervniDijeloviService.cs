using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IRezervniDijeloviService
    {
    
        List<Model.RezervniDijelovi> Get(RezervniDijeloviSearchRequest request);
        Model.RezervniDijelovi GetById(int id);
        Model.RezervniDijelovi Insert(RezervniDijeloviUpsertRequest request);
        Model.RezervniDijelovi Update(int id, RezervniDijeloviUpsertRequest request);
        //Model.PoziviDezurnomVozilu Patch(int id, TuristickiVodiciUpsertRequest request);
        List<Model.RezervniDijeloviPregled> GetDijeloviPregled();
        Model.RezervniDijelovi Patch(int id, RezervniDijeloviUpsertRequest request);
    }
}
