From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [SPARSE v2 00/28] detect invalid branches
Date: Tue, 19 May 2020 23:16:37 +0200
Message-ID: <20200519211637.4hjorseu675acihh@ltop.local>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wiaZgBKwC2-ku3UeV4Rdv=tPcKLAfjy96PbJSntcLBWHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESVQl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 17:16:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83016C08C5C0
        for <linux-sparse@vger.kernel.org>; Tue, 19 May 2020 14:16:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f13so645602wmc.5
        for <linux-sparse@vger.kernel.org>; Tue, 19 May 2020 14:16:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wiaZgBKwC2-ku3UeV4Rdv=tPcKLAfjy96PbJSntcLBWHw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, May 18, 2020 at 06:41:07PM -0700, Linus Torvalds wrote:
> On Mon, May 18, 2020 at 5:57 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > The goals of the patches in this series are:
> > *) to detect such gotos at evaluation time;
> > *) issue a sensible error message;
> > *) avoid the linearization of functions with invalid gotos.
> 
> Ack. Apart from that one question I had, which I didn't actually
> verify whether it was a problem for the insane test-case I posted.
> 
> I only _read_ the patches, I didn't actually apply and test them in any way.

Sure, I understand that very well. I tend to give to this kind of
series a decent amount of testing and its mostly fully automatic
anyway (and, I think, the tests cover well most situations),
but having another eye and another opinion on the patches is very
much appreciated.

-- Luc
