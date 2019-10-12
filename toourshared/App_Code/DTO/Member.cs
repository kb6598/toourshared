using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Member의 요약 설명입니다.
/// </summary>
namespace tooushared.DTO
{
    public class Member
    {

        private string mem_id;
        private string mem_state;
        private string mem_phone;
        private string mem_pw;
        private string mem_name;
        private string mem_sex;
        private string mem_ques;
        private string mem_answer;
        private string mem_birth;
        private string mem_email;
        private string mem_reg_datetime;
        private string mem_timestmap;
        private string mem_img_url;

        public Member()
        {

        }


        public Member(string mem_id, string mem_state, string mem_phone, string mem_pw, string mem_name, string mem_sex, string mem_ques, string mem_answer, string mem_birth, string mem_email, string mem_reg_datetime, string mem_timestmap, string mem_img_url)
        {
            this.mem_id = mem_id;
            this.mem_state = mem_state;
            this.mem_phone = mem_phone;
            this.mem_pw = mem_pw;
            this.mem_name = mem_name;
            this.mem_sex = mem_sex;
            this.mem_ques = mem_ques;
            this.mem_answer = mem_answer;
            this.mem_birth = mem_birth;
            this.mem_email = mem_email;
            this.mem_reg_datetime = mem_reg_datetime;
            this.mem_timestmap = mem_timestmap;
            this.mem_img_url = mem_img_url;
            //
            // TODO: 여기에 생성자 논리를 추가합니다.
            //
        }

        public string Mem_id
        {
            get
            {
                return mem_id;
            }

            set
            {
                mem_id = value;
            }
        }

        public string Mem_state
        {
            get
            {
                return mem_state;
            }

            set
            {
                mem_state = value;
            }
        }

        public string Mem_phone
        {
            get
            {
                return mem_phone;
            }

            set
            {
                mem_phone = value;
            }
        }

        public string Mem_pw
        {
            get
            {
                return mem_pw;
            }

            set
            {
                mem_pw = value;
            }
        }

        public string Mem_name
        {
            get
            {
                return mem_name;
            }

            set
            {
                mem_name = value;
            }
        }

        public string Mem_sex
        {
            get
            {
                return mem_sex;
            }

            set
            {
                mem_sex = value;
            }
        }

        public string Mem_ques
        {
            get
            {
                return mem_ques;
            }

            set
            {
                mem_ques = value;
            }
        }

        public string Mem_answer
        {
            get
            {
                return mem_answer;
            }

            set
            {
                mem_answer = value;
            }
        }

        public string Mem_birth
        {
            get
            {
                return mem_birth;
            }

            set
            {
                mem_birth = value;
            }
        }

        public string Mem_email
        {
            get
            {
                return mem_email;
            }

            set
            {
                mem_email = value;
            }
        }

        public string Mem_reg_datetime
        {
            get
            {
                return mem_reg_datetime;
            }

            set
            {
                mem_reg_datetime = value;
            }
        }

        public string Mem_timestmap
        {
            get
            {
                return mem_timestmap;
            }

            set
            {
                mem_timestmap = value;
            }
        }

        public string Mem_img_url
        {
            get
            {
                return mem_img_url;
            }

            set
            {
                mem_img_url = value;
            }
        }

        public override bool Equals(object obj)
        {
            var member = obj as Member;
            return member != null &&
                   mem_id == member.mem_id &&
                   mem_state == member.mem_state &&
                   mem_phone == member.mem_phone &&
                   mem_pw == member.mem_pw &&
                   mem_name == member.mem_name &&
                   mem_sex == member.mem_sex &&
                   mem_ques == member.mem_ques &&
                   mem_answer == member.mem_answer &&
                   mem_birth == member.mem_birth &&
                   mem_email == member.mem_email &&
                   mem_reg_datetime == member.mem_reg_datetime &&
                   mem_timestmap == member.mem_timestmap &&
                   mem_img_url == member.mem_img_url;
        }

        public override int GetHashCode()
        {
            var hashCode = -704531517;
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_id);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_state);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_phone);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_pw);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_name);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_sex);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_ques);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_answer);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_birth);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_email);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_reg_datetime);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_timestmap);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(mem_img_url);
            return hashCode;
        }
    }
}