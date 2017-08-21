From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix expansion of constant bitfield dereference
Date: Mon, 21 Aug 2017 12:06:37 -0400
Message-ID: <CANeU7Q=K4r4QSH0k6YCFadsDs5YN0+xt9As2F7XVxJNnddzOQw@mail.gmail.com>
References: <20170820221602.27852-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=HgV-H0yRZ60n1A0uo79z+0F6mQEVxN8PQhQ_RQnB2NQ@mail.gmail.com> <CAMHZB6HJWjTycs9xm_j4WU+aF1W9mb4+9wTTNid-OdZDkUEigw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33578 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbdHUQGi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 12:06:38 -0400
Received: by mail-yw0-f172.google.com with SMTP id h127so25541849ywf.0
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 09:06:38 -0700 (PDT)
In-Reply-To: <CAMHZB6HJWjTycs9xm_j4WU+aF1W9mb4+9wTTNid-OdZDkUEigw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Mon, Aug 21, 2017 at 9:42 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 21, 2017 at 2:26 PM, Christopher Li <sparse@chrisli.org> wrote:
>> On Sun, Aug 20, 2017 at 6:16 PM, Luc Van Oostenryck wrote:
>>
>> With this applied, sparse still have a bug at did not match the
>> value to the bit field member, right? I saw on the other email
>> thread said the value always pick offset zero.
>
> I'm not sure to understand.
> Have you an example?

I am referenitng to your email reply to Dibyendu:

===========================
It's a very surprising bug. It's not a linearization or
an optimization bug as the AST is already wrong.
With a simpler test case, like:
        struct s {
                char a:4;
                char b:4;
        };

        int foo(void)
        {
                struct s x = { .a = 2, .b = 4 };

                return x.b;
        }

you can see that the linearization produce correct
code for the initializer.
You can also see that the return statement to be
linearized is something like
        STMT_RETURN
                ret_value: EXPR_VALUE (value = 2)

===========================


>
> Wait for the pull request, please.
>

Sure. Glad that I asked :-)
>
> Well ..., if we have an EXPR_FVALUE which type is a bitfield, yes
> for sure there would be a bug. But I have no reason to belive there
> is such bug and since checking the ctype is more costly than checking
> the expr->type, I think it's best so.
>
> Note, I find this check already annoying and hackish if not worse.
>

Yes, from your other email said there is a bug some where else
in sparse yet. (the text I quote you).

Chris
