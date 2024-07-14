using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IKorisniciService
    {
        List<Model.Korisnici> Get(KorisniciSearchRequest request);
        //Model.Korisnici GetLogin(string usn);
        //Model.Korisnici GetLogin(xModel request);
        List<Model.Korisnici> Get();
        List<Model.Korisnici> GetKupci(KorisniciSearchRequest request);
        List<Model.Korisnici> GetDetaljiKorisnici(KorisniciDetailsRequest request);
        Model.Korisnici GetProfilKorisnika(string username);
        Model.Korisnici GetById(int id);
        Model.Korisnici GetProfilKorisnikaById(int id);
        Model.Korisnici Insert(KorisniciUpsertRequest request);
        Model.Korisnici InsertKupca(KorisniciMobilnaUpsertRequest request);
        Model.Korisnici UpdateProfilKorisnika(int Id, KorisniciMobilnaProfilRequest request);
        Model.Korisnici Update(int id, KorisniciUpsertRequest request);
        Model.Korisnici Patch(int id, KorisniciUpdateRequest request);
        Task<Model.Korisnici> AuthentikacijaKorisnika(string usern, string pass);
    }
}
