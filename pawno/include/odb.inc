#if defined _odb_included
  #endinput
#endif

#define _odb_included
#pragma library dutils

#include <a_samp>
#include <dutils>
//---Forwards---//
forward odb_hash(buf[]);
forward odb_getPlanosaude(nickname[]);
forward odb_setPlanosaude(nickname[], new_planosaude);
//--------------//
public odb_hash(buf[]) {
	new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

public odb_getPlanosaude(nickname[]) {
  new pwd_hash, planosaude;
  if (odb_Load(nickname, pwd_hash, planosaude;
  return 0;
}

public odb_setPlanosaude(nickname[], new_planosaude) {
  new pwd_hash, planosaude;
  if (odb_Load(nickname, pwd_hash, planosaude;)) {
      odb_Save(nickname, pwd_hash, planosaude;);
	  return true;
    }
  return false;
}

public odb_Save(nickname[], pwd_hash, planosaude) {
  new tmpres[MAX_STRING];
  tmpres[0]=0;
  new tmp[MAX_STRING];
  new File:fhnd;
  
  valstr(tmp,pwd_hash);   strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,planosaude); strcat(tmpres,tmp); strcat(tmpres,";");

  strcat(tmpres,clantag);
  format(tmpres,sizeof(tmpres),"%s;%f;);
  
  
  new tmp2[MAX_STRING];

  new tmp_a[MAX_STRING];
  new tmp_b[MAX_STRING];


  set(tmp_a,tmp2);strcat(tmp_a,".1.player");
  set(tmp_b,tmp2);strcat(tmp_b,".2.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_b,io_write);
	 fwrite(fhnd,tmpres);
	 fclose(fhnd);
	 fremove(tmp_a);
     return true;
  }

  set(tmp_a,tmp2);strcat(tmp_a,".2.player");
  set(tmp_b,tmp2);strcat(tmp_b,".3.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_b,io_write);
	 fwrite(fhnd,tmpres);
	 fclose(fhnd);
	 fremove(tmp_a);
     return true;
  }
  set(tmp_a,tmp2);strcat(tmp_a,".3.player");
  set(tmp_b,tmp2);strcat(tmp_b,".1.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_b,io_write);
	 fwrite(fhnd,tmpres);
	 fclose(fhnd);
	 fremove(tmp_a);
     return true;
  }
  fhnd=fopen(tmp_b,io_write);
  fwrite(fhnd,tmpres);
  fclose(fhnd);


  return false;
}

public odb_Load(nickname[], &pwd_hash, &planosaude) {
  new tmpres[MAX_STRING];
  tmpres[0]=0;
  pwd_hash=0; planosaude=0;

  new File:fhnd;

  new tmp2[MAX_STRING];
  new tmp_a[MAX_STRING];


  set(tmp_a,tmp2);strcat(tmp_a,".1.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_a,io_read);
	 fread(fhnd,tmpres);
	 fclose(fhnd);
  }

  set(tmp_a,tmp2);strcat(tmp_a,".2.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_a,io_read);
	 fread(fhnd,tmpres);
	 fclose(fhnd);
  }

  set(tmp_a,tmp2);strcat(tmp_a,".3.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_a,io_read);
	 fread(fhnd,tmpres);
	 fclose(fhnd);
  }
  StripNewLine(tmpres);
  if (tmpres[0]!=0) {
  new i;
  pwd_hash    = strval(strtok(tmpres,i,';'));
  planosaude    = strval(strtok(tmpres,i,';'));
  return true;
  }
  return false;
}