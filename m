From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Fri, 18 Aug 2017 12:18:30 -0400
Message-ID: <CANeU7QkGxD3g=kQkMHKNzagMA51moni0EHy_iazEDidQjEeZQg@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
 <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com>
 <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com>
 <CAExDi1TNbGgNkKqaPM0tgUof6m9hJVSR-XZaYbQO4QOPewFjzw@mail.gmail.com> <CACXZuxf0gQfdMqa6XLmcmnrzD9SzqefL5Aw9+AsuYqp8cC_HnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34427 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdHRQSb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 12:18:31 -0400
Received: by mail-yw0-f171.google.com with SMTP id s143so61684096ywg.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 09:18:31 -0700 (PDT)
In-Reply-To: <CACXZuxf0gQfdMqa6XLmcmnrzD9SzqefL5Aw9+AsuYqp8cC_HnQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 3:28 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I will check at my end and revert with my thoughts.
>
> But I would have preferred if the SSA change was like for like
> initially - rather than introducing new breaking changes. That should
> ideally come as patches later on.

I just realized another side effect of doing the SSA conversion on
the AST directly. It means we will not have access to the linearization
byte code before promoting the memory variable to pseudo.

If you are depending on that pre-simplified byte code, then you don't
have a choice not do it. Maybe later on we can consider an option to
avoid doing the SSA conversion on memory variable as an option.

Chris
