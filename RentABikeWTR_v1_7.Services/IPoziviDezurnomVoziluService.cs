using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IPoziviDezurnomVoziluService
    {
        List<Model.PoziviDezurnomVozilu> Get(PoziviDezurnomVoziluSearchRequest request);
        Model.PoziviDezurnomVozilu GetById(int id);
        Model.PoziviDezurnomVozilu Insert(PoziviDezurnomVoziluUpsertRequest request);
        Model.PoziviDezurnomVozilu Update(int id, PoziviDezurnomVoziluUpsertRequest request);
        //Model.PoziviDezurnomVozilu Patch(int id, TuristickiVodiciUpsertRequest request);
        List<Model.PoziviDezurnomVoziluPregled> GetPoziviPregled(DateTime DatumOd, DateTime DatumDo);
    }
}
