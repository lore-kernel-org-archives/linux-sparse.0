From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Sat, 24 Jan 2015 00:59:35 +0100
Message-ID: <20150123235934.GA42931@macpro.local>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
 <20150123223856.GB1489@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:52556 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbbAWX7k (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Jan 2015 18:59:40 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so288424wes.2
        for <linux-sparse@vger.kernel.org>; Fri, 23 Jan 2015 15:59:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150123223856.GB1489@cloud>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@joshtriplett.org
Cc: Christopher Li <sparse@chrisli.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jan 23, 2015 at 02:38:56PM -0800, josh@joshtriplett.org wrote:
> On Fri, Jan 23, 2015 at 11:23:32PM +0100, Luc Van Oostenryck wrote:
> > On Fri, Jan 23, 2015 at 08:40:17AM -0800, Christopher Li wrote:
> > > I think sparse haven't implement the __COUNTER__ macro. That is why it emit the
> > > error on duplicate entry.
> > 
> > The following patch should fix that.
> [...]
> > Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> One issue below.
> 
> > --- a/pre-process.c
> > +++ b/pre-process.c
> > @@ -181,6 +181,10 @@ static int expand_one_symbol(struct token **list)
> >  			time(&t);
> >  		strftime(buffer, 9, "%T", localtime(&t));
> >  		replace_with_string(token, buffer);
> > +	} else if (token->ident == &__COUNTER___ident) {
> > +		static int counter;
> > +
> > +		replace_with_integer(token, counter++);
> 
> This should not use a static counter.  GCC and Sparse can run over more
> than one file in one invocation:
> 
> $ head test1.c test2.c
> ==> test1.c <==
> __COUNTER__
> __COUNTER__
> 
> ==> test2.c <==
> __COUNTER__
> __COUNTER__
> 
> $ gcc -E test1.c test2.c
> # 1 "test1.c"
> # 1 "<built-in>"
> # 1 "<command-line>"
> # 1 "/usr/include/stdc-predef.h" 1 3 4
> # 1 "<command-line>" 2
> # 1 "test1.c"
> 0
> 1
> # 1 "test2.c"
> # 1 "<built-in>"
> # 1 "<command-line>"
> # 1 "/usr/include/stdc-predef.h" 1 3 4
> # 1 "<command-line>" 2
> # 1 "test2.c"
> 0
> 1
> 
> Notice that the second file starts with __COUNTER__ at 0 again.
> 
> The counter *should* keep counting through include files, but needs to
> reset before starting a new top-level compile.
> 
> - Josh Triplett
> --

Yes, indeed.
Thanks for bringing to my attention.

Here is a new version of the patch taking care of that.


Luc

---
Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro.

This macro expands to sequential integral values starting from 0,
and this for each top-level source file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h                       |  1 +
 pre-process.c                      |  4 ++++
 validation/preprocessor/counter1.c | 12 ++++++++++++
 validation/preprocessor/counter2.c | 14 ++++++++++++++
 validation/preprocessor/counter2.h |  1 +
 validation/preprocessor/counter3.c | 13 +++++++++++++
 6 files changed, 45 insertions(+)
 create mode 100644 validation/preprocessor/counter1.c
 create mode 100644 validation/preprocessor/counter2.c
 create mode 100644 validation/preprocessor/counter2.h
 create mode 100644 validation/preprocessor/counter3.c

diff --git a/ident-list.h b/ident-list.h
index d5a145f8..b65b667d 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -108,6 +108,7 @@ __IDENT(__TIME___ident, "__TIME__", 0);
 __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
+__IDENT(__COUNTER___ident, "__COUNTER__", 0);
 
 /* Sparse commands */
 IDENT_RESERVED(__context__);
diff --git a/pre-process.c b/pre-process.c
index 1aa3d2c4..601e0f26 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -45,6 +45,7 @@
 #include "scope.h"
 
 static int false_nesting = 0;
+static int counter_macro;		// __COUNTER__ expansion
 
 #define INCLUDEPATHS 300
 const char *includepath[INCLUDEPATHS+1] = {
@@ -181,6 +182,8 @@ static int expand_one_symbol(struct token **list)
 			time(&t);
 		strftime(buffer, 9, "%T", localtime(&t));
 		replace_with_string(token, buffer);
+	} else if (token->ident == &__COUNTER___ident) {
+		replace_with_integer(token, counter_macro++);
 	}
 	return 1;
 }
@@ -1882,6 +1885,7 @@ static void init_preprocessor(void)
 		sym->normal = 0;
 	}
 
+	counter_macro = 0;
 }
 
 static void handle_preprocessor_line(struct stream *stream, struct token **line, struct token *start)
diff --git a/validation/preprocessor/counter1.c b/validation/preprocessor/counter1.c
new file mode 100644
index 00000000..98187ee6
--- /dev/null
+++ b/validation/preprocessor/counter1.c
@@ -0,0 +1,12 @@
+__COUNTER__
+__COUNTER__
+/*
+ * check-name: __COUNTER__ #1
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+0
+1
+ * check-output-end
+ */
diff --git a/validation/preprocessor/counter2.c b/validation/preprocessor/counter2.c
new file mode 100644
index 00000000..9883b682
--- /dev/null
+++ b/validation/preprocessor/counter2.c
@@ -0,0 +1,14 @@
+__FILE__ __COUNTER__
+#include <counter2.h>
+__FILE__ __COUNTER__
+/*
+ * check-name: __COUNTER__ #2
+ * check-command: sparse -Ipreprocessor -E $file
+ *
+ * check-output-start
+
+"preprocessor/counter2.c" 0
+"preprocessor/counter2.h" 1
+"preprocessor/counter2.c" 2
+ * check-output-end
+ */
diff --git a/validation/preprocessor/counter2.h b/validation/preprocessor/counter2.h
new file mode 100644
index 00000000..447b70ab
--- /dev/null
+++ b/validation/preprocessor/counter2.h
@@ -0,0 +1 @@
+__FILE__ __COUNTER__
diff --git a/validation/preprocessor/counter3.c b/validation/preprocessor/counter3.c
new file mode 100644
index 00000000..1449b2d1
--- /dev/null
+++ b/validation/preprocessor/counter3.c
@@ -0,0 +1,13 @@
+/*
+ * check-name: __COUNTER__ #3
+ * check-command: sparse -Ipreprocessor -E preprocessor/counter1.c preprocessor/counter2.c
+ *
+ * check-output-start
+
+0
+1
+"preprocessor/counter2.c" 0
+"preprocessor/counter2.h" 1
+"preprocessor/counter2.c" 2
+ * check-output-end
+ */
