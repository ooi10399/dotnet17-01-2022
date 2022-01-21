using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicModelsLibrary
{
    class Doctor:User

    {
        public string Experience { get; set; }
        public string Speciality { get; set; }

        public Doctor()
        {
            Type = "Doctor";
        }
    }
}
