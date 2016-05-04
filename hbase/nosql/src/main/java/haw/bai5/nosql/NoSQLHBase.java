package haw.bai5.nosql;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.util.Bytes;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

public class NoSQLHBase {
	
	public static void main(String[] args) throws IOException {
		Configuration conf = HBaseConfiguration.create();
		conf.set("hbase.zookeeper.quorum", "localhost:2181");
		conf.set("hbase.master", "localhost");
        conf.set("hbase.zookeeper.property.clientPort", "35402");	// TODO: ändern!?
		HBaseAdmin admin = new HBaseAdmin(conf);
		HTableDescriptor tableDescriptor = new HTableDescriptor(TableName.valueOf("postals"));
		tableDescriptor.addFamily(new HColumnDescriptor("details"));
		admin.createTable(tableDescriptor);
		System.out.println("create table: Done!");

		HTable table = new HTable(conf, "postals");
		
		String file = "/media/sf_haw.bai5.nosql_wpp/P2/plz.data";
		String thisLine = null;
		Gson gson = new Gson();
		BufferedReader br = new BufferedReader(new FileReader(file));
		while((thisLine = br.readLine()) != null) {
			JsonElement jsonElem = gson.fromJson(thisLine, JsonElement.class);
			JsonObject json = jsonElem.getAsJsonObject();
			
			Put put = new Put(Bytes.toBytes(json.get("_id").toString()));
			put.add(Bytes.toBytes("postals"), Bytes.toBytes("city"), Bytes.toBytes(json.get("city").toString()));
			put.add(Bytes.toBytes("postals"), Bytes.toBytes("log"), Bytes.toBytes(json.get("log").toString()));
			put.add(Bytes.toBytes("postals"), Bytes.toBytes("pop"), Bytes.toBytes(json.get("pop").toString()));
			put.add(Bytes.toBytes("postals"), Bytes.toBytes("state"), Bytes.toBytes(json.get("state").toString()));
			
			table.put(put);
			table.flushCommits();
		}
		table.close();
		br.close();
	}
}
