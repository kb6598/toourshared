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
            myDB = new MyDB();
            myDB.GetCon();
        }

        /*public DataTable GetDBTable(string sql)
        {
            MySqlConnection con = myDB.GetCon();
            MySqlDataAdapter adapter = new MySqlDataAdapter(sql, con);
            MySqlCommandBuilder builder = new MySqlCommandBuilder(adapter);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            return dt;
        }*/

        private void button1_Click(object sender, EventArgs e)
        {
            ReportDao reportdao = new ReportDao();
            Report report = new Report();
            Report inputReport = new Report();

            DataSet ds = reportdao.SelectReport();
            dataGridView1.DataSource = ds.Tables[0];
            //rep_no, trv_no, rep_timestap, rep_mem_id, rep_reason
            dataGridView1.Columns[0].HeaderCell.Value = "신고 번호";
            dataGridView1.Columns[1].HeaderCell.Value = "게시글 번호";
            dataGridView1.Columns[2].HeaderCell.Value = "신고 일시";
            dataGridView1.Columns[3].HeaderCell.Value = "신고인";
            dataGridView1.Columns[4].HeaderCell.Value = "신고 사유";

            //inputReport.Rep_no = "1";
            //report = reportdao.selectReportByrep_no(inputReport);

            //Console.WriteLine(report.Rep_no);

        }
    }
}
