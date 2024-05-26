using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface ILoginService
    {
        Task<Model.Korisnici> Authenticiraj(string username, string pass);
        //Task<Model.Kupci> AuthenticirajKupce(string username, string pass);
        //Model.TuristickiVodici AuthenticirajTuristickeVodice(string username, string pass);

    }
}
