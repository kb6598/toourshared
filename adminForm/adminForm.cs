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

        //adminForm 기본 설정
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

        //신고목록조회 버튼
        private void button1_Click(object sender, EventArgs e)
        {
            After_Report();
        }

        //신고글 제재 버튼
        private void button2_Click(object sender, EventArgs e)
        {
            Travel travel = new Travel();
            Member member = new Member();
            Member_Block member_Block = new Member_Block();
            TravelDao travelDao = new TravelDao();
            MemberDao memberDao = new MemberDao();
            Report delete = new Report();
            Member_BlockDao member_BlockDao = new Member_BlockDao();


            int selectedCellCount = dataGridView1.GetCellCount(DataGridViewElementStates.Selected);


            // trvNo를 받아와서 그 Travel의 mem_id를 가지고 그 mem_id의 state를 바꾼다.

            //선택한 셀들의 행을 구해오고 그행의 두번째열 trv_no의 값을 가져온다.
            travel.Trv_no = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[1].Value.ToString();

            travel = travelDao.selectTravelBytrv_no(travel); // 바꿔치기

            member.Mem_id = travel.Mem_id;

            memberDao.UpdateMemberStateByMemId(member, 1); // 멤버 상태 바꾸고

            travel.Trv_secret = "3"; // travel 객체 secret 속성 데이터 바꾸고

            travelDao.UpdatetTravel(travel); // travelDao로 DB 업데이트


            //제재 눌렀을때 선택한 행의 trv_no를 가져온다. 
            travel.Trv_no = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[1].Value.ToString();
            try
            {
                string sql = "select travel.mem_id as mem_id from toourshared.travel"
                    + " where travel.trv_no = @trv_no";
                string mem_id = "";
                MySqlConnection con = myDB.GetCon();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@trv_no", travel.Trv_no);
                con.Open();
                MySqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    mem_id = rd["mem_id"].ToString();
                }

                rd.Close();
                con.Close();

                string sql2 = "insert  into toourshared.member_block(mem_blo_date, mem_blo_length, mem_id)"
                    + " values(now(), 3, @mem_id)";
                MySqlCommand cmd2 = new MySqlCommand(sql2, con);
                cmd2.Parameters.AddWithValue("@mem_id", mem_id);

                con.Open();
                cmd2.ExecuteNonQuery();
                con.Close();
            }

            catch
            {

            }

            //선택 행의 첫번째 rep_no 가져오기
            delete.Rep_no = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[0].Value.ToString();

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

            After_Report();
        }

        //신고글 해제 버튼
        private void button3_Click(object sender, EventArgs e)
        {
            Travel inputTravel = new Travel();
            Travel outputTravel = new Travel();
            TravelDao travelDao = new TravelDao();
            Report delete = new Report();

            int selectedCellCount = dataGridView1.GetCellCount(DataGridViewElementStates.Selected);

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

        //계정정지 해제버튼
        private void button5_Click(object sender, EventArgs e)
        {
            MyDB mydb = new MyDB();
            MySqlConnection con;
            MySqlCommand cmd;
            MySqlDataReader reader;

            List<string> memberList = new List<string>(); // 계정 블록된 아이디들 리스트로
            List<string> dateList = new List<string>(); // 계정 블록된 날짜 데이터 

            string Sql = "SELECT * FROM member_block"; // member_block 테이블 데이터 조회 SQL

            try
            {
                con = mydb.GetCon();
                cmd = new MySqlCommand(Sql, con);

                con.Open();
                reader = cmd.ExecuteReader();

                while(reader.Read())
                {
                    if (string.IsNullOrEmpty(reader["mem_blo_date"].ToString()) || string.IsNullOrEmpty(reader["mem_id"].ToString()))
                    {
                        // 데이터가 null or empty 일 경우
                        continue;
                    }
                    else
                    {
                        // 데이터 존재하는 경우 lists에 데이터 추가
                        memberList.Add(reader["mem_id"].ToString());
                        dateList.Add(reader["mem_blo_date"].ToString());
                    }
                }

                reader.Close();
                con.Close();
            }
            catch{;}

            string Now_Time = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"); // 2번

            int compareTime = 0;
            DateTime time1, time2;

            List<string> compareList = new List<string>();

            for (int i = 0; i < dateList.Count; i++)
            {
                time1 = DateTime.Parse(dateList[i]).AddHours(72); // 이전 시간에서 72시간 더한 시간
                time2 = DateTime.Parse(Now_Time); // 현재 시간

                compareTime = DateTime.Compare(time1, time2);
                if(compareTime <= 0)
                {
                    compareList.Add(memberList[i]); // 그 인원만 따로 List에 추가
                }
            }

            try
            {
                for(int j = 0; j < compareList.Count; j++)
                {
                    con = mydb.GetCon(); // compareList 수 만큼 연결 반복
                    Sql = "DELETE FROM member_block WHERE mem_id = '" + compareList[j] + "'"; // 그 아이디에 해당하는 데이터를 삭제하는 SQL

                    cmd = new MySqlCommand(Sql, con);

                    con.Open();
                    cmd.ExecuteNonQuery(); // 쿼리 실행
                    con.Close();
                }
            }
            catch {; }


            //☆  →  할일을 말로 대충 풀어쓴 것
            //string sql = "select mem_blo_date from member_block";
            //위의 sql에서 조회된 데이터를 저장한다. ex) string Before_Report = "위의 sql데이터 값";
            //DELETE FROM member_block WHERE Now_Time <= Before_Report + 3

            //★★★  아래처럼 해야 합니다.  ★★★
            //① sql의 조회된 값을 변수에 저장한다.
            //② 현재 시간을 변수에 저장한다.
            //③ 이전시간 + 3일 값이 현재시간보다 크거나 같으면 테이블에서 해당 데이터를 삭제한다.

            Member_BlockList();//계정 정지목록 조회
        }
    }
}
