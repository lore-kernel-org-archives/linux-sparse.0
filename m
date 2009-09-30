From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Handle __builtin_ms_va_list.
Date: Wed, 30 Sep 2009 23:34:56 +0200
Message-ID: <20090930213456.GA502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbZI3Vex (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Sep 2009 17:34:53 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8ULYv2G009467
	for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2009 17:34:58 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.32.0.1])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8ULYvX7006174
	for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2009 17:34:57 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

For Win64 compiles Wine does
 #ifndef __ms_va_list
 # if defined(__x86_64__) && defined (__GNUC__)
 #  define __ms_va_list __builtin_ms_va_list
 #  define __ms_va_start(list,arg) __builtin_ms_va_start(list,arg)
 #  define __ms_va_end(list) __builtin_ms_va_end(list)
 # else

Wouldn't be as bad if sparse cannot handle those but it trips over
WINBASEAPI DWORD WINAPI FormatMessageA(DWORD,LPCVOID,DWORD,DWORD,LPSTR,DWORD,__ms_va_list*);
WINBASEAPI DWORD WINAPI FormatMessageW(DWORD,LPCVOID,DWORD,DWORD,LPWSTR,DWORD,__ms_va_list*);
producing this errors for basically every file:
wine/include/winbase.h:1546:96: error: Expected ) in function declarator
wine/include/winbase.h:1546:96: error: got *
wine/include/winbase.h:1547:97: error: Expected ) in function declarator
wine/include/winbase.h:1547:97: error: got *

Signed-off-by: Michael Stefaniuc <mstefaniuc@gmail.com>
---
 lib.c   |    2 ++
 parse.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index 622b547..cf00c8b 100644
--- a/lib.c
+++ b/lib.c
@@ -794,11 +794,13 @@ void create_builtin_stream(void)
 
 	add_pre_buffer("#define __builtin_stdarg_start(a,b) ((a) = (__builtin_va_list)(&(b)))\n");
 	add_pre_buffer("#define __builtin_va_start(a,b) ((a) = (__builtin_va_list)(&(b)))\n");
+	add_pre_buffer("#define __builtin_ms_va_start(a,b) ((a) = (__builtin_ms_va_list)(&(b)))\n");
 	add_pre_buffer("#define __builtin_va_arg(arg,type)  ({ type __va_arg_ret = *(type *)(arg); arg += sizeof(type); __va_arg_ret; })\n");
 	add_pre_buffer("#define __builtin_va_alist (*(void *)0)\n");
 	add_pre_buffer("#define __builtin_va_arg_incr(x) ((x) + 1)\n");
 	add_pre_buffer("#define __builtin_va_copy(dest, src) ({ dest = src; (void)0; })\n");
 	add_pre_buffer("#define __builtin_va_end(arg)\n");
+	add_pre_buffer("#define __builtin_ms_va_end(arg)\n");
 
 	/* FIXME! We need to do these as special magic macros at expansion time! */
 	add_pre_buffer("#define __BASE_FILE__ \"base_file.c\"\n");
diff --git a/parse.c b/parse.c
index c3f9b6a..6ab2ac4 100644
--- a/parse.c
+++ b/parse.c
@@ -391,6 +391,7 @@ static struct init_keyword {
 
 	/* Predeclared types */
 	{ "__builtin_va_list", NS_TYPEDEF, .type = &ptr_ctype, .op = &spec_op },
+	{ "__builtin_ms_va_list", NS_TYPEDEF, .type = &ptr_ctype, .op = &spec_op },
 	{ "__int128_t",	NS_TYPEDEF, .type = &lllong_ctype, .op = &spec_op },
 	{ "__uint128_t",NS_TYPEDEF, .type = &ulllong_ctype, .op = &spec_op },
 
-- 
1.6.5.rc2
