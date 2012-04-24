From: Konrad Eisele <konrad@gaisler.com>
Subject: dependency tee from c parser entities downto token
Date: Tue, 24 Apr 2012 11:54:45 +0200
Message-ID: <4F967865.60809@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail175c2.megamailservers.com ([69.49.111.75]:39612 "EHLO
	mail175c2.megamailservers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752649Ab2DXMAF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 24 Apr 2012 08:00:05 -0400
Received: from [192.168.0.37] (gaisler.se [92.33.28.242])
	(authenticated bits=0)
	by mail175c2.megamailservers.com (8.13.6/8.13.1) with ESMTP id q3OA4V25031573
	for <linux-sparse@vger.kernel.org>; Tue, 24 Apr 2012 06:04:33 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi, I'd like to extend sparse so that I can preserve a
dependency tree that goes from c parse entities all
the way down to single tokens. There are several places
this can be useful:
  1. If you have :
    "#include <stdio.h> int main() {}"
    and add for instance
    "#include <stdio.h> int main() {FILE *f;}"
    what are the macros and structs that are used for this single "FILE *f;"?
    (With macros and all #ifdef nesting macros dependencies and their dependendies
     and macros in macro arg/body substitutions and also macros in c parse entities
     that FILE (struct _IO_FILE) c-depends on)
  2. If you have a compilation with a fixed options-line, calculate
    a minimal c sourcefile that is "pre pre-processor" that compiles correctly.
    This would save time in compilation, stripping away all unneeded
    macros defines and declarations.
  3. You could also use it to write tools to show the
    dependency tree of macros at a particular location of the source...
    something all c-coders long for (at least me :-).

For case (1.) I have created a dirty prototype that on sourceforge
does this

$git clone git://git.code.sf.net/p/decpp/code decpp
$cd decpp
$make
$./shrinkc t1.c

The output is below ("output of "shrinkc"").

Before I start to submit patches I'd like to as weather
there is there is interest for such a development, or better
weather there is interest of such a development if I do
the work, as maybe you rather want to do it yourself, I
also first ask because otherwise I'll put time in it
and none will apply the patches in the end anyway.

Here is how i'd do it:

- Try to not mess with basic structs like "struct token" etc.
   by adding a little hash based attibute tagging to void * pointers
   so that additional information can be stored for each sparse
   entity in seperate stuctures.
- modify pre-processor.c to not overwrite already created  tokens
   but instead duplicate them. Of course also avoid freeing tokens.
   Also preserve the undef/define history of macros (by not reusing
   the macro symbols)
- Buildup the macro dependency tree created from macros expansion
   and #if statements
- Tag all tokens with extra informations: macro dependency as well
   as source-stream end location (to be able to reconstruct).
- write a traversal that descends from translation-units through the
   dependency tree down to the tokens and marks them as used. Or maybe
   downto a "used-char" bitfield in streams.

Opon that, useful tools (as I think) could be built up.

-- Konrad



============= output of "shrinkc" ===============

eiselekd+~/tmp/>shrinkc t1.c

********* builtin *********


********* preprocessor *********


********* t1.c *********

int main(int argc, char **argv) {
         FILE *f;
};

********* preprocessor *********


********* /usr/include/stdio.h *********

#ifndef _STDIO_H
#if !defined __need_FILE && !defined __need___FILE
# define _STDIO_H       1
# define __need_FILE
# define __need___FILE
#endif /* Don't need FILE.  */
#if !defined __FILE_defined && defined __need_FILE
struct _IO_FILE;
typedef struct _IO_FILE FILE;
#endif /* FILE not defined.  */
#if !defined ____FILE_defined && defined __need___FILE
typedef struct _IO_FILE __FILE;
#endif /* __FILE not defined.  */
#ifdef  _STDIO_H

********* /usr/include/features.h *********


********* /usr/include/sys/cdefs.h *********


********* /usr/include/bits/wordsize.h *********


********* /usr/include/gnu/stubs.h *********


********* /usr/include/bits/wordsize.h *********


********* /usr/include/gnu/stubs-32.h *********


********* /usr/lib/gcc/i486-slackware-linux/4.2.4//include/stddef.h *********

#endif
#endif

********* /usr/include/bits/types.h *********


********* /usr/include/bits/wordsize.h *********


********* /usr/include/bits/typesizes.h *********


********* /usr/include/libio.h *********

#ifndef _IO_STDIO_H
#ifdef _G_NEED_STDARG_H
#endif
# else
struct _IO_jump_t;  struct _IO_FILE;
# else
#else
typedef void _IO_lock_t;
#endif
struct _IO_marker {
   struct _IO_marker *_next;
   struct _IO_FILE *_sbuf;
   int _pos;
};
enum __codecvt_result
{
   __codecvt_ok,
   __codecvt_partial,
   __codecvt_error,
   __codecvt_noconv
};
struct _IO_FILE {
   int _flags;           /* High-order word is _IO_MAGIC; rest is flags. */
   char* _IO_read_ptr;   /* Current read pointer */
   char* _IO_read_end;   /* End of get area. */
   char* _IO_read_base;  /* Start of putback+get area. */
   char* _IO_write_base; /* Start of put area. */
   char* _IO_write_ptr;  /* Current put pointer. */
   char* _IO_write_end;  /* End of put area. */
   char* _IO_buf_base;   /* Start of reserve area. */
   char* _IO_buf_end;    /* End of reserve area. */
   char *_IO_save_base; /* Pointer to start of non-current get area. */
   char *_IO_backup_base;  /* Pointer to first valid character of backup area */
   char *_IO_save_end; /* Pointer to end of non-current get area. */
   struct _IO_marker *_markers;
   struct _IO_FILE *_chain;
   int _fileno;
#if 0
#else
   int _flags2;
#endif
   _IO_off_t _old_offset; /* This used to be _offset but it's too small.  */
   unsigned short _cur_column;
   signed char _vtable_offset;
   char _shortbuf[1];
   _IO_lock_t *_lock;
#if defined _G_IO_IO_FILE_VERSION && _G_IO_IO_FILE_VERSION == 0x20001
   _IO_off64_t _offset;
# if defined _LIBC || defined _GLIBCPP_USE_WCHAR_T
# else
   void *__pad1;
   void *__pad2;
   void *__pad3;
   void *__pad4;
   size_t __pad5;
# endif
   int _mode;
   char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];
#endif
};
#endif /* _IO_STDIO_H */

********* /usr/include/_G_config.h *********

#ifndef _G_config_h
#define __need_mbstate_t
typedef struct
{
   __off_t __pos;
   __mbstate_t __state;
} _G_fpos_t;
typedef struct
{
   __off64_t __pos;
   __mbstate_t __state;
} _G_fpos64_t;
#define _G_off_t        __off_t
#define _G_off64_t      __off64_t
typedef int _G_int16_t __attribute__ ((__mode__ (__HI__)));
typedef int _G_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int _G_uint16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int _G_uint32_t __attribute__ ((__mode__ (__SI__)));
#define _G_NEED_STDARG_H 1
#define _G_IO_IO_FILE_VERSION 0x20001

********* /usr/lib/gcc/i486-slackware-linux/4.2.4//include/stddef.h *********

#endif
#endif
#endif
#endif /* defined(_ANSI_H_) || defined(_MACHINE_ANSI_H_) */
#endif /* _STDDEF_H or __need_size_t.  */
#endif

********* /usr/include/wchar.h *********

#ifndef _WCHAR_H
#if defined _WCHAR_H || defined __need_wint_t || !defined __WINT_TYPE__
# define __need_wint_t
#if (defined _WCHAR_H || defined __need_mbstate_t) && !defined __mbstate_t_defined
typedef struct
{
   int __count;
   union
   {
# ifdef __WINT_TYPE__
     __WINT_TYPE__ __wch;
# else
# endif
     char __wchb[4];
   } __value;            /* Value so far.  */
} __mbstate_t;
#endif
#endif /* ISO C99 or GCC and GNU.  */
#endif /* GCC and use GNU.  */
#endif /* Use ISO C95, C99 and Unix98. */
#endif
#endif
#endif  /* _WCHAR_H defined */
#endif /* wchar.h  */

********* /usr/lib/gcc/i486-slackware-linux/4.2.4//include/stddef.h *********

#endif
#endif
#endif
#endif /* defined(_ANSI_H_) || defined(_MACHINE_ANSI_H_) */
#endif /* _STDDEF_H or __need_size_t.  */
#endif
#endif
#endif /* __WCHAR_T__ */
#endif /* __wchar_t__ */
#endif /* _STDDEF_H or __need_wchar_t.  */
#if defined (__need_wint_t)
#ifndef _WINT_T
#ifndef __WINT_TYPE__
#define __WINT_TYPE__ unsigned int
#endif
typedef __WINT_TYPE__ wint_t;
#endif
#endif
#endif /* __sys_stdtypes_h */

********* /usr/lib/gcc/i486-slackware-linux/4.2.4//include/stdarg.h *********

#ifndef _STDARG_H
#ifndef _ANSI_STDARG_H_
#ifndef __GNUC_VA_LIST
typedef __builtin_va_list __gnuc_va_list;
#endif
#else /* not __svr4__ || _SCO_DS */
#endif
#endif /* not _VA_LIST_, except on certain systems */
#endif /* not __svr4__ */
#endif /* _STDARG_H */
#endif /* not _ANSI_STDARG_H_ */
#endif /* not _STDARG_H */

********* /usr/include/bits/stdio_lim.h *********


********* /usr/include/bits/sys_errlist.h *********
