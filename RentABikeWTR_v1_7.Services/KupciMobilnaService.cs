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
    public class KupciMobilnaService : IKupciMobilnaService
    {
        private readonly IMapper _mapper;
        private readonly RentABikeWTR_v1_7Context _context;

        public KupciMobilnaService(IMapper mapper, RentABikeWTR_v1_7Context context)
        {
            _mapper = mapper;
            _context = context;
        }

        public List<Model.Kupci> Get(KupciSearchRequest search)
        {


            //var query = _context.Set<Database.TipoviBicikla>().AsQueryable();
            //if (!string.IsNullOrWhiteSpace(search.NazivTipa))
            //{
            //    var li = _context.Set<Database.Bicikli>()
            //    .Where(a => a.TipBicikla.NazivTipa.StartsWith(search.NazivTipa))
            //    .ToList();

            //    return _mapper.Map<List<Model.Bicikli>>(li);
            //}
            if (!string.IsNullOrWhiteSpace(search.Grad))
            {
                var lis = _context.Set<Database.Bicikli>()
                    .Where(a => a.NazivBicikla.StartsWith(search.Grad))
                    .ToList();
                return _mapper.Map<List<Model.Kupci>>(lis);
            }
            else
            {
                var lis = _context.Kupci.ToList();
                return _mapper.Map<List<Model.Kupci>>(lis);
            }
        }
        public Model.Kupci GetById(int? id)
        {
            //var entity = _context.Set<Database.Kupci>().Find(id);
            var entity = _context.Kupci.Where(x => x.KupacId == id).FirstOrDefault();// ovo sam iskopirao sa korisnika..da bi radilo na flutter-u

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

            return _mapper.Map<Model.Kupci>(entity);
            //return _mapper.Map<Model.BicikliSearchRequest>(entity);
            //return entity;
        }
        public Model.Kupci Update(int? id, KupciUpdateRequest? request)
        {

            var entity = _context.Kupci.Where(x => x.KupacId == id).FirstOrDefault();
            _context.Kupci.Attach(entity);
            _context.Kupci.Update(entity);

            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Kupci>(entity);

        }
    }
}
