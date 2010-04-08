From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: L'\0' handling
Date: Thu, 08 Apr 2010 17:22:40 +0200
Message-ID: <4BBDF4C0.8020305@redhat.com>
References: <1270738799.2167.7.camel@yura-tl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758732Ab0DHPWn (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Apr 2010 11:22:43 -0400
In-Reply-To: <1270738799.2167.7.camel@yura-tl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: linux-sparse@vger.kernel.org

Hello,

Yura Pakhuchiy wrote:
> It looks like sparse do not understand constructions like L'\0'.
yepp, it doesn't. I have run into that problem 2 years ago. But for Wine
that is actually a "feature" as wide char/string literals are forbidden
aka cannot be used. Thus my interest in adding support for that in
sparse died.

bye
	michael

> 
> .-(~)------------------------------------------------------------(yura@yura-tl)-
> `--> cat b.c
> int main(void)
> {
> 	L'\0';
> 	return 0;
> }
> .-(~)------------------------------------------------------------(yura@yura-tl)-
> `--> gcc b.c
> .-(~)------------------------------------------------------------(yura@yura-tl)-
> `--> cgcc b.c
> b.c:3:10: error: Expected ; at end of statement
> b.c:3:10: error: got `\0'
> b.c:3:9: error: undefined identifier `L'
> 
> This causes problems with /usr/include/wchar.h
> and  /usr/include/bits/wchar.h includes from ubuntu.
> 
> /usr/include/bits/wchar.h:38:8: error: garbage at end: `\0' - 1 > 0
> 
> /usr/include/wchar.h:393:51: error: Expected ) in expression
> /usr/include/wchar.h:393:51: error: got `\0'
> 
> Relevant lines from these headers:
> 
> extern int __wctob_alias (wint_t __c) __asm ("wctob");
> __extern_inline int
> __NTH (wctob (wint_t __wc))
> { return (__builtin_constant_p (__wc) && __wc >= L'\0' && __wc <= L'\x7f'
> 	  ? (int) __wc : __wctob_alias (__wc)); }
> 
> and
> 
> #ifdef __WCHAR_UNSIGNED__
> #define __WCHAR_MIN       L'\0'
> 
> /* Failing that, rely on the preprocessor's knowledge of the
>    signedness of wchar_t.  */
> #elif L'\0' - 1 > 0
> #define __WCHAR_MIN       L'\0'
> #else
> #define __WCHAR_MIN       (-__WCHAR_MAX - 1)
> #endif
