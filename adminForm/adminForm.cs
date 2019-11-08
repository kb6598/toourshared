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
using tooushared.DAO;
using tooushared.DTO;

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

        //신고글 조회 기능(함수)
        public void After_Report()
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
        }

        //계정정지 목록 조회 기능(함수)
        public void Member_BlockList()
        {
            Member_Block memberBlock = new Member_Block();
            Member_BlockDao memberBlockDao = new Member_BlockDao();

            DataSet ds = memberBlockDao.SelectMember_Block();
            dataGridView2.DataSource = ds.Tables[0];

            //mem_blo_no, mem_id, mem_blo_date, mem_blo_length
            dataGridView2.Columns[0].HeaderCell.Value = "계정정지 번호";
            dataGridView2.Columns[1].HeaderCell.Value = "아이디";
            dataGridView2.Columns[2].HeaderCell.Value = "계정정지 시작일";
            dataGridView2.Columns[3].HeaderCell.Value = "계정정지 기간";            
        }

        //신고글의 계정 목록 조회 기능(함수)
        public void Report_MemberList()
        {
            Member_BlockDao memberDao = new Member_BlockDao();
            Member member = new Member();

            DataSet ds = memberDao.Select_MemberID();
            dataGridView2.DataSource = ds.Tables[0];

            dataGridView2.Columns[0].HeaderCell.Value = "정지 번호";
            dataGridView2.Columns[1].HeaderCell.Value = "해당 계정";
            dataGridView2.Columns[2].HeaderCell.Value = "정지 일자";
            dataGridView2.Columns[3].HeaderCell.Value = "정지 기간";
        }

        //신고목록조회 버튼
        private void button1_Click(object sender, EventArgs e)
        {
            After_Report();
        }

        //신고글 제재 버튼
        private void button2_Click(object sender, EventArgs e)
        {            
            //server=itbuddy.iptime.org;user=yuhan;database=toourshared;password=yuhan1234;port=8233;"
            //using (MySqlConnection myconn = new MySqlConnection(@"server=itbuddy.iptime.org;user=yuhan;database=toourshared;password=yuhan1234;port=8233;"))
            //{
            //    try { 
            //    myconn.Open();
            //    int selectCell = dataGridView1.GetCellCount(DataGridViewElementStates.Selected);

            //    MySqlCommand update = new MySqlCommand();
            //    update.Connection = myconn;
            //    update.CommandText = "update travel set trv_secret = 3 where trv_no = @selectCell";
            //       update.Parameters.Add("@selectCell", selectCell.ToString());
            //    update.ExecuteNonQuery();

            //    }
            //    catch (Exception ex)
            //    {
            //        Console.WriteLine(ex.StackTrace.ToString());

            //    }
            //}


            Travel inputTravel = new Travel();
            Travel outputTravel = new Travel();
            Member inputMember = new Member();
            TravelDao travelDao = new TravelDao();
            Report delete = new Report();


            int selectedCellCount =dataGridView1.GetCellCount(DataGridViewElementStates.Selected);

            for (int i = 0; i < selectedCellCount; i++)
            {
                //선택한 셀들의 행을 구해오고 그행의 두번째열 trv_no의 값을 가져온다.
                inputTravel.Trv_no = dataGridView1.Rows[dataGridView1.SelectedCells[i].RowIndex].Cells[1].Value.ToString();

                outputTravel = travelDao.selectTravelBytrv_no(inputTravel);

                outputTravel.Trv_secret = "3";

                travelDao.UpdatetTravel(outputTravel);

                //선택 행의 첫번째 rep_no 가져오기
                delete.Rep_no = dataGridView1.Rows[dataGridView1.SelectedCells[i].RowIndex].Cells[0].Value.ToString();

                try
                {
                    string sql = "Delete from toourshared.report where rep_no = @rep_no";
                    MySqlConnection con = myDB.GetCon();
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@rep_no", delete.Rep_no);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                catch (Exception ex)
                {

                }                
            }
            After_Report();
        }

        //신고글 해제 버튼
        private void button3_Click(object sender, EventArgs e)
        {
            //using (MySqlConnection myconn = new MySqlConnection(@"server=itbuddy.iptime.org;user=yuhan;database=toourshared;password=yuhan1234;port=8233;"))
            //{
            //    try
            //    {
            //        myconn.Open();
            //    int selectCell = dataGridView1.GetCellCount(DataGridViewElementStates.Selected);

            //    MySqlCommand update = new MySqlCommand();
            //    update.Connection = myconn;
            //    update.CommandText = "update travel set trv_secret = 0 where trv_no = selectCell";


            //    update.ExecuteNonQuery();

            //    }
            //    catch (Exception ex)
            //    {
            //        Console.WriteLine(ex.StackTrace.ToString());

            //    }

            //}

            Travel inputTravel = new Travel();
            Travel outputTravel = new Travel();
            TravelDao travelDao = new TravelDao();
            Report delete = new Report();


            int selectedCellCount = dataGridView1.GetCellCount(DataGridViewElementStates.Selected);

            /*inputTravel.Trv_no = selectCell.ToString();
            outputTravel = travelDao.selectTravelBytrv_no(inputTravel);

            outputTravel.Trv_secret = "0";

            travelDao.UpdatetTravel(outputTravel);*/

            for (int i = 0; i < selectedCellCount; i++)
            {
                //선택한 셀들의 행을 구해오고 그행의 두번째열 trv_no의 값을 가져온다.
                inputTravel.Trv_no = dataGridView1.Rows[dataGridView1.SelectedCells[i].RowIndex].Cells[1].Value.ToString();
                outputTravel = travelDao.selectTravelBytrv_no(inputTravel);

                outputTravel.Trv_secret = "0";

                travelDao.UpdatetTravel(outputTravel);

                //선택 행의 첫번째 rep_no 가져오기
                delete.Rep_no = dataGridView1.Rows[dataGridView1.SelectedCells[i].RowIndex].Cells[0].Value.ToString();

                try
                {
                    string sql = "Delete from toourshared.report where rep_no = @rep_no";
                    MySqlConnection con = myDB.GetCon();
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@rep_no", delete.Rep_no);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                catch (Exception ex)
                {

                }
            }
            After_Report();
        }

        //계정정지 목록 조회버튼
        private void button4_Click(object sender, EventArgs e)
        {
            Member_BlockList();
        }

        //신고글의 계정목록 조회버튼
        private void button5_Click(object sender, EventArgs e)
        {
            Report_MemberList();
        }

        //기능 의 조회버튼
        private void button6_Click(object sender, EventArgs e)
        {

        }
    }
}
