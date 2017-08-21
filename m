From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix expansion of constant bitfield dereference
Date: Mon, 21 Aug 2017 12:46:00 -0400
Message-ID: <CANeU7QkWUDxpmm2ZsAdNsa4OsP3xGUhyJfRaZYRRoWU_2orghQ@mail.gmail.com>
References: <20170820221602.27852-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=HgV-H0yRZ60n1A0uo79z+0F6mQEVxN8PQhQ_RQnB2NQ@mail.gmail.com>
 <CAMHZB6HJWjTycs9xm_j4WU+aF1W9mb4+9wTTNid-OdZDkUEigw@mail.gmail.com>
 <CANeU7Q=K4r4QSH0k6YCFadsDs5YN0+xt9As2F7XVxJNnddzOQw@mail.gmail.com> <CAMHZB6FaVescSVFrZK4x_=47Rs_zF=WNbgbSWhjgHhqUK9FXEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36582 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbdHUQqC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 12:46:02 -0400
Received: by mail-yw0-f180.google.com with SMTP id y64so9966712ywf.3
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 09:46:01 -0700 (PDT)
In-Reply-To: <CAMHZB6FaVescSVFrZK4x_=47Rs_zF=WNbgbSWhjgHhqUK9FXEw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Mon, Aug 21, 2017 at 12:14 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 21, 2017 at 6:06 PM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> I am referenitng to your email reply to Dibyendu:
>>
>> ===========================
>> It's a very surprising bug. It's not a linearization or
>> an optimization bug as the AST is already wrong.
>> With a simpler test case, like:
>>         struct s {
>>                 char a:4;
>>                 char b:4;
>>         };
>>
>>         int foo(void)
>>         {
>>                 struct s x = { .a = 2, .b = 4 };
>>
>>                 return x.b;
>>         }
>>
>> you can see that the linearization produce correct
>> code for the initializer.
>> You can also see that the return statement to be
>> linearized is something like
>>         STMT_RETURN
>>                 ret_value: EXPR_VALUE (value = 2)
>
>
> It's precisely this bug that this patch fixes.

Oh, I see. I misunderstand what bug the patch fix.
Let me go back to read it again.

Sorry about that.

Thanks for the explain.

Chris
