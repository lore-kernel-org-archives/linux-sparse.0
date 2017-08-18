From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Fri, 18 Aug 2017 18:38:05 +0200
Message-ID: <CAExDi1RrKzNMXv=jNQXtviB=Aq5aHYJJfOsa34K_153-Z8gRew@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
 <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com>
 <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com>
 <CAExDi1TNbGgNkKqaPM0tgUof6m9hJVSR-XZaYbQO4QOPewFjzw@mail.gmail.com>
 <CACXZuxf0gQfdMqa6XLmcmnrzD9SzqefL5Aw9+AsuYqp8cC_HnQ@mail.gmail.com> <CANeU7QkGxD3g=kQkMHKNzagMA51moni0EHy_iazEDidQjEeZQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33187 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdHRQiG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 12:38:06 -0400
Received: by mail-oi0-f42.google.com with SMTP id f11so101848420oic.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 09:38:06 -0700 (PDT)
In-Reply-To: <CANeU7QkGxD3g=kQkMHKNzagMA51moni0EHy_iazEDidQjEeZQg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 6:18 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> I just realized another side effect of doing the SSA conversion on
> the AST directly. It means we will not have access to the linearization
> byte code before promoting the memory variable to pseudo.

Of course.
But consider the other side: it means that you already have already
a lot of variables promoted to pseudo *while* doing the linearization.
It means that you already can know quite a bit about the 'values'
during linearization and avoid to generate code that will be thrown
away soon after being created.

> Maybe later on we can consider an option to
> avoid doing the SSA conversion on memory variable as an option.

Sure, but it's a serious research topic too.
Lots can be done. A few things are easy and cheap, most are quite
complex and expensive.

-- Luc
