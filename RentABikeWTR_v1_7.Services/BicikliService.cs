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
    
        public class BicikliService : IBicikliService
        {
            private readonly RentABikeWTR_v1_7Context _context;
            private readonly IMapper _mapper;

            public BicikliService(RentABikeWTR_v1_7Context context, IMapper mapper)
            {
                _context = context;
                _mapper = mapper;
            }
        //public List<Model.BicikliPregled> GetBicikliPregled(BicikliSearchRequest search)
        //{


        //    if (!string.IsNullOrWhiteSpace(search.NazivBicikla))
        //    {
        //        var lis = _context.Bicikli // 
        //                                   //.Include(b => b.TipBicikla)
        //                                   //.Include(c=>c.ModelBicikla)

        //            .Where(a => a.NazivBicikla.StartsWith(search.NazivBicikla)).AsQueryable().ToList()
        //            .Select(b => new
        //            {
        //                BiciklID = b.BiciklId,
        //                NazivBicikla = b.NazivBicikla,
        //                Slika = b.Slika,
        //                NazivTipa = b.TipBicikla.NazivTipa,
        //                NazivModela = b.ModelBicikla.NazivModela
        //            });



        //        return _mapper.Map<List<Model.BicikliPregled>>(lis);
        //        //return lis;
        //    }
        //    else
        //    {
        //        //var lis = _context.Bicikli
        //        //    .Include(t => t.ModelBicikla)
        //        //    .Include(r => r.TipBicikla)
        //        //    .AsQueryable()
        //        //    .ToList();
        //        var lis = _context.Bicikli
        //.Select(b => new
        //{
        //    BiciklID = b.BiciklId,
        //    NazivBicikla = b.NazivBicikla,
        //    Slika = b.Slika,
        //    NazivTipa = b.TipBicikla.NazivTipa,
        //    NazivModela = b.ModelBicikla.NazivModela
        //});


        //        return _mapper.Map<List<Model.BicikliPregled>>(lis);
        //    }
        //}
        public List<Model.Bicikli> Get(BicikliSearchRequest request)
        {


            var query = _context.Bicikli.AsQueryable();
                //b=>new { 
                //BiciklId=b.BiciklId,
                //NazivBicikla=b.NazivBicikla,
                //    Boja=b.Boja,
                //    Slika=b.Slika,
                //    VrstaRama =b.VrstaRama,
                //    NazivDrzave=b.Drzava.NazivDrzave,
                //    NazivProizvodjaca=b.ProizvodjacBicikla.NazivProizvodjaca,
                //    CijenaBicikla=b.CijenaBicikla,
                //    DatumOptisa=b.DatumOtpisa,
                //    GodinaProizvodnje=b.GodinaProizvodnje,
                //    NazivModela=b.ModelBicikla.NazivModela, 
                //    NazivPoslovnice=b.Poslovnica.NazivPoslovnice,
                //    NazivVelicine=b.VelicinaBicikla.NazivVelicine
                
                //}); // promijenio sam kod
            if (!string.IsNullOrWhiteSpace(request?.NazivBicikla))
            {
                query = query.Where(x => x.NazivBicikla.StartsWith(request.NazivBicikla));
                var lis = query.ToList();
                return _mapper.Map<List<Model.Bicikli>>(lis);
            }
            else {
                var lista = query.ToList();
                return _mapper.Map<List<Model.Bicikli>>(lista);
            }

        }
        public Model.Bicikli GetById(int id)
        {
            var entity = _context.Set<Bicikli>().Find(id);
            
            //var entity = _context.Bicikli
            //    .Where(a=>a.BiciklId==id)
            //    .Select(
            //    b => new {
            //        BiciklId = b.BiciklId,
            //        NazivBicikla = b.NazivBicikla,
            //        Boja = b.Boja,
            //        Slika = b.Slika,
            //        VrstaRama = b.VrstaRama,
            //        NazivDrzave = b.Drzava.NazivDrzave,
            //        NazivProizvodjaca = b.ProizvodjacBicikla.NazivProizvodjaca,
            //        CijenaBicikla = b.CijenaBicikla,
            //       // DatumOptisa = b.DatumOtpisa,
            //        GodinaProizvodnje = b.GodinaProizvodnje,
            //        NazivModela = b.ModelBicikla.NazivModela,
            //        NazivPoslovnice = b.Poslovnica.NazivPoslovnice,
            //        NazivVelicine = b.VelicinaBicikla.NazivVelicine,
            //        NabavnaCijena=b.NabavnaCijena

            //    });
            
            return _mapper.Map<Model.Bicikli>(entity);
            //return _mapper.Map<Model.BicikliSearchRequest>(entity);
            //return entity;
        }
        public Model.Bicikli Insert(BicikliUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Bicikli>(request);
            _context.Set<Database.Bicikli>().Add(entity);
            _context.SaveChanges();
            //_context.SaveChanges();
            return _mapper.Map<Model.Bicikli>(entity);
        }
        public Model.Bicikli Update(int id, BicikliUpsertRequest request)
        {
            var entity = _context.Set<Database.Bicikli>().Find(id);
            _context.Set<Database.Bicikli>().Attach(entity);
            _context.Bicikli.Update(entity);
            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Bicikli>(entity);
        }
        public Model.Bicikli Patch(int id, BicikliUpsertRequest request)
        {
            var entity = _context.Bicikli.Where(x => x.BiciklId == id).FirstOrDefault();
            _context.Bicikli.Attach(entity);
            //_context.Korisnici.Patch(entity);
            //entity.TuristickiVodicId = id;
            entity.NazivBicikla = request.NazivBicikla ?? entity.NazivBicikla;
            entity.VrstaRama = request.VrstaRama ?? entity.VrstaRama;
            entity.ModelBiciklaID = request.ModelBiciklaID;
            entity.TipBiciklaID = request.TipBiciklaID;
            entity.Boja = request.Boja;
            entity.ProizvodjacBiciklaID = request.ProizvodjacBiciklaID;
            entity.CijenaBicikla = (decimal)request.CijenaBicikla;
            entity.PoslovnicaID = request.PoslovnicaID;
            entity.DrzavaID= request.DrzavaID;
            entity.StatusID = request.StatusID ?? entity.StatusID;
            entity.VelicinaBiciklaID = request.VelicinaBiciklaID ?? entity.VelicinaBiciklaID;
            entity.Slika = request.Slika ?? entity.Slika;
            
            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Bicikli>(entity);
        }

    }
}
