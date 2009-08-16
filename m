From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sun, 16 Aug 2009 14:05:33 +0300
Message-ID: <1250420733.9535.1.camel@penberg-laptop>
References: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
	 <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
	 <1250367991.14751.1.camel@penberg-laptop> <20090815223602.GA4516@feather>
	 <1250406233.32343.9.camel@penberg-laptop>  <20090816105114.GA6489@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from courier.cs.helsinki.fi ([128.214.9.1]:36991 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZHPLFd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 16 Aug 2009 07:05:33 -0400
In-Reply-To: <20090816105114.GA6489@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org

Hi Josh,

On Sun, 2009-08-16 at 03:51 -0700, Josh Triplett wrote:
> On Sun, Aug 16, 2009 at 10:03:53AM +0300, Pekka Enberg wrote:
> > On Sat, 2009-08-15 at 15:36 -0700, Josh Triplett wrote:
> > > These defines need to have the right type suffixes.  GCC defines
> > > __LONG_LONG_MAX__ with an LL suffix, and __LONG_MAX__ with an L suffix.
> > > You could either add the appropriate suffixes, or better yet, stringize
> > > the constants and print them as strings.
> > 
> > Right. Is there a macro in sparse to do the stringification? I didn't
> > find one and the best I could come up is this.
> [...]
> > --- a/lib.c
> > +++ b/lib.c
> > @@ -788,6 +788,14 @@ void create_builtin_stream(void)
> >  		add_pre_buffer("#define __OPTIMIZE__ 1\n");
> >  	if (optimize_size)
> >  		add_pre_buffer("#define __OPTIMIZE_SIZE__ 1\n");
> > +
> > +	/* GCC defines these for limits.h */
> > +	add_pre_buffer("#weak_define __SHRT_MAX__ " STRINGIFY(__SHRT_MAX__) "\n");
> > +	add_pre_buffer("#weak_define __SCHAR_MAX__ " STRINGIFY(__SCHAR_MAX__) "\n");
> > +	add_pre_buffer("#weak_define __INT_MAX__ " STRINGIFY(__INT_MAX__) "\n");
> > +	add_pre_buffer("#weak_define __LONG_MAX__ " STRINGIFY(__LONG_MAX__) "\n");
> > +	add_pre_buffer("#weak_define __LONG_LONG_MAX__ " STRINGIFY(__LONG_LONG_MAX__) "\n");
> > +	add_pre_buffer("#weak_define __WCHAR_MAX__ " STRINGIFY(__WCHAR_MAX__) "\n");
> >  }
> >  
> >  static struct symbol_list *sparse_tokenstream(struct token *token)
> > diff --git a/lib.h b/lib.h
> > index b22fa93..62f7433 100644
> > --- a/lib.h
> > +++ b/lib.h
> > @@ -17,6 +17,9 @@
> >  #include "compat.h"
> >  #include "ptrlist.h"
> >  
> > +#define __STRINGIFY(x) #x
> > +#define STRINGIFY(x) __STRINGIFY(x)
> > +
> 
> This looks fine, with one minor nit: s/__STRINGIFY/STRINGIFY2/g or
> similar.  The C language reserves identifiers containing "__" (C99
> "7.1.3 Reserved identifiers").

Of course. Here's the final patch. *fingers crossed*

			Pekka

From 8894fa768ddc69f4c7d2160c67e080731aefb88e Mon Sep 17 00:00:00 2001
From: Pekka Enberg <penberg@cs.helsinki.fi>
Date: Sat, 15 Aug 2009 23:22:24 +0300
Subject: [PATCH] Define GCC builtin defines for limits.h

Sparse produces a bunch of warnings like this when compiling against
glibc:

  /usr/lib/gcc/i486-linux-gnu/4.3.2//include-fixed/limits.h:33:22: warning: undefined preprocessor identifier '__INT_MAX__'
  /usr/lib/gcc/i486-linux-gnu/4.3.2//include-fixed/limits.h:64:5: warning: undefined preprocessor identifier '__SHRT_MAX__'
  /usr/lib/gcc/i486-linux-gnu/4.3.2//include-fixed/limits.h:64:21: warning: undefined preprocessor identifier '__INT_MAX__'
  /usr/include/bits/xopen_lim.h:95:6: warning: undefined preprocessor identifier '__INT_MAX__'
  /usr/include/bits/xopen_lim.h:98:7: warning: undefined preprocessor identifier '__INT_MAX__'

Fix that up by adding some add_pre_buffer() calls to
create_builtin_define(). For future reference, GCC defines the builtins
in the c_cpp_builtins() function in gcc/c-cppbuiltin.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 lib.c |    8 ++++++++
 lib.h |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index 42affcd..fb7e9bc 100644
--- a/lib.c
+++ b/lib.c
@@ -788,6 +788,14 @@ void create_builtin_stream(void)
 		add_pre_buffer("#define __OPTIMIZE__ 1\n");
 	if (optimize_size)
 		add_pre_buffer("#define __OPTIMIZE_SIZE__ 1\n");
+
+	/* GCC defines these for limits.h */
+	add_pre_buffer("#weak_define __SHRT_MAX__ " STRINGIFY(__SHRT_MAX__) "\n");
+	add_pre_buffer("#weak_define __SCHAR_MAX__ " STRINGIFY(__SCHAR_MAX__) "\n");
+	add_pre_buffer("#weak_define __INT_MAX__ " STRINGIFY(__INT_MAX__) "\n");
+	add_pre_buffer("#weak_define __LONG_MAX__ " STRINGIFY(__LONG_MAX__) "\n");
+	add_pre_buffer("#weak_define __LONG_LONG_MAX__ " STRINGIFY(__LONG_LONG_MAX__) "\n");
+	add_pre_buffer("#weak_define __WCHAR_MAX__ " STRINGIFY(__WCHAR_MAX__) "\n");
 }
 
 static struct symbol_list *sparse_tokenstream(struct token *token)
diff --git a/lib.h b/lib.h
index b22fa93..25abb80 100644
--- a/lib.h
+++ b/lib.h
@@ -17,6 +17,9 @@
 #include "compat.h"
 #include "ptrlist.h"
 
+#define DO_STRINGIFY(x) #x
+#define STRINGIFY(x) DO_STRINGIFY(x)
+
 extern int verbose, optimize, optimize_size, preprocessing;
 extern int die_if_error;
 extern int repeat_phase, merge_phi_sources;
-- 
1.5.6.3



