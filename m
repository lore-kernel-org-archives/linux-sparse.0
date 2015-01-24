From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Sat, 24 Jan 2015 12:27:06 +0100
Message-ID: <20150124112705.GA47109@macpro.local>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
 <20150123223856.GB1489@cloud>
 <20150123235934.GA42931@macpro.local>
 <20150124012958.GB28468@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:47403 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbbAXL1K (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 24 Jan 2015 06:27:10 -0500
Received: by mail-we0-f169.google.com with SMTP id u56so1754805wes.0
        for <linux-sparse@vger.kernel.org>; Sat, 24 Jan 2015 03:27:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150124012958.GB28468@thin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Sam Ravnborg <sam@ravnborg.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jan 23, 2015 at 05:29:58PM -0800, Josh Triplett wrote:
> On Sat, Jan 24, 2015 at 12:59:35AM +0100, Luc Van Oostenryck wrote:
> > Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro.
> > 
> > This macro expands to sequential integral values starting from 0,
> > and this for each top-level source file.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> counter3.c seems like a bit of an abuse of the test suite framework, but
> I don't have a better suggestion.
> 
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Yes, I know ...

Would the following change to the test-suite (introducing tags to separate input sections)
and the corresponding test be more OK ?


Luc

diff --git a/validation/test-suite b/validation/test-suite
index df5a7c60..97d4dd40 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -102,6 +102,15 @@ do_test()
 	fi
 	test_name=$last_result
 
+	# grab the input sections
+	input_nr=1
+	while grep -q "input-file-$input_nr-start" "$file"; do
+		sed -n "/input-file-$input_nr-start/,/input-file-$input_nr-end/p" "$file" \
+			| grep -v input-file > "$file".input$input_nr
+		eval "file$input_nr=$file.input$input_nr"
+		input_nr=$(($input_nr + 1))
+	done
+
 	# does the test provide a specific command ?
 	cmd=`eval echo $default_path/$default_cmd`
 	get_value "check-command" $file
diff --git a/Documentation/test-suite b/Documentation/test-suite
index 6c4f24f6..34b38696 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -32,6 +32,10 @@ check-output-start / check-output-end (optional)
 check-known-to-fail (optional)
 	Mark the test as being known to fail.
 
+input-file-1-start / input-file-1-end, / input-file-2-start / ... (optional)
+	The input files of check-command lies between those tags.
+	It's only needed when the test needs several distincts input files.
+
 
 	Using test-suite
 	~~~~~~~~~~~~~~~~
@@ -58,6 +62,9 @@ name:
 cmd:
 	check-command value. If no cmd is provided, it defaults to
 	"sparse $file".
+	If the "input-file-1-start/..." tags are used those files are to be
+	referenced with "$file1", ... and the command need to be something like:
+	"sparse $file1 $file2"
 
 The output of the test-suite format command can be redirected into the
 test case to create a test-suite formated file.
diff --git a/validation/preprocessor/counter3.c b/validation/preprocessor/counter3.c
index e69de29b..76635e82 100644
--- a/validation/preprocessor/counter3.c
+++ b/validation/preprocessor/counter3.c
@@ -0,0 +1,20 @@
+/* input-file-1-start */
+__COUNTER__
+__COUNTER__
+/* input-file-1-end */
+
+/* input-file-2-start */
+__COUNTER__
+/* input-file-2-end */
+
+/*
+ * check-name: __COUNTER__ #3
+ * check-command: sparse -E $file1 $file2
+ *
+ * check-output-start
+
+0
+1
+0
+ * check-output-end
+ */
