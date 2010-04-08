From: Yura Pakhuchiy <pakhuchiy@gmail.com>
Subject: L'\0' handling
Date: Thu, 08 Apr 2010 17:59:59 +0300
Message-ID: <1270738799.2167.7.camel@yura-tl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:36736 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab0DHPAC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Apr 2010 11:00:02 -0400
Received: by bwz1 with SMTP id 1so1855916bwz.21
        for <linux-sparse@vger.kernel.org>; Thu, 08 Apr 2010 08:00:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

It looks like sparse do not understand constructions like L'\0'.

.-(~)------------------------------------------------------------(yura@yura-tl)-
`--> cat b.c
int main(void)
{
	L'\0';
	return 0;
}
.-(~)------------------------------------------------------------(yura@yura-tl)-
`--> gcc b.c
.-(~)------------------------------------------------------------(yura@yura-tl)-
`--> cgcc b.c
b.c:3:10: error: Expected ; at end of statement
b.c:3:10: error: got `\0'
b.c:3:9: error: undefined identifier `L'

This causes problems with /usr/include/wchar.h
and  /usr/include/bits/wchar.h includes from ubuntu.

/usr/include/bits/wchar.h:38:8: error: garbage at end: `\0' - 1 > 0

/usr/include/wchar.h:393:51: error: Expected ) in expression
/usr/include/wchar.h:393:51: error: got `\0'

Relevant lines from these headers:

extern int __wctob_alias (wint_t __c) __asm ("wctob");
__extern_inline int
__NTH (wctob (wint_t __wc))
{ return (__builtin_constant_p (__wc) && __wc >= L'\0' && __wc <= L'\x7f'
	  ? (int) __wc : __wctob_alias (__wc)); }

and

#ifdef __WCHAR_UNSIGNED__
#define __WCHAR_MIN       L'\0'

/* Failing that, rely on the preprocessor's knowledge of the
   signedness of wchar_t.  */
#elif L'\0' - 1 > 0
#define __WCHAR_MIN       L'\0'
#else
#define __WCHAR_MIN       (-__WCHAR_MAX - 1)
#endif


-- 
Best regards,
        Yura

