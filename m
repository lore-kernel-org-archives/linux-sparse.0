From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] Use any previous initializer to size a symbol
Date: Sun, 30 Mar 2014 12:22:26 -0700
Message-ID: <CANeU7Q=tSY-CVCv=+CB80C7w4e5RjR=4ZWKNM92raWvKd_rz6g@mail.gmail.com>
References: <alpine.LFD.2.11.1403301020530.16374@i7.linux-foundation.org>
	<CA+55aFy=Y_xOBdQFdhgvadEpmSFp85FiPQZc8VTKBkDO=WLhgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:61841 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbaC3TW1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Mar 2014 15:22:27 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so7949863qcr.25
        for <linux-sparse@vger.kernel.org>; Sun, 30 Mar 2014 12:22:26 -0700 (PDT)
In-Reply-To: <CA+55aFy=Y_xOBdQFdhgvadEpmSFp85FiPQZc8VTKBkDO=WLhgA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 30, 2014 at 11:38 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> The reason seems to be that our logic in check_declaration[] is
> broken: it only ties things together based on both symbols having
> 'extern'. So the actual declaration with an initializer, that lacks
> the extern (but is in global scope) is missed.
>
> The attached patch would seem to fix it. Chris, what is the reason for
> that MOD_INLINE check? You added it in commit 8cf99394ee4c ("move
> extern inline function to file scope") and I suspect it messes up the
> same_symbol logic. But I left it alone, and added a comment. If you

Possible. If I comment out that check, I will get this error in the
extern-inline.c
test case:

$ ./sparse validation/extern-inline.c validation/extern-inline.c
validation/extern-inline.c:12:1: warning: multiple definitions for function 'g'
validation/extern-inline.c:12:1:  the previous one is here
$

Unfortunately I have to run now, I will take a closer look when I am back
tonight. I verify that applying your second patch did not trigger the error
in extern-inline.c.

I think it is possible the fix for the extern-inline.c is wrong regarding the
same_symbol chain, there should be better way to fix it. I need to spend
more time on it though.

> can resolve that comment, please apply this patch with my sign-off and
> some random commit message..

Sure

Chris
