From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] llvm fixes
Date: Sun, 5 Nov 2017 18:03:52 +0100
Message-ID: <20171105170349.o7r7z3qb4a36pmtf@ltop.local>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
 <CANeU7Qk4AGhSzzpPXT1-NmWRzSprUXEjWm6o1iy8yKAb-TceQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:53304 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdKERD6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 12:03:58 -0500
Received: by mail-wm0-f43.google.com with SMTP id r196so9931817wmf.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 09:03:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk4AGhSzzpPXT1-NmWRzSprUXEjWm6o1iy8yKAb-TceQg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 05, 2017 at 04:49:37PM +0800, Christopher Li wrote:
> >commit 5674da2d1af2467605fcc9b798fb54ee2d28efc7
> >Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> >Date:   Mon Mar 20 15:18:53 2017 +0100
> >
> >    canonicalize compare instructions
> >
> >    Currently only commutative instructions are canonicalized
> >    (the "simpler" operands, often a constant, is forced, if present
> >    to be in the second operand). This improve CSE (more cases are
> >    considered as equivalent) and help to reduce the number of "pattern"
> >    to be handled at simplification.
> >
> 
> 
> Notice that LT and GT and equivalent instructions after swapping the src.
> Another way to do it we might just remove one kind of instruction from the
> sparse IR. From the linearization point just map GT into LT and swap the source.
> 
> So the IR does not allow those duplicated equilateral instructions. There is
> less canonization to be done.

The principal and most important action done during canonicalization is
insuring that constants are on the RHS.

-- Luc
