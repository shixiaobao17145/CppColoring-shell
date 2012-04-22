<span class="preprocessor">#include</span> &lt;iostream&gt;
<span class="preprocessor">#include</span> &lt;vector&gt;
<span class="preprocessor">#include</span> &lt;stack&gt;

<span class="keyword">using</span> namespace std;
<span class="comment">/* c style comment  */</span> haha <span class="comment">/**/</span> xixi <span class="comment">/*   */</span> en <span class="comment">/*/*/</span> append <span class="comment">/* haha */</span> what? <span class="comment">/* haha */</span>
<span class="quote">"124"</span> asdf <span class="quote">""</span> haha <span class="quote">"asd\""</span> asd <span class="quote">"\" asdf"</span> gewg <span class="quote">"\\"</span> fef <span class="quote">"\\\\\""</span> qertq <span class="quote">"asdfas\\\\\""</span> qwetqwe  <span class="quote">"asdfas\\\\\" fa"</span>

<span class="comment">//path: an absolute path <span class="keyword">for</span> a file (Unix-style)</span>
string SimplifyPath(string path) 
{
    path.push_back(<span class="character">'/'</span>);<span class="comment">//make sure the last path would be push to stack</span>
    stack&lt;size_t&gt; iStack; <span class="comment">//index of each directory in the path</span>
    size_t pos = 0; <span class="comment">//position <span class="keyword">for</span> next directory to append</span>
    iStack.push(pos);

    <span class="comment">//since the path is absolute, the first character would always be <span class="character">'/'</span> </span>
    <span class="keyword">for</span> (int i = 1; i &lt; path.size(); ++i)
    {
        char c = path[i];
        <span class="keyword">if</span> (c != <span class="character">'/'</span>)
        {
            path[++pos] =c;
            <span class="keyword">continue</span>;
        }

        <span class="keyword">if</span>(path[i-1] == <span class="character">'/'</span>) <span class="keyword">continue</span>;
        
        path[++pos] = c;<span class="comment">// c == <span class="character">'/'</span></span>
        int dir = iStack.top();
        <span class="keyword">if</span> (path[dir+1]  == <span class="character">'.'</span>)
            <span class="keyword">switch</span> (path[dir+2])
            {
                <span class="comment">//stay in current directory</span>
                <span class="keyword">case</span> <span class="character">'/'</span>: pos = dir; <span class="keyword">break</span>;
                    
                <span class="keyword">case</span> <span class="character">'.'</span>:
                    <span class="keyword">if</span> (path[dir+3] != <span class="character">'/'</span>) <span class="comment">//hiden file</span>
                        iStack.push(pos);
                    <span class="keyword">else</span>
                    {
                        <span class="comment">//back to the position of previous directory</span>
                        <span class="keyword">if</span>(iStack.size() &gt; 1) iStack.pop();
                        pos = iStack.top();
                    }
                    <span class="keyword">break</span>;
                    
                <span class="keyword">default</span>: <span class="comment">//hiden file</span>
                    iStack.push(pos);
                    <span class="keyword">break</span>;
            }
        <span class="keyword">else</span> <span class="comment">//simple directory</span>
            iStack.push(pos);
    }

    <span class="keyword">if</span> (pos == 0)pos = pos+1; <span class="comment">//the path is back to the root</span>
    
    path.erase(pos);
    <span class="keyword">return</span> path;
}

int main(int argc, char** argv)
{
    string s = <span class="quote">"/home/../.."</span>;
    cout &lt;&lt; s &lt;&lt; <span class="quote">" =&gt; "</span> &lt;&lt; SimplifyPath(s) &lt;&lt; endl;
    s = <span class="quote">"/a/./.b/../../c/"</span>;
    cout &lt;&lt; s &lt;&lt; <span class="quote">" =&gt; "</span> &lt;&lt; SimplifyPath(s) &lt;&lt; endl;
    s = <span class="quote">"/home/of/foo/../../bar/../../is/./here/."</span>;
    cout &lt;&lt; s &lt;&lt; <span class="quote">" =&gt; "</span> &lt;&lt; SimplifyPath(s) &lt;&lt; endl;
/**
 
 /home/../.. =&gt; /
 /a/./.b/../../c/ =&gt; /c
 /home/of/foo/../../bar/../../is/./here/. =&gt; /is/here

 **/
    
    
    <span class="keyword">return</span> 0;
}