From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/8] Remove single-store shortcut
Date: Mon, 7 Aug 2017 14:42:14 -0700
Message-ID: <CA+55aFwmmzysWqAH5ebju7B5udaJKqcz5MA0dmszxRdjnCpwtg@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36111 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdHGVuD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 17:50:03 -0400
Received: by mail-oi0-f42.google.com with SMTP id g131so16355962oic.3
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 14:50:03 -0700 (PDT)
In-Reply-To: <20170807191205.86590-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 12:11 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Fix this by removing this single-store shortcut and leave
> all the work for the general case which handle this
> situation quite well (and/but set those variables to 0).

Ack.  The single-store case really was always a hack to make simple
things look simple.

Doing proper optimization is the right approach, no question about it.

                   Linus
