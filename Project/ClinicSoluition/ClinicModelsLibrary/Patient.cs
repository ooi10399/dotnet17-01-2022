using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicModelsLibrary
{
    public class Patient : User
    {
        public string Remarks { get; set; }
        public string Status { get; set; }


        public Patient()
        {
            Type = "Patients";
            Remarks = "Sensitive to Prawn";
            Status = "Future";
        }

        public override string ToString()
        {
            return base.ToString() + "\nType: " + Type + "\nRemarks: " + Remarks + "\nStatus: " + Status;
        }
    }
}
