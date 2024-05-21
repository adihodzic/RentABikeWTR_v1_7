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
    public class BicikliService : BaseCRUDService<Model.Bicikli, BicikliSearchRequest, BicikliUpsertRequest, BicikliUpsertRequest, Database.Bicikli>
    {
        public BicikliService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override List<Model.Bicikli> Get(BicikliSearchRequest request)
        {

            //var proba = _context.ServisnaKnjiga.Include(x=>x.
            //var tipBicikla = _context.Bicikli.Include("ModelBicikla.ProizvodjaciBicikla.TipoviBicikla")
            //    .Select(x => x.ModeliBicikla.ProizvodjaciBicikla.TipBiciklaID).FirstOrDefault();

            //var tipB = _context.Set<Database.TipoviBicikla>().Include(q => q.ProizvodjaciBicikla)
            //.ThenInclude(r => r.ModeliBicikla)
            //.ThenInclude(s => s.Bicikli)
            //.FirstOrDefault();
            //var query = _context.Bicikli.Where(x => x.ModelBiciklaID == request.ModelBiciklaID).ToList();
            var query = _context.Bicikli.AsQueryable(); // promijenio sam kod
            if (!string.IsNullOrWhiteSpace(request?.NazivBicikla))
            {
                query = query.Where(x => x.NazivBicikla.StartsWith(request.NazivBicikla));
            }

            var lista = query.ToList();
            return _mapper.Map<List<Model.Bicikli>>(lista);

            //}
            //else //ovo radim zbog testiranja flutter-a
            //{
            //    var lista = _context.Bicikli.ToList();
            //    return _mapper.Map<List<Model.Bicikli>>(lista); 
            //}


            //.Where(cc => cc.ModeliBicikla.ProizvodjaciBicikla.TipBiciklaID == request.TipBiciklaID);
            //if (!string.IsNullOrWhiteSpace(request?.NazivBicikla))
            //{
            //    query = query.Where(xx => xx.NazivBicikla.StartsWith(request.NazivBicikla))
            //        .Where(cc => cc.ModeliBicikla.ProizvodjaciBicikla.TipBiciklaID == request.TipBiciklaID);

            //}
            //else 
            //{
            //    query = query.Where(x => x.ModeliBicikla.ProizvodjaciBicikla.TipBiciklaID==request.TipBiciklaID);

            //}
            //var list = query.ToList();  - ovo sam zakomentarisao zbog flutter-a
            //return _mapper.Map<List<Model.Bicikli>>(list); -- ovo sam zakomentarisao zbog flutter-a
        }
        public override Model.Bicikli GetById(int id)
        {
            var entity = _context.Set<Database.Bicikli>().Find(id);
            //var entity=_context.Set<Database.Bicikli>().Include(x=>x.ModelBicikla.NazivModela).Include(y=>y.VelicinaBicikla.NazivVelicine)
            //    .Include(z=>z.Poslovnica.NazivPoslovnice).Include(st=>st.Status.NazivStatusa).Include(d=>d.Drzava.NazivDrzave).Where(b=>b.BiciklId==id).FirstOrDefault();
            //var entity = _context.Set<Database.Bicikli>().Include(x => x.ModelBicikla)
            //    .Include(y => y.VelicinaBicikla)
            //    .Include(z => z.Poslovnica)
            //    .Include(st => st.Status)
            //    .Include(d => d.Drzava)
            //    .Where(b => b.BiciklId == id)
            //    .Select(a=>a.ModelBicikla.NazivModela)
            //    .FirstOrDefault();

            return _mapper.Map<Model.Bicikli>(entity);
            //return _mapper.Map<Model.BicikliSearchRequest>(entity);
            //return entity;
        }
        public override Model.Bicikli Insert(BicikliUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Bicikli>(request);
            _context.Set<Database.Bicikli>().Add(entity);
            _context.SaveChanges();
            //_context.SaveChanges();
            return _mapper.Map<Model.Bicikli>(entity);
        }
        public override Model.Bicikli Update(int id, BicikliUpsertRequest request)
        {
            var entity = _context.Set<Database.Bicikli>().Find(id);
            _context.Set<Database.Bicikli>().Attach(entity);
            _context.Bicikli.Update(entity);
            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Bicikli>(entity);
        }

    }
}
