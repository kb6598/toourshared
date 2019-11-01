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

        //조회 버튼
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

        //여기는 제재.
        private void button2_Click(object sender, EventArgs e)
        {
            //server=itbuddy.iptime.org;user=yuhan;database=toourshared;password=yuhan1234;port=8233;"
            using (MySqlConnection myconn = new MySqlConnection(@"server=itbuddy.iptime.org;user=yuhan;database=toourshared;password=yuhan1234;port=8233;"))
            {
                myconn.Open();
                int selectCell = dataGridView1.GetCellCount(DataGridViewElementStates.Selected);

                MySqlCommand update = new MySqlCommand();
                update.Connection = myconn;
                update.CommandText = "update travel set trv_secret = 3 where trv_no = selectCell";
                update.ExecuteNonQuery();

                myconn.Close();
            }            
        }

        //여기는 해제.
        private void button3_Click(object sender, EventArgs e)
        {
            using (MySqlConnection myconn = new MySqlConnection(@"server=itbuddy.iptime.org;user=yuhan;database=toourshared;password=yuhan1234;port=8233;"))
            {
                myconn.Open();
                int selectCell = dataGridView1.GetCellCount(DataGridViewElementStates.Selected);

                MySqlCommand update = new MySqlCommand();
                update.Connection = myconn;
                update.CommandText = "update travel set trv_secret = 0 where trv_no = selectCell";
                update.ExecuteNonQuery();

                myconn.Close();
            }
        }
    }
}
