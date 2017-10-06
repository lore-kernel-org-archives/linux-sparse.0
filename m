From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/6] build: various updates
Date: Fri, 6 Oct 2017 12:03:03 -0700
Message-ID: <CANeU7QnYphoaeq1Vi6XdV+8fk0hoC_hdMVu6vOXiMKR93LFVBA@mail.gmail.com>
References: <20171004132605.24734-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37878 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbdJFTDE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Oct 2017 15:03:04 -0400
Received: by mail-qt0-f194.google.com with SMTP id 32so8738736qtp.4
        for <linux-sparse@vger.kernel.org>; Fri, 06 Oct 2017 12:03:04 -0700 (PDT)
In-Reply-To: <20171004132605.24734-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 4, 2017 at 6:25 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
> Hello,
>
> this series motiviation is to support CPPFLAGS which is needed for
> Debian packaging and includes the stuff I found while adding this.

Sorry I was traveling in the last two days. Not able to reply
it earlier.

The first patch is applicable. However the others have
major conflict with the debug build change:

https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=3Ddebu=
g-target-v3

I plan to merge that first because it has deeper impact.
It also have impact on your patch too. I will comment that
on separate email reply to your patch.

Can you give the debug-target-v3 a review?

Thanks

Chris
