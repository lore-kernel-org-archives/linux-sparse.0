From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Fri, 11 Aug 2017 11:28:23 +0100
Message-ID: <CACXZuxecqPvcnQ+3UbrPK8gbjns893gUNsOymbY6X+kinrVf3w@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com> <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:32927 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdHKK2Y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 06:28:24 -0400
Received: by mail-ua0-f182.google.com with SMTP id 80so13468382uas.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 03:28:23 -0700 (PDT)
In-Reply-To: <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

Hi Luc,

On 10 August 2017 at 23:34, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> * the OP_PUSH instructions do a perfect job of giving a type to functions
>   arguments
> * the OP_PUSH instructions also nicely abstract away the *operation* of
>   argument passing that all architectures have. It's a good thing.
>

It is true that OP_PUSH instructions resolved the issue I was having.
However there is something odd about them as they are not really
instructions in the instruction stream, are they? They get added as
arguments to the OP_CALL instruction. The solution works great though.

Regards
Dibyendu
