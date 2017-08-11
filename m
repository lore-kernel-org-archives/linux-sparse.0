From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Fri, 11 Aug 2017 14:39:51 +0200
Message-ID: <20170811123950.jncvpczj3vpavctk@ltop.local>
References: <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com>
 <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
 <CACXZuxecqPvcnQ+3UbrPK8gbjns893gUNsOymbY6X+kinrVf3w@mail.gmail.com>
 <20170811114937.fqzgxdqcq64jlpgn@ltop.local>
 <CACXZuxcytdnZjcjf-d0cMCeXLxSA_m66RO1G+dkpMqX81tVB1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36673 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbdHKMjy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 08:39:54 -0400
Received: by mail-wm0-f46.google.com with SMTP id t201so40873054wmt.1
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 05:39:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcytdnZjcjf-d0cMCeXLxSA_m66RO1G+dkpMqX81tVB1A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Fri, Aug 11, 2017 at 01:20:38PM +0100, Dibyendu Majumdar wrote:
> 
> I was mistaken - I think they do appear in the instruction stream.

Yes, they are in bb->insns.

> I thought they didn't because we kind of ignore them - and only look at
> them as part of the OP_CALL arguments.

Well, it depends what we do with them. For the LLVM front-end,
indeed they don't correspond to an LLVM instruction.
For other situations they are or will be used more directly.

-- Luc
