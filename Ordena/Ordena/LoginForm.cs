using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data.Odbc;
using System.Data.OleDb;
using System.Windows.Forms;

namespace Ordena
{
    public partial class LoginForm : Form
    {
        private int NumeroIntentos = 0;
        

        public LoginForm()
        {
            InitializeComponent();
        }

       
        private bool checkUsrNombre()
        {
            if (string.IsNullOrEmpty(edtUsrNombre.Text))
            {
                errorProvider.SetError(edtUsrNombre, "El Nombre del Usuario es requerido");
                return false;
            }
            errorProvider.SetError(edtUsrNombre, "");
            return true;
        }
        private string Encrypt(String clave)
        {
            if (string.IsNullOrEmpty(clave))
                return clave;

            return clave.GetHashCode().ToString();
        }
        private void btnOk_Click(object sender, EventArgs e)
        {
         

            if (!checkUsrNombre())
                return;

            
            string usrNombre = string.Empty;
            string usrClave = string.Empty;
            string usrEstado = string.Empty;
            DateTime fechaExpira = new DateTime();

            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString = @"Data Source=DESKTOP-2UDMLKN\SQLEXPRESS;Integrated Security=SSPI;Initial Catalog=Ordena";
                cn.Open();
                //
                string strSQL = "SELECT * FROM Gl_Usuario WHERE Estado='A' ";
                strSQL += "AND NombreUsuario = @UsrNombre";
                SqlCommand cmmd = new SqlCommand(strSQL, cn);
                //
                SqlParameter param = new SqlParameter();
                param.ParameterName = "@UsrNombre";
                param.SqlDbType = SqlDbType.Char;
                param.Size = 50;
                param.Value = edtUsrNombre.Text;
                cmmd.Parameters.Add(param);

                SqlDataReader dr = cmmd.ExecuteReader();
                while (dr.Read())
                {
                    usrNombre = dr["NombreUsuario"].ToString();
                    fechaExpira = DateTime.Parse(dr["FechaExpira"].ToString());
                    usrEstado = dr["Estado"].ToString();
                    usrClave = dr["Clave"].ToString();
                }
                dr.Close();

            }

            if (usrEstado == "I")
            {
                MessageBox.Show("Favor contactar a Soporte Tecnico", "Acceso Negado", MessageBoxButtons.OK);
                return;
            }


            TimeSpan diff = fechaExpira.Subtract(DateTime.Now);
            if (diff.TotalSeconds < 0d )
            {
                MessageBox.Show("Favor contactar a Soporte Tecnico", "Acceso Negado", MessageBoxButtons.OK);
                return;
            }

            //
            if (edtUsrClave.Text == usrClave && edtUsrNombre.Text == usrNombre)
            {
                DialogResult = DialogResult.OK;
            } else
            {
                NumeroIntentos++;
                if (MessageBox.Show("Nombre de Usuario/Clave incorrectos", "Acceso Negado", MessageBoxButtons.RetryCancel) == DialogResult.Cancel
                    || NumeroIntentos == 3)
                    Close();
            }
                

        }

       
    }
}
