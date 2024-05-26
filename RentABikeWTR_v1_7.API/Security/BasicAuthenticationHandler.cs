using Azure.Core;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using RentABikeWTR_v1_7.Services;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text.Encodings.Web;
using System.Text;

namespace RentABikeWTR_v1_7.API.Security
{
    public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        //private readonly IKupciService _kupciService;
        //private readonly ITuristickiVodiciService _turistickiVodiciService;//dodatno
        private readonly IKorisniciService _korisniciService;

        public BasicAuthenticationHandler(
            IOptionsMonitor<AuthenticationSchemeOptions> options,
            ILoggerFactory logger,
            UrlEncoder encoder,
            ISystemClock clock,
            //IKupciService KupciService,
            //ITuristickiVodiciService TuristickiVodiciService, //dodatno
            IKorisniciService KorisniciService)//dodatno
            : base(options, logger, encoder, clock)
        {
            //_kupciService = KupciService;
            //_turistickiVodiciService = TuristickiVodiciService;//dodatno
            _korisniciService = KorisniciService;//dodatno
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            if (!Request.Headers.ContainsKey("Authorization"))
                return AuthenticateResult.Fail("Missing Authorization Header");

            //Model.Kupci kupson = null;
            //Model.TuristickiVodici vodson = null; //dodatno
            Model.Korisnici korison = null; //dodatno
            //bool _kor = false;
            try
            {
                var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
                var credentialBytes = Convert.FromBase64String(authHeader.Parameter);
                var credentials = Encoding.UTF8.GetString(credentialBytes).Split(':');
                var username = credentials[0];
                var password = credentials[1];


                //kupson = await _kupciService.AuthentikacijaKupca(username, password);


                //if (kupson == null)//dodatno citav blok
                //{
                //    vodson = await _turistickiVodiciService.AuthentikacijaVodica(username, password);


                //    if (vodson == null)
                //{
                korison = await _korisniciService.AuthentikacijaKorisnika(username, password);

                // }
                //}//dodatno kraj bloka
            }
            catch
            {
                return AuthenticateResult.Fail("Invalid Authorization Header");
            }

            //if (kupson == null && vodson == null && korison == null) //izmijenjeno
            //    return AuthenticateResult.Fail("Invalid Username or Password");

            var claims = new List<Claim>();//dodano

            //if (kupson != null)
            //{
            //    claims = new List<Claim> {
            //        new Claim(ClaimTypes.NameIdentifier, kupson.KorisnickoIme),
            //        new Claim(ClaimTypes.Name, kupson.Ime)
            //        //new Claim(ClaimTypes.Email, kupson.Email)
            //    };
            //}
            //if (vodson != null)
            //{
            //    claims = new List<Claim> {
            //        new Claim(ClaimTypes.NameIdentifier, vodson.KorisnickoIme),
            //        new Claim(ClaimTypes.Name, vodson.Naziv)
            //        //new Claim(ClaimTypes.Email, vodson.Email)
            //    };
            //}
            if (korison != null)
            {
                claims = new List<Claim> {
                    new Claim(ClaimTypes.NameIdentifier, korison.KorisnickoIme),
                    new Claim(ClaimTypes.Name, korison.Ime)
                    //new Claim(ClaimTypes.Email, korison.Email)
                };
            }

            //foreach (var role in user)
            //{
            //    claims.Add(new Claim(ClaimTypes.Role, role.Uloga.Naziv));
            //}

            var identity = new ClaimsIdentity(claims, Scheme.Name);
            var principal = new ClaimsPrincipal(identity);
            var ticket = new AuthenticationTicket(principal, Scheme.Name);

            return AuthenticateResult.Success(ticket);
        }
    }
}
