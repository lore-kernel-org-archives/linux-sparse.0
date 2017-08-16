From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Wed, 16 Aug 2017 08:51:19 -0700
Message-ID: <CA+55aFz+yT2W4GdLHVtsOs1Y7VhZjLPyW51=d8XXWLK-G7ffbw@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36488 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbdHPPvU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:51:20 -0400
Received: by mail-oi0-f44.google.com with SMTP id g131so40027360oic.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:51:20 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Wed, Aug 16, 2017 at 8:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to implement and integrate to sparse
> the method described in the paper:

Thanks, now the changes have a good commit log, and the patches all
look good to me.

I didn't *test* any of it, or try to follow the logic, but it can't be
worse than what we had, so "just make it so".

               Linus
