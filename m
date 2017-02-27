From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] CSE: relax type checking in hashing/compare
Date: Mon, 27 Feb 2017 16:09:45 +0800
Message-ID: <CANeU7Qmo49EXqTs3EaMdgKMiii4VBYjEmef7P3AnjjPd2xTyKg@mail.gmail.com>
References: <20170217000608.6433-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37795 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdB0IKj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 03:10:39 -0500
Received: by mail-it0-f46.google.com with SMTP id 203so60683750ith.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 00:09:46 -0800 (PST)
In-Reply-To: <20170217000608.6433-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Feb 17, 2017 at 8:06 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I made a patch (see the second one in this non-serie) so that
> cast from equivalent types hash identically. It worked well
> but after a while I concluded that it was not really needed.
> Indeed, in the context of CSE, to consider two instructions as
> equivalent, the first thing that need to be equal is their source
> operands. Isn't it already the case that if we use the same pseudo
> in two instructions, the type of these pseudo in each instructions
> must already be, if not identical, at least 'sufficently equivalent'?

I think so. I will apply this version to sparse-next.

Chris
