using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IRezervacijeService
    {
        List<Model.Rezervacije> Get(RezervacijeSearchRequest? request);
        List<Model.Rezervacije> GetRezervacijeKupac(int id);
        Model.Rezervacije GetById(int id);
        //List<Model.Rezervacije>Get(RezervacijeDatumSearchRequest? requestDatum);
        Model.Rezervacije Insert(RezervacijeUpsertRequest request);
        Model.Rezervacije InsertMobilna(RezervacijeMobilnaUpsertRequest request);
        Model.Rezervacije Update(int id, RezervacijeUpsertRequest request);

    }
}
