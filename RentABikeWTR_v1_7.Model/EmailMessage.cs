using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model
{
    public class EmailMessage //ovo je kao ViewModel za mail
    {
       
        public EmailAddress ToAddresses { get; set; }
        public EmailAddress FromAddresses { get; set; }
        public string Subject { get; set; }
        public string Content { get; set; }
    }
}
