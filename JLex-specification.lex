import java.io.*;

class A2 {
    public static void main(String [] args) throws java.io.IOException {
        int temp[] = {0, 0, 0, 0, 0};
        MyLexer2 lexer = new MyLexer2(new BufferedReader(new FileReader("input.txt")));
        Token t;
        while ((t = lexer.yylex()) != null) {
            temp[t.getPosition()]++;
        }
        BufferedWriter out = new BufferedWriter(new FileWriter("output.txt"));
        
        out.write("identifiers :" + temp[0] + "\nkeywords: " + temp[1] + "\nnumbers: " + temp[2] + "\ncomments: " + temp[3] + "\nquotedString: " + temp[4]);
        out.flush();
    }
}

class Token {
    int position;
    String text;
    String line;
    Token(int position, String t, String l){this.position=position; text = t; line=l; }
    public int getPosition(){
        return position;
    }
}

%%

        %line
        %type Token
        %class MyLexer2
%eofval{ return null;
        %eofval}

        KEYWORD = MAIN|IF|END|READ|WRITE|RETURN|BEGIN|INT|REAL|STRING
        IDENTIFIER = [a-zA-Z][a-zA-Z0-9]*
        COMMENT = /\*([^*]|(\*+([^*/])))*\*+/
        NUMBER = [0-9\.]+[0-9]+
        QUOTEDSTRING = (\"([^\"]|\"\")*\")

        %%
        {KEYWORD} {return(new Token(1, yytext(), "KY"));}
        {NUMBER} {return (new Token(2, yytext(), "NM"));}
        {COMMENT} { return(new Token(3, yytext(), "CM"));}
        {QUOTEDSTRING} { return(new Token(4, yytext(), "QS"));}
        {IDENTIFIER} {return(new Token(0, yytext(), "ID"));}
        \r|\n {}
        . {}
