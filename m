From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Fri, 11 Aug 2017 08:40:25 -0400
Message-ID: <CANeU7Q=q-37HBG0WjBq747SZkHaf7PbNY5h9KFeqQRzW+go-9A@mail.gmail.com>
References: <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com>
 <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
 <CACXZuxecqPvcnQ+3UbrPK8gbjns893gUNsOymbY6X+kinrVf3w@mail.gmail.com>
 <20170811114937.fqzgxdqcq64jlpgn@ltop.local> <CANeU7Qkzpdxc5vCdZT3Uc4Ajj1S7aL6sCR_21xBf1M1iDeSJHA@mail.gmail.com>
 <20170811123535.n2fulymfn6wq4zbk@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34049 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdHKMk1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 08:40:27 -0400
Received: by mail-yw0-f181.google.com with SMTP id s143so21457559ywg.1
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 05:40:26 -0700 (PDT)
In-Reply-To: <20170811123535.n2fulymfn6wq4zbk@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Fri, Aug 11, 2017 at 8:35 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Aug 11, 2017 at 08:00:50AM -0400, Christopher Li wrote:
>>
>> I think he means the push instruction is not in the bb->insns list.
>>
>> I agree with that view.
>
> But these instructions *are* in the bb->insns list.

If they are in the bb->insns, that is even worse in my book. It means
the back end processing the IR need to remember the state to match
up push into the calling arguments. The call instruction show up *after*
the push. You are forcing the back end to simulate a push stack to
properly process  the function call. When the back end see the
push instruction, they have noway of known the following call
will use varidic or not. The back end have to save the state to
wait for the call instruction.

You might just as well give call instruction a separate type list matching
the calling one. That at least don't show up as bb->insns.

I still want to explore Linus's first suggestion, give pseudo a type.
Using the OP_SETVAL, When I get a chance.

Chris
