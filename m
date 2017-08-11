From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Fri, 11 Aug 2017 14:35:36 +0200
Message-ID: <20170811123535.n2fulymfn6wq4zbk@ltop.local>
References: <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com>
 <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
 <CACXZuxecqPvcnQ+3UbrPK8gbjns893gUNsOymbY6X+kinrVf3w@mail.gmail.com>
 <20170811114937.fqzgxdqcq64jlpgn@ltop.local>
 <CANeU7Qkzpdxc5vCdZT3Uc4Ajj1S7aL6sCR_21xBf1M1iDeSJHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37748 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdHKMfk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 08:35:40 -0400
Received: by mail-wm0-f53.google.com with SMTP id i66so46300138wmg.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 05:35:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qkzpdxc5vCdZT3Uc4Ajj1S7aL6sCR_21xBf1M1iDeSJHA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Fri, Aug 11, 2017 at 08:00:50AM -0400, Christopher Li wrote:
> 
> I think he means the push instruction is not in the bb->insns list.
> 
> I agree with that view.

But these instructions *are* in the bb->insns list.

-- Luc
