From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] Allow casting to a restricted type if !restricted_value
Date: Fri, 17 Feb 2017 09:50:06 -0800
Message-ID: <CA+55aFxHhidy-640c+pvmOtGGMw_=NYhh86JBPkN7YLtFiL4OQ@mail.gmail.com>
References: <e8e65c94-4d07-b20e-1bdb-30c7a8d1108f@solarflare.com> <1d8e35fa-643b-afa4-8089-f5a945a50eef@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34263 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934053AbdBQSWe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 13:22:34 -0500
Received: by mail-oi0-f54.google.com with SMTP id s131so14304348oie.1
        for <linux-sparse@vger.kernel.org>; Fri, 17 Feb 2017 10:22:34 -0800 (PST)
In-Reply-To: <1d8e35fa-643b-afa4-8089-f5a945a50eef@solarflare.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Edward Cree <ecree@solarflare.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Feb 17, 2017 at 7:11 AM, Edward Cree <ecree@solarflare.com> wrote:
> If the operand of a cast to a restricted type is an unrestricted value,
>  the cast should not produce a warning, since an equivalent implied cast
>  (e.g. in an initialiser) would not do so.

Looks ok to me, fwif

          Linus
