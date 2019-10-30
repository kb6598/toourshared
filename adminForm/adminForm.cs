using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using tooushared.Lib;

namespace adminForm
{
    public partial class adminForm : Form
    {
        MyDB myDB = new MyDB();

        public adminForm()
        {
            InitializeComponent();
            InitializeComponent();
            myDB = new MyDB();
            myDB.GetCon();
        }

        public DataTable GetDBTable(string sql)
        {
            MySqlConnection con = myDB.GetCon();
            MySqlDataAdapter adapter = new MySqlDataAdapter(sql, con);
            MySqlCommandBuilder builder = new MySqlCommandBuilder(adapter);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            return dt;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sql = "SELECT rep_no, trv_no, rep_reason, rep_timestap, rep_mem_id";
            DataTable dt = GetDBTable(sql);
            myDB.CloseCon();
        }
    }
}
