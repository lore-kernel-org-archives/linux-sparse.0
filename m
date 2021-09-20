Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43611C433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 21 Sep 2021 01:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B3861168
	for <linux-sparse@archiver.kernel.org>; Tue, 21 Sep 2021 01:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhIUBmz (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhIUBin (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Sep 2021 21:38:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785AFC128ED4
        for <linux-sparse@vger.kernel.org>; Mon, 20 Sep 2021 12:46:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g1so72774842lfj.12
        for <linux-sparse@vger.kernel.org>; Mon, 20 Sep 2021 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/4d6QJeGZCj2JNd8r06qB/o4KuGi6QEUdTRkNveq3w=;
        b=Q3LhEPOHc010gdfUc6e/0+OwWkLDILQAryxm4+BRnojSGhKUZx3i2JKpwpPFiraRMu
         E/I72DGNYfViGt4X8Hw5CpE7Nktij+mVRH+dEpKmPPQIoMBi3/lKCUfxw61t1pARyUwe
         w3uR28CSEpRp+LIB6b1M9E+jNUiv+vNeaFNjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/4d6QJeGZCj2JNd8r06qB/o4KuGi6QEUdTRkNveq3w=;
        b=r53cKCNe49SvCLW8MG5C2JuzITsC67j7IQRwtE11EvEnhQvJ9b0r6PflAY8iOEvz+D
         W3UsZR6n+0G5urpfkMZ97UC1U/i7AhtbXzgpijHYOQ64/+qx3/SAESrfXkBsLK7d8TDg
         ftwY1dxLgMPjhUBd7x62wCaMSydhpZqU78l04UfZzQog5kz87YrdlFRN+jNzlshdLa8p
         agbxFFaCg7wP5nLG99RJ0joy7Jd7AdYkzmF6D1cMvS8bMULrJlkH4QIlRZtNgiRpTrBa
         WH93yChIQwbkSh99wCgttVFgSZViwhMceSbMX9GTqPZbNsESGHY6i2fBZFLTOzqb1OhM
         1hSQ==
X-Gm-Message-State: AOAM530A+/j3ONT2QMH/dmpEvzWK4FHnybpKasUtgkvQwF9BSNNjZvhz
        E6EiNV8kEIqyzPjfaqm7pVzU1f4SH3aUMQYn
X-Google-Smtp-Source: ABdhPJwv8e73UGLMi56TokB0mM5YZsaVX8dqk2itwx7QMFH/jaxQJZcf3qH+Lb1Nw14iDAKtfczAYg==
X-Received: by 2002:a05:6512:15a4:: with SMTP id bp36mr19924980lfb.509.1632167169881;
        Mon, 20 Sep 2021 12:46:09 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f15sm1865804ljn.120.2021.09.20.12.46.09
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 12:46:09 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id g1so72774690lfj.12
        for <linux-sparse@vger.kernel.org>; Mon, 20 Sep 2021 12:46:09 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr12166105ljc.249.1632167169161;
 Mon, 20 Sep 2021 12:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh-=tMO9iCA4v+WgPSd+Gbowe5kptwo+okahihnO2fAOA@mail.gmail.com>
 <202109201825.18KIPsV4026066@valdese.nms.ulrich-teichert.org>
 <CAHk-=wibRWoy4-ZkSVXUoGsUw5wKovPvRhS7r6VM+_GeBYZw1A@mail.gmail.com> <CAEdQ38HeUPDyiZhhriHqdA+Qeyrb3M=FoKWKgs0dZaEjbcpVUQ@mail.gmail.com>
In-Reply-To: <CAEdQ38HeUPDyiZhhriHqdA+Qeyrb3M=FoKWKgs0dZaEjbcpVUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 12:45:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1JWZ3sCrGz16nxEj7=0O+srMg6Ah3iPTDXSPKEws_SA@mail.gmail.com>
Message-ID: <CAHk-=wj1JWZ3sCrGz16nxEj7=0O+srMg6Ah3iPTDXSPKEws_SA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Matt Turner <mattst88@gmail.com>
Cc:     Ulrich Teichert <krypton@ulrich-teichert.org>,
        Michael Cree <mcree@orcon.net.nz>,
        Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Sep 20, 2021 at 11:59 AM Matt Turner <mattst88@gmail.com> wrote:
>
> In the decade plus I've been around Linux on alpha I've don't actually
> recall hearing of anyone using Linux on a Jensen system before :)

Looking around, I'm pretty sure the system I did all my initial work
on was a Jensen.

This is from the linux-.1.1.83 patch:

- * I don't have any good documentation on the EISA hardware interrupt
- * stuff: I don't know the mapping between the interrupt vector and the
- * EISA interrupt number.
- *
- * It *seems* to be 0x8X0 for EISA interrupt X, and 0x9X0 for the
- * local motherboard interrupts..
+ * The vector is 0x8X0 for EISA interrupt X, and 0x9X0 for the local
+ * motherboard interrupts.. This is for the Jensen.

So yup, my initial bringup machine was that DECpc AXP 150, aka "Jensen".

The IO subsystem on that thing was absolutely horrendous. Largely
because of the lack of byte/word accesses, so doing any PCI accesses
had to be encoded on the address bus. Nasty nasty nasty.

The original design with only 32-bit and 64-bit memory accesses really
was horribly horribly wrong, and all the arguments for it were
garbage. Even outside of IO issues, it blew up code size enormously,
but the IO side became truly horrendous.

Oh well. Water under the bridge.

I did have another alpha at some point - going from the original
150HMz EV4 to a 275MHz EV45. I forget what system that was.

               Linus
