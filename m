From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 6/8] transform (A & M) >> S to (A >> S) & (M >> S)
Date: Tue, 8 Aug 2017 02:29:39 +0200
Message-ID: <CAExDi1RAaLD2aeCLBqcAngqKDuG5FpeOpZQP6TZ=Mo+MFBKwyQ@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-7-luc.vanoostenryck@gmail.com>
 <CANeU7Q=VSGSTLweWegU1RxZO9_iV9UT0p9L5xe95rC6-vMuntA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:38441 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHHA3l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 20:29:41 -0400
Received: by mail-qt0-f180.google.com with SMTP id t37so11765676qtg.5
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 17:29:40 -0700 (PDT)
In-Reply-To: <CANeU7Q=VSGSTLweWegU1RxZO9_iV9UT0p9L5xe95rC6-vMuntA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 8, 2017 at 2:22 AM, Christopher Li <sparse@chrisli.org> wrote:

> Why (A>>S) & (M >>S) is easier to simplify?
>
> The original has two instruction but the result has three.

Only 2 because M & S are constants and so (M >> S) is already evaluated.

As described succinctly in the patch description, even with 2 instructions
the real motivation is only because it's one of the three patterns that arise
when storing a bitfield and reloading it later.

But isolating a AND (smaller) mask is always a good thing because there
is a lot of other opportunities for more simplifications that can be
done on them.

-- Luc
