From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/5] fixes for rare crashes
Date: Thu, 6 Jul 2017 12:50:16 -0700
Message-ID: <CANeU7QnuWVvBgXOWqQwrMH+GoR7UoShYJNTUznEdEBcEToZqEw@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32972 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdGFTuS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jul 2017 15:50:18 -0400
Received: by mail-pf0-f173.google.com with SMTP id e7so5840715pfk.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 12:50:18 -0700 (PDT)
In-Reply-To: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 12:19 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series contains some fixes for crashes I found during
> some fuzzy-testing.
>
> Most of the reproducers are not at all valid C code and
> the crashes occurs very very rarely (a few tens of
> crashes after more or less 150 CPU hours of fuzzing)
> but I don't see much reasons why more 'normal' uses
> could not trigger the crashes.
>
> Sorry for coming with this so late in the release.

Let me take a look after my lunch.

I might delay the release a bit if there is a real bug there.

Chris
