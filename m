From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Wed, 16 Aug 2017 18:12:27 +0200
Message-ID: <CAExDi1RPS3qeqH=nr-9982FUnL3-99VoV7hQaxZbwWZsTCim=g@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <CA+55aFz+yT2W4GdLHVtsOs1Y7VhZjLPyW51=d8XXWLK-G7ffbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38625 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdHPQM2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 12:12:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id s21so3948676oie.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 09:12:28 -0700 (PDT)
In-Reply-To: <CA+55aFz+yT2W4GdLHVtsOs1Y7VhZjLPyW51=d8XXWLK-G7ffbw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Wed, Aug 16, 2017 at 5:51 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Aug 16, 2017 at 8:34 AM, Luc Van Oostenryck wrote:
>> The goal of this series is to implement and integrate to sparse
>> the method described in the paper:
>
> Thanks, now the changes have a good commit log, and the patches all
> look good to me.
>
> I didn't *test* any of it, or try to follow the logic, but it can't be
> worse than what we had, so "just make it so".

Thank you.

My own tests are pretty promising: no crashes, testsuite OK,
kernel allyesconfig OK too (but there is just 8 additional
'bad context' warnings I would like to investigate, OTOH,
knowing how broken the current SSA is I would bet that
these warnings were, in fact, missing in the old/present version).

For the logic, the (first part of the) paper is pretty straight
forward I won't be able to explain better than they did.

Best regards,
-- Luc Van Oostenryck
