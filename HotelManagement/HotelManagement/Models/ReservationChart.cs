using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.Linq;
using System.Web;

namespace HotelManagement.Models
{
    public class ReservationChart
    {
        private Dictionary<int, List<string>> chart;
        private DateTime[] datesInWeek = new DateTime[7];

        public ReservationChart(DateTime startDate)
        {
            this.chart = new Dictionary<int, List<string>>();
            this.datesInWeek[0] = startDate.Date;

            for (int i = 1; i < 7; i++)
            {
                this.datesInWeek[i] = this.datesInWeek[i - 1].Date.AddDays(1);
            }
        }

        public void AddRoomNumbers(List<int> roomNumberList)
        {
            foreach (int roomNumber in roomNumberList)
            {
                chart.Add(roomNumber, new List<string>(7));
                for (int i = 0; i < 7; i++)
                {
                    chart[roomNumber][i] = "";
                }
            }
        }

        public void AddReservation(Reservation reservation)
        {
            foreach (int roomNumber in reservation.Rooms.Select(r => r.roomNumber))
            {
                for (int i = 0; i < 7; i++)
                {
                    if (reservation.startDateTime.Date == this.datesInWeek[i].Date)
                        chart[roomNumber][i] += ("Guest arriving at " + reservation.startDateTime.ToShortTimeString() + "\n");
                    else if (reservation.endDateTime.Date == this.datesInWeek[i].Date)
                        chart[roomNumber][i] += ("Guest leaving at " + reservation.startDateTime.ToShortTimeString() + "\n");
                    else if (reservation.startDateTime.Date < this.datesInWeek[i].Date &&
                            this.datesInWeek[i].Date < reservation.endDateTime.Date)
                        chart[roomNumber][i] += ("Occupied\n");
                }
            }
        }

        public Dictionary<int, List<string>> GetChart()
        {
            foreach (KeyValuePair<int, List<string>> row in chart)
            {
                for (int i = 0; i < 7; i++)
                {
                    if (row.Value[i].Equals(""))
                        row.Value[i] = "Vacant";
                }
            }

            return chart;
        }
    }
}