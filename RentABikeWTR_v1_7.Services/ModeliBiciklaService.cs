using MapsterMapper;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class ModeliBiciklaService : BaseCRUDService<Model.ModeliBicikla, ModeliSearchRequest, ModeliUpsertRequest, ModeliUpsertRequest, Database.ModeliBicikla>
    {
        public ModeliBiciklaService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }
        //public override List<Model.ModeliBicikla> Get(ModeliSearchRequest request)
        //{

        //    var query = _context.ModeliBicikla

        //        .ToList();
        //    //if (request.TipBiciklaId != 0 && request.TipBiciklaId.HasValue)
        //    //{
        //    //    query = query.Where(x => x.ProizvodjaciBicikla.TipBiciklaID == request.TipBiciklaId);
        //    //}
        //    //if (request.ProizvodjacBiciklaId != 0 && request.ProizvodjacBiciklaId.HasValue)
        //    //{
        //    //    query = query.Where(x => x.ProizvodjaciBicikla.ProizvodjacBiciklaId == request.ProizvodjacBiciklaId);
        //    //}
        //    //if (request.DrzavaId != 0 && request.DrzavaId.HasValue)
        //    //{
        //    //    query = query.Where(x => x.ProizvodjaciBicikla.DrzavaID == request.DrzavaId);
        //    //}
        //    //var list = query.ToList();
        //    return _mapper.Map<List<Model.ModeliBicikla>>(query);
        //}
        public override Model.ModeliBicikla Insert(ModeliUpsertRequest request)
        {
            var entity = _mapper.Map<Database.ModeliBicikla>(request);
            //entity.ProizvodjacBiciklaID = (int)request.ProizvodjacBiciklaID;
            //entity.TipBiciklaID = (int)request.TipBiciklaID;
            //entity.TipBicikla.NazivTipa = request.NazivTipa;
            //entity.ProizvodjacBicikla.NazivProizvodjaca = request.NazivProizvodjaca;
            _context.ModeliBicikla.Add(entity);
            _context.SaveChanges();


            return _mapper.Map<Model.ModeliBicikla>(entity);

        }
    }
}
