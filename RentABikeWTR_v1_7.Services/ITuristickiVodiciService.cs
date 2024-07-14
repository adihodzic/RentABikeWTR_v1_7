using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface ITuristickiVodiciService
    {
        List<Model.TuristickiVodici> Get(TuristickiVodiciSearchRequest request);
        Model.TuristickiVodici GetById(int id);
        Model.TuristickiVodici Insert(TuristickiVodiciUpsertRequest request);
        Model.TuristickiVodici Update(int id, TuristickiVodiciUpsertRequest request);
        Model.TuristickiVodici Patch(int id, TuristickiVodiciUpsertRequest request);


    }
}
