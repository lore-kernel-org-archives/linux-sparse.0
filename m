From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Interesting (?) failure case
Date: Thu, 9 Apr 2020 09:51:28 -0700
Message-ID: <CAHk-=wgLxBez6hB1t5UQbhpFpwXpASe-+Nqz5_=_Qp1w-9hz9g@mail.gmail.com>
References: <CAHk-=wg=Fs=EecQCNNzofn8+QXuB-sYy9m+YVPAmzDesmqFsbg@mail.gmail.com>
 <20200409062319.ykuewl7z3dc3a55n@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lj1-f169.google.com ([209.85.208.169]:41785 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgDIQvr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Apr 2020 12:51:47 -0400
Received: by mail-lj1-f169.google.com with SMTP id n17so377361lji.8
        for <linux-sparse@vger.kernel.org>; Thu, 09 Apr 2020 09:51:47 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id e17sm15463524ljo.75.2020.04.09.09.51.45
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 09:51:45 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id i20so394320ljn.6
        for <linux-sparse@vger.kernel.org>; Thu, 09 Apr 2020 09:51:45 -0700 (PDT)
In-Reply-To: <20200409062319.ykuewl7z3dc3a55n@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Apr 8, 2020 at 11:23 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Yes, the problem is caused at expand_conditional() where one of
> the sides is throwed away if the condition is known. So the label
> doesn't exist anymore and at linearization Sparse ends with a
> jump to an unexisting BB.

Yes.

And I don't think that's really a problem per se. I think the gcc
model of saying "you jumped to an invalid place, go away" is fine -
particularly since this can only happen if you use a gcc extension to
begin with.

So I don't think sparse is wrong, except for the total lack of any
error messages.

> I tried to simply discard the early optimization in expand but
> then when testing the kernel I got a whole bunch of warnings

I don't think we want to get rid of the early tree-level
simplifications. They are sensible and help avoid unnecessary work
later.

So I'd much rather just figure out some way to say "hmm, this goto is
to something that was removed earlier, let's just say so".

> I tried also to warn on gotos jumping into an expression statement.
> The idea was to give a new 'label_scope' for each such statement.
> Things are a bit complicated because the labels are implicitly
> declared by the gotos.

Yes. I think the gcc warning is nice, but I also think that it would
be entirely sufficient to not notice at an early stage, but only when
linearizing and hitting the "I'm branching to something that I can't
generate code for", and report it at that point, instead of being
clever and analyzing scopes up front.

                  Linus
