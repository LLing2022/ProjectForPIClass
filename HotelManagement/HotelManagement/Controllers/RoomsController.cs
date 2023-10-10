using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace HotelManagement.Controllers
{
    public class RoomsController : Controller
    {
        private HotelManagementDBEntities db = new HotelManagementDBEntities();
        // GET: Rooms
        public ActionResult Index()
        {
            return View(db.RoomTypes.ToList());
        }

        public ActionResult Book(int? roomTypeId)
        {
            if (roomTypeId == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Book([Bind(Include = "startDateTime,endDateTime")] Reservation reservation, int roomTypeId)
        {
            if (ModelState.IsValid)
            {
                reservation.userId = db.Users.Where(user => user.name.Equals(HttpContext.User.Identity.Name)).Select(user => user.userId).Single();
                reservation.Rooms.Add(db.Rooms.Where(room => room.roomTypeId == roomTypeId).First());

                db.Reservations.Add(reservation);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(reservation);
        }

        public ActionResult CancelReservation(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Reservation reservation = db.Reservations.Where(res => res.userId == id).Single();
            if (reservation == null)
            {
                return HttpNotFound();
            }
            return View(reservation);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CancelReservation(Reservation reservation, int id)
        {
            Reservation toDelete = db.Reservations.Where(res => res.userId == id).Single();
            toDelete.Rooms.Clear();
            db.Reservations.Remove(toDelete);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult ModifyReservation(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Reservation reservation = db.Reservations.Where(res => res.userId == id).Single();
            if (reservation == null)
            {
                return HttpNotFound();
            }
            return View(reservation);
        }

        [HttpPost, ActionName("Modify")]
        [ValidateAntiForgeryToken]
        public ActionResult ModifyReservation([Bind(Include = "reservationId,startDate,endDate")] Reservation reservation, int id)
        {
            if (ModelState.IsValid)
            {
                db.Entry(reservation).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }
    }
}