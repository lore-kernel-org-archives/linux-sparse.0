Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0786C433FE
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7417D22B40
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgLDROu (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgLDROt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Dec 2020 12:14:49 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A2C061A4F
        for <linux-sparse@vger.kernel.org>; Fri,  4 Dec 2020 09:14:08 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s27so8648387lfp.5
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 09:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAg/m20itFUVeaJ0MmGzrM60lSJ3qDXKn9picUexREc=;
        b=YmHPeLrRs9zH9HHLoQXuCFI+pC3JG+CEZhKCPsE49YX9+2wJDqNsk0l+VhkRaRCI3G
         1azyieoDHp2bwp7GdJrzpuswSTif8x2J2UjPwcDb7zh3Zu9mUnxA7US/Bn/doLHVJOG2
         hqdZyl2hc+deKZDv/FE3mRZ0Tq8F4NRRNlzTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAg/m20itFUVeaJ0MmGzrM60lSJ3qDXKn9picUexREc=;
        b=OL60CMWu3lRk+IOVmZ6T4FrNRiAYWKYNy0ndnQwYqccWv65heasrSdwUf7EVIouX1g
         5PTz8QNtke79M8PANVZkWp3ubNVSlBSx3ATgeUXnpJseYnMvI40DtuhLp9z63tQY21xL
         tG0IchYEJqEx2WXXNVbMYOgmXNkRUeK2JqGJE6puWpEh757Qx6QczxK70nf7OMUHiPJW
         tmas8zcANOsXeJuqMGoQjiSteAjSAXVEyV1qZYPGZMEFR9BzIYWOeA2PakfXNC1xbhUY
         di+7HdDQlWLwmkFOSIrJZDU947POGC+Llyl+Hw7dU7AUM0h89D3vESO2uX/x+0YqeDAJ
         jkNg==
X-Gm-Message-State: AOAM530gsN4xDCgE+eWI3+TJ4KW8pbaic3DXPurUHsfJuylYPgq2TOyY
        ty337L7zZrBnRNpnWE5be1Y0qP+5TwxwfA==
X-Google-Smtp-Source: ABdhPJwZJiIxi0pBSF5o9JcRUqrFXTfkaJ7t/Fs6TyjzCYlB/glpByMEfDvGkoZ2dzs/7JwHmvp0ng==
X-Received: by 2002:a19:7d8:: with SMTP id 207mr3819554lfh.376.1607102047102;
        Fri, 04 Dec 2020 09:14:07 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id a30sm1891515ljd.91.2020.12.04.09.14.06
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:14:06 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id y7so7415835lji.8
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 09:14:06 -0800 (PST)
X-Received: by 2002:a2e:7f13:: with SMTP id a19mr4002051ljd.70.1607102045900;
 Fri, 04 Dec 2020 09:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20201204163315.68538-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20201204163315.68538-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Dec 2020 09:13:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=witmTznTY4oH7KDr7aTufXey17w1fTaTBiMChk+4NUQ1Q@mail.gmail.com>
Message-ID: <CAHk-=witmTznTY4oH7KDr7aTufXey17w1fTaTBiMChk+4NUQ1Q@mail.gmail.com>
Subject: Re: [PATCH] experimental: code sinking
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Dec 4, 2020 at 8:34 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> A lot of the false 'context imbalance' warnings are caused by
> a potential jump-threading being blocked between 2 conditional
> branches on the same condition because the second CBR belong
> to a non-empty BB. Often the offending instructions can be moved
> to some other BB, sometimes even with some added advantages.

I hope you don't just use the context imbalance as a sign of this
being a good idea, because a lot of the context imbalances are likely
real and valid.

I do think moving the instruction to the (single) user sounds like a
good idea in some cases, but I'm a bit worried about doing it quite
this mindlessly. It can expand on liveness a lot - while the liveness
of the result of the sunk instruction shrinks, the liveness of the
sources to the sunk instruction can grow a lot.

That's obviously a non-issue for the use of sparse as an analysis tool
(and that's clearly the primary use), but I'd still like to think that
code generation might matter.

So I think this might be better with more heuristics. And explaining
them. Right now you have one heuristic: you only sink instructions
from bb's that end with a conditional branch. I'm not entirely sure
that I understand the reason for that heuristic, it smells a bit
arbitrary to me (I suspect it was the case you saw when looking at
examples).

On that note: would also be lovely to actually see examples of what
this results in - and not necessarily about just the context imbalance
again.

There might be cases where instruction sinking makes sense even
outside the "can we empty this bb entirely" issue. Not that I can
think of any, but I wonder if this could be used to actually shrink
liveness regions (if both the inputs to the sunk instruction are live
_anyway_ at the target, then sinking the instruction should actually
improve liveness in general, for example).

             Linus
