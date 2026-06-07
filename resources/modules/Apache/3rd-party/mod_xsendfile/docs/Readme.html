<!DOCTYPE html>
<html>
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
  <title>mod_xsendfile for Apache2</title>
  <meta content="Nils Maier" name="author" />
  <style media="all" type="text/css">
  html, body {
    background: white;
    font-family: sans-serif;
    padding: 0;
    margin: 0;
  }
  article {
    max-width: 900px;
    margin: 0px;
    margin-left: auto;
    margin-right: auto;
    padding: 2em;
    padding-top: 1ex;
    box-shadow: 0px 0px 30px darkgray;
  }
  h1, h2, h3, h4, h5, h6 {
    font-family: "Trebuchet MS","Andale Mono",sans-serif;
    text-shadow: 1px 1px 1px lightgray;
  }
  h1, h2 {
    border-bottom: 1px solid black;
  }
  pre,
  .code,
  table.directive {
    border: 1px solid gray;
    padding: 1ex;
    text-align: left;
    width: 80%;
  }
  .table.directive th {
    width: 15%;
  }
  pre {
    background-color: #333333;
    color: white;
  }
  .remark {
    color: red;
    background: lightyellow;
    padding: 1ex;
    border-radius: 1ex;
  }
  </style>
</head>
<body>
  <article>
    <header>
      <h1>mod_xsendfile for Apache2</h1>
    </header>

    <section>
      <h2>Overview</h2>

      <p>mod_xsendfile is a small Apache2 module that
      processes X-SENDFILE headers output handlers might have registered.</p>

      <p>If it encounters the presence of such header it will discard all output and send the file specified by that header instead using Apache internals including all optimizations like caching-headers and sendfile or mmap if configured.</p>

      <p>It is useful for processing script-output of e.g. php, perl, python or
      any *cgi.</p>

      <h2>Useful?</h2>

      <p>Yep, it is useful.</p>

      <ul>
        <li>Some applications require checking for special privileges.</li>
        <li>Other have to lookup values first (e.g.. from a DB) in order to correctly process a download request.</li>
        <li>Or store values (download-counters come into mind).</li>
        <li>etc.</li>
      </ul>

      <h3>Benefits</h3>
      <ul>
        <li>Uses apache internals</li>
        <li>Optimal delivery through sendfile and mmap (if available).</li>
        <li>Sets correct cache headers such as Etag and If-Modified-Since as if the file was statically served.</li>
        <li>Processes cache headers such as If-None-Match or If-Modified-Since.</li> 
        <li>Support for ranges.</li>
      </ul>
    </section>

    <section>
      <h2>Installation</h2>
      <ol>
        <li>Grab the source.</li>
        <li>Compile and install
          <ul>
            <li>In general:<br/>
            <code>apxs -cia mod_xsendfile.c</code></li>
            <li>Debian/Ubuntu uses apxs2:<br/>
            <code>apxs2 -cia mod_xsendfile.c</code></li>
            <li>Mac users might want to build fat binaries:<br/>
            <code>apxs -cia -Wc,"-arch i386 -arch x86_64" -Wl,"-arch i386 -arch x86_64" mod_xsendfile.c</code></li>
          </ul>
        </li>
        <li>Restart apache</li>
        <li>That's all.</li>
      </ol>
    </section>

    <section>
      <h2>Configuration</h2>

      <h3>Headers</h3>
      <ul>
        <li><code>X-SENDFILE</code> - Send the file referenced by this headers instead of the current response body</li>
        <li><code>X-SENDFILE-TEMPORARY</code> - Like <code>X-SENDFILE</code>, but the file will be deleted afterwards. The file must originate from a path that has the <code>AllowFileDelete</code> flag set.</li>
      </ul>

      <h3>XSendFile</h3>

      <table class="code directive">
        <tbody>
          <tr>
            <th>Description</th>
            <td>Enables or disables header processing</td>
          </tr>
          <tr>
            <th>Syntax</th>
            <td>XSendFile on|off</td>
          </tr>
          <tr>
            <th>Default</th>
            <td>XSendFile off</td>
          </tr>
          <tr>
            <th>Context</th>
            <td>server config, virtual host, directory, .htaccess</td>
          </tr>
        </tbody>
      </table>

      <p>Setting <code>XSendFile on</code> will enable processing.</p>

      <p>The file specified in <code>X-SENDFILE</code> header will be sent instead of the handler output.</p>

      <p>The value (file name) given by the header is assmumed to be url-encoded, i.e. unescaping/url-decoding will be performed. See <a href="#XSendFileUnescape">XSendFileUnescape</a>.<br/>
      If you happen to store files using already url-encoded file names, you must "double" encode the names... <code>%20 -&gt; %2520</code></p>

      <p>If the response lacks the <code>X-SENDFILE</code> header the module will not perform any processing.</p>

      <h3>XSendFileIgnoreEtag</h3>

      <table class="code directive">
        <tbody>
          <tr>
            <th>Description</th>
            <td>Ignore script provided Etag headers</td>
          </tr>
          <tr>
            <th>Syntax</th>
            <td>XSendFileIgnoreEtag on|off</td>
          </tr>
          <tr>
            <th>Default</th>
            <td>XSendFileIgnoreEtag off</td>
          </tr>
          <tr>
            <th>Context</th>
            <td>server config, virtual host, directory, .htaccess</td>
          </tr>
        </tbody>
      </table>

      <p>Setting <code>XSendFileIgnoreEtag on</code> will ignore all ETag headers the original output handler may have set.<br/>
      This is helpful for applications that will generate such headers even for empty content.</p>

      <h3>XSendFileIgnoreLastModified</h3>

      <table class="code directive">
        <tbody>
          <tr>
            <th>Description</th>
            <td>Ignore script provided LastModified headers</td>
          </tr>
          <tr>
            <th>Syntax</th>
            <td>XSendFileIgnoreLastModified on|off</td>
          </tr>
          <tr>
            <th>Default</th>
            <td>XSendFileIgnoreLastModified off</td>
          </tr>
          <tr>
            <th>Context</th>
            <td>server config, virtual host, directory, .htaccess</td>
          </tr>
        </tbody>
      </table>

      <p>Setting <code>XSendFileIgnoreLastModified on</code> will ignore all Last-Modified headers the original output handler may have set.<br/>
      This is helpful for applications that will generate such headers even for empty content.</p>

      <h3 id="XSendFileUnescape">XSendFileUnescape</h3>

      <table class="code directive">
        <tbody>
          <tr>
            <th>Description</th>
            <td>Unescape/url-decode the value of the header</td>
          </tr>
          <tr>
            <th>Syntax</th>
            <td>XSendFileUnescape on|off</td>
          </tr>
          <tr>
            <th>Default</th>
            <td>XSendFileUnescape on</td>
          </tr>
          <tr>
            <th>Context</th>
            <td>server config, virtual host, directory, .htaccess</td>
          </tr>
        </tbody>
      </table>

      <p>Setting <code>XSendFileUnescape off</code> will restore the pre-1.0 behavior of using the raw header value, instead of trying to unescape/url-decode first.<br/>
      Headers may only contain a certain ASCII subset, as dictated by the corresponding RFCs/protocol. Hence you should escape/url-encode (and have XSendFile unescape/url-decode) the header value. Failing to keep within the bounds of that ASCII subset might cause errors, depending on your application framework.<p>
      <p>Hence this setting is meant only for backwards-compatibility with legacy applications expecting the old behavior; new applications should url-encode the value correctly and leave <code>XSendFileUnescape on</code>. Of course, if your paths are always ASCII, then (usually) no special encoding is required.</p>

      <h3>XSendFilePath</h3>

      <table class="code directive">
        <tbody>
          <tr>
            <th>Description</th>
          <td>White-list more paths</td>
          </tr>
          <tr>
            <th>Syntax</th>
            <td>XSendFilePath <code>&lt;absolute path&gt;</code> [<code>AllowFileDelete</code>]</td>
          </tr>
          <tr>
            <th>Default</th>
            <td>None</td>
          </tr>
          <tr>
            <th>Context</th>
            <td>server config, virtual host, directory</td>
          </tr>
        </tbody>
      </table>

      <p>XSendFilePath allow you to add additional paths to some kind of white list. All files within these paths are allowed to get served through mod_xsendfile.</p>
      <p>Provide an absolute path as Parameter to this directive.</p>
      <p>If the optional <code>AllowFileDelete</code> flag is specified, then files under this path can be served using the <code>X-SENDFILE-TEMPORARY</code> header, and will then be deleted once the file is delievered.
      Hence you should only set the <code>AllowFileDelete</code> flag for paths that do not hold any files that shouldn't be deleted!</p>
      <p>You may provide more than one path.<p>
      <h4>Remarks - Relative paths</h4>
      <p>The current working directory (if it can be determined) will be always checked first.</p>
      <p>If you provide relative paths via the X-SendFile header, then all whitelist items will be checked until a seamingly valid combination is found, i.e. the result is within the bounds of the whitelist item; it isn't checked at this point if the path in question actually exists.<br/>
      Considering you whitelisted <code>/tmp/pool</code> and <code>/tmp/pool2</code> and your script working directory is <code>/var/www</code>.</p>
      <p><code>X-SendFile: file</code></p>
      <ol>
        <li><code>/var/www/file</code> - Within bounds of <code>/var/www</code>, OK</li>
      </ol>
      <p><code>X-SendFile: ../pool2/file</code></p>
      <ol>
        <li><code>/var/www/../pool2/file = /var/pool2/file</code> - Not within bounds of <code>/var/www</code></li>
        <li><code>/tmp/pool/../pool2/file = /tmp/pool2/file</code> - Not within bounds of <code>/tmp/pool</code></li>
        <li><code>/tmp/pool2/../pool2/file = /tmp/pool2/file</code> - Within bounds of <code>/tmp/pool2</code>, OK</li>  
      </ol>
      <p>You still can only access paths that are whitelisted. However you have might expect a different behavior here, hence the documentation.</p>
      <p class="remark"><strong>Please note:</strong> It is recommended to always use absolute paths.</p>

      <h4>Remarks - Inheritance</h4>
      <p>The white list "inherits" entries from higher level configuration.<br/>
      <pre class="code">XSendFilePath /tmp
&lt;VirtualHost *&gt;
  ServerName someserver
  XSendFilePath /home/userxyz
&lt;/VirtualHost&gt;
&lt;VirtualHost *&gt;
  ServerName anotherserver
  XSendFilePath /var/www/somesite/
  &lt;Directory /var/www/somesite/fastcgis&gt;
    XSendFilePath /var/www/shared
  &lt;/Directory&gt;
&lt;/VirtualHost&gt;</pre>
      <p>Above example will give:</code>
      <ul>
        <li>*<ul>
          <li><code>/tmp</code></li>
        </ul></li>
        <li>someserver<ul>
          <li><code>/tmp</code></li>
          <li><code>/home/userxyz</code></li>
        </ul></li>
        <li>another<ul>
          <li><code>/tmp</code></li>
          <li><code>/var/www/somesite</code></li>
          <li><code>/var/www/shared</code> (for scripts* located in /var/www/somesite/fastcgis)</li>
        </ul></li>
      </ul>
      <p style="font-size:small;">*) Scripts, in this context, mean the actual script-starters. E.g. PHP as a handler will use the .php itself, while in CGI mode refers to the starter.</p>
      <p class="remark"><em>Windows</em> users must include the drive letter to those paths as well. Tests show that it has to be in upper-case.</p>

      <h3>Example</h3>

      <p><code>.htaccess</code></p>

      <pre>&lt;Files out.php&gt;
XSendFile on
&lt;/Files&gt;</pre>

      <p><code>out.php</code></p>

      <p class="code"><code><span style="color: rgb(0, 0, 0);"><span style="color: rgb(0, 0, 187);">&lt;?php<br />

      </span><span style="color: rgb(0, 119, 0);">...<br />

      if&nbsp;(</span><span style="color: rgb(0, 0, 187);">$user</span><span style="color: rgb(0, 119, 0);">-&gt;</span><span style="color: rgb(0, 0, 187);">isLoggedIn</span><span style="color: rgb(0, 119, 0);">())<br />

      {<br />

      &nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color: rgb(0, 0, 187);">header</span><span style="color: rgb(0, 119, 0);">(</span><span style="color: rgb(221, 0, 0);">"X-Sendfile:&nbsp;$path_to_somefile"</span><span style="color: rgb(0, 119, 0);">);<br />

      &nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color: rgb(0, 0, 187);">header</span><span style="color: rgb(0, 119, 0);">(</span><span style="color: rgb(221, 0, 0);">"Content-Type:&nbsp;application/octet-stream"</span><span style="color: rgb(0, 119, 0);">);<br />

      &nbsp;&nbsp;&nbsp;&nbsp;</span><span style="color: rgb(0, 0, 187);">header</span><span style="color: rgb(0, 119, 0);">(</span><span style="color: rgb(221, 0, 0);">"Content-Disposition:&nbsp;attachment;&nbsp;filename=\"$somefile\""</span><span style="color: rgb(0, 119, 0);">);<br />

      &nbsp;&nbsp;&nbsp;&nbsp;exit;<br />

      }<br />

      </span><span style="color: rgb(0, 0, 187);">?&gt;<br />

      </span>&lt;h1&gt;Permission&nbsp;denied&lt;/h1&gt;<br />

      &lt;p&gt;Login&nbsp;first!&lt;/p&gt;</span></code></p>

      <h2>Limitations / Issues / Security considerations</h2>

      <ul>

        <li>The <code>Content-Encoding</code>
      header - if present - will be dropped, as the module
      cannot know if it was set by intention of the programmer or the
      handler. E.g. php with output compression enabled will set this header,
      but the replacement file send via mod_xsendfile is most likely not
      compressed.</li>

        <li>The header (X-SENDFILE) is not case-sensitive.</li>

        <li class="remark"><strong>X-Sendfile will also happily send files that are otherwise protected (e.g. Deny from all).</strong><br>
      </ul>
    </section>

    <section>
      <h2>Credits</h2>

      <p>The idea comes from <a href="http://www.lighttpd.net/">lighttpd</a>
      - <span style="font-style: italic;">A fast web server
      with minimal memory footprint</span>.</p>

      <p>The module itself was inspired by many other Apache2 modules
      such as mod_rewrite, mod_headers and obviously core.c.</p>

      <h2>License</h2>

      <p><strong>Copyright 2006-2012 by Nils Maier</strong></p>

      <p>Licensed under the <em>Apache License, Version 2.0</em> (the "License"); you may not use this file except in compliance with the License.</p>

      <p>You may obtain a copy of the License at<br />
      <a href="http://www.apache.org/licenses/LICENSE-2.0">http://www.apache.org/licenses/LICENSE-2.0</a></p>

      <p>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.</p>

      <p> See the License for the specific language governing permissions and
      limitations under the License.</p>

      <h2 id="changes">Changes</h2>
      <h3>Version 1.0</h3>
      <ul>
        <li>Unescape/url-decode header value to support non-ascii file names</li>
        <li><code>XSendFileUnescape</code> setting, to support legacy applications</li>
        <li><code>X-SENDFILE-TEMPORARY</code> header and corresponding <code>AllowFileDelete</code> flag</li>
        <li>Fix: Actually look into the backend-provided headers for Last-Modified</li>
      </ul>
      <h3>Version 0.12</h3>
      <ul>
        <li>Now incorrect headers will be dropped early</li>
      </ul>
      <h3>Version 0.11.1</h3>
      <ul>
        <li>Fixed some documentation bugs</li>
        <li>Built win32 binaries against latest httpd using MSVC9</li>
        <li>Updated MSVC Project files</li>
      </ul>
      <h3>Version 0.11</h3>
      <ul>
        <li>Fixed large file support</li>
      </ul>
      <h3>Version 0.10</h3>
      <ul>
        <li>Won't override Etag/Last-Modified if already set.</li>
        <li>New Configuration directive: XSendFileIgnoreEtag</li>
        <li>New Configuration directive: XSendFileIgnoreLastModified</li>
        <li>New Configuration directive: XSendFilePath</li>
        <li>Removed Configuration directive: XSendFileAllowAbove<br/>
        Use XSendFilePath instead.</li>
        <li>Improved header handling for FastCGI/CGI output (removing duplicate headers).</li>
      </ul>
      <h3>Version 0.9</h3>
      <ul>
        <li>New configuration directive: XSendFileAllowAbove</li>
        <li>Initial FastCGI/CGI support</li>
        <li>Filter only added when needed</li>
      </ul>
      <h3>Version 0.8</h3>
      <ul>
        <li>This is the initial public release.</li>
      </ul>
    </section>
  </article>
</body>
</html>
