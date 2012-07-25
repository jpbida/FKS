import java.util.*;
import java.awt.*;
import java.io.*;
import java.awt.image.*;
//import javax.imageio.*;

public class lattice{//begin Lattice Class
    public static void main(String args[]){//begin main
	int e1 = 0;
	int s1 = 0;
	int p1 = 0;
	int i1 = 0;
	int b1 = 0;
	int size = 0;
	int time = 0;
	boolean mpeg = false;
	boolean path = false;
	String tru = "TRUE";
	String sim_file ="file";
	String path_file= "file";
	double r_stat = 0;
	double f_stat = 0;
	double g_stat = 0;
	String mpeg_dir = ".";
	String file_num = args[1];
try {
        // Create the tokenizer to read from a file
        FileReader rd = new FileReader(args[0]);
        StreamTokenizer st = new StreamTokenizer(rd);
    
        // Prepare the tokenizer for Java-style tokenizing rules
        st.parseNumbers();
        st.wordChars('_', '_');
        st.eolIsSignificant(true);
    
        // If whitespace is not to be discarded, make this call
        //st.ordinaryChars(0, ' ');
    
        // These calls caused comments to be discarded
        st.slashSlashComments(true);
        st.slashStarComments(true);
    
        // Parse the file
        int token = st.nextToken();
        while (token != StreamTokenizer.TT_EOF) {
            token = st.nextToken();
            switch (token) { //switch
            case StreamTokenizer.TT_WORD:
                // A word was found; the value is in sval
                String word = st.sval;
		    if(word.equals("SIZE")){
			token = st.nextToken();		      
			size = (int)st.nval;
		    }else{
			if(word.equals("ENZYME")){
			    token = st.nextToken();		      
			    e1 = (int)st.nval;
			}else{
			if(word.equals("MPEG_DIR")){
			    token = st.nextToken();		      
			    mpeg_dir = st.sval;			   
			}else{
			    if(word.equals("SUBSTRATE")){
				token = st.nextToken();		      
				s1 = (int)st.nval;
			    }else{
				if(word.equals("PRODUCT")){
				token = st.nextToken();		      
				p1 = (int)st.nval;
				}else{
				    if(word.equals("INTERMEDIATE")){
					token = st.nextToken();		      
					i1 = (int)st.nval;
				    }else{
					if(word.equals("BOUNDARY")){
					    token = st.nextToken();		      
					    b1 = (int)st.nval;
					}else{
					    if(word.equals("R_STAT")){
						token = st.nextToken();	
						r_stat = st.nval;
					    }else{
					    if(word.equals("G_STAT")){
						token = st.nextToken();		      
						g_stat = st.nval;
					    }else{
					    if(word.equals("F_STAT")){
						token = st.nextToken();		      
						f_stat = st.nval;
					    }else{
					    if(word.equals("TIME")){
						token = st.nextToken();		      
						time = (int)st.nval;
					    }else{
					    if(word.equals("SIM_MPEG")){
						token = st.nextToken();		      
						mpeg = tru.equals(st.sval);
					    }else{
					    if(word.equals("OUT_FILE")){
						token = st.nextToken();	    
						sim_file = st.sval;
					    }else{
					    if(word.equals("MOL_PATH")){
						token = st.nextToken();		      
						path = tru.equals(st.sval);
					    }else{
					    if(word.equals("OUT_MOLS")){
						token = st.nextToken();		      
						path_file = st.sval;
					    }
					}
					}
					}
					}
					}
					}
					}
					}
				    }
				    }
				}
			    }
			}
		    }
		
		
                break;
            case '"':
                // A double-quoted string was found; sval contains the contents
                String dquoteVal = st.sval;
                break;
            case '\'':
                // A single-quoted string was found; sval contains the contents
                String squoteVal = st.sval;
                break;
            case StreamTokenizer.TT_EOL:
                // End of line character found
                break;
            case StreamTokenizer.TT_EOF:
                // End of file has been reached
                break;
            default:
                // A regular character was found; the value is the token itself
                char ch = (char)st.ttype;
                break;
            }
        }
        rd.close();
    } catch (IOException e) {
    }
sim_file = sim_file + file_num + ".csv";
	//Testing lattice class
	int[] vals = {1,2,3,4,5};
	int[] dens = {e1,s1,i1,p1,b1};
	
	int[][] output = new int[2][3];
	int tot;
	int k = 0;
	String out_path;
	String out_sim;
	lattice grid = new lattice(size,size);
	grid.r_static = r_stat;
	grid.f_static = f_stat;
	grid.g_static = g_stat;
	tot = grid.addMol(vals,dens);

	// Generates data for molecular path plots       //
	try{
	FileWriter pathFile = new FileWriter(path_file);
	System.out.print("Creating file: sim " + file_num + " "); 
	FileWriter simFile = new FileWriter(sim_file);
	System.out.print("sim " + file_num + " "); 
	while(k < time){
	    grid.colli = 0;
	    grid.disas1s = 0;
	    grid.disas1f = 0;
	    grid.disas2s = 0;
	    grid.disas2f = 0;
	    grid.assoc = 0;
	output = grid.simESCEP(tot,0);
	out_path = grid.printMols()+"\n";
	if(path){
	pathFile.write(out_path,0,out_path.length());
	}
	if(mpeg){
	grid.print(mpeg_dir +"/frame"+((k%10000-k%1000)/1000)+((k%1000-k%100)/100)+""+((k%100-k%10)/10)+""+k%10+".png");	
	}

	    out_sim = k + "," + grid.colli+ "," +grid.disas1s+ ","+grid.disas1f+ "," +grid.assoc+ "," +grid.disas2s+ ","+grid.disas2f+ "," +grid.printSimData();

	simFile.write(out_sim,0,out_sim.length());
	if(k%10 == 0){
	    System.out.print(".");
	} 
	k++;
	}
    pathFile.close();
    simFile.close();
	}catch(IOException e){
	    System.out.println("Error Creating file");
	}
	//----------------------------------------------//
	

	
	// Generates .png images for creating animation //
	/*
	grid.print("./images/frame0000.png");
	while(k < 1000){
	output = grid.simESCEP(tot,0);
	k++;
	grid.print("./images/frame"+((k%10000-k%1000)/1000)+((k%1000-k%100)/100)+""+((k%100-k%10)/10)+""+k%10+".png");	
	}
	*/
	//----------------------------------------------//
	/*
	// Generates csv data for analyis //
	System.out.println("T E S C P");
	while(k < 1000){
	output = grid.simESCEP(tot,0);
	System.out.printf("%d,",k);
	grid.printSimData();
	k++;
	}
	//----------------------------------------------//
	*/
    }
 
    public lattice(int x0,int y0){
        x = x0;
        y = y0;
        grid2 = new int[x][y];
	for(int i = 0; i < grid2[0].length; i++){
	    for(int j = 0; j < grid2.length; j++){
		grid2[j][i]=0;
	    }
	}
    }
    public void printMolPath(int molnum){
	//System.out.println();
	for(int i = 0; i < sim2.length; i++){
	    if(sim2[i][2][molnum]==3){
		System.out.println(i + ": x = " + sim2[i][0][molnum] + " y = " + sim2[i][1][molnum] + " type = " +  sim2[i][2][molnum]);}
	}
	    	    System.out.println();
    }

    public int addMol(int[] vals, int[] dense){
        int nMol = 0;
        int added = 0; 
        int x1;
        int x2;
	int size=0;
	int val;
	int dens;
	int tot;

	for(int i = 0; i < vals.length; i++){
	    val = vals[i];
	    dens = dense[i];
	    nMol = dens;
	switch(val)
	    {
	    case 5:
		// Do not count boundaries as reactive molecules
		break;
	    case 3:
		totalmols = totalmols + 2*nMol;
		// C = E+S so it is counted as two molecules
		break;
		default:
		totalmols = totalmols + nMol;
	    }
	}
	//System.out.println("Total Mols: " + totalmols);
	mols = new int[3][totalmols];
	lastmol =0;

	for(int i = 0; i < vals.length; i++){
	    val = vals[i];
	    dens = dense[i];

	nMol = dens;
	added =0;
        while(added < nMol){
            x1 = (int)Math.round((Math.random()*(x-1)));
            x2 = (int)Math.round((Math.random()*(y-1)));
	    if(grid2[x1][x2] == 0){
		
		//System.out.println("x = "+x1+", y = "+x2);
	
		// Adding Values to current reactive molecules list 
		if(val != 5){
		    if(val == 3){
		mols[0][lastmol]=x1;
		mols[1][lastmol] = x2;
		mols[2][lastmol++]=val;
		    // adding dummy values for C spliting into E and P 
                mols[0][lastmol]=x1;
		mols[1][lastmol]=x2;
		mols[2][lastmol++]=-1;
		    }else{
		mols[0][lastmol]=x1;
		mols[1][lastmol]=x2;
		mols[2][lastmol++]=val;
		    }
		}
		grid2[x1][x2]=val;
		added++;
	    }
	}
	}
	tot = totalmols;
	return tot;
    }

    public void print(String outFileName){
	/* Writes out simulation data to a file */
	int r;
	int g;
	int b;
	int w = 0;
	BufferedImage img = new BufferedImage(x,y,6);
	int[] pixels =new int[x*y];
	for(int i = 0; i < this.grid2[0].length; i++){
            for(int j = 0; j < this.grid2.length; j++){
		    if(this.grid2[j][i] == 1){//E
			g = 255;
			b = 0;
			r = 0;
		    }
		else{
		    if(this.grid2[j][i] == 2){//S
		    	g = 0;
			b = 255;
			r = 0;
		    }
		else{
		    if(this.grid2[j][i] == 3){//C
		    	g = 255;
			b = 255;
			r = 0;
		    }
		else{
		    if(this.grid2[j][i] == 4){//P
		    	g = 0;
			b = 0;
			r = 255;
		    }
		else{
		    if(this.grid2[j][i] == 5){//B
		    	g = 100;
			b = 100;
			r = 10;
		    }else{
			g = 255;
			b = 255;
			r = 255;
		    }
		    }
		
		}
		}
		}
	    
		
		    pixels[w++]= (255 << 24) | (r << 16) | (g << 8) | b;
            }
	}
	img.setRGB(0,0,x,y,pixels,0,x);
	img = mag2(img);
	img = mag2(img);
	//try{
	//ImageIO.write(img, "png", new File(outFileName));
	//}catch(IOException e){
	//   System.out.println("IO Exception");	
	//}
    }
    public BufferedImage mag2(BufferedImage img){
	// Magnifies the give image 
	int w = img.getWidth();
	int h = img.getHeight();
	int[] pixels = new int[2*w*2*h];
	BufferedImage outImg = new BufferedImage(w*2,h*2,6);
	int k = 0;
	for(int i = 0; i < w; i++){
	    if(k != 0){
		    int k1 = k;
		for(int z = (k-2*w); z < k1; z++){
		    pixels[k++]=pixels[z];
		}
	    }
	    for(int j = 0; j < h; j++){
		pixels[k++] = img.getRGB(i,j);
		pixels[k++] = img.getRGB(i,j);
	    }
	}
outImg.setRGB(0,0,2*w,2*h,pixels,0,2*w);
return outImg;
    }
    public String printMols(){
	String out = "";
	for(int i = 0; i < mols[0].length; i++){
	    out = (out + i + "," + mols[0][i] + "," + mols[1][i] + "," + mols[2][i]+"\n");
	}
	return out;
    }
    
    public String printSimData(){
	int E = 0;
	int S = 0;
	int C = 0;
	int P = 0;
	String out_simData;
for(int i = 0; i < mols[0].length; i++){
    if(mols[2][i]==1){E++;}
    if(mols[2][i]==2){S++;}
    if(mols[2][i]==3){C++;}
    if(mols[2][i]==4){P++;}
}
//System.out.printf("%d,%d,%d,%d\n",E,S,C,P);
out_simData =  E + "," + S + "," + C + "," + P+"\n";
return out_simData;
    }
    public int[] move(double xdir, double ydir){
	int xmove;
	int ymove;
	int[] out = new int[2];
	if(xdir < 0.33333){
		xmove = -1;
	    }else{
		if(xdir < 0.66666){
		    xmove = 0;
		}
	    else{
		xmove = 1;
	    }
	    }
	    if(ydir < 0.33333){
		ymove = -1;
	    }else{
		if(ydir < 0.6666){
		    ymove = 0;
		}
	    else{
		ymove = 1;
	    }
	    }
	    out[0] = xmove;
	    out[1] = ymove;
	    return out;

    }
    public int[][] simESCEP(int time, int debug){//begin simESCEP 
    sim2 = new int[1][3][totalmols];

    for(int v = 0; v < 3; v++){
	for( int w = 0; w < totalmols; w++){
	    sim2[0][v][w] = mols[v][w];
	}
    }
    /*
	for(int u = 1; u < time ; u++){
		    for(int v = 0; v < 3; v++){
			for(int w = 0; w < totalmols; w++){
		    sim2[u][v][w] = 0;
		}
	    }
    
		}
    */
    /* Rules for Particle Motion 
       1.) If the molecule occupying this site is an S, a destination
       iste is chosen at random between its four nearest neighbors. If
       this destination iste is unoccupied, the molecule moves to it
       directly. If the destination iste is occupied by an E molecule,
       a random nubmer is chosen between 0 and 1. If this number is
       loware than the reaction probability f, the destination site is
       turned into a C molecule and the initial S site becomnes
       unoccupied. In all other cases, the S moleucle remains at ist
       initial position.
       2) If the molecule occupying the cosen site is an E the process
       is symmetric to the formaer case, depends on the occupancy
       status of the randomly chosen destination site: */
    
    int t = 0;
    int pick =-1;
    int ymove = 0;
    int xmove = 0;
    int pair = 0;
    int spot;
    int[] cord = new int[2];
    double xdir;
    double ydir;
    boolean pickmol = true;
    boolean check = false;
    double react_prob;
    int step =0;
    int[][] out = new int[2][3];

	/* Intializing the Simulation Data */
	

		while(step < time){//begin while t < time
    // Setting t-1 = t to initialize the coordinates 
		    /*  if(step!=0){
	
 for(int v = 0; v < 3; v++){
	for( int w = 0; w < totalmols; w++){
	    sim2[step][v][w] = sim2[step-1][v][w];
	}
    }
	}	    */


    t = 0;// This prevents all moves from being stored so we don't run out of memory
    // Randomly Choose a molecule to move: 1 time unit = move "totalmols" times 

    pickmol = true;
    // pick a molecule to move. Make sure the molecule is reactive;
    while(pickmol){
	pick = (int)(Math.random()*(totalmols)-.5);
	if(sim2[t][2][pick]!=-1){
	    pickmol = false;
	}
    }
    if(debug == 1){ System.out.println();}
    if(debug == 1){ System.out.println("Step: " + step);}
    if(debug == 1){ System.out.println();}
    if(debug == 1){ System.out.println("Moving Molecule " + pick + ": x = "  + sim2[t][0][pick] + " y = "+sim2[t][1][pick]+" type = "+sim2[t][2][pick]);}
    
    // Returning the Point that is going to be moved 

        out[0][0] =  sim2[t][0][pick]; // x coordinate
	out[0][1] =  sim2[t][1][pick]; // y cordinate
	out[0][2] =  sim2[t][2][pick]; // Type determines what color the point will be
	// Returning the Second Point = Same as first point if particle doesn't move
	out[1][0] =  sim2[t][0][pick]; // x coordinate
	out[1][1] =  sim2[t][1][pick]; // y cordinate
	out[1][2] =  sim2[t][2][pick]; // Type determines what color the point will be
	

        /* addMol(val,size,density) 1 = E, 2 = S, 3 = C, 4 = P*/  
    switch(sim2[t][2][pick]){//begin switch

	case 1:
	    xdir = Math.random();
	    ydir = Math.random();
	    cord = this.move(xdir,ydir);
	    xmove = cord[0];
	    ymove = cord[1];
	   
	    // Making sure we stay within the grid 
	    if((ymove + sim2[t][1][pick]) < 0){
		ymove = 0;
	    }else{
		if((ymove + sim2[t][1][pick]) >= grid2[0].length){
		ymove = 0;
		}
	    }
	    if(xmove + sim2[t][0][pick] < 0){
		xmove = 0;
	    }
	    else{
		if((xmove + sim2[t][0][pick]) >= grid2.length){
		xmove = 0;
		}
	    }

	    cord[0] = sim2[t][0][pick]+xmove;
	    cord[1] = sim2[t][1][pick]+ymove;

	    spot = grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove];
	    if(spot == 2){
		colli++;
		if(Math.random() < f_static){
		    assoc++;
		    grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove] = 3;
		    grid2[sim2[t][0][pick]][sim2[t][1][pick]] = 0;
		    
		    sim2[t][0][pick] = sim2[t][0][pick]+xmove;
		    sim2[t][1][pick] = sim2[t][1][pick]+ymove;
		    sim2[t][2][pick] = 3;


		    // Intial Point becomes type = 0, New point becomes Type = 3 

		    out[0][2] =  0;
		    out[1][0] =  cord[0];
		    out[1][1] =  cord[1];
		    out[1][2] =  3;

		    if(debug == 1){ System.out.println("REACTION: C to  x = " + cord[0] + " y = " +  cord[1]);}
		    // Making the type 2 molecule in the mols array = type -1
		    for(int j = 0; j<sim2[t][0].length; j++){
			if(sim2[t][0][j] == cord[0] & sim2[t][1][j] == cord[1] & sim2[t][2][j] == 2){
			    sim2[t][2][j] = -1;
			}
		    }
		}

	    }
	    else{ 
		if(spot == 0){
		    //Move Molecule to that spot, Update Grid;
		    grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove] = 1;
		    grid2[sim2[t][0][pick]][sim2[t][1][pick]] = 0;
		    sim2[t][0][pick] = sim2[t][0][pick]+xmove;
		    sim2[t][1][pick] = sim2[t][1][pick]+ymove;

		    // Old Point = 0 new point = 1
		    out[0][2] =  0;
		    out[1][0] =  cord[0];
		    out[1][1] =  cord[1];
		    out[1][2] =  1;
		    
		    if(debug == 1){ System.out.println("       to: x = " + cord[0] + " y = " +  cord[1]);}
		}
	    }
	    break;
	case 2:
	    xdir = Math.random();
	    ydir = Math.random();
 cord = this.move(xdir,ydir);
	    xmove = cord[0];
	    ymove = cord[1];
	   
	    // Making sure we stay within the grid 
	    if((ymove + sim2[t][1][pick]) < 0){
		ymove = 0;
	    }else{
		if((ymove + sim2[t][1][pick]) >= grid2[0].length){
		ymove = 0;
		}
	    }
	    if(xmove + sim2[t][0][pick] < 0){
		xmove = 0;
	    }
	    else{
		if((xmove + sim2[t][0][pick]) >= grid2.length){
		xmove = 0;
		}
	    }	   

	    cord[0] = sim2[t][0][pick]+xmove;
	    cord[1] = sim2[t][1][pick]+ymove;

	    spot = grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove];
	    if(spot == 1){
		colli++;
		if(Math.random() < f_static){
		    assoc++;
		    grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove] = 3;
		    grid2[sim2[t][0][pick]][sim2[t][1][pick]] = 0;
		    sim2[t][0][pick] = sim2[t][0][pick]+xmove;
		    sim2[t][1][pick] = sim2[t][1][pick]+ymove;
		    sim2[t][2][pick] = 3;

		    // Original Spot becomes 0 new spot becomes 3
		    out[0][2] =  0;
		    out[1][0] =  cord[0];
		    out[1][1] =  cord[1];
		    out[1][2] =  3;


		    if(debug == 1){ System.out.println("REACTION: C to  x = " + cord[0] + " y = " +  cord[1]);}
		    //Reaction: Making the second molecule in the reaction = type = -1 in the mols array
		    for(int j = 0; j < sim2[t][0].length; j++){
			if(sim2[t][0][j] == cord[0] & sim2[t][1][j] == cord[1] & sim2[t][2][j] == 1 ){
			    sim2[t][2][j] = -1;
			}
		    }
		}

	    }    
	    else{ 
		if(spot == 0){
		    //Move Molecule to that spot, Update Grid;
		    grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove] = 2;
		    grid2[sim2[t][0][pick]][sim2[t][1][pick]] = 0;
		    sim2[t][0][pick] = sim2[t][0][pick]+xmove;
		    sim2[t][1][pick] = sim2[t][1][pick]+ymove;

		    // Original Spot becomes zero, new spot becomes 2
		    out[0][2] =  0;
		    out[1][0] =  cord[0];
		    out[1][1] =  cord[1];
		    out[1][2] =  2;

		    if(debug == 1){ System.out.println("       to: x = " + cord[0] + " y = " +  cord[1]);}
		}
	    }

	    break;
	case 3:
	    xdir = Math.random();
	    ydir = Math.random();
	    cord = this.move(xdir,ydir);
	    xmove = cord[0];
	    ymove = cord[1];
	   
	    // Making sure we stay within the grid 
	    if((ymove + sim2[t][1][pick]) < 0){
		ymove = 0;
	    }else{
		if((ymove + sim2[t][1][pick]) >= grid2[0].length){
		ymove = 0;
		}
	    }
	    if(xmove + sim2[t][0][pick] < 0){
		xmove = 0;
	    }
	    else{
		if((xmove + sim2[t][0][pick]) >= grid2.length){
		xmove = 0;
		}
	    }

	    
	    cord[0] = sim2[t][0][pick]+xmove;
	    cord[1] = sim2[t][1][pick]+ymove;

	    spot = grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove];
	    // How does the product dissassociate?
	    react_prob = Math.random();
	    if(react_prob < (r_static)){
		//C dissassociates into E and S if site is unoccupied
		if(spot == 0){
		    disas1s++;
		    //Moves S to the unoccupied spot
		    grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove] = 2;
		    //E stays in original C spot
		    grid2[sim2[t][0][pick]][sim2[t][1][pick]] = 1;

		    //Original C molecule becomes and E molecule;
		    sim2[t][2][pick] = 1;
		    
		    out[0][2] =  1;
		    out[1][0] =  cord[0];
		    out[1][1] =  cord[1];
		    out[1][2] =  2;

		    //C molecules -1 spot becomes the S molecule with new coordinates
		    check = false;
		    if(debug == 1){ System.out.println("DISASSOCIATION: E and S");}
		    if(debug == 1){ System.out.println("       S to: x = " + cord[0] + " y = " +  cord[1]);}
		    for(int j = 0; j<sim2[t][0].length; j++){
			if(sim2[t][0][j] == sim2[t][0][pick] & sim2[t][1][j] == sim2[t][1][pick] & sim2[t][2][j] == -1){
			    sim2[t][2][j] = 2;
			    sim2[t][0][j] = sim2[t][0][pick]+xmove;
			    sim2[t][1][j] = sim2[t][1][pick]+ymove;
			    check = true;
			}
		    }
		    if(!check){
			if(debug == 1){ System.out.println("No -1 spot for C molecule: C -> E + S");}
		    }
		    
		}else{disas1f++;}
      

	    }else{
		if(react_prob < (r_static + g_static)){
	       //C dissassociates into E and P if site is unoccupied
		if(spot == 0){
		    disas2s++;
		    if(debug == 1){ System.out.println("DISASSOCIATION: E and P");}
		    if(debug == 1){ System.out.println("       P to: x = " + cord[0] +" y = " + cord[1]);}
		    //Moves P to the unoccupied spot
		    grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove] = 4;
		    //E stays in original C spot
		    grid2[sim2[t][0][pick]][sim2[t][1][pick]] = 1;

		    //Original C molecule becomes and E molecule;
		    sim2[t][2][pick] = 1;
		    
		    out[0][2] =  1;
		    out[1][0] =  cord[0];
		    out[1][1] =  cord[1];
		    out[1][2] =  4;

		    //C molecules -1 spot becomes the P molecule with new coordinates
		    check = false;
		    for(int j = 0; j<sim2[t][0].length; j++){
			if(sim2[t][0][j] == sim2[t][0][pick] & sim2[t][1][j] == sim2[t][1][pick] & sim2[t][2][j] == -1){
			    sim2[t][2][j] = 4;
			    sim2[t][0][j] = sim2[t][0][pick]+xmove;
			    sim2[t][1][j] = sim2[t][1][pick]+ymove;
			    check = true;
			}
		    }
		    if(!check){
			if(debug == 1){ System.out.println("No -1 spot for C molecule: C -> E and P");}
		    }

		}else{disas2f++;}
		}else{
		    
		// C randomly moves to the site if unoccupied
		if(spot == 0){
		    if(debug == 1){ System.out.println("       to: x = " + cord[0] + " y = " +  cord[1]);}
		    //Move Molecule to that spot, Update Grid;
		    grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove] = 3;
		    grid2[sim2[t][0][pick]][sim2[t][1][pick]] = 0;
 
		    out[0][2] =  0;
		    out[1][0] =  cord[0];
		    out[1][1] =  cord[1];
		    out[1][2] =  3;

		    for(int j = 0; j<sim2[t][0].length; j++){
			if(sim2[t][0][j] == sim2[t][0][pick] & sim2[t][1][j] == sim2[t][1][pick] & sim2[t][2][j] == -1){
			    sim2[t][0][j] = sim2[t][0][pick]+xmove;
			    sim2[t][1][j] = sim2[t][1][pick]+ymove;
			    check = true;
			}
		    }

		    sim2[t][0][pick] = sim2[t][0][pick]+xmove;
		    sim2[t][1][pick] = sim2[t][1][pick]+ymove;

		    if(!check){
			if(debug == 1){ System.out.println("No -1 spot for C molecule: Moving C");}
		    }
		}
		}
	    }
	    break;
	case 4:
	    xdir = Math.random();
	    ydir = Math.random();
	    cord = this.move(xdir,ydir);
	    xmove = cord[0];
	    ymove = cord[1];
	   
	    // Making sure we stay within the grid 
	    if((ymove + sim2[t][1][pick]) < 0){
		ymove = 0;
	    }else{
		if((ymove + sim2[t][1][pick]) >= grid2[0].length){
		ymove = 0;
		}
	    }
	    if(xmove + sim2[t][0][pick] < 0){
		xmove = 0;
	    }
	    else{
		if((xmove + sim2[t][0][pick]) >= grid2.length){
		xmove = 0;
		}
	    }


	    cord[0] = sim2[t][0][pick]+xmove;
	    cord[1] = sim2[t][1][pick]+ymove;

	    spot = grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove];
	    if(spot == 0){

		    out[0][2] =  0;
		    out[1][0] =  cord[0];
		    out[1][1] =  cord[1];
		    out[1][2] =  4;

		if(debug == 1){ System.out.println("       to: x = " + cord[0] + " y = " +  cord[1]);}
		    //Move Molecule to that spot, Update Grid;
		    grid2[sim2[t][0][pick]+xmove][sim2[t][1][pick]+ymove] = 4;
		    grid2[sim2[t][0][pick]][sim2[t][1][pick]] = 0;
		    sim2[t][0][pick] = sim2[t][0][pick]+xmove;
		    sim2[t][1][pick] = sim2[t][1][pick]+ymove;
	    }
	    
	    break;
	default:
	    if(debug == 1){ System.out.println("Error! Unknown molecule type = "+sim2[t][2][pick]);}
	   
    }
    if(debug == 1){ System.out.println();}
 step++;	  // System.out.println("Time: "+t);
}


		// setting the final state to mols. So that a simulation can be stepped through 

 for(int v = 0; v < 3; v++){
	for( int w = 0; w < totalmols; w++){
	    mols[v][w] =  sim2[0][v][w];
	}
    }
 return out;
   
}
    public int colli = 0;
    public int assoc = 0;
    public int disas1s = 0;
    public int disas1f = 0;
    public int disas2s = 0;
    public int disas2f = 0;
    public int[][]   grid2;
    public int[][][]   sim2;
    public int x = 1;
    public int y = 1;
    public int[][] mols;
    public int   totalmols = 0;
    public int lastmol;
    public double r_static;
    public double f_static;
    public double g_static;

}


