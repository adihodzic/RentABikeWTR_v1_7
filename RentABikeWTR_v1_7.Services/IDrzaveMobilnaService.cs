using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface IDrzaveMobilnaService
    {
        public List<Model.Drzave> Get(DrzaveSearchRequest search);
        public Model.Drzave GetById(int id);

    }
}
