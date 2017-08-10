From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 1/8] Remove single-store shortcut
Date: Wed, 9 Aug 2017 20:53:26 -0400
Message-ID: <CANeU7QnYFax33asyuekw5tKx0SaN-u15LCXi0KDmpQaX_7+Agw@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-2-luc.vanoostenryck@gmail.com>
 <CA+55aFwmmzysWqAH5ebju7B5udaJKqcz5MA0dmszxRdjnCpwtg@mail.gmail.com>
 <CANeU7Qn3Nxcd6LLXJnw0Pd0WNYfddoWgKft2NqkO5AS5r8L9yg@mail.gmail.com> <CAExDi1StnUK7CCP45oVTw7VeQ8JrEgk_0EeOGrarf6kYWB+JRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35614 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdHJAx2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 20:53:28 -0400
Received: by mail-yw0-f181.google.com with SMTP id l82so49892564ywc.2
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 17:53:27 -0700 (PDT)
In-Reply-To: <CAExDi1StnUK7CCP45oVTw7VeQ8JrEgk_0EeOGrarf6kYWB+JRw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 8:41 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Are you fine with this?

Sure. I am still writing the documents for RC5.

Do you want me to merge this V4 version as it is?

I will start to switch to master to do the merge. Giving up the
rebase thing on sparse-next. At the same time I also want to give
you patch a bit more test.

Thanks

Chris
