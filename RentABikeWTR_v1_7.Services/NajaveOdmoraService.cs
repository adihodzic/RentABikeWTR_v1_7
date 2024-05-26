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
    public class NajaveOdmoraService : BaseCRUDService<Model.NajaveOdmora, NajaveOdmoraSearchRequest, NajaveOdmoraUpsertRequest, NajaveOdmoraUpsertRequest, Database.NajaveOdmora>
    {
        public NajaveOdmoraService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override List<Model.NajaveOdmora> Get(NajaveOdmoraSearchRequest request)
        {
            var query = _context.NajaveOdmora.AsQueryable();
            query = _context.NajaveOdmora.Where(x => x.DatumOdmora.Date == request.DatumOdmora.Date);
            var lista = query.ToList();

            return _mapper.Map<List<Model.NajaveOdmora>>(lista);
        }
        public override Model.NajaveOdmora Insert(NajaveOdmoraUpsertRequest request)
        {
            var entity = _mapper.Map<Database.NajaveOdmora>(request);
            //entity.ProizvodjacBiciklaID = (int)request.ProizvodjacBiciklaID;
            //entity.TipBiciklaID = (int)request.TipBiciklaID;
            //entity.TipBicikla.NazivTipa = request.NazivTipa;
            //entity.ProizvodjacBicikla.NazivProizvodjaca = request.NazivProizvodjaca;
            _context.NajaveOdmora.Add(entity);
            _context.SaveChanges();


            return _mapper.Map<Model.NajaveOdmora>(entity);

        }
    }
}
