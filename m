From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: Sparse parsing question: string literal
Date: Sun, 20 Aug 2017 17:31:40 +0100
Message-ID: <28542583-07ad-55d2-5678-bf90f0570e17@knosof.co.uk>
References: <CACXZuxcvbCc+eOyqzrUUs4qkTpS705u065nc5=H8DLJ9AQnCEw@mail.gmail.com>
 <CANeU7Qkq60MA_ufvPsx6dXvr5ZW-kVaGmwVVQ8gQY1g=srZ1MA@mail.gmail.com>
 <ccf4cac2-003f-f856-28db-49dacae374b6@knosof.co.uk>
 <CANeU7QmGO7BCDFYhsBmpipB4TYPXWybd9txDOq9Fkw91HKHtug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from know-smtprelay-omc-8.server.virginmedia.net ([80.0.253.72]:49111
        "EHLO know-smtprelay-omc-8.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753118AbdHTQbo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 12:31:44 -0400
In-Reply-To: <CANeU7QmGO7BCDFYhsBmpipB4TYPXWybd9txDOq9Fkw91HKHtug@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

Christopher,

> Do you have any comment on sparse giving warning of:
> sizeof(function_name)?
> 
> The programmer usually mean sizeof(&function_name).
> But 729 said sizeof is such a special case the function degenerate
> into pointers does not work inside sizeof().
> 
> Should sparse give warning for sizeof(function_name) at all?

It's a question of intent.

sizeof(function_name) was written, but was
sizeof(function_name()) intended?

Of course sizeof(&function_name) may have been written, but
sizeof(&function_name()) was intended.  But that & is an
unusually thing to include in a function call, which makes it
less likely that () were accidentally omitted.

Is it reasonable to require people to add & to signal,
yes I really do mean pointer to function?  The indignity
if having to type that extra character!

I'm inclined towards generating warnings, since there is a
way of making the warning to go away, e.g., add & or ().

-- 
Derek M. Jones           Software analysis
tel: +44 (0)1252 520667  blog:shape-of-code.coding-guidelines.com
