From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: update __builtin_object_size() prototype
Date: Thu, 17 Nov 2016 16:28:26 +0800
Message-ID: <CANeU7QnyvFzscoi4tGAMAz6FJO-1+67OWDNCio5cc+sE17mO+A@mail.gmail.com>
References: <1474467238-20939-1-git-send-email-lrichard@redhat.com>
 <20161107100934.GB443@macbook.home> <CANeU7Q=hA2T+dgdi7cz_RK1Xday0g5PWszZMoT_Dw0vx0K5CBQ@mail.gmail.com>
 <20161116232850.GB21402@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33007 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbcKQI22 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 03:28:28 -0500
Received: by mail-it0-f68.google.com with SMTP id c20so13551400itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 00:28:27 -0800 (PST)
In-Reply-To: <20161116232850.GB21402@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Lance Richardson <lrichard@redhat.com>, Johannes Berg <johannes@sipsolutions.net>

On Thu, Nov 17, 2016 at 7:28 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> BTW, how must we consider this "chrilsi" repository?
> A bit like a -next repository or more like a working one?

It is a repository I use to stage change. I need to know
more about the difference between "-next" repository vs
a working one.

> Can we consider it as stable for git fetches & pulls?

So far it has been stable for git fetch and pulls.

The "review-xxxx" branches are not.

Chris
