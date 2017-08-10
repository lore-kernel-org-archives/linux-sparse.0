From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v4 00/25] improve constexpr handling
Date: Thu, 10 Aug 2017 08:36:44 -0400
Message-ID: <CANeU7QkXi8+yi3RcY6a=WtKo9LgEgKi_CjpW-bEvHFhuu=FgVA@mail.gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35070 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdHJMgp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 08:36:45 -0400
Received: by mail-yw0-f175.google.com with SMTP id l82so3606724ywc.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 05:36:45 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Thu, Mar 30, 2017 at 9:44 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Here is a respin of the series originally made and
> submitted by Nicolai Stange.
>
> The goal of this series is to improve the tracking of
> expression constness in the sense of C99 [6.4.4, 6.6]:
> more fine-grained and more correct. A new flag is added
> for a strict mode while by default offering the relaxed
> mode we're used to, for example for kernel compile.

Sorry for the late replay. As I express before, this integer context
will not be part of this release 0.5.1.

Now the RC5 is almost out of the door. I can catch up a bit of
back log I have.

One suggest on the V4 is that, (suggestion, not reason to object
the inclusion of this series. If you prefer, I can merge them as it is
and change them later.)

I would like the manipulate of the bits representation abstract as
higher level function or macros. I have suspicious that bits
representation can be simplify in the future. Wrap them into
higher level function at the call site will be easier to read what
is the intend for this operation.

It also make the change of the underlying bit representation easier,
that is if we do found a simpler representation.

Thanks

Chris
