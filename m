From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] patches for -rc5
Date: Thu, 10 Aug 2017 02:32:33 +0200
Message-ID: <CAExDi1T-r4WRx_uGPGYJZ2Kk7PtN5hu4A+3+VNB9YDx1w42rHw@mail.gmail.com>
References: <20170809004307.16663-1-luc.vanoostenryck@gmail.com>
 <20170809192015.li6dmzg3griy6uug@ltop.local> <CANeU7Q=JLy294tJiVVU=4Z0PhEQPgpgZwwcHSyCEsb1_W+k6ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36803 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbdHJAce (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 20:32:34 -0400
Received: by mail-oi0-f47.google.com with SMTP id g131so76442564oic.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 17:32:34 -0700 (PDT)
In-Reply-To: <CANeU7Q=JLy294tJiVVU=4Z0PhEQPgpgZwwcHSyCEsb1_W+k6ZQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 2:12 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 9, 2017 at 3:20 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Wed, Aug 09, 2017 at 02:43:07AM +0200, Luc Van Oostenryck wrote:
>>> Chris,
>>> Please pull these patches for the upcoming release.
>>> No surprise here, it's the patches that have been on
>>> sparse-next, with no rebasing on external branches and
>>> some extra testing.
>>>
>>> The following changes since commit fa71b7ac0594c9ddf81ec27753280cffef702489:
>>>
>>>   Adding gcc attribute no_gccisr (2017-07-13 23:57:09 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/lucvoo/sparse.git tip
>>>
>>> for you to fetch changes up to cccba8defbf0386305f522e63e1a1dd939f8c734:
>>>
>>>   Bump sparse's version to -rc5 (2017-08-09 00:24:23 +0200)
>
> Please don't do the -rc5 bump just yet. I need to add some documents.
>
> I can take the master to 989132ba9259b80bc8b8bac7d9b29fabf1d9e483, the one
> before -rc5 bump. Please let me do the bump. It usually come with the sign tags
> as well.

I have no problem for you to take only till the preceding ref.
But as we agreed and so that you just have something that fast-forward to
master *all* the changes must come from my tree first. I do the integration
and you just pull from me.
It's exactly what you asked and we agreed, right?

-- Luc
