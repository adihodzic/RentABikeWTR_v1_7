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
    public class ServisiranjaService : BaseCRUDService<Model.Servisiranja, ServisiranjaSearchRequest, ServisiranjaUpsertRequest, ServisiranjaUpsertRequest, Database.Servisiranja>
    {
        public ServisiranjaService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override List<Model.Servisiranja> Get(ServisiranjaSearchRequest request)
        {
            var query = _context.Servisiranja.AsQueryable();
            if (request?.BiciklId != 0)
                query = query.Where(x => x.BiciklID == request.BiciklId);
            var list = query.ToList();
            return _mapper.Map<List<Model.Servisiranja>>(list);
        }
        public override Model.Servisiranja Insert(ServisiranjaUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Servisiranja>(request);
            _context.Servisiranja.Add(entity);
            _context.SaveChanges();
            //foreach (var itemID in request.RezervniDijeloviIDs)
            //{
            //    var rezervni = _context.RezervniDijelovi.Find(itemID);
            //    rezervni.ServisID = entity.ServisId;
            //    rezervni.NaStanju = false;
            //    //var idKD = _context.RezervniDijelovi.Where(x=>x.RezervniDijeloviId==rezervni.RezervniDijeloviId).FirstOrDefault().KategorijaDijelovaID;
            //    //rezervni.KategorijaDijelovaID = idKD;
            //    //_context.RezervniDijelovi.Attach(rezervni);
            //    _context.RezervniDijelovi.Update(rezervni);

            //}
            //_context.SaveChanges();
            return _mapper.Map<Model.Servisiranja>(entity);

        }
    }
}
