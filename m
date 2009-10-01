From: Christopher Li <sparse@chrisli.org>
Subject: Re: Handle __builtin_ms_va_list.
Date: Thu, 1 Oct 2009 11:41:57 -0700
Message-ID: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>
References: <20090930213456.GA502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f192.google.com ([209.85.212.192]:45939 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbZJASlx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 1 Oct 2009 14:41:53 -0400
Received: by vws30 with SMTP id 30so220258vws.21
        for <linux-sparse@vger.kernel.org>; Thu, 01 Oct 2009 11:41:57 -0700 (PDT)
In-Reply-To: <20090930213456.GA502@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Sep 30, 2009 at 2:34 PM, Michael Stefaniuc <mstefani@redhat.com=
> wrote:
> For Win64 compiles Wine does
> =A0#ifndef __ms_va_list
> =A0# if defined(__x86_64__) && defined (__GNUC__)
> =A0# =A0define __ms_va_list __builtin_ms_va_list
> =A0# =A0define __ms_va_start(list,arg) __builtin_ms_va_start(list,arg=
)
> =A0# =A0define __ms_va_end(list) __builtin_ms_va_end(list)
> =A0# else
>
> Wouldn't be as bad if sparse cannot handle those but it trips over
> WINBASEAPI DWORD WINAPI FormatMessageA(DWORD,LPCVOID,DWORD,DWORD,LPST=
R,DWORD,__ms_va_list*);
> WINBASEAPI DWORD WINAPI FormatMessageW(DWORD,LPCVOID,DWORD,DWORD,LPWS=
TR,DWORD,__ms_va_list*);
> producing this errors for basically every file:
> wine/include/winbase.h:1546:96: error: Expected ) in function declara=
tor
> wine/include/winbase.h:1546:96: error: got *
> wine/include/winbase.h:1547:97: error: Expected ) in function declara=
tor
> wine/include/winbase.h:1547:97: error: got *

Applied.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
