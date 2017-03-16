From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 16:51:22 -0700
Message-ID: <CA+55aFzKqWTZBdDG+ecedw40HxEs0FezqJBuc=VRTvj1Bmps7Q@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <20170316211904.ac52l6nfag45v37z@macbook.local> <CA+55aFzD3K7XcXTwVqbY0sM5FirAprm7kMyOvP3x1S5uO2zSnQ@mail.gmail.com>
 <20170316231213.kv5yvkyguqmtqckw@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35326 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbdCPXvY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 19:51:24 -0400
Received: by mail-it0-f42.google.com with SMTP id m27so6565928iti.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 16:51:23 -0700 (PDT)
In-Reply-To: <20170316231213.kv5yvkyguqmtqckw@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 16, 2017 at 4:12 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> We can simply see these OP_ARG as a sort of pseudo-push instruction.

Exactly, that was my thinking. It might even show in the
test-linearize pseudo-code output as a "push".

              Linus
