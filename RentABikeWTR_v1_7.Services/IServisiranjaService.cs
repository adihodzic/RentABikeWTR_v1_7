using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IServisiranjaService
    {


        List<Model.Servisiranja> Get(int? biciklid);
        Model.Servisiranja GetById(int id);
        Model.Servisiranja Insert(ServisiranjaUpsertRequest request);
        Model.Servisiranja Update(int id, ServisiranjaUpsertRequest request);
        //Model.PoziviDezurnomVozilu Patch(int id, ServisiranjaUpsertRequest request);
        List<Model.ServisiranjaPregled> GetServisiranjaPregled(int? id);
        Model.Servisiranja Patch(int id, ServisiranjaUpsertRequest request);

    }
}
