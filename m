From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sat, 15 Aug 2009 23:26:31 +0300
Message-ID: <1250367991.14751.1.camel@penberg-laptop>
References: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
	 <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from courier.cs.helsinki.fi ([128.214.9.1]:35922 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbZHOU0c (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 15 Aug 2009 16:26:32 -0400
In-Reply-To: <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, torvalds@linux-foundation.org

Hi Chris,

On Sat, 2009-08-15 at 12:36 -0700, Christopher Li wrote:
> On Sat, Aug 15, 2009 at 7:57 AM, Pekka Enberg<penberg@cs.helsinki.fi> wrote:
> > +       } else if (token->ident == &__SHRT_MAX__ident) {
> > +               replace_with_integer(token, __SHRT_MAX__);
> > +       } else if (token->ident == &__SCHAR_MAX__ident) {
> > +               replace_with_integer(token, __SCHAR_MAX__);
> > +       } else if (token->ident == &__INT_MAX__ident) {
> > +               replace_with_integer(token, __INT_MAX__);
> > +       } else if (token->ident == &__LONG_MAX__ident) {
> > +               replace_with_integer(token, __LONG_MAX__);
> > +       } else if (token->ident == &__LONG_LONG_MAX__ident) {
> > +               replace_with_long_long(token, __LONG_LONG_MAX__);
> > +       } else if (token->ident == &__WCHAR_MAX__ident) {
> > +               replace_with_integer(token, __WCHAR_MAX__);
> 
> 
> I am pretty sure that is not the way to do it in sparse.  If you just want
> add some sparse builtin defines, it is much better to add them in
> create_builtin_streams(). It would be even better to group them in a new
> function create_builtin_define():
> 
> Some thing like:
> 
> add_pre_buffer("#weak_define __INT_MAX__ %d\n", __INT_MAX__);

Oh, right, makes sense. I am a total sparse newbie so does something
like this look better (works fine for me)?

			Pekka

From 8e19ea98138dd43a5482519fec6f7488422aff30 Mon Sep 17 00:00:00 2001
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
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index 42affcd..0510ae0 100644
--- a/lib.c
+++ b/lib.c
@@ -788,6 +788,14 @@ void create_builtin_stream(void)
 		add_pre_buffer("#define __OPTIMIZE__ 1\n");
 	if (optimize_size)
 		add_pre_buffer("#define __OPTIMIZE_SIZE__ 1\n");
+
+	/* GCC defines these for limits.h */
+	add_pre_buffer("#weak_define __SHRT_MAX__ %d\n", __SHRT_MAX__);
+	add_pre_buffer("#weak_define __SCHAR_MAX__ %d\n", __SCHAR_MAX__);
+	add_pre_buffer("#weak_define __INT_MAX__ %d\n", __INT_MAX__);
+	add_pre_buffer("#weak_define __LONG_MAX__ %ld\n", __LONG_MAX__);
+	add_pre_buffer("#weak_define __LONG_LONG_MAX__ %lld\n", __LONG_LONG_MAX__);
+	add_pre_buffer("#weak_define __WCHAR_MAX__ %d\n", __WCHAR_MAX__);
 }
 
 static struct symbol_list *sparse_tokenstream(struct token *token)
-- 
1.5.6.3



