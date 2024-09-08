using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model
{
    public class EmailModel
    {
        public string Sender { get; set; }
        public string Recipient { get; set; }
        public string Subject { get; set; }
        public string Content { get; set; }
    }

}
