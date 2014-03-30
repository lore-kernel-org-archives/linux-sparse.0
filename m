From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Use any previous initializer to size a symbol
Date: Sun, 30 Mar 2014 13:21:35 -0700
Message-ID: <CA+55aFz4mozGHRqV3YqkQEY5yqSrPSfVUbjPk7MNEt2ZBsvU_Q@mail.gmail.com>
References: <alpine.LFD.2.11.1403301020530.16374@i7.linux-foundation.org>
	<CA+55aFy=Y_xOBdQFdhgvadEpmSFp85FiPQZc8VTKBkDO=WLhgA@mail.gmail.com>
	<CANeU7Q=tSY-CVCv=+CB80C7w4e5RjR=4ZWKNM92raWvKd_rz6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:52039 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbaC3UVg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Mar 2014 16:21:36 -0400
Received: by mail-ve0-f171.google.com with SMTP id jy13so4428378veb.16
        for <linux-sparse@vger.kernel.org>; Sun, 30 Mar 2014 13:21:35 -0700 (PDT)
In-Reply-To: <CANeU7Q=tSY-CVCv=+CB80C7w4e5RjR=4ZWKNM92raWvKd_rz6g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 30, 2014 at 12:22 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> Possible. If I comment out that check, I will get this error in the
> extern-inline.c
> test case:
>
> $ ./sparse validation/extern-inline.c validation/extern-inline.c
> validation/extern-inline.c:12:1: warning: multiple definitions for function 'g'
> validation/extern-inline.c:12:1:  the previous one is here

Ok, I think that is just us being too anal. We should allow multiple
definitions for functions that are identical otherwise, but differ in
the "inline".

So I think that MOD_INLINE check in check_declaration() is wrong, and
makes us consider the definitions to be for different symbols. Yes,
that ignores the warning, but they really *aren't* different symbols.

So the correct thing to do is (I think) to remove that check, and then
make the parse_function_body() warning go away by accepting the fact
that we can have both an inline version and an out-of-line version of
the same function.

Hmm? I'm on my way out, so I'm not going to write that patch..

              Linus
