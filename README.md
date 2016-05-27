# Getting-and-Cleaning-Data


###Pre-requisite libraries
<ul>
<li>  reshape2</li>
<li>  knitr</li>
<li>  markdown</li>
</ul>
To **reproduce** the results copy the *run_analysis.R* and *codeBook.Rmd* files in your working directory and run the script. Using following code.

<pre class="r"><code class="r"><span class="identifier"><span class="identifier">source</span></span><span class="paren"><span class="paren">(</span></span><span class="identifier"><span class="identifier">"run_analysis.R"</span></span><span class="paren"><span class="paren"></span></span><span class="paren"><span class="paren">)</span></span></code></pre>

A codebook is provided to deliver information about the transformations used to clean the data. Variable descriptions are the same as provided in the original dataset.Any change in the variable names is mentioned in the codeBook.md file. Also, how the *run_analysis.R* is working is explained there. Open the following file to view the codebook.

<pre>codebook.md</pre>

Result will be a tidy dataset stored in **"ActivityRecognitionUsingSmartphones.txt"** which will be in working directory. Use the following code to read the Tidy data created.

<pre class="r"><code class="r"><span class="identifier">Tidydata</span><span class="operator">&lt;-</span><span class="identifier">read.table</span><span class="paren">(</span><span class="string">"ActivityRecognitionUsingSmartphones.txt"</span>,<span class="identifier">header</span> <span class="operator">=</span> <span class="literal">TRUE</span><span class="paren">)</span>
<span class="identifier">head</span><span class="paren">(</span><span class="identifier">Tidydata</span><span class="paren">)</span></code></pre>

CodeBook will also be generated in the working directory as *codebook.md*. One can open **codebook.html** file to view the codebook for the tidy dataset.
