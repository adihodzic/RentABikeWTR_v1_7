using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class LoginService : ILoginService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;
        public LoginService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        //-----------------------------------------------------------------------------------
        public async Task<Model.Korisnici> Authenticiraj(string username, string pass)
        {
            //var user = await _context.Korisnici.Include("KorisniciUloge.Uloga").FirstOrDefaultAsync(x=>x.KorisnickoIme==username);
            var user = await _context.Korisnici.FirstOrDefaultAsync(x => x.KorisnickoIme == username);

            if (user != null)
            {
                var newHash = GenerateHash(user.LozinkaSalt, pass);

                if (newHash == user.LozinkaHash)
                {
                    return _mapper.Map<Model.Korisnici>(user);
                }
            }
            return null;
        }

        //public async Task<Model.Kupci> AuthenticirajKupce(string username, string pass)  // ovo je postavljeno kao i kod Masle provjeriti Model.Korisnici
        //{
        //    var user =await _context.Kupci.FirstOrDefaultAsync(x => x.KorisnickoIme == username); //samo sam morao naci metodu sa Async FirstOrDefaultAsync umjesto klasične FirstOrDefault()

        //    if (user != null)
        //    {
        //        var newHash = GenerateHash(user.LozinkaSalt, pass);

        //        if (newHash == user.LozinkaHash)
        //        {
        //            return _mapper.Map<Model.Kupci>(user);  //i ovdje sam promijenio u model.korisnici
        //        }
        //    }
        //    return null;
        //}


        //-----------------------------------------------------------------------------------
        public static string GenerateSalt()
        {
            var buf = new byte[16];
            (new RNGCryptoServiceProvider()).GetBytes(buf);
            return Convert.ToBase64String(buf);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        //Model.Korisnici ILoginService.Authenticiraj(string username, string pass)
        //{
        //    throw new NotImplementedException();
        //}

        //Model.Korisnici ILoginService.AuthenticirajKupca(string username, string pass)
        //{
        //    throw new NotImplementedException();
        //}


        //-----------------------------------------------------------------------------------
    }
}
