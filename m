From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Thu, 17 Aug 2017 00:45:11 -0400
Message-ID: <CANeU7QnnQ+ou69FfHaLXYbhK2_78iOfps0q3L3bO6tMp7K=VvQ@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <CA+55aFz+yT2W4GdLHVtsOs1Y7VhZjLPyW51=d8XXWLK-G7ffbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35888 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbdHQEpM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:45:12 -0400
Received: by mail-yw0-f182.google.com with SMTP id u207so34610469ywc.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:45:12 -0700 (PDT)
In-Reply-To: <CA+55aFz+yT2W4GdLHVtsOs1Y7VhZjLPyW51=d8XXWLK-G7ffbw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Aug 16, 2017 at 11:51 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Thanks, now the changes have a good commit log, and the patches all
> look good to me.
>
> I didn't *test* any of it, or try to follow the logic, but it can't be
> worse than what we had, so "just make it so".

I agree. And thanks for the feedback.  I really want to get the
SSA behave nicely on sparse too.

Chris
