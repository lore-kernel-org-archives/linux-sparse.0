From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] avoid infinite loop during simplification
Date: Sat, 12 Aug 2017 16:50:32 +0200
Message-ID: <CAExDi1S+uqc2EU_O6+UF7hUXY8Ade7-7-YV_jucLx1cTYiZ5dQ@mail.gmail.com>
References: <20170812125525.34044-1-luc.vanoostenryck@gmail.com>
 <CANeU7QmjFd17UTFGSe_FOR+0jTn+azzaHvwq_FtG6sSGL1sx+Q@mail.gmail.com>
 <CAExDi1RZ9v_5TFvcAOF2JkPWJYD_awt9uqga8tSvgzpmoaHrWQ@mail.gmail.com> <CANeU7QnU+_h-1si+ROWuVqLSG3pTbrzbso0Ck-21ru=q62UsNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35165 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdHLOuc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 10:50:32 -0400
Received: by mail-oi0-f46.google.com with SMTP id e124so55042361oig.2
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 07:50:32 -0700 (PDT)
In-Reply-To: <CANeU7QnU+_h-1si+ROWuVqLSG3pTbrzbso0Ck-21ru=q62UsNg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 4:31 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> I think we need to draw the line some where.
>
> Now RC5 is out. The merge window is closed.
> It is not critical to have it.

Certainly.

> If  there is serious bug cause
> RC6 then we can merge this in as well.
>
> Otherwise I would say hold on to after the release.

That's very fine for me.

> Let's get this 0.5.1 release out.

I'm all in favor of that.

-- Luc
