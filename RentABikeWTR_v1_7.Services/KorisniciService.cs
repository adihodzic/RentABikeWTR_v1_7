using MapsterMapper;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class KorisniciService : IKorisniciService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public KorisniciService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Korisnici> AuthentikacijaKorisnika(string usn, string pass)
        {
            var user = _context.Korisnici.Where(x => x.KorisnickoIme == usn).FirstOrDefault();
            //Mora ici samo jedan korisnik ...ne bi drugacije radilo
            //svaki bi put izbacivao greske kada ne bi nasao korisnika.Ako ih trazim vise.


            if (user != null)
            {
                var newHash = GenerateHash(user.LozinkaSalt, pass);
                if (newHash != user.LozinkaHash)
                {
                    throw new Exception("Passwordi se ne slazu");
                }
                return _mapper.Map<Model.Korisnici>(user);
            }
            else
            {
                throw new Exception("Stvarno niste autentificirani - authentikacija korisnika");
            }

        }

        public static string GenerateHash(string lozinkaSalt, string pass)
        {
            byte[] src = Convert.FromBase64String(lozinkaSalt);
            byte[] bytes = Encoding.Unicode.GetBytes(pass);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(src, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public List<Model.Korisnici> Get()
        {
            var query = _context.Korisnici.ToList();
            var list = query.ToList();
            return _mapper.Map<List<Model.Korisnici>>(list);
        }
        public List<Model.Korisnici> Get(KorisniciSearchRequest request)
        {
            //var query = _context.Korisnici.Include("KorisniciUloge.Uloga").AsQueryable();
            var query = _context.Korisnici.AsQueryable();
            //if (!string.IsNullOrWhiteSpace(request?.Ime))
            //{
            //    query = query.Where(x => x.Ime.StartsWith(request.Ime));

            //}
            //if (!string.IsNullOrWhiteSpace(request?.Prezime))
            //{
            //    query = query.Where(x => x.Prezime.StartsWith(request.Prezime));
            //}
            if (!string.IsNullOrWhiteSpace(request?.KorisnickoIme))
            {
                query = query.Where(x => x.KorisnickoIme.StartsWith(request.KorisnickoIme));
            }
            var list = query.ToList();
            return _mapper.Map<List<Model.Korisnici>>(list);
        }
        public List<Model.Korisnici> GetKorisnici(KorisniciSearchRequest? request)
        {
            //var query = _context.Korisnici.Include("KorisniciUloge.Uloga").AsQueryable();
            var query = _context.Korisnici.AsQueryable();
            //if (!string.IsNullOrWhiteSpace(request?.Ime))
            //{
            //    query = query.Where(x => x.Ime.StartsWith(request.Ime));

            //}
            //if (!string.IsNullOrWhiteSpace(request?.Prezime))
            //{
            //    query = query.Where(x => x.Prezime.StartsWith(request.Prezime));
            //}
            if (!string.IsNullOrWhiteSpace(request?.KorisnickoIme))
            {
                query = query.Where(x => x.KorisnickoIme.StartsWith(request.KorisnickoIme));
            }
            var list = query.ToList();
            return _mapper.Map<List<Model.Korisnici>>(list);
        }
        public List<Model.Korisnici> GetDetaljiKorisnici(KorisniciDetailsRequest request)
        {
            //var query = _context.Korisnici.Include("KorisniciUloge.Uloga").AsQueryable();
            var query = _context.Korisnici.AsQueryable();
            //if(!string.IsNullOrWhiteSpace(request?.Ime))
            //{
            //    query = query.Where(x => x.Ime.StartsWith(request.Ime));

            //}
            //if (!string.IsNullOrWhiteSpace(request?.Prezime))
            //{
            //    query = query.Where(x => x.Prezime.StartsWith(request.Prezime));
            //}
            if (!string.IsNullOrWhiteSpace(request?.KorisnickoIme))
            {
                query = query.Where(x => x.KorisnickoIme.StartsWith(request.KorisnickoIme));
            }
            var list = query.ToList();
            return _mapper.Map<List<Model.Korisnici>>(list);
        }
        public List<Model.Korisnici> GetKupci(KorisniciSearchRequest request)
        {
            var query = _context.Korisnici.AsQueryable();
            if (!string.IsNullOrWhiteSpace(request?.Ime))
            {
                query = query.Where(x => x.Ime.StartsWith(request.Ime));

            }
            if (!string.IsNullOrWhiteSpace(request?.Prezime))
            {
                query = query.Where(x => x.Prezime.StartsWith(request.Prezime));
            }

            if (!string.IsNullOrWhiteSpace(request?.KorisnickoIme))
            {
                query = query.Where(x => x.KorisnickoIme.StartsWith(request.KorisnickoIme));


            }
            var list = query.Where(x=>x.UlogaID==4).ToList();
            return _mapper.Map<List<Model.Korisnici>>(list);


            //else
            //{
            //    query = query.Where(x => x.UlogaID == 4);
            //    var li = query.ToList();
            //    return _mapper.Map<List<Model.Korisnici>>(li);
            //}

        }
        public Model.Korisnici GetProfilKorisnika(string username)
        {
            //var entity = _context.Korisnici.AsQueryable();

            var query = _context.Korisnici.Where(x => x.KorisnickoIme.Equals(username));
            var entity = query.FirstOrDefault(); // morao sam uraditi jer mi mapper javlja grešku ako koristim samo entity kao kod getById
            return _mapper.Map<Model.Korisnici>(entity);

        }
        
        public Model.Korisnici GetById(int id)
        {
            //var entity = _context.Korisnici.Include("KorisniciUloge").Where(x => x.KorisnikId == id).FirstOrDefault();
            var entity = _context.Korisnici.Where(x => x.KorisnikId == id).FirstOrDefault();
            return _mapper.Map<Model.Korisnici>(entity);
        }
        public Model.Korisnici GetProfilKorisnikaById(int id)
        {
            //var entity = _context.Korisnici.Include("KorisniciUloge").Where(x => x.KorisnikId == id).FirstOrDefault();
            var entity = _context.Korisnici.Where(x => x.KorisnikId == id).FirstOrDefault();
            return _mapper.Map<Model.Korisnici>(entity);
        }


        public Model.Korisnici Insert(KorisniciUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Korisnici>(request);
            if (!string.IsNullOrWhiteSpace(request?.Password))
            {
                if (request.Password != request.PasswordPotvrda)
                {
                    throw new Exception("Passwordi se ne slazu!");
                }
                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Password);
            }
            _context.Korisnici.Add(entity);
            _context.SaveChanges();
            //foreach (var uloga in request.Uloge)
            //{
            //    Database.KorisniciUloge korisniciUloge = new Database.KorisniciUloge
            //    { 
            //        DatumIzmjene=DateTime.Now,
            //        UlogaId=uloga,
            //        KorisnikId=entity.KorisnikId
            //    };
            //    _context.KorisniciUloge.Add(korisniciUloge);
            //}
            //_context.SaveChanges();
            return _mapper.Map<Model.Korisnici>(entity);
        }
        public Model.Korisnici InsertKupca(KorisniciMobilnaUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Korisnici>(request);
            if (!string.IsNullOrWhiteSpace(request?.Password))
            {
                if (request.Password != request.PasswordPotvrda)
                {
                    throw new Exception("Passwordi se ne slazu!");
                }
                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Password);
            }
            _context.Korisnici.Add(entity);
            _context.SaveChanges();

            return _mapper.Map<Model.Korisnici>(entity);
        }

        public static string GenerateSalt()
        {
            var buf = new byte[16];
            (new RNGCryptoServiceProvider()).GetBytes(buf);
            return Convert.ToBase64String(buf);
        }

        public Model.Korisnici Update(int id, KorisniciUpsertRequest request)
        {
            var entity = _context.Korisnici.Where(x => x.KorisnikId == id).FirstOrDefault();
            _context.Korisnici.Attach(entity);
            _context.Korisnici.Update(entity);
            if (!string.IsNullOrWhiteSpace(request?.Password))
            {
                if (request.Password != request.PasswordPotvrda)
                {
                    throw new Exception("Ne slazu se passwordi");
                }
                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Password);
            }
            _context.SaveChanges();
            //var korisnickeUloge = _context.Uloge.Where(x => x.KorisnikId == id).ToList();
            //foreach (var item in korisnickeUloge)
            //{
            //    _context.KorisniciUloge.Remove(item);
            //}
            //_context.SaveChanges();
            //foreach (var uloga in request.Uloge)
            //{
            //    Database.Uloge uloge = new Database.Uloge
            //    { 
            //        DatumIzmjene=DateTime.Now,
            //        UlogaId=uloga,
            //        KorisnikId=entity.KorisnikId
            //    };
            //    _context.Uloge.Add(uloga);
            //}
            //_context.SaveChanges();
            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Korisnici>(entity);
        }

        public Model.Korisnici UpdateProfilKorisnika(int id, KorisniciMobilnaProfilRequest request)
        {
            var entity = _context.Korisnici.Where(x => x.KorisnikId == id).FirstOrDefault();
            _context.Korisnici.Attach(entity);
            _context.Korisnici.Update(entity);
            if (!string.IsNullOrWhiteSpace(request?.Password))
            {
                if (request.Password != request.PasswordPotvrda)
                {
                    throw new Exception("Ne slazu se passwordi");
                }
                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Password);
            }
            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Korisnici>(entity);
        }
        public Model.Korisnici Patch(int id, KorisniciUpdateRequest request)
        {
            var entity = _context.Korisnici.Where(x => x.KorisnikId == id).FirstOrDefault();
            _context.Korisnici.Attach(entity);
            //_context.Korisnici.Patch(entity);
            entity.KorisnikId = id;
            entity.Ime = request.Ime ?? entity.Ime;
            entity.Prezime = request.Prezime ?? entity.Prezime;
            entity.KorisnickoIme = request.KorisnickoIme ?? entity.KorisnickoIme;
            entity.Email = request.Email ?? entity.Email;
            entity.Aktivan=request.Aktivan.Value;
            entity.DrzavaID= request.DrzavaID ?? entity.DrzavaID;
            entity.Telefon = request.Telefon ?? entity.Telefon;
            entity.DatumRegistracije = request.DatumRegistracije ?? entity.DatumRegistracije;
            entity.UlogaID = request.UlogaID ?? entity.UlogaID;

            //if (!string.IsNullOrWhiteSpace(request?.Password))
            //{
            //    if (request.Password != request.PasswordPotvrda)
            //    {
            //        throw new Exception("Ne slazu se passwordi");
            //    }
            //    entity.LozinkaSalt = GenerateSalt();
            //    entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Password);
            //}
            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Korisnici>(entity);
        }
    


        
    }
}
