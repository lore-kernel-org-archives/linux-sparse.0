From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 1/8] Remove single-store shortcut
Date: Wed, 9 Aug 2017 20:29:26 -0400
Message-ID: <CANeU7Qn3Nxcd6LLXJnw0Pd0WNYfddoWgKft2NqkO5AS5r8L9yg@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-2-luc.vanoostenryck@gmail.com>
 <CA+55aFwmmzysWqAH5ebju7B5udaJKqcz5MA0dmszxRdjnCpwtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34665 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbdHJA31 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 20:29:27 -0400
Received: by mail-yw0-f181.google.com with SMTP id s143so49738915ywg.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 17:29:27 -0700 (PDT)
In-Reply-To: <CA+55aFwmmzysWqAH5ebju7B5udaJKqcz5MA0dmszxRdjnCpwtg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 5:42 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ack.  The single-store case really was always a hack to make simple
> things look simple.
>
> Doing proper optimization is the right approach, no question about it.
>

Totally agree.

Chris
