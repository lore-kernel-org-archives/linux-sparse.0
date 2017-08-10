From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 1/8] Remove single-store shortcut
Date: Thu, 10 Aug 2017 02:41:55 +0200
Message-ID: <CAExDi1StnUK7CCP45oVTw7VeQ8JrEgk_0EeOGrarf6kYWB+JRw@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-2-luc.vanoostenryck@gmail.com>
 <CA+55aFwmmzysWqAH5ebju7B5udaJKqcz5MA0dmszxRdjnCpwtg@mail.gmail.com> <CANeU7Qn3Nxcd6LLXJnw0Pd0WNYfddoWgKft2NqkO5AS5r8L9yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34007 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbdHJAl4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 20:41:56 -0400
Received: by mail-oi0-f68.google.com with SMTP id v11so7240346oif.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 17:41:56 -0700 (PDT)
In-Reply-To: <CANeU7Qn3Nxcd6LLXJnw0Pd0WNYfddoWgKft2NqkO5AS5r8L9yg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 2:29 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 7, 2017 at 5:42 PM, Linus Torvalds wrote:
>>
>> Ack.  The single-store case really was always a hack to make simple
>> things look simple.
>>
>> Doing proper optimization is the right approach, no question about it.
>>
>
> Totally agree.

This patch (and the preceding one but not the ones that follow) is totally
worth to add to the release. I've tested it (my normal tests + kernel
allyesconfig)
and all is OK :
- lots of changes in test-linearize, of course, but only good changes
- zero changes in kernel check

Are you fine with this?

-- Luc
