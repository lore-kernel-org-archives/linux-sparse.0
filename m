Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E522C5519F
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 18:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EAC21734
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 18:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WFMHOXbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgKRScE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgKRScE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 13:32:04 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184B8C0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 10:32:04 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id h23so3406306ljg.13
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 10:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Q7rWiFYI3RwGEEwETazOrhe2ppRCzmiMJEwR8Ma3w4=;
        b=WFMHOXbjTtxAnb4/Is7TAdWIrIsbWTyU+WdyUQ96EUx52apet5yqVGABDFdczvZTNa
         nV7Xi52G/6YvUPfgUQarqc3Qf3dg7+svgUHaI9aWpCNvAbHZt4p+ls3jnsd5biOaLR9Q
         Y6rTCgyzS42OdDeAyzhbOwydc09ENaavM5B+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Q7rWiFYI3RwGEEwETazOrhe2ppRCzmiMJEwR8Ma3w4=;
        b=EZaOLcXU4wwLD4EKoiIsYW0iYx1TzxawFzirhvLKUhqsArDas990T/pyYiGeZYdnUK
         Yw7t45xvpQHg3Jd7rcrH2syemX1YqzE9o/UE9ZuUKNHoinqFfgiopCdiYojUkpnTiIvn
         cvlueSHdqQRaXCzIdSt28SoOiFVYafe0w81X/6IRJ9sF5dAGZjq05dP5+ESAC5FQ689U
         OM8coeyiFAZwK18XSf3LMmotXEDtB4CiyZAP+X4lYaE+Y5LPpKYLNZVObe2LVN7jq0iO
         rgfsiJNmaNrPgIm8a04jIWAg7oaktJmKxWCoJER4hcq/gB1PM5sMwIqHywgQ8FvYBw0l
         +gOA==
X-Gm-Message-State: AOAM5328Izz2obnvZk1nBk9LvbIbEIaAIJr8yfSeiRL6bdlblYjcfQQ7
        plu/YDF0VGhnTWa5nqggeaUQ1zzNzTNaBQ==
X-Google-Smtp-Source: ABdhPJxLJ4N9NmCDfLjn+iL3szxLd1jHghRCaNxNiyKM/Y4BsAGgH2TVLcIBzqU04nfcu8aTEJs6Nw==
X-Received: by 2002:a2e:b00e:: with SMTP id y14mr4583899ljk.445.1605724322246;
        Wed, 18 Nov 2020 10:32:02 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n5sm3681140lfl.175.2020.11.18.10.31.59
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 10:32:00 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id l10so3450237lji.4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 10:31:59 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr4328451ljo.371.1605724319532;
 Wed, 18 Nov 2020 10:31:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
 <20201117212829.99552-1-luc.vanoostenryck@gmail.com> <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Nov 2020 10:31:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-XUPMduO16mvNeou58O-LrxnSk33WBg+vbbqCpzHgOw@mail.gmail.com>
Message-ID: <CAHk-=wi-XUPMduO16mvNeou58O-LrxnSk33WBg+vbbqCpzHgOw@mail.gmail.com>
Subject: Re: [PATCH] casts should drop qualifiers
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Nov 17, 2020 at 3:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Would doing the same unqualify_type() in degenerate() be sufficient?

Actually, that's a stupid suggestion. Forget I ever mentioned it.

I should have reacted to Martin Ucker pointing out

> > lvalue conversion drops qualifers in C.  In GCC, this is not
> > implemented correctly as it is unobvervable in standard C
> > (but it using typeof).

with the notable point that it is unobservable outside of "typeof".

I'm not actually entirely sure that is true: if you don't drop
qualifiers, it's potentially observable in code generation, in that a
"volatile" that didn't get dropped might perhaps cause unnecessary
memory ops. But from a kernel variable type standpoint where we want
to just drop qualifiers on variables using "typeof()", maybe the
simplest solution would be just special-casing typeof itself, using
something (entirely untested and probably complete garbage) like this:

  --- a/symbol.c
  +++ b/symbol.c
  @@ -509,6 +509,7 @@ static struct symbol
*examine_pointer_type(struct symbol *sym)

   static struct symbol *examine_typeof(struct symbol *sym)
   {
  +     int lvalue = lvalue_expression(sym->initializer);
        struct symbol *base = evaluate_expression(sym->initializer);
        unsigned long mod = 0;

  @@ -520,6 +521,8 @@ static struct symbol *examine_typeof(struct symbol *sym)
        }
        if (base->type == SYM_BITFIELD)
                warning(base->pos, "typeof applied to bitfield type");
  +     if (!lvalue)
  +             mod &= MOD_QUALIFIER;
        sym->type = SYM_NODE;
        sym->ctype.modifiers = mod;
        sym->ctype.base_type = base;

Hmm?

           Linus
