From: Konrad Eisele <konrad@gaisler.com>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 04 May 2012 09:33:09 +0200
Message-ID: <4FA38635.5060300@gaisler.com>
References: <4F967865.60809@gaisler.com> <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail202c2.megamailservers.com ([69.49.111.103]:56586 "EHLO
	mail202c2.megamailservers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751535Ab2EDHnO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 03:43:14 -0400
In-Reply-To: <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <eiselekd@gmail.com>, linux-sparse@vger.kernel.org

Christopher Li wrote:
> On Wed, May 2, 2012 at 12:27 AM, Konrad Eisele<eiselekd@gmail.com>  wrote:
>> But this is the point. All macros are expanded. They disappear completely in
>> the pre-processing step. There is no tool at all right now that
>> preserves the macro-dependency. Even in IDEs like Eclipse you have tools to show
>> macros expansions, but you have no tool to show you in a simple
>> way for i.e.:
>> #define a
>> #ifdef a
>> #define b 1
>> #endif
>> that "#define b 1" is dependent of "#define a" even the "#ifdef a" is
>> lost and you have to deduce it yourself from the #line comments.
>
> Sure, so the usage case is mostly for people to understand how
> the macro get expanded.

Yes, and in a human readable way, that is, the output is from
before the pre-procesing step. Otherwise it is meaningless.

>
>> The information for this is in "struct macro_expansion" of the patch and one can
>> build aroung it a trace of the macro expansion. I've done that with a patch for
>> gcc and could do it for sparse also. A example is at:
>> http://cfw.sourceforge.net/htmltag/init_32.c.pinfo.html
>> source at : http://cfw.sourceforge.net/htmltags.html
>> i.e. go in init_32.c.pinfo.html to mark_rodata_ro() and click on
>> virt_to_page (). A help in in the left pannel.
>
> I agree this is useful. However I feel the original patch is a bit invasive.
> How about do it in a step by step way. Make a small patch to allow register
> call backs when the macro expands. That way the application using sparse
> get notify of the pre-processor macro expands. I can take a look at how to
> implement this small patch as well.
>
> If needed, we can make one option that pre-processor don't free the tokens.
> In this case, very few changes in the caller side. I feel it cleaner
> than changing
> the free function behavior.

The minimum original-code-base change that I see would be:
  - "struct position <pos>" is removed in all structures except "struct token" and
    replaced with "struct token *<tok>". When <pos> is needed <tok>->pos is
    used instead. This implies that tokens are not freed by default.
  - struct statement *, struct expression *, struct *token
    all get a extra "void *custom" pointer. This pointer can be used for
    tools to save their own data.
I think this is not too far off: 4 bytes more for each struct and  "<tok>->pos"
instead of "pos", that is not a massive change. the <tok>->pos would be
a boilerplate refactoring.

Should I implemnt a patch for that as a first step?

After that I can build upon that.

-- Konrad

Ps: I post again the link for my "shrinkc" app. I think
it is very impressive. I never had en overview about stdlib.h
and could see for that first time the dependencies for i.e.
FILE *f. Ok the ouput is still raw, "#include" lines are missing,
but still you can really see what is going on. And frankly,
isnt it strange that all c-programmers use stdlib.h without
really knowing what is going on? Maybe I am the only one that
has no clue though...
$git clone git://git.code.sf.net/p/decpp/code decpp
$cd decpp
$make
$./shrinkc t1.c



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


>
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

