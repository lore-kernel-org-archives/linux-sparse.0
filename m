From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Fri, 11 Aug 2017 14:45:41 +0200
Message-ID: <20170811124540.ronpgzifgif4wklj@ltop.local>
References: <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com>
 <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
 <CACXZuxecqPvcnQ+3UbrPK8gbjns893gUNsOymbY6X+kinrVf3w@mail.gmail.com>
 <20170811114937.fqzgxdqcq64jlpgn@ltop.local>
 <CANeU7Qkzpdxc5vCdZT3Uc4Ajj1S7aL6sCR_21xBf1M1iDeSJHA@mail.gmail.com>
 <20170811123535.n2fulymfn6wq4zbk@ltop.local>
 <CANeU7Q=q-37HBG0WjBq747SZkHaf7PbNY5h9KFeqQRzW+go-9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37268 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbdHKMpo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 08:45:44 -0400
Received: by mail-wm0-f46.google.com with SMTP id i66so46513965wmg.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 05:45:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=q-37HBG0WjBq747SZkHaf7PbNY5h9KFeqQRzW+go-9A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Fri, Aug 11, 2017 at 08:40:25AM -0400, Christopher Li wrote:
> On Fri, Aug 11, 2017 at 8:35 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Fri, Aug 11, 2017 at 08:00:50AM -0400, Christopher Li wrote:
> >>
> >> I think he means the push instruction is not in the bb->insns list.
> >>
> >> I agree with that view.
> >
> > But these instructions *are* in the bb->insns list.
> 
> If they are in the bb->insns, that is even worse in my book. It means
> the back end processing the IR need to remember the state to match
> up push into the calling arguments. The call instruction show up *after*
> the push.

Yes. Calling conventions are often like this.
isn't the opposite direction somehow less meaningful?

> You are forcing the back end to simulate a push stack to
> properly process  the function call.

That's not true.  Look at the LLVM backend.

-- Luc
