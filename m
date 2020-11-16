Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8EC63777
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D6B22453
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FZRWjVbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgKPWxk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPWxk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 17:53:40 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFC4C0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:53:39 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r9so27436842lfn.11
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4d3VT0fsuww0+XsATs4+3xOpvlbjp+PtreIisO0ilg=;
        b=FZRWjVbbexu3VqcdVLhhokaNBNpin1+cNiV9AGi7+CtoT1ufYAHPkuKbdtXtqJ8vjY
         Xyf/XMH/WTQQR0Ha0iM7jKfpSoxvJp+9Jg2AWpCEqQlu/xV5t4KVjC/ZaDdlMY6mgkz0
         Hk+VjHQO4DPPrLTd+78AfG4ixOxbymhPjSyhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4d3VT0fsuww0+XsATs4+3xOpvlbjp+PtreIisO0ilg=;
        b=c5x9EbCmH07Osk+4qhk983KjxLc56xvtlkRElmbMBSDqhuaaApv4xnI5MjU/6BtOuv
         XSx9Q3EiVd6qG7YYBECgF3unT2vue1WmHeZRZsIx15Th8WMxiOE9jbVfse5wTBivKIRG
         I6T+eSENMMVc7T2Jt14blIgTxHx+kTRDPsF2dNHo/xSWcOLJX0Herqaa6yeV6dcJ6JDk
         YW98oFUFu37GS06UUJvTvO4NQY8W6j4r9eOldOR8HingRwzG+M36txzGEb7Vy+j6hxe8
         l383OrQprOs8Qj5sll7UcqTpfxavKom3SOwJJxliZCnRMnDX52z6Tu92oD8bK6ig4ijS
         iY1Q==
X-Gm-Message-State: AOAM532oxZkRNrRnu1degbgatCwetWkt2AW8fSZ4FRDGtjabzQEbGXIA
        FLIUcF/nJVJcX27nOElcBLvB1sTjHM3+4w==
X-Google-Smtp-Source: ABdhPJzrucccBfT2wa2Ut841O/b68RXKinAKpXw6TSXWO5siXvOAIJ+mAOZhs8iPJF6zJU8cHtKZ6A==
X-Received: by 2002:a19:c704:: with SMTP id x4mr517666lff.499.1605567218065;
        Mon, 16 Nov 2020 14:53:38 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u28sm2888836lfn.102.2020.11.16.14.53.37
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 14:53:37 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id i17so20932689ljd.3
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:53:37 -0800 (PST)
X-Received: by 2002:a2e:3503:: with SMTP id z3mr626955ljz.70.1605567216807;
 Mon, 16 Nov 2020 14:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com> <20201116222927.51939-5-luc.vanoostenryck@gmail.com>
In-Reply-To: <20201116222927.51939-5-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 14:53:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSQ-=SRspfVWdE17ORGJtjJzPCvCOo7ETwM9jeUG6uvg@mail.gmail.com>
Message-ID: <CAHk-=wiSQ-=SRspfVWdE17ORGJtjJzPCvCOo7ETwM9jeUG6uvg@mail.gmail.com>
Subject: Re: [PATCH 4/8] cfg: adjust phi-sources when merging BBs
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Nov 16, 2020 at 2:30 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> +static void adjust_phisrc(struct basic_block *top, struct instruction *insn)

My only issue is that this is a really odd name, and calling convention.

"adjust"?

Wouldn't it be more sensible to call this "remove_phisrc()", because
that's what it does. It removes the matching phisrc instruction in the
specified basic block.

(I also think it might be a bit more obvious to do the get_phinode()
in the caller, and simply pass in the OP_PHI instruction, but maybe
you had reasons to do it that way).

             Linus
