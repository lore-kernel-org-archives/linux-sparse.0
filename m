Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB2C433E0
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 17:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD6423A9C
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 17:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbhAVRlI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 22 Jan 2021 12:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbhAVRgq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 22 Jan 2021 12:36:46 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3FFC06174A
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 09:36:02 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id q8so8607890lfm.10
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 09:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MjpSmzzBkOsQldCKL+v1Bd/X0kxKyO2NNiaegquMJs=;
        b=SfITsr5kfkU7oz+94KRXDlckZZYa4X4XMDHXjonvySdQhMoukibZyfBkJwMWerXgFf
         BWvsANw8L/nnTX8n/kPIZYTYwn8Yotc/WPzVz2sEsYyo8fRvbS0KZOaQuS9nztKU8tsa
         /Myjeia741Kgh0cQHfRWhMjRlWGlPa2H3O30o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MjpSmzzBkOsQldCKL+v1Bd/X0kxKyO2NNiaegquMJs=;
        b=MBb1Ce1g1Q4pr/1AHUz/SaRUIWTVmOdwgJi9E63YmZDlG7oE6xqY9L2Q8DvJ8QCFKd
         R4Mh8eGZlcu9LfspE8MNUoqog1kVWvte/+/pYsAyLF15isDvXJIMCRojfJfl35/Fo5FU
         7y//QiKcWYVOGL15wvduss+/tV/WHzsJX2jJQv61/wlr9BMAzvY7XenwDB58BZ5cwyqA
         1CsruRe6JleIJU+Eq4f7BO5SSsJgjbuB+AwbWfH6dWnqi40QU59ZYNnMRTksHSI16cqM
         7cg95SqvV5Kdb5RAdEik22uam5IMsEBaSZ89us5lW75ZYbpjd/bjpZzp1VRydX8L4Urn
         ybOg==
X-Gm-Message-State: AOAM533Plo9lEgKdBEjlZh48O2hNkTYNUUocUSseFvw+m50S2EVkQ8KJ
        U75GTksm963oJn9QlGvfXvb/3sEPLVomwA==
X-Google-Smtp-Source: ABdhPJwOxWWK0lGRxoW57EVJUcK0O9PL6U+GOoJXmAnEyW3F9cMhwT6Agl62G4P6EcoG3Cksn4gaqw==
X-Received: by 2002:ac2:5e36:: with SMTP id o22mr1174956lfg.15.1611336960941;
        Fri, 22 Jan 2021 09:36:00 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f29sm960111lfj.47.2021.01.22.09.35.59
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 09:35:59 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id v24so8633759lfr.7
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 09:35:59 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr1980067lff.201.1611336959420;
 Fri, 22 Jan 2021 09:35:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
 <20210122162625.73007-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20210122162625.73007-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jan 2021 09:35:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3v1hm3x0x_3ui1PQDLbn7V5PoxGyDf_UB6TCxMTgjQw@mail.gmail.com>
Message-ID: <CAHk-=wj3v1hm3x0x_3ui1PQDLbn7V5PoxGyDf_UB6TCxMTgjQw@mail.gmail.com>
Subject: Re: [PATCH] handle qualified anonymous structures
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Jan 22, 2021 at 8:26 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> So, the solution chosen here is to handle this during type examination,
> more precisely, inside examine_struct_union_type(), where things are
> a bit more complicated

Well, doesn't look all that complicated to me.

The only thing I would do is to just at the head of that function do:

        unsigned long mod = sym->ctype.modifiers & MOD_QUALIFIER;

        if (!mod)
                return;

and that also means that you can avoid the "parent-vs-sym" thing,
because the symbol is never used after that, so you don't need to
create a new one.

The other thing that might be worth doing is to just make sure that
the "sub" whose modifier you change is always a SYM_NODE. We never
want to touch an actual type, only the node.

I don't think it _can_ be anything else (that's how the struct/union
symbol_list should be set up), but since this is a very unusual case
of going back and modifying a symbol after the fact, I think I'd be a
bit more comfortable with that kind of sanity check.

Hmm?

Anyway, looks good, and obviously passes my trivial test-case.

               Linus
