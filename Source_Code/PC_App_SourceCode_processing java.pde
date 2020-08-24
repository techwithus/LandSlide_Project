import org.gicentre.utils.stat.*; // For chart classes.
 import grafica.*;
import java.util.Random;
import processing.serial.*;//Serial port library
public GPlot plot2;
public String SerialData;
Serial myPort;// defining a class my port

float data1 = 0,data2 = 0,data3 = 0,data4 = 0,data5 = 0,AtmosTemp = 0,AtmosHumi = 0,vibration = 0; 
PFont f;
int[] nums;
int count = 0, nPoints = 100;
GPointsArray points = new GPointsArray(nPoints);
BarChart barChart;// Creating Bar Chart Object
// Creating line chart object
 
// Initialises the sketch and loads data into the chart.
void setup()
{ myPort = new Serial(this, "COM17", 9600);//Selecting serial port and baudRate
   f = createFont("Arial",16,true);
  int nPoints = 100;
  
  /* for (int i = 0; i < nPoints; i++) {
    points.add(i, 10*noise(0.1*i));
  }*/
  size(850,600);//Determine the size of the Screen
  //Line plot settings
  plot2 = new GPlot(this);
  plot2.setPos(380, 30);
  plot2.setDim(300, 300);
  plot2.getTitle().setText("Vibration Data");
  plot2.getXAxis().getAxisLabel().setText("Number of data");
  plot2.getYAxis().getAxisLabel().setText(" Pulse Duration");
  plot2.activateZooming(1.5);
  

  //BarChart settings
  barChart = new BarChart(this);
  barChart.setBarColour(color(0,0,200,150));
  barChart.setBarGap(4); 
  // Scaling
  barChart.setMinValue(0);
  barChart.setMaxValue(1);
  textFont(createFont("Serif",10),10);
  barChart.setData(new float[] {0.76, 0.24, 0.39, 0.18, 0.20});//Initialdummy value
  barChart.showValueAxis(true);
  barChart.setValueFormat("#%");
  barChart.setBarLabels(new String[] {"S1","S2","S3","S4","S5"});
  barChart.showCategoryAxis(true);
}
// Draws the chart in the sketch
void draw()
{SerialData = myPort.readStringUntil('\n');
if(SerialData == null){
 // print("0");
 return;
}
else{
  //print(SerialData);
  nums = int(split(SerialData,','));
  if(nums.length == 9){
 data1 =  1- ( (nums[0]/1023.00));//Mapping for drawing bar graph
 data2 =  1 - ( (nums[1]/1023.00));
 data3 =  1 - ( (nums[2]/1023.00));
 data4 =  1 - ( (nums[3]/1023.00));
 data5 =  1 - ( (nums[4]/1023.00));
 vibration = nums[5];
  AtmosTemp = nums[6]/100;
  AtmosHumi = nums[7]/100;
  count = count  +1;
  points.add(count,vibration);
  println(nums[5]);
  /* print(nums[1]);
    print(nums[2]);
     print(nums[3]);
      print(nums[4]);
       print(nums[5]);
        print(nums[6]);
         print(nums[7]);*/
  }
  else{
    return;
  }
 
}
  background(255);
 //GPoint lastPoint = plot2.getPointsRef().getLastPoint();
  textFont(f,16);                  // STEP 3 Specify font to be used
  fill(0);                         // STEP 4 Specify font color 
  text("Atmosphere Temperature : ",80,480); text(AtmosTemp,280,480);text("°C",340,480); 
  text("Atmosphere Humidity : ",500,480);text(AtmosHumi,500+170,480); text("%",555+170,480); 
  

  // Reset the points if the user pressed the space bar
  
   // Draw the second plot  
  plot2.beginDraw();
  plot2.drawBackground();
  plot2.drawBox();
  plot2.drawXAxis();
  plot2.drawYAxis();
  plot2.drawTitle();
  plot2.drawGridLines(GPlot.BOTH);
  plot2.drawLines();
  plot2.drawPoints();
  plot2.setPoints(points);
  plot2.endDraw();
  barChart.setData(new float[] {data1, data2, data3, data4, data5});
  barChart.draw(30,40,350,350); 
}
