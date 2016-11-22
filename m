From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] normalize bb's label names for testing
Date: Tue, 22 Nov 2016 14:27:49 +0100
Message-ID: <20161122132748.GB8370@macbook.local>
References: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=uNLQh=ynnWPeO0+ahu7qhJ2nxqxOrxbDraR1jo6xEAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33264 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755434AbcKVN2D (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 08:28:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so3805247wmu.0
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 05:27:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=uNLQh=ynnWPeO0+ahu7qhJ2nxqxOrxbDraR1jo6xEAQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Nov 22, 2016 at 06:02:04PM +0800, Christopher Li wrote:
> On Mon, Nov 21, 2016 at 12:14 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > These two patches solves the testing problem of the label names
> > as emitted by test-linearize and others being not comparable
> > between runs.
> 
> I think it is much easier just let test-linearize print out label in
> a predictable way.

Absolutely. It's what I'm doing here on my working tree.

> e.g. In the "struct basic_block", there is this
> two fields "generation" and "priv". The "generation" is used by
> flow analyze to store some state. Same as the "priv", which is
> used by the back end to store some back end related state.
> 
> Since test-linearize can treat as a back end, it is perfectly safe
> to store some allocation number into the "priv".

The problem with this 'priv' is that it's, well ... private, if we
reuse it to store labels IDs it possibly can't be used anymore for
this private usage.
I would be more tempted to reuse the 'generation' field which is a long
and don't need much bits.
Of course, the real question is if that's such important to not add a new
field to struct bb.

> Than we don't need to complicate the test-suit script to do the
> label normalization.

Sure.
But it should be noted that this filtering stuff *could* be useful for other
things to (but I have no such uses).

Luc
