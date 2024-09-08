using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public interface ISesijaService
    {
        public Task<String> CreateCheckout(string nazivBicikla, double cijenaBicikla);
        public Task<String> xCreateCheckout(string nazivBicikla, string nazivRute, string jezikVodica, double cijenaUsluge);
    }
}
