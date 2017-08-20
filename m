From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse parsing question: string literal
Date: Sun, 20 Aug 2017 14:25:48 -0400
Message-ID: <CANeU7QktQppCsNS4oqDwSg_7LiYFcVULxQqGrUCw6_=m6OZLWQ@mail.gmail.com>
References: <CACXZuxcvbCc+eOyqzrUUs4qkTpS705u065nc5=H8DLJ9AQnCEw@mail.gmail.com>
 <CANeU7Qkq60MA_ufvPsx6dXvr5ZW-kVaGmwVVQ8gQY1g=srZ1MA@mail.gmail.com>
 <ccf4cac2-003f-f856-28db-49dacae374b6@knosof.co.uk> <CANeU7QmGO7BCDFYhsBmpipB4TYPXWybd9txDOq9Fkw91HKHtug@mail.gmail.com>
 <28542583-07ad-55d2-5678-bf90f0570e17@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35846 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdHTSZt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 14:25:49 -0400
Received: by mail-yw0-f174.google.com with SMTP id o192so1816109ywd.3
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 11:25:49 -0700 (PDT)
In-Reply-To: <28542583-07ad-55d2-5678-bf90f0570e17@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 12:31 PM, Derek M Jones <derek@knosof.co.uk> wrote:
>
>
> It's a question of intent.
>
> sizeof(function_name) was written, but was
> sizeof(function_name()) intended?

The case I saw was for as part of the structure initialization.
It want to store the generic object and its size.
So it has { .... , function_name, sizeof(function_name), .... }
some thing like that.

For that usage I am pretty sure it is sizeof(&function_name).

But you are right the other way to guess the intend can be
sizeof(function_name()).


>
> Of course sizeof(&function_name) may have been written, but
> sizeof(&function_name()) was intended.  But that & is an
> unusually thing to include in a function call, which makes it
> less likely that () were accidentally omitted.
>
> Is it reasonable to require people to add & to signal,
> yes I really do mean pointer to function?  The indignity
> if having to type that extra character!
>
> I'm inclined towards generating warnings, since there is a
> way of making the warning to go away, e.g., add & or ().

OK, that make sense. The warning should stay.

Thanks

Chris
