Return-Path: <SRS0=Wnm1=C3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D013C43463
	for <linux-sparse@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B81C23719
	for <linux-sparse@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuBtDTA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIRUlz (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 18 Sep 2020 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIRUly (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Sep 2020 16:41:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5CEC0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 13:41:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i1so7392830edv.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sqN2Hq30MWQ50QUAVj2F94jSOHGxmAovjMqpfDqNAgk=;
        b=LuBtDTA6LM22Y3Al8BaYZbf7F0nEv5382qw+z8w362vTIikDhPuP2b5EFbr5FfHchY
         vU0Msf+aGMxa+0gbWHqyQLz5eLWVo/wl1ffuWtpnjYW+C/kKwEPNxCH0r5tArv3S8mta
         QnXkpY2sh/5BFZYpQM+lJueOj8EVMyZOB2ym1xp83lAA2DSzlsbSPo6NdRM5Cl2fiM/I
         7nu9476eWio9t4GoWtzgbJPgvTZnAdPBHxwqNT55pIlNGAWIGRZ+L/MN6p3i90A1FU+J
         bezIqicDuha050HDnoeh5+CZNol/TJ9dOPRiCcv0ZLAX8Dl1IiuFPQHoJvLwO7hW4H/w
         AWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sqN2Hq30MWQ50QUAVj2F94jSOHGxmAovjMqpfDqNAgk=;
        b=QwHIgpu05+eKX40uTTkJ6q5+ZnXF993ZXTXKuIcvbyeCh00h0Z4aOuSvYH7nkaSJ2p
         YXsPoBIkB+IYv4Rd7ih8TADxCmVHMvQZUNFJkCl1s3Zf47BvjEdibh23bXlYrxx/ls4j
         BtF071E/f9pfkd2ogB0a8LdFMiwLqOdCzASCCl3REtbxemZaIrK9NKuCs9MwnqZaCQAW
         lvyDUM1DK5jxfDTXuSF3qjFIXZsxNSS9Y4KUhYXpqSx25AMM11epn8fFT8eo3wLww0h8
         4XHTF6O9RB81flICaGshWieesi5ykcCh7LIVSrcPWIW3/WHFMBqHBggt7VHeRbhak1LM
         f5Gg==
X-Gm-Message-State: AOAM533kpi3zwwG0zqem+nS7H35NGvq3wzQUdTHlC30vt3P30uRJG52d
        y/KEyZs5jU1uOb7aB79cTqzkKT49eoo=
X-Google-Smtp-Source: ABdhPJysccKvMJbDDLO5RqrxfgxHcEbRSQo3P3ol2JkqZ0izjhRkvilK41aPAJKy4jQxVkvUD7Olig==
X-Received: by 2002:a50:88c6:: with SMTP id d64mr16144173edd.141.1600461712869;
        Fri, 18 Sep 2020 13:41:52 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a042:11c2:1f02:36ab])
        by smtp.gmail.com with ESMTPSA id dc22sm3122976ejb.112.2020.09.18.13.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:41:52 -0700 (PDT)
Date:   Fri, 18 Sep 2020 22:41:49 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: Making structs with variable-sized arrays unsized?
Message-ID: <20200918204149.eqpl352wygwem34a@ltop.local>
References: <CAHk-=wgJZ05ap8VQdzWDWJVWVtZiOYTc6cnNB8gNeQzEnfm-tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgJZ05ap8VQdzWDWJVWVtZiOYTc6cnNB8gNeQzEnfm-tw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Sep 18, 2020 at 12:33:56PM -0700, Linus Torvalds wrote:
> Luc,
>  we've been making kernel structures use flexible arrays as a
> cleanliness thing, but it turns out that it doesn't find bugs that it
> _should_ find.
> 
> We have that nice "struct_size()" macro to determine the size of the
> flexible structure given the number of elements, which uses "offsetof
> + n*members". But sadly standard C still allows the (nonsensical)
> 'sizeof()' to be used - and I merged another fix for that just today.
> 
> Ok, so that's a C standard problem, but it's something that sparse
> *could* warn about.

Yes, sure.
I think that sparse treats flexible arrays exactly as if zero-sized,
without the notion of 'incomplete type' and without check that it is
the last member, so without any warnings.
This, I think, explains the results in your tests here under.

I'll look to add some warnings for array declaration and sizeof()
(explicit or implicit).

> Comments? Appended is a kind of test-case for odd situations that
> sparse happily and silently generates nonsensical code for (just
> tested with test-linearize).

Thanks, these tests make a lot of sense.
It should be noted, though, that test-linearize gives exactly the
same result as GCC & clang (sparse IR 100% matches x86 & ARM64 here).

I also have 2 questions here under.

>     struct bad {
>         unsigned long long a;
>         char b[];
>     };
... 
>     // The layout is odd
>     // The code does "info->align_size = 0" for unsized arrays, but it
> still works?
>     int odd(struct bad *a)
>     {
>         return __alignof__(*a);
>     }

This returns 8. What's odd here?
The 0 align_size is only for the member 'b' and shouldn't have any
effect on the alignment of the whole struct. What am I missing?

>     // Arrays of flexible-array structures are pretty nonsensical
>     // Plus we don't even optimize the constant return. Sad.
>     int not_nice(struct bad p[2])
>     {
>         return (void *)(p+1) - (void *)p;
>     }

I don't understand what you mean by 'optimize the constant return'.
test-linearize returns the only possible sensical answer (if the size
of the structure is accepted to be 8):
	not_nice:
	.L2:
		<entry-point>
		ret.32      $8

What could be optimized here?

-- Luc
