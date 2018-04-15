package com.copan.framework.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.logicalcobwebs.proxool.ProxoolException;
import org.logicalcobwebs.proxool.configuration.JAXPConfigurator;
import org.xml.sax.InputSource;


/**
 * 
 * @author LuoQing
 *
 */
public class DBOperator {

	/**
	 * 日志
	 */
	public static final Logger logger = Logger.getLogger(DBOperator.class.getName());

	/**
	 * 数据连接池名称
	 */
	private String DBPOOL_NAME;

	/**
	 * DBOperator的唯一实例
	 */
	private static DBOperator _instance = new DBOperator();

//	/**
//	 * 数据库连接池配置文件
//	 */
	//private static String confFilePath = "." + File.separator + "conf" + File.separator + "ProxoolConf.xml";

	/**
	 * 数据库连接初始化状态
	 */
	private static boolean initialized = false;

	/**
	 * 构造一个DBOperator
	 */
	private DBOperator() {

	}

	/**
	 * 数据库连接初始化
	 * @param 配置文件路径
	 * @param 连接池名称
	 */
	public void init(String configFile, String poolName) throws Exception {
		if (!initialized) {
			logger.info("数据库连接初始化");
			DBPOOL_NAME = poolName;
			try {
				JAXPConfigurator.configure(new InputSource(configFile), false);
				logger.info("初始化数据库链接池文件(" + configFile + ").");
			} catch (ProxoolException ex) {
				logger.info("初始化数据库链接池文件(" + configFile + ")失败.");
				throw new Exception("初始化数据库链接池文件(" + configFile + ")失败", ex);
			}

			try {
				Class.forName("org.logicalcobwebs.proxool.ProxoolDriver");
				logger.info("初始化数据库连接池驱动.");
			} catch (ClassNotFoundException e) {
				logger.error("初始化数据库连接池驱动失败:");
				throw new Exception("初始化数据库连接池驱动失败:", e);
			}
			initialized = true;
			logger.info("数据库连接初始化完成");
			
		}
	}
	
	/**
	 * 重新载入配置文件
	 * @param configFile
	 * @param poolName
	 * @throws Exception
	 */
	public void reload(String configFile,String poolName) throws Exception{
		initialized = false;
		init(configFile,poolName);
	}

	/**
	 * 静态方式返回一个DBOperator实例
	 * 
	 * @return
	 */
	public static DBOperator getInstance() {
		return _instance;
	}

	/**
	 * 返回一个数据库连接
	 * 
	 * @return
	 * @throws SQLException
	 */
	public Connection getConnection() throws SQLException {
		return getConnection(DBPOOL_NAME);
	}

	/**
	 * 根据连接池名称返回一个连接
	 * 
	 * @param aliasName
	 *            连接池数据源
	 * @return
	 * @throws SQLException
	 */
	public Connection getConnection(String aliasName) throws SQLException {
		Connection connection = null;
		if (!initialized) {
			throw new SQLException("数据库连接池没有被初始化。");
		}
		connection = DriverManager.getConnection("proxool." + aliasName);
		if (connection != null) {
			return connection;

		} else {
			throw new SQLException("数据库连接池" + aliasName + "不存在，或已超过最大连接.");
		}
	}

	/**
	 * 执行批量插入的事务
	 * @param sqls
	 * @return
	 */
	public boolean executeInsertTransactions(DBIterator iterator) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			try {
				while (iterator.hasNext()) {
					rs = stmt.executeQuery("select LAST_INSERT_ID()");
					while (rs.next()) {
						if (stmt.executeUpdate(iterator.next(rs.getInt(1))) != 1) {
							logger.error("执行sql事务不完整");
							conn.rollback();
							return false;
						}
						break;
					}
				}
				conn.commit();
				return true;
			} catch (Exception ex) {
				logger.error("执行sql事务异常:", ex);
				conn.rollback();
				return false;
			}
		} catch (Exception e) {
			logger.error("执行sql事务异常:", e);
			return false;
		} finally {
			try {
				if(rs != null){
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
					conn = null;
				}
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * 执行批量插入的事务,并批量返回插入数据的标识结果集
	 */
	public int[] executeInsertTransactions(String[] sqls) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			try {
				int[] retIds = new int[sqls.length];
				int uprows = 0;
				for (int i = 0; i < sqls.length; i++) {
					if (stmt.executeUpdate(sqls[i]) != 1) {
						logger.error("执行sql事务不完整");
						conn.rollback();
						return null;
					}
					rs = stmt.executeQuery("select LAST_INSERT_ID()");
					while (rs.next()) {
						retIds[i] = rs.getInt(1);
						uprows++;
						break;
					}
				}
				if (uprows != sqls.length) {
					logger.error("执行sql事务不完整");
					conn.rollback();
					return null;
				}
				conn.commit();
				return retIds;
			} catch (Exception ex) {
				logger.error("执行sql事务异常:", ex);
				conn.rollback();
				return null;
			}
		} catch (Exception e) {
			logger.error("执行sql事务异常:", e);
			return null;
		} finally {
			try {
				if(rs != null){
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
					conn = null;
				}
			} catch (Exception e) {
			}
		}
	}

	/**
	 * 根据sql语句执行查询
	 * 
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public ExResultSet executeQuery(String sql) {
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		try {
			conn = getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY,
					ResultSet.CLOSE_CURSORS_AT_COMMIT);
			rs = stmt.executeQuery(sql);
			ExResultSet ers = new ExResultSet(rs);
			return ers;
		} catch (SQLException e) {
			logger.warn("执行sql查询异常[" + sql + "]:" + e.getMessage());
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
			}
		}
	}
	/**
	 * 根据参数执行SQL语句
	 * @param sql
	 * @param params
	 * @return
	 */
	public ExResultSet executeQuery(String sql, Param[] params)
	  {
	    ResultSet rs = null;
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    try
	    {
	      conn = getConnection();
	      stmt = conn.prepareStatement(sql);
	      for (int i = 0; (params != null) && (i < params.length); i++) {
	        Param param = params[i];
	        if (param == null) {
	          break;
	        }
	        switch (param.type) {
		        case Types.TINYINT:
		        	stmt.setInt(i + 1, ((Byte)param.content).intValue());
			          break;
		        case Types.INTEGER:
		        	stmt.setInt(i + 1, ((Integer)param.content).intValue());
			          break;
		        case Types.SMALLINT:
		          stmt.setInt(i + 1, ((Short)param.content).intValue());
		          break;
		        case Types.BIGINT:
		          stmt.setLong(i + 1, ((Long)param.content).longValue());
		          break;
		        case Types.VARCHAR:
		          stmt.setString(i + 1, (String)param.content);
		          break;
		        case Types.DATE:
		          stmt.setDate(i + 1, (java.sql.Date)param.content);
		          break;
		        case Types.TIMESTAMP:
		          stmt.setTimestamp(i + 1, (Timestamp)param.content);
		          break;
		        case Types.FLOAT:
		          stmt.setFloat(i + 1, ((Float)param.content).floatValue());
		          break;
		        case Types.DOUBLE:
		          stmt.setDouble(i + 1, ((Double)param.content).doubleValue());
		          break;
		        default:
		          throw new SQLException("配置的参数类型不正确:" + param.type);
	        }
	      }
	      rs = stmt.executeQuery();
	      ExResultSet ers = new ExResultSet(rs);
	      return ers;
	    } catch (SQLException e) {
	      logger.warn("执行sql查询异常[" + sql + "]:" + e.getMessage());
	      e.printStackTrace();
	      return null;
	    } finally {
	      try {
	        if (rs != null) {
	          rs.close();
	          rs = null;
	        }
	        if (stmt != null) {
	          stmt.close();
	          stmt = null;
	        }
	        if (conn != null) {
	          conn.close();
	          conn = null;
	        }
	      } catch (SQLException e) {
	      }
	    }
	  }
	
	

	/**
	 * 数据库查询方法
	 * 
	 * @param sql
	 *            需要执行查询执行sql语句
	 * @param objDbGeneral
	 *            对象生成接口
	 * @return
	 */
	public List<Object> executeQuery(String sql, IObjectDBGeneral objDbGeneral) {
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		List<Object> lists = new ArrayList<Object>();
		try {
			conn = getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY,
					ResultSet.CLOSE_CURSORS_AT_COMMIT);
			rs = stmt.executeQuery(sql);
			int row = 0;
			while (rs != null && rs.next()) {
				lists.add(objDbGeneral.mappingRow(rs, row++));
			}
			return lists;
		} catch (SQLException e) {
			logger.warn("执行sql查询异常[" + sql + "]:" + e.getMessage());
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
			}
		}
	}

	/**
	 * 根据sql执行
	 * 
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public boolean execute(String sql) {
		Statement stmt = null;
		Connection conn = null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			stmt.execute(sql);
			return true;
		} catch (SQLException e) {
			logger.warn("执行sql异常[" + sql + "]:" + e.getMessage());
			return false;
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
			}
		}
	}

	/**
	 * 执行事务(sqls的长度必须和影响结果相同才会提交，否则失败回轨！)
	 */
	public boolean executeTransactions(String[] sqls) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			try {
				for (int i = 0; i < sqls.length; i++) {
					if (sqls[i] != null && !sqls[i].equals("")) {
						stmt.addBatch(sqls[i]);
					}
				}
				int rows = 0;
				int[] result = stmt.executeBatch();
				for (int i = 0; i < result.length; i++) {
					rows += result[i];
				}
				if(sqls.length != rows) {
					logger.error("执行sql事务不完整 ");
					conn.rollback();
					return false;
				}
				conn.commit();
				
				return true;
			} catch (Exception ex) {
				logger.error("执行sql事务异常:", ex);
				conn.rollback();
				return false;
			}
		} catch (Exception e) {
			logger.error("执行sql事务异常:", e);
			return false;
		} finally {
			try {

				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
					conn = null;
				}

			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * 根据sql执行插入操作，并返回最后一条插入数据的标识
	 * 
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public long executeInsertRetLong(String sql) {
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			stmt.execute(sql);
			rs = stmt.executeQuery("select LAST_INSERT_ID()");
			while (rs.next()) {
				return rs.getLong(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.warn("执行sql插入异常[" + sql + "]:" + e.getMessage());
			return 0;
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
			}
		}
		return 0;
	}

	/**
	 * 根据sql执行插入操作，并返回最后一条插入数据的标识
	 * 
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public int executeInsert(String sql) {
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			stmt.execute(sql);
			rs = stmt.executeQuery("select LAST_INSERT_ID()");
			while (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.warn("执行sql插入异常[" + sql + "]:" + e.getMessage());
			return 0;
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
			}
		}
		return 0;
	}
	/**
	 * 根据参数运行SQL语句
	 * @param sql
	 * @param params
	 * @return
	 */
	public int executeInsert(String sql, Param[] params)
	  {
	    Connection conn = null;
	    ResultSet rs = null;
	    PreparedStatement stmt = null;
	    try {
	      conn = getConnection();
	      stmt = conn.prepareStatement(sql);
	      for (int i = 0; (params != null) && (i < params.length); i++) {
	        Param param = params[i];
	        if (param == null) {
	          break;
	        }
		    switch (param.type) {
			    case Types.TINYINT:
					stmt.setInt(i + 1, (Byte) param.content);
					break;
				case Types.SMALLINT:
					stmt.setInt(i + 1, (Short) param.content);
					break;
				case Types.INTEGER:
					stmt.setInt(i + 1, (Integer) param.content);
					break;
		        case Types.BIGINT:
		          stmt.setLong(i + 1, ((Long)param.content).longValue());
		          break;
		        case Types.VARCHAR:
		          stmt.setString(i + 1, (String)param.content);
		          break;
		        case Types.DATE:
		          stmt.setDate(i + 1, (java.sql.Date)param.content);
		          break;
		        case Types.TIMESTAMP:
		          stmt.setTimestamp(i + 1, (Timestamp)param.content);
		          break;
		        case Types.FLOAT:
		          stmt.setFloat(i + 1, ((Float)param.content).floatValue());
		          break;
		        case Types.DOUBLE:
		          stmt.setDouble(i + 1, ((Double)param.content).doubleValue());
		          break;
		        default:
		          throw new SQLException("配置的参数类型不正确:" + param.type);
	        }
	      }
	      stmt.execute();
	      int count = stmt.getUpdateCount();
	      if (count > 0) {
	        rs = stmt.executeQuery("select LAST_INSERT_ID()");
	        if (rs.next()) {
	          return rs.getInt(1);
	        }
	      }else{
	        return 0;
	      }
	    } catch (SQLException e) {
	      e.printStackTrace();
	      logger.warn("执行sql插入异常[" + sql + "]:" + e.getMessage());
	      return 0;
	    } finally {
	      try {
	        if (rs != null) {
	          rs.close();
	          rs = null;
	        }
	        if (stmt != null) {
	          stmt.close();
	          stmt = null;
	        }
	        if (conn != null) {
	          conn.close();
	          conn = null;
	        }
	      }
	      catch (SQLException e)
	      {
	      }
	    }
	    return 0;
	  }

	/**
	 * 批量插入方法
	 * 
	 * @param sql
	 *            批量插入sql字符串 本字符串必须符合insert into
	 *            table(columnName1,columnName2,...columnNamen)
	 *            values(?,?,...?)的格式 否则无法完成
	 * @param params
	 *            插入参数数组 数组的列的数量必须与sql字符串中的列数相同
	 * @return
	 */
	public int[] excuteBatchInsert(String sql, Param[][] params) {
		int[] result = null;
		Connection conn = null;
		PreparedStatement psStatement = null;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			psStatement = conn.prepareStatement(sql);
			try {
				for (int i = 0; i < params.length; i++) {
					for (int j = 0; params[i] != null && j < params[i].length; j++) {
						Param param = params[i][j];
						if (param == null) {
							break;
						}
						switch (param.type) {
						case Types.TINYINT:
							psStatement.setInt(j + 1, (Byte) param.content);
							break;
						case Types.SMALLINT:
							psStatement.setInt(j + 1, (Short) param.content);
							break;
						case Types.INTEGER:
							psStatement.setInt(j + 1, (Integer) param.content);
							break;
						case Types.BIGINT:
							psStatement.setLong(j + 1, (Long) param.content);
							break;
						case Types.VARCHAR:
							psStatement
									.setString(j + 1, (String) param.content);
							break;
						case Types.DATE:
							psStatement.setDate(j + 1,
									(java.sql.Date) param.content);
							break;
						case Types.TIMESTAMP:
							psStatement.setTimestamp(j + 1,
									(Timestamp) param.content);
							break;
						case Types.FLOAT:
							psStatement.setFloat(j + 1, (Float) param.content);
							break;
						case Types.DOUBLE:
							psStatement
									.setDouble(j + 1, (Double) param.content);
							break;
						default:
							throw new Exception();
						}
					}
					psStatement.addBatch();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				conn.rollback();
			}
			result = psStatement.executeBatch();
			conn.commit();
			return result;

		} catch (Exception e) {
			logger.warn("执行sql插入异常[" + sql + "]:" + e.getMessage());
			return null;
		} finally {
			try {
				if (psStatement != null) {
					psStatement.close();
					psStatement = null;
				}

				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
					conn = null;
				}
			} catch (Exception e) {
			}
		}
	}

	/**
	 * 根据sql执行
	 * 
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public int executeUpdate(String sql) {
		Statement stmt = null;
		Connection conn = null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			return stmt.executeUpdate(sql);
		} catch (SQLException e) {
			logger.warn("执行sql更新异常[" + sql + "]:" + e.getMessage());
			return 0;
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
			}
		}
	}

	public int executeUpdate(String sql, Param[] params)
	  {
	    PreparedStatement stmt = null;
	    Connection conn = null;
	    try {
	      conn = getConnection();
	      stmt = conn.prepareStatement(sql);
	      for (int i = 0; (params != null) && (i < params.length); i++) {
	        Param param = params[i];
	        if (param == null) {
	          break;
	        }
	        switch (param.type) {
		        case Types.TINYINT:
		        	stmt.setInt(i + 1, ((Byte)param.content).intValue());
			          break;
		        case Types.INTEGER:
		        	stmt.setInt(i + 1, ((Integer)param.content).intValue());
			          break;
		        case Types.SMALLINT:
		          stmt.setInt(i + 1, ((Short)param.content).intValue());
		          break;
		        case Types.BIGINT:
		          stmt.setLong(i + 1, ((Long)param.content).longValue());
		          break;
		        case Types.VARCHAR:
		          stmt.setString(i + 1, (String)param.content);
		          break;
		        case Types.DATE:
		          stmt.setDate(i + 1, (java.sql.Date)param.content);
		          break;
		        case Types.TIMESTAMP:
		          stmt.setTimestamp(i + 1, (Timestamp)param.content);
		          break;
		        case Types.FLOAT:
		          stmt.setFloat(i + 1, ((Float)param.content).floatValue());
		          break;
		        case Types.DOUBLE:
		          stmt.setDouble(i + 1, ((Double)param.content).doubleValue());
		          break;
		        default:
		          throw new SQLException("配置的参数类型不正确:" + param.type);
	        }
	      }
	      return stmt.executeUpdate();
	    } catch (SQLException e) {
	      logger.warn("执行sql更新异常[" + sql + "]:" + e.getMessage());
	      return 0;
	    } finally {
	      try {
	        if (stmt != null) {
	          stmt.close();
	          stmt = null;
	        }
	        if (conn != null) {
	          conn.close();
	          conn = null;
	        }
	      } catch (SQLException e) {
	      }
	    }
	  }
}
