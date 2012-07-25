

import javax.swing.*;//for the inputs
import java.io.*;//for the output file
public class Test10
/*Combinatorics solution fastest and best looking yet
 *same as test15 but tries every position and chooses the line 
 *closest to the preferred length
 *lines cross is still flawed...but best version yet...
 */
{   static Database[] threeDRoute;
    static int xMAX = getNum("Value for maximum in x direction?","100") ;
    static int yMAX = getNum("Value for maximum in y direction?","100") ;
    static int zMAX = getNum("Value for maximum in z direction?","100") ;
    static int xMIN =  0;
    static int yMIN = 0;
    static int zMIN = 0;
    static int xRow = 0;
    static int yRow = 0;
    static int zRow = 0;
    static int r = getNum("Value for radii?","10") ;
    static FileOutputStream out; // declare a file output object
    static PrintStream p;
    
     public static void main(String[] args)  
        {          String file_name = "";
                try {Thread.sleep(10);
            		} catch(Exception e) {System.out.println(e);}
                         // declare a print stream object

                try
                {
                        // Create a new file output stream
                        // connected to "myfile.txt"
                        file_name = "CenterCoordinates.txt";//where to save the file
                        out = new FileOutputStream(file_name);

                        // Connect print stream to the output stream
                        p = new PrintStream( out );
		


                        
                }
                catch (Exception e)
                {
                        System.err.println ("Error writing to file");
                }
                setRoute();//the meat of the program
                p.close();//closes the file
                alert("Done."+(char)012+"Results saved in: "+file_name);//game over sign
           
         }
        
        
        public static boolean getBool(String s, String t, String yes, String no)
        {
            boolean valid = false;
             boolean bool = false;
            Object[] options = {yes,no};
            while(!valid)
            {
                int n = JOptionPane.showOptionDialog(null, s,t,
                    JOptionPane.YES_NO_OPTION,
                    JOptionPane.QUESTION_MESSAGE,
                    null,
                    options,
                    options[0]);
                switch (n)
                {   case JOptionPane.YES_OPTION: 
                        bool = true;
                        valid = true;
                        break; 
                    case JOptionPane.NO_OPTION: 
                        bool = false;
                        valid = true;
                        break;
                    case JOptionPane.CANCEL_OPTION: 
                        valid = false; break;
            }
        }
           
        return bool;
        }
        
        public static int getNum(String s, String  d)
        {   int num = -1;
            String exception ="Maybe";
            while(!exception.equals("None"))
               {
                   try 
                    {
                       num = Integer.parseInt(JOptionPane.showInputDialog(s,d));
                       exception = "None";
                   } catch(Exception e) {exception = e.toString();}
               }
            return num;
        }
            public static void alert(String s)
        {   JOptionPane.showMessageDialog(null,
                     s,
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
            
        }    
        public static void print(Object s)
        {   p.println(s);//prints to file not screen
        }
        
        
       public static void setRoute()
        {   int num = (int)(((xMAX*yMAX*zMAX)*.8)/r/r/r/(4/3)/Math.PI);//overestimate how many spheres there will be
            threeDRoute = new Database[num];//makes database of that many points
            boolean isAPlane = true;// used as a switch
            int j = 0;//counter
            double zAt = r;//the first ball's z-coord
            while(zAt<=zMAX-r)//so, when z is less than the z lid on the box...
            {   
                /*There are two types of planes of balls A and B
                 */
                
                if(isAPlane)
                {   yRow=0;
                    double xAt=2*r;
                    double yAt=r;
                    while(yAt<=yMAX-r)
                    {
                        while(xAt<=xMAX-r)
                        {
                            threeDRoute[j] = new Database(xAt, yAt, zAt);
                            print(threeDRoute[j]);//calls MY print METHOD
                            xAt = xAt + 2*r;//x coords are always off by 2*r
                            j++;

                        }
                        yRow++;
                        yAt = yAt + Math.sqrt(3)*r;//y coords are always off by this
                        /*
                         *There are two types of rows of balls
                         *they start at different x coords
                         */
                        if(yRow%2==1)
                        {
                            xAt = r;
                        }
                        if(yRow%2==0)
                        {
                            xAt = 2*r;
                        }
                    }
                }
                else
                {   
                    yRow=0;
                    double xAt=r;
                    double yAt=Math.sqrt(3)/3*r+r;
                    while(yAt<=yMAX-r)
                    {
                        while(xAt<=xMAX-r)
                        {
                            threeDRoute[j] = new Database(xAt, yAt, zAt);
                            print(threeDRoute[j]);
                            xAt = xAt + 2*r;
                            j++;

                        }
                        yRow++;
                        yAt = yAt + Math.sqrt(3)*r;
                        if(yRow%2==0)
                        {
                            xAt = r;
                        }
                        if(yRow%2==1)
                        {
                            xAt = 2*r;
                        }
                    }
                }
                isAPlane = !isAPlane;
                zAt = zAt +Math.sqrt(6.)*(2./3.)*r;//z coords are always off by this
            }
        }
	     
}

class Database
{   //each point or center of a sphere is an instance of this class
    double x;
    double y;
    double z;
    public Database(double over, double down, double imagine)
    {   
        x= over;
        y = down;
        z= imagine; 
    
    }
    public String toString()
    {   String s = ""+x+(char)9+y+(char)9+z;//(char)9 is a TAB could be replaced by "," or " "
        return s;
    }
}






