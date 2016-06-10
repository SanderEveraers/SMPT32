package com.wordflip.api;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;
import com.wordflip.api.models.*;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

/**
 * Created by robvangastel on 02/06/16.
 */
public class SqlCreator {

	private DataSource ds;

	public SqlCreator() {
		try {
			DBConfiguration db = new DBConfiguration();
			ds = db.dataSource();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public DataSource createDataSource() {
		try {
			DBConfiguration db = new DBConfiguration();
			DataSource ds = db.dataSource();
			return ds;
		} catch (SQLException e) {
			e.getMessage();
		}
		return null;
	}

	public boolean testDataSource() {

		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		boolean gotConnection = false;

		try {
			con = (Connection) ds.getConnection();
			stmt = (Statement) con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM leerling");

			while (rs.next()) {
				gotConnection = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return gotConnection;
	}

	public boolean validateUser(String userId) {

		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		boolean valid = false;

		try {
			con = (Connection) ds.getConnection();
			stmt = (Statement) con.createStatement();
			rs = stmt.executeQuery("select * FROM leerling WHERE ID =" + userId);

			while (rs.next()) {
				valid = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return valid;
	}

	public Pupil loginPupil(String username, String password) {

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Pupil p = null;
		PreparedStatement stmt2 = null;

		try {
			con = (Connection) ds.getConnection();
			stmt = (PreparedStatement) con.prepareStatement("SELECT * FROM leerling WHERE gebruikersnaam = ? AND wachtwoord = ?");
			stmt.setString(1, username);
			stmt.setString(2, password);
			rs = stmt.executeQuery();
			Calendar c = Calendar.getInstance();

			while (rs.next()) {
				c.setTime(rs.getTimestamp("Laatstingelogd"));
				p = new Pupil(rs.getInt("ID"), rs.getString("Gebruikersnaam"), rs.getString("Wachtwoord"), c);
			}

			stmt2 = (PreparedStatement) con.prepareStatement("UPDATE L" +
					"EERLING SET LaatstIngelogd = ? WHERE ID = ?");
			c = Calendar.getInstance();
			stmt2.setTimestamp(1, new Timestamp(c.getTimeInMillis()));
			stmt2.setInt(2, p.getId());
			stmt2.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (stmt2 != null) stmt2.close();
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return p;
	}

	public void addPractice(Practice practice, String userId, String toetsId) {

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			con = (Connection) ds.getConnection();
			int id = Integer.parseInt(userId);
			int toets_id = Integer.parseInt(toetsId);
			int planned = (practice.isPlanned()) ? 1 : 0;

			stmt = (PreparedStatement) con.prepareStatement("INSERT INTO oefenmoment(Tijdstip, Tijdsduur, Leerling_ID, Aantal, fouten, toets_ID, planned) VALUES ( Now(), ?, ?, ?, ?, ?, ?)");
			stmt.setInt(1, practice.getDuration());
			stmt.setInt(2, id);
			stmt.setInt(3, practice.getAmountOfWords());
			stmt.setInt(4, practice.getMistakes());
			stmt.setInt(5, toets_id);
			stmt.setInt(6, planned);
			stmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public List<Practice> getPractices(String userId) {

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Practice> practices = new ArrayList<>();

		try {
			con = (Connection) ds.getConnection();
			int id = Integer.parseInt(userId);

			stmt = (PreparedStatement) con.prepareStatement("SELECT * FROM oefenmoment o WHERE o.leerling_ID = ?");
			stmt.setInt(1, id);
			rs = stmt.executeQuery();

			//int duration, int amountOfWords, int correct, Date timeOfPractice
			while (rs.next()) {
				Calendar c = Calendar.getInstance();
				c.setTime(rs.getTimestamp("Tijdstip"));
				practices.add(new Practice(rs.getInt("tijdsduur"), rs.getInt("aantal"), rs.getInt("fouten"), c, (rs.getInt("planned") == 1) ? true : false));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return practices;
	}

	public List<Practice> getOtherPractices(String userId) {

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Practice> practices = new ArrayList<>();

		try {
			con = (Connection) ds.getConnection();
			int id = Integer.parseInt(userId);

			stmt = (PreparedStatement) con.prepareStatement("SELECT * FROM oefenmoment o WHERE o.leerling_ID <> ?");
			stmt.setInt(1, id);
			rs = stmt.executeQuery();

			//int duration, int amountOfWords, int correct, Date timeOfPractice
			while (rs.next()) {
				Calendar c = Calendar.getInstance();
				c.setTime(rs.getTimestamp("Tijdstip"));
				practices.add(new Practice(rs.getInt("tijdsduur"), rs.getInt("aantal"), rs.getInt("fouten"), c, (rs.getInt("planned") == 1) ? true : false));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return practices;
	}

	public List<Subject> getSubjectCount(String userId) {

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Subject> subjects = new ArrayList<>();

		try {
			con = (Connection) ds.getConnection();
			int id = Integer.parseInt(userId);

			stmt = (PreparedStatement) con.prepareStatement("SELECT count(o.ID), k.GegevenVak FROM oefenmoment o, klas k, toets t WHERE k.ID = t.Klas_ID AND o.toets_ID = t.ID AND o.Leerling_ID = ?");
			stmt.setInt(1, id);
			rs = stmt.executeQuery();

			while (rs.next()) {
				subjects.add(new Subject(rs.getInt("count(o.ID)"), rs.getString("GegevenVak")));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return subjects;
	}

	public List<Practice> getToetsPractices(int toets_id) {

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Practice> toetsPractices = new ArrayList<>();

		try {
			con = (Connection) ds.getConnection();

			stmt = (PreparedStatement) con.prepareStatement("SELECT * FROM oefenmoment o, klas k, toets t WHERE k.ID = t.Klas_ID AND o.toets_ID = t.ID AND t.ID = ?");
			stmt.setInt(1, toets_id);
			rs = stmt.executeQuery();

			while (rs.next()) {
				Calendar c = Calendar.getInstance();
				c.setTime(rs.getTimestamp("Tijdstip"));
				toetsPractices.add(new Practice(rs.getInt("tijdsduur"), rs.getInt("aantal"), rs.getInt("fouten"), c, (rs.getInt("planned") == 1) ? true : false));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return toetsPractices;
	}




	public int getToetsId(String course, int userId) {

		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		int toetsId = 1;

		System.out.println(course);
		System.out.println(userId);

		try {
			con = (Connection) ds.getConnection();
			stmt = (Statement) con.createStatement();
			rs = stmt.executeQuery("CALL `getToetsvragen`('" + course + "', " + userId + ")");
			while(rs.next()){
				toetsId = rs.getInt("Toets_ID");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return toetsId;
	}

}
