From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC v0 0/4] Give a type to constants, considered harmful
Date: Sun, 12 Mar 2017 21:30:41 +0100
Message-ID: <20170312203040.erc4n2iollen2274@macpro.local>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36211 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934692AbdCLUaq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 16:30:46 -0400
Received: by mail-wr0-f195.google.com with SMTP id l37so17794465wrc.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 13:30:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Sat, Mar 11, 2017 at 04:47:21PM +0100, Luc Van Oostenryck wrote:
> This is a RFC for giving a type to constants/PSEUDO_VALs.
> 
> Not having this info if fine for the linearization/simplification
> but is quite painful once trying to generate code of it.
> 
> This serie try to do this by:
> - shuffling some fields in struct pseudo to allow
>   PSEUDO_VAL to have the ::sym field too without
>   without increasing the size of the structure.
> - mechanically initialize each PSEUDO_VAL's ::sym
>   with the appropriate type.
> 
> This serie have been tested on the test suite only.
> Thsi serie also doesn't make any use yet of this type info.

I have begun to try to make use of this and I'm now convinced
that this direction is not a viable solution for sparse.

Sparse's IR is slightly lower-level that LLVM's IR, more close
to what a real CPU would do. This can already be seen at some
instructions (nothing like GEP in sparse), the real difference
is less obvious but it's heer that things begin to hurt.
Indeed, sparse's CPU-like model implies that values are typeless
but have a size and sparse's CSE and simplification is heavily
based on this.
Once you try to add and maintain complete and correct typing to
sparse's instructions so that they can be used easily by sparse-llvm
you realize that:
- you need to add a lot more casts
- you need to change CSE to make things equivalent only if they
  have the same type
- a lot of simplifications are wrong, some can be corrected by adding
  even more casts.

So, while I'm very fine to add typing info where it was missing,
I have no interest in making the simplifications more complex and
of lesser quality.


-- Luc Van Oostenryck
