#include <a_samp>

/*
native CriarLog(const File[]);
native EscreverLog(const File[], string[]);
native DeletarLog(const File[]);
native LerLog(const File[]);
*/

stock CriarLog(const File[])
{
    if(fexist(File))
    {
        printf("Utilize EscreverLog(\"arquivo\", \"Mensagem\"); para escrever em um log existente.");
        return 0;
    }
    new File:Arquivo = fopen(File, io_write);
	fclose(Arquivo);
    return 1;
}

stock EscreverLog(const File[], string[])
{
    if(!fexist(File))
    {
        printf("Utilize CriarLog(\"arquivo\"); para criar o Log e escrever nele.");
        return 0;
    }
    new celulas[ 300 ];
    new a, m, d, h, mi, s;
    getdate(a, m, d);
	gettime(h,mi,s);
	format(celulas, sizeof(celulas), "(%d/%d/%d)[%02d:%02d:%d] %s\r\n",d,m,a,h,mi,s, string);
    new File:Arquivo = fopen(File, io_append);
	fwrite(Arquivo, celulas);
	fclose(Arquivo);
    return 1;
}

stock DeletarLog(const File[])
{
    if(!fexist(File))
    {
        printf("Esse arquivo não existe, utilize CriarLog(\"arquivo\"");
        return 0;
    }
    fremove(File);
    return 1;
}

stock LerLog(const File[])
{
    if(!fexist(File))
    {
        printf("Esse arquivo não existe, utilize CriarLog(\"arquivo\"");
        return 0;
    }
    new string[100];
    new File:Arquivo = fopen(File, io_read);
    while(fread(Arquivo, string))
    {
        printf("[ %s ] %s", File, string);
        return 1;
    }
    fclose(Arquivo);
    return 1;
}
